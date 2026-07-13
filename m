Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1F3B3BF1;
	Mon, 13 Jul 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931622; cv=none; b=OrjhG1q4sv1lVD6sngeS0wczAFDJa0TYgukZlS0fPLxiyeAkvMVMYBb3bwp+EsjF2ZB/ADBLaPzF6OhQQ+xQSbG7c3PVBFPvYuNcYHHpvkVbOChDuNd65D3HBpCVsML2X+Ya7DDHNVDHcUjxbVXRkwfChseyVhj0s4yNGWIwCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931622; c=relaxed/simple;
	bh=/kmQ6nX1x9XecdGPLCdGgXcUKCfODdy7o0FiL7JzYQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pefH5ahx472elU41InUfCfvg8vxq70UjZSriUF12xcNLr/20j2iskShrbNgPWnMkPNQPhnNuiTmHeVp4Xg8pw4vRBJPklWkFnr6pBSZdwu29eE3wOupUKpN5UgXraMLuq4ZKm1Y4q0rd5nLYeAm9YxfSsDzmokptNAoN8p+nzIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYyeIPUB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYyeIPUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783931618; x=1815467618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/kmQ6nX1x9XecdGPLCdGgXcUKCfODdy7o0FiL7JzYQE=;
  b=OYyeIPUBIIlC1P6TCUKUUpR9NJh0ARv7i7DP99rsWX6MnfLcZzK8AVyW
   oz4YIeehpLFuxrKWQN3mSKqaKYYlSyWIjNw5lKdjZ6qcd9L01uLWq/lri
   WCPcM8w5F7me/KBkCFtmLCcnZY8lYw+dUD/Z+7rXJitEk7qNY/kyHjxAA
   42HIwvu2Jfhq1HCC6BimdJxVhRDp5DZi/yR1iVh34ipFghF/mXgzYmIn4
   v772kAhYiFu/7vJ3I//duhBUY4n6OlBdQ8gBPQwHNdOJtt7KatLs8mN3f
   3hmGrBJVbpvnNEfjG6ix7BmU+ZbzOCHo0H3uJEsFIV9j6+zaO8+YPDCa3
   w==;
X-CSE-ConnectionGUID: hgLsQaFZRoOBrB78Uz3KcQ==
X-CSE-MsgGUID: fmwmS2K5SuOELmvf8ysaYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390093"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390093"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 01:33:37 -0700
X-CSE-ConnectionGUID: uHBWmmtyRgqkB1d/1mxMuw==
X-CSE-MsgGUID: yEV4ZLQpTEGSXUPeW4r6NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255560761"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 01:33:33 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 4/7] perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
Date: Mon, 13 Jul 2026 16:27:31 +0800
Message-Id: <20260713082734.3162099-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_cpu_prepare() allocates per-CPU perf state first and then sets
up the arch PEBS buffer. If alloc_arch_pebs_buf_on_cpu() fails,
the previously allocated cpuc resources are left behind.

Make the failure path call intel_cpuc_finish(cpuc) to release the per-CPU
state allocated by intel_cpuc_prepare().

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a991fc4f1575..b47d2f00ac13 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5924,13 +5924,20 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 
 static int intel_pmu_cpu_prepare(int cpu)
 {
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	int ret;
 
-	ret = intel_cpuc_prepare(&per_cpu(cpu_hw_events, cpu), cpu);
+	ret = intel_cpuc_prepare(cpuc, cpu);
 	if (ret)
 		return ret;
 
-	return alloc_arch_pebs_buf_on_cpu(cpu);
+	ret = alloc_arch_pebs_buf_on_cpu(cpu);
+	if (ret) {
+		intel_cpuc_finish(cpuc);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void flip_smm_bit(void *data)
-- 
2.34.1

