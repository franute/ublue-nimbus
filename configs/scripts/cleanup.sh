# Remove unnecessary packages
rpm-ostree cleanup -m

# Remove temporary files and caches
rm -rf /var/cache/dnf /var/lib/dnf /tmp/* /var/tmp/*
