Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550E369D71;
	Thu, 17 Sep 2026 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610390; cv=none; b=nKtINpFjyfan5t7JknV3UtHMH32qYTSH2qI77atShn7Q/dJXtFZY8ImZqQbVHTaP34Ji5apMHWrTjsrlqie1BquJVSoZpgEU2SOK5cGYgZ3YXVArouAsL5s1OhJB7zJPnoDviULJa/O6SKvLTGVqdUAyJYkrwuWKVPyv+RsXTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610390; c=relaxed/simple;
	bh=NpcicHZ6wu/v+pwcBKqhm/vgXk8qNPFILJ7n0gYLbzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yo1aJCJyVpEdkBEB2A5bziS8e/b+pRK/ksOuIUjfsZKIY1fF71NEB4gjDZM/yfODBowCIqQfZHdPwXIeg9LVFGHzQ3q03xVgy4utFp3sVyOupFXH/WfH2UDC45CQNeAsdMjAgC2X0KbyP8xSH5EYQBHuALo7z1iu/nPbz6J+J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYw9z//R; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYw9z//R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610388; x=1821146388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NpcicHZ6wu/v+pwcBKqhm/vgXk8qNPFILJ7n0gYLbzs=;
  b=MYw9z//RuwWViOsLkSdsgQE+PG9iDCxKVT9X7vLRdoQQToIbdXAN/gj4
   Zzk/thdJ6v9R8j/TXFOtGr4VchhwFqqhPWpBseMwEvwoYgexz8CtaWgJr
   /o+dC/Ak3EpkdOi3bk7KRrHirYJgE3YxEnFSkDVEh4OMb3Cil7/ao+wrG
   NOCc77aaouBCEamGYCGRnV9Xgq5IJvoaBa6hycRKMsjVBUFzrpkmdjkle
   PP+jXTrs0qVML5oLzOyItaTqq6qDOtOD8uOejg3Rv3K0dj59/NjYBVtu4
   nknidYOOexwlp3L3vtcH2W1/padzakPyK6njzltWWFtPEczrfnS2s8xBX
   g==;
X-CSE-ConnectionGUID: r+Qzv0vgQXCJUZ9KAIJk+Q==
X-CSE-MsgGUID: BjD68fiVRaif9PEzedZocA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498540"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:59:48 -0700
X-CSE-ConnectionGUID: 5XTyXSH8RuSz5W37+6vICw==
X-CSE-MsgGUID: zZZQckQeSH6LWjNuwMWL/w==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 18:59:44 -0700
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
Subject: [PATCH 03/12] perf/x86/intel: Fix DKT PEBS load/store direction for latency events
Date: Thu, 17 Sep 2026 09:52:25 +0800
Message-Id: <20260917015234.981153-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same issue exists on Darkmont, intel_dkt_pebs_event_constraints[]
applies LAT_CONSTRAINT constraints to
MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set explicit
LOAD/STORE flags for those events.

The PEBS latency path (pebs_latency_data(), via cmt_latency_data) uses
the event flags to determine memory operation direction. Without an
explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
misclassified as LOADs.

Set explicit LOAD/STORE flags in intel_dkt_pebs_event_constraints[] for:
- MEM_UOPS_RETIRED.LOAD_LATENCY
- MEM_UOPS_RETIRED.STORE_LATENCY

This fixes incorrect STORE sample classification. Additionally remove
INTEL_HYBRID_LAT_CONSTRAINT() since no one uses it anymore.

Fixes: 65fd435095bb ("perf/x86/intel: Update event constraints for PTL")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c   | 4 ++--
 arch/x86/events/perf_event.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 434adf15d83c..95b3ed3097ab 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1312,8 +1312,8 @@ struct event_constraint intel_cmt_pebs_event_constraints[] = {
 
 struct event_constraint intel_dkt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0xff),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0xff),
 	EVENT_CONSTRAINT_END
 };
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c9c52f3ee4fc..5787053dd40a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -710,10 +710,6 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_ST)
 
-#define INTEL_HYBRID_LAT_CONSTRAINT(c, n)	\
-	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
-			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID)
-
 #define INTEL_HYBRID_LDLAT_CONSTRAINT(c, n)	\
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID|PERF_X86_EVENT_PEBS_LD_HSW)
-- 
2.34.1

