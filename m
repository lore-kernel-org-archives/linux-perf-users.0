Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F834CFD7;
	Tue, 24 Mar 2026 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313171; cv=none; b=QzePs+1sLLILd0Zh06BoYznASCn1K5P4I/Ra+AqhNLzX+qUFuzX5846DIoVaIS3U2fn+lwBceK2sUZmbMLbluAG7KxohLccG82tHl10rm0VvMKkU40/PEHBm8MYECYLTmTPKs8UqPNloPeVf4Jw0h1STzYZKxXG2IsPpdf30ocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313171; c=relaxed/simple;
	bh=F6zSDvY2cAEEmHpKsROXdQb5nFcmwiqGgFuqWyyAeQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1wpvRrCUYYh36PpyBYIiIKdh+zpI/hT73w1rY8ljGIaxxn5sSXmIdY/96hWtTBDi7ixAZgGd+Hr6zsrg7oD3PCiq1iJOsxvjDMcgnVGx/CL2m2qVk92ec+Hb+p3bvIHa2M+QKJ2AL8iEul99Ty/d9Cj+Cr7ickn67mYf/MM6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATLkMY37; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATLkMY37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313170; x=1805849170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F6zSDvY2cAEEmHpKsROXdQb5nFcmwiqGgFuqWyyAeQM=;
  b=ATLkMY37z+Lab6CCz8NFPafKcIK/1mx7ObYTsDXuPdvqo6TFZCHwo8qv
   5jCki+lLc+uylfM3u+Zn+I9ikh2Al0K6qaK8Rj22YdkAohtcVwZDlKUuJ
   3surpbTN8h9moT3pvtuZI7BoPk01ZRC0XRuDkPQj3sQSZIc75Ldt6T1C8
   /kjNCwtH0BxRz2TgU94MiTQM6sLFlyNQ24XEK2VVJcIWfK5qnd7YNEB2J
   EMcppgWbVxLT6nNH7L2XXyKQjpj3aGuvIxpkWK1Vzl7V/n79b00ERHIj0
   poZeAYxLHtVZals2t2XYNThqQB1Fhi0mnRQUrs8O4UzfW19/4k62TdXFa
   Q==;
X-CSE-ConnectionGUID: T/ok0zVJTDS8tBbVEKRlyg==
X-CSE-MsgGUID: 2dUyC+s6RwWf2cBTwTf2LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397007"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397007"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:10 -0700
X-CSE-ConnectionGUID: r5xmhYw/T32/l1gGkLNmNA==
X-CSE-MsgGUID: +FpuexhIRe+8sS8y2jQwZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322627"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:05 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 04/24] perf/x86/intel: Convert x86_perf_regs to per-cpu variables
Date: Tue, 24 Mar 2026 08:40:58 +0800
Message-Id: <20260324004118.3772171-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the intel_pmu_drain_pebs_icl() and intel_pmu_drain_arch_pebs()
helpers define many temporary variables. Upcoming patches will add new
fields like *ymm_regs and *zmm_regs to the x86_perf_regs structure to
support sampling for these SIMD registers. This would increase the stack
size consumed by these helpers, potentially triggering the warning:
"the frame size of 1048 bytes is larger than 1024 bytes
 [-Wframe-larger-than=]".

To eliminate this warning, convert x86_perf_regs to per-cpu variables.

No functional changes are intended.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 49af127bff68..52eb6eac5df3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3179,14 +3179,16 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_pebs_regs);
+
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	struct pebs_basic *basic;
 	void *base, *at, *top;
 	u64 mask;
@@ -3236,8 +3238,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	union arch_pebs_index index;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
 	u64 mask;
 
-- 
2.34.1

