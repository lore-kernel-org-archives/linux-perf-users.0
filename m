Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8F3B42D8;
	Fri, 10 Jul 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666690; cv=none; b=d2PAn4mEK+R0LKy5n4alko3AciK66TVuGuttmjVbb4KmmWrVL9ONI+PXfM4LcdvQ6Ohgk/oxO8lBFlTEh7VxzvuMIxEkLo5OdFbA2kxGcfTtJiNkrU56v01jNAv5SqSWIaUsm2CFAuZKjJ8hHktXr07goDFeyXb/z7jaKiZecF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666690; c=relaxed/simple;
	bh=8S09QdWdLrgZxEpSqXviQuROpHFyDeq3D96u2IBgg3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkvkufBKP2+lN5sSo/SAfi0f+zEBlbC5QJosihnlFU5AYP/lO/vGrAP5s6awj33a7HAPUWbH7i1mNnJHQLZNgBSLBLLd+IvRCZjSO6tZ+bQSGS0ZMZv0aqk7dqAV7pk2feMwqaQ0FATYW8l/Owih5BFoYMm35aq7FxCb4dbWgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PsjoDA3S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsjoDA3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666686; x=1815202686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8S09QdWdLrgZxEpSqXviQuROpHFyDeq3D96u2IBgg3M=;
  b=PsjoDA3Sk1vYobR83rMRKGtVe8VJVLCu1vMwEV2u54KCzciSCwSqYfSj
   iHW3q9pOMxErdj6xEkVT92jLO/OumPVY0ExCNJg2CKWnOJENIHuGZohYt
   CB8Ad3K3Cy7FnqqXKdnXkVoNyh0Sn8+ge6Q0Ba+VYu+Tt2EpVrJ0JK6En
   aZjAgn5+jiG1NKecxAHb0+0xM96IL5GRvIPnNdi9MYy+UwMfUp+RZOF8n
   AaiSt6FOdEticediCVXnuDFcFz4QDV7SAHrbLJPvguDix0azdc8HRzC0F
   V4dJnTx2hQwWgyZNuBmO4s6FgsUxMxc1L/l3s3m6F1Ho8pjZTRXz1na/1
   g==;
X-CSE-ConnectionGUID: cD6FukV5TpumB0tlzyKCUA==
X-CSE-MsgGUID: uKBzKBvKT7WgmX7bTa4qlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554239"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554239"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:58:04 -0700
X-CSE-ConnectionGUID: fL4J414KSpuIfUCW1FVQWQ==
X-CSE-MsgGUID: aVoqNAbHTGuWCRVjC9fN6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159274"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:59 -0700
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
Subject: [PATCH 7/7] perf/x86: Optimize ACR handling in match_prev_assignment()
Date: Fri, 10 Jul 2026 14:51:28 +0800
Message-Id: <20260710065128.1799838-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
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
---
 arch/x86/events/core.c       | 13 ++++++++++++-
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0bd3798b6e33..6a7502d2ae6e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1292,6 +1292,17 @@ int x86_perf_rdpmc_index(struct perf_event *event)
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
@@ -1301,7 +1312,7 @@ static inline int match_prev_assignment(struct perf_event *event,
 	return hwc->idx == cpuc->assign[i] &&
 	       hwc->last_cpu == smp_processor_id() &&
 	       hwc->last_tag == cpuc->tags[i] &&
-	       !is_acr_event_group(event);
+	       acr_match_prev_indices(event, cpuc);
 }
 
 static void x86_pmu_start(struct perf_event *event, int flags);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 088f7ce715df..d382e5ed72a8 100644
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

