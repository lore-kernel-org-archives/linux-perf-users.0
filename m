From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] perf/bench/numa: Add functions to detect sparse
 numa nodes
Date: Tue, 31 Oct 2017 20:44:53 +0530
Message-ID: <20171031151453.pe2ef33hyjl6bcxo@naverao1-tp.localdomain>
References: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
 <855c8ed2d15135f2ac32105f60a745a4fd14036b.1503310062.git.sathnaga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <855c8ed2d15135f2ac32105f60a745a4fd14036b.1503310062.git.sathnaga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sathnaga@linux.vnet.ibm.com
Cc: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Hi Satheesh,

On 2017/08/21 10:15AM, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> Added functions 1) to get a count of all nodes that are exposed to
> userspace. These nodes could be memoryless cpu nodes or cpuless memory
> nodes, 2) to check given node is present and 3) to check given
> node has cpus
> 
> This information can be used to handle sparse/discontiguous nodes.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> ---
>  tools/perf/bench/numa.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 469d65b..2483174 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -215,6 +215,50 @@ static const char * const numa_usage[] = {
>  	NULL
>  };
> 
> +/*
> + * To get number of numa nodes present.
> + */
> +static int nr_numa_nodes(void)
> +{
> +	int i, nr_nodes = 0;
> +
> +	for (i = 0; i < g->p.nr_nodes; i++) {
> +		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
> +			nr_nodes++;
> +	}
> +
> +	return nr_nodes;
> +}
> +
> +/* 

Please run patches through scripts/checkpatch.pl. There is a trailing 
whitespace above...

> + * To check if given numa node is present.
> + */
> +static int is_node_present(int node)
> +{
> +	return numa_bitmask_isbitset(numa_nodes_ptr, node);
> +}
> +
> +/*
> + * To check given numa node has cpus.
> + */
> +static bool node_has_cpus(int node)
> +{
> +	struct bitmask *cpu = numa_allocate_cpumask();
> +	unsigned int i;
> +
> +	if (cpu == NULL)
> +		return false; /* lets fall back to nocpus safely */
> +
> +	if (numa_node_to_cpus(node, cpu) == 0) {

This can be simplified to:
	if (cpu && !numa_node_to_cpus(node, cpu)) {

> +		for (i = 0; i < cpu->size; i++) {
> +			if (numa_bitmask_isbitset(cpu, i))
> +				return true;
> +			}
> +		}

The indentation on those brackets look to be wrong.

> +
> +	return false;
> +}
> +

More importantly, you've introduced few functions in this patch, but 
none of those are being used. This is not a useful way to split your 
patches. In fact, this hurts bisect since trying to build perf with just 
this patch applied throws errors.

You seem to be addressing a few different issues related to perf bench 
numa. You might want to split your patch based on the specific issue(s) 
each change fixes.


- Naveen


>  static cpu_set_t bind_to_cpu(int target_cpu)
>  {
>  	cpu_set_t orig_mask, mask;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
