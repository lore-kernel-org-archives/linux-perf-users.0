From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 6/6] perf util: use correct IP mapping to find srcline
 for hist entry
Date: Tue, 31 Oct 2017 08:35:23 +0900
Message-ID: <20171030233523.GA4597@sejong>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <3026429.kO1GvhRXjL@agathebauer>
 <20171020051533.GA2746@sejong>
 <8383335.eDmCaHkkAL@agathebauer>
 <20171025014600.GA12785@sejong>
 <20171030200347.GS7045@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:52525 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbdJ3XfZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Oct 2017 19:35:25 -0400
Content-Disposition: inline
In-Reply-To: <20171030200347.GS7045@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com

Hi Arnaldo,

On Mon, Oct 30, 2017 at 05:03:47PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 25, 2017 at 10:46:00AM +0900, Namhyung Kim escreveu:
> > Hi Milian,
> > 
> > On Tue, Oct 24, 2017 at 10:51:43AM +0200, Milian Wolff wrote:
> > > On Freitag, 20. Oktober 2017 07:15:33 CEST Namhyung Kim wrote:
> > > > I looked into it and found a bug handling cumulative (children)
> > > > entries.  For chilren entries that has no self period, the al->addr
> > > > (so he->ip) ends up having an doubly-mapped address.
> > > > 
> > > > It seems to be there from the beginning but only affects entries that
> > > > have no srclines - finding srcline itself is done using a different
> > > > address but it will show the invalid address if no srcline was found.
> > > > I think we should fix the commit c7405d85d7a3 ("perf tools: Update
> > > > cpumode for each cumulative entry").
> > > > 
> > > > Could you please test the following patch works for you?
> > > 
> > > Sorry for the delay, nearly forgot about this mail. The patch below does help 
> > > in my situation, thanks! Can you commit it please?
> > 
> > Sure, I'll add your Tested-by then.
> 
> Namhyung, I couldn't find a submission from you for this one, so I
> tentatively added this to my perf/core branch, please let me know if you
> want to reword this somehow.

I already sent it:

  https://lkml.org/lkml/2017/10/24/1130

But I'm also ok with yours (with small changes below).


> 
> commit 0485954310bf3490cb73936164ca03a0c5916773
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Fri Oct 20 14:15:33 2017 +0900
> 
>     perf callchain: Fix double mapping al->addr for children without self period
>     
>     Milian Wolff found a problem he described in [1] and that for him would

Where's the link for [1]?

>     get fixed:
>     
>     "Note how most of the large offset values are now gone. Most notably, we
>     get proper srcline resolution for the random.h and complex headers."
>     
>     Then Namhyung found the root cause:
>     
>     "I looked into it and found a bug handling cumulative (children)
>     entries.  For children entries that has no self period, the al->addr (so

s/has/have/

Thanks,
Namhyung


>     he->ip) ends up having an doubly-mapped address.
>     
>     It seems to be there from the beginning but only affects entries that
>     have no srclines - finding srcline itself is done using a different
>     address but it will show the invalid address if no srcline was found.  I
>     think we should fix the commit c7405d85d7a3 ("perf tools: Update cpumode
>     for each cumulative entry")."
>     
>     Reported-by: Milian Wolff <milian.wolff@kdab.com>
>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>     Tested-by: Milian Wolff <milian.wolff@kdab.com>
>     Cc: Jin Yao <yao.jin@linux.intel.com>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: kernel-team@lge.com
>     Fixes: c7405d85d7a3 ("perf tools: Update cpumode for each cumulative entry")
>     Link: http://lkml.kernel.org/r/20171020051533.GA2746@sejong
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 3a3916934a92..837012147c7b 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1091,10 +1091,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
>  	al->map = node->map;
>  	al->sym = node->sym;
>  	al->srcline = node->srcline;
> -	if (node->map)
> -		al->addr = node->map->map_ip(node->map, node->ip);
> -	else
> -		al->addr = node->ip;
> +	al->addr = node->ip;
>  
>  	if (al->sym == NULL) {
>  		if (hide_unresolved)
