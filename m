Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972202;
	b=28MArhTJibEer4pAjtQOiYmUdMC8k/g7XfYcOPi5PjoeAOSPYcXsgChr1CHAUcXzFkXJ
	 7zfXrkYLZJbjuIRAlZhByOeT4MByk7Nzx0fPVIR9auiyg5PtVanCmiN1uKki2u/29PJBN
	 U6GaNI73Cfc0D39PZybXMEfLgDvypdhZzQoTi7Mw7VLLgskVVq0rvzCz+AJ2HJ4oTEnPz
	 xeHIlTX9qTmvcwvt5wbPmoPahRWAT/MIiX5IV+K+riaszQv96qc8BZA2Skgz6ZkMbOghG
	 wzft0TRtg8ztmE4JVE1OyhCiEgyrrkMOXRf7soGo66ObUcwR8fP5pNL4OCGIKNBjpog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972202;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V+GRT8jmmR2U3WQugHms8GO9CFAw66uZfviPgj8Fkc4=;
	b=H8exJrr2MrQAExFDYU1FTZd9xVilu5aPa5pnBjSWaeWvlKPCM1lJWah4eBePMCQygP6a
	 4Cj+gCAg7KAH0YvIghgRlzhIatHo17Qt3SuCqsXZehDJsminBIhAgsuzHHMSHxIrNJlaV
	 9FNd5wqtxlEgwJvmVI3rIv6VuaUHZuhfrJF2e4PaW0v+XTFia5cULoVwkVR1nw2dvSzkK
	 BGYp8lUGXZs/gzEaZWYKOYd7YpGRuDCQcdBjNWalkghHVXSM0BJhmQX7Y5aq+UbqOsY15
	 GdxV40RHDDBnBd+tymEmNCrA3V1cNaFJNnO11FwE4Tiz5BJCqdP9puXswDyA6KUmGnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c57gXhmC;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCF606A334;
	Wed, 18 Nov 2026 03:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CCCF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c57gXhmC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972203; x=1826508203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7OgCwOWMH7Rv9ak/pARtImDYvl5rqIdloRm+k7LX1VE=;
  b=c57gXhmCjLYSNG8BdiK4+hJ0hvvF/uiDVw5T8UtvnElh6GP1AdI7dMjo
   jqBnDWllOQwQfP8S4GVyWwpIFDg+jfviyAZLqUqT6PMIqVL9uabZvXRTD
   b7zlo2dUP10kf8RPtCetw6SMmKA1G0d5CDB6rSL4VMjIJBsm5Cn4xPrYI
   UY6vRFolkHaV9X+a2e/2tSGbABtWz6/8S8ZmG0Ho57R9LqN68uTeI/g8R
   E0JQAyYHHLJhMi4CIdM6q44SWim0NQNd2dmsZAZLsy0bWLu19RdF7qXT+
   b5nbr58d74ZwfaEormGdh4W68FEdpijISlR2P+1Cd8TfWX8oaVudNwPYb
   Q==;
X-CSE-ConnectionGUID: rSGsTOLkRjmlDyomelwKkw==
X-CSE-MsgGUID: 6MofE8QdSw++BHGfgrvl0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629817"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629817"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:00 -0800
X-CSE-ConnectionGUID: QnfkzL9VQ+qCUnhMb5SBNw==
X-CSE-MsgGUID: 8mR/2qOITWK33ptx4iibyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894122"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:22:55 -0800
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
Subject: [Patch v7 02/24] perf/x86/intel: Validate LBR XSAVE state before updating LBR stack
Date: Wed, 18 Nov 2026 11:14:31 +0800
Message-Id: <20261118031453.1353625-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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

intel_pmu_arch_lbr_read_xsave() did not verify whether LBR data was
actually present in the XSAVE area. When the LBR state was in the INIT
state, the hardware might not have written valid data to the XSAVE
buffer, allowing stale or incomplete data to be cached.

Add an explicit presence check for the LBR XSAVE state before updating
the cached LBR stack. Also clear the cached LBR stack in
intel_pmu_lbr_reset() to prevent stale entries from being reused across
context switches and similar transitions.

Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0b446d8912e4..3d41385c4924 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -198,6 +198,7 @@ void intel_pmu_lbr_reset(void)
 
 	x86_pmu.lbr_reset();
 
+	cpuc->lbr_stack.nr = 0;
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) && cpuc->lbr_select)
@@ -1010,9 +1011,15 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
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

