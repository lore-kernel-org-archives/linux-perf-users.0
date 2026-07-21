Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1C4307AD;
	Tue, 21 Jul 2026 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617417; cv=none; b=WuKjnXRYuRzfpNFEGs/P/xpRhuYIujG3bFuPuCSkTmGLdxFUHLlS35G1YrW1QSa6K6i+bQrjyF0V9WGrzY/wSw8uuVIS3HZaq3WXYsrSSDf+tPZD39EES2K0YiDcXBqFp1iPVtk+AIU1QnSFh/Xidyb/GddQ6csPrZfQkVN9/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617417; c=relaxed/simple;
	bh=magmibytr2cGqGJvl73VBDjjLoMk6V+sHxKJ82yEJ7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFrKjtJPdZ6MXZjhdNUPZK9MexETDZyB4Oao/4ubhHTBHu+IVjpGXullFBOYlXPCGleBdJ/dbtdNdSHQceQmgD38BUaNmjC1YmbZeLKt0abBF+PJH0gZ/W7Mu34NrMHyODoQZT6/nT8YtVWligCgSI9hV0Gg08ypvWhhlGw1YiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mT/gG5Xn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mT/gG5Xn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784617416; x=1816153416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=magmibytr2cGqGJvl73VBDjjLoMk6V+sHxKJ82yEJ7g=;
  b=mT/gG5Xn+pFRxIbQf1fI67EJktBB0RMEBFyQtDEdiVdY8F/juhKxofQG
   tAGVMJUSfj53Ciw5zShZybYDAatdhlA6t4FtWD6xVaTp2MFGB30jZTs5I
   VI9WItuP4jdniB2cGJPzwjE6AQ56TsWpH39Qz1g6uS2/29GCSH3EPtqq+
   dBXBarp7d+G9/8awPy7wHPFtKZgUzq3X+1IuXQfcHqHiWigDsyqWz95l1
   yZLSsEBw4NxywtlHvDDaKGjFHXD9EiEmHfUGAtSPXl9WZYWeCI8j32PWG
   Q07TA4ZYRgVW25NrGrcGoPp9Ttr7lFWHbBd69bGWFUfYGOpP/EzB7UTxd
   g==;
X-CSE-ConnectionGUID: E+wMme7lTt+N7jDQZBbmhw==
X-CSE-MsgGUID: jSBAh0SfTlSxmWv1pqar/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96717627"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="96717627"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:33 -0700
X-CSE-ConnectionGUID: qQXBBjgvSWS68FlDQ02cBA==
X-CSE-MsgGUID: o2bw5LsCSNe5wQzHd+pkww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255036648"
Received: from abityuts-desk.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:21 -0700
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
Subject: [PATCH 3/3] perf/x86/intel/pt: Fix stop/start with no update
Date: Tue, 21 Jul 2026 10:02:54 +0300
Message-ID: <20260721070254.13557-4-adrian.hunter@intel.com>
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

If pt_event_stop() is called without PERF_EF_UPDATE flag, then
perf_aux_output_end() is not called.  A subsequent call to pt_event_start()
will call perf_aux_output_begin() again which violates the rule against
nesting and triggers a WARNING in perf_aux_output_begin().

Originally, pt_event_stop() was never called without PERF_EF_UPDATE,
because the only code paths to do so are from event overflow, and Intel PT
does not do that.

However the introduction of group throttling by commit 9734e25fbf5ae
("perf: Fix the throttle logic for a group") meant that an Intel PT event
could be throttled if it was part of a group.  Throttling calls PMU
 ->stop() / ->start() callbacks without flags.

An example is when AUX area sampling is used. The following commands
hit the issue:

  echo 10000 > /proc/sys/kernel/perf_event_max_sample_rate

  perf record -F32000 --aux-sample -e '{intel_pt//u,cycles:u}' \
  -- bash -c 'for i in `seq 1 100000` ; do true ; done'

Use PERF_HES_UPTODATE to track whether perf_aux_output_begin() and
perf_aux_output_end() are balanced.  A cleared PERF_HES_UPTODATE bit
indicates that an AUX output context is still open.

Amend pt_event_start() / pt_event_stop() accordingly so that begin/end
stay balanced:

 - In non-snapshot mode, stop() always closes the buffer (the buffer may
   have run out of space, and that accounting is done by the update), so
   a following start() opens a fresh one as before.

 - In snapshot/overwrite mode, stop() without PERF_EF_UPDATE leaves the
   buffer open so that pt_event_snapshot_aux() can still copy from it,
   and start() then only re-enables tracing instead of calling
   perf_aux_output_begin() again.

