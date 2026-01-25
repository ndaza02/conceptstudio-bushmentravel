# Update Navigation to include Foundation link
# Targets both desktop and mobile layouts

$files = Get-ChildItem -Path . -Filter *.html -File

$foundationLinkDesktop = '                        <a href="foundation.html" class="text-sm uppercase tracking-widest hover:text-zim-gold transition-colors hover-trigger">Foundation</a>'
$foundationLinkMobile = '                    <a href="foundation.html" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Foundation</a>'

foreach ($file in $files) {
    if ($file.Name -eq "foundation.html") { continue }
    
    $content = Get-Content $file.FullName -Raw
    
    if ($content -like "*foundation.html*") {
        Write-Host "Skipping $($file.Name) - already has foundation link"
        continue
    }

    Write-Host "Updating $($file.Name)..."

    # 1. Desktop Nav Update
    # Try inserting after Destinations (various formats)
    if ($content -match '(<a href="(index\.html#experiences|provinces\.html)"[^>]*>Destinations</a>)') {
        $content = $content -replace '(<a href="(index\.html#experiences|provinces\.html)"[^>]*>Destinations</a>)', "`$1`r`n$foundationLinkDesktop"
    }
    # Otherwise try inserting after Tours
    elseif ($content -match '(<a href="index\.html#tours"[^>]*>Tours</a>)') {
         $content = $content -replace '(<a href="index\.html#tours"[^>]*>Tours</a>)', "`$1`r`n$foundationLinkDesktop"
    }

    # 2. Mobile Nav Update
    if ($content -match '(<a href="(index\.html#experiences|provinces\.html)" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Destinations</a>)') {
         $content = $content -replace '(<a href="(index\.html#experiences|provinces\.html)" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Destinations</a>)', "`$1`r`n$foundationLinkMobile"
    }
    elseif ($content -match '(<a href="index\.html#tours" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Tours</a>)') {
        $content = $content -replace '(<a href="index\.html#tours" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Tours</a>)', "`$1`r`n$foundationLinkMobile"
    }

    # Save changes
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
}

Write-Host "Nav update complete!" -ForegroundColor Green
