Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16273E49D;
	Mon, 15 Jul 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059677; cv=none; b=O+yohDD619qqk2N8/D41z/EW0JKaJAZUrg+/pIcbMkAoWyAJB7NgYVZInCf2aNGknPFi2/AJ+6kRnyQdzHO6j4dOiGvhIKfk9R3M9/E9J6kDLlZME5Zw3BwsxQfJTyfrCxTBI8/xpdLv1AQKg+e2NWGWyycYiYOa4mGvlYN4eI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059677; c=relaxed/simple;
	bh=+hq3P0AGBGCKyL0Jx2ImBjyEI0MYBUh9fT5KNpqUMVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdAZu7xZ9utY8N1y03SNnKI7j5r3Z6rqFlDYqvwAekFU8cVhFl70wGzq2EuuEYmmsON72ztAYfGnBuK41in98J/yaONmrq9bivN35Cyjp/OSEg3IHhWgFpL6dvd82PjGSXhGQTDC8bqpX85lPlBDj2HI5dXHLKbAU4EbQGd9kdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuYwcTRA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuYwcTRA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721059676; x=1752595676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hq3P0AGBGCKyL0Jx2ImBjyEI0MYBUh9fT5KNpqUMVE=;
  b=DuYwcTRAZ0kqcMl7ix2lghFovVlZ0bk+xgoppK/3EF3yi/+8ugnF28U3
   KK3KYDbZWFMa15qDomkH6V6SVyCaRLnjGRnU9PVY1SzqcBcQcq0WA27ps
   /7piw4ZjJtDP+KNw/lJ452erx36ayh3iK50PLzozJ3jSBvrO2Iwg9OO/j
   8f12vwpXYauJhtTzhV/KzIJbVwPB2XUJzdOBJ0U0ZlmgIPR43SDHFXHus
   a9I/zSwaDyAbd8m31R9lVeCVZfDy0iS41QDL9zd0U7BrZ5Ms4f6UgdHGi
   qQC/A3gT0xQKD5WPnks93wYzA/TWCoYWPtKOXAuZGdlolthWGGfcNk1dP
   g==;
X-CSE-ConnectionGUID: mTu8BAT3TFCtNVLH83lNlA==
X-CSE-MsgGUID: o1poRGEYTOOEEtWLJrkqBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="21361207"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="21361207"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:07:50 -0700
X-CSE-ConnectionGUID: iSpZrdC3RxeeL9BSIM7XDw==
X-CSE-MsgGUID: eKrJuMWLT+ybp7w/xXss+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49413538"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:07:44 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V9 04/13] perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
Date: Mon, 15 Jul 2024 19:07:03 +0300
Message-Id: <20240715160712.127117-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715160712.127117-1-adrian.hunter@intel.com>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Events with aux actions or aux sampling expect the PMI to coincide with the
event, which does not happen for large PEBS, so do not enable large PEBS in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..3de40cb823c9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3886,6 +3886,12 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static inline bool has_aux_action(struct perf_event *event)
+{
+	return event->attr.aux_pause || event->attr.aux_resume ||
+	       event->attr.aux_sample_size;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3903,8 +3909,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
-			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event))) {
+			if (!(event->attr.sample_type & ~intel_pmu_large_pebs_flags(event)) &&
+			    !has_aux_action(event)) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 				event->attach_state |= PERF_ATTACH_SCHED_CB;
 			}
-- 
2.34.1

