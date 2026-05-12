Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C54395AE4;
	Tue, 12 May 2026 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629186; cv=none; b=lw4VuMFn4xZJIhv5BuxxFiZQRtplt1ierFb92nXXKu+lJLYy0TvVTgG6lfQwhNgucqiC0TXhrDyL5VCrlntUJ1qxa7Yxs35tSMimHh+KZWdFY1A8hNOjXSSnNfUF21lN+qIIaSL62N0Sil1kXfJDUoEIeccnnKH6FZpLjjJIfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629186; c=relaxed/simple;
	bh=55Vyb6PFmbPX/QiipZc8PE8dRL/bYO2WEUwOcsq8DXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdNOF1MvYXKHnp33TCYaEhLkJw//TVQeQmfbLnoXuhrJhUaropdhoq+kPxafu2BDnU34vOGW5n7Z9oLC2p1RCYce8nodgZ/G75eADmdooFBOdRzublTMXHtufu/wz/W3grig7KRQ5amxFBfjIe2Vd9nVwPUZRbqjAE+m149NLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSUY9Nto; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSUY9Nto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629183; x=1810165183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=55Vyb6PFmbPX/QiipZc8PE8dRL/bYO2WEUwOcsq8DXg=;
  b=YSUY9Ntoa/W01B2nvm148ZaXVbkZj99c6Gnq/jQ8B599XFCaqBTbwe7Z
   60t80RP9/Stu0sgLRZzjZFMGpoq48ufubTTQhqcsfzsIG9v1xQnm9n9WM
   WcAZFmxUeD6hnqyqmA3s1UAWokvoKVg7Hq+8LJIW6D3qWd5ynCuzfdOOV
   Wpag8aQynVbUoiO2UjQ3MIoKOQq4/lDd/Yyr8lBfe7bPu5MPMGboQ44k8
   ri2vK7DMDnXV/jatpeRLgLIu792RVm+AGWcWeQb7R3RXZWXyUkYSIKQBY
   jkRlXEE3RgRpLtlf7YYU1pLzRpq+Co/xCd93E7PjB4eklitarlZl9U5si
   Q==;
X-CSE-ConnectionGUID: 57aR7ih7Sp+XYkW6t/F5/A==
X-CSE-MsgGUID: YdU2vmr9Sa2gIVln2LMldA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008900"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008900"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
X-CSE-ConnectionGUID: vCXUVPe3T1+BLC4c8lCw8A==
X-CSE-MsgGUID: cJXup2kNTPOWQ6RmWxDZcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271304"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
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
Subject: [PATCH 7/7] perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMU
Date: Tue, 12 May 2026 16:30:48 -0700
Message-ID: <20260512233048.9577-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512233048.9577-1-zide.chen@intel.com>
References: <20260512233048.9577-1-zide.chen@intel.com>
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
 arch/x86/events/intel/uncore.c | 72 ++++++----------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 399f434e1a7d..2aaac0b49bb6 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1564,8 +1564,11 @@ static void uncore_box_unref(struct intel_uncore_type **types, int die)
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
 			box = pmu->boxes[die];
 			if (box && box->cpu >= 0 &&
-			    atomic_dec_return(&box->cpu_refcnt) == 0)
+			    atomic_dec_return(&box->cpu_refcnt) == 0) {
+				if (atomic_dec_return(&pmu->die_refcnt) == 0)
+					uncore_pmu_unregister(pmu);
 				uncore_box_exit(box);
+			}
 		}
 	}
 }
@@ -1659,7 +1662,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
 			box = pmu->boxes[die];
 			if (box && box->cpu >= 0 &&
 			    atomic_inc_return(&box->cpu_refcnt) == 1)
-				uncore_box_init(box);
+				uncore_box_setup(pmu, box);
 		}
 	}
 	return 0;
@@ -1690,67 +1693,16 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int __init type_pmu_register(struct intel_uncore_type *type)
+static int __init uncore_cpu_mmio_init(struct intel_uncore_type **types)
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
 	int ret;
 
 	ret = uncore_types_init(types);
-	if (ret)
-		goto err;
+	if (!ret)
+		return 0;
 
-	for (; *types; types++) {
-		ret = type_pmu_register(*types);
-		if (ret)
-			goto err;
-	}
-	return 0;
-err:
-	uncore_types_exit(uncore_mmio_uncores);
-	uncore_mmio_uncores = empty_uncore;
+	uncore_types_exit(types);
+	types = empty_uncore;
 	return ret;
 }
 
@@ -2052,12 +2004,12 @@ static int __init intel_uncore_init(void)
 
 	if (uncore_init->cpu_init) {
 		uncore_init->cpu_init();
-		cret = uncore_cpu_init();
+		cret = uncore_cpu_mmio_init(uncore_msr_uncores);
 	}
 
 	if (uncore_init->mmio_init) {
 		uncore_init->mmio_init();
-		mret = uncore_mmio_init();
+		mret = uncore_cpu_mmio_init(uncore_mmio_uncores);
 	}
 
 	if (cret && pret && mret) {
-- 
2.54.0

