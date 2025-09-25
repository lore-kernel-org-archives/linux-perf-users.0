Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21662E9EA6;
	Thu, 25 Sep 2025 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780874; cv=none; b=P3tcXyXoVUZr3dHe9O1ibqWMSbcx6NzRg4xciCjuooiaB30gFqBtDfO7MfTwN6SJYVoFKUToQkmFGqDscvWPBEy9B/yWGQPuNbDRfI2OxywQjdzv4cFDXFccDqS56b4HdgQ2PcYxzCzEPNpchnjCc8AxZp/Q8OPDyT0D2OjlUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780874; c=relaxed/simple;
	bh=g+UWioWetDwIySgG84A2HsmsXd1dwmnMNNqWOCLE6HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODfretIvB1sdKdkzITLWKIrkm5PAL2fzBrvH6nPJ/NwS4nwCzSBiv3UubgszvZOGcQRVm/U8x6S6OM2uc4+Bskw6y9cbOTISoi3N8BCIRSWq31FP9iQvSEoaJfPDwh8avBc3PX7QcxgzjKQgjs5KP0UGbPTQwBEO/mtpUqs5Ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hh0lZQzP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hh0lZQzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780873; x=1790316873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g+UWioWetDwIySgG84A2HsmsXd1dwmnMNNqWOCLE6HU=;
  b=hh0lZQzPbpv1/j89/86Nb3TCn0/01ypbIAj83oOwVDMYHZGKk8xOGriz
   YtFjtiiSoENxcF2xeaIz5cydbl3TPTQlrRUgQdhTttJ3fO0pmz1sx1R3J
   THv56RwYzooClC/zaYGFci5K2o2lJTvJmtIh85/xTtzj2bbnH90gWYBKj
   ndsHHyigD+Mm6ALDSWwObbBeka0jbJ9P64O6UDn8tgXiTvpu925RUUTpn
   QhPJIAazaYIJiEsEk58HDoo4/1mgb44zm2Danul4T062EppuGiyvbeJPu
   rQg0fR6diPhr5xY0SQus/W2xTwP81/NEockVSpfuvUBSsIlVFazbsULCu
   g==;
X-CSE-ConnectionGUID: ZILNbAgyRdeKmiKwqchh9w==
X-CSE-MsgGUID: moxKxliuS7ufZIcsDj5+Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139520"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139520"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:32 -0700
X-CSE-ConnectionGUID: F/9NL101SDawiFcNJD5z1g==
X-CSE-MsgGUID: CbibZBHtQp6aq5GkQwJtFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528331"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:27 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 04/17] perf: Move has_extended_regs() to header file
Date: Thu, 25 Sep 2025 14:12:00 +0800
Message-Id: <20250925061213.178796-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The function will also be used in the ARCH-specific code.

Rename it to follow the naming rule of the existing functions.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 include/linux/perf_event.h | 8 ++++++++
 kernel/events/core.c       | 8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b99..1a647a1e6d08 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1526,6 +1526,14 @@ perf_event__output_id_sample(struct perf_event *event,
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
index 28de3baff792..fe3a01cc4d92 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12560,12 +12560,6 @@ int perf_pmu_unregister(struct pmu *pmu)
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
@@ -12600,7 +12594,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.34.1

