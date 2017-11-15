From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] perf/bench/numa: Handle discontiguous/sparse
 numa nodes
Date: Wed, 15 Nov 2017 21:21:40 +0530
Message-ID: <1510761100.24275.50.camel@linux.vnet.ibm.com>
References: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
         <67b88aa2de6dd199d57bacdecf35d26958780feb.1503310062.git.sathnaga@linux.vnet.ibm.com>
         <20171031151658.clq6qmdfw3gj6afg@naverao1-tp.localdomain>
         <20171031152657.GU7045@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171031152657.GU7045@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,Please find my reply inline.

On Tue, 2017-10-31 at 12:26 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 31, 2017 at 08:46:58PM +0530, Naveen N. Rao escreveu:
> > 
> > On 2017/08/21 10:17AM, sathnaga@linux.vnet.ibm.com wrote:
> > > 
> > > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > > 
> > > Certain systems are designed to have sparse/discontiguous nodes.
> > > On such systems, perf bench numa hangs, shows wrong number of
> > > nodes
> > > and shows values for non-existent nodes. Handle this by only
> > > taking nodes that are exposed by kernel to userspace.
> > > 
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > > Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > ---
> > >  tools/perf/bench/numa.c | 17 ++++++++++-------
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > > index 2483174..d4cccc4 100644
> > > --- a/tools/perf/bench/numa.c
> > > +++ b/tools/perf/bench/numa.c
> > > @@ -287,12 +287,12 @@ static cpu_set_t bind_to_cpu(int
> > > target_cpu)
> > > 
> > >  static cpu_set_t bind_to_node(int target_node)
> > >  {
> > > -	int cpus_per_node = g->p.nr_cpus/g->p.nr_nodes;
> > > +	int cpus_per_node = g->p.nr_cpus/nr_numa_nodes();
> > >  	cpu_set_t orig_mask, mask;
> > >  	int cpu;
> > >  	int ret;
> > > 
> > > -	BUG_ON(cpus_per_node*g->p.nr_nodes != g->p.nr_cpus);
> > > +	BUG_ON(cpus_per_node*nr_numa_nodes() != g->p.nr_cpus);
> > >  	BUG_ON(!cpus_per_node);
> > > 
> > >  	ret = sched_getaffinity(0, sizeof(orig_mask),
> > > &orig_mask);
> > > @@ -692,7 +692,7 @@ static int parse_setup_node_list(void)
> > >  			int i;
> > > 
> > >  			for (i = 0; i < mul; i++) {
> > > -				if (t >= g->p.nr_tasks) {
> > > +				if (t >= g->p.nr_tasks ||
> > > !node_has_cpus(bind_node)) {
> > >  					printf("\n# NOTE:
> > > ignoring bind NODEs starting at NODE#%d\n", bind_node);
> > >  					goto out;
> > >  				}
> > > @@ -973,6 +973,7 @@ static void calc_convergence(double
> > > runtime_ns_max, double *convergence)
> > >  	int node;
> > >  	int cpu;
> > >  	int t;
> > > +	int processes;
> > > 
> > >  	if (!g->p.show_convergence && !g->p.measure_convergence)
> > >  		return;
> > > @@ -1007,13 +1008,14 @@ static void calc_convergence(double
> > > runtime_ns_max, double *convergence)
> > >  	sum = 0;
> > > 
> > >  	for (node = 0; node < g->p.nr_nodes; node++) {
> > > +		if (!is_node_present(node))
> > > +			continue;
> > >  		nr = nodes[node];
> > >  		nr_min = min(nr, nr_min);
> > >  		nr_max = max(nr, nr_max);
> > >  		sum += nr;
> > >  	}
> > >  	BUG_ON(nr_min > nr_max);
> > > -
> > Looks like an un-necessary change there.
> Right, and I would leave the 'int processes' declaration where it is,
> as
> it is not used outside that loop.
> 
I had hit with this compilation error, so had to move the
initialization above.

  CC       bench/numa.o
bench/numa.c: In function ‘calc_convergence’:
bench/numa.c:1035:3: error: ISO C90 forbids mixed declarations and code
[-Werror=declaration-after-statement]
   int processes = count_node_processes(node);
   ^
cc1: all warnings being treated as errors
mv: cannot stat ‘bench/.numa.o.tmp’: No such file or directory
make[4]: *** [bench/numa.o] Error 1
make[3]: *** [bench] Error 2
make[2]: *** [perf-in.o] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

> The move of that declaration to the top of the calc_convergence()
> function made me spend some cycles trying to figure out why that was
> done, only to realize that it was an unnecessary change :-\
> 

Agree, I would have kept it in the same scope, will keep as below,

@@ -984,8 +1026,11 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
        process_groups = 0;
 
        for (node = 0; node < g->p.nr_nodes; node++) {
-               int processes = count_node_processes(node);
+               int processes;
 
+               if (!is_node_present(node))
+                       continue;
+               processes = count_node_processes(node);
                nr = nodes[node];
                tprintf(" %2d/%-2d", nr, processes);
 
Please advice. Thanks.


Regards,
-Satheesh.
> > 
> > - Naveen
> > 
> > > 
> > >  	BUG_ON(sum > g->p.nr_tasks);
> > > 
> > >  	if (0 && (sum < g->p.nr_tasks))
> > > @@ -1027,8 +1029,9 @@ static void calc_convergence(double
> > > runtime_ns_max, double *convergence)
> > >  	process_groups = 0;
> > > 
> > >  	for (node = 0; node < g->p.nr_nodes; node++) {
> > > -		int processes = count_node_processes(node);
> > > -
> > > +		if (!is_node_present(node))
> > > +			continue;
> > > +		processes = count_node_processes(node);
> > >  		nr = nodes[node];
> > >  		tprintf(" %2d/%-2d", nr, processes);
> > > 
> > > @@ -1334,7 +1337,7 @@ static void print_summary(void)
> > > 
> > >  	printf("\n ###\n");
> > >  	printf(" # %d %s will execute (on %d nodes, %d
> > > CPUs):\n",
> > > -		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" :
> > > "tasks", g->p.nr_nodes, g->p.nr_cpus);
> > > +		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" :
> > > "tasks", nr_numa_nodes(), g->p.nr_cpus);
> > >  	printf(" #      %5dx %5ldMB global  shared mem
> > > operations\n",
> > >  			g->p.nr_loops, g-
> > > >p.bytes_global/1024/1024);
> > >  	printf(" #      %5dx %5ldMB process shared mem
> > > operations\n",
