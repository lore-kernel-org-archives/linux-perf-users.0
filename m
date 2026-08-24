Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F23B19AC;
	Mon, 24 Aug 2026 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560492; cv=none; b=izAJut5R3T0xixEMX9fMCJxOuQabxOMOHpE7OlXfRJ6ZrJJikL7WaUDM3sT4WkoIIDRWmV3oKERX23EsjcQ5zqMH6vdgWkggjkb5J2qVz0zd3pHDMZKy1Nl/6p3c6ADCjXn93jYlV6w7gFQYA5Ztt1cbYZGw5hH/OgOw7PblNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560492; c=relaxed/simple;
	bh=pkcuxpLGeRWDOpDrexd3QD8I7fox8hA3fGdkgE/+Vlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddA8ht/vDipaSiw6Z0PZTawegRoPcPqNaGYffGb08wDcrLzNr4h3eGJS2vuYJkf/WSK6i0l84p4czu+33/ZTJAXQcHeVR6Bg2lOZXCfux3XEm2/phfKSqagkteZXeLsPbsrpWWou4x2lPPagYmD9yktJBSprBaQl9LFn9t6LPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2+yd3pW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2+yd3pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560491; x=1819096491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pkcuxpLGeRWDOpDrexd3QD8I7fox8hA3fGdkgE/+Vlg=;
  b=P2+yd3pWglvyRI/Gr2DXh5l1Tv0kBVjNtbuSYF9l84U8jnSVI722YZ9K
   rahvhMsbNe/blO3jIokEUIO22zSdVkm5alv6n7+uAYnOChXzCcgBwoGle
   30ls040ynwxOYic+U1xRFGEMa8JyFDOTnix61BehU23k7DnTOL56qv9kA
   ejGuYsBoKDS0ngDR5j1tBb/iMqshqRUIyOnVEpo/Q+SVe9ei2I23Reupj
   uYqz9yDr/Wwm+WKAEIUsJ0t2uvcECo/dOwHuPwG4HFuX5GLm/g1ApnZXe
   MvYC19yzg0qYpWeceUNeGQvjiFr/wArFCtGyJSp0vD8DW08t57d4dPZWo
   Q==;
X-CSE-ConnectionGUID: dy5S8r++SxOuJ9G+t84h+g==
X-CSE-MsgGUID: eHOa9ZpkR5S9QxPV/rGzTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598767"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598767"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:34:51 -0700
X-CSE-ConnectionGUID: p78nZXD3SxunkMoQA3Tn5w==
X-CSE-MsgGUID: 5osrcXaASHy9/A2La5kRIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326205"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:46 -0700
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
Subject: [RESEND Patch v10 08/23] perf: Move and enhance has_extended_regs() for arch-specific use
Date: Mon, 24 Aug 2026 16:27:16 +0800
Message-Id: <20260824082731.1013973-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Move has_extended_regs() to include/linux/perf_event.h so it can be used
by arch-specific code.

While moving it, enhance the check logic and rename it to
event_has_extended_regs() to match existing perf event helper naming.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 include/linux/perf_event.h | 10 ++++++++++
 kernel/events/core.c       |  8 +-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..fb38affa7352 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1534,6 +1534,16 @@ perf_event__output_id_sample(struct perf_event *event,
 extern void
 perf_log_lost_samples(struct perf_event *event, u64 lost);
 
+static inline bool event_has_extended_regs(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	return ((attr->sample_type & PERF_SAMPLE_REGS_USER) &&
+		(attr->sample_regs_user & PERF_REG_EXTENDED_MASK)) ||
+	       ((attr->sample_type & PERF_SAMPLE_REGS_INTR) &&
+		(attr->sample_regs_intr & PERF_REG_EXTENDED_MASK));
+}
+
 static inline bool event_has_any_exclude_flag(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aac1617865d5..801cf34cf519 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13118,12 +13118,6 @@ int perf_pmu_unregister(struct pmu *pmu)
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
@@ -13158,7 +13152,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.34.1

