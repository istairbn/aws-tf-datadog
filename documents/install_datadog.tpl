{
    "schemaVersion":"2.2",
    "description":"Installs Datadog.",
    "parameters":{
        "datadogAPIKey":{
            "type":"String",
            "description":"(Required) The API key for your Datadog Instance. Contact Support if you don't have one!"
        }
    },
    "mainSteps":[
        { 
            "action":"aws:runShellScript",
            "name":"install_datadog_linux",
            "precondition":{
                "StringEquals":[
                    "platformType",
                    "Linux"
                ]
            },
            "inputs":{
                "runCommand": [
                    "sudo curl -o ddagent.sh https://raw.githubusercontent.com/istairbn/dd-agent/patch-1/packaging/datadog-agent/source/install_agent.sh",
                    "sudo bash ./ddagent.sh {{ datadogAPIKey }}"
                ],
                "workingDirectory":"/tmp",
                "timeoutSeconds":"3600"
            }
        },
        { 
            "action":"aws:runPowerShellScript",
            "name":"install_datadog_windows",
            "precondition":{
                "StringEquals":[
                    "platformType",
                    "Windows"
                ]
            },
            "inputs":{
                "runCommand": [
                    "Invoke-WebRequest -Uri https://raw.githubusercontent.com/istairbn/dd-agent/patch-2/packaging/windows/datadog-installer.ps1 -OutFile C:/Windows/Temp/Datadog-Installer.ps1 -UseBasicParsing",
                    ". C:/Windows/Temp/Datadog-Installer.ps1 -APIKey {{ datadogAPIKey}}"
                ],
                "workingDirectory":"C:/Windows/Temp",
                "timeoutSeconds":"3600"
            }
        }
    ]
}
