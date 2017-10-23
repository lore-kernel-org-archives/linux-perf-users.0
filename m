From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v7 0/5] generate full callchain cursor entries for
 inlined frames
Date: Mon, 23 Oct 2017 19:43:25 -0300
Message-ID: <20171023224325.GB7045@kernel.org>
References: <20171019113836.5548-1-milian.wolff@kdab.com>
 <3662337.Ysj1km7A8r@agathebauer>
 <20171023190453.GD21936@kernel.org>
 <1707691.qaJ269GSZW@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbdJWWn3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 18:43:29 -0400
Content-Disposition: inline
In-Reply-To: <1707691.qaJ269GSZW@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Em Mon, Oct 23, 2017 at 09:39:57PM +0200, Milian Wolff escreveu:
> On Montag, 23. Oktober 2017 21:04:53 CEST Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 20, 2017 at 10:21:03PM +0200, Milian Wolff escreveu:
> > > On Freitag, 20. Oktober 2017 18:15:40 CEST Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Oct 19, 2017 at 01:38:31PM +0200, Milian Wolff escreveu:
> > > > > This series of patches completely reworks the way inline frames are
> > > > > handled. Instead of querying for the inline nodes on-demand in the
> > > > > individual tools, we now create proper callchain nodes for inlined
> > > > > frames. The advantages this approach brings are numerous:
> > > > > 
> > > > > - less duplicated code in the individual browser
> > > > > - aggregated cost for inlined frames for the --children top-down list
> > > > > - various bug fixes that arose from querying for a srcline/symbol
> > > > > based on
> > > > > 
> > > > >   the IP of a sample, which will always point to the last inlined
> > > > >   frame
> > > > >   instead of the corresponding non-inlined frame
> > > > > 
> > > > > - overall much better support for visualizing cost for heavily-inlined
> > > > > C++
> > > > > 
> > > > >   code, which simply was confusing and unreliably before
> > > > > 
> > > > > - srcline honors the global setting as to whether full paths or
> > > > > basenames
> > > > > 
> > > > >   should be shown
> > > > > 
> > > > > - caches for inlined frames and srcline information, which allow us to
> > > > > 
> > > > >   enable inline frame handling by default
> > > > > 
> > > > > For comparison, below lists the output before and after for `perf
> > > > > script`
> > > > 
> > > > > and `perf report`. The example file I used to generate the perf data 
> is:
> > > > So, please check my tmp.perf/core branch, it has this patchset + the fix
> > > > I proposed for the match_chain() to always use absolute addresses.
> > > 
> > > OK, so I've looked at it. I think there are some style issues with the
> > > indentation in match_chain_addresses. Also, the unmap_ip lines are too
> > > long
> > > for checkpatch.pl
> > > 
> > > Additionally, we can now still run into the CCKEY_ADDRESS code path (when
> > > match_chain_strings for inlined symbols returns MATCH_ERROR, or when
> > > either
> > > cnode->ms.sym or node->sym is invalid), but won't unmap the IP properly
> > > then.
> >
> > so you're saying that cnode->ip and node->ip may be relative or
> > absolute? I thought they were always absolute, but I'll double check.
> 
> See below.
>  
> > > Can we maybe instead use something like this on top of your patch?
> > > 
> > > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > > index 01fc95fdd1e0..92bca95be202 100644
> > > --- a/tools/perf/util/callchain.c
> > > +++ b/tools/perf/util/callchain.c
> > > @@ -669,11 +669,16 @@ static enum match_result match_chain_strings(const
> > > char *left,
> > > 
> > >  static enum match_result match_chain_addresses(u64 left_ip, u64 right_ip)
> > >  {
> > >  
> > >  	if (left_ip == right_ip)
> > > 
> > > -               return MATCH_EQ;
> > > -       else if (left_ip < right_ip)
> > > -               return MATCH_LT;
> > > -       else
> > > -               return MATCH_GT;
> > > +		return MATCH_EQ;
> > > +	else if (left_ip < right_ip)
> > > +		return MATCH_LT;
> > > +	else
> > > +		return MATCH_GT;
> > > +}
> > 
> > Applied the space fixes above, but the following I don't think makes
> > things clearer, it is not "unmap_ip()" it is at its best
> > try_to_unmap_ip_but_do_not_unmap_if_not_possible() which is confusing
> > 8-)
> > 
> > So we better fix it in the users and continue using the existing
> > map->unmap_ip(map, rel_ip) idiom.
> > 
> > > +static u64 unmap_ip(struct map *map, u64 ip)
> > > +{
> > > +	return map ? map->unmap_ip(map, ip) : ip;
> > > 
> > >  }
> > >  
> > >  static enum match_result match_chain(struct callchain_cursor_node *node,
> > > 
> > > @@ -702,9 +707,10 @@ static enum match_result match_chain(struct
> > > callchain_cursor_node *node,
> > > 
> > >  				if (match != MATCH_ERROR)
> > >  				
> > >  					break;
> > >  			
> > >  			} else {
> > > 
> > > -				u64 left = cnode->ms.map->unmap_ip(cnode->ms.map, cnode-
> > > 
> > > >ms.sym->start),
> > > 
> > > -				    right = node->map->unmap_ip(node->map, node->sym-
> >start);
> > > -
> > > +				u64 left = unmap_ip(cnode->ms.map,
> > > +						    cnode->ms.sym->start);
> > > +				u64 right = unmap_ip(node->map,
> > > +						     node->sym->start);
> > 
> > So, in the above, you say that cnode->ms.map or node->map may be NULL,
> > right? But then both are asking for a sym->start (which is a relative
> > address, it came from a symtab), and furthermore, for cnode->ms.sym to
> > be not NULL means that cnode->ms.map is not NULL, after all
> > cnode->ms.sym came from a dso__find_symbol(cnode->ms.map->dso).
> 
> Ugh sorry yes, now I see where my confusion comes from... I clearly did not 
> understand Ravi's patch in its entirety - sorry for that.
> 
> So trying to bring back some clarity, let's summarize:
> 
> - sym->start is always relative
> - *->ip is absolute if no map could be found
> - *->ip is relative otherwise if there is a map
> - we need to always use relative addresses as we want to aggregate from 
> different address spaces (see also Namhyung's latest mail in the thread on v6 
> of this patch series)

We're aggregating on the same hist entry paths to a function in a DSO, I
see, so indeed we need to always use relative, i.e. the sym->start.

And sometimes we resolve the map but not the symbol, ok. But perhaps
keeping ->ip always as absolute helps in reading the code, i.e. when we
resolve the symbol we have sym->start, relative, when we dont, then we
do a cnode->ms.map(cnode->ms.map, cnode->ip) to get the relative
address.

> - we need to prevent merging of equal relative addresses from different DSOs
> 
> So to fix this all, I guess the suggested approach by Namhyung would be best, 
> i.e. fixup my initial match_addresses to take the map, and then if the map is 
> valid also take the dso into account when comparing the addresses:
> 
>         if (left_dso != right_dso)
>                 return left_dso < right_dso ? MATCH_LT : MATCH_GT;

Humm, but then what would be a cmp function? strcmp(left->dso->name,
right->dso->name)?  Like _sort__dso_cmp() does? Probably yes, for
consistency?

>         else if (left_ip != right_ip)
>                 return left_ip < right_ip ? MATCH_LT : MATCH_GT;
>         else
>                 return MATCH_EQ;
> 
> > Ditto for node->sym/node->map.
> > 
> > >  				match = match_chain_addresses(left, right);
> > >  				break;
> > >  			
> > >  			}
> > > 
> > > @@ -713,7 +719,9 @@ static enum match_result match_chain(struct
> > > callchain_cursor_node *node,
> > > 
> > >  		__fallthrough;
> > >  	
> > >  	case CCKEY_ADDRESS:
> > > 
> > >  	default:
> > > -		match = match_chain_addresses(cnode->ip, node->ip);
> > > +		match = match_chain_addresses(unmap_ip(cnode->ms.map,
> > > +						       cnode->ip),
> > > +					      unmap_ip(node->map, node->ip));
> > 
> > Here I need to look further, to see what kind of address cnode->ip is,
> > my expectation is that it is a absolute address, so no need for
> > unmapping, will check.
 
> Please double check this and also the other points in my list above. It is all 
> a bit confusing... 

Right, but from Namhyung's comments (and yours), the confusion comes
from this "hey, its relative if resolved, absolute if not), which I
think we should resolve by stating that it is the original, "raw"
address that came in the callchain record from the kernel, and when we
need to transform it into some relative address, if we found at least
the map, then we can, using map->map_ip(map, cnode->ip).
 
> Do you want me to supply another patch, or will you take care of this?

Well, having what you think is right in a branch helps in testing, even
if as we discuss we might not use it.

Good, we're making progress, I guess :-)

- Arnaldo
