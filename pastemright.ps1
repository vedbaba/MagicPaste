Add-Type -AssemblyName System.Windows.Forms
 
# Define the file path
$filePath = "copy.txt"  # Ensure this path is correct and the file is accessible
 
# Read text from the file
$textToType = Get-Content -Path $filePath -Raw

if($textToType.Length -gt 0)
{

}
else {
    $textToType = Get-Clipboard
}

Function Get-CursorClick
{
    $click = [System.Windows.Forms.UserControl]::MouseButtons
    
    return $click
}

function Send-SpecialKey {
    param (
        [string]$key
    )

    # Handle each special character
    switch ($key) {
        '+' { [System.Windows.Forms.SendKeys]::SendWait('{+}') } # Plus sign
        '^' { [System.Windows.Forms.SendKeys]::SendWait('{^}') } # Caret (^) symbol
        '%' { [System.Windows.Forms.SendKeys]::SendWait('{%}') } # Percent symbol
        '~' { [System.Windows.Forms.SendKeys]::SendWait('{~}') } # Tilde (~) symbol
        '(' { [System.Windows.Forms.SendKeys]::SendWait('{(}') } # Left parenthesis
        ')' { [System.Windows.Forms.SendKeys]::SendWait('{)}') } # Right parenthesis
        '[' { [System.Windows.Forms.SendKeys]::SendWait('{[}') } # Left bracket
        ']' { [System.Windows.Forms.SendKeys]::SendWait('{]}') } # Right bracket
        '{' { [System.Windows.Forms.SendKeys]::SendWait('{{}') } # Left brace
        '}' { [System.Windows.Forms.SendKeys]::SendWait('}}') } # Right brace
        '.' { [System.Windows.Forms.SendKeys]::SendWait('{.}') } # Period
        '*' { [System.Windows.Forms.SendKeys]::SendWait('{*}') } # Asterisk
        '?' { [System.Windows.Forms.SendKeys]::SendWait('{?}') } # Question mark
        '|' { [System.Windows.Forms.SendKeys]::SendWait('{|}') } # Pipe
        '\' { [System.Windows.Forms.SendKeys]::SendWait('\\') } # Backslash
        '$' { [System.Windows.Forms.SendKeys]::SendWait('{$}') } # Dollar sign
        '@' { [System.Windows.Forms.SendKeys]::SendWait('{@}') } # At symbol
        '#' { [System.Windows.Forms.SendKeys]::SendWait('{#}') } # Hash
        '!' { [System.Windows.Forms.SendKeys]::SendWait('{!}') } # Exclamation mark
        '&' { [System.Windows.Forms.SendKeys]::SendWait('{&}') } # Ampersand
        ';' { [System.Windows.Forms.SendKeys]::SendWait('{;}') } # Semicolon
        ':' { [System.Windows.Forms.SendKeys]::SendWait('{:}') } # Colon
        "'" { [System.Windows.Forms.SendKeys]::SendWait("'") } # Single quote
        '"' { [System.Windows.Forms.SendKeys]::SendWait('"') } # Double quote
        ',' { [System.Windows.Forms.SendKeys]::SendWait('{,}') } # Comma
        '/' { [System.Windows.Forms.SendKeys]::SendWait('{/}') } # Slash
        '<' { [System.Windows.Forms.SendKeys]::SendWait('{<}') } # Less than
        '>' { [System.Windows.Forms.SendKeys]::SendWait('{>}') } # Greater than
        '=' { [System.Windows.Forms.SendKeys]::SendWait('{=}') } # Equals
        '_' { [System.Windows.Forms.SendKeys]::SendWait('{_}') } # Underscore
        '-' { [System.Windows.Forms.SendKeys]::SendWait('{-}') } # Hyphen
        '}}' { [System.Windows.Forms.SendKeys]::SendWait('}}}}') } # }}
        '{{' { [System.Windows.Forms.SendKeys]::SendWait('{{{{') } # }}
        default { [System.Windows.Forms.SendKeys]::SendWait($key) } # Default handling for other keys
    }
}



# Function to send keystrokes
function Send-Keys {
    param (
        [string]$textToType
    )
    
    $lines = $textToType -split "`n"

    foreach ($line in $lines) {
        # Escape special characters in the line
        foreach ($c in $line.ToCharArray()) {
            Send-SpecialKey -key $c
        }
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    }
}
$count=0
while($true)
{
    $event = Get-CursorClick
    if($event -ne "None")
    {
        if ($event -eq "Left" ) {
            if ( $count -eq 4)
            {
                $count = 0
                Send-Keys $textToType 
                break
            }
            $count ++
        }
    }
    Start-Sleep -Milliseconds 100
}







