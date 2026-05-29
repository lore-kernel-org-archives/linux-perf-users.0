Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769D3B6346;
	Fri, 29 May 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041786; cv=none; b=ZFmzFo90TuEgykHWvFfOe8bqwAhabztbZiS6DZrStdVmcmKd07T8aj3k6VK/+fPH7NFnm/1PQima1U53ZBfWn9KDZ8olXbiZhVVqyOGxnDs5XwM7MTD7XGfuYvn1whvJM7U66wMZBpxE+NPIjMWP0I6Mso7p1B/Lsi/xhGAe7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041786; c=relaxed/simple;
	bh=pR2poulYHn6VOTSmZqyeJ9hNbKOoQfLf5cKqhyIl+hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCLS611Fs851DFxEbPiAJAkkmtNqxhkI3lyO+mTO9GzPxMiun1pfa4t76ElecL/4RNildYlXtLuQYjHWEA3UrNCKffNTi+JX7m6gL3UgNwGqCjUDihTdHRlAWq9HQz32lYz2D5CNPUP0emGzJlmKIr7mnfkpKDDBvkS0gQ8fViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAVKP2q8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAVKP2q8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041785; x=1811577785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pR2poulYHn6VOTSmZqyeJ9hNbKOoQfLf5cKqhyIl+hc=;
  b=MAVKP2q8deLRjf3jHjjVSURqYW5boeziuo3tmEwbN4SxnIcRDlLF+J3g
   c3INiFE0kMN6Mui0mstJGF6dRp2pYasXclffGBr5rMd3ulXA2ixSgQzTj
   /ClKqVq7EpPoBuLR8gkYW63QXztHiO7Cw1TcghIT7y/5leygUmVtNqE2f
   HShY3CsZL2ijZ8Buw+pVsAOvuN1xsySkVIRo1TfErAWBE4bwPwPlgu2vZ
   Eshu4GLqEocGFFc9002ruvq8uke2qJJVAfikYaRuIuIgVlTHVzxDYFr8V
   DM8dnDdCaNifAhhUQ96kX3SaNVzbXqPjJsyIvlhRcbMSGrBgnacpytPX0
   Q==;
X-CSE-ConnectionGUID: ghi6lCx7SR6pZM34hY79Mw==
X-CSE-MsgGUID: oBTcOCCCQLGMcbD+Dqxw2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341902"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341902"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:05 -0700
X-CSE-ConnectionGUID: WaalXZmqQt+jdruMlKt3bw==
X-CSE-MsgGUID: 2xSxdNiBQoqGr9B44k6bWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802023"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:00 -0700
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
Subject: [Patch v8 06/23] perf/x86: Use x86_perf_regs in the x86 nmi handlers
Date: Fri, 29 May 2026 15:56:28 +0800
Message-Id: <20260529075645.580362-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More and more regs will be supported in the overflow, e.g., more vector
registers, SSP, etc. The generic pt_regs struct cannot store all of
them. Use a X86 specific x86_perf_regs instead.

The struct pt_regs *regs is still passed to x86_pmu_handle_irq(). There
is no functional change for the existing code.

AMD IBS's NMI handler doesn't utilize the static call
x86_pmu_handle_irq(). The x86_perf_regs struct doesn't apply to the AMD
IBS. It can be added separately later when AMD IBS supports more regs.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V8: Use x86_perf_regs for xen_pmu_irq_handler() as well.

 arch/x86/events/core.c | 5 ++++-
 arch/x86/xen/pmu.c     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 17e122e27e0b..17c8f44ee43b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1788,9 +1788,11 @@ void perf_put_guest_lvtpc(void)
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
@@ -1814,7 +1816,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	x86_regs->regs = *regs;
+	ret = static_call(x86_pmu_handle_irq)(&x86_regs->regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 8f89ce0b67e3..de3d7d391a5e 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -455,12 +455,14 @@ static void xen_convert_regs(const struct xen_pmu_regs *xen_regs,
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
@@ -471,7 +473,8 @@ irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
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

