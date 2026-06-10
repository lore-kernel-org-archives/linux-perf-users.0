Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748C3749EB;
	Wed, 10 Jun 2026 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079405; cv=none; b=CPzgpF8H8Uq7Z0ozN+98ZXdoiG8oTw5US5ao/0y8WTtrwb8hj3vBrfaSG3uwWxcJmXLEPAGoqs0ER1Mxq2XXIamYtGlN7gmWgOUPpt8u0cERjkE27RMp7h8ojyeyOtt1De4Kj/9pwgF0nXbunVk1DRfHptMPZ7hrB6HV5zmufFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079405; c=relaxed/simple;
	bh=HbUyVE8smbQ6HvGgO/NiV72DjYqXhG9ylJkoHKn9K4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQgHvLL1we0oqR+Xs+DXz+FpuQj9/Yvd0URBevRapjrC5xnc83tMxjdw9ptTL/L17+nE0rKDvCu5sKf4TSMkrGs7xfnTPGaMD25aek2D2YXImyFLyKdbj66hzshBfrlFfWJtLrBWYjmcNy8lbF7x3FPv1uAIWH3i6X/R9mUB7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qhkjdQY3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhkjdQY3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hPEpx155or2Dr2bQ+ZhsunDFyYCKr4o5e0V5+MuLbj4=; b=qhkjdQY30pBb+ibjyh+JaMGRu5
	e7qNITjqBdtQNKbxBra7pm1KhFGvdTSZHUnGpYaUX2ue/GNX8nrfyQG8320NVGWGoGGFibA41pAFw
	wvg8VcpCsm3Vz3LgUrGshnsG+5QoPBePGhHD1Ugv7MeQDmRlmb1xMX26+mEoINLsky+gaWOSgYdqT
	YSOToaGgVKXdQV/0qPD0+pa5uFv6mVTqzXRIjscaslfjSeDA4XCt8Cx64uvW19XtMYoGXkb0pgyR/
	yU2settQyYsFaVekBhT9iWN81G+VCXUkG5AHM6FZszRJuf/1Y/7PFvd3nJQXptJpGlt43YPqLuJwK
	J5LrWyTw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXE6p-00000003bfJ-2zu4;
	Wed, 10 Jun 2026 08:16:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08257302FEF; Wed, 10 Jun 2026 10:16:22 +0200 (CEST)
Date: Wed, 10 Jun 2026 10:16:21 +0200
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
Subject: Re: [Patch v2 6/9] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
Message-ID: <20260610081621.GE49951@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609050222.2458129-7-dapeng1.mi@linux.intel.com>


Would not something like so work?

I could not find a reason we *have* to init arch lbr that early -- but
perhaps I didn't look hard enough?

---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d9488ade0f8e..4e551f240b2b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7534,14 +7534,14 @@ __init int intel_pmu_init(void)
 	struct attribute **td_attr    = &empty_attrs;
 	struct attribute **mem_attr   = &empty_attrs;
 	struct attribute **tsx_attr   = &empty_attrs;
+	struct x86_hybrid_pmu *pmu;
+	unsigned int fixed_mask;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
-	unsigned int fixed_mask;
+	int version, i, ret;
 	bool pmem = false;
-	int version, i;
 	char *name;
-	struct x86_hybrid_pmu *pmu;
 
 	/* Architectural Perfmon was introduced starting with Core "Yonah" */
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
@@ -7611,9 +7611,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		intel_pmu_arch_lbr_init();
-
 	intel_pebs_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
@@ -8216,7 +8213,9 @@ __init int intel_pmu_init(void)
 		 *
 		 * Initialize the common PerfMon capabilities here.
 		 */
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = grt_latency_data;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
@@ -8274,7 +8273,9 @@ __init int intel_pmu_init(void)
 	case INTEL_METEORLAKE:
 	case INTEL_METEORLAKE_L:
 	case INTEL_ARROWLAKE_U:
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8313,7 +8314,9 @@ __init int intel_pmu_init(void)
 		name = "lunarlake_hybrid";
 
 	lnl_common:
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = lnl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8337,7 +8340,9 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_ARROWLAKE_H:
-		intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		ret = intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = arl_h_latency_data;
 		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
@@ -8371,7 +8376,9 @@ __init int intel_pmu_init(void)
 	case INTEL_NOVALAKE_L:
 		pr_cont("Novalake Hybrid events, ");
 		name = "novalake_hybrid";
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret  = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = nvl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8478,6 +8485,9 @@ __init int intel_pmu_init(void)
 
 	intel_pmu_check_event_constraints_all(NULL);
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
+		intel_pmu_arch_lbr_init();
+
 	/*
 	 * Access LBR MSR may cause #GP under certain circumstances.
 	 * Check all LBR MSR here.
