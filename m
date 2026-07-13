Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FAD3B71B0;
	Mon, 13 Jul 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931632; cv=none; b=e3E0bZhEtGCOzMNYSkj7nzqC1G09HWJ+240Dkh3hPX8YROTgpjttXRdkrulYkcvWjTCj2tzOetPii9z7x6jG3Q31Hb2F1S9hoPdaqeqT1YltZ2TvvmyxhltTLp8F4O1tLaa2sSnASOb4BarEZ7+QodAqWtmIRE0K35H4eNyw8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931632; c=relaxed/simple;
	bh=JjRQDahHvHTmZRvDpD8gV7TkrX5uByr65wUx7EWU3YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6XTCvksnYCSXjD7+24dMz/fcsjPP73dBuikbbn9brROhR6drfJS+mPZC5apH8n3u2prK2OmfiDWYHF3M0r0gWGeGLZToP0dNe9qRVV30L73BZU+7zDc9Dj/Fcwi18s0h6ezl+rtHY80hufcwiG2WJjbeh6FIyxLh5OUTO4jnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmquFIDA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmquFIDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783931630; x=1815467630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjRQDahHvHTmZRvDpD8gV7TkrX5uByr65wUx7EWU3YQ=;
  b=OmquFIDAtXM4fP3VPyePJkn9z8oeufYK2x8A8CCglRRInlOOFlt4+WMj
   xOGpjfnzNFlyC4YC4WIw+maTf+UQSogPSfiUCg7RwQrebUdHntg4jWUH7
   LnTDMk5cgGF5l345WZJQ6C/8/FwGwjn+9R8wT9QwVhKYqOJGWqmjuNLhb
   LmFjGHIY+788IjaO97FjWXA7vizytEGGZUyRzGal1Z2oIeIwTbgwm8v4g
   dsQzIXAAH5h3DKcGrVbtf54VKqRKgZ4SREiPfT5rv9uxAIZYhQ3VbPt6g
   3hh5Xw4rwyLAdnoxqP2HrgTPhUGCYOsNZhIzMopWXHnjxXmux6BFolApY
   w==;
X-CSE-ConnectionGUID: UZnkJFyfSpSkwfCwg5cGuw==
X-CSE-MsgGUID: vH3y29eGRaq/r6bSabWGGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390123"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390123"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 01:33:49 -0700
X-CSE-ConnectionGUID: AgwzRcQCQAWv7Q9Wtp6AHQ==
X-CSE-MsgGUID: EmmXzLvPRV6+g6K1HZzL0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255560773"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 01:33:44 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 7/7] perf/x86: Optimize ACR handling in match_prev_assignment()
Date: Mon, 13 Jul 2026 16:27:34 +0800
Message-Id: <20260713082734.3162099-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
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

