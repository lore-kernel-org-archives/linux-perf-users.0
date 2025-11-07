Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B02D7DFB;
	Fri,  7 Nov 2025 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480045; cv=none; b=F6Ez29c8OKzetR/iBiWLQDZ7w8+MDRAJuNkeG9HJqoLz+nCC5T2v7T7yVkONPSvCH/nwP3O5QHfxk5P+RmtrKGJM7rKjyM80YIFYUypLzY6COb1OQdKmLQVxZ967QiSWYESq8zdTwtpJ1ur8jQp4+UqlzF0oCCHH1/2sbg0/gcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480045; c=relaxed/simple;
	bh=z+81QhvzdMj0gydU3u9K7LAH1toJQiw/zUrK/FYwljw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajdVQfPA0oS1WCz68jR2OjOnH7kyeXGM0BxIzc01nBRKQbC/jkKX8xn7RVXon7BLzNWbZga5+7SgD+DxXI2ZQ5HhL0VPJ08nenFF80AnKGPagB7TYsJTyrfah8EevJ32UEIZlon8KP2Zsb1Gz4c++svjdV5LNeeiXrsQ+K8V15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD7SploW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD7SploW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A97C4CEFB;
	Fri,  7 Nov 2025 01:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762480044;
	bh=z+81QhvzdMj0gydU3u9K7LAH1toJQiw/zUrK/FYwljw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HD7SploWbmhatVjZQ8r+tkxsKWb5KWR+PMDq3BP38S7GV/GlNmFyKvG0FvVSwiAUf
	 9LY0TRIQoIJ/pC9d0SX/nSETugSKOZxeFHV77RKTvDSjFMpWkyI+QorJnEbGMFlq2U
	 uN1/WBRLD8Y5b2NYqE7+FbfVO0Qnt1Tu1TbFKf1hRVXZU/wwbHFufNPIRSJgXF8b4/
	 1SEjUQsjWRpbxY/AgLb236c+MxCnfsNpZC3F+EF41360vZAjKL0BJZAHWL8DGJQ51N
	 OqN9eGRTnYsg4hsnoNQXEK+FpwjonFV8kd1UyU6R/p+FB2MMzScMrWvg7oIcu8YvyZ
	 L+eZ+AY4d4SYQ==
Date: Thu, 6 Nov 2025 17:47:19 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/5] perf vendor events arm64:: Add i.MX94 DDR
 Performance Monitor metrics
Message-ID: <aQ1Pp6GF6svXDXoy@google.com>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
 <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
 <wlziowwtfqbhzsltffm4l3pxntev3lgjan44wfixztnk3gw5d7@z2selm5eczsq>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <wlziowwtfqbhzsltffm4l3pxntev3lgjan44wfixztnk3gw5d7@z2selm5eczsq>

Hello,

On Tue, Nov 04, 2025 at 02:33:08PM +0800, Xu Yang wrote:
> Hi Namhyung,
> 
> Could you please take this one?

Yep, will add this patch to perf-tools-next soon.

Thanks,
Namhyung


