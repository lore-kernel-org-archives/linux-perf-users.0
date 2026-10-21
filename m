Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792559690;
	b=LvzpnPKcT94ZneRZF9bJ3UY0OmFw/sE0JecWZTbMN61E6PHFXFHjN7Xu9GZLArt1tiEw
	 QVKIe4TxDiBwUSoWeg8nf8nmeCH/V6nifFdq6qJ1KbpoPJGAkO8IRk2sRsmSgf8oBxrRT
	 SqOt9mkVlVbJt82p9O1OTFsl5ZPBX+pBz67Zj2LmhKP971mrblOglMsaZbplm04B8Jh63
	 gnd3KSm6JAalqJ4oluiHRzB0Y7K4fO0FKJXTAW/GXIuuWgB6S0shesPB3XwqfXkXxEKtQ
	 QwORhMil38zfwaeZUrFpj75mdBrYgmROYU/5lxUwrqhrFRmdGcgN4afe74lwT+320Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559690;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l+UzvfTKE+xvxb9jyN0s6EqMSSmyuRP0/v64tcRdlSM=;
	b=Nal3BxMwKH4yLAaPK7zilvniyn0Ud/sMu+aCgW1molMmVXSjdqhRFRvtIaRGZRazw1yq
	 wRwA4YoaAOLOLKHAHWwELEwxjD/zIFCdbgB6PgMbxx7iCe40NuNq2MdOo7F7DPZ3HxY/j
	 8hfqqQ5tQitqOT3WkrQhIHf77VrjMtqoC1p0BhtPgW1Sj5lygbKmdY1MORTIe4Z84QLmA
	 9jA9MaHyyodYIWybbrTJ9OX4/mBiMn4F7chvq6hwJ8qzpfcThQjJw3JqtVLg3816Js726
	 6wu25FBHxUkCCdFpFeGLD7DJg6nRf3iBVLbG3w2uHWt2+f4tKsUD0sY2W7MtMsejqpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jTboD54w;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0186606A31A;
	Wed, 21 Oct 2026 05:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0186606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jTboD54w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792559690; x=1824095690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MEVuvr9POgXP/LhOjLb0m5Uinep80kmDGLAtDAn6zR4=;
  b=jTboD54wWv7FIkFxA6eXJggyCHIpwEXtkv4AAIFKSq2xOGwMR9br0JsH
   E8iPP5du23br3kyPerm8rEv7mmV4puwv1yjBZnbWOZltHaZAq/WVyuWAu
   XLP/LpJpNB0BfWSPv4VeAAfidRdr7UqJiXPldsvuj2n374C4WvWUvMkIa
   kxjKJQop+nGOsFvK5gJF4+tO439QMl5VfyirNdZ6LoYmL7eWC7+NxdmTF
   JRp1lLujeu83FXBGvxxnnWl48K055/qavfTU9yUyxb9bmB+1LoP9keZ2M
   nf0+xf8EioH++zE+mxTfTuh+0JsU4uIPkzh2hW0yhHd740ACk6GvO/nMC
   g==;
X-CSE-ConnectionGUID: GnkPzAb6SCWRYRe8+OOctA==
X-CSE-MsgGUID: Gea76bcnRcmCcbz4W7UmzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1149201"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1149201"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 22:14:50 -0700
X-CSE-ConnectionGUID: ri3PIFiQRlCYCWQ/O50tOg==
X-CSE-MsgGUID: 5p8q/uD1RwqOZ9+NVbZTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2947677"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2026 22:14:46 -0700
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
Subject: [Patch v4 5/5] pef/x86/intel: Always snapshot live hardware LBR state for BPF path
Date: Wed, 21 Oct 2026 13:07:11 +0800
Message-Id: <20261021050711.4043703-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
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

__intel_pmu_snapshot_branch_stack() is meant to snapshot the current
runtime LBR state from hardware for the BPF path. However, stale cached
PEBS LBR data can be snapshotted instead when a PEBS LBR user is active.

Fix this by always snapshotting the live hardware LBR state, regardless
of whether a PEBS LBR user is active. Reading the runtime LBR registers
can overwrite the cached PEBS LBR stack, so save and restore the cached
PEBS LBR state around the snapshot. This preserves the PEBS LBR data for
later output to userspace in the normal PEBS record path.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 43 ++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/lbr.c  |  9 --------
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5dfb9e9156e8..07d1a8a7845b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2815,16 +2815,50 @@ static void intel_pmu_enable_all(int added)
 	__intel_pmu_enable_all(added, false);
 }
 
+struct lbr_snapshot {
+	struct perf_branch_stack stack;
+	struct perf_branch_entry entries[MAX_LBR_ENTRIES];
+	u64 counters[MAX_LBR_ENTRIES];
+};
+static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);
+
 static noinline int
 __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 				  unsigned int cnt, unsigned long flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct lbr_snapshot *snapshot = this_cpu_ptr(&lbr_snapshot);
+
+	/*
+	 * This may be called from bpf_event_handler() in a PMI context. If
+	 * a PEBS LBR user is active, the PEBS sample record has already updated
+	 * cpuc->lbr_stack. Reading the LBR registers here would overwrite that
+	 * cached PEBS LBR stack, so save it first and restore it afterward. This
+	 * keeps the cached LBR data available for later output to userspace in
+	 * the normal PEBS record path.
+	 */
+	if (cpuc->lbr_pebs_users) {
+		memcpy(&snapshot->stack, &cpuc->lbr_stack,
+		       sizeof(struct perf_branch_stack));
+		memcpy(snapshot->entries, cpuc->lbr_entries,
+		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
+		memcpy(snapshot->counters, cpuc->lbr_counters,
+		       sizeof(u64) * cpuc->lbr_stack.nr);
+	}
 
 	intel_pmu_lbr_read();
 	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
-
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+
+	if (cpuc->lbr_pebs_users) {
+		memcpy(&cpuc->lbr_stack, &snapshot->stack,
+		       sizeof(struct perf_branch_stack));
+		memcpy(cpuc->lbr_entries, snapshot->entries,
+		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
+		memcpy(cpuc->lbr_counters, snapshot->counters,
+		       sizeof(u64) * cpuc->lbr_stack.nr);
+	}
+
 	intel_pmu_enable_all(0);
 	local_irq_restore(flags);
 	return cnt;
@@ -4022,7 +4056,12 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	intel_pmu_lbr_read();
+	/*
+	 * No need to read the LBR stack when all LBR users are PEBS events,
+	 * since the PEBS handler updates it.
+	 */
+	if (cpuc->lbr_users != cpuc->lbr_pebs_users)
+		intel_pmu_lbr_read();
 	intel_pmu_ack_status(status);
 	if (++loops > 100) {
 		static bool warned;
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ac1759a71288..07b32255e48d 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1030,15 +1030,6 @@ void intel_pmu_lbr_read(void)
 		return;
 	}
 
-	/*
-	 * Don't read when all LBRs users are using adaptive PEBS.
-	 *
-	 * This could be smarter and actually check the event,
-	 * but this simple approach seems to work for now.
-	 */
-	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
-		return;
-
 	x86_pmu.lbr_read(cpuc);
 
 	intel_pmu_lbr_filter(cpuc);
-- 
2.34.1

