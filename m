From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf unwind: Use addr_location::addr instead of ip for
 entries
Date: Wed, 17 Aug 2016 00:49:39 +0900
Message-ID: <20160816154939.GA15204@danjae.aot.lge.com>
References: <20160816153926.11288-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32978 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbcHPPvJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Aug 2016 11:51:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so5696468pfe.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Aug 2016 08:51:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160816153926.11288-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Tue, Aug 16, 2016 at 05:39:26PM +0200, Milian Wolff wrote:
> This fixes the srcline translation for call chains of user space
> applications.
> 
> Before we got:
> 
>     perf report --stdio --no-children -s sym,srcline -g address
>      8.92%  [.] main                                 mandelbrot.h:41
>             |
>             |--3.70%--main +8390240
>             |          __libc_start_main +139950056726769
>             |          _start +8388650
>             |
>             |--2.74%--main +8390189
>             |
>              --2.08%--main +8390296
>                        __libc_start_main +139950056726769
>                        _start +8388650
> 
>      7.59%  [.] main                                 complex:1326
>             |
>             |--4.79%--main +8390203
>             |          __libc_start_main +139950056726769
>             |          _start +8388650
>             |
>              --2.80%--main +8390219
> 
>      7.12%  [.] __muldc3                             libgcc2.c:1945
>             |
>             |--3.76%--__muldc3 +139950060519490
>             |          main +8390224
>             |          __libc_start_main +139950056726769
>             |          _start +8388650
>             |
>              --3.32%--__muldc3 +139950060519512
>                        main +8390224
> 
> With this patch applied, we instead get:
> 
>     perf report --stdio --no-children -s sym,srcline -g address
>      8.92%  [.] main                                 mandelbrot.h:41
>             |
>             |--3.70%--main mandelbrot.h:41
>             |          __libc_start_main +241
>             |          _start +4194346
>             |
>             |--2.74%--main mandelbrot.h:41
>             |
>              --2.08%--main mandelbrot.h:41
>                        __libc_start_main +241
>                        _start +4194346
> 
>      7.59%  [.] main                                 complex:1326
>             |
>             |--4.79%--main complex:1326
>             |          __libc_start_main +241
>             |          _start +4194346
>             |
>              --2.80%--main complex:1326
> 
>      7.12%  [.] __muldc3                             libgcc2.c:1945
>             |
>             |--3.76%--__muldc3 libgcc2.c:1945
>             |          main mandelbrot.h:39
>             |          __libc_start_main +241
>             |          _start +4194346
>             |
>              --3.32%--__muldc3 libgcc2.c:1945
>                        main mandelbrot.h:39
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/unwind-libdw.c           | 2 +-
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index cf5e250..783a53f 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -66,7 +66,7 @@ static int entry(u64 ip, struct unwind_info *ui)
>  	if (__report_module(&al, ip, ui))
>  		return -1;
>  
> -	e->ip  = ip;
> +	e->ip  = al.addr;
>  	e->map = al.map;
>  	e->sym = al.sym;
>  
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 97c0f8f..20c2e57 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -542,7 +542,7 @@ static int entry(u64 ip, struct thread *thread,
>  	thread__find_addr_location(thread, PERF_RECORD_MISC_USER,
>  				   MAP__FUNCTION, ip, &al);
>  
> -	e.ip = ip;
> +	e.ip = al.addr;
>  	e.map = al.map;
>  	e.sym = al.sym;
>  
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
