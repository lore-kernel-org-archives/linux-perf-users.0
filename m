Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972236;
	b=tnokLm7CWxSNGv/9sfivxQR2rQT0QeWFZgkGsmeIiA8afRAp8Q9N0D/3VgJ+jekVQGU4
	 mwT+0zWKQFLz/6thlXpgi2iBD7ZqKFARY5v2TgZH82xRQJIu5sAIs/R2XDsxLrEd0cfNy
	 kVmP8fHuPIwSGQZub1YrS/YiwTfd6Pf9ZK8C1HfEv4EDH1Mg1t9uY6kcPecFIsrx9lfJQ
	 Unov0qtKP+vhhbvySE9UFCW+hXlwhirT5DwIAOgJaF7g5ne/hhXNO1yQ/Qmrk/dd3pBz2
	 44AnfoS6W2nucFRypTBiXJl7TzNaJ5D1AfRk4Zri6JWUgb6eJe49pUvjpN3toI9UE3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972236;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YtANDZP9LoNxtgZhQEQkYpbgl9MzdfwiDH61sBHGkyc=;
	b=mWgCEAavMCxlSY0WLyf8MncCRMVRu4HzIQIGZBzFpd/0pGk1iQi2e8YqdEx4e3h922WH
	 9kdtRTxG76SM2vXy5z1zXYmhIV7pepf+UqIDk3rgHD6jgLOUQAhmKtKSgGs2XbUU0a+Df
	 VIC7FqDDSE5Z1TOG4dHwBmWMvGAYyYua9qxgm1jpvjSlmBNuClu5mrNUR47MQKTWlu32J
	 spn1Q/KXrZcwY2qeyfkH6g4UCXGoYIQcVFZrnQtnUml/IFudskPUo3AevknSP4o6BkTky
	 4huMkHRVYo0ZDzj/pW7lh0cM5nYiRMDZe13gl6yb37wyFKOq05uHfDXQe3gHbse1xpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GsLfdS1x;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DD60A381A;
	Wed, 18 Nov 2026 03:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A69DD60A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GsLfdS1x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972236; x=1826508236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5UrcRYInUIWBIiHdmcBh2quhjwMh2jnVf+Caebh8G4=;
  b=GsLfdS1xuiVt0qro2z8g9h5ATWZUYrOnzIXOBag1MIb/1fMD6IUSz2Hb
   gloCsDIAf9DJ6fptYekrJFeMbeKjkljRTR1/cw087eiIJjUNkmPGQ7Vrx
   AxD7PfZxgtHhJb2GYbyclzo57MtRADROZ1BUm9A9BheBPt6Wjq1waeyUp
   jGFWuhLhf7wAJdZ4YOGMco0oTCqUPX2p5zKHTIZXFzto8I0Oo+t66PfMY
   uHrApWvGMdyUacfSYWqFfTGG4UAI6f7rJZPh0qh27eGrlC9wWhZygz/d+
   mwMjt+A4wXPDyAAaAVyj+qmZzYWGq/q2LUfGYXb21jgLwIiKakJ5ro7DM
   g==;
X-CSE-ConnectionGUID: qZUYG/eZTxuTnO1VP0TZoA==
X-CSE-MsgGUID: hz/rnegYSi635mYUMXNX7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629948"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:56 -0800
X-CSE-ConnectionGUID: fj9z7DD9TC2WbWKO8QvihQ==
X-CSE-MsgGUID: 7luNSXfHSPyQZgnAERtC2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894292"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:51 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v7 14/24] perf/x86/intel: Account lbr_pebs_users for arch-PEBS events
Date: Wed, 18 Nov 2026 11:14:43 +0800
Message-Id: <20261118031453.1353625-15-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lbr_pebs_users tracks how many PEBS events are currently using LBR.
It is updated for legacy PEBS events, but arch-PEBS events were missing
from that accounting.

Add the missing lbr_pebs_users accounting for arch-PEBS as well.

Fixes: d243d0bb64af ("perf/x86/intel: Initialize architectural PEBS")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 4 ++--
 arch/x86/events/perf_event.h | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 6c7123c1f9ae..3a282352b0d2 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -616,7 +616,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	 * be 'new'. Conversely, a new event can get installed through the
 	 * context switch path for the first time.
 	 */
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+	if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users++;
 	perf_sched_cb_inc(event->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
@@ -687,7 +687,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
 
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+	if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users--;
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fa0af528cd1e..8d64bfcdc82d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -2096,6 +2096,13 @@ static inline bool intel_pmu_has_pebs(void)
 	return x86_pmu.ds_pebs || x86_pmu.arch_pebs;
 }
 
+static inline bool intel_pmu_has_pebs_lbr(struct pmu *pmu)
+{
+	if (x86_pmu.arch_pebs)
+		return hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_LBR;
+	return x86_pmu.intel_cap.pebs_baseline;
+}
+
 #else /* CONFIG_CPU_SUP_INTEL */
 
 static inline void reserve_ds_buffers(void)
-- 
2.34.1

