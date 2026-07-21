Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75642FCBC;
	Tue, 21 Jul 2026 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617415; cv=none; b=ZCnvp3TcCJ+aK6Wo7gE0iPZyrBexuKo3ReVdnma+0vD2kngn6ezPVcsHpaCTfYuReU98mkkIsu26BT2t0FrQpghggk6wtZ6hBmDc+skFlmUZ0sTQRc9oq3w+oyyV51vfUoq/gRqZZ2QFLlfpgCi9gsSFSBf51HC/HBKLQ194Xvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617415; c=relaxed/simple;
	bh=iS4fPXYL2KEDGfJvXI7oPkCzy6Z6uaxLvuhovYQ4g10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+SN07WlXFTz1fYpv7YfUsVrCbYOCQ5tOgJP6H19io6fXjNaqLIcS9kLkGvXM8Tv/6nTTmiMoOmrTuxigwm4jxUJ+3YLtlb4q2w9C3D+a8UfF6+1v7WeP+YwjYACsPELObf+E/XdRd10GkCJ9vbbkM9mfmK8wynxFYSMyy0ukvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiUtofTT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiUtofTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784617414; x=1816153414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iS4fPXYL2KEDGfJvXI7oPkCzy6Z6uaxLvuhovYQ4g10=;
  b=XiUtofTTFRmkyprONEOMiBvHhJE3wX8apjb3P4eSwHIkaYzULDZSqRK3
   xBzvr+ym31tFMGMhAq6t7SoRdkS8ij7/4DJwwXAmOJ7mldLnF3qubO2Pp
   YFpFIWh0ZGlerYn+ejO7UtvGS9eOyzXxX0YnLo/+h6QijdKmvJcGjgm1k
   XTsQ50kmvi5PkUNZbyziaAhC9voTzmUJlccdNJ5k84zzG43pnXRwPqGhk
   ilV0c5ScrkFbQtRliPuEvYrHAYfX5+5Ong5UDISYaZnYriWVdsE8EHo5s
   SVXI85cKqwpWJEf5zU+MGI9nAA4bpgD/HBX7upHXKaoEH/FWVjpwJ7e/q
   A==;
X-CSE-ConnectionGUID: FjSJVLZQRjyfogt3ZZGeOw==
X-CSE-MsgGUID: PkMQbtScTg2sYXPiXhwgSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96717621"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="96717621"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:33 -0700
X-CSE-ConnectionGUID: butcXq4wSZKhHNHbpy7HpA==
X-CSE-MsgGUID: wOH4tNlqTFq3DUwI8Clgfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255036643"
Received: from abityuts-desk.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:18 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
Date: Tue, 21 Jul 2026 10:02:53 +0300
Message-ID: <20260721070254.13557-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721070254.13557-1-adrian.hunter@intel.com>
References: <20260721070254.13557-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

The Intel PT driver reads and writes event->hw.state as a whole value,
assuming it is either 0 or PERF_HES_STOPPED.  That is true today, but a
subsequent fix needs to also track an open AUX output buffer using the
PERF_HES_UPTODATE bit of the same field.

When more than one bit can be set, whole-value assignments would
overwrite the other bits and whole-value comparisons would fail to match.

Convert all accesses to set, clear and test the PERF_HES_STOPPED bit
individually, in preparation for that change.

No functional change intended: event->hw.state currently only ever
holds 0 or PERF_HES_STOPPED, so the bitwise forms are equivalent.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index dc1be7f6e04b..2163e5ccdc04 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1540,12 +1540,12 @@ void intel_pt_interrupt(void)
 
 	perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0));
 
-	if (!event->hw.state) {
+	if (!(event->hw.state & PERF_HES_STOPPED)) {
 		int ret;
 
 		buf = perf_aux_output_begin(&pt->handle, event);
 		if (!buf) {
-			event->hw.state = PERF_HES_STOPPED;
+			event->hw.state |= PERF_HES_STOPPED;
 			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
@@ -1639,7 +1639,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 			goto fail_end_stop;
 	}
 
-	hwc->state = 0;
+	hwc->state &= ~PERF_HES_STOPPED;
 
 	pt_config_buffer(buf);
 	pt_config(event);
@@ -1649,7 +1649,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 fail_end_stop:
 	perf_aux_output_end(&pt->handle, 0);
 fail_stop:
-	hwc->state = PERF_HES_STOPPED;
+	hwc->state |= PERF_HES_STOPPED;
 }
 
 static void pt_event_stop(struct perf_event *event, int mode)
@@ -1680,10 +1680,10 @@ static void pt_event_stop(struct perf_event *event, int mode)
 
 	pt_config_stop(event);
 
-	if (event->hw.state == PERF_HES_STOPPED)
+	if (event->hw.state & PERF_HES_STOPPED)
 		return;
 
-	event->hw.state = PERF_HES_STOPPED;
+	event->hw.state |= PERF_HES_STOPPED;
 
 	if (mode & PERF_EF_UPDATE) {
 		struct pt_buffer *buf = perf_get_aux(&pt->handle);
@@ -1778,10 +1778,10 @@ static int pt_event_add(struct perf_event *event, int mode)
 	if (mode & PERF_EF_START) {
 		pt_event_start(event, 0);
 		ret = -EINVAL;
-		if (hwc->state == PERF_HES_STOPPED)
+		if (hwc->state & PERF_HES_STOPPED)
 			goto fail;
 	} else {
-		hwc->state = PERF_HES_STOPPED;
+		hwc->state |= PERF_HES_STOPPED;
 	}
 
 	ret = 0;
-- 
2.53.0

