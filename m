Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2D3E7BCA;
	Mon, 24 Aug 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560478; cv=none; b=jSRf6BBUrCzOf8bYl89AU92ErmZG3EFMuafSaMExtJrUKGpXNwcnx/3+eqbw8oar4f9yKiDRPr/WEkCORqGtrxLQnefshjojXzsEBr6lfl74IeCGvcZi8+B/uk8JKgArqOcjE/HWpEupcE6NGoj0TP5uqfqhOogdC3dSobR4e8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560478; c=relaxed/simple;
	bh=sm5pwEFZcPUk1k9wG+3OIN8I0e2VwsfYDE+wjRlQikM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wyoys2bLR1o2aHIIY4X5iCgvTMmGmJGsHo5aQehgeWThayU4lMZI3TPOp0HAnIHIPJp6D15GndmsATgibG6KNrFg3FOyvuPYagMl4AVYbgS54w5ixUGeYMFe3lCjt6ZmuOCf4UbYDNIgzHHJi90giQcqQXzsmrGu91IfyWSZ8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmV8EDmj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmV8EDmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560477; x=1819096477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sm5pwEFZcPUk1k9wG+3OIN8I0e2VwsfYDE+wjRlQikM=;
  b=AmV8EDmjDbTx8d0bbhC//BcVq+ZGFnaAWGPc0TBjGYrZXbtuHlaK6EZw
   yRa6Foku++igX0JZWEyHrj1gHmQHN2ToWCvQXm/gT6xxOu/DR5LPI8c29
   JaKvxDa1ClAkoMunXHkJy2bsB2z9LDMhZsbZzRM6MX38jZlfni21azwEO
   RHzK/jN5QdsOk4P1zDQJmYC4WMgDUdaSVjAiU10KYF/8OcqQ2ZXmLYYjZ
   nk66CnKyBKGBOldTy2apYZIWItbeNr5614bItCeVp9UhEMLmtHPHaacYr
   0w9ztgmPnzIdomt48ZG5/orEueR7yjqFr1nRy+p9YQ3aJ3ax/8gilWj53
   Q==;
X-CSE-ConnectionGUID: 6arl22jwTWi8A078nnFc3g==
X-CSE-MsgGUID: k4ev2BV7QLyYBs56Ad5aWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598725"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598725"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:34:36 -0700
X-CSE-ConnectionGUID: 3zNRMrfzTgW5OWZ7R0zKTQ==
X-CSE-MsgGUID: McJcfxPVRJWM0AGG/H0oJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326085"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:31 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND Patch v10 05/23] perf/x86: Use x86_perf_regs in NMI handlers
Date: Mon, 24 Aug 2026 16:27:13 +0800
Message-Id: <20260824082731.1013973-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for sampling additional register state in NMI context
(e.g. vector registers and SSP) requires an x86-specific register
container. The generic pt_regs structure cannot represent all of
the required x86 register data, so switch x86 NMI handlers to
x86_perf_regs.

pt_regs is still passed to x86_pmu_handle_irq(), so there is no
functional change to existing handling.

AMD IBS NMI handling does not use x86_pmu_handle_irq(), so this
conversion does not apply to IBS. IBS support for extended register
sampling can be added separately in follow-up patches.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 5 ++++-
 arch/x86/xen/pmu.c     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 75358a297222..3368270c0ad1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1800,9 +1800,11 @@ void perf_put_guest_lvtpc(void)
 EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
 #endif /* CONFIG_PERF_GUEST_MEDIATED_PMU */
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_intr_regs);
 static int
 perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 {
+	struct x86_perf_regs *x86_regs = this_cpu_ptr(&x86_intr_regs);
 	u64 start_clock;
 	u64 finish_clock;
 	int ret;
@@ -1826,7 +1828,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	x86_regs->regs = *regs;
+	ret = static_call(x86_pmu_handle_irq)(&x86_regs->regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 5f50a3ee08f5..3f4dd3f50f56 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -456,12 +456,14 @@ static void xen_convert_regs(const struct xen_pmu_regs *xen_regs,
 	}
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_xen_intr_regs);
 irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
 {
 	int err, ret = IRQ_NONE;
 	struct pt_regs regs = {0};
 	const struct xen_pmu_data *xenpmu_data = get_xenpmu_data();
 	uint8_t xenpmu_flags = get_xenpmu_flags();
+	struct x86_perf_regs *x86_regs = this_cpu_ptr(&x86_xen_intr_regs);
 
 	if (!xenpmu_data) {
 		pr_warn_once("%s: pmudata not initialized\n", __func__);
@@ -472,7 +474,8 @@ irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
 		xenpmu_flags | XENPMU_IRQ_PROCESSING;
 	xen_convert_regs(&xenpmu_data->pmu.r.regs, &regs,
 			 xenpmu_data->pmu.pmu_flags);
-	if (x86_pmu.handle_irq(&regs))
+	x86_regs->regs = regs;
+	if (x86_pmu.handle_irq(&x86_regs->regs))
 		ret = IRQ_HANDLED;
 
 	/* Write out cached context to HW */
-- 
2.34.1

