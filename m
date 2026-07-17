Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304F3E00A5;
	Fri, 17 Jul 2026 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275806; cv=none; b=rXiHzPkFvWUde7jFbjJBKuQxMBneI0Bdi2xc7FhVIDw8gSmS6RZY5/m+2nD6JzdJYkwVBUSYMz2E8Pq39VdvP1Xk9cEtzm0bQHLB0PgFHE4J+Bd2000IwZKTmfxym+YDZlHCIqSu0FAy3V+9KphYufQwCPTJUr9sYNSw9Nbo0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275806; c=relaxed/simple;
	bh=ZjbnYeeSMu5T4wtc0P0mmdxflnjLI7lWhbwx0Um34as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyvxdmHUvOv6MCyddWZ9SyW5r221lqg7Agd9LuIuDcGiLr0lyXAr4UsGO+N1TdTFolGwwlHrQlpD1FOfGet166FTu878F9k3jXvKCk6EGQnpy2oQaUMHZ4ka0xK1SIqMJsqdsH9u+PvNwBjdKzT2tqItJTB1az5pMG1fON+sGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUToFPAp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUToFPAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275805; x=1815811805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZjbnYeeSMu5T4wtc0P0mmdxflnjLI7lWhbwx0Um34as=;
  b=XUToFPApwtYhaaE+bLyQReNEUuxP2LfI7mgivPlGutTpkwxJw+ibCWQi
   1oEsmcjTd8f6+IxuJHo64Q3pUb/4YEJBZDn4G6Ef47sqEWEmDYph479+L
   IHLN+KziVKwn0s0yq3FWMTjzeBAfZuqbYIPBgXsfjhaCEds/leZkzV/yh
   2nL3yc03j2whWWItlqqZ/PEfL7JDjay0X9s1hbWv9LPU+y3r/SkFREjeq
   EOZ+UleiUwCAA4ZbccewwZEQDzPyCluW5oipAoWFjFlTzLyyl2WvmCzB6
   ygcxvVi5EKhyOOOBKRu/6GGmnajg2p3lZC6XEjU6msF9KCpW1pSUYuVyc
   Q==;
X-CSE-ConnectionGUID: XidSekS/TLuVjjCRBLhcgg==
X-CSE-MsgGUID: P7P/bt80QjmBTr3M9JR1Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065504"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065504"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:05 -0700
X-CSE-ConnectionGUID: Nz7ZGnHtSI6phDHtGQiypA==
X-CSE-MsgGUID: lh6w8WkYQ42gQirP2YIFaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315461"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:10:01 -0700
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
Subject: [Patch v3 3/8] perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
Date: Fri, 17 Jul 2026 16:03:37 +0800
Message-Id: <20260717080342.1879573-4-dapeng1.mi@linux.intel.com>
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
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
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

