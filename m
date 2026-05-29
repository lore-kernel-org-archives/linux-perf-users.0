Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BFC3B2FDB;
	Fri, 29 May 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041801; cv=none; b=XVkmWBPIpR6KmWvu3GWOZq86oVHqeOwco+43rR82dMENfAx3Vjn5o1J9uR6nq3HxJh+0roQekzd+Kij1yG49aYyAip1L68h5+gzjNKs9Hu3KyA1htlM7BEdFAV1aMVVanEtA95jtH3VkNb/KpmBwjPIJFrzSL5PJLBVrVrgL0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041801; c=relaxed/simple;
	bh=QcZxr/t2d5aOuMpifMfhoT20FIpK5G/CW4f704Y+Z2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqXAY3fvwE60MB7Z+5DvXvWhhdLBEL3zBD/fxDjnh/hTehFHbYya5vJ0WN1xrX31DOaO9db7htEVTRP93QSGpQt+C54eUjo3YCEp8r5D+zLUUSPrKEJnr4oo57xdmAFZdZ/LdSVXsKjvnaHPPjCdvAu2+diMfgYJEKjsGN7u3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/LAjoNs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/LAjoNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041800; x=1811577800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QcZxr/t2d5aOuMpifMfhoT20FIpK5G/CW4f704Y+Z2A=;
  b=M/LAjoNshywTo1MX8LfPTAAEJ1q6XjYr6f6wspoE/XMnqDIUcgP0Q8C8
   FlLwuIZgpfE8Y0C0x5YGrlfoihhD4vIU4chwVURJIrzuvS/4fXkFvVia8
   I4XvEo2MLtqmbCMRVR0+ZwL72ryiCefsmj18Iv6I/jJhb+fBFm4ySK/LJ
   qj2rnrMBez6G2+v0+zR46zkHS/Xmv5VQ8pJsS1G1RYuP/9saFQPVleC87
   1Q1kJ1UfhjugI1VmAU0b3edv4Vro27GaPoSgTVxxtxSb6bvGXl7eLcicB
   Ilk92jIubVWQ21vn0jXuqyqEHBHyFWi8O5TDhuy5MA/ZjOZnTWJH9iiZG
   w==;
X-CSE-ConnectionGUID: habs1rBCQgWiqcYhPuBqZQ==
X-CSE-MsgGUID: PMfDfINmS3KAliahQ3kKBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341949"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:20 -0700
X-CSE-ConnectionGUID: m4yYZEMXS/uaAPBaD1Pz3w==
X-CSE-MsgGUID: F4lw46IIQNSnoSoIoEmxVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802172"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:15 -0700
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
Subject: [Patch v8 09/23] perf: Move and enhance has_extended_regs() for arch-specific use
Date: Fri, 29 May 2026 15:56:31 +0800
Message-Id: <20260529075645.580362-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
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
index fedc0cf65f9e..2ce553db4dcb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13056,12 +13056,6 @@ int perf_pmu_unregister(struct pmu *pmu)
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
@@ -13096,7 +13090,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.34.1

