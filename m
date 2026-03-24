Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4883659E7;
	Tue, 24 Mar 2026 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313199; cv=none; b=DdmuqY0KPxHxLRwjaPH9+o0c555AmlsQD4tMRSKfSI2YnjX83XGEStdxCTYO0HnpH9envIqUGXRVi28SneD3Rltzrxip5z55Eiu/WdnhbiXT2AmqdYQtSgjQEq0uWdet/kUDU15ZjoU3kIHT5AuyK8xsjgyDzanIfsXc9znwsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313199; c=relaxed/simple;
	bh=NCXNvw0KAcxdnslKQ+0wQ8tLZRJYbbz/pgK2U354PaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNok+rSoKEkQqRaF5YfUaeutnnL9c9YFtigJuV0X+7yNTHLxxGZvdohXRPaQxPAetlFpJe+Zav3Cj/kQmMgwEYatjcoBrO1MLYZSwTwna+KKMuJ+ix26/kHD9GLnggIQpTZAY/UDj77w042tSTxwknjOYO2tAgRQ8BQKrPVuKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT5v1OPL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT5v1OPL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313198; x=1805849198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCXNvw0KAcxdnslKQ+0wQ8tLZRJYbbz/pgK2U354PaI=;
  b=YT5v1OPLXKzikboOcdrC8T3ZQHAuDOxP2fNTiBDEJaUjKU5Y20mApNx6
   fMwh0d74iAMwDKQp0sk92ibng72ZA/JPGtTOrDyVYlvvYFv4p3fpLPOuG
   ZIQjR9XiIZpoMrXzcUC1QtfwE6ZofbBX6ZbGvnYBi7dNoZe211TUTypM+
   Y+lSHermwHy0baua6Ch7m40hFuPeJAWHfb718kEvfxECrrR4HEebRwR99
   PfyC4gsIainNQpatVwlSDZZTeXbiDHyod5OpAh8MKFZfDJDkbpAmXUPkZ
   8RKH8cZpnHHoMjgFaZqpj0fBGH/RaCxVoH8e+hZgGbQg82rlaT5CZJGIj
   g==;
X-CSE-ConnectionGUID: UnWo30HKSTeeNAxSdto8gQ==
X-CSE-MsgGUID: GZGhYqC8Th+CCDKrFqfopw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397107"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397107"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:38 -0700
X-CSE-ConnectionGUID: aztT3aPcRw61myiLucdD2Q==
X-CSE-MsgGUID: dBKdnehJR3GjsuBvliBOEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322773"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:34 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 10/24] perf: Move and rename has_extended_regs() for ARCH-specific use
Date: Tue, 24 Mar 2026 08:41:04 +0800
Message-Id: <20260324004118.3772171-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The has_extended_regs() function will be utilized in ARCH-specific code.
To facilitate this, move it to header file perf_event.h

Additionally, the function is renamed to event_has_extended_regs() which
aligns with the existing naming conventions.

No functional change intended.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 include/linux/perf_event.h | 8 ++++++++
 kernel/events/core.c       | 8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..e8b0d8e2d2af 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1534,6 +1534,14 @@ perf_event__output_id_sample(struct perf_event *event,
 extern void
 perf_log_lost_samples(struct perf_event *event, u64 lost);
 
+static inline bool event_has_extended_regs(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	return (attr->sample_regs_user & PERF_REG_EXTENDED_MASK) ||
+	       (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK);
+}
+
 static inline bool event_has_any_exclude_flag(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index eb1dea2b1b0e..7558bc5b1e73 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12978,12 +12978,6 @@ int perf_pmu_unregister(struct pmu *pmu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
-static inline bool has_extended_regs(struct perf_event *event)
-{
-	return (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK) ||
-	       (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK);
-}
-
 static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 {
 	struct perf_event_context *ctx = NULL;
@@ -13018,7 +13012,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.34.1

