From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Re: Sampling on sched:sched_switch
Date: Tue, 14 Apr 2015 19:00:43 +0530
Message-ID: <CAGAANTV1gQFd0_WZbGTG_+ASZZdDmfAecr_ddchnWGB+dMyVDA@mail.gmail.com>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
	<20150413151148.GI3200@kernel.org>
	<CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
	<20150414121559.GD16027@kernel.org>
	<CAGAANTUAJJmBBSRijursj2VxCg=1kbEP90BRMW2-J0S83tzRug@mail.gmail.com>
	<20150414125921.GJ16027@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34058 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbbDNNao (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Apr 2015 09:30:44 -0400
Received: by oiko83 with SMTP id o83so1655577oik.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2015 06:30:43 -0700 (PDT)
In-Reply-To: <20150414125921.GJ16027@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

> This is incomplete: "multiple events for all CPUS" ok, but for a specific
> thread? Or for all of them?

If i have 2 CPU's, i made it run 2 threads each per CPU. Both threads
have different streams for same tracepoints polling on them. Well, had
to go with this approach since enabling tracepoints on all CPU when
inherit was not working for me :(


> See this, look for the inherit flag, then look for the CPU arg to
> sys_perf_event_open, many tracepoints, a process that creates a process that
> creates a process that makes a networking call that hits net:*skb* tracepoints,
> is something like that that you want?

This is exactly what i want. But things seem to be working in unexpected way.

> [root@zoo ~]# perf stat -vv -e sched:* -e skb:* time time ping -c 1 127.0.0.1
> <SNIP>
> ------------------------------------------------------------
> perf_event_attr:
>   type                             2
>   size                             112
>   config                           10b
>   { sample_period, sample_freq }   1
>   sample_type                      TIME|CPU|PERIOD|RAW
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 9944  cpu -1  group_fd -1  flags 0x8
> ------------------------------------------------------------

I think i should figure out why mmap is failing when inherit=1, seeing
this it doesn't make sense. Will get back to you if i find something.

Thank you Arnaldo.
