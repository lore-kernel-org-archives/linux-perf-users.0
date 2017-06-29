From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf and containers
Date: Thu, 29 Jun 2017 13:33:37 -0700
Message-ID: <CAE40pdcP42zaBP_nZa1rdG7D6gDA-X2+Y6FbMfkzfkgFTnz3qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36354 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdF2UeJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jun 2017 16:34:09 -0400
Received: by mail-wr0-f173.google.com with SMTP id c11so195085855wrc.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jun 2017 13:34:08 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day perf-users,

I've been using perf with containers a lot, running perf from the host
system-wide or with --cgroup for one container, and I'm wondering
about symbol translation and namespaces. When running "perf script" or
"perf report" from the host:

- kernel symbols: works fine

- JIT symbols: doesn't work as /tmp/perf-PID.map is in the container,
not the host, and has a different PID. I currently have shell scripts
to copy and rename map files, but... Would it be possible for perf to
try opening /tmp/perf-PID.map, and if that fails, check if the PID
still exists in /proc, read its NSpid from /proc/PID/status, and if
that's different (meaning it's in a container), then read
/proc/PID/root/tmp/perf-NSpid.map instead?

- binary symbols: /usr/bin/node,
/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java, /lib/..., etc, may not
be in the host, so symbol translation fails. Could perf have a similar
approach where it tries from /proc/PID/root/... instead, if the PID is
in a container?

Or, are there other workarounds I don't know about for these? :) perf
could have a --setns flag to set the mount namespace before it
attempts symbol translation, which may also work for when I'm
analyzing one container only from the host, and could run "perf script
--setns=..." for that one container.

Using perf from within the container is totally different, and not
always possible (perf_event_open() can be disabled, and, some
containers are completely locked down, such that it's hard to run any
command that isn't the application)...

Brendan
