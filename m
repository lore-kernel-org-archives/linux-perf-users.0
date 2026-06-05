Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51458378D8B;
	Fri,  5 Jun 2026 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622223; cv=none; b=UdkW9ccMuNn830qmf4FvYTqk0zgurOEg+p3yfNGkkNBiG/rJvJuQqUgJvlnuu2A5923mOnGeoRxouWwLiL46RAaR2owWg1TrVGMJv6siEiFI5A4bRWHiuY4Y2SWCoxOtRe7758mixEWAul9WuEqW5AixvJtZK1inwUfRDgKuJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622223; c=relaxed/simple;
	bh=99LaCPX5v3Uxh5M6N+wcyfmWLe5NRtFKC2Yvy4+Lvjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmNMDn3OoyCmbqN9VW5gVSsQFtG7r2GiTTZhYJ2Zgq+fu4+QD7mC9FQu+k/8yrLI0ovnBtAdM+RVgDCZjV2y0HNg5nLGM4eHLHj7YR0HK/n6NNzDQGAxVjtSfVhakY+6z7flOhUOBdSurO23AOok8GP6zOq9Hh8ioBa42LxDdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gocR8Mhl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gocR8Mhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622216; x=1812158216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99LaCPX5v3Uxh5M6N+wcyfmWLe5NRtFKC2Yvy4+Lvjk=;
  b=gocR8Mhly9nTM0kF7oWyZ0FmjFoEIr3ZDadOZ1pDP1N0TYU1OH9Dpgji
   I0Gk6vqi+igcHat0duPw4C5tOfuZ9jjlvatP2gozusmg46ITxBkPCBLsO
   r03sEXFWdYsKVOG0gHPX+AXxnGUME10d2LGvQZfbiawl8iGB6cTJvwg++
   ws1NxeyJKB0+4UQhvtf1yyaP9VOgczyNM0DN5hzEfgTqH6F+1/ZFzJoZH
   mmHZj5iATPHAmnVrjbW7sFo3lrD+29q1YevyVB/GsqygK1zOCf5MvQEx8
   flW/7Z8AFwJMZSsIcM04xXXJEm7dsxmfH/06o3OYTeJ7+GiR7Bs8p3WYj
   w==;
X-CSE-ConnectionGUID: 1xIpTgTiTf+RcHDOgxxHqg==
X-CSE-MsgGUID: TdJwhkuAT+mgHz03OZ871w==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91772180"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91772180"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:16:56 -0700
X-CSE-ConnectionGUID: PDfKJrB7QlqKjQPJmhNRpQ==
X-CSE-MsgGUID: mJsfoDSzQW+/gwiFuekubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244817113"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 18:16:53 -0700
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
Subject: [PATCH 2/8] perf/x86: Introduce is_x86_pmu() helper
Date: Fri,  5 Jun 2026 09:11:30 +0800
Message-Id: <20260605011136.2043393-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
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
---

Original patch link:
https://lore.kernel.org/all/20260316050838.3624051-1-dapeng1.mi@linux.intel.com/

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

