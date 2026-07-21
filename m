Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2A4252A0;
	Tue, 21 Jul 2026 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615580; cv=none; b=XwBMmSQPW1vpZQP01gfqPcQHTUoQGyMvI9Q1uDPt+9twsA3b7uV6C+1575dxYKtexKq/FBm9jwryspVB+n9cy/RDX/3F2BPjYgTNTmuxx4UxRzF3U6GrpnDZNeHmy9wZvcK0CT4dhTXip+vBMhl75fuJgmOlLFjfl2frSuh/ofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615580; c=relaxed/simple;
	bh=v3iMP1VKCgvyvF9VbXliT0PXbMARsiTfffnP7hrmTA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAqg+yPu53Xbc9vLkm4vo0mFVcQXJuSeWAUdZ9wbLs3MO1x21KlB6EBFb16d7Apz3XmfNm/ViVliXWAWmN6WS5kXwP4orIzAUMtTCjudSFMEUjzNba7jrzc01bFwCNfrY5D7rWX3dMnxNpQ9/SJ584RpwlaDP0csjK0+r9F6Y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFXBOfqy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFXBOfqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615580; x=1816151580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3iMP1VKCgvyvF9VbXliT0PXbMARsiTfffnP7hrmTA4=;
  b=hFXBOfqyfIXC3vzSiDV+a41srMcgIq8YiCzd18qe3fRnObFN7W++S1Sv
   AvR1/CRjQu7m+XRrc9cUSKxcTRWxrGLuTlU9KirUJQ7/LskgYY+QJ7ept
   zeaS2gM3LBWOjLbRVw0WPPV+76tiy3jOzlRCR29WV0N2vrV322TiV+VYU
   mixOY7JH2zomfFe0+YJTwUlMjI0UUhtZiDRphtqeISmXS2BVIzdAR/hT5
   Lgq7fG5kmG2HtqUSj2oLbjcL+LfhZK15qEJ+t97GY4XPqvNeaRDo01Nvt
   2dMY8fHn1PwjYAGXHYa7tb+Eaf1NIduwxzG8SLVoB8d/3nTq+1SpNL001
   w==;
X-CSE-ConnectionGUID: Sz2K5L79QCKi73ZsPo2nBQ==
X-CSE-MsgGUID: RYIg/rLOQjeHchBoMIg3kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565425"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:32:59 -0700
X-CSE-ConnectionGUID: eUeiAvtOSgKkn4KH+sH7+A==
X-CSE-MsgGUID: iDrQN6d8ToeFlOxoT79ndw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259655993"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:32:53 -0700
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
Subject: [Patch v10 08/23] perf: Move and enhance has_extended_regs() for arch-specific use
Date: Tue, 21 Jul 2026 14:24:51 +0800
Message-Id: <20260721062506.3745816-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
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
index 770c4b1330c7..7848e9ac06ca 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13116,12 +13116,6 @@ int perf_pmu_unregister(struct pmu *pmu)
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
@@ -13156,7 +13150,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.34.1

