From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf report: don't crash on invalid maps in `-g srcline`
 mode
Date: Fri, 12 May 2017 21:19:03 +0900
Message-ID: <20170512121903.GA3839@danjae.aot.lge.com>
References: <20170509205046.21473-1-milian.wolff@kdab.com>
 <20170510060423.GB2667@sejong>
 <1866798.U7tsNezOxe@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33900 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdELMTP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2017 08:19:15 -0400
Content-Disposition: inline
In-Reply-To: <1866798.U7tsNezOxe@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Fri, May 12, 2017 at 12:23:06PM +0200, Milian Wolff wrote:
> On Mittwoch, 10. Mai 2017 08:04:23 CEST Namhyung Kim wrote:
> > On Tue, May 09, 2017 at 10:50:46PM +0200, Milian Wolff wrote:
> 
> <snip>
> 
> > > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > > index 9ab68682c6d0..295f0846fd84 100644
> > > --- a/tools/perf/util/callchain.c
> > > +++ b/tools/perf/util/callchain.c
> > > @@ -642,13 +642,22 @@ static enum match_result match_chain_strings(const
> > > char *left,> 
> > >  static enum match_result match_chain_srcline(struct callchain_cursor_node
> > >  *node,>  
> > >  					     struct callchain_list *cnode)
> > >  
> > >  {
> > > 
> > > -	char *left = get_srcline(cnode->ms.map->dso,
> > > -				 map__rip_2objdump(cnode->ms.map, cnode->ip),
> > > -				 cnode->ms.sym, true, false);
> > > -	char *right = get_srcline(node->map->dso,
> > > -				  map__rip_2objdump(node->map, node->ip),
> > > -				  node->sym, true, false);
> > > -	enum match_result ret = match_chain_strings(left, right);
> > > +	char *left = NULL;
> > > +	char *right = NULL;
> > > +	enum match_result ret = MATCH_ERROR;
> > > +
> > > +	if (!node->map || !cnode->ms.map)
> > > +		return ret;
> > 
> > This makes it fall back to function/address matching below if one of
> > srcline is not available.  But it'll just show many "??:0" entries
> > IMHO.  Maybe we can use same logic in util/sort.c:cmp_null instead..
> 
> Yes, that could be done but I think it's not directly related to the patch/fix 
> at hand. Would it be OK if I change this behavior in a separate patch?

I'm OK with that.

Thanks,
Namhyung
