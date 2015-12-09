From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core 20/22] perf: Fix maps__fixup_overlappings to
 put used maps
Date: Wed, 9 Dec 2015 12:15:32 -0300
Message-ID: <20151209151532.GK15864@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021131.10245.41485.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53650 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbLIPPh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 10:15:37 -0500
Content-Disposition: inline
In-Reply-To: <20151209021131.10245.41485.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Em Wed, Dec 09, 2015 at 11:11:31AM +0900, Masami Hiramatsu escreveu:
> Since the __map_groups__insert got the given map, we don't
> need to keep it. So put the maps.
> 
> Refcnt debugger shows that the map_groups__fixup_overlappings
> got a map twice but the group released it once. This pattern
> usually indicates the leak happens in caller site.

Thanks, applied!

- Arnaldo

>   ----
>   ==== [0] ====
>   Unreclaimed map@0x39d3ae0
>   Refcount +1 => 1 at
>     ./perf(map_groups__fixup_overlappings+0x335) [0x4c1865]
>     ./perf(thread__insert_map+0x30) [0x4c8e00]
>     ./perf(machine__process_mmap2_event+0x106) [0x4bd876]
>     ./perf() [0x4c378e]
>     ./perf() [0x4c4393]
>     ./perf(perf_session__process_events+0x38a) [0x4c654a]
>     ./perf(cmd_record+0xe24) [0x42fc94]
>     ./perf() [0x47b745]
>     ./perf(main+0x617) [0x422547]
>     /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f2eca2deaf5]
>     ./perf() [0x4226bd]
>   Refcount +1 => 2 at
>     ./perf(map_groups__fixup_overlappings+0x3c5) [0x4c18f5]
>     ./perf(thread__insert_map+0x30) [0x4c8e00]
>     ./perf(machine__process_mmap2_event+0x106) [0x4bd876]
>     ./perf() [0x4c378e]
>     ./perf() [0x4c4393]
>     ./perf(perf_session__process_events+0x38a) [0x4c654a]
>     ./perf(cmd_record+0xe24) [0x42fc94]
>     ./perf() [0x47b745]
>     ./perf(main+0x617) [0x422547]
>     /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f2eca2deaf5]
>     ./perf() [0x4226bd]
>   Refcount -1 => 1 at
>     ./perf(map_groups__exit+0x92) [0x4c0962]
>     ./perf(map_groups__put+0x60) [0x4c0bc0]
>     ./perf(thread__put+0x90) [0x4c8a40]
>     ./perf(machine__delete_threads+0x7e) [0x4bad9e]
>     ./perf(perf_session__delete+0x4f) [0x4c499f]
>     ./perf(cmd_record+0xb6d) [0x42f9dd]
>     ./perf() [0x47b745]
>     ./perf(main+0x617) [0x422547]
>     /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f2eca2deaf5]
>     ./perf() [0x4226bd]
>   ----
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> ---
>  tools/perf/util/map.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 03b7297..89be9c5 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -693,6 +693,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
>  			__map_groups__insert(pos->groups, before);
>  			if (verbose >= 2)
>  				map__fprintf(before, fp);
> +			map__put(before);
>  		}
>  
>  		if (map->end < pos->end) {
> @@ -707,6 +708,7 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
>  			__map_groups__insert(pos->groups, after);
>  			if (verbose >= 2)
>  				map__fprintf(after, fp);
> +			map__put(after);
>  		}
>  put_map:
>  		map__put(pos);
