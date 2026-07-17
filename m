Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3C3E0C4F;
	Fri, 17 Jul 2026 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275809; cv=none; b=T6/kiz0oOgyF7b6kxHsbhb2UgN3oE1izzozg+kKgq89LjXh8Rztl2a0tw92g9F2ISdcjTWY+VOSQF90AcJYzHCRPlfVJW4zvAYIo8Ib0hQMK4ZA4ef8QP1Sf6mzp4MClrn+rfdl15qOIWediLMO1Vj1l2ULSxwdrq+pxgawCGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275809; c=relaxed/simple;
	bh=8fiYiM+Sjbpu3hg1mInSZ2lfu0AMkNALh66sKTZNISc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCKP2YQYt0UH8OtoPFagQUdJZKqPFcOgEwARb6nmaSjk0DLbWBBMHXW6gLo7R1XPuT95ayW3sMrEbiDb25JCeYHf2JVjjkklMz/y2xM7t/pUzrEFw60VlwCT3Ni+NawYtS8nnwMfrUNwEs27WUR0MoJ8pswhbsJ24OZVmVDw3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iK8nWuBv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iK8nWuBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275809; x=1815811809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fiYiM+Sjbpu3hg1mInSZ2lfu0AMkNALh66sKTZNISc=;
  b=iK8nWuBv6/WjEzH5gONw1aXxs0iSMU0hL6v2NKngMqI1XrjGPulxHQNx
   0Jl8KQ2zj+lAlWBdpQ7z9h6zt2GvKJdh9+Abl3XZtCVjqxnliF/sKXBCT
   yGhiy0Br5MJRGcdz3CB6yXHJZt+5qPzy5pBn+MXYlfpTJgPimstQG0xjo
   ZIrizHrrPZX6r8ShM4Jq/hPlNPFCV4nvRIR0UcWgSd8vjzTT35M+1Dl8d
   IdV1AtarHDGQZK0uzUUt3+5o58MaNxYVAglWdRkj1OKD/iqtYHcO6DWJ8
   SMDHYiflyuGkbKWwBHuEfRi7DlESGpb/PWF+OsuikAyI7a8TWhbwzuPbA
   Q==;
X-CSE-ConnectionGUID: 2aB1KKVaRmaiJ+bQH8lLiQ==
X-CSE-MsgGUID: xemAsrvvT+mOjHvXqM/smA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065511"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065511"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:08 -0700
X-CSE-ConnectionGUID: /hYu39P6Q2uJPcwuqeBlMw==
X-CSE-MsgGUID: YbnbSQLERZWdtDDx2vFkAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315472"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:10:04 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 4/8] perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
Date: Fri, 17 Jul 2026 16:03:38 +0800
Message-Id: <20260717080342.1879573-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
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
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
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

