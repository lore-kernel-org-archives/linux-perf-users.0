From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf/bench/numa: Add functions to detect sparse numa
 nodes
Date: Thu, 10 Aug 2017 16:22:13 -0300
Message-ID: <20170810192213.GE3900@kernel.org>
References: <1502350129-10489-1-git-send-email-sathnaga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbdHJTWZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2017 15:22:25 -0400
Content-Disposition: inline
In-Reply-To: <1502350129-10489-1-git-send-email-sathnaga@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sathnaga@linux.vnet.ibm.com
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com

Em Thu, Aug 10, 2017 at 12:58:49PM +0530, sathnaga@linux.vnet.ibm.com escreveu:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> Added functions 1) to get a count of all nodes that are exposed to
> userspace. These nodes could be memoryless cpu nodes or cpuless memory
> nodes, 2) to check given node is present and 3) to check given
> node has cpus
> 
> This information can be used to handle sparse/discontiguous nodes.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> ---
>  tools/perf/bench/numa.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 469d65b..efd7595 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -215,6 +215,41 @@ static const char * const numa_usage[] = {
>  	NULL
>  };
>  
> +static int nr_numa_nodes(void)
> +{
> +	int node = 0, i;
> +
> +        for (i = 0; i < g->p.nr_nodes; i++) {
> +		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
> +			node++;
> +	}
> +	return node;

Humm, can you rename 'node' to 'nr_nodes'?

> +}
> +
> +static bool is_node_present(int node)
> +{
> +	if (numa_bitmask_isbitset(numa_nodes_ptr, node))
> +		return true;
> +	else
> +		return false;
> +}

Why four lines instead of just one? Isn't this equivalent:

static bool is_node_present(int node)
{
	return numa_bitmask_isbitset(numa_nodes_ptr, node);
}

?

> +
> +static bool is_node_hascpu(int node)

Can you rename this function, the name is confusing :-\

Based on the documentation for this function, that you left only in the
changelog (please put it just before the function, as a comment, I think
it should be named node_has_cpus()?

> +{
> +	struct bitmask *cpu;
> +	unsigned int i;
> +
> +	cpu = numa_allocate_cpumask();

Please put the line with the initialization together with the
declaration, making it:

struct bitmask *cpu = numa_allocate_cpumask();

Also, this is a "alloc" function, I bet it can fail? If so, check it and
return something useful if it fails, which probably will be difficult
since this function returns bool?


> +	if (numa_node_to_cpus(node, cpu) == 0) {
> +		for (i = 0; i < cpu->size; i++) {
> +			if (numa_bitmask_isbitset(cpu, i))
> +				return true;
> +			}
> +	} else
> +		return false; // lets fall back to nocpus safely
> +	return false;
> +}
> +
>  static cpu_set_t bind_to_cpu(int target_cpu)
>  {
>  	cpu_set_t orig_mask, mask;
> -- 
> 2.7.4
