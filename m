Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940049;
	b=Gsyt51+RdpBglbfPm4hy+TMGwSGuVTXe9ZqFiDLZDApkIOJQga2K6oS5oVHtFQsoDgkl
	 JStN2u+nGOYODlKmMKj3IcI136ToMjjSqYyYavWBcMNZ4royeskeqlWQlG1thPfXfSEmB
	 Ufwj70QjyqT91gUsIjYs/QFMo0fqZdLhwUsy/mnSpXq59zuIpLELbcxYx6r10kPkpG7qn
	 h2wINdcgVN7XkFOeLTXypebRkzJK3SipRINuAjO3RthrGy7xipY0n0l63qoVLYVURx8i8
	 0Fdd/+tLHysSKBxTeeGjFx3U+tnZxi2zSdnBLAw3Vi6YvHdexOAZOzICOnbjPZFon0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940049;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WU/+lH8yaeQcAN1uIlOR4c7LdrYbWyu0ZaRDjKuub5s=;
	b=ABu5pCPEKfQORPQLd8K74HRMND/2gyvzFP4EfGlOSY1beq6jQbQuBVmQVgF9cavm91pu
	 4FXeB6575UuUHTzLKMKLtLb+qeTX++kf/Sz9zhM0+O8658x/O/1GNEHquck44NOfVIhrG
	 tRDpqcabtmekgX9Hr2vCsp43OHRvi+WODYA5AFHQIugNohJtADS3PLo9c2y0pZ5lz6exv
	 90oZBEHVORcG7wlBZJMwfPYIpAwTjoTneD8FZTQ6lPK4mCepQqXsE+fAbWxFBc3Cyc9hX
	 7p4NoMQNphenMmr3q5IuyZRSSG0Z5XPwzlLYm6JgYQafSm0DhKT0ca+jLmqBjdtYnqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kSTvYPLC;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6A606A339;
	Fri,  6 Nov 2026 04:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E6A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kSTvYPLC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940049; x=1825476049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgZRBVXSDLgAalgpg4Xy5bjRZp2kn1Z3WQGVthT7eSo=;
  b=kSTvYPLCJOH0+1ARcwdCEx3DJpX0gtaK2Cwa9L2V53zaW6fwgGeDbES6
   7KjUZ8ligJgXuPwqhxtXmwABXbpwgprB640pf6Ia3ZgNElc0h+Dpotcei
   GjVMVhnIZMoIr6yqcmDwFUde5P6BI2ZYpFJqj+jI7btv1yRxwhfDiAwGD
   90IYQe6DBlnxPCzgt/7llESVWI5OkovYRzHCpt5t6nUkUQA15f8I48vTB
   bBojxrUa+cAtakpbzxeP5H6AvxcPEfLLrwF3pTQ0/2dtwnGRnqlazlnUL
   xu3wigRm2syfRY7FvO7E7lNFZU7hZzX74j4o9sfLp2oBoFAvcxW4rJAxE
   g==;
X-CSE-ConnectionGUID: VCGGDDTwT6WsVxOtbMYYbQ==
X-CSE-MsgGUID: MSjamaC+QOiWtiatojD87w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780762"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780762"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:40:49 -0800
X-CSE-ConnectionGUID: cDZyYIm5R/msq9Dugjj59w==
X-CSE-MsgGUID: bg4xuKRVQ2WxiUfbpbXIGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222818"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:40:44 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 02/20] perf/x86/intel: Validate LBR XSAVE state before updating LBR stack
Date: Fri,  6 Nov 2026 12:32:39 +0800
Message-Id: <20261106043257.842864-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_arch_lbr_read_xsave() doesn't check if the LBR data is present
in the xsave area. If LBR data is in the INIT state, the LBR data may not
be really written into the xsave area.

Add an explicit LBR XSAVE state presence check before updating the cached
LBR stack. Also clear the cached LBR stack when intel_pmu_lbr_reset() is
called, in addition to resetting the hardware LBR register file, to prevent
stale LBR data from being reused after a context switch or similar
transition.

Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0b446d8912e4..a2e4ba7e1a4f 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -193,6 +193,8 @@ void intel_pmu_lbr_reset(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	cpuc->lbr_stack.nr = 0;
+
 	if (!x86_pmu.lbr_nr)
 		return;
 
@@ -1010,9 +1012,15 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
+	xsave->header.xfeatures = 0;
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
-	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	if (xsave->header.xfeatures & XFEATURE_MASK_LBR) {
+		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	} else {
+		/* Clear the LBR stack to avoid leaking stale entries. */
+		cpuc->lbr_stack.nr = 0;
+	}
 }
 
 void intel_pmu_lbr_read(void)
-- 
2.34.1

