Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF32E8DF3;
	Thu, 25 Sep 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780859; cv=none; b=KoxfDYk+eGxu1osTQg2CfMm9TToqhlo5fWH7prrbs5ZaC6U0fTffAsPY0gCXG9Ke/FShTdIl1j+8uqMlxIYErIwNe6s5tliUckrSUgh9XWfIOZsdpHTOLTnQJU720f5cHeWOLtL05Znt9kWBwq0LcRs7ksB992NqMwH2N+PxzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780859; c=relaxed/simple;
	bh=bVpOx/UplKaLc2pZjyStjI2aTE6kkIHTslupj0SqI34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxR2iJO1tgdmQm8+BUprVo4eLx7Za19/XT1G06K+fyavSm8hO6spLjaYpuJG//CJbm7GsyB+YLOwG6ND/T+VSMmxbPrjSq23cPgMs1CQrF6wXjFu/LwvXf9d5jGINAIsyvMRdEalEeNf0LKE9v0IzoDW6OO1ClaJRT7DgzGRYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kaqpiop0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kaqpiop0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780857; x=1790316857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bVpOx/UplKaLc2pZjyStjI2aTE6kkIHTslupj0SqI34=;
  b=Kaqpiop0d0yNdXLUhN3mpgl1AIGhLagpxMxBmDdKxjCk0BO70XpANkSq
   KkvaGDCWnQ78zHxb51RSYMGXgZ6g7rNpZmmEj7zyFluXXiSjcYpcsFMKe
   CotywJ2ORpemfK922NtI7noKu3KzqYj7p+igWpLiacEtm0KBjfJ41JBz2
   re0db+osNbwGXKAK3Vc53aMJBpVsJIovJQKAb+Z+iSWcaQAQUv0ZEAOtt
   Q6pMQQFIajtY75utOuSvqNPCJZ7gQ+7zUdlHOHaW6WUPsDoAalUwB+o60
   LgdvOhO9UOTOQ3wqXGIV1RDl5Y+7i1/BIVP+WnMwiFFEwovpaPJAW10tC
   A==;
X-CSE-ConnectionGUID: Nb0/Bxf0R9yhJzXdQCm8Bg==
X-CSE-MsgGUID: RNNlFe+/SmmP49GiH+hLSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139480"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139480"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:17 -0700
X-CSE-ConnectionGUID: aGX27sm/SlaBe9xfSiKN4Q==
X-CSE-MsgGUID: pLH3/d+pTcaJO4IJ1YFF1Q==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528283"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:12 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 01/17] perf/x86: Use x86_perf_regs in the x86 nmi handler
Date: Thu, 25 Sep 2025 14:11:57 +0800
Message-Id: <20250925061213.178796-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 745caa6c15a3..f4afef16cbab 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1752,6 +1752,7 @@ void perf_events_lapic_init(void)
 static int
 perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 {
+	struct x86_perf_regs x86_regs;
 	u64 start_clock;
 	u64 finish_clock;
 	int ret;
@@ -1764,7 +1765,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	x86_regs.regs = *regs;
+	ret = static_call(x86_pmu_handle_irq)(&x86_regs.regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
-- 
2.34.1

