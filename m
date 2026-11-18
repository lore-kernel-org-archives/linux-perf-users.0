Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972259;
	b=Xczl7Fnj7HUmcexov8mwhqdOmZqZg37u3YUKgGPG7zeqzuliPnR/hxTikp8iWx30xuLt
	 420P9GLQOZNAYKFxXwmnmU3CKz7xvFRO0o54lkicl3luq9Z9fFXE2M0a3DsGObRCZ6xnN
	 L5nORrTQ71Z4aMDnXOyCRznLy4oSeJGlY7ILqIESRID+eoKQTHbUmRwoJGVD4l7X6LS6T
	 j0agVynMBeXUA7RVHCBRFsO3dUDN1/U6hZAsGRrbSfENlucXPdG9IgRLhshegMC2CYHnQ
	 V0f1mdog/wxJPBpfJcluZATuweLep1PpVElubaev/eePZKn7XAGIwSuAlitomGSegsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972259;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A7skZU9uGti38aZnT/uADJ4YXUdAQ0zjEcJpJAUQfhE=;
	b=qytU7Sf3RxyT6Z4xVI6/AoUxa2Bx8eo0CYPv8dDXyg6gw9j6oLpbHN7koLuAbGYX7N7a
	 m/C9RC6YjVLrI++m1QqJ5ZVWYAEwLTnDWRSOoGQ9lJYa/T0QpMDzlYjz6EePPur2rY1r/
	 6Rapvgk/oi/0tkcxpK4Ly4xkC68iHfqhtn4WS/I+z58jyaojgzFZNmIQP0ZuUJb1S0EQu
	 ro6bwKML0grcQJYFKETbIc+Ife2EUQTRpgVkP9msJRPYuAP6tuyGWSOOm31FCGHEdjxVJ
	 hyIsaGOQZR416l6cVvrDI0NELU1NKJb/eePLvHpuMJnoKVbrZjkQ5z1bWukMay8uEFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B4KcTIZe;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1432606A31C;
	Wed, 18 Nov 2026 03:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1432606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B4KcTIZe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972259; x=1826508259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaQlyboidAG4Y7EfXwH4AsD0h9DSHC2Qjk/UMDAxgq4=;
  b=B4KcTIZebTCkPjwj9F14z4f/Nok83chkOh+qwI0Fyi8hOGkrAR3EhKjI
   52LymuWFFQrVG7g4xbtf9CzSz0Nf7renJL2ygb/qyfI+TR/g6zMsrIN/N
   MD7YZ1MKN0DSBzJkQtQbVYf31J5GWJM9QK1pOozVRA39Ype7xwqwcnWWr
   hncD/Ag7gVeuZeQuytAa/c7O8yMHv5X6q0z0saH6gV1tMBr+WE3ZFtWCp
   ijEnWBD3jLcpMvCv4uTHA9C0Xpo6U7Zj3iJKL6WD2twxjZtRwmI4nhQ6N
   dXlhVLuH3HSrMDWuojeCUm0B5GlW3Ym6LpcPUrfYqiAkWOU9rr7jSwFpB
   Q==;
X-CSE-ConnectionGUID: e/v/hwDORSSEZvdZ5QaE0A==
X-CSE-MsgGUID: 61YHZ4INQCymO+xjWG0oGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629998"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629998"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:19 -0800
X-CSE-ConnectionGUID: HIdAMWh+Rb+0dZ31mvSzRQ==
X-CSE-MsgGUID: 1drpI484RL6KQvroqLpiQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894348"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:14 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v7 19/24] perf/x86/intel: Drain PEBS buffer for branch events with PEBS LBR users
Date: Wed, 18 Nov 2026 11:14:48 +0800
Message-Id: <20261118031453.1353625-20-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an event needs a branch stack while PEBS LBR users are active, the
PEBS buffer may get drained before the event's sample is output. The
drain overwrites the live LBR snapshot read by the PMI handler, so the
stale PEBS LBR stack is reported to userspace instead.

This can happen, for example, when:
- The event belongs to a SAMPLE_READ group that includes a PEBS event
  snapshotting the LBR stack, and a later perf_event_overflow() calls
  perf_output_read_group(), which drains the PEBS buffer via
  intel_pmu_read_event();
- The overflow triggers group throttling, disabling a PEBS LBR event and
  causing intel_pmu_disable_event() to drain the PEBS buffer before the
  live LBR snapshot is output.

Thus, drain the PEBS buffer whenever the overflowed event needs a branch
stack and PEBS LBR users are active.

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 54 ++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 67275a873dba..ccd2c57931b3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4027,24 +4027,48 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 			continue;
 
 		/*
-		 * There may be unprocessed PEBS records in the PEBS buffer,
-		 * which still stores the previous values.
-		 * Process those records first before handling the latest value.
-		 * For example,
-		 * A is a regular counter
-		 * B is a PEBS event which reads A
-		 * C is a PEBS event
+		 * Drain any pending PEBS records before handling the overflow
+		 * for the event in two cases:
 		 *
-		 * The following can happen:
-		 * B-assist			A=1
-		 * C				A=2
-		 * B-assist			A=3
-		 * A-overflow-PMI		A=4
-		 * C-assist-PMI (PEBS buffer)	A=5
+		 * 1) The event belongs to a PEBS counter event group. Other
+		 *    PEBS events may record the previous count for this event.
+		 *    If those buffered PEBS records are processed only after
+		 *    intel_pmu_save_and_restart() updates the count, the counter
+		 *    value will be corrupted.
 		 *
-		 * The PEBS buffer has to be drained before handling the A-PMI
+		 *    Example:
+		 *    A = regular counter
+		 *    B = PEBS event that reads A
+		 *    C = PEBS event
+		 *
+		 *    Sequence:
+		 *    B-assist            A=1
+		 *    C                   A=2
+		 *    B-assist            A=3
+		 *    A-overflow-PMI      A=4
+		 *    C-assist-PMI (PEBS) A=5
+		 *
+		 *    Therefore, the PEBS buffer must be drained before handling
+		 *    the A overflow.
+		 *
+		 * 2) The event needs a branch stack, but active PEBS LBR users
+		 *    may drain the PEBS buffer and overwrite the live LBR
+		 *    snapshot updated by the PMI handler. This can happen,
+		 *    for example, when:
+		 *
+		 *    - the event belongs to a SAMPLE_READ group that includes
+		 *      a PEBS event which snapshots the LBR stack; a later
+		 *      perf_event_overflow() may call perf_output_read_group(),
+		 *      which drains the PEBS buffer via intel_pmu_read_event();
+		 *    - the overflow triggers group throttling, disabling a PEBS
+		 *      LBR event and causing intel_pmu_disable_event() to drain
+		 *      the PEBS buffer before the live LBR snapshot is output.
+		 *
+		 *    Therefore, drain the PEBS buffer whenever the event needs
+		 *    a branch stack and PEBS LBR users are active.
 		 */
-		if (is_pebs_counter_event_group(event))
+		if (is_pebs_counter_event_group(event) ||
+		    (has_branch_stack(event) && cpuc->lbr_pebs_users > 0))
 			intel_pmu_drain_pebs_buffer();
 
 		last_period = event->hw.last_period;
-- 
2.34.1

