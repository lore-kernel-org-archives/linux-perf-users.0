Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C95EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596ED6109F
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJ1ABY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ1ABY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0BD0600D3;
        Wed, 27 Oct 2021 23:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635379138;
        bh=46zTAnx5/Bzzo9vxFPOqAbwL6H7XXD9LmeDzjZdGOT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+8pRqS1OuHXv+TcgFhtkzKYjZ7viTb/ILPC6kW7x6VOvxdqlhl0FCvDG2ET+4b8l
         /HccwxLJmP+dwnI6lYzbYxcTc+5z47fBlkNp0WEcSvCvGI5F57TbG+XBstGF8wd/l+
         sGsXCiyymorqi+EbdmmsqoCWv0opyFMDXyQYs5P8Q7t0aEXtVlJZZErNJSWHqdX0cU
         AsKUq+mnEPefjmh3bjziFR3d2UIrTgVaZyZjGsoYV28ZOaWiV7gAg1b3qUFXHHwb5n
         EWqYPuXL3YMBKt/9h1TLXkjfJvtjKgbMCWrJLzkc+lnyQ7s+8A5waNrI4Vh8hwxtIG
         rDQupWK1axiFg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63867410A1; Wed, 27 Oct 2021 20:58:55 -0300 (-03)
Date:   Wed, 27 Oct 2021 20:58:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Lexi Shao <shaolexi@huawei.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        qiuxi1@huawei.com, nixiaoming@huawei.com, wangbing6@huawei.com
Subject: Re: [PATCH] perf script: Show binary offsets for userspace addr
Message-ID: <YXnnv3i3vdBR3z30@kernel.org>
References: <20211019072417.122576-1-shaolexi@huawei.com>
 <YXAYg8N1vikCsOnU@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXAYg8N1vikCsOnU@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 20, 2021 at 03:24:19PM +0200, Jiri Olsa escreveu:
> On Tue, Oct 19, 2021 at 03:24:17PM +0800, Lexi Shao wrote:
> > Show binary offsets for userspace addr with map in perf script output
> > with callchain.
> > 
> > In commit 19610184693c("perf script: Show virtual addresses instead of
> > offsets"), the addr shown in perf script output with callchain is changed
> > from binary offsets to virtual address to fix the incorrectness when
> > displaying symbol offset.
> > 
> > This is inconvenient in scenario that the binary is stripped and
> > symbol cannot be resolved. If someone wants to further resolve symbols for
> > specific binaries later, he would need an extra step to translate virtual
> > address to binary offset with mapping information recorded in perf.data,
> > which can be difficult for people not familiar with perf.
> > 
> > This patch modifies function sample__fprintf_callchain to print binary
> > offset for userspace addr with dsos, and virtual address otherwise. It
> > does not affect symbol offset calculation so symoff remains correct.
> > 
> > Before applying this patch:
> > test  1512    78.711307:     533129 cycles:
> > 	aaaae0da07f4 [unknown] (/tmp/test)
> > 	aaaae0da0704 [unknown] (/tmp/test)
> > 	ffffbe9f7ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)
> > 
> > After this patch:
> > test  1519   111.330127:     406953 cycles:
> > 	7f4 [unknown] (/tmp/test)
> > 	704 [unknown] (/tmp/test)
> > 	20ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)
> > 
> > Fixes: 19610184693c("perf script: Show virtual addresses instead of offsets")
> > 
> > Signed-off-by: Lexi Shao <shaolexi@huawei.com>
> 
> makes sense to me
> 
> Acked-/Tested-by Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> should we have a way to display these callchain detail in perf report output as well?
> 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/evsel_fprintf.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> > index bfedd7b23521..8c2ea8001329 100644
> > --- a/tools/perf/util/evsel_fprintf.c
> > +++ b/tools/perf/util/evsel_fprintf.c
> > @@ -11,6 +11,7 @@
> >  #include "strlist.h"
> >  #include "symbol.h"
> >  #include "srcline.h"
> > +#include "dso.h"
> >  
> >  static int comma_fprintf(FILE *fp, bool *first, const char *fmt, ...)
> >  {
> > @@ -144,12 +145,17 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
> >  			if (print_arrow && !first)
> >  				printed += fprintf(fp, " <-");
> >  
> > -			if (print_ip)
> > -				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> > -
> >  			if (map)
> >  				addr = map->map_ip(map, node->ip);
> >  
> > +			if (print_ip) {
> > +				/* Show binary offset for userspace addr */
> > +				if (map && !map->dso->kernel)
> > +					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
> > +				else
> > +					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> > +			}
> > +
> >  			if (print_sym) {
> >  				printed += fprintf(fp, " ");
> >  				node_al.addr = addr;
> > -- 
> > 2.12.3
> > 

-- 

- Arnaldo
