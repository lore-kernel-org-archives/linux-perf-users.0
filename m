Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249210;
	b=WPkmmQ5hB6KO5clUefRsL/8Gb4N27d7BXjvWUp95iaJhIxTUIkj6ZN4sn/vPiL1E/+u6
	 ATuSjM3pf9p9tw8QLcS2tlRh9JyPEDUDAvPGe7ijfsuJWPxe9c3kahemsILOxYgHxDemh
	 DXdwFUNIYe5GZ0FX8WJF45ybfNLdGkG0hCyfAlaFSIkVLI8n5UdWvoLSqje8i/0+kv4lG
	 I5VgNGB7ucJBXLLEsFYGqU+3NgfsarF3PA2iuzKHm3Yh2QQj4tpA0lC5Jjvl0QVpYcjRk
	 UWDsEkgt5V9ERGNw0ph7rTjrF2kSXXBlFa+qDLZ4VvZiwwizf1HHC2c7RVp+UI3N+OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249210;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WU/+lH8yaeQcAN1uIlOR4c7LdrYbWyu0ZaRDjKuub5s=;
	b=SBpX6Yq+eJ+kb2kdWIzzmt+vp1nKsvIFOip1VWL5PMoa5YxaWI0bmQiY8YKe3WYOcih8
	 Kzl4GoKJLrzGa3Tl2AsCrljiRBuUfZ7U8YBGS3QfZhyWy7Y325ZgLepf5gJ7kc7FKRoCZ
	 SuS0COafM9LY6sX6tL85zox5a3MUTrKi/aJ3Bfb0ZiGqHa1SeEzREBCD0lfIshknrGiI8
	 UG6+NRskyLtiZ2y7pX6KeFKmD461xokElZzw4m3oyFMAgKhtas+GnXJYc1A2ipWTM9e98
	 X6pyy5jYdgr8UBzTuAG2TFFb/fjCFkE1mAYfsg5Trg773hoY2ZXlaJG/br2oK5AWo7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E6Dec+SY;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D38606A322;
	Thu, 29 Oct 2026 04:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D38606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E6Dec+SY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249210; x=1824785210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgZRBVXSDLgAalgpg4Xy5bjRZp2kn1Z3WQGVthT7eSo=;
  b=E6Dec+SYHaRQiDou5V5vlvLlbBHiNA/k+HUj594MvksfcnWWp/gM2G1E
   Fa3ixdC5C30d5h6VpfKX59C/iu+UNwOmRWwJd+T0MUAYAcSHW9BCmggEK
   weogOFOeaz7UZFKNMmn1VlbfHRUfsec4md+1E77g0xQPX6num0Cy9gHMO
   m+Nm6H4BG3PO4lz7hAdygFv9Xd2GJ/FI1D+vz2SzXCnElX8ruDAvHVeBZ
   ZfCjXCJVxvaUFhxK2gmDh9Jh4srGnFekixFIYZUMch4F2i8yZ90/EU6Qs
   C80yLt3kHhthXDon8SDuF+vGxMV1N3XQvyqt20Anmz4fHMgC+5aYGAiRt
   g==;
X-CSE-ConnectionGUID: NuJQKOy2S/eruia+1aEiKw==
X-CSE-MsgGUID: 7Iyt7If8Rq6+J+3Ye3LlBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986248"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986248"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:46:50 -0700
X-CSE-ConnectionGUID: xoig1mU5Sy+lxe+NE+S5Cw==
X-CSE-MsgGUID: 7NJFKUziQnGjZocVGzrxIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420288"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:46:46 -0700
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
Subject: [Patch v5 02/18] perf/x86/intel: Validate LBR XSAVE state before updating LBR stack
Date: Thu, 29 Oct 2026 12:38:58 +0800
Message-Id: <20261029043914.1395147-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
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

