Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF034250E;
	Tue,  9 Jun 2026 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981695; cv=none; b=XPb9k/AkIv+NFFvUVERwjO0DEYwpBNsGw8NP65rkfsxczsAJr9lir5pDBZPqeQyKgfBY+DcQc6EzLjloTEHCH9o2SoUeG6Fy5s0BQX0mP8ywaFgpC48FaW98VbmuMbX5sw61OyHGhUkHXHbJGxPemktddzkk0iNnn6ex+ZorjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981695; c=relaxed/simple;
	bh=/HMpJYUnRjLOLb0b3XgXdYUsgp3rc8FEEUh5u0chOs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mR+I3Lzzxtmoovjc8EIkYzKL9rgayz4FksRQyCzMSJYP3JR/kIT/YFKA6gtLrilURceCIgv13YpjIEKiwVMuXKu7g7Ep00uFo8w/k7ltsxzjzJD/on9sLyUlNFNIA9lW0Y1Tn0Mkt1yFs3nmDhtcT00RXMu+jleDDZBudyUwC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAOoTV/r; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAOoTV/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981694; x=1812517694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/HMpJYUnRjLOLb0b3XgXdYUsgp3rc8FEEUh5u0chOs4=;
  b=oAOoTV/r9yimXFtFG+/SVUC9yIGBCnejDucRANl9HARgUy/KSCUf3NET
   V8Ljspn7Sj6BoJeAhUyuR7TTY0xq9r5pmHGQRK039/VCH/+BCtnMFnony
   Gmlc282JrnuXvgDeXstaFb1fXtiolAziNH0xA+8SYizWt7F4xyC3f3ae4
   6YKJd4Z0fy/wgcF8QRSzBllkV0xVHtB2N2bEsr4eNIuETaoZ64SDSuR6F
   U170Rwiw/VFxiLnz/Z3u+a3IJfxLdHisCxo6KgZJam6ugN0oMrc9uiIU+
   u2rwpbH0SXIa4o/rMN8r6sJ+C8V4wpmCsly0aPINMMaSHEhEfgJdioz4f
   w==;
X-CSE-ConnectionGUID: hMFmGAmtSlul/S8DgdCplQ==
X-CSE-MsgGUID: gszq5vlzSQeiAma6GVdk2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586199"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:08:14 -0700
X-CSE-ConnectionGUID: X02cEoFDQR+t35v8rXsEgg==
X-CSE-MsgGUID: cPBOwXGcRJCT6qXQ8KlLqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838937"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:08:10 -0700
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
Subject: [Patch v2 8/9] perf/core: Fix kernel register info leak via hardware skid
Date: Tue,  9 Jun 2026 13:02:21 +0800
Message-Id: <20260609050222.2458129-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
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
index 7935d5663944..1bde029eeca7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7763,10 +7763,20 @@ unsigned long perf_misc_flags(struct perf_event *event,
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
@@ -7800,10 +7810,22 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
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
 
 
@@ -8694,7 +8716,8 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
-		perf_sample_regs_intr(&data->regs_intr, regs);
+		perf_sample_regs_intr(&data->regs_intr, regs,
+				      event->attr.exclude_kernel);
 
 		if (data->regs_intr.regs) {
 			u64 mask = event->attr.sample_regs_intr;
-- 
2.34.1

