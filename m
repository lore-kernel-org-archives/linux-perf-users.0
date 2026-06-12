Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CF3A4F3B;
	Fri, 12 Jun 2026 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255223; cv=none; b=oWv6BdXLhcCn6/dClTwvr3/hLqiOG66eulBkXBdCLbBKUpdBxXZwhPV+FuzdlcwgFicCSv8PzGTxTsoakALh3kpdgvybHgW+U0P+hbcexsjyjH+jEJOmcoxndYh0vKIio9yo1T/sUEY499Vz/fihw/rAA+TZBCPyF4gNYdip8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255223; c=relaxed/simple;
	bh=LqWga/INHK1rzH2ms2/El4jnpXfJdHBn3fdrz2yDfPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGSFfv6BlpmXJ/nWqVCwxVqJMFVLfxCGlmISi3g5lrWnMJ6TTCAXwZLtmFFohqHWkflTBnbqEBhXa3YXwp/Bsg5ay8cCb+1oWoDD9kwShUH9vu8PWCTR/6Z7oWoDn0pqURBjLKEKyVgj2QWBoTmuG1koNSqx2qdZHBzrCpkN8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEcNr1y2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEcNr1y2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255219; x=1812791219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqWga/INHK1rzH2ms2/El4jnpXfJdHBn3fdrz2yDfPo=;
  b=KEcNr1y2sKlVE+FVVoJ3KzcaDm+AhNIsD9+/85op6C8SBNFIRENAk6Rw
   msfq5JzUg2Kvyk7QyGHYVGZ1URMPKwTB5QnWIpklwT6to93T3EAwjKPsW
   /73eYPUz8PkU8TNKE53lPxQyRpsqz6Z9oRafdjspuLaE5UF0mpeqor/b+
   ARzBQEjUIE0fJ6eU+6jSAiiXkw93dDLYfxKNd/Z+57jPIW4KwniFdVVVp
   TUAF8+6TuBB3TajKzVxgRK13uWb7PYDpYUAEZJhIJ82MaxxoTzY1os9pq
   qz+3Xb+KPaE9X90w+NyVdvPbfDLd5WeWn6QAqlyEo9+MFp83Mlit2mH4J
   w==;
X-CSE-ConnectionGUID: 4mR18ZJJR0GBVlAwwaNlHQ==
X-CSE-MsgGUID: 3d6C2g73Q06FyQhbNelDTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714479"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:06:59 -0700
X-CSE-ConnectionGUID: nIraCesPSuCse0ylGObgug==
X-CSE-MsgGUID: lwTcnybUT5qo0+YKj6gYjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838772"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:55 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [Patch v3 7/8] perf/core: Fix kernel register info leak via hardware skid
Date: Fri, 12 Jun 2026 17:01:13 +0800
Message-Id: <20260612090114.3188886-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unprivileged hardware perf event using exclude_kernel=1 can leak kernel
register data to user space via PERF_SAMPLE_REGS_INTR or PERF_SAMPLE_IP.
Due to hardware skid, a PMI may trigger after the CPU has already entered
kernel space (Ring 0), bypassing the perf_allow_kernel() privilege
barrier.

This security vulnerability is severely exacerbated by upcoming support
for SIMD register sampling via XSAVES, which could expose sensitive kernel
FPU states (such as active cryptographic keys).

Fix this by ensuring that sampled register data is dropped if the event's
exclude_kernel attribute is set but the PMI catches the CPU in kernel mode.

Link: https://lore.kernel.org/all/20260529085613.CCAFB1F00893@smtp.kernel.org/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 kernel/events/core.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95d806bba654..89f6c9ffb964 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7792,10 +7792,20 @@ unsigned long perf_misc_flags(struct perf_event *event,
 unsigned long perf_instruction_pointer(struct perf_event *event,
 				       struct pt_regs *regs)
 {
-	if (should_sample_guest(event))
-		return perf_guest_get_ip();
+	/*
+	 * Hardware skid can lead to a scenario where a PMI is
+	 * delivered after the CPU has already entered kernel mode.
+	 * In that case, user-space sampling must not expose kernel
+	 * register state.
+	 */
+	if (should_sample_guest(event)) {
+		return event->attr.exclude_kernel &&
+		       !(perf_guest_state() & PERF_GUEST_USER) ?
+			0 : perf_guest_get_ip();
+	}
 
-	return perf_arch_instruction_pointer(regs);
+	return event->attr.exclude_kernel && !user_mode(regs) ?
+		0 : perf_arch_instruction_pointer(regs);
 }
 
 static void
@@ -7829,10 +7839,22 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 }
 
 static void perf_sample_regs_intr(struct perf_regs *regs_intr,
-				  struct pt_regs *regs)
+				  struct pt_regs *regs,
+				  bool exclude_kernel)
 {
-	regs_intr->regs = regs;
-	regs_intr->abi  = perf_reg_abi(current);
+	/*
+	 * Hardware skid can lead to a scenario where a PMI is
+	 * delivered after the CPU has already entered kernel mode.
+	 * In that case, user-space sampling must not expose kernel
+	 * register state.
+	 */
+	if (exclude_kernel && !user_mode(regs)) {
+		regs_intr->abi = PERF_SAMPLE_REGS_ABI_NONE;
+		regs_intr->regs = NULL;
+	} else {
+		regs_intr->regs = regs;
+		regs_intr->abi = perf_reg_abi(current);
+	}
 }
 
 
@@ -8723,7 +8745,8 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
-		perf_sample_regs_intr(&data->regs_intr, regs);
+		perf_sample_regs_intr(&data->regs_intr, regs,
+				      event->attr.exclude_kernel);
 
 		if (data->regs_intr.regs) {
 			u64 mask = event->attr.sample_regs_intr;
-- 
2.34.1

