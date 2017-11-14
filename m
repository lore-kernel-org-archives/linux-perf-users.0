From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] perf/bench/numa: Add functions to detect sparse
 numa nodes
Date: Tue, 14 Nov 2017 18:17:46 +0530
Message-ID: <1510663666.24275.41.camel@linux.vnet.ibm.com>
References: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
         <855c8ed2d15135f2ac32105f60a745a4fd14036b.1503310062.git.sathnaga@linux.vnet.ibm.com>
         <20171031151453.pe2ef33hyjl6bcxo@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754544AbdKNMsC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 07:48:02 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAECiTGg091027
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 07:48:02 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e7wbs3nc4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 07:48:01 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Tue, 14 Nov 2017 07:48:01 -0500
In-Reply-To: <20171031151453.pe2ef33hyjl6bcxo@naverao1-tp.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com

Hi Naveen,Thanks for detailed review, my comments inline.

On Tue, 2017-10-31 at 20:44 +0530, Naveen N. Rao wrote:
> Hi Satheesh,
> 
> On 2017/08/21 10:15AM, sathnaga@linux.vnet.ibm.com wrote:
> > 
> > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > 
> > Added functions 1) to get a count of all nodes that are exposed to
> > userspace. These nodes could be memoryless cpu nodes or cpuless
> > memory
> > nodes, 2) to check given node is present and 3) to check given
> > node has cpus
> > 
> > This information can be used to handle sparse/discontiguous nodes.
> > 
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > ---
> >  tools/perf/bench/numa.c | 44
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > index 469d65b..2483174 100644
> > --- a/tools/perf/bench/numa.c
> > +++ b/tools/perf/bench/numa.c
> > @@ -215,6 +215,50 @@ static const char * const numa_usage[] = {
> >  	NULL
> >  };
> > 
> > +/*
> > + * To get number of numa nodes present.
> > + */
> > +static int nr_numa_nodes(void)
> > +{
> > +	int i, nr_nodes = 0;
> > +
> > +	for (i = 0; i < g->p.nr_nodes; i++) {
> > +		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
> > +			nr_nodes++;
> > +	}
> > +
> > +	return nr_nodes;
> > +}
> > +
> > +/* 
> Please run patches through scripts/checkpatch.pl. There is a
> trailing 
> whitespace above...
> 
Sure
> > 
> > + * To check if given numa node is present.
> > + */
> > +static int is_node_present(int node)
> > +{
> > +	return numa_bitmask_isbitset(numa_nodes_ptr, node);
> > +}
> > +
> > +/*
> > + * To check given numa node has cpus.
> > + */
> > +static bool node_has_cpus(int node)
> > +{
> > +	struct bitmask *cpu = numa_allocate_cpumask();
> > +	unsigned int i;
> > +
> > +	if (cpu == NULL)
> > +		return false; /* lets fall back to nocpus safely
> > */
> > +
> > +	if (numa_node_to_cpus(node, cpu) == 0) {
> This can be simplified to:
> 	if (cpu && !numa_node_to_cpus(node, cpu)) {
> 
> > 
> > +		for (i = 0; i < cpu->size; i++) {
> > +			if (numa_bitmask_isbitset(cpu, i))
> > +				return true;
> > +			}
> > +		}
> The indentation on those brackets look to be wrong.
> 
Sure
> > 
> > +
> > +	return false;
> > +}
> > +
> More importantly, you've introduced few functions in this patch, but 
> none of those are being used. This is not a useful way to split your 
> patches. In fact, this hurts bisect since trying to build perf with
> just 
> this patch applied throws errors.
> 
Sure, This can be merged to single patch, will do it in next version.

> You seem to be addressing a few different issues related to perf
> bench 
> numa. You might want to split your patch based on the specific
> issue(s) 
> each change fixes.
> 
> 
> - Naveen
> 
> 
Regards,
-Satheesh.
> > 
> >  static cpu_set_t bind_to_cpu(int target_cpu)
> >  {
> >  	cpu_set_t orig_mask, mask;
