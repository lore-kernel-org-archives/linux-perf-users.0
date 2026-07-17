Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C173E4C6B;
	Fri, 17 Jul 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275820; cv=none; b=Zb18t4UIRpqwu31XlhJV8U81oEhMtcW8LT4b0KuySbfSJYt4Go8rsNXDN6xc3iDItM2NFL4rCYimV6aNS0qz5IrInoQzfHpuADdiyARVrgwVyX9cl4x5EqXPAEtajJcR2VYJMgxQOm/TC2V3qgdNCxJ4IO2f7kspqq1NElP23nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275820; c=relaxed/simple;
	bh=2XoQz/r08PTbjhRF90PB9DNSQmS11LLXzQseGbyIEcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j+M12Et2lC99cr5wS8cNIBfLyrwcGufdYkhn3f22SDkzUUqFkat1PqMw5lVNA44yJ+1jruRC88u7v9pR+2xUhPBG5zD2QMpB4IYH0FNLU3kddbLiyNKdVQkO+UrWgmtYnm7fM9RYh+h9bSp+I0PhGWdlmlWlVGqkYknRbYqiJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRdVErbf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRdVErbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275820; x=1815811820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XoQz/r08PTbjhRF90PB9DNSQmS11LLXzQseGbyIEcY=;
  b=CRdVErbfgUYpZNbBnjCcmse7f/xmuej2y/MaCyH0gx8bHzbgEMrwOUCJ
   6XMwekw+5fSPlAz1FQ4vLDxPvjzzHKvXPbm/JzwMMzBYehsi+jG2D3mML
   zNorbOCZB8HBkKXvECV8Pgk2Ujxi3ESmc+B2ebIH4ogRsJppa7kfdEPlN
   lXPDxy2woYhxvhXvj4oBmEKbWSPpPDJZ1qZIG7v+KW0mE2W/99Z/kqYwr
   X3jrTcUAAHe68ovhzHiVS6QZT3GEMP6cS2C8ZsM+8kgiW3lJAAcvs8fg7
   t2g2dSQIY7sj+RmVcV4rR2TQ0jDp4c4d/Qn4Q1UdeeEuXamSe6UkglaWS
   g==;
X-CSE-ConnectionGUID: zCKeMzz1RMuvCrqfKXC78w==
X-CSE-MsgGUID: O7bXNtEbTVuzbUC4TXffoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065582"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065582"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:19 -0700
X-CSE-ConnectionGUID: b9KdwjRcQgC1OJc1ErRR8Q==
X-CSE-MsgGUID: 6yMxLjWARxCXLCgqRkAGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315482"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:10:15 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 7/8] perf/x86: Optimize ACR handling in match_prev_assignment()
Date: Fri, 17 Jul 2026 16:03:41 +0800
Message-Id: <20260717080342.1879573-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

match_prev_assignment() currently forces a mismatch for ACR events, so
ACR counter indices are reprogrammed on every scheduling pass. That
causes avoidable overhead because disable and enable paths must touch
multiple MSRs.

The previous ACR assignment is already cached in acr_cfg_b[]. Use that
state to compare the newly computed ACR counter indices in hwc->config1
against the cached value in acr_cfg_b[hwc->idx]. If they match, skip
unnecessary disable and enable work.

Also tighten is_acr_self_reload_event() so it first verifies the event
is an ACR event before testing for the self-reload case.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/core.c       | 13 ++++++++++++-
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 143a6e735d9e..8b3ea0adb965 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1297,6 +1297,17 @@ int x86_perf_rdpmc_index(struct perf_event *event)
 	return event->hw.event_base_rdpmc;
 }
 
+static inline bool acr_match_prev_indices(struct perf_event *event,
+					  struct cpu_hw_events *cpuc)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!is_acr_event_group(event))
+		return true;
+	/* ACR counter indices don't change. */
+	return hwc->config1 == cpuc->acr_cfg_b[hwc->idx];
+}
+
 static inline int match_prev_assignment(struct perf_event *event,
 					struct cpu_hw_events *cpuc,
 					int i)
@@ -1306,7 +1317,7 @@ static inline int match_prev_assignment(struct perf_event *event,
 	return hwc->idx == cpuc->assign[i] &&
 	       hwc->last_cpu == smp_processor_id() &&
 	       hwc->last_tag == cpuc->tags[i] &&
-	       !is_acr_event_group(event);
+	       acr_match_prev_indices(event, cpuc);
 }
 
 static void x86_pmu_start(struct perf_event *event, int flags);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cc9cfaae4f01..fa381110f7a7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -141,7 +141,7 @@ static inline bool is_acr_self_reload_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (hwc->idx < 0)
+	if (hwc->idx < 0 || !is_acr_event_group(event))
 		return false;
 
 	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
-- 
2.34.1

