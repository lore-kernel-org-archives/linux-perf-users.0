From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: distinguish between inliners in the same
 function
Date: Mon, 15 May 2017 10:21:58 +0900
Message-ID: <20170515012158.GB22151@sejong>
References: <20170503213536.13905-1-milian.wolff@kdab.com>
 <1673560.Uk8cHjlLU8@agathebauer>
 <20170512130129.GB3839@danjae.aot.lge.com>
 <3856259.BJNyvrKptd@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:60144 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbdEOBWB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 May 2017 21:22:01 -0400
Content-Disposition: inline
In-Reply-To: <3856259.BJNyvrKptd@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

Hi Milian,

On Sun, May 14, 2017 at 08:10:50PM +0200, Milian Wolff wrote:
> On Freitag, 12. Mai 2017 15:01:29 CEST Namhyung Kim wrote:
> > On Fri, May 12, 2017 at 12:37:01PM +0200, Milian Wolff wrote:
> > > On Mittwoch, 10. Mai 2017 07:53:52 CEST Namhyung Kim wrote:
> > > > Hi,
> > > 
> > > > On Wed, May 03, 2017 at 11:35:36PM +0200, Milian Wolff wrote:
> > > <snip>
> > > 
> > > > > +static enum match_result match_chain_srcline(struct
> > > > > callchain_cursor_node
> > > > > *node, +					     struct callchain_list *cnode)
> > > > > +{
> > > > > +	char *left = get_srcline(cnode->ms.map->dso,
> > > > > +				 map__rip_2objdump(cnode->ms.map, cnode->ip),
> > > > > +				 cnode->ms.sym, true, false);
> > > > > +	char *right = get_srcline(node->map->dso,
> > > > > +				  map__rip_2objdump(node->map, node->ip),
> > > > > +				  node->sym, true, false);
> > > > > +	enum match_result ret = match_chain_strings(left, right);
> > > > 
> > > > I think we need to check inlined srcline as well.  There might be a
> > > > case that two samples have different addresses (and from different
> > > > callchains) but happens to be mapped to a same srcline IMHO.
> > > 
> > > I think I'm missing something, but isn't this what this function provides?
> > > The function above is now being used by the match_chain_inliner function
> > > below.
> > > 
> > > Ah, or do you mean for code such as this:
> > > 
> > > ~~~~~
> > > inline_func_1(); inline_func_2();
> > > ~~~~~
> > > 
> > > Here, both branches could be inlined into the same line and the same issue
> > > would occur, i.e. different branches get collapsed into the first match
> > > for
> > > the given srcline?
> > > 
> > > Hm yes, this should be fixed too.
> > 
> > OK.
> > 
> > > But, quite frankly, I think it just shows more and more that the current
> > > inliner support is really fragile and leads to lots of issues throughout
> > > the code base as the inlined frames are different from non-inlined
> > > frames, but should most of the same be handled just like them.
> > > 
> > > So, maybe it's time to once more think about going back to my initial
> > > approach: Make inlined frames code-wise equal to non-inlined frames, i.e.
> > > instead of requesting the inlined frames within match_chain, do it outside
> > > and create callchain_node/callchain_cursor instances (not sure which one
> > > right now) for the inlined frames too.
> > > 
> > > This way, we should be able to centrally add support for inlined frames
> > > and
> > > all areas will benefit from it:
> > > 
> > > - aggregation by srcline/function will magically work
> > > - all browsers will automatically display them, i.e. no longer need to
> > > duplicate the code for inliner support in perf script, perf report tui/
> > > stdio/...
> > > - we can easily support --inline in other tools, like `perf trace --call-
> > > graph`
> > > 
> > > So before I invest more time trying to massage match_chain to behave well
> > > for inline nodes, can I get some feedback on the above?
> > 
> > Fair enough.  I agree that it'd be better adding them as separate
> > callchain nodes when resolving callchains.
> 
> Can you, or anyone else more involved with the current callchain code, guide 
> me a bit?
> 
> My previous attempt at doing this can be seen here:
> https://github.com/milianw/linux/commit/
> 71d031c9d679bfb4a4044226e8903dd80ea601b3
> 
> There are some issues with that. Most of it boils down to the question of how 
> to feed an inlined frame into a callchain_cursor_node. The latter contains a 
> symbol* e.g. and users of that class currently rely on using the IP to find 
> e.g. the corresponding srcline.
> 
> From what I can see, we either have to hack inline nodes in there, cf. my 
> original approach in the github repo above. Or, better, we would have to 
> (heavily?) refactor the callchain_cursor_node struct and the code depending on 
> it. What I have in mind would be something like adding two members to this 
> struct:
> 
> const char* funcname;
> const char* srcline;
> 
> For non-inlined frames, the funcname aliases the `symbol->name` value, and the 
> srcline is queried as-needed. For inlined frames the values from the inlined 
> node struct are used. The inlined frames for a given code location would all 
> share the same symbol and ip.
> 
> Would that be OK as a path forward?

I think you'd be better adding (fake) dso and sym to keep the inline
information.  The fake dso can be paired with the original dso and
maintain a tree of (inlined) symbols.  You may need a fake map to
point the fake dso then.  It seems a bit compilcated but that way the
code will be more consistent and easier to handle (e.g. for caching
and/or deletion) IMHO.

Also, for the children mode, callchain nodes should have enough
information to create hist entries (but I'm not sure how to apply
self periods for those inlined entries).

Thanks,
Namhyung
