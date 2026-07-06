Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827A35DA5B;
	Mon,  6 Jul 2026 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303313; cv=none; b=ofCA3sdXRz3yCNb3JZ6p6sDNXR2mCDe+kUk+aWpS0QPM2Dpsdw/lEkkamRd6rnA9oBkbwOGMTQWz6iONkBZBaO5IqKSv/jWLbXYsT7Sutzww0fBkgKwib4+5nr29q2vkDlp3LGvs1MTN7861hw9XH+3+EIulJ95LYW6eTwE1qko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303313; c=relaxed/simple;
	bh=NHF2vYwmeS5fbjcvp9Rwylbu4DKmNjG0PIX3Nlm4Crc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZEqKBQRK6VAoR/E4hvR8pnXJntLU/IlHf7un6vxfdksxisJELYqeOah51obTISiE3uGTAKvFFNkjO05bWFBbpyUrD8uhsSd8PCY2uFXC0ZTKUyoMb+X3Qw6gemMLUJi/s47HCRkffUoKss4ZYPd3YIiZODlb/juC8e33QoswrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xi5c4CjC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xi5c4CjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303313; x=1814839313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHF2vYwmeS5fbjcvp9Rwylbu4DKmNjG0PIX3Nlm4Crc=;
  b=Xi5c4CjCSYxrUaC/JVnKGryAPUz3qaV5E95f+T5cbcNPgn9VZAE4l2pX
   B16UoE7DP0nEc+TSfy59ChDg3iG1qtFMjb+WEzHKord2GWEOFFnjnDiUq
   p0c1pa8qjmQymBEKo1iAUMHl+XuxaK439/uV7Fu6MWnlMJBkXQTHYihfV
   5HxQ38Okp/xB8qH7qEzDBXMPMf+qMRgY7lo7DMfP2YDQw7MA9YEKKIL7A
   AM3vVxnOKX0gFMiXRNzDdYgRYoUmSDQblUVmqVCf9CpWJUw1Kzx1yURRr
   bCeUONRMmz0nYFEUkV25pFa3eCjn8+RpqfQl2TMSyzCvJI+Ek2C5bL0Lx
   A==;
X-CSE-ConnectionGUID: ENHi4bUET4W7GO+gRjaW+g==
X-CSE-MsgGUID: rl3XKDhaTFSqsfcVIQnSXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911633"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911633"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:53 -0700
X-CSE-ConnectionGUID: uRDQEPH8Q+aWXswupGJIhQ==
X-CSE-MsgGUID: 5ZvcI/gNS+GGp7koseQrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191297"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:47 -0700
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
Subject: [Patch v9 09/24] perf: Move and enhance has_extended_regs() for arch-specific use
Date: Mon,  6 Jul 2026 09:54:24 +0800
Message-Id: <20260706015439.3040804-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
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
index 82009bfb4fd9..0239864029be 100644
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

