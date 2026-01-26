# Declutter Navigation Script
# Removes 'Home' link, reduces spacing, and streamlines the menu items.

$files = Get-ChildItem -Path . -Filter *.html -File

foreach ($file in $files) {
    Write-Host "Processing $($file.Name)..."
    $content = Get-Content $file.FullName -Raw

    # 1. Update Desktop Navigation
    # Replace the entire nav link block with a streamlined version
    # Target: The <div class="hidden md:flex items-center space-x-..."> block
    
    $desktopNavRegex = '(?s)<div class="hidden md:flex items-center space-x-(12|8)">.*?</div>'
    
    # Define the new streamlined navigation items
    $newNavItems = @'
                    <div class="hidden md:flex items-center space-x-8">
                        <a href="index.html#tours" class="text-sm uppercase tracking-widest hover:text-zim-gold transition-colors hover-trigger">Tours</a>
                        <a href="provinces.html" class="text-sm uppercase tracking-widest hover:text-zim-gold transition-colors hover-trigger">Destinations</a>
                        <a href="foundation.html" class="text-sm uppercase tracking-widest hover:text-zim-gold transition-colors hover-trigger">Foundation</a>
                        <a href="journal.html" class="text-sm uppercase tracking-widest hover:text-zim-gold transition-colors hover-trigger">Journal</a>
                        <a href="contact.html" class="text-sm uppercase tracking-widest hover:text-zim-gold transition-colors hover-trigger">Contact</a>
                    </div>
'@

    if ($content -match $desktopNavRegex) {
        $content = $content -replace $desktopNavRegex, $newNavItems
    }

    # 2. Update Mobile Navigation
    # Standardize mobile menu as well
    $mobileMenuRegex = '(?s)<div id="mobile-menu" class="md:hidden hidden border-t border-white/10 pb-4">.*?</div>'
    $newMobileItems = @'
            <div id="mobile-menu" class="md:hidden hidden border-t border-white/10 pb-4">
                <div class="pt-4 space-y-3">
                    <a href="index.html#tours" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Tours</a>
                    <a href="provinces.html" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Destinations</a>
                    <a href="foundation.html" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Foundation</a>
                    <a href="journal.html" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Journal</a>
                    <a href="contact.html" class="block text-sm uppercase tracking-widest text-gray-300 hover:text-zim-gold transition-colors hover-trigger">Contact</a>
                </div>
            </div>
'@

    if ($content -match $mobileMenuRegex) {
        $content = $content -replace $mobileMenuRegex, $newMobileItems
    }

    # Save changes
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
}

Write-Host "Header decluttering complete for all pages!" -ForegroundColor Green
