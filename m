From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] perf/bench/numa: Handle discontiguous/sparse numa
 nodes
Date: Tue, 31 Oct 2017 20:46:58 +0530
Message-ID: <20171031151658.clq6qmdfw3gj6afg@naverao1-tp.localdomain>
References: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
 <67b88aa2de6dd199d57bacdecf35d26958780feb.1503310062.git.sathnaga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751446AbdJaPRG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Oct 2017 11:17:06 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9VFGt6m138210
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2017 11:17:05 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dxsxb70ms-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2017 11:17:04 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 31 Oct 2017 15:17:02 -0000
Content-Disposition: inline
In-Reply-To: <67b88aa2de6dd199d57bacdecf35d26958780feb.1503310062.git.sathnaga@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sathnaga@linux.vnet.ibm.com
Cc: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com

On 2017/08/21 10:17AM, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> Certain systems are designed to have sparse/discontiguous nodes.
> On such systems, perf bench numa hangs, shows wrong number of nodes
> and shows values for non-existent nodes. Handle this by only
> taking nodes that are exposed by kernel to userspace.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> ---
>  tools/perf/bench/numa.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 2483174..d4cccc4 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -287,12 +287,12 @@ static cpu_set_t bind_to_cpu(int target_cpu)
> 
>  static cpu_set_t bind_to_node(int target_node)
>  {
> -	int cpus_per_node = g->p.nr_cpus/g->p.nr_nodes;
> +	int cpus_per_node = g->p.nr_cpus/nr_numa_nodes();
>  	cpu_set_t orig_mask, mask;
>  	int cpu;
>  	int ret;
> 
> -	BUG_ON(cpus_per_node*g->p.nr_nodes != g->p.nr_cpus);
> +	BUG_ON(cpus_per_node*nr_numa_nodes() != g->p.nr_cpus);
>  	BUG_ON(!cpus_per_node);
> 
>  	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
> @@ -692,7 +692,7 @@ static int parse_setup_node_list(void)
>  			int i;
> 
>  			for (i = 0; i < mul; i++) {
> -				if (t >= g->p.nr_tasks) {
> +				if (t >= g->p.nr_tasks || !node_has_cpus(bind_node)) {
>  					printf("\n# NOTE: ignoring bind NODEs starting at NODE#%d\n", bind_node);
>  					goto out;
>  				}
> @@ -973,6 +973,7 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
>  	int node;
>  	int cpu;
>  	int t;
> +	int processes;
> 
>  	if (!g->p.show_convergence && !g->p.measure_convergence)
>  		return;
> @@ -1007,13 +1008,14 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
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

Looks like an un-necessary change there.

- Naveen

>  	BUG_ON(sum > g->p.nr_tasks);
> 
>  	if (0 && (sum < g->p.nr_tasks))
> @@ -1027,8 +1029,9 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
>  	process_groups = 0;
> 
>  	for (node = 0; node < g->p.nr_nodes; node++) {
> -		int processes = count_node_processes(node);
> -
> +		if (!is_node_present(node))
> +			continue;
> +		processes = count_node_processes(node);
>  		nr = nodes[node];
>  		tprintf(" %2d/%-2d", nr, processes);
> 
> @@ -1334,7 +1337,7 @@ static void print_summary(void)
> 
>  	printf("\n ###\n");
>  	printf(" # %d %s will execute (on %d nodes, %d CPUs):\n",
> -		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", g->p.nr_nodes, g->p.nr_cpus);
> +		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", nr_numa_nodes(), g->p.nr_cpus);
>  	printf(" #      %5dx %5ldMB global  shared mem operations\n",
>  			g->p.nr_loops, g->p.bytes_global/1024/1024);
>  	printf(" #      %5dx %5ldMB process shared mem operations\n",
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
