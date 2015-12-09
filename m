From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core 15/22] perf: Fix map_groups__clone to put
 cloned map
Date: Wed, 9 Dec 2015 11:17:46 -0300
Message-ID: <20151209141746.GF15864@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021120.10245.95388.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50323 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbbLIOZ0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 09:25:26 -0500
Content-Disposition: inline
In-Reply-To: <20151209021120.10245.95388.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Em Wed, Dec 09, 2015 at 11:11:20AM +0900, Masami Hiramatsu escreveu:
> Fix map_groups__clone to put cloned map after
> inserting it to the map_groups.

Thanks, applied!

- Arnaldo
 
> Refcnt debugger shows:
>   ----
>   ==== [0] ====
>   Unreclaimed map: 0x2a27ee0
>   Refcount +1 => 1 at
>     ./perf(map_groups__clone+0x8d) [0x4bb7ed]
>     ./perf(thread__fork+0xbe) [0x4c1f9e]
>     ./perf(machine__process_fork_event+0x216) [0x4b79a6]
>     ./perf(perf_event__synthesize_threads+0x38b) [0x48135b]
>     ./perf(cmd_top+0xdc6) [0x43cb76]
>     ./perf() [0x477223]
>     ./perf(main+0x617) [0x422077]
>     /lib64/libc.so.6(__libc_start_main+0xf0) [0x7ff806af8fe0]
>     ./perf() [0x4221ed]
>   Refcount +1 => 2 at
>     ./perf(map_groups__clone+0x128) [0x4bb888]
>     ./perf(thread__fork+0xbe) [0x4c1f9e]
>     ./perf(machine__process_fork_event+0x216) [0x4b79a6]
>     ./perf(perf_event__synthesize_threads+0x38b) [0x48135b]
>     ./perf(cmd_top+0xdc6) [0x43cb76]
>     ./perf() [0x477223]
>     ./perf(main+0x617) [0x422077]
>     /lib64/libc.so.6(__libc_start_main+0xf0) [0x7ff806af8fe0]
>     ./perf() [0x4221ed]
>   Refcount -1 => 1 at
>     ./perf(map_groups__exit+0x87) [0x4ba757]
>     ./perf(map_groups__put+0x68) [0x4ba9a8]
>     ./perf(thread__put+0x8b) [0x4c1aeb]
>     ./perf(machine__delete_threads+0x81) [0x4b48f1]
>     ./perf(perf_session__delete+0x4f) [0x4be63f]
>     ./perf(cmd_top+0x1094) [0x43ce44]
>     ./perf() [0x477223]
>     ./perf(main+0x617) [0x422077]
>     /lib64/libc.so.6(__libc_start_main+0xf0) [0x7ff806af8fe0]
>     ./perf() [0x4221ed]
>   ----
> 
> This shows map_groups__clone get the map twice
> and put it when map_groups__exit.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> ---
>  tools/perf/util/map.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 7859216..03b7297 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -744,6 +744,7 @@ int map_groups__clone(struct map_groups *mg,
>  		if (new == NULL)
>  			goto out_unlock;
>  		map_groups__insert(mg, new);
> +		map__put(new);
>  	}
>  
>  	err = 0;
