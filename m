Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24649154BE4
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054101; cv=none; b=rEsihuofin3fMhi80WfRPbIaOlaVmphrmIqDEo13QkfRZHaXj3YTmqZaYzY61qYqVkUNI2aoWzU8IeO6cRdHlPVe4/tEAxfNNavmGIFl9jdoK59oKMkc2hUx6URmQ3OePeuKyqCOmovqES4Mc1jPCPrwabSCHhg6+BqSIGcgsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054101; c=relaxed/simple;
	bh=o0qb0i+dwv5WeAPbMsy+rHfdNRQbCXJiw4nVUxMA1Uk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC8vK9BAIL6AWvT2XWhfLQX9s+ci6eBLeQXL+9PRcaTV3t2+9y9EJiW6O8DYJ39+viMe0jx2pvjhBqxbx9HdvqQgnckRDIo08dJhQuyj+EQgTBvJLaTSVo8428ZKf2129vwF77SQLkwziHAkWX4URrlgNxx2ytpLZf/LS2XXw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3dWn1n0bz6L77J;
	Wed, 11 Sep 2024 19:24:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 44257140F3F;
	Wed, 11 Sep 2024 19:28:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 13:28:13 +0200
Date: Wed, 11 Sep 2024 12:28:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>, <linuxarm@huawei.com>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@linaro.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<linux-perf-users@vger.kernel.org>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@huawei.com>
Subject: Re: [PATCH] perf vender events arm64: Use "Topdown" as topdown
 metric group name
Message-ID: <20240911122755.00000e15@huawei.com>
In-Reply-To: <e75258ec-ea7c-0bc8-0cb1-b233564d9340@huawei.com>
References: <20240730020145.30227-1-yangyicong@huawei.com>
	<e75258ec-ea7c-0bc8-0cb1-b233564d9340@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Sep 2024 21:06:03 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> another ping...
> 
> This patch should be very straightforward, due to the changes to use "Topdown" after [1].
> 
> [1] 1647cd5b8802 ("perf stat: Implement --topdown using json metrics")

Hi Yicong,

That reference definitely helps make this obvious given it clearly states
the pattern match is TopdownL.

