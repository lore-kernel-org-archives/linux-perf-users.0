Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE43B2FF7;
	Mon, 13 Jul 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931619; cv=none; b=PuWdJ9xIU3LdIUlXRS8JJsGUZEQYuoKiAaFAZWmhgSaCkKojxtWbax9Ceh0xE/5vDtwBbQrzi8jxv7PydvStOYJSV5Nf5bsBEmUE3HjLjoQgE2GVyKlrEsNXufpAlRRIY8DNV6OlOWsR5sQ1yJPydq81KBCGa947dvwXZX/j4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931619; c=relaxed/simple;
	bh=9xbJSv1SMk/1yXM8aWvs+76XrC+eEQsJ0ouuPohqP3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBjmJQfMDdhk0g20U+bbzo6tuuu12eYsNieO+6pjIkoRMBs0qa130wyyYM23ZvQSupY0vgy+Ija3v3YJJRdfoGclmthqJ3agnmZ9mjNWEQ8ioVnGl03vfodT3F2Xe5V/ZbQoXHxzRdH97RZpsuu6ouwjfGH3LJ+52VojThGPqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAf7MpKd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAf7MpKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783931615; x=1815467615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9xbJSv1SMk/1yXM8aWvs+76XrC+eEQsJ0ouuPohqP3Y=;
  b=UAf7MpKdcR69SN3S1WlhRRSYqE8bAgb5Vhy5SkwRNEHw71q2D5Lgc7hc
   rPd3OcYDgcnQDp1+ByYEII+wkoY/deNLhXNOMa4XijGd0WQWpeFZTIf4y
   22qXfHV9p7Xowgnn2Cyqj9ur8jk5vTpesaRVDoYy+eidsLH110DqAFjRg
   4ZUz638m1WXl2ERlRireQQn+f4uBdVI6TgIt6p3zm4lbE06quai2iNmlC
   0yotcjrRwFACkk8tqu4elFJa9i9FE+2g8WFHKwshxHb0XVSt1Jatoit/k
   kb+EFEOomNXoMq/+mrZQU0yvPQ4cJuw3fIEf63SnPDgDqz8auTdSy5zDY
   g==;
X-CSE-ConnectionGUID: Aff13TKHRoC3mvryP0S7pg==
X-CSE-MsgGUID: fcts9QwwT4qbny5gLNMbXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390088"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390088"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 01:33:34 -0700
X-CSE-ConnectionGUID: uqKxKKhQQ/yZnFNoEBMQCw==
X-CSE-MsgGUID: ETVMkzDqRISHzo4kl6TYtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255560756"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 01:33:30 -0700
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
Subject: [Patch v2 3/7] perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
Date: Mon, 13 Jul 2026 16:27:30 +0800
Message-Id: <20260713082734.3162099-4-dapeng1.mi@linux.intel.com>
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

In failure paths, cpuc->pmu can still point to the global static pmu
instead of an embedded x86_hybrid_pmu::pmu. Calling hybrid_pmu() on
that pointer causes an invalid container conversion and may lead to
out-of-bounds access.

This can happen in at least two cases:
- init_hybrid_pmu() fails check_hw_exists() and leaves cpuc->pmu as-is.
- CPU hotplug fails between CPUHP_PERF_X86_PREPARE and
CPUHP_AP_PERF_X86_STARTING, and rollback invokes intel_pmu_cpu_dead().

Fix both paths by:
- Clear cpuc->pmu to NULL when check_hw_exists() fails.
- Validat that cpuc->pmu is not the global static pmu before calling
  hybrid_pmu() in intel_pmu_cpu_dead().

A new helper x86_get_static_pmu() is added to get the global static pmu.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 5 +++++
 arch/x86/events/intel/core.c | 7 +++++--
 arch/x86/events/perf_event.h | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6c63b27e11e6..a02f303a9151 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -790,6 +790,11 @@ int is_x86_event(struct perf_event *event)
 	return false;
 }
 
+inline struct pmu *x86_get_static_pmu(void)
+{
+	return &pmu;
+}
+
 struct pmu *x86_get_pmu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b39c6ce0efb5..a991fc4f1575 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6329,8 +6329,10 @@ static bool init_hybrid_pmu(int cpu)
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
-	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask))
+	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask)) {
+		cpuc->pmu = NULL;
 		return false;
+	}
 
 	pr_info("%s PMU driver: ", pmu->name);
 
@@ -6475,11 +6477,12 @@ void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 static void intel_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	struct pmu *pmu = x86_get_static_pmu();
 
 	release_arch_pebs_buf_on_cpu(cpu);
 	intel_cpuc_finish(cpuc);
 
-	if (is_hybrid() && cpuc->pmu)
+	if (is_hybrid() && cpuc->pmu && cpuc->pmu != pmu)
 		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a8afea8d38f0..01ae287cde16 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1161,6 +1161,7 @@ static struct perf_pmu_format_hybrid_attr format_attr_hybrid_##_name = {\
 	.pmu_type	= _pmu,						\
 }
 
+struct pmu *x86_get_static_pmu(void);
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
-- 
2.34.1

