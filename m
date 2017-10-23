From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v7 0/5] generate full callchain cursor entries for
 inlined frames
Date: Mon, 23 Oct 2017 16:04:53 -0300
Message-ID: <20171023190453.GD21936@kernel.org>
References: <20171019113836.5548-1-milian.wolff@kdab.com>
 <20171020161540.GG30002@kernel.org>
 <3662337.Ysj1km7A8r@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3662337.Ysj1km7A8r@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Oct 20, 2017 at 10:21:03PM +0200, Milian Wolff escreveu:
> On Freitag, 20. Oktober 2017 18:15:40 CEST Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 19, 2017 at 01:38:31PM +0200, Milian Wolff escreveu:
> > > This series of patches completely reworks the way inline frames are
> > > handled. Instead of querying for the inline nodes on-demand in the
> > > individual tools, we now create proper callchain nodes for inlined
> > > frames. The advantages this approach brings are numerous:
> > > 
> > > - less duplicated code in the individual browser
> > > - aggregated cost for inlined frames for the --children top-down list
> > > - various bug fixes that arose from querying for a srcline/symbol based on
> > > 
> > >   the IP of a sample, which will always point to the last inlined frame
> > >   instead of the corresponding non-inlined frame
> > > 
> > > - overall much better support for visualizing cost for heavily-inlined C++
> > > 
> > >   code, which simply was confusing and unreliably before
> > > 
> > > - srcline honors the global setting as to whether full paths or basenames
> > > 
> > >   should be shown
> > > 
> > > - caches for inlined frames and srcline information, which allow us to
> > > 
> > >   enable inline frame handling by default
> > > 
> > > For comparison, below lists the output before and after for `perf script`
> > 
> > > and `perf report`. The example file I used to generate the perf data is:
> >
> > So, please check my tmp.perf/core branch, it has this patchset + the fix
> > I proposed for the match_chain() to always use absolute addresses.
> 
> OK, so I've looked at it. I think there are some style issues with the 
> indentation in match_chain_addresses. Also, the unmap_ip lines are too long 
> for checkpatch.pl
> 
> Additionally, we can now still run into the CCKEY_ADDRESS code path (when 
> match_chain_strings for inlined symbols returns MATCH_ERROR, or when either 
> cnode->ms.sym or node->sym is invalid), but won't unmap the IP properly then.

so you're saying that cnode->ip and node->ip may be relative or
absolute? I thought they were always absolute, but I'll double check.
 
> Can we maybe instead use something like this on top of your patch?
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 01fc95fdd1e0..92bca95be202 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -669,11 +669,16 @@ static enum match_result match_chain_strings(const char 
> *left,
>  static enum match_result match_chain_addresses(u64 left_ip, u64 right_ip)
>  {
>  	if (left_ip == right_ip)
> -               return MATCH_EQ;
> -       else if (left_ip < right_ip)
> -               return MATCH_LT;
> -       else
> -               return MATCH_GT;
> +		return MATCH_EQ;
> +	else if (left_ip < right_ip)
> +		return MATCH_LT;
> +	else
> +		return MATCH_GT;
> +}

Applied the space fixes above, but the following I don't think makes
things clearer, it is not "unmap_ip()" it is at its best
try_to_unmap_ip_but_do_not_unmap_if_not_possible() which is confusing
8-)

So we better fix it in the users and continue using the existing
map->unmap_ip(map, rel_ip) idiom.

> +static u64 unmap_ip(struct map *map, u64 ip)
> +{
> +	return map ? map->unmap_ip(map, ip) : ip;
>  }
>  
>  static enum match_result match_chain(struct callchain_cursor_node *node,
> @@ -702,9 +707,10 @@ static enum match_result match_chain(struct 
> callchain_cursor_node *node,
>  				if (match != MATCH_ERROR)
>  					break;
>  			} else {
> -				u64 left = cnode->ms.map->unmap_ip(cnode->ms.map, cnode-
> >ms.sym->start),
> -				    right = node->map->unmap_ip(node->map, node->sym->start);
> -
> +				u64 left = unmap_ip(cnode->ms.map,
> +						    cnode->ms.sym->start);
> +				u64 right = unmap_ip(node->map,
> +						     node->sym->start);

So, in the above, you say that cnode->ms.map or node->map may be NULL,
right? But then both are asking for a sym->start (which is a relative
address, it came from a symtab), and furthermore, for cnode->ms.sym to
be not NULL means that cnode->ms.map is not NULL, after all
cnode->ms.sym came from a dso__find_symbol(cnode->ms.map->dso).

Ditto for node->sym/node->map.

>  				match = match_chain_addresses(left, right);
>  				break;
>  			}
> @@ -713,7 +719,9 @@ static enum match_result match_chain(struct 
> callchain_cursor_node *node,
>  		__fallthrough;
>  	case CCKEY_ADDRESS:
>  	default:
> -		match = match_chain_addresses(cnode->ip, node->ip);
> +		match = match_chain_addresses(unmap_ip(cnode->ms.map,
> +						       cnode->ip),
> +					      unmap_ip(node->map, node->ip));

Here I need to look further, to see what kind of address cnode->ip is,
my expectation is that it is a absolute address, so no need for
unmapping, will check.

- Arnaldo
