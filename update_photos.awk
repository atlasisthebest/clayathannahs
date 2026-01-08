BEGIN { in_section = 0; found_desc = 0; }

# For index.html - Studio Membership section
/Studio Membership<\/h2>/ {
    print
    getline  # Get next line (description paragraph)
    # Modify margin from 3rem to 2rem
    gsub(/margin: 0 auto 3rem/, "margin: 0 auto 2rem")
    print
    # Add photo boxes
    print "            <div style=\"display: flex; gap: 1.5rem; justify-content: center; flex-wrap: wrap; margin-bottom: 3rem;\">"
    print "                <div style=\"background: #e8e8e8; border-radius: 4px; padding: 6rem 4rem; flex: 1; max-width: 500px; min-width: 300px; display: flex; align-items: center; justify-content: center; color: #999; font-size: 1.1rem; text-align: center;\">"
    print "                    Photo Coming Soon"
    print "                </div>"
    print "                <div style=\"background: #e8e8e8; border-radius: 4px; padding: 6rem 4rem; flex: 1; max-width: 500px; min-width: 300px; display: flex; align-items: center; justify-content: center; color: #999; font-size: 1.1rem; text-align: center;\">"
    print "                    Photo Coming Soon"
    print "                </div>"
    print "            </div>"
    next
}

# Skip the flex wrapper opening line
/^        <div style="display: flex; gap: 2rem; max-width: 1200px; margin: 0 auto; align-items: start; flex-wrap: wrap;">/ { next }

# Modify section opening to remove flex styles
/^        <section class="section" style="flex: 1; min-width: 300px;">/ {
    print "        <section class=\"section\">"
    next
}

# Skip vertical photo box sidebar (8 lines)
/^            <div style="display: flex; flex-direction: column; gap: 1.5rem; width: 300px;">/ {
    # Skip this line and the next 7 lines
    for (i = 0; i < 7; i++) getline
    next
}

# Skip the flex wrapper closing div (right before Classes & Workshops section)
/^        <\/div>$/ {
    # Check if next line is a section
    next_line = ""
    if (getline next_line > 0) {
        if (next_line ~ /<section class="section">/) {
            # This is the flex wrapper closing, skip it and print the section
            print next_line
            next
        } else {
            # Not the wrapper closing, print both lines
            print
            print next_line
            next
        }
    }
}

# Print all other lines
{ print }
