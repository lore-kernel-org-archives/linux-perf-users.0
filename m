From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf and containers
Date: Fri, 30 Jun 2017 19:13:10 +0200
Message-ID: <4501889.eVrlQgCJXI@agathebauer>
References: <CAE40pdcP42zaBP_nZa1rdG7D6gDA-X2+Y6FbMfkzfkgFTnz3qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:45804 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbdF3RNN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2017 13:13:13 -0400
In-Reply-To: <CAE40pdcP42zaBP_nZa1rdG7D6gDA-X2+Y6FbMfkzfkgFTnz3qA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Donnerstag, 29. Juni 2017 22:33:37 CEST Brendan Gregg wrote:
> G'Day perf-users,
> 
> I've been using perf with containers a lot, running perf from the host
> system-wide or with --cgroup for one container, and I'm wondering
> about symbol translation and namespaces. When running "perf script" or
> "perf report" from the host:
> 
> - kernel symbols: works fine
> 
> - JIT symbols: doesn't work as /tmp/perf-PID.map is in the container,
> not the host, and has a different PID. I currently have shell scripts
> to copy and rename map files, but... Would it be possible for perf to
> try opening /tmp/perf-PID.map, and if that fails, check if the PID
> still exists in /proc, read its NSpid from /proc/PID/status, and if
> that's different (meaning it's in a container), then read
> /proc/PID/root/tmp/perf-NSpid.map instead?
> 
> - binary symbols: /usr/bin/node,
> /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java, /lib/..., etc, may not
> be in the host, so symbol translation fails. Could perf have a similar
> approach where it tries from /proc/PID/root/... instead, if the PID is
> in a container?
> 
> Or, are there other workarounds I don't know about for these? :) perf
> could have a --setns flag to set the mount namespace before it
> attempts symbol translation, which may also work for when I'm
> analyzing one container only from the host, and could run "perf script
> --setns=..." for that one container.
> 
> Using perf from within the container is totally different, and not
> always possible (perf_event_open() can be disabled, and, some
> containers are completely locked down, such that it's hard to run any
> command that isn't the application)...

It's a bit hacky, but in the past I resorted to passing the mount point of the 
container root to perf via `--symfs`. That made it work quite nicely for my 
use case, but I also recorded from within the container - not sure if that 
plays a role here.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
