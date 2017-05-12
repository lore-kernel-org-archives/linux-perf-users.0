From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: distinguish between inliners in the same
 function
Date: Fri, 12 May 2017 22:01:29 +0900
Message-ID: <20170512130129.GB3839@danjae.aot.lge.com>
References: <20170503213536.13905-1-milian.wolff@kdab.com>
 <20170510055352.GA2667@sejong>
 <1673560.Uk8cHjlLU8@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34151 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756330AbdELNBl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2017 09:01:41 -0400
Content-Disposition: inline
In-Reply-To: <1673560.Uk8cHjlLU8@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Fri, May 12, 2017 at 12:37:01PM +0200, Milian Wolff wrote:
> On Mittwoch, 10. Mai 2017 07:53:52 CEST Namhyung Kim wrote:
> > Hi,
> > 
> > On Wed, May 03, 2017 at 11:35:36PM +0200, Milian Wolff wrote:
> 
> <snip>
> 
> > > +static enum match_result match_chain_srcline(struct callchain_cursor_node
> > > *node, +					     struct callchain_list *cnode)
> > > +{
> > > +	char *left = get_srcline(cnode->ms.map->dso,
> > > +				 map__rip_2objdump(cnode->ms.map, cnode->ip),
> > > +				 cnode->ms.sym, true, false);
> > > +	char *right = get_srcline(node->map->dso,
> > > +				  map__rip_2objdump(node->map, node->ip),
> > > +				  node->sym, true, false);
> > > +	enum match_result ret = match_chain_strings(left, right);
> > 
> > I think we need to check inlined srcline as well.  There might be a
> > case that two samples have different addresses (and from different
> > callchains) but happens to be mapped to a same srcline IMHO.
> 
> I think I'm missing something, but isn't this what this function provides? The 
> function above is now being used by the match_chain_inliner function below. 
> 
> Ah, or do you mean for code such as this:
> 
> ~~~~~
> inline_func_1(); inline_func_2();
> ~~~~~
> 
> Here, both branches could be inlined into the same line and the same issue 
> would occur, i.e. different branches get collapsed into the first match for 
> the given srcline?
> 
> Hm yes, this should be fixed too.

OK.

> 
> But, quite frankly, I think it just shows more and more that the current 
> inliner support is really fragile and leads to lots of issues throughout the 
> code base as the inlined frames are different from non-inlined frames, but 
> should most of the same be handled just like them.
> 
> So, maybe it's time to once more think about going back to my initial 
> approach: Make inlined frames code-wise equal to non-inlined frames, i.e. 
> instead of requesting the inlined frames within match_chain, do it outside and 
> create callchain_node/callchain_cursor instances (not sure which one right 
> now) for the inlined frames too.
> 
> This way, we should be able to centrally add support for inlined frames and 
> all areas will benefit from it:
> 
> - aggregation by srcline/function will magically work
> - all browsers will automatically display them, i.e. no longer need to 
> duplicate the code for inliner support in perf script, perf report tui/
> stdio/...
> - we can easily support --inline in other tools, like `perf trace --call-
> graph`
> 
> So before I invest more time trying to massage match_chain to behave well for 
> inline nodes, can I get some feedback on the above?

Fair enough.  I agree that it'd be better adding them as separate
callchain nodes when resolving callchains.

> 
> Back then when Jin and me discussed this, noone from the core perf 
> contributors ever bothered to give us any insight in what they think is the 
> better approach.

That's unfortunate, sorry about that.

> 
> > > +
> > > 
> > >  	free_srcline(left);
> > >  	free_srcline(right);
> > >  	return ret;
> > >  
> > >  }
> > > 
> > > +static enum match_result match_chain_inliner(struct callchain_cursor_node
> > > *node, +					     struct callchain_list *cnode)
> > > +{
> > > +	u64 left_ip = map__rip_2objdump(cnode->ms.map, cnode->ip);
> > > +	u64 right_ip = map__rip_2objdump(node->map, node->ip);
> > > +	struct inline_node *left_node = NULL;
> > > +	struct inline_node *right_node = NULL;
> > > +	struct inline_list *left_entry = NULL;
> > > +	struct inline_list *right_entry = NULL;
> > > +	struct inline_list *left_last_entry = NULL;
> > > +	struct inline_list *right_last_entry = NULL;
> > > +	enum match_result ret = MATCH_EQ;
> > > +
> > > +	left_node = dso__parse_addr_inlines(cnode->ms.map->dso, left_ip);
> > > +	if (!left_node)
> > > +		return MATCH_ERROR;
> > > +
> > > +	right_node = dso__parse_addr_inlines(node->map->dso, right_ip);
> > > +	if (!right_node) {
> > > +		inline_node__delete(left_node);
> > > +		return MATCH_ERROR;
> > > +	}
> > > +
> > > +	left_entry = list_first_entry(&left_node->val,
> > > +				      struct inline_list, list);
> > > +	left_last_entry = list_last_entry(&left_node->val,
> > > +					  struct inline_list, list);
> > > +	right_entry = list_first_entry(&right_node->val,
> > > +				       struct inline_list, list);
> > > +	right_last_entry = list_last_entry(&right_node->val,
> > > +					  struct inline_list, list);
> > 
> > What about keeping number of entries in a inline_node so that we can
> > check the numbers for faster comparison?
> 
> What benefit would that have? The performance cost is dominated by finding the 
> inlined nodes, not by doing the comparison on the callstack.

Well, I didn't measure the performance cost but your example contains
long symbols and they share some parts.  So I guess it would hurt
performance as they'll be checked frequently.

> 
> > > +	while (ret == MATCH_EQ && (left_entry || right_entry)) {
> > > +		ret = match_chain_strings(left_entry ? left_entry->funcname : 
> NULL,
> > > +					  right_entry ? right_entry->funcname : NULL);
> > > +
> > > +		if (left_entry && left_entry != left_last_entry)
> > > +			left_entry = list_next_entry(left_entry, list);
> > > +		else
> > > +			left_entry = NULL;
> > > +
> > > +		if (right_entry && right_entry != right_last_entry)
> > > +			right_entry = list_next_entry(right_entry, list);
> > > +		else
> > > +			right_entry = NULL;
> > > +	}
> > > +
> > > +	inline_node__delete(left_node);
> > > +	inline_node__delete(right_node);
> > > +	return ret;
> > > +}
> > > +
> > > 
> > >  static enum match_result match_chain(struct callchain_cursor_node *node,
> > >  
> > >  				     struct callchain_list *cnode)
> > >  
> > >  {
> > > 
> > > @@ -671,7 +728,13 @@ static enum match_result match_chain(struct
> > > callchain_cursor_node *node,> 
> > >  	}
> > >  	
> > >  	if (left == right) {
> > > 
> > > -		if (node->branch) {
> > > +		if (symbol_conf.inline_name && cnode->ip != node->ip) {
> > > +			enum match_result match = match_chain_inliner(node,
> > > +								      cnode);
> > > +
> > > +			if (match != MATCH_ERROR)
> > > +				return match;
> > 
> > I guess it'd be better just returning the match result.  Otherwise
> > MATCH_ERROR will be converted to MATCH_EQ..
> 
> This is done on purpose to fall-back to the IP-based comparison. That way, 
> entries without inlined nodes will be sorted the same way as before this 
> patch.

Hmm.. OK, but as I said in another thread, if one node has inlines and
the other don't, they should be separated.

Thanks,
Namhyung
