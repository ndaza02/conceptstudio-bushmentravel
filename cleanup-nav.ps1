# Cleanup Navigation Duplicates
$files = Get-ChildItem -Path . -Filter *.html -File

$dupPattern = '                    <a href="foundation.html" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Foundation</a>\r?\n                        <a href="foundation.html" class="text-sm uppercase tracking-widest hover:text-zim-gold transition-colors hover-trigger">Foundation</a>'

# Correct mobile link (with block class)
$correctMobile = '                    <a href="foundation.html" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Foundation</a>'

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Check for the specific duplication pattern
    if ($content -match $dupPattern) {
        Write-Host "Cleaning up $($file.Name)..."
        $content = $content -replace $dupPattern, $correctMobile
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
    }
}

Write-Host "Cleanup complete!" -ForegroundColor Green
