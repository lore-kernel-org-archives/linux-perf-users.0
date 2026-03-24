Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B773368A9;
	Tue, 24 Mar 2026 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313180; cv=none; b=jhmuqhXqYapkYCM0uXAeyX3Z+lJ9Ku8v1L/Z7iKA4B0qjS7XVkiQCHJ5tdSCyEecPHdhQ+Qa4cMejTa9nKMJJ3ppMLrDOpZSANiXNXrglsUKAyURAN8X0gr7kpgZh+7VmyjRKhvsK9FabEj5dZKazCwKHf/3r///Iw40XJtFOoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313180; c=relaxed/simple;
	bh=YPwdksZY9flUYU+BXIQ78U8LxMq1uu73KMPaOrlJlDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxMpyiduAgSfwCQkO77e6Jbha97U/6U4lBU78nIUJU8XfPUbpt8W74+XlJqsDpeL0I88YapgHqvE+11hZKi5TqjJHmWp27U4nfLKc3wb78z+4AC5PU3fEhkGAdhvyTBFQTB6ArGxDsaBeRINENus2jSj0109v9G9vyCVBOt/aqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsZIjjPq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsZIjjPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313180; x=1805849180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YPwdksZY9flUYU+BXIQ78U8LxMq1uu73KMPaOrlJlDE=;
  b=jsZIjjPqfT6R9n6675RcPiafeCS7FdQCYIfddTfz7ApFjqpX7+qFqPNI
   6xKhUOky6IxFiPB7XI4Fg+WDpDQdi7rsfeawGvsYHucou05uJ5Q2gWjeM
   5PoN6aMFVNUXaV/rL9FNbN1y9tnZBKv0fkavnWZgB40eowtKEH0qLmFDr
   NwTN8picqGIcTbiAQbTQTU6uHC3M4BbR5NB58f+9/BnaiDjeno6XAGJXk
   +QRoBwupPaf5nkYHx4dMCygvUn0r+kEdSLBoRnQG4om76AXguLBqh7ITF
   s4J33lDjJv8n9uFf/519WC5KSJ6SanP/qTEzbWdZWNJbN7dzxoXkebR3j
   Q==;
X-CSE-ConnectionGUID: 89ZWDUocS2KJi7KFyqSnUQ==
X-CSE-MsgGUID: FfwFUtnfSsKxHpxEL2Zrtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397054"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397054"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:19 -0700
X-CSE-ConnectionGUID: vorp4ajcQySGM1M1Frrl4A==
X-CSE-MsgGUID: muSkuVMvSVC2hSm+hgElfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322684"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:15 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 06/24] perf/x86: Use x86_perf_regs in the x86 nmi handler
Date: Tue, 24 Mar 2026 08:41:00 +0800
Message-Id: <20260324004118.3772171-7-dapeng1.mi@linux.intel.com>
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

From: Kan Liang <kan.liang@linux.intel.com>

More and more regs will be supported in the overflow, e.g., more vector
registers, SSP, etc. The generic pt_regs struct cannot store all of
them. Use a X86 specific x86_perf_regs instead.

The struct pt_regs *regs is still passed to x86_pmu_handle_irq(). There
is no functional change for the existing code.

AMD IBS's NMI handler doesn't utilize the static call
x86_pmu_handle_irq(). The x86_perf_regs struct doesn't apply to the AMD
IBS. It can be added separately later when AMD IBS supports more regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V7: use per-cpu x86_intr_regs to replace temporary variable in v6.

 arch/x86/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 67883cf1d675..ad6cbc19592d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1782,9 +1782,11 @@ void perf_put_guest_lvtpc(void)
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
@@ -1808,7 +1810,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	x86_regs->regs = *regs;
+	ret = static_call(x86_pmu_handle_irq)(&x86_regs->regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
-- 
2.34.1