Note that pt_event_del() calls pt_event_stop() with PERF_EF_UPDATE flag set
(as is required by the documentation), so a final call to
perf_aux_output_end() is assured.

Fixes: 52ca9ced3f707 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 45 ++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 2163e5ccdc04..5754cd405562 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1540,6 +1540,8 @@ void intel_pt_interrupt(void)
 
 	perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0));
 
+	event->hw.state |= PERF_HES_UPTODATE;
+
 	if (!(event->hw.state & PERF_HES_STOPPED)) {
 		int ret;
 
@@ -1561,6 +1563,8 @@ void intel_pt_interrupt(void)
 
 		pt_config_buffer(buf);
 		pt_config_start(event);
+
+		event->hw.state &= ~PERF_HES_UPTODATE;
 	}
 }
 
@@ -1629,6 +1633,18 @@ static void pt_event_start(struct perf_event *event, int mode)
 		return;
 	}
 
+	/*
+	 * Re-start subsequent to a call to pt_event_stop() without the
+	 * PERF_EF_UPDATE flag. Absence of PERF_HES_UPTODATE indicates that
+	 * perf_aux_output_begin() has already been called. This path can
+	 * come about only in snapshot/overwrite mode - see pt_event_stop().
+	 */
+	if (!(hwc->state & PERF_HES_UPTODATE)) {
+		hwc->state &= ~PERF_HES_STOPPED;
+		pt_config_enable(event);
+		return;
+	}
+
 	buf = perf_aux_output_begin(&pt->handle, event);
 	if (!buf)
 		goto fail_stop;
@@ -1639,7 +1655,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 			goto fail_end_stop;
 	}
 
-	hwc->state &= ~PERF_HES_STOPPED;
+	hwc->state &= ~(PERF_HES_STOPPED | PERF_HES_UPTODATE);
 
 	pt_config_buffer(buf);
 	pt_config(event);
@@ -1649,12 +1665,13 @@ static void pt_event_start(struct perf_event *event, int mode)
 fail_end_stop:
 	perf_aux_output_end(&pt->handle, 0);
 fail_stop:
-	hwc->state |= PERF_HES_STOPPED;
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 }
 
 static void pt_event_stop(struct perf_event *event, int mode)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct pt_buffer *buf;
 
 	if (mode & PERF_EF_PAUSE) {
 		if (READ_ONCE(pt->pause_allowed))
@@ -1680,17 +1697,24 @@ static void pt_event_stop(struct perf_event *event, int mode)
 
 	pt_config_stop(event);
 
-	if (event->hw.state & PERF_HES_STOPPED)
-		return;
-
 	event->hw.state |= PERF_HES_STOPPED;
 
-	if (mode & PERF_EF_UPDATE) {
-		struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	if (event->hw.state & PERF_HES_UPTODATE)
+		return;
 
-		if (!buf)
-			return;
+	buf = perf_get_aux(&pt->handle);
+	if (!buf)
+		return;
 
+	/*
+	 * When not in snapshot/overwrite mode, there is a possibility that the
+	 * buffer has run out of space. The accounting for that is handled by
+	 * the update, so always update in that case. Snapshot/overwrite mode is
+	 * treated differently to allow for pt_event_snapshot_aux() which can
+	 * still get called if the AUX-sampling event is not stopped until after
+	 * PT is stopped.
+	 */
+	if ((mode & PERF_EF_UPDATE) || !buf->snapshot) {
 		if (WARN_ON_ONCE(pt->handle.event != event))
 			return;
 
@@ -1705,6 +1729,7 @@ static void pt_event_stop(struct perf_event *event, int mode)
 				local_xchg(&buf->data_size,
 					   buf->nr_pages << PAGE_SHIFT);
 		perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0));
+		event->hw.state |= PERF_HES_UPTODATE;
 	}
 }
 
@@ -1775,6 +1800,8 @@ static int pt_event_add(struct perf_event *event, int mode)
 	if (pt->handle.event)
 		goto fail;
 
+	event->hw.state |= PERF_HES_UPTODATE;
+
 	if (mode & PERF_EF_START) {
 		pt_event_start(event, 0);
 		ret = -EINVAL;
-- 
2.53.0

