From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf/bench/numa: Add functions to detect sparse
 numa nodes
Date: Thu, 17 Aug 2017 18:00:47 +0530
Message-ID: <1502973047.9759.11.camel@linux.vnet.ibm.com>
References: <1502350129-10489-1-git-send-email-sathnaga@linux.vnet.ibm.com>
         <20170810192213.GE3900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36795 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753726AbdHUR3r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2017 13:29:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7LHSjxD079832
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2017 13:29:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cg1613dnd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2017 13:29:46 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Mon, 21 Aug 2017 11:29:46 -0600
In-Reply-To: <20170810192213.GE3900@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com

Thanks Arnaldo for the detailed review :-)
Will address them and send across v2. On Thu, 2017-08-10 at 16:22 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 10, 2017 at 12:58:49PM +0530, sathnaga@linux.vnet.ibm.com
>  escreveu:
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
> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > ---
> >  tools/perf/bench/numa.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > index 469d65b..efd7595 100644
> > --- a/tools/perf/bench/numa.c
> > +++ b/tools/perf/bench/numa.c
> > @@ -215,6 +215,41 @@ static const char * const numa_usage[] = {
> >  	NULL
> >  };
> >  
> > +static int nr_numa_nodes(void)
> > +{
> > +	int node = 0, i;
> > +
> > +        for (i = 0; i < g->p.nr_nodes; i++) {
> > +		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
> > +			node++;
> > +	}
> > +	return node;
> Humm, can you rename 'node' to 'nr_nodes'?
> 
Sure, will Change it.
> > 
> > +}
> > +
> > +static bool is_node_present(int node)
> > +{
> > +	if (numa_bitmask_isbitset(numa_nodes_ptr, node))
> > +		return true;
> > +	else
> > +		return false;
> > +}
> Why four lines instead of just one? Isn't this equivalent:
> 
Sure.
> static bool is_node_present(int node)
> {
> 	return numa_bitmask_isbitset(numa_nodes_ptr, node);
> }
> 
> ?
> 
> > +
> > +static bool is_node_hascpu(int node)
> Can you rename this function, the name is confusing :-\
> 
> Based on the documentation for this function, that you left only in
> the
> changelog (please put it just before the function, as a comment, I
> think
> it should be named node_has_cpus()?
> 
make sense, will change it.
> > 
> > +{
> > +	struct bitmask *cpu;
> > +	unsigned int i;
> > +
> > +	cpu = numa_allocate_cpumask();
> Please put the line with the initialization together with the
> declaration, making it:
> 
> struct bitmask *cpu = numa_allocate_cpumask();
> 
> Also, this is a "alloc" function, I bet it can fail? If so, check it
> and
> return something useful if it fails, which probably will be difficult
> since this function returns bool?
> 
Sure, will check return false as failsafe.
> 
> > 
> > +	if (numa_node_to_cpus(node, cpu) == 0) {
> > +		for (i = 0; i < cpu->size; i++) {
> > +			if (numa_bitmask_isbitset(cpu, i))
> > +				return true;
> > +			}
> > +	} else
> > +		return false; // lets fall back to nocpus safely
> > +	return false;
> > +}
> > +
> >  static cpu_set_t bind_to_cpu(int target_cpu)
> >  {
> >  	cpu_set_t orig_mask, mask;
