Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E331AA9B;
	Mon, 12 Jan 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214500; cv=none; b=VoZxc5UPANbRmPQqmv2lJmoc0vg4wd0AhGdxAgj6cWbwPWIPyM4u6sKg0x9MDJbZNj+B0eXCKdDkrd0DD1smpFMN/w9wL3EHCN7jfm0vb5sQQoLPaDQH0G/fyYHxQGAeIZIfdRv9Qfg1CEt4prZIasIpMZp1AuzXFG+Q3IFKL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214500; c=relaxed/simple;
	bh=HD/MkefP0pRRSt9O4UNZB1r06SLtIq2oyq9pcwuTblw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcShrzudheUylTTbRZ0MX9IkYV6yTqBV1+zjWD73qYBiz3SFEtNow2vmfGMqyqGulx2LYyl9whMB4X7cCC4XZ0/PZaCOE4Tmy+ZVmbp2RBEngSOqq/oo01wFzJJP36u1DgU+APFfFuJALF9b0so1esuXDDLVnr8/1DKK+b0ha7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G4692o1X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4692o1X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5blHbByQ8+HGNJIDcjdSLJb6lJUU22Kg8goIos1AWnY=; b=G4692o1XBO5o4fahg7mWTZC3TT
	wO8xvYgXUb3LkTFKN5QfryhD/3RferR46FKsBBUHV2ozedQKCYKA1IQQmBP/ewNfzfUx0rgh7Uevn
	X2hY/8gpvBoHZAExVa6KjRQpO6RszpDHJocJhA8Gtdmt/6v0mCHr3PLu8llZgwXMTkxtD7QZz44+V
	6xwniblYHzEtG6s4w8XhedcQj6sykA3OCnVSnyU7BHY1KXOZb+Rhi3QzIjsoYSKmO5U3gJ9mMODVl
	X3bswJe8SZZXV+v5KK9bw3aDfjkrDwqsTOjeLvyEWEavPADlcRi83SNux0A2X4ypdgw3NmnWaRI23
	a07F3ZRQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFMa-000000036eh-2Nno;
	Mon, 12 Jan 2026 10:41:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7375130057E; Mon, 12 Jan 2026 11:41:31 +0100 (CET)
Date: Mon, 12 Jan 2026 11:41:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v2 3/7] perf/x86/intel: Add core PMU support for DMR
Message-ID: <20260112104131.GF830755@noisy.programming.kicks-ass.net>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112051649.1113435-4-dapeng1.mi@linux.intel.com>

On Mon, Jan 12, 2026 at 01:16:45PM +0800, Dapeng Mi wrote:
> @@ -7906,6 +8072,22 @@ __init int intel_pmu_init(void)
>  		intel_pmu_pebs_data_source_skl(true);
>  		break;
>  
> +	case INTEL_DIAMONDRAPIDS_X:
> +		intel_pmu_init_pnc(NULL);
> +		x86_pmu.pebs_ept = 1;
> +		x86_pmu.hw_config = hsw_hw_config;
> +		x86_pmu.pebs_latency_data = pnc_latency_data;
> +		x86_pmu.get_event_constraints = glc_get_event_constraints;
> +		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
> +			hsw_format_attr : nhm_format_attr;
> +		extra_skl_attr = skl_format_attr;
> +		mem_attr = glc_events_attrs;
> +		td_attr = glc_td_events_attrs;
> +		tsx_attr = glc_tsx_events_attrs;
> +		pr_cont("Panthercove events, ");
> +		name = "panthercove";
> +		break;
> +
>  	case INTEL_ALDERLAKE:
>  	case INTEL_ALDERLAKE_L:
>  	case INTEL_RAPTORLAKE:

Does something like so make sense?


--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -8066,6 +8066,9 @@ __init int intel_pmu_init(void)
 
 	glc_common:
 		intel_pmu_init_glc(NULL);
+		intel_pmu_pebs_data_source_skl(true);
+	
+	glc_base:
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = glc_get_event_constraints;
@@ -8075,24 +8078,14 @@ __init int intel_pmu_init(void)
 		mem_attr = glc_events_attrs;
 		td_attr = glc_td_events_attrs;
 		tsx_attr = glc_tsx_events_attrs;
-		intel_pmu_pebs_data_source_skl(true);
 		break;
 
 	case INTEL_DIAMONDRAPIDS_X:
-		intel_pmu_init_pnc(NULL);
-		x86_pmu.pebs_ept = 1;
-		x86_pmu.hw_config = hsw_hw_config;
-		x86_pmu.pebs_latency_data = pnc_latency_data;
-		x86_pmu.get_event_constraints = glc_get_event_constraints;
-		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
-			hsw_format_attr : nhm_format_attr;
-		extra_skl_attr = skl_format_attr;
-		mem_attr = glc_events_attrs;
-		td_attr = glc_td_events_attrs;
-		tsx_attr = glc_tsx_events_attrs;
 		pr_cont("Panthercove events, ");
 		name = "panthercove";
-		break;
+		intel_pmu_init_pnc(NULL);
+		x86_pmu.pebs_latency_data = pnc_latency_data;
+		goto glc_base;
 
 	case INTEL_ALDERLAKE:
 	case INTEL_ALDERLAKE_L:
