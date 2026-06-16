Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D173CB916;
	Tue, 16 Jun 2026 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585577; cv=none; b=f50xUUROzulRzeCWGhqyr9xxWsTre6Qruv9Httng/OS5hveMEr/A+k5SKgzJFgWE+lA8tANXq2cuOl3b4RFCH9AHfR5IYj3Bs0mC+p5BY42nrNvXEXOGe+uM+shlSTt8BozdwkVoD6+6D/JJLpJRd8tTBDxTsXcTb5YsqfLai/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585577; c=relaxed/simple;
	bh=LqWga/INHK1rzH2ms2/El4jnpXfJdHBn3fdrz2yDfPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ek7Nv/vul85SwpimsGwmOxLyQArd8xzRve/y2z1ubgYCFEoJlXPcuo//rklNHqsGvS1Oe3ITXbd5KpTyXyVOX6z9Mfg8Wa1RV0luk2q51RRBxKIS2R9jcLbwimg3uSo8CabfPHFN9mK1+eEVKP+l/e3OzFanv5MWOxpxb+ZfsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEw0leTb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEw0leTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781585576; x=1813121576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqWga/INHK1rzH2ms2/El4jnpXfJdHBn3fdrz2yDfPo=;
  b=aEw0leTb7V0SiSccpoUXo2s4LZRDDwL7dCcBm3HHK+I9ymaTfezOMGuy
   7LjxlON65ZHgBERXYMBoUQi0OUJ+SicrdE63IZJO530+bpQkWNJ7MK5u2
   QHT4jnup7AqqLE3+kUOKBsde8D042i+toE8tN3Gab1nf0M6VbKvdlrRPt
   6DZvgGckzNc+JlQEUJmOaoFq16OGbo7dCv7tVd86G75YrUOTJ1r83fruK
   veRucYKNyzubtyIeWfF6/q0ZK4kKMlTGqlaj/80ZLO8H97eJdKDShFVbw
   8NcuFx4QZHwq2vfO0xAYPWe3rk3sDvWowkMR2qs09bDa3/kxyULmV9N0c
   w==;
X-CSE-ConnectionGUID: kwIVet9MQnC3Gbx1rKQTAA==
X-CSE-MsgGUID: mv6dYyxXR4Or2fkQ0T4vVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82445502"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82445502"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 21:52:55 -0700
X-CSE-ConnectionGUID: AKRGOzvsSO+EQkiztO8CqA==
X-CSE-MsgGUID: 1hPwagZXQzm8bvHcBt6mOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271726526"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 21:52:51 -0700
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
Subject: [Patch v4 7/8] perf/core: Fix kernel register info leak via hardware skid
Date: Tue, 16 Jun 2026 12:46:53 +0800
Message-Id: <20260616044654.3468742-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
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

