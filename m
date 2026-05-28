Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E23F86FC;
	Thu, 28 May 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982638; cv=none; b=mIxJFPh6xxiKWFEUzqSlIWLDzYQD7a+2QradfFynj1WT49fwwbohi6qzyR6N76CoyvuPWyWvIXJEsyoEdt4yzeRSHOMrRhYP7nTOIH5Kq9zJFYo0olovX8Y3TW4gReJ16LCyWe+CRV570c9grmPBGop1pdtxysgY9Idq/HzUYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982638; c=relaxed/simple;
	bh=T0akOmjnAyWqBw9ksqG6dqy082Z1lwctdCyO4znESRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWFlFmxYVGAtA/LYz+YSHAsXW2zm4Epd5u4ZG76pZTsBBV49nDHHVtjSSMMegJZRrIr0WBOqawQkE49CdDO2Ow10mWGQ4OuvwANWdaz0AJlnM50xur61HsTVyuqQLdRNUwaJ850DEZ2cXUOjtK0nzUNUdYfnRsm3CPvEPJexvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGhxzo8X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGhxzo8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779982638; x=1811518638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T0akOmjnAyWqBw9ksqG6dqy082Z1lwctdCyO4znESRY=;
  b=iGhxzo8Xw8nLoprZzuEnMVO2TL/I1OCGa+kXo+QZ+7oZ1BnL+nhjIRlH
   6MjUvFLXdx4uDeAcwXYcz5JPhMMramxnJTdocHk7o+4196uqhcVsEDPGi
   cMaq+Ym02x6tv+aX0SVim1SeDRa8Nq0XwEPJ5zDd9kelyaUdGV656H4PX
   d0bWbw7K727AR/25xTBLvS7/RWshIvIv++lzQrEm76L/9ouQLvqj83IqC
   4/QnV7Ua8MiOiEQ5CUugrQ3taiwwnEtXl9+pI0OvR+uXnHZo4kooxcLFq
   u4zVvcIkPpGb6vwgJmU9vPE03pn9lJwR+qhl8T89npISr0c7SzLjb7BOJ
   w==;
X-CSE-ConnectionGUID: wfJB3xgFQcCxm2HFq64FMA==
X-CSE-MsgGUID: N15wRuj+S1SroHF5WlIKnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91396812"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="91396812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:37:17 -0700
X-CSE-ConnectionGUID: VOqn/DWoTLaqX3qIkPZU2w==
X-CSE-MsgGUID: jDXjQ5WvS2amc+PodopnFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="236226866"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.220.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:37:16 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v3 2/2] perf/annotate: Fix missing branch counter column in TUI mode
Date: Thu, 28 May 2026 10:36:37 -0500
Message-ID: <20260528153637.300213-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528153637.300213-1-thomas.falcon@intel.com>
References: <20260528153637.300213-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf annotate checks that evlist->nr_br_cntr has been incremented
to determine whether to show branch counter information. However,
this data is not populated until after the check when events are
processed. Therefore, this counter will always be less than zero
and the Branch Count column is never shown. Do this check after
events have been processed and branch counter data is updated.

Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-annotate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 719b36d4eed5..5f450c8093c0 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -559,6 +559,10 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	if (ret)
 		goto out;
 
+	if ((use_browser == 1 || ann->use_stdio2) && ann->has_br_stack)
+		if (session->evlist->nr_br_cntr > 0)
+			annotate_opts.show_br_cntr = true;
+
 	if (dump_trace) {
 		perf_session__fprintf_nr_events(session, stdout);
 		evlist__fprintf_nr_events(session->evlist, stdout);
@@ -922,11 +926,8 @@ int cmd_annotate(int argc, const char **argv)
 	 * branch counters, if the corresponding branch info is available
 	 * in the perf data in the TUI mode.
 	 */
-	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
+	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack)
 		sort__mode = SORT_MODE__BRANCH;
-		if (annotate.session->evlist->nr_br_cntr > 0)
-			annotate_opts.show_br_cntr = true;
-	}
 
 	if (setup_sorting(/*evlist=*/NULL, perf_session__env(annotate.session)) < 0)
 		usage_with_options(annotate_usage, options);
-- 
2.43.0

