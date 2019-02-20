From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 2/2] perf evsel: add inline functions to sample callchain
 output
Date: Wed, 20 Feb 2019 01:11:16 +0100
Message-ID: <20190220001116.3b3yyndjjmqs3hmm@studium.uni-erlangen.de>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
 <6aab7b5b0816426fed3cb2f2a2ba08e73e4c51e2.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6aab7b5b0816426fed3cb2f2a2ba08e73e4c51e2.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Feb 19, 2019 at 07:38:10PM +0100, Jonas Rabenstein wrote:
> Whenever a callchain shall be printed search for each address whether
> inline information is available and add those symbols to the output
> if symbol_conf.inline_name is enabled.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
>  tools/perf/util/evsel_fprintf.c | 46 +++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index c710f687ddf4..9f9ece453dc4 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -168,6 +168,49 @@ static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symb
>  	return printed;
>  }
>  
> +static int __fprintf_callchain_inlines(struct callchain_cursor_node *node,
> +				       bool first, int left_alignment,
> +				       unsigned int print_opts, FILE *fp)
> +{
> +	int printed = 0;
> +	struct inline_node *inline_node;
> +	struct inline_list *ilist;
> +	u64 addr;
> +
> +	if (!symbol_conf.inline_name)
> +		return 0;
> +
> +	if (!node->map || !node->map->dso)
> +		return 0;
> +
> +	addr = node->map->map_ip(node->map, node->ip);
I stumbled across a problem with the usage of map_ip here. Using the map_ip
on dynamic binaries does resolve the inline symbols but it fails with static
ones. Using node->ip directly works for static binaries but fails for
static ones...
Is there a way to decide whether node->map->dso is a static or dynamic
object file? Furthermore, is it even correct for a static dso to have
map->map_ip set to map__map_ip instead of identity__map_ip?
> +
> +	inline_node = inlines__tree_find(&node->map->dso->inlined_nodes,
> +					 addr);
> +	if (!inline_node) {
> +		inline_node = dso__parse_addr_inlines(node->map->dso,
> +						      addr, node->sym);
> +		if (!inline_node)
> +			return 0;
> +		inlines__tree_insert(&node->map->dso->inlined_nodes,
> +				     inline_node);
> +	}
> +
> +	list_for_each_entry(ilist, &inline_node->val, list) {
> +		if (ilist->symbol == node->sym)
> +			break;
> +
> +		printed += __fprintf_callchain_link(node->ip, node->map,
> +						    ilist->symbol,
> +						    ilist->srcline,
> +						    first, left_alignment,
> +						    print_opts, fp);
> +		first = (first && printed == 0);
> +	}
> +
> +	return printed;
> +}
> +
>  int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			      unsigned int print_opts, struct callchain_cursor *cursor,
>  			      FILE *fp)
> @@ -183,6 +226,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (!node)
>  				break;
>  
> +			printed += __fprintf_callchain_inlines(node, (printed ==  0),
> +							       left_alignment,
> +							       print_opts, fp);
>  
>  			printed += __fprintf_callchain_link(node->ip, node->map,
>  							    node->sym, NULL,
> -- 
> 2.19.2
> 