As such this LGTM (but I'm not a perf tool expert by any means!)
FWIW.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Thanks.
> 
> On 2024/7/30 10:01, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > HiSilicon HIP08 does support Topdown metrics but perf tool complains
> > when trying to count Topdown metrics:
> > [root@localhost tracing]# perf stat --topdown
> > Topdown requested but the topdown metric groups aren't present.
> > (See perf list the metric groups have names like TopdownL1)
> > 
> > It's because tool's using "Topdown" as the metric group name[1] rather
> > than "TopDown", so follow the convention.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c?h=v6.11-rc1#n1994
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  .../arch/arm64/hisilicon/hip08/metrics.json   | 74 +++++++++----------
> >  1 file changed, 37 insertions(+), 37 deletions(-)
> > 
> > diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> > index 6463531b9941..b6a0d2de8534 100644
> > --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> > +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> > @@ -3,235 +3,235 @@
> >          "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
> >          "PublicDescription": "Frontend bound L1 topdown metric",
> >          "BriefDescription": "Frontend bound L1 topdown metric",
> > -        "DefaultMetricgroupName": "TopDownL1",
> > -        "MetricGroup": "Default;TopDownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "frontend_bound"
> >      },
> >      {
> >          "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
> >          "PublicDescription": "Bad Speculation L1 topdown metric",
> >          "BriefDescription": "Bad Speculation L1 topdown metric",
> > -        "DefaultMetricgroupName": "TopDownL1",
> > -        "MetricGroup": "Default;TopDownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "bad_speculation"
> >      },
> >      {
> >          "MetricExpr": "INST_RETIRED / (CPU_CYCLES * 4)",
> >          "PublicDescription": "Retiring L1 topdown metric",
> >          "BriefDescription": "Retiring L1 topdown metric",
> > -        "DefaultMetricgroupName": "TopDownL1",
> > -        "MetricGroup": "Default;TopDownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "retiring"
> >      },
> >      {
> >          "MetricExpr": "1 - (frontend_bound + bad_speculation + retiring)",
> >          "PublicDescription": "Backend Bound L1 topdown metric",
> >          "BriefDescription": "Backend Bound L1 topdown metric",
> > -        "DefaultMetricgroupName": "TopDownL1",
> > -        "MetricGroup": "Default;TopDownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "backend_bound"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x201d@ / CPU_CYCLES",
> >          "PublicDescription": "Fetch latency bound L2 topdown metric",
> >          "BriefDescription": "Fetch latency bound L2 topdown metric",
> > -        "MetricGroup": "TopDownL2",
> > +        "MetricGroup": "TopdownL2",
> >          "MetricName": "fetch_latency_bound"
> >      },
> >      {
> >          "MetricExpr": "frontend_bound - fetch_latency_bound",
> >          "PublicDescription": "Fetch bandwidth bound L2 topdown metric",
> >          "BriefDescription": "Fetch bandwidth bound L2 topdown metric",
> > -        "MetricGroup": "TopDownL2",
> > +        "MetricGroup": "TopdownL2",
> >          "MetricName": "fetch_bandwidth_bound"
> >      },
> >      {
> >          "MetricExpr": "(bad_speculation * BR_MIS_PRED) / (BR_MIS_PRED + armv8_pmuv3_0@event\\=0x2013@)",
> >          "PublicDescription": "Branch mispredicts L2 topdown metric",
> >          "BriefDescription": "Branch mispredicts L2 topdown metric",
> > -        "MetricGroup": "TopDownL2",
> > +        "MetricGroup": "TopdownL2",
> >          "MetricName": "branch_mispredicts"
> >      },
> >      {
> >          "MetricExpr": "bad_speculation - branch_mispredicts",
> >          "PublicDescription": "Machine clears L2 topdown metric",
> >          "BriefDescription": "Machine clears L2 topdown metric",
> > -        "MetricGroup": "TopDownL2",
> > +        "MetricGroup": "TopdownL2",
> >          "MetricName": "machine_clears"
> >      },
> >      {
> >          "MetricExpr": "(EXE_STALL_CYCLE - (MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@)) / CPU_CYCLES",
> >          "PublicDescription": "Core bound L2 topdown metric",
> >          "BriefDescription": "Core bound L2 topdown metric",
> > -        "MetricGroup": "TopDownL2",
> > +        "MetricGroup": "TopdownL2",
> >          "MetricName": "core_bound"
> >      },
> >      {
> >          "MetricExpr": "(MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@) / CPU_CYCLES",
> >          "PublicDescription": "Memory bound L2 topdown metric",
> >          "BriefDescription": "Memory bound L2 topdown metric",
> > -        "MetricGroup": "TopDownL2",
> > +        "MetricGroup": "TopdownL2",
> >          "MetricName": "memory_bound"
> >      },
> >      {
> >          "MetricExpr": "(((L2I_TLB - L2I_TLB_REFILL) * 15) + (L2I_TLB_REFILL * 100)) / CPU_CYCLES",
> >          "PublicDescription": "Idle by itlb miss L3 topdown metric",
> >          "BriefDescription": "Idle by itlb miss L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "idle_by_itlb_miss"
> >      },
> >      {
> >          "MetricExpr": "(((L2I_CACHE - L2I_CACHE_REFILL) * 15) + (L2I_CACHE_REFILL * 100)) / CPU_CYCLES",
> >          "PublicDescription": "Idle by icache miss L3 topdown metric",
> >          "BriefDescription": "Idle by icache miss L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "idle_by_icache_miss"
> >      },
> >      {
> >          "MetricExpr": "(BR_MIS_PRED * 5) / CPU_CYCLES",
> >          "PublicDescription": "BP misp flush L3 topdown metric",
> >          "BriefDescription": "BP misp flush L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "bp_misp_flush"
> >      },
> >      {
> >          "MetricExpr": "(armv8_pmuv3_0@event\\=0x2013@ * 5) / CPU_CYCLES",
> >          "PublicDescription": "OOO flush L3 topdown metric",
> >          "BriefDescription": "OOO flush L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "ooo_flush"
> >      },
> >      {
> >          "MetricExpr": "(armv8_pmuv3_0@event\\=0x1001@ * 5) / CPU_CYCLES",
> >          "PublicDescription": "Static predictor flush L3 topdown metric",
> >          "BriefDescription": "Static predictor flush L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "sp_flush"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x1010@ / BR_MIS_PRED",
> >          "PublicDescription": "Indirect branch L3 topdown metric",
> >          "BriefDescription": "Indirect branch L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "indirect_branch"
> >      },
> >      {
> >          "MetricExpr": "(armv8_pmuv3_0@event\\=0x1013@ + armv8_pmuv3_0@event\\=0x1016@) / BR_MIS_PRED",
> >          "PublicDescription": "Push branch L3 topdown metric",
> >          "BriefDescription": "Push branch L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "push_branch"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x100d@ / BR_MIS_PRED",
> >          "PublicDescription": "Pop branch L3 topdown metric",
> >          "BriefDescription": "Pop branch L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "pop_branch"
> >      },
> >      {
> >          "MetricExpr": "(BR_MIS_PRED - armv8_pmuv3_0@event\\=0x1010@ - armv8_pmuv3_0@event\\=0x1013@ - armv8_pmuv3_0@event\\=0x1016@ - armv8_pmuv3_0@event\\=0x100d@) / BR_MIS_PRED",
> >          "PublicDescription": "Other branch L3 topdown metric",
> >          "BriefDescription": "Other branch L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "other_branch"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x2012@ / armv8_pmuv3_0@event\\=0x2013@",
> >          "PublicDescription": "Nuke flush L3 topdown metric",
> >          "BriefDescription": "Nuke flush L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "nuke_flush"
> >      },
> >      {
> >          "MetricExpr": "1 - nuke_flush",
> >          "PublicDescription": "Other flush L3 topdown metric",
> >          "BriefDescription": "Other flush L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "other_flush"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x2010@ / CPU_CYCLES",
> >          "PublicDescription": "Sync stall L3 topdown metric",
> >          "BriefDescription": "Sync stall L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "sync_stall"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x2004@ / CPU_CYCLES",
> >          "PublicDescription": "Rob stall L3 topdown metric",
> >          "BriefDescription": "Rob stall L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "rob_stall"
> >      },
> >      {
> >          "MetricExpr": "(armv8_pmuv3_0@event\\=0x2006@ + armv8_pmuv3_0@event\\=0x2007@ + armv8_pmuv3_0@event\\=0x2008@) / CPU_CYCLES",
> >          "PublicDescription": "Ptag stall L3 topdown metric",
> >          "BriefDescription": "Ptag stall L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "ptag_stall"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x201e@ / CPU_CYCLES",
> >          "PublicDescription": "SaveOpQ stall L3 topdown metric",
> >          "BriefDescription": "SaveOpQ stall L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "saveopq_stall"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x2005@ / CPU_CYCLES",
> >          "PublicDescription": "PC buffer stall L3 topdown metric",
> >          "BriefDescription": "PC buffer stall L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "pc_buffer_stall"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x7002@ / CPU_CYCLES",
> >          "PublicDescription": "Divider L3 topdown metric",
> >          "BriefDescription": "Divider L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "divider"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x7003@ / CPU_CYCLES",
> >          "PublicDescription": "FSU stall L3 topdown metric",
> >          "BriefDescription": "FSU stall L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "fsu_stall"
> >      },
> >      {
> >          "MetricExpr": "core_bound - divider - fsu_stall",
> >          "PublicDescription": "EXE ports util L3 topdown metric",
> >          "BriefDescription": "EXE ports util L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "exe_ports_util"
> >      },
> >      {
> >          "MetricExpr": "(MEM_STALL_ANYLOAD - MEM_STALL_L1MISS) / CPU_CYCLES",
> >          "PublicDescription": "L1 bound L3 topdown metric",
> >          "BriefDescription": "L1 bound L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "l1_bound"
> >      },
> >      {
> >          "MetricExpr": "(MEM_STALL_L1MISS - MEM_STALL_L2MISS) / CPU_CYCLES",
> >          "PublicDescription": "L2 bound L3 topdown metric",
> >          "BriefDescription": "L2 bound L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "l2_bound"
> >      },
> >      {
> >          "MetricExpr": "MEM_STALL_L2MISS / CPU_CYCLES",
> >          "PublicDescription": "Mem bound L3 topdown metric",
> >          "BriefDescription": "Mem bound L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "mem_bound"
> >      },
> >      {
> >          "MetricExpr": "armv8_pmuv3_0@event\\=0x7005@ / CPU_CYCLES",
> >          "PublicDescription": "Store bound L3 topdown metric",
> >          "BriefDescription": "Store bound L3 topdown metric",
> > -        "MetricGroup": "TopDownL3",
> > +        "MetricGroup": "TopdownL3",
> >          "MetricName": "store_bound"
> >      }
> >  ]
> >   

