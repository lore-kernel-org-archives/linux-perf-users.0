Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8C3B27DB;
	Fri, 10 Jul 2026 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666674; cv=none; b=mtkMZjj7HRKsjMf+LNgRLzVkM/RqpBHx7lPzYIqJMBAFnCqmSSsUyphRAa0G6UHyT/s6g+vIYnY7g1T517SEeir9BXyG+CrFTxFTzzcjDyHO2CGB1afx5uavW7wpcas+kyGNKTABZurXk284e8+EbMdA1opNGmInlrwqa1XSyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666674; c=relaxed/simple;
	bh=6/pA+PVlZBzij4PGw1hsx6W3ULClJwrF+OAopxWssSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVhXS0biKiyQBUsionDcx8wqEqtVVFyK8IK6V0ogk+mhhD6z+mjFJj+Ag7VdO56EQQGAbYIBMCyUzWHugi+K36sIanYyl4VAAwr5ztScW9uFds3vfzte1zjmJ6QE7KlPx9XEAwS3vkFi0nKdAoNsVtyV6YRlVCj8YNSRnqLCUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKNqzCPw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKNqzCPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666672; x=1815202672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/pA+PVlZBzij4PGw1hsx6W3ULClJwrF+OAopxWssSU=;
  b=eKNqzCPwogV7cazPj0+vp6fsfuk1xv6j1Ca39BsgWF/fZNRdoZYKfrDL
   AyQHmRyY8MJLEX1B0N95I0bjTYht9t6hvv1zdUSUfOCCM3oNHnyr0E0yh
   z/43/a7VBmn0i2eINCjygasstVFlM4iQ+bpTuD7tC+BDXL7CrgCgdv4Z4
   SGjzG/IW5eQ6Dp6hqDewYeS6gxWh3SNG6T/IyftCYkdsFt5nNK5IhvKEq
   W0wVLko4H9EmLQVEVPkDYxkQMqwchlr44YiHsDGritryKybt1qxMgc3rd
   5yB2mOEELQh9zjDDVXQWkNuquCqtdQrO4r9AYuvq4ZRoh0O7M09VUkX9y
   w==;
X-CSE-ConnectionGUID: X8sXAg3pQSSPHawhxVjg8A==
X-CSE-MsgGUID: SeWR82L7QiWUrG9Gsdufgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554215"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554215"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:57:51 -0700
X-CSE-ConnectionGUID: ssU8JN91S+i6jZQQVW3KMQ==
X-CSE-MsgGUID: WctfkNZ8QVirMngrV4G7wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159213"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:46 -0700
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
Subject: [PATCH 4/7] perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
Date: Fri, 10 Jul 2026 14:51:25 +0800
Message-Id: <20260710065128.1799838-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
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
index 9d4774278b50..737c5a070379 100644
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

