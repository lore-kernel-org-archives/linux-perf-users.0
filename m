Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88F4279E0;
	Thu, 11 Jun 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194183; cv=none; b=SBp8WqpHbpbNTipSPUfgoPQY8pgOk0EVK9UW6aUHgX2xoJuKN1M6f8BoguW6DOpxtZ2K87nhIdDPRo13Vr/qSp/xrKyzkk0yX4BFfSRUSGI+nsfzQFGJ5MXtOGTSPLtXz4KXOnR5+xCd4forNoRQ1P0W64XNg5rEB0tNXqxykAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194183; c=relaxed/simple;
	bh=8nQtIfzcmmn5trV2x2c54i8+kazaOtg/GhjKzewIqE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjPiU4F6fqJtLcdyYsLwCxBmiad3ICIH5Gs5BSaeOUh2sFMOH/WqRHq+y+fpkRCdny75KJN2CtAt6xvWWHxhzUH1weBsJVX7n5IRXvgq4xk/mN7cpu6z9LjsGs6BWS+MBML7k3s7gAsdl0aBDv9U0ph0OLDIfP9i1ULhDFhl9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gysRlrgC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gysRlrgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194182; x=1812730182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8nQtIfzcmmn5trV2x2c54i8+kazaOtg/GhjKzewIqE4=;
  b=gysRlrgCIFezyrIrptmVdSOsAi1uHVHGYFfIypQaVqYr6BgqBNKovPh8
   7hfCBMYLpNbqA/gDIKVlKuV+TILKnz1mKkXESXebtpLkS3x5YLqzG2fQ9
   E5ZkBUgNxi3YPORti8zxLemumY6QPaymxP0P43/hGWv0bA5JSzenT0iQM
   4H6d9ygP9USP2Ni6PPn1xwwi97nNCv+4ZfEglNHoYyzYygbxeDl1YDmMo
   UuUdOy8HepWZj5Jzq1zcBMq84QUVxT9hB/lYXH2Qf89fnZCzbbP99OYdO
   /rHXuFgU8DVLw0onpMZIPCUopwRZ9NoTnXfgzWzvFyV9pZniw3ar1xTn8
   w==;
X-CSE-ConnectionGUID: TBTxGthxSn+qEHtqMsOiTw==
X-CSE-MsgGUID: ApmUl+caQkeoGAKjWr2UoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81995001"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81995001"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:37 -0700
X-CSE-ConnectionGUID: RxUZorLTT7aGjY0itp8Y9A==
X-CSE-MsgGUID: gB+0euCKSo6mnNtlfOSaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246403609"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 8/8] perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMUs
Date: Thu, 11 Jun 2026 09:00:33 -0700
Message-ID: <20260611160033.66760-9-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611160033.66760-1-zide.chen@intel.com>
References: <20260611160033.66760-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSR and MMIO uncore PMUs are currently registered at module init time
and appear in sysfs even when no PMU boxes are functional.

Apply the same lazy registration model used by PCI uncore PMUs: the
PMU is registered when the first box is successfully initialized, and
unregistered when the last box exits.  If a box fails to initialize on
a subsequent die, the PMU is marked broken but remains registered to
avoid disrupting any in-flight perf events.

Box allocation and freeing remain at module init/exit time to avoid
repeated kfree/alloc cycles across CPU offline/online events.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Update title: PMU -> PMUs.
- Add Reviewed-by tag.
v2:
- uncore_box_unref(): Only decrement pmu->activeboxes for active boxes
  (those without init_box callback or successfully initialized) to prevent
  underflow when initialization fails.
- Set uncore_{msr,mmio}_uncores to empty_uncore when
  uncore_pmu_types_init() fails.
- Rename uncore_cpu_mmio_init() to uncore_pmu_types_init() (Dapeng).
---
 arch/x86/events/intel/uncore.c | 78 +++++++---------------------------
 arch/x86/events/intel/uncore.h |  6 +++
 2 files changed, 22 insertions(+), 62 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b9ac2f7d31ca..9f8a80c9dcb6 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1570,8 +1570,13 @@ static void uncore_box_unref(struct intel_uncore_type **types, int die)
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[die];
-			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
+			if (box && box->cpu >= 0 &&
+			    atomic_dec_return(&box->refcnt) == 0) {
+				if (uncore_box_active(box) &&
+				    atomic_dec_return(&pmu->activeboxes) == 0)
+					uncore_pmu_unregister(pmu);
 				uncore_box_exit(box);
+			}
 		}
 	}
 }
@@ -1658,7 +1663,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[die];
 			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
-				uncore_box_init(box);
+				uncore_box_setup(pmu, box);
 		}
 	}
 	return 0;
@@ -1689,67 +1694,12 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int __init type_pmu_register(struct intel_uncore_type *type)
+static int __init uncore_pmu_types_init(struct intel_uncore_type **types)
 {
-	int i, ret;
-
-	for (i = 0; i < type->num_boxes; i++) {
-		ret = uncore_pmu_register(&type->pmus[i]);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
-static int __init uncore_msr_pmus_register(void)
-{
-	struct intel_uncore_type **types = uncore_msr_uncores;
-	int ret;
-
-	for (; *types; types++) {
-		ret = type_pmu_register(*types);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
-static int __init uncore_cpu_init(void)
-{
-	int ret;
-
-	ret = uncore_types_init(uncore_msr_uncores);
-	if (ret)
-		goto err;
-
-	ret = uncore_msr_pmus_register();
-	if (ret)
-		goto err;
-	return 0;
-err:
-	uncore_types_exit(uncore_msr_uncores);
-	uncore_msr_uncores = empty_uncore;
-	return ret;
-}
-
-static int __init uncore_mmio_init(void)
-{
-	struct intel_uncore_type **types = uncore_mmio_uncores;
-	int ret;
-
-	ret = uncore_types_init(types);
+	int ret = uncore_types_init(types);
 	if (ret)
-		goto err;
+		uncore_types_exit(types);
 
-	for (; *types; types++) {
-		ret = type_pmu_register(*types);
-		if (ret)
-			goto err;
-	}
-	return 0;
-err:
-	uncore_types_exit(uncore_mmio_uncores);
-	uncore_mmio_uncores = empty_uncore;
 	return ret;
 }
 
@@ -2050,12 +2000,16 @@ static int __init intel_uncore_init(void)
 
 	if (uncore_init->cpu_init) {
 		uncore_init->cpu_init();
-		cret = uncore_cpu_init();
+		cret = uncore_pmu_types_init(uncore_msr_uncores);
+		if (cret)
+			uncore_msr_uncores = empty_uncore;
 	}
 
 	if (uncore_init->mmio_init) {
 		uncore_init->mmio_init();
-		mret = uncore_mmio_init();
+		mret = uncore_pmu_types_init(uncore_mmio_uncores);
+		if (mret)
+			uncore_mmio_uncores = empty_uncore;
 	}
 
 	if (cret && pret && mret) {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 0adb477d9708..c8dfa2d21bfd 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -568,6 +568,12 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
 	return box->pmu->type->ops->read_counter(box, event);
 }
 
+static inline bool uncore_box_active(struct intel_uncore_box *box)
+{
+	return (!box->pmu->type->ops->init_box ||
+		test_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags));
+}
+
 static inline int uncore_box_init(struct intel_uncore_box *box)
 {
 	int ret = 0;
-- 
2.54.0

