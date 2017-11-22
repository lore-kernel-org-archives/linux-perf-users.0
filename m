From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/1] perf/bench/numa: Fixup discontiguous/sparse numa
 nodes
Date: Wed, 22 Nov 2017 21:39:38 +0530
Message-ID: <1511366847.k4y13an79p.naveen@linux.ibm.com>
References: <1511336642-15389-1-git-send-email-sathnaga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751476AbdKVQJw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Nov 2017 11:09:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAMG9ouq007469
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 11:09:52 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2edaqxf3rg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 11:09:51 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 22 Nov 2017 16:09:43 -0000
In-Reply-To: <1511336642-15389-1-git-send-email-sathnaga@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@kernel.org, sathnaga@linux.vnet.ibm.com
Cc: bala24@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com

sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> Certain systems are designed to have sparse/discontiguous nodes.
> On such systems, perf bench numa hangs, shows wrong number of nodes
> and shows values for non-existent nodes. Handle this by only
> taking nodes that are exposed by kernel to userspace.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> ---
>  tools/perf/bench/numa.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index d95fdcc..ed7db12 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -216,6 +216,47 @@ static const char * const numa_usage[] = {
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
> +	if (cpu && !numa_node_to_cpus(node, cpu)) {
> +		for (i = 0; i < cpu->size; i++) {
> +			if (numa_bitmask_isbitset(cpu, i))
> +				return true;
> +		}
> +	}
> +
> +	return false; /* lets fall back to nocpus safely */
> +}
> +
>  static cpu_set_t bind_to_cpu(int target_cpu)
>  {
>  	cpu_set_t orig_mask, mask;
> @@ -244,12 +285,12 @@ static cpu_set_t bind_to_cpu(int target_cpu)
> 
>  static cpu_set_t bind_to_node(int target_node)
>  {
> -	int cpus_per_node = g->p.nr_cpus/g->p.nr_nodes;
> +	int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
>  	cpu_set_t orig_mask, mask;
>  	int cpu;
>  	int ret;
> 
> -	BUG_ON(cpus_per_node*g->p.nr_nodes != g->p.nr_cpus);
> +	BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
>  	BUG_ON(!cpus_per_node);
> 
>  	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
> @@ -649,7 +690,7 @@ static int parse_setup_node_list(void)
>  			int i;
> 
>  			for (i = 0; i < mul; i++) {
> -				if (t >= g->p.nr_tasks) {
> +				if (t >= g->p.nr_tasks || !node_has_cpus(bind_node)) {
>  					printf("\n# NOTE: ignoring bind NODEs starting at NODE#%d\n", bind_node);
>  					goto out;
>  				}
> @@ -964,13 +1005,14 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
>  	sum = 0;
> 
>  	for (node = 0; node < g->p.nr_nodes; node++) {
> +		if (!is_node_present(node))
> +			continue;
>  		nr = nodes[node];
>  		nr_min = min(nr, nr_min);
>  		nr_max = max(nr, nr_max);
>  		sum += nr;
>  	}
>  	BUG_ON(nr_min > nr_max);
> -
>  	BUG_ON(sum > g->p.nr_tasks);

Looks like that change to remove a blank line did slip in, but that's a 
small nit. Apart from that, the patch looks good to me.
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen
