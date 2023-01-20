Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E653AC05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 14:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjATO3c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjATO3a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 09:29:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A749431
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 06:29:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49338CE28A2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 14:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD60C433D2;
        Fri, 20 Jan 2023 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674224933;
        bh=OHa55FA+V96LUeRkfvA1d2d7Lg7WlahFkXKiyyQE6+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMOILfamX4L5Z+YLcXrcRxQrsDniIPTT/gW0pEXs0VzZqFiDNOM9fMB2TGn+2wyec
         hT5mNf7EDANLFp8Za2YnzICmyG37vpX59QSNCWMFaIjeyFgVYSTcTfyZu/xTBZmY+9
         iRSX4n7zRakQdyqpYGtGSxPJ1GjvNprsDz4afvtDzxWsTJH5iNdP6VPGcIk050n5wM
         vhcr9Svy8/F0ymI+bcY/lEIUvSsXxDBmOVwiQjJOFYPkmGrT1HyJiNERVkhL8tT4Pr
         mGokAqktxYo+/QGYXAVsONrEXxwYO1g83eGs5BL2wvBoc3oVDA2k2UgHacYuxErQbR
         0j2ITICf5PX0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FCC0405BE; Fri, 20 Jan 2023 11:28:50 -0300 (-03)
Date:   Fri, 20 Jan 2023 11:28:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, irogers@google.com, ak@linux.intel.com,
        namhyung@kernel.org, james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.ibm.com
Subject: Re: [PATCH] tools/perf: Disable perf probe when libtraceevent is
 missing
Message-ID: <Y8qlIuDCpkj523xE@kernel.org>
References: <20230120120256.34694-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120120256.34694-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jan 20, 2023 at 05:32:56PM +0530, Athira Rajeev escreveu:
> While parsing the tracepoint events in parse_events_add_tracepoint()
> function, code checks for HAVE_LIBTRACEEVENT support. This is needed
> since libtraceevent is necessary for tracepoint. But while adding
> probe points, check for LIBTRACEEVENT is not done in case of perf probe.
> Hence, in environment with missing libtraceevent-devel, it is
> observed that adding a probe point works even though its not
> supported.
 
> Example:
> Adding probe point:
> 	./perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
> 	Added new event:
> 	  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)
 
> 	You can now use it in all perf tools, such as:
 
> 		perf record -e probe:vfs_getname -aR sleep 1
 
> But trying perf record:
> 	./perf  record -e probe:vfs_getname -aR sleep 1
> 	event syntax error: 'probe:vfs_getname'
> 				\___ unsupported tracepoint
> 	libtraceevent is necessary for tracepoint support
> 	Run 'perf list' for a list of valid events
> 
> Fix this by wrapping "builtin-probe" compilation and
> "perf probe" usage under "CONFIG_LIBTRACEEVENT" check.

Humm, but 'perf probe' continues to work, as uou demoed above, the
problem is with the suggestion to use other perf tools that need to
parse tracefs and without libtraceevent, currently can't do it:

[root@quaco ~]# perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

[root@quaco ~]# perf probe -l
  probe:vfs_getname    (on getname_flags:72@fs/namei.c with pathname)
[root@quaco ~]# perf trace -e probe:vfs_getname
perf: 'trace' is not a perf-command. See 'perf --help'.
[root@quaco ~]# cd /sys/kernel/tracing/events/probe/vfs_getname/
[root@quaco vfs_getname]# ls
enable  filter  format  hist  id  trigger
[root@quaco vfs_getname]# ls -la
total 0
drwxr-x---. 2 root root 0 Jan 20 11:18 .
drwxr-x---. 3 root root 0 Jan 20 11:18 ..
-rw-r-----. 1 root root 0 Jan 20 11:18 enable
-rw-r-----. 1 root root 0 Jan 20 11:18 filter
-r--r-----. 1 root root 0 Jan 20 11:18 format
-r--r-----. 1 root root 0 Jan 20 11:18 hist
-r--r-----. 1 root root 0 Jan 20 11:18 id
-rw-r-----. 1 root root 0 Jan 20 11:18 trigger
[root@quaco vfs_getname]#

But we can go on from there:

[root@quaco tracing]# pwd
/sys/kernel/tracing
[root@quaco tracing]# echo 1 > /sys/kernel/tracing/events/probe/vfs_getname/enable
[root@quaco tracing]# echo 1 > tracing_on
[root@quaco tracing]# head trace_pipe
    systemd-oomd-979     [003] ..... 96369.978971: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname="/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service"
    systemd-oomd-979     [003] ..... 96369.979022: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname="/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memory.current"
    systemd-oomd-979     [003] ..... 96369.979084: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname=""
    systemd-oomd-979     [003] ..... 96369.979162: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname="/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memory.min"
    systemd-oomd-979     [003] ..... 96369.979197: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname=""
    systemd-oomd-979     [003] ..... 96369.979267: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname="/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memory.low"
    systemd-oomd-979     [003] ..... 96369.979303: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname=""
    systemd-oomd-979     [003] ..... 96369.979372: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname="/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memory.swap.current"
    systemd-oomd-979     [003] ..... 96369.979406: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname=""
    systemd-oomd-979     [003] ..... 96369.979475: vfs_getname: (getname_flags.part.0+0x6b/0x1c0) pathname="/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memory.stat"
[root@quaco tracing]#

So you could instead replace the suggestion from:

"
       You can now use it in all perf tools, such as:

               perf record -e probe:vfs_getname -aR sleep 1
"

To:

"
	perf is not linked with libtraceevent, to use the new probe you
	can use tracefs:

		cd /sys/kernel/tracing/
		echo 1 > events/probe/vfs_getname/enable
		echo 1 > tracing_on
		cat trace_pipe
"

wdyt?

- Arnaldo
 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/Build  | 4 +++-
>  tools/perf/perf.c | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 6dd67e502295..a138a2304929 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -33,7 +33,9 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    perf-$(CONFIG_TRACE) += trace/beauty/
>  endif
>  
> -perf-$(CONFIG_LIBELF) += builtin-probe.o
> +ifeq ($(CONFIG_LIBTRACEEVENT),y)
> +  perf-$(CONFIG_LIBELF) += builtin-probe.o
> +endif
>  
>  perf-y += bench/
>  perf-y += tests/
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 82bbe0ca858b..7b0d79284d5a 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -80,9 +80,11 @@ static struct cmd_struct commands[] = {
>  #ifdef HAVE_LIBTRACEEVENT
>  	{ "sched",	cmd_sched,	0 },
>  #endif
> +#ifdef HAVE_LIBTRACEEVENT
>  #ifdef HAVE_LIBELF_SUPPORT
>  	{ "probe",	cmd_probe,	0 },
>  #endif
> +#endif
>  #ifdef HAVE_LIBTRACEEVENT
>  	{ "kmem",	cmd_kmem,	0 },
>  	{ "lock",	cmd_lock,	0 },
> -- 
> 2.39.0

-- 

- Arnaldo