> On Thu, Aug 21, 2025 at 07:01:51PM +0800, Xu Yang wrote:
> > Add JSON metrics for i.MX94 DDR Performance Monitor.
> > 
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > 
> > ---
> > Changes in v2:
> >  - add Rb tag
> > ---
> >  .../arch/arm64/freescale/imx94/sys/ddrc.json       |   9 +
> >  .../arch/arm64/freescale/imx94/sys/metrics.json    | 450 +++++++++++++++++++++
> >  2 files changed, 459 insertions(+)
> > 
> > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..aa7b58721dc7e23dc9d9905a79e0c1778b7bbf11
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> > @@ -0,0 +1,9 @@
> > +[
> > +   {
> > +           "BriefDescription": "ddr cycles event",
> > +           "EventCode": "0x00",
> > +           "EventName": "imx94_ddr.cycles",
> > +           "Unit": "imx9_ddr",
> > +           "Compat": "imx94"
> > +   }
> > +]
> > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..629f1f52761e2210ef43a9cbba175871817e1230
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> > @@ -0,0 +1,450 @@
> > +[
> > +	{
> > +		"BriefDescription": "bandwidth usage for lpddr5 evk board",
> > +		"MetricName": "imx94_bandwidth_usage.lpddr5",
> > +		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
> > +		"ScaleUnit": "1e2%",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bandwidth usage for lpddr4 evk board",
> > +		"MetricName": "imx94_bandwidth_usage.lpddr4",
> > +		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
> > +		"ScaleUnit": "1e2%",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of all masters read from ddr",
> > +		"MetricName": "imx94_ddr_read.all",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of all masters write to ddr",
> > +		"MetricName": "imx94_ddr_write.all",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of all a55 read from ddr",
> > +		"MetricName": "imx94_ddr_read.a55_all",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of all a55 write from ddr",
> > +		"MetricName": "imx94_ddr_write.a55_all",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 0 read from ddr",
> > +		"MetricName": "imx94_ddr_read.a55_0",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 0 write to ddr",
> > +		"MetricName": "imx94_ddr_write.a55_0",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 1 read from ddr",
> > +		"MetricName": "imx94_ddr_read.a55_1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 1 write to ddr",
> > +		"MetricName": "imx94_ddr_write.a55_1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 2 read from ddr",
> > +		"MetricName": "imx94_ddr_read.a55_2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 2 write to ddr",
> > +		"MetricName": "imx94_ddr_write.a55_2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 3 read from ddr",
> > +		"MetricName": "imx94_ddr_read.a55_3",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of a55 core 3 write to ddr",
> > +		"MetricName": "imx94_ddr_write.a55_3",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m7 core1 read from ddr",
> > +		"MetricName": "imx94_ddr_read.m7_1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m7 core1 write to ddr",
> > +		"MetricName": "imx94_ddr_write.m7_1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m33 core1 (in netc) read from ddr",
> > +		"MetricName": "imx94_ddr_read.m33_1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m33 core1 (in netc) write to ddr",
> > +		"MetricName": "imx94_ddr_write.m33_1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of pcie2 read from ddr",
> > +		"MetricName": "imx94_ddr_read.pcie2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of pcie2 write to ddr",
> > +		"MetricName": "imx94_ddr_write.pcie2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
> > +		"MetricName": "imx94_ddr_read.cortex_a_dsu",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
> > +		"MetricName": "imx94_ddr_write.cortex_a_dsu",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m33 core0 read from ddr",
> > +		"MetricName": "imx94_ddr_read.m33_0",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m33 core0 write to ddr",
> > +		"MetricName": "imx94_ddr_write.m33_0",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m7 core0 read from ddr",
> > +		"MetricName": "imx94_ddr_read.m7_0",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of m7 core0 write to ddr",
> > +		"MetricName": "imx94_ddr_write.m7_0",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of sentinel read from ddr",
> > +		"MetricName": "imx94_ddr_read.sentinel",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of sentinel write to ddr",
> > +		"MetricName": "imx94_ddr_write.sentinel",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of edma1 read from ddr",
> > +		"MetricName": "imx94_ddr_read.edma1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of edma1 write to ddr",
> > +		"MetricName": "imx94_ddr_write.edma1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of edma2 read from ddr",
> > +		"MetricName": "imx94_ddr_read.edma2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of edma2 write to ddr",
> > +		"MetricName": "imx94_ddr_write.edma2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of netc read from ddr",
> > +		"MetricName": "imx94_ddr_read.netc",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of netc write to ddr",
> > +		"MetricName": "imx94_ddr_write.netc",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of aonmix read from ddr",
> > +		"MetricName": "imx94_ddr_read.aonmix",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of aonmix write to ddr",
> > +		"MetricName": "imx94_ddr_write.aonmix",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of npumix read from ddr",
> > +		"MetricName": "imx94_ddr_read.npumix",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of npumix write to ddr",
> > +		"MetricName": "imx94_ddr_write.npumix",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usdhc1 read from ddr",
> > +		"MetricName": "imx94_ddr_read.usdhc1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usdhc1 write to ddr",
> > +		"MetricName": "imx94_ddr_write.usdhc1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usdhc2 read from ddr",
> > +		"MetricName": "imx94_ddr_read.usdhc2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usdhc2 write to ddr",
> > +		"MetricName": "imx94_ddr_write.usdhc2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usdhc3 read from ddr",
> > +		"MetricName": "imx94_ddr_read.usdhc3",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usdhc3 write to ddr",
> > +		"MetricName": "imx94_ddr_write.usdhc3",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of xspi read from ddr",
> > +		"MetricName": "imx94_ddr_read.xspi",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of xspi write to ddr",
> > +		"MetricName": "imx94_ddr_write.xspi",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of pcie1 read from ddr",
> > +		"MetricName": "imx94_ddr_read.pcie1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of pcie1 write to ddr",
> > +		"MetricName": "imx94_ddr_write.pcie1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usb1 read from ddr",
> > +		"MetricName": "imx94_ddr_read.usb1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usb1 write to ddr",
> > +		"MetricName": "imx94_ddr_write.usb1",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usb2 read from ddr",
> > +		"MetricName": "imx94_ddr_read.usb2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of usb2 write to ddr",
> > +		"MetricName": "imx94_ddr_write.usb2",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of pxp read from ddr",
> > +		"MetricName": "imx94_ddr_read.pxp",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of pxp write to ddr",
> > +		"MetricName": "imx94_ddr_write.pxp",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of dcif read from ddr",
> > +		"MetricName": "imx94_ddr_read.dcif",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	},
> > +	{
> > +		"BriefDescription": "bytes of dcif write to ddr",
> > +		"MetricName": "imx94_ddr_write.dcif",
> > +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
> > +		"ScaleUnit": "9.765625e-4KB",
> > +		"Unit": "imx9_ddr",
> > +		"Compat": "imx94"
> > +	}
> > +]
> > 
> > -- 
> > 2.34.1
> > 
