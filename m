Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC53529D260;
	Wed,  3 Dec 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745107; cv=none; b=uZwYLr9XYe8GQiD9LjpmqLELde1X/2WmcHpP92PKoR6ejX1PL0uujTURaolJ6fuylhz/yBhNPQPrtfNt27Aqb2SIrJkz0jfW0u+JQevCNgvpGyxCy0e3F5Lq+q40sp5omcnHj2b6Ep+cfEaaulfCOc208nD/2eULrmLDs3QNqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745107; c=relaxed/simple;
	bh=zLgkbpHLpsxyBbWLwrpPSYQx1fWU/bpzREKI2QhRlSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWr4PrH6ZKeqkD10R6z+V5HppVhDrk2enLo4zQrN1aIxhY6cvGVtvExWJeNVjWEF5yKvjye1aAUn/a2gZLCzWb2sRu0RxNjThw7YelKO0ZEBJGM4QUE1z8YMD7CPymQvvY18lzuxjVp1XYZqzp66iqQyP9I9hjZ9QtIghWUntHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnqzPUgk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnqzPUgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745106; x=1796281106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zLgkbpHLpsxyBbWLwrpPSYQx1fWU/bpzREKI2QhRlSc=;
  b=WnqzPUgkszEZVNj7j22SdcCzC+KTlbjYZ9wPOeXEKjjiFS9/mPkb8w/C
   0KI0F6nT7PSUFiThuEkRbC84zJa43wjbgbphBPNZE61QJl2jqkuE/5oRY
   WGp/juLrJnW1zVARMjtGtulkZYiglEwEMg+cEHsEx4qBjhbtdbE6OdxNF
   KjrFQxYqaEAp/+aQbf9ZcE2O4B+yTmCTXjKUk4za99z2wFgcklVpaU7+L
   d5Hs8xnKdg9EmzlGjry4T+2jMf9xVSQWzLPMV45xkuLVqlKXPP694tGKT
   SlK1/dZ5i2HHF7B10+AILfECuK3EM9z1td2Smnv44Vb/a7EeydYRlhrL/
   Q==;
X-CSE-ConnectionGUID: WCYDkFH9QkqdHc2ZyGwdyA==
X-CSE-MsgGUID: nGPFvFkjSsW1wDEmdS+A7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324793"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324793"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:25 -0800
X-CSE-ConnectionGUID: TP7saJF6ThSkoHFUkN1c5A==
X-CSE-MsgGUID: +DaQ0cDrRcC+1BK4huZJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003821"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:21 -0800
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
Subject: [Patch v5 05/19] perf: Move and rename has_extended_regs() for ARCH-specific use
Date: Wed,  3 Dec 2025 14:54:46 +0800
Message-Id: <20251203065500.2597594-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
index 9870d768db4c..5153b70d09c8 100644
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
index efc938c6a2be..3e9c48fa2202 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12664,12 +12664,6 @@ int perf_pmu_unregister(struct pmu *pmu)
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
@@ -12704,7 +12698,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.34.1

