Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7F3033F5;
	Mon,  9 Feb 2026 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621905; cv=none; b=qqvKJyjYcUaa1Ms8+7BFrl2CfQtd+pUFDFfY0GatkPKkCv/2BBeb22lJLwuzxiIQqCH3MSFEsJ8UPppGTD3Ed9mZ+cNSthKNMypHhuXIRmb+hJLtSAHFaomNS/SG6omNA7DU66TJ+FaSJvUtJqE98ZJ6dZ0E8tkFfxxe5nFOzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621905; c=relaxed/simple;
	bh=vyccwpwVNEoObBkltGcUlDWlubtE7wsvucwHlawZWaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLUgpXHKNMndpXrjBQ4jtkj/NgW7prpegNhhLJfa3gls1zruBHqNmZT55Kn+FSi3C43SV/y3g68JmgBPPL45B1EITc2bLvPsHg8kdEGOoKK7xHYPFPq5v2wS6JfR4GMyaCHB0B0QXOMFcjJpFU8ZA9fZmTfZiE6gaqHDKiTYhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Obi7LVHZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Obi7LVHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621905; x=1802157905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyccwpwVNEoObBkltGcUlDWlubtE7wsvucwHlawZWaM=;
  b=Obi7LVHZUZf1nXgAEuZbeeOF7Anz3Raa+67IMwqxm8pZqMSLuKulc96l
   waAo1KTszCV1tQA7/yanPrZ1FDZobtTxZiZ+Bcu/HfXyInCpj7fVZC5x/
   YKRoRB1FhQA2Sokzw1tNaKmQfZEfdCmYmLMZqYMbMORxlHZO9tO2EIumy
   4y0zfVRZ4+SPmLPlh61c/LGPiaeyExY9tfuhZbtYRS5GghjnyOgzrpg3E
   Ok6mdfyBfZH5EuZYTKL/76ZACpKaWYcDJ7SXeGa4DM3PD24vrgftlrom2
   xa44fahF9r3C34EBOOL4bijnANh6Gn6t8xtzSIA4lTNLvJgUzyue2XrUS
   g==;
X-CSE-ConnectionGUID: Tk2utIBWRyif4IcKizgGaQ==
X-CSE-MsgGUID: C+tPk/6pQAa/0qHMpW29qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098269"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098269"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:05 -0800
X-CSE-ConnectionGUID: rDYe2InXTUKlH3wkudaB6g==
X-CSE-MsgGUID: e87nQxDVS7+JPQ1W+snS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694604"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:00 -0800
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
Subject: [Patch v6 03/22] perf/x86/intel: Convert x86_perf_regs to per-cpu variables
Date: Mon,  9 Feb 2026 15:20:28 +0800
Message-Id: <20260209072047.2180332-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
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

V6: new patch.

 arch/x86/events/intel/ds.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 57805c6ba0c3..87bf8672f5a8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3174,14 +3174,16 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 
 }
 
+DEFINE_PER_CPU(struct x86_perf_regs, pebs_perf_regs);
+
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&pebs_perf_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	struct pebs_basic *basic;
 	void *base, *at, *top;
 	u64 mask;
@@ -3231,8 +3233,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	union arch_pebs_index index;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&pebs_perf_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
 	u64 mask;
 
-- 
2.34.1

