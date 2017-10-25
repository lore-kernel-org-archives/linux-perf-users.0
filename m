From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 0/5] generate full callchain cursor entries for
 inlined frames
Date: Wed, 25 Oct 2017 11:09:14 +0900
Message-ID: <20171025020914.GB12785@sejong>
References: <20171019113836.5548-1-milian.wolff@kdab.com>
 <3662337.Ysj1km7A8r@agathebauer>
 <20171023190453.GD21936@kernel.org>
 <1707691.qaJ269GSZW@agathebauer>
 <20171024132742.GE7045@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171024132742.GE7045@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

On Tue, Oct 24, 2017 at 10:27:42AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 23, 2017 at 09:39:57PM +0200, Milian Wolff escreveu:
> > So to fix this all, I guess the suggested approach by Namhyung would be best, 
> > i.e. fixup my initial match_addresses to take the map, and then if the map is 
> > valid also take the dso into account when comparing the addresses:
> > 
> >         if (left_dso != right_dso)
> >                 return left_dso < right_dso ? MATCH_LT : MATCH_GT;
> >         else if (left_ip != right_ip)
> >                 return left_ip < right_ip ? MATCH_LT : MATCH_GT;
> >         else
> >                 return MATCH_EQ;
> 
> So, can you check that the patch below is the one we should commit to?
> Namhyung? I'm looking at your latest patch kit, v7, to see if the branch
> parts, further below, are as you submitted or if I have any issues with
> it.
> 
> I've updated my perf/core branch with all this.
> 
> commit 275049196c64cc1233837c9f066b4b87e32cd1df
> Author: Milian Wolff <milian.wolff@kdab.com>
> Date:   Fri Oct 20 12:14:47 2017 -0300
> 
>     perf report: Properly handle branch count in match_chain()
>     
>     Some of the code paths I introduced before returned too early without
>     running the code to handle a node's branch count.  By refactoring
>     match_chain to only have one exit point, this can be remedied.
>     
>     Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
>     Cc: David Ahern <dsahern@gmail.com>
>     Cc: Jin Yao <yao.jin@linux.intel.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
>     Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>     Link: http://lkml.kernel.org/r/1707691.qaJ269GSZW@agathebauer
>     Link: http://lkml.kernel.org/r/20171018185350.14893-2-milian.wolff@kdab.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 35a920f09503..19bfcadcf891 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -666,83 +666,99 @@ static enum match_result match_chain_strings(const char *left,
>  	return ret;
>  }
>  
> -static enum match_result match_chain(struct callchain_cursor_node *node,
> -				     struct callchain_list *cnode)
> +/*
> + * We need to always use relative addresses because we're aggregating
> + * callchains from multiple threads, i.e. different address spaces, so
> + * comparing absolute addresses make no sense as a symbol in a DSO may end up
> + * in a different address when used in a different binary or even the same
> + * binary but with some sort of address randomization technique, thus we need
> + * to compare just relative addresses. -acme
> + */
> +static enum match_result match_chain_dso_addresses(struct map *left_map, u64 left_ip,
> +						   struct map *right_map, u64 right_ip)
>  {
> -	struct symbol *sym = node->sym;
> -	u64 left, right;
> -	struct dso *left_dso = NULL;
> -	struct dso *right_dso = NULL;
> +	struct dso *left_dso = left_map ? left_map->dso : NULL;
> +	struct dso *right_dso = right_map ? right_map->dso : NULL;
>  
> -	if (callchain_param.key == CCKEY_SRCLINE) {
> -		enum match_result match = match_chain_strings(cnode->srcline,
> -							      node->srcline);
> +	if (left_dso != right_dso)
> +		return left_dso < right_dso ? MATCH_LT : MATCH_GT;
>  
> -		/* if no srcline is available, fallback to symbol name */
> -		if (match == MATCH_ERROR && cnode->ms.sym && node->sym)
> -			match = match_chain_strings(cnode->ms.sym->name,
> -						    node->sym->name);
> +	if (left_ip != right_ip)
> + 		return left_ip < right_ip ? MATCH_LT : MATCH_GT;
>  
> -		if (match != MATCH_ERROR)
> -			return match;
> +	return MATCH_EQ;
> +}
>  
> -		/* otherwise fall-back to IP-based comparison below */
> -	}
> +static enum match_result match_chain(struct callchain_cursor_node *node,
> +				     struct callchain_list *cnode)
> +{
> +	enum match_result match = MATCH_ERROR;
>  
> -	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
> -		/*
> -		 * Compare inlined frames based on their symbol name because
> -		 * different inlined frames will have the same symbol start
> -		 */
> -		if (cnode->ms.sym->inlined || node->sym->inlined)
> -			return match_chain_strings(cnode->ms.sym->name,
> -						   node->sym->name);
> -
> -		left = cnode->ms.sym->start;
> -		right = sym->start;
> -		left_dso = cnode->ms.map->dso;
> -		right_dso = node->map->dso;
> -	} else {
> -		left = cnode->ip;
> -		right = node->ip;
> +	switch (callchain_param.key) {
> +	case CCKEY_SRCLINE:
> +		match = match_chain_strings(cnode->srcline, node->srcline);
> +		if (match != MATCH_ERROR)
> +			break;
> +		/* otherwise fall-back to symbol-based comparison below */
> +		__fallthrough;
> +	case CCKEY_FUNCTION:
> +		if (node->sym && cnode->ms.sym) {
> +			/*
> +			 * Compare inlined frames based on their symbol name
> +			 * because different inlined frames will have the same
> +			 * symbol start. Otherwise do a faster comparison based
> +			 * on the symbol start address.
> +			 */
> +			if (cnode->ms.sym->inlined || node->sym->inlined) {
> +				match = match_chain_strings(cnode->ms.sym->name,
> +							    node->sym->name);
> +				if (match != MATCH_ERROR)
> +					break;
> +			} else {
> +				match = match_chain_dso_addresses(cnode->ms.map, cnode->ms.sym->start,
> +								  node->map, node->sym->start);
> +				break;
> +			}
> +		}
> +		/* otherwise fall-back to IP-based comparison below */
> +		__fallthrough;
> +	case CCKEY_ADDRESS:
> +	default:
> +		match = match_chain_dso_addresses(cnode->ms.map, cnode->ip, node->map, node->ip);
> +		break;
>  	}
>  
> -	if (left == right && left_dso == right_dso) {
> -		if (node->branch) {
> -			cnode->branch_count++;
> +	if (match == MATCH_EQ && node->branch) {
> +		cnode->branch_count++;
>  
> -			if (node->branch_from) {
> -				/*
> -				 * It's "to" of a branch
> -				 */
> -				cnode->brtype_stat.branch_to = true;
> +		if (node->branch_from) {
> +			/*
> +			 * It's "to" of a branch
> +			 */
> +			cnode->brtype_stat.branch_to = true;
>  
> -				if (node->branch_flags.predicted)
> -					cnode->predicted_count++;
> +			if (node->branch_flags.predicted)
> +				cnode->predicted_count++;
>  
> -				if (node->branch_flags.abort)
> -					cnode->abort_count++;
> +			if (node->branch_flags.abort)
> +				cnode->abort_count++;
>  
> -				branch_type_count(&cnode->brtype_stat,
> -						  &node->branch_flags,
> -						  node->branch_from,
> -						  node->ip);
> -			} else {
> -				/*
> -				 * It's "from" of a branch
> -				 */
> -				cnode->brtype_stat.branch_to = false;
> -				cnode->cycles_count +=
> -					node->branch_flags.cycles;
> -				cnode->iter_count += node->nr_loop_iter;
> -				cnode->iter_cycles += node->iter_cycles;
> -			}
> +			branch_type_count(&cnode->brtype_stat,
> +					  &node->branch_flags,
> +					  node->branch_from,
> +					  node->ip);
> +		} else {
> +			/*
> +			 * It's "from" of a branch
> +			 */
> +			cnode->brtype_stat.branch_to = false;
> +			cnode->cycles_count += node->branch_flags.cycles;
> +			cnode->iter_count += node->nr_loop_iter;
> +			cnode->iter_cycles += node->iter_cycles;
>  		}
> -
> -		return MATCH_EQ;
>  	}
>  
> -	return left > right ? MATCH_GT : MATCH_LT;
> +	return match;
>  }
>  
>  /*
