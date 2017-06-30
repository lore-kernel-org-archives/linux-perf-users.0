From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf and containers
Date: Thu, 29 Jun 2017 23:16:54 -0300
Message-ID: <20170630021654.GE12064@kernel.org>
References: <CAE40pdcP42zaBP_nZa1rdG7D6gDA-X2+Y6FbMfkzfkgFTnz3qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdF3CQ5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jun 2017 22:16:57 -0400
Received: from jouet.infradead.org (unknown [179.97.44.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE65D22B6B
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2017 02:16:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAE40pdcP42zaBP_nZa1rdG7D6gDA-X2+Y6FbMfkzfkgFTnz3qA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Thu, Jun 29, 2017 at 01:33:37PM -0700, Brendan Gregg escreveu:
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

Yeah, I watched your presentation :-)

We need to fix it properly, using the workarounds you describe as a
starting point, patches trying to attack this piecemeal would be more
than welcome, else I'll try to work on this at some point.

- Arnaldo
 
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
> 
> Brendan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
