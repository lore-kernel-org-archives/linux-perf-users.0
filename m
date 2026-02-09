Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F111EB5F8;
	Mon,  9 Feb 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621934; cv=none; b=ZcfkUJN/IUxXWzEGoIoTZNxElHRh7AerXZEkW1n73Yzh6sw7bENAbEH+n2OWe4/+O/aG/EtpG18trP4Gi1euXfUpkwHF9mWXjTtEl+qHFuwMpESoswO7+DsaWdQf12OyK+5riwmpyoOTJB+MWr8/w1icnvzo5esMdJ7pessVcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621934; c=relaxed/simple;
	bh=NdJxAgkkZUlMDn4CCFlG9khMShPl95l1ZRV/iTrz0MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4dLfQetKfaT8Iuq1BhGLPVISszVaPQcvbKUWtT96LaG1kcJzW/V0zyjQer7WSbkW3q57NoAYPfaDkq0/FGZ5n04mgKYbW8kUQRBn9RqsURUrLWL3g22zAy5zTxRNdmwqXQUgGweF98RknNVY5zPPHKjDkGgJznINPSzkRgldvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHsLNq4K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHsLNq4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621935; x=1802157935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NdJxAgkkZUlMDn4CCFlG9khMShPl95l1ZRV/iTrz0MI=;
  b=nHsLNq4KphS/MelKkQRFRwrg5x14daXBeGXLyxwGallNQazbgeddQAWF
   lyCPJF7jgx9UzHgVExha5qhKRwenRBtWIZWXAwS3EtvQRaNkcvNCyROND
   e4UdAr1PuQvnbn9LUlAXKvWvB+DZ7Cz3A+bbTt2ca30raIJxSKNEJzlyC
   hnfNgSNTeoQmLjc+3l/w3/aASSoC6XL8k64fCBe4fecn6gOhE3Vd88zai
   5OsKDYmSS4PZLA4OET5C73h5ubO0DvRvIsuVDlPsPqvnILy9AWXBoJzqg
   OQXd6LI55kBO42fq+hM8r07qv/AzO1Yq3jmV/grcgT6wp4m4ul1nS7G8N
   w==;
X-CSE-ConnectionGUID: JlD2gR2wQ6unLEVhSPt6og==
X-CSE-MsgGUID: i/Sm5pY+SWe8LK24sj/Obw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098354"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:35 -0800
X-CSE-ConnectionGUID: p6wmg1LsT5uV6vH3FhHc+w==
X-CSE-MsgGUID: vNPd+U5BQOupRK0yoMrQXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694648"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:30 -0800
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
Subject: [Patch v6 09/22] perf: Move and rename has_extended_regs() for ARCH-specific use
Date: Mon,  9 Feb 2026 15:20:34 +0800
Message-Id: <20260209072047.2180332-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
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
index 82e617fad165..b8a0f77412b3 100644
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
index 8410b1a7ef3b..d487c55a4f3e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12964,12 +12964,6 @@ int perf_pmu_unregister(struct pmu *pmu)
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
@@ -13004,7 +12998,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.34.1

