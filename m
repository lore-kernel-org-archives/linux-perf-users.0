Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E6C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Feb 2021 12:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B163764E50
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Feb 2021 12:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBIMlL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Feb 2021 07:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhBIMk5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Feb 2021 07:40:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 298E764E88;
        Tue,  9 Feb 2021 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612874415;
        bh=7aTIqFoEfAOdw1PwcXhIYfI7/U0vD9InuzazfdqFO/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/NUi3Thh3c0+B+SQMpHgjgyMy1PuSD2dJvZi2yHkrCg4DBs2jH7L3FWabt/cB69D
         iY9qP9ti5p37sIyjR4XpKs1gQ1Qt7OdnwsKGsEEC+6GWUnim67jsR1EZHbgRvyVEWP
         shdP0r3Jy6B1BEhq64eY1vduIjizDIdx2RpREuvaucwqo5JbD9fEGKAJckzenbptYq
         AFur2rbrpyvmTUsu9nNHAAKPIZ2MhsYX1v7gCfNaflhz9r21tKGYNtmbkjSKbRFgst
         AO/eDspsnOw408qtCmRfiaoqgIRoXiGY2/3BPoObKHsP3bIZsRVPrJvf+0pnhx81EM
         wossehp2RwWIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB70C40513; Tue,  9 Feb 2021 09:40:09 -0300 (-03)
Date:   Tue, 9 Feb 2021 09:40:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ndesaulniers@google.com, irogers@google.com,
        tmricht@linux.ibm.com, hushiyuan@huawei.com, hewenliang4@huawei.com
Subject: Re: [PATCH] perf report: Fix arm64 gap between kernel start and
 module end
Message-ID: <20210209124009.GA1018564@kernel.org>
References: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
 <20200330131129.GB31702@kernel.org>
 <20200330131810.GC31702@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330131810.GC31702@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Mar 30, 2020 at 10:18:10AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 30, 2020 at 10:11:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Mar 30, 2020 at 03:41:11PM +0800, Kemeng Shi escreveu:
> > > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> > > index 393b9895c..37cbfa5e9 100644
> > > --- a/tools/perf/arch/arm64/util/Build
> > > +++ b/tools/perf/arch/arm64/util/Build
> > > @@ -2,6 +2,7 @@ libperf-y += header.o
> > >  libperf-y += tsc.o
> > >  libperf-y += sym-handling.o
> > >  libperf-y += kvm-stat.o
> > > +libperf-y += machine.o
> > 
> > You made the patch against an old perf codebase, right? This libperf-y
> > above was changed to perf-y here:
> > 
> > commit 5ff328836dfde0cef9f28c8b8791a90a36d7a183
> > Author: Jiri Olsa <jolsa@kernel.org>
> > Date:   Wed Feb 13 13:32:39 2019 +0100
> > 
> >     perf tools: Rename build libperf to perf
> > 
> > ----
> > 
> > I'm fixing this up, please check my perf/core branch later to see that
> > all is working as intended.
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> 
> Here it is:
> 
> 
> From 829b915d7d7eeafbe4af76dce19ccbdc743a43c8 Mon Sep 17 00:00:00 2001
> From: Kemeng Shi <shikemeng@huawei.com>
> Date: Mon, 30 Mar 2020 15:41:11 +0800
> Subject: [PATCH 1/1] perf symbols: Fix arm64 gap between kernel start and
>  module end
> 
> During execution of command 'perf report' in my arm64 virtual machine,
> this error message is showed:
> 
> failed to process sample
> 
> __symbol__inc_addr_samples(860): ENOMEM! sym->name=__this_module,
>     start=0x1477100, addr=0x147dbd8, end=0x80002000, func: 0
> 
> The error is caused with path:
> cmd_report
>  __cmd_report
>   perf_session__process_events
>    __perf_session__process_events
>     ordered_events__flush
>      __ordered_events__flush
>       oe->deliver (ordered_events__deliver_event)
>        perf_session__deliver_event
>         machines__deliver_event
>          perf_evlist__deliver_sample
>           tool->sample (process_sample_event)
>            hist_entry_iter__add
>             iter->add_entry_cb(hist_iter__report_callback)
>              hist_entry__inc_addr_samples
>               symbol__inc_addr_samples
>                __symbol__inc_addr_samples
>                 h = annotated_source__histogram(src, evidx) (NULL)
> 
> annotated_source__histogram failed is caused with path:
> ...
>  hist_entry__inc_addr_samples
>   symbol__inc_addr_samples
>    symbol__hists
>     annotated_source__alloc_histograms
>      src->histograms = calloc(nr_hists, sizeof_sym_hist) (failed)
> 
> Calloc failed as the symbol__size(sym) is too huge. As show in error
> message: start=0x1477100, end=0x80002000, size of symbol is about 2G.
> 
> This is the same problem as 'perf annotate: Fix s390 gap between kernel
> end and module start (b9c0a64901d5bd)'. Perf gets symbol information from
> /proc/kallsyms in __dso__load_kallsyms. A part of symbol in /proc/kallsyms
> from my virtual machine is as follows:
>  #cat /proc/kallsyms | sort
>  ...
>  ffff000001475080 d rpfilter_mt_reg      [ip6t_rpfilter]
>  ffff000001475100 d $d   [ip6t_rpfilter]
>  ffff000001475100 d __this_module        [ip6t_rpfilter]
>  ffff000080080000 t _head
>  ffff000080080000 T _text
>  ffff000080080040 t pe_header
>  ...
> 
> Take line 'ffff000001475100 d __this_module [ip6t_rpfilter]' as example.
> The start and end of symbol are both set to ffff000001475100 in
> dso__load_all_kallsyms. Then symbols__fixup_end will set the end of symbol
> to next big address to ffff000001475100 in /proc/kallsyms, ffff000080080000
> in this example. Then sizeof of symbol will be about 2G and cause the
> problem.
> 
> The start of module in my machine is
>  ffff000000a62000 t $x   [dm_mod]
> 
> The start of kernel in my machine is
>  ffff000080080000 t _head
> 
> There is a big gap between end of module and begin of kernel if a samll
> amount of memory is used by module. And the last symbol in module will
> have a large address range as caotaining the big gap.
> 
> Give that the module and kernel text segment sequence may change in
> the future, fix this by limiting range of last symbol in module and kernel
> to 4K in arch arm64.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Hu Shiyuan <hushiyuan@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: hewenliang4@huawei.com
> Link: http://lore.kernel.org/lkml/33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com
> [ refreshed the patch on current codebase ]
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/arch/arm64/util/Build     |  1 +
>  tools/perf/arch/arm64/util/machine.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/util/machine.c
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 789956f76d85..5c13438c7bd4 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,4 +1,5 @@
>  perf-y += header.o
> +perf-y += machine.o
>  perf-y += perf_regs.o
>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
> new file mode 100644
> index 000000000000..94745131e89a
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/machine.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include "debug.h"
> +#include "symbol.h"
> +
> +/* On arm64, kernel text segment start at high memory address,
> + * for example 0xffff 0000 8xxx xxxx. Modules start at a low memory
> + * address, like 0xffff 0000 00ax xxxx. When only samll amount of
> + * memory is used by modules, gap between end of module's text segment
> + * and start of kernel text segment may be reach 2G.
> + * Therefore do not fill this gap and do not assign it to the kernel dso map.
> + */
> +
> +#define SYMBOL_LIMIT (1 << 12) /* 4K */
> +
> +void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
> +{
> +	if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
> +			(strchr(p->name, '[') == NULL && strchr(c->name, '[')))
> +		/* Limit range of last symbol in module and kernel */
> +		p->end += SYMBOL_LIMIT;
> +	else
> +		p->end = c->start;
> +	pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
> +}

This breaks the build on powerpc 32-bit, I'm fixing it using the proper "%#" PRIx64 " style.

- Arnaldo


  72    13.69 ubuntu:18.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
    arch/powerpc/util/machine.c: In function 'arch__symbols__fixup_end':
    arch/powerpc/util/machine.c:23:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
      pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
                ^
    /git/linux/tools/perf/util/debug.h:18:21: note: in definition of macro 'pr_fmt'
     #define pr_fmt(fmt) fmt
                         ^~~
    /git/linux/tools/perf/util/debug.h:33:29: note: in expansion of macro 'pr_debugN'
     #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                 ^~~~~~~~~
    /git/linux/tools/perf/util/debug.h:33:42: note: in expansion of macro 'pr_fmt'
     #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                              ^~~~~~
    arch/powerpc/util/machine.c:23:2: note: in expansion of macro 'pr_debug4'
      pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
      ^~~~~~~~~
    cc1: all warnings being treated as errors
    /git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/linux/tools/build/Makefile.build:139: recipe for target 'powerpc' failed
    make[4]: *** [powerpc] Error 2
    /git/linux/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  73    30.47 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0

