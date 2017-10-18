From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 1/6] perf report: properly handle branch count in match_chain
Date: Wed, 18 Oct 2017 15:41:04 -0700
Message-ID: <871sm0hyf3.fsf@linux.intel.com>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
        <20171018185350.14893-2-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018185350.14893-2-milian.wolff@kdab.com> (Milian Wolff's
        message of "Wed, 18 Oct 2017 20:53:45 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>  
> +static enum match_result match_address_dso(struct dso *left_dso, u64 left_ip,
> +					   struct dso *right_dso, u64 right_ip)
> +{
> +	if (left_dso == right_dso && left_ip == right_ip)
> +		return MATCH_EQ;
> +	else if (left_ip < right_ip)
> +		return MATCH_LT;
> +	else
> +		return MATCH_GT;
> +}

So why does only the first case check the dso? Does it not matter
for the others?

Either should be checked by none or by all.


> +	case CCKEY_FUNCTION:
> +		if (node->sym && cnode->ms.sym) {
> +			/*
> +			 * Compare inlined frames based on their symbol name
> +			 * because different inlined frames will have the same
> +			 * symbol start. Otherwise do a faster comparison based
> +			 * on the symbol start address.
> +			 */
> +			if (cnode->ms.sym->inlined || node->sym->inlined)
> +				match = match_chain_strings(cnode->ms.sym->name,
node->sym->name);

So what happens when there are multiple symbols with the same name?

(e.g. local for a DSO or local in a file)

> +					  node->ip);
> +		} else {
> +			/*
> +			 * It's "from" of a branch
> +			 */
> +			cnode->brtype_stat.branch_to = false;
> +			cnode->cycles_count += node->branch_flags.cycles;
> +			cnode->iter_count += node->nr_loop_iter;
> +			cnode->iter_cycles += node->iter_cycles;

I assume you tested the cycle accounting still works?

-Andi
