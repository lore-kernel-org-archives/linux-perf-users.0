Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940156;
	b=IcTMld1eZmUFNkvix/GqKX+EXATJiU4kvGFYLiuREPfyeHr5QpjXbliqxSkacYUAKJSp
	 VmmJUgDKbGoNf3pwqlBjHVJxdzE1gkmr7dJZUR8z0mSO6LV1K6AjLJtcKCe/iKirF3OiG
	 VB0q8Jd70pgyIXwazZ8ebt1oRZoCcpskPdPbgqRRotVDQOQ7Y5lScOslh3OeRxJgimDUm
	 KU+oPesJOE1DGFaMYT+3GrohXj+AD2wryMwUVFhVW1ie10ldLa1AqoATRRLh8e9pimI4K
	 vPYxbQAIy31JbNemVQg6kPXGUzG5s4CYXsCsEgFUF/tD5LSDVzJSYnufobJ9FCBO5Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940156;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fGvX3/a0vC7nlTjAHSMPcYCuo1tQSG8MJBCHqXDvNlw=;
	b=G2B5XIlfEM63vdFLKNoyiN/8hPV4FPquvxF0vPX4IuUateR9iIyJlqvZ1HAxPe8+FSn3
	 Z94TIEAS5HzQCkZ8IgIBb6acQb2Ymd/BkNMVoqP60N4atnUnB2B0Ah9e5eOrr1+WEiVXV
	 vPH/QGZOxz63+RUpV+uL1f4s0UQHDL66vmSR+0cS3zDbEDFBPW1JhGB2LnT2D+PRntroF
	 u4c4zKayno39CwSXi1fZDqqCm86ARoGjRqy1sEddxqLnFYJ4VKBdN8xPJgEYDllBacJyi
	 Z77WwjNbL06F3i1SC4zaihOY7pDxzg4hQh7ogAkweM8E0Z0BG2FNm/OVkjtjmoIr7bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g2q+sw2C;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067E606A338;
	Fri,  6 Nov 2026 04:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8067E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g2q+sw2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940157; x=1825476157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=anigBFNvLZFvrEcI1RE7HwrxHGo2njaEoqKnElay2RA=;
  b=g2q+sw2CSiulqDqjncBvMe3dLFb7eqd/uDf3DRm/v3ySZmbBl71v/nOd
   GRhDgBo3mQUNQyuxNEidBT0/vtre9bPyUnyxT5NPtqoXP2gkzXtb8b5mj
   t7/sTLiYWZs9BoaHGPrHjODhwvzYkxgkXcxI5++ijh+jE9zZkZaJ32lAW
   DTf55tYDIQyseQMlvJRsNQOzc8j+KbU5G3T+ZebfHf0yoV1TG5fUCtZYu
   jhfCES/hM7TIGC2eJwG3JxT3LTQNJ/+gL/Hy6s5MIUxCiRaa3oI3pkhjm
   XB7QokC0w0IFyFEFhv2qA9VGmyVOxwTULIwvWJYYkWZzcBq2dXX0r9dCe
   w==;
X-CSE-ConnectionGUID: 1rqMSTZ3Q7W9cJl4SsvGVw==
X-CSE-MsgGUID: P3XALOGyShmFhEcEXEhezA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780947"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:54 -0800
X-CSE-ConnectionGUID: IQwJY9/CSl2DmnoLrUVLaA==
X-CSE-MsgGUID: klv1oIh7RXyIy6UmSgTv4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7223012"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:49 -0800
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
Subject: [Patch v6 16/20] perf/x86/intel: Remove dead lbr_pebs_users
Date: Fri,  6 Nov 2026 12:32:53 +0800
Message-Id: <20261106043257.842864-17-dapeng1.mi@linux.intel.com>
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

The lbr_pebs_users accounting is no longer used, so remove the dead
field and the related code paths that maintain it.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 5 -----
 arch/x86/events/perf_event.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 27e4be839926..3500cf3518f4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -617,8 +617,6 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	 * be 'new'. Conversely, a new event can get installed through the
 	 * context switch path for the first time.
 	 */
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
-		cpuc->lbr_pebs_users++;
 	perf_sched_cb_inc(event->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
@@ -688,11 +686,8 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
 
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
-		cpuc->lbr_pebs_users--;
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
-	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
 	perf_sched_cb_dec(event->pmu);
 
 	/*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fa0af528cd1e..0213e2a8efff 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -526,7 +526,6 @@ struct cpu_hw_events {
 	 * Intel LBR bits
 	 */
 	int				lbr_users;
-	int				lbr_pebs_users;
 	u64				__lbr_stack[LBR_STACK_SIZE / sizeof(u64)];
 	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
 	union {
-- 
2.34.1

