Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA550EC1A;
	Fri,  4 Sep 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546140; cv=none; b=CNY2LrivyF7S9zwK3nfbuBXTCler3b0ewUJ6wYtVVqa37DySFCi+2avsmIdCQZbw06RR7r2Xno2TzRJLp9EM44CFKl7Q+ogl++yzZzQjNparWghY5+z0hSUqKo2BK5Dckj4q3qbgDr+2li9VChJMF/DMpsmLaoNmAzEwyDLKM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546140; c=relaxed/simple;
	bh=UBQi2GzBqSozDfM9rqM5kIfL6hNZIDnsxoMXtV2thKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Laqy+GeXtTISwsBXcEFmo37BphepBWTldTP1MZzyoexepE+oxQjoPh6D4vFevBQ8fOVamnOUunHTwbYc5Tm7piEJ1UQdcztsh+Z8NrijdNNqi8P+KT1loqzt+fD0SgureHRaepAPdbyaGnkaKt7PtCR+TjegYeA1TU4UaLb7TBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyEYJnbA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyEYJnbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788546138; x=1820082138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UBQi2GzBqSozDfM9rqM5kIfL6hNZIDnsxoMXtV2thKk=;
  b=jyEYJnbAes84ek91RU2MHPyrzkBCHUMIK1nUlvgPN7Ihi+0aZAovnJqH
   WrihKxzCmySYXqrvePjhQIpZbGf+IZZy5CfBIiSPmAjIBQGSOhtI6hyxW
   cd5Zp1uVPn9dU/9/RwOlsVUpHuGT0IXxTkIr86+09V+qs0rTpzwYyVafj
   E0q1UyUIQRLPJ9Don1xI+VeS46lwaKA8nSBr/64FERafkZxEU0qPqQpHS
   uzh8ICLJ/xUHV++8XrJMX4NvXOQ1fOq1p+C8pesQovVorLZXgjED33JKa
   Zop88Ejxjm8N1D4PFUlZa0D9mkcqTLv/wPgbmmQ8cfQhG04/Vdp+a/Ta8
   w==;
X-CSE-ConnectionGUID: q0GLhDmrTA+SM3ie+z11kg==
X-CSE-MsgGUID: WxKfOf7dTliRSyATYXj6dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="99386512"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="99386512"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 11:22:18 -0700
X-CSE-ConnectionGUID: 0K1quQIsSY2rsyDgCLw+Gg==
X-CSE-MsgGUID: LyVmY9ZNQHKFrzHPdE5Fag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="269581350"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2026 11:22:18 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Subject: [PATCH 1/2] perf: Fix null pointer access in is_include_guest_event()
Date: Fri,  4 Sep 2026 11:16:24 -0700
Message-Id: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A typical module unload occurring event when there is an active perf
connection leads to freeing of the pmu pointer. The call log is something
like:
 ..
 __pmu_detach_event
 pmu_detach_event
 pmu_detach_events
 perf_pmu_unregister
 ..

__pmu_detach_event() sets event->pmu to null. When the perf connection
finally is closed, the following stack trace is observed:

 Oops: general protection fault, kernel NULL pointer dereference
 ...
 RIP: 0010:_free_event+0x3e/0x370
 ...
 Call Trace:
 ...
 perf_event_release_kernel+0x260/0x2d0
 perf_release+0x12/0x20

A call to mediated_pmu_unaccount_event() inside _free_event() is the root
cause of this crash. Adding a check inside is_include_guest_event() ensures
we don't accidentally access a null pmu ptr. In addition to this, we will
now call mediated_pmu_unaccount_event() before clearing the pmu ptr so that
nr_include_guest_events counts are maintained correctly.

Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Assisted-by: Claude:Claude-Sonnet-5
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..7777e82aad5e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6350,6 +6350,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
 /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
 static inline bool is_include_guest_event(struct perf_event *event)
 {
+	if (!event->pmu)
+		return false;
+
 	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
 	    !event->attr.exclude_guest)
 		return true;
@@ -13002,6 +13005,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	exclusive_event_destroy(event);
 	module_put(pmu->module);
 
+	mediated_pmu_unaccount_event(event);
 	event->pmu = NULL; /* force fault instead of UAF */
 }
 
-- 
2.38.1

