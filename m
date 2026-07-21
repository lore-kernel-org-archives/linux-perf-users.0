Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB113EDE7C;
	Tue, 21 Jul 2026 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615548; cv=none; b=YxvXf55cCjnbWeCHE7FYVMqxvXRqdizHov/ZqmwTCNkDNXltsYi8TYgyrTmfVvoh15Km9KTVrI0rZ0uV5nQScykvqKa87pYOkNU7aFEuQ3BH4DW3Wsk/7eZL6sz24Lqo4h/BOHZ+SKe6ts8y7jUVoXQUhErfN69HnZIOgE4Sns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615548; c=relaxed/simple;
	bh=YbHRkkn496VMoLY29m74DxK+lyVy8p8q0O68g31Nauw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBtYJV2Y0FzFDS74OP9UY/oOYzantFBzy3YhTsLy/ji7+EpemRWjtSXi5tZfQbJm+gJwX1BLo3xobCn1SFPg6y04bxADY2B6eupJZiVckzH4tWjUYu5p/PvydkjqgKPems9NjNekOiw+BWy5n1RRPmjzhYqZqjqaRO1euSVfPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcelUWRe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcelUWRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615547; x=1816151547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YbHRkkn496VMoLY29m74DxK+lyVy8p8q0O68g31Nauw=;
  b=PcelUWReZgRXFxWSUky9bGar/gpo/N0AnONvO487axPGtJ5dA7gv2dDr
   d97rE1PBJnEuroTku7gn9Cx2VVyAiI9yDFA0TkzVB5wAqNcEKg/aBexwM
   c2AofC7ZnlJF5B7z3r1lD7iIhEnOzPD8+b7fMTguoqfn94zRqAkWJd8aw
   3VFtqwDWlHoGAd03fGHrBqg0h0i2/dsdLV31kp/JQ/j5K2jydVUYWBp+o
   4Os8ewyxQlSAkIB3G1Er2IaPnOq8VSGbkdDK2Ad+cu4kyY0D18Dup0TYc
   vrnlyx3pcx7htUtbruJihQDMDEEHC07sm9MFKyum4Kdhzx9cHHOwOFbMM
   g==;
X-CSE-ConnectionGUID: DtHd44+iTfqBJvOV6d/FtA==
X-CSE-MsgGUID: 6zuIrgn9T9GQvLvDzi+dCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72740282"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="72740282"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:32:26 -0700
X-CSE-ConnectionGUID: oGrO48dBRhOZU4fEEK6W6Q==
X-CSE-MsgGUID: b0sSWx9fStKiCuqGiL1Jrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259655781"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:32:21 -0700
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
Subject: [Patch v10 03/23] perf/x86/intel: Convert x86_perf_regs to per-cpu variables
Date: Tue, 21 Jul 2026 14:24:46 +0800
Message-Id: <20260721062506.3745816-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the drain_pebs() helpers, e.g., intel_pmu_drain_arch_pebs()
define an on-stack x86_perf_regs. Upcoming patches will add new fields
like *ymm_regs and *zmm_regs to the x86_perf_regs structure to support
sampling for these SIMD registers. This would increase the stack size
consumed by these helpers, potentially triggering the warning:

"the frame size of 1048 bytes is larger than 1024 bytes
 [-Wframe-larger-than=]".

To eliminate this warning, convert x86_perf_regs to per-cpu variables.

Please note drain_pebs() can't be interrupted by other NMIs since
either it's already in NMI context or PMU is already disabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7f8b98d1837d..9355744a9258 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2910,6 +2910,8 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_pebs_regs);
+
 static __always_inline void
 __intel_pmu_pebs_events(struct perf_event *event,
 			struct pt_regs *iregs,
@@ -2919,8 +2921,8 @@ __intel_pmu_pebs_events(struct perf_event *event,
 			setup_fn setup_sample)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	int cnt = count;
 
@@ -3168,8 +3170,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -3219,8 +3221,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
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

