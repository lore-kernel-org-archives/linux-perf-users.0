Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A4363C77;
	Tue,  9 Jun 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981670; cv=none; b=GXprN05+a3/CjT5Z71J/i5tbK3VwsVhorc6k2XsrDfqyCBx9LA+2eCNn7qjNyDfqz3zS5c0+pg+8hYVToah9g2bvuZZqfDsZaC/IS/2xlZBTel5UNLy+VSQ9I6HiF0cyIEzne+2L3umqGsG7/auRjDjYWLoqQCS1MY2bToObN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981670; c=relaxed/simple;
	bh=vYkX+548z3bRzygU30VXSH/d4JA5ME0AFOgehEsG3qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLdfGMCennaSvKIWcK8GHIKRSjAejGJk27KJTz9jSOQxib0u3DjiD8X92yKbg7EoOdSsPLTA2Toer4E22b4yMlVZNi/CYQTEYP8qI06/5+ETAdSeNIEB6uY8iCUwQpK0ub9iWR4tQBEO65qqme5+7B6fDPp23VyxigNpuTVln5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMKTRMd/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMKTRMd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981669; x=1812517669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vYkX+548z3bRzygU30VXSH/d4JA5ME0AFOgehEsG3qI=;
  b=NMKTRMd/AXFfVip/2EFcrP+z9UjP+9RkZWVGnw6wjekQY+2fjLWzbrI0
   MQzUud40WGB0x4EdSay+cVPGw0eAB3dh8U1ikfsf7cwGv72R0w+hnzDAI
   a9WgE3KzAdcQEoZNXKpKfQwsoa8ApgJQYk6O23aWGiF4BAzzi8VGJ+OwP
   HzfLvwzCBxbwbKozLAf7iSiXTczN1J5UM4/4vmVFlhec18wrIpIi5iI+s
   dgUDCORiGN1BgkrVcf5MHb6NCbARll7qtrFaHkV0N3SBsC+/fxWZVbXF1
   0vnEK6j2Bh1j62wXJ8HXg9bcamwvw9Nw9iyec9kusn91+pCNmS7mE3bRW
   A==;
X-CSE-ConnectionGUID: 1ork/1tvT12J8BSeQA3adg==
X-CSE-MsgGUID: +ZwMxTjJSgaUmMND1aajoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586157"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586157"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:07:49 -0700
X-CSE-ConnectionGUID: lW7CvoTRTayTeDxqW/xBFw==
X-CSE-MsgGUID: XV7/IyGDSJayHgZl8aVb/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838903"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:07:45 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 2/9] perf/x86: Introduce is_x86_pmu() helper
Date: Tue,  9 Jun 2026 13:02:15 +0800
Message-Id: <20260609050222.2458129-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

To facilitate the detection of x86 PMU structures in upcoming patches,
the is_x86_pmu() helper is introduced. Additionally, the is_x86_event()
helper has been refactored to utilize is_x86_pmu().

No function changes intended.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/core.c       | 16 ----------------
 arch/x86/events/perf_event.h | 18 +++++++++++++++++-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4b9e105309c6..3bd0522afe6d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -774,22 +774,6 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-int is_x86_event(struct perf_event *event)
-{
-	/*
-	 * For a non-hybrid platforms, the type of X86 pmu is
-	 * always PERF_TYPE_RAW.
-	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
-	 * is a unique capability for the X86 PMU.
-	 * Use them to detect a X86 event.
-	 */
-	if (event->pmu->type == PERF_TYPE_RAW ||
-	    event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
-		return true;
-
-	return false;
-}
-
 struct pmu *x86_get_pmu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5902a297daa1..dbb5c8e8a8ea 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,7 +115,23 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
-int is_x86_event(struct perf_event *event);
+static inline bool is_x86_pmu(struct pmu *pmu)
+{
+	/*
+	 * For a non-hybrid platforms, the type of X86 pmu is
+	 * always PERF_TYPE_RAW.
+	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
+	 * is a unique capability for the X86 PMU.
+	 * Use them to detect a X86 event.
+	 */
+	return pmu->type == PERF_TYPE_RAW ||
+	       pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE;
+}
+
+static inline bool is_x86_event(struct perf_event *event)
+{
+	return is_x86_pmu(event->pmu);
+}
 
 static inline bool check_leader_group(struct perf_event *leader, int flags)
 {
-- 
2.34.1

