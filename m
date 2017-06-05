From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf report: ensure the perf DSO mapping matches
 what libdw sees
Date: Mon, 5 Jun 2017 12:41:30 +0200
Message-ID: <20170605104130.GB28871@krava>
References: <20170602143753.16907-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdFEKld (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2017 06:41:33 -0400
Content-Disposition: inline
In-Reply-To: <20170602143753.16907-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jan Kratochvil <jkratoch@redhat.com>

On Fri, Jun 02, 2017 at 04:37:52PM +0200, Milian Wolff wrote:
> In some situations the libdw unwinder stopped working properly.
> I.e. with libunwind we see:
> 
> ~~~~~
> heaptrack_gui  2228 135073.400112:     641314 cycles:
> 	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
> 	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
> 	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
> 	           608f3 _GLOBAL__sub_I_kdynamicjobtracker.cpp (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
> 	            f199 call_init.part.0 (/usr/lib/ld-2.25.so)
> 	            f2a5 _dl_init (/usr/lib/ld-2.25.so)
> 	             db9 _dl_start_user (/usr/lib/ld-2.25.so)
> ~~~~~
> 
> But with libdw and without this patch this sample is not properly
> unwound:
> 
> ~~~~~
> heaptrack_gui  2228 135073.400112:     641314 cycles:
> 	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
> 	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
> 	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
> ~~~~~
> 
> Debug output showed me that libdw found a module for the last frame
> address, but it thinks it belongs to /usr/lib/ld-2.25.so. This patch
> double-checks what libdw sees and what perf knows. If the mappings
> mismatch, we now report the elf known to perf. This fixes the
> situation above, and the libdw unwinder produces the same stack as
> libunwind.

hum, sounds like libdw bug right? CC-ing Jan... any idea?

anyway, I think we can keep that as sanity check

thanks,
jirka

> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/unwind-libdw.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index b4c20124d2ee..da45c4be5fb3 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -39,6 +39,14 @@ static int __report_module(struct addr_location *al, u64 ip,
>  		return 0;
>  
>  	mod = dwfl_addrmodule(ui->dwfl, ip);
> +	if (mod) {
> +		Dwarf_Addr s;
> +
> +		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
> +		if (s != al->map->start)
> +			mod = 0;
> +	}
> +
>  	if (!mod)
>  		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
>  				      dso->long_name, -1, al->map->start,
> -- 
> 2.13.0
> 
