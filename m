Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D06204684
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859362; cv=none; b=Q5a17goKPTn8Zo3X57t/7yczLKHyDbTXi6QWppakZj/U8XIV9216mazgAla03ulGu9GjOYy8Agj1uvdW7dpWZ50ZbXr/9+Cal2mkGfjFu6J4z99tE1Ut3Ujxf8XUWYlAOLPdQB17V0JYtqGDltAVp2OslLt1bwoq7Ve+Ub6/1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859362; c=relaxed/simple;
	bh=RZA0FdQ6HjnAZsZwnDxvnjvH70jyDRXe0PCoXNZ51Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZitG0gcapjVC4STBTovCwTGJypMqZaIoG+kQ8oA2OXM9NstuFEj3399ia0ZCMwBvLoVS0P72WUrnE6mm4GEx5wdL17i22HqzC4Eb4qrQVfE/rDuaUMnAISgM9BYyvZCNEJF+LYFtZQK8gRFF8SC+dT2S+9qcR39LV9RSZOg1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMwFu17v; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMwFu17v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733859361; x=1765395361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RZA0FdQ6HjnAZsZwnDxvnjvH70jyDRXe0PCoXNZ51Gs=;
  b=GMwFu17v6iSyqjy2zwD0/dqbuYri11DYm2H+EYbsAegNILfCHqwAG+w+
   Jzl3zoGyaRPc2ge5W3TI/lCbk3rl6QZp5Yv9V3KrZapEZCbxDqCwo0flC
   B1nsYJ5btQ2MQDMoeJ05HZxZCAyhBSgUrxjbnHhRRdGvILO0QkIsCU3aX
   2089zxUKm+oHX41TKcBdBZTpY0emmRSLBvNNKjbFnI7k+ihERQFD0CfV+
   hSOKTIY8z2DlLRACC5jOynf4WP38IwKjx/RV/tcCiFYZrIXg95lh3DW82
   VLoqbncdTNlNhRlagPN3R5S6I/tlKlWCCGDMhfaNscKLbJqJu3+nAYuXN
   A==;
X-CSE-ConnectionGUID: yuEqsj+3RFCZBHgirTm7pA==
X-CSE-MsgGUID: KbSIBlPiRheiM0qHltZ1iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33950675"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="33950675"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 11:36:00 -0800
X-CSE-ConnectionGUID: Fz5T6YH4QGuRaH+iaM0ccQ==
X-CSE-MsgGUID: 6KCzzx9HQ7OdY01X2KBGSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="132911099"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 11:36:00 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] Update perf tools topdown documentation
Date: Tue, 10 Dec 2024 11:35:54 -0800
Message-ID: <20241210193554.93013-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Document and give examples for the Lunar Lake perf metrics reset mode.
- Fix the error handling for mmap (it returns -1 on error, not 0)
- Clarify the slots placement documentation. It is not Icelake specific
and also applies for non sampling.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/topdown.txt | 33 +++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index 5c17fff694ee..3e2340f3f78e 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -87,7 +87,7 @@ if (slots_fd < 0)
 
 /* Memory mapping the fd permits _rdpmc calls from userspace */
 void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, slots_fd, 0);
-if (!slot_p)
+if (slot_p == (void*)-1L)
 	.... error ...
 
 /*
@@ -107,7 +107,7 @@ if (metrics_fd < 0)
 
 /* Memory mapping the fd permits _rdpmc calls from userspace */
 void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, metrics_fd, 0);
-if (!metrics_p)
+if (metrics_p == (void*)-1L)
 	... error ...
 
 Note: the file descriptors returned by the perf_event_open calls must be memory
@@ -290,15 +290,38 @@ This "opens" a new measurement period.
 A program using RDPMC for TopDown should schedule such a reset
 regularly, as in every few seconds.
 
-Limits on Intel Ice Lake
-========================
+Newer Intel CPUs (Lunar Lake, Arrow Lake+) support resetting the perf
+metrics automatically RDPMC, which can avoid a system call or needing
+to schedule special resets.
+
+This is available if /sys/devices/cpu*/cap/metrics_clear
+exists, and requires setting an opt-in bit when opening the 
+slots counter:
+
+if (access("/sys/devices/cpu/cap/metrics_clear") &&
+    access("/sys/devices/cpu_core/cap/metrics_clear"))
+     ... functionality not supported ...
+
+#define INTEL_TD_CFG_METRIC_CLEAR 1ULL
+
+struct perf_event_attr slots_event = {
+	... same as slots example above ...
+	.config1 = INTEL_TD_CFG_METRIC_CLEAR,
+};
+
+... open and map counter same as example above ...
+
+Then any metric read will reset the metrics and slots.
+
+Using perf metrics with perf stat
+=================================
 
 Four pseudo TopDown metric events are exposed for the end-users,
 topdown-retiring, topdown-bad-spec, topdown-fe-bound and topdown-be-bound.
 They can be used to collect the TopDown value under the following
 rules:
 - All the TopDown metric events must be in a group with the SLOTS event.
-- The SLOTS event must be the leader of the group.
+- The SLOTS event must be the first entry of the group.
 - The PERF_FORMAT_GROUP flag must be applied for each TopDown metric
   events
 
-- 
2.47.1

