Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DA3DE453;
	Mon,  1 Jun 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333813; cv=none; b=eSoLAEKEpXX+4sHcdZ5i4Xbt7NQTfAJH5oPTvy9HB6+t/a4iHE8qL2w586IMfzzmwH7N+u+mKI6vzysZz+w10V/+6rj05NV6ipdhX/hSCYyd7mB6YJ4wy+ELMfMykqKZz+10hbGwktRy5T+u7MnXEztlmMfgyMKa2R/WKTUgfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333813; c=relaxed/simple;
	bh=W+dMjre+SiDgALwNCgcZvTV/g8UhJwVNRJ4TYVKT+N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIZfX6PS/BppPak46/zlbGsE2M0YVU/RnuGX+rGxB5nw2QSxxKh6XWpv8kW+yivtfGGESmwtS2zvMWDuavML8AP2MzqN8nk1PykJPiyEKO2fuKGkgqrOxfMauDL2WGr20YZ4uvy3x6ANPxTa4SpnAYDnkHMlxQjo2B8I843M3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHamXpUJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHamXpUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333811; x=1811869811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+dMjre+SiDgALwNCgcZvTV/g8UhJwVNRJ4TYVKT+N8=;
  b=FHamXpUJjadhqAsm8IN2RtLEN6796mKgd99HAlEuuK0CcSsian6fIum5
   h4zs/6218Cl0rxbMPT9ckOFA1U4KkKy6UbpljUCqGgPLamRbLRuDoDk6x
   wXwB8DHoqvUTDiccOH6imBhuQTHOTjGaROA95aDmm6lIJFl1xWP2vb/T6
   CDto4jiTlnqNiO7+2rtmvOjNc9UbdsTVV5ALJSGD2bZjpe7BHTCZTbETA
   GZtM5b8+e5Og/FU/aOFLnbsFqzeQ4vMAC7Vp0doHqdle1Aade4SsLmhra
   uCBX3NBYKujIaUCwm+IPNDb946PPbD2CSKrk138b+5bBbZuPNjtAVnwIX
   Q==;
X-CSE-ConnectionGUID: GC+VpuFWScOpp68fhoSbmg==
X-CSE-MsgGUID: chPKpGYsT4yMVHA3+6B6xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98517014"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98517014"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:07 -0700
X-CSE-ConnectionGUID: vPeeXUw1SfyNbsGnQ8Wh3A==
X-CSE-MsgGUID: Oa20yW9sQO6o2NS+G+N+YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242585018"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:05 -0700
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
Subject: [PATCH V2 8/8] perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMU
Date: Mon,  1 Jun 2026 10:01:14 -0700
Message-ID: <20260601170114.173359-9-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601170114.173359-1-zide.chen@intel.com>
References: <20260601170114.173359-1-zide.chen@intel.com>
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

Box allocation and free remain at module init/exit time to avoid
repeated kfree/alloc cycles across CPU offline/online events.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
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
index 6d710aef52ac..06f50f5fae8c 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1567,8 +1567,13 @@ static void uncore_box_unref(struct intel_uncore_type **types, int die)
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
@@ -1655,7 +1660,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[die];
 			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
-				uncore_box_init(box);
+				uncore_box_setup(pmu, box);
 		}
 	}
 	return 0;
@@ -1686,67 +1691,12 @@ static int uncore_event_cpu_online(unsigned int cpu)
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
 
@@ -2047,12 +1997,16 @@ static int __init intel_uncore_init(void)
 
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

