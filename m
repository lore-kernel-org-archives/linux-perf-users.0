Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940156;
	b=25TiHv6gqqkpAevPRJQsifJtyyKpefj2UgKSSZok7sbzDfd4HHfvoxyvLL4T9XZeVFMS
	 CgJvci6SVi6TlGlloozo9N8AUm1Fyx526Dog5QR8IiaCYkJJNWMlchchKz4Fi87LoFXav
	 c7uI9aeN2r63hC5RacXKTTuhlJ+o1tk7JLjhwONZrjRf2zqEmV1DTRQKF4jFatJACZj+D
	 0bmh5UCvqz4amBsTvlzX3fIpcP7hH6zJ6KtkTH14LGXrfwz8R9qY3dMOmGs5QvMVBtsls
	 O+wLgZkPeRfJYo7KzuKfUm4vWDqqVsxWGFMp+Q0/byQQs4b52poa+p+1hMuPEIyrX3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940156;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=99eirPRWINMHRIk433o5e/g+0/670ROgU+69Re1F90Q=;
	b=q5B6OMVf/gTW7D5xGlQb5ZvD4MwixHUa7T//yemSmv9hvGF7aoYDTIgaNFF3QYJ40hOq
	 kihjXB1CdrE5B6E8Cj5VD+pG6ZeDkxKWN3YVyuxtijuM6JvXDm/kqxzQO6f7TU35FI7m0
	 j+LoYz0oE3QKNeCLYg11IU9FW/4O43XZr3FYKIHOh/EZ+5egE6uj7p2dHTd5Q7MUvUAQN
	 j7ugfJJB44WCrzF3HnFitLgxIRQW96GK72coot7h0ZzpHlkncBeArf/ObNObd/20XA6gA
	 JZlohOkrcHRtXCdxmhV8CZ8FSHW5DiQFcqwr1vrdaofzDFztvbRSmSYybcHWmOwsOrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MA4UYnIV;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0F606A33A;
	Fri,  6 Nov 2026 04:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD0F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MA4UYnIV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940156; x=1825476156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lSQgD76tCo+X8cEqcw22PclJMXEzAN4QRZffvAzHwP4=;
  b=MA4UYnIV9Hzum4dsSePk9tXkumRM/uAlGiJWaIdiwZ8QwLuQ+ciI5JVV
   jm5NMveinLBj8QYcHt4Ji6WVO7ax/wIWAz8aBenRH5f2Y2z3KbaWpxEWR
   jPg6gNjcCs7ba2pbd77XM4s6c0VAiu4osMCPGesay5FpzCsroBXgDYilx
   oL3+bGzgAM88jAEUda7Y4Qnywg00ijTHSOKkRAC/Ab/VnBz7wM3PY3MJH
   01pIFBRlUDjQV8vU5/OowoOkpgR9zwi1kjJ6fj/cAe/o5SpHsORyP521D
   idZHp5sb0xMacIExkZx8oVj3OLP81hNpIwSljGaDnKlS6h1hekQvzIt5I
   A==;
X-CSE-ConnectionGUID: /5rkNvVaSiqN3ZcMQ8ZXLA==
X-CSE-MsgGUID: gyZCbRRcTRO9dT4vLEGbow==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780929"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780929"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:49 -0800
X-CSE-ConnectionGUID: folx+3vORluwfl/DpNEYpA==
X-CSE-MsgGUID: X8ITbZlpTeWxdSki0oBoaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7223003"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:45 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 15/20] perf/x86/intel: Refresh LBR stack for non-PEBS LBR events when needed
Date: Fri,  6 Nov 2026 12:32:52 +0800
Message-Id: <20261106043257.842864-16-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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

PEBS and non-PEBS events share the same LBR stack in cpuc->__lbr_stack.
In the PMI handler, the non-PEBS path refreshes the LBR state before the
PEBS buffer is drained.

When PEBS and non-PEBS LBR events overflow in the same PMI, draining the
PEBS buffer can overwrite the shared LBR stack with the PEBS snapshot.
This leaves stale LBR data from the PEBS record in place, so userspace
can see the wrong branch stack instead of the live LBR state at PMI
entry.

Track whether the LBR state has already been refreshed with a
lbr_refreshed flag. If PEBS events overwrite the shared LBR stack before
the non-PEBS LBR event is processed, clear the flag so the live LBR state
is refreshed again. Remove the unconditional LBR refresh at PMI entry and
initialize the flag as false so the stack is refreshed only when an active
non-PEBS LBR event requires it. Since the LBR state is frozen while the
PMI is being handled, it only needs to be read once for multiple non-PEBS
LBR events in the same interrupt.

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 40 +++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fbde874af618..b267c68f9467 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3864,8 +3864,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int bit;
+	bool lbr_refreshed = false;
 	int handled = 0;
+	int bit;
 
 	inc_perf_irq_stat();
 
@@ -3906,6 +3907,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *)&status)) {
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
+		/*
+		 * Prior to adaptive PEBS, PEBS does not support LBR snapshotting.
+		 * Refresh the LBR stack explicitly when LBR users are present.
+		 */
+		if (cpuc->lbr_users > 0 && !x86_pmu.intel_cap.pebs_baseline) {
+			intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
+			lbr_refreshed = true;
+		}
+
 		handled += x86_pmu_handle_guest_pebs(regs, &data);
 		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
 		/* Ensure no "suspicious NMI" warning for empty PEBS buffer. */
@@ -4003,8 +4013,19 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 *
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
-		if (is_pebs_counter_event_group(event))
+		if (is_pebs_counter_event_group(event)) {
+			/*
+			 * PEBS counter sampling is only supported on adaptive PEBS
+			 * and arch-PEBS, both of which snapshot the LBR stack.
+			 * No explicit LBR refresh is needed here.
+			 */
 			static_call(x86_pmu_drain_pebs)(regs, &data);
+			/*
+			 * Draining the PEBS buffer can overwrite the shared
+			 * LBR stack, so mark lbr_refreshed as false.
+			 */
+			lbr_refreshed = false;
+		}
 
 		last_period = event->hw.last_period;
 
@@ -4013,8 +4034,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
+			if (!lbr_refreshed) {
+				intel_pmu_lbr_read(cpu_lbr_stack(cpuc),
+						   cpuc->lbr_counters);
+				lbr_refreshed = true;
+			}
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
+		}
 
 		x86_pmu_clear_perf_regs(regs);
 		x86_pmu_update_perf_regs(event, &data, regs, false);
@@ -4070,13 +4097,6 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	/*
-	 * No need to read the LBR stack when all LBR users are PEBS events,
-	 * since the PEBS handler updates it.
-	 */
-	if (cpuc->lbr_users != cpuc->lbr_pebs_users)
-		intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
-
 	/*
 	 * Do not clear the LBR frozen status here; keep LBR frozen
 	 * throughout PMI handling.
-- 
2.34.1

