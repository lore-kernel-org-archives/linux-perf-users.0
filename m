Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18B1D6DDA;
	Wed, 11 Dec 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932971; cv=none; b=skWLrzCVHsx1HocCCltIvgtep9Oq5zAAWYPJGosnJ5EiyB7hDbKp2kN8dTrpXt1auTQvuorvjID6HPiw6w0GDtqDyo64RWesESfa40JYe7U+ltMAj+Qqd/OtcdVpFQ6QikEsgbK4d+S5ENFqOgBGPJZlq7TvFithX97D0Bj3/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932971; c=relaxed/simple;
	bh=e8gQe/UZBZtcrlk2ief58ZONRCL8ckwSKdXRy8F+xSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qE1N2bw8G8fOD9MBuokRed/gHuLO7lGRh2yVSHuBqWmKutAh6puDMkPvhxDR5mn5EoMrzF8dSxnaEWLT9Twdv+O7hWBRAf3wRczucLtpPHek1Jf74cQLcGPAioDW880Q3q/A2pCr/+QKwz3/O/mm9l2tjrJ5TYz88j3mdmKnwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cbd2Z7k5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cbd2Z7k5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733932970; x=1765468970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e8gQe/UZBZtcrlk2ief58ZONRCL8ckwSKdXRy8F+xSA=;
  b=Cbd2Z7k5B4acVt+EPkl0bbHZSBIpzjsUmlQ7gaQJBinFmLOlncbZPkLa
   uVyv8FQHPFvMJ+ERoSl3XaAfB+xCnFakv4gKuklaVUyyJv6s1KAbRJfvg
   PqpvHnj4ps7yvi1pmKEHYmWc7wKy/LSjswyzkb5SxWsWRbgz7Wtc+Y/0K
   MxgHQSs47tYXXSgxiChgupOoc5ygOzDgltyQLZJtoRqXdkf9RRfsC011c
   2PHGvspRgIlxNjMuv6W6bLHN+VfBOBCcgb7dvGN9DxxcBb2v2oZzc8CLe
   7NsXm0EZXorWCyWhIAMVq4GTJYhjqP885ax/H0WMaEO1EQKFFvoIG03Ex
   A==;
X-CSE-ConnectionGUID: hfj8UFbLQ42ZPx7fMovJgQ==
X-CSE-MsgGUID: Kz3cTxyeRyqpsKprNNYgKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34458985"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34458985"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:02:47 -0800
X-CSE-ConnectionGUID: e74nG60wSYW32Cd1oNzvRg==
X-CSE-MsgGUID: jy09rSsOQ326h5alPlHsFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95686234"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 11 Dec 2024 08:02:46 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	ak@linux.intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: irogers@google.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 2/2] perf doc: Update perf tools topdown documentation
Date: Wed, 11 Dec 2024 08:03:18 -0800
Message-Id: <20241211160318.235056-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241211160318.235056-1-kan.liang@linux.intel.com>
References: <20241211160318.235056-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andi Kleen <ak@linux.intel.com>

- Document and give examples for the Lunar Lake perf metrics reset mode.
- Fix the error handling for mmap (it returns -1 on error, not 0)
- Clarify the slots placement documentation. It is not Icelake specific
and also applies for non sampling.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---

The doc update patch is originally from
https://lore.kernel.org/linux-perf-users/20241210193554.93013-1-ak@linux.intel.com/

 tools/perf/Documentation/topdown.txt | 33 +++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index 5c17fff694ee..44644e917ffd 100644
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
+Newer Intel CPUs (Lunar Lake, Arrow Lake+) support automatically
+resetting the perf metrics RDPMC, which can avoid a system call or
+needing to schedule special resets.
+
+This is available if /sys/devices/cpu*/format/metrics_clear
+exists, and requires setting an opt-in bit when opening the
+slots counter:
+
+if (access("/sys/devices/cpu/format/metrics_clear") &&
+    access("/sys/devices/cpu_core/format/metrics_clear"))
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
2.38.1

