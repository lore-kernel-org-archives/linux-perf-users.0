Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972227;
	b=H1e4gTg9PjbhqTJaRrMeXe5ybnXUOfPsJ8hC+VH6u5E81XE2oUqSlw+weg6qWfzhfC4f
	 se4X8P17mDhU2oKKEsi+XNed7VJmLQqPfetEPPk/oBlFv6PFRN02Lh1OwR1mkhynfzbMr
	 tyvcv7QFCQjtaPPJABaMwFJXuyEp13XCZkzAI0VzweJQa9TxEtu/hpFaI2GTiS2hKUEHr
	 iDuse4zPA7FtOb5xnK4e5OnweQH6Zdlp8LL5ciEzBfEVtQns4ZSQxbK10mwcQKPvvIrhX
	 TZWuI+AKDIoJIgYl1MgkN90MUScu4peMCeQfp9pCf95nKbM0KdpoEtyGj9qxawXH09w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972227;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2iPMece3bY6LUbOV5VpSZ0waeKuKhnnqGdDVNfX/8yo=;
	b=C16lfO3Czibl81aeS7ckFAVFKtfTRfangLQdy2Fl8r4NbIMZ+p/holEZirfHUQ7yBGCI
	 f5p94GBtF+js7tGy6YPBdppyJA3a2WlwM9CBJJsBSW9RvManBvCXOIJqap2fSQ+qca7yc
	 DDH9//JAw5s1E86KKpemEJNJeKV0BHyq4ElPCBqSMNeD9ssbLA5ZuaGBUtDvcZibBfMcn
	 /Jg8+JlCmw2x7wzmOiIynBwexWU8gKrOWo2a8Q105s5FSnp0ELopRFubGh+Tqzde/+FNI
	 sCpKPhrJ2bWItM6K1DHJo3ieYh8AXNJeT7zUUHlo7CwU/1cZUTFZQNh58BH5WIrZLVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b6SVaatG;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EC606A333;
	Wed, 18 Nov 2026 03:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F6EC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b6SVaatG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972228; x=1826508228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGxdSDBFio0PYS+ZYmVI7Euv5KFn7a9q7pYa6YBkjKA=;
  b=b6SVaatGi6e8foN+h9tetP96tGcZS6AzZmaix2x31QfdN2A2WphkNHgx
   dU/ACn3oHVdcXmiBMjw0v05G2CsOeJ+j0H1y5Zdq0CPnxFwANdSmw0yS7
   AOO11+wD0iuqNlnO0z+l9Dj8i/V18GRT17P6EFLnlYsbm+gftAgSD93zS
   B6vEknoMe9MuNztfPMSeGH/LKcsc3LDAaP6OnEKiIa8LLEQ/4xRMw30Um
   8pzxZ/gbfnQKk7SOMB9wRgZT0Z7rWwCf3mFjFGLG3WNvslk4DeaPzyDq4
   IVBRVdPg6SC+m5f6dU8qeGqfVr21acV1pksm3ygNCv+ZtYlV9BQQj7Ble
   A==;
X-CSE-ConnectionGUID: b1w7OqK3QCSh8U4evj1S2w==
X-CSE-MsgGUID: wA008iu7TNuahdjtv3YUOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629931"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:47 -0800
X-CSE-ConnectionGUID: lGI8r9RTRf+TlekmDHFoPQ==
X-CSE-MsgGUID: zuBkgOqmSnyCzIJb7zotsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894271"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:43 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v7 12/24] perf/x86/intel: Use a dedicated LBR stack for BPF snapshotting
Date: Wed, 18 Nov 2026 11:14:41 +0800
Message-Id: <20261118031453.1353625-13-dapeng1.mi@linux.intel.com>
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

BPF LBR snapshotting currently reuses the default LBR stack
(cpuc->__lbr_stack) when storing sampled data. This is unsafe when the
BPF helper runs in PMI context via bpf_overflow_handler(): it can
overwrite the cached LBR state for active PEBS LBR events, causing
incorrect LBR data to be reported to userspace. When the PEBS and BPF
stacks have different depths, this can also lead to out-of-bounds reads
when the LBR stack is later exported.

Use a dedicated LBR stack for BPF snapshotting so the BPF path no
longer clobbers the shared LBR state used by other perf events.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 357c8eb7ee08..b560f2e96848 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2819,17 +2819,26 @@ static void intel_pmu_enable_all(int added)
 	__intel_pmu_enable_all(false);
 }
 
+struct lbr_snapshot {
+	u64 __lbr_stack[LBR_STACK_SIZE / sizeof(u64)];
+	u64 counters[MAX_LBR_ENTRIES];
+};
+static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);
+
 static noinline int
 __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 				  unsigned int cnt, unsigned long flags,
 				  int pmu_enabled, int lbr_enabled)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct lbr_snapshot *bpf = this_cpu_ptr(&lbr_snapshot);
+	struct perf_branch_stack *lbr_stack;
 
-	intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
-	cnt = min_t(unsigned int, cnt, cpu_lbr_stack(cpuc)->nr);
+	lbr_stack = (struct perf_branch_stack *)bpf->__lbr_stack;
+	intel_pmu_lbr_read(lbr_stack, bpf->counters);
+	cnt = min_t(unsigned int, cnt, lbr_stack->nr);
 
-	memcpy(entries, cpu_lbr_stack(cpuc)->entries,
+	memcpy(entries, lbr_stack->entries,
 	       sizeof(struct perf_branch_entry) * cnt);
 
 	/*
-- 
2.34.1

