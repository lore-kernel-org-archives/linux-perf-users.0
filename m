Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96B3630B7;
	Fri, 10 Apr 2026 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852411; cv=none; b=A2rMFzJW9MV+NC0GWn7XYgMnqpFfVWYUJhKlSl6mdlcYiogfTBc7T+dVxlGZXq8jxAXV6jZM3eIo3OraRdpzJBaunupAUjtkZ1a7mCZPpoWaMZfOKHutc3LzBGmD1Ivssqzq3Ls7HYkJMwyC0q+zVQdAgmzu75G/i4vzCtu5Q6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852411; c=relaxed/simple;
	bh=5sAUndeE9EvHVWhMgw6PXKxYIBKFzUxCcMZhMz+h3rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU2tNyRvFSyn0Qovs6OjkYlSvSh+kA96SYTcRuG+aE2dTAUCqoQ+1YF1gyOKTLlzuMNTwcKNNiNL6yPwO9ogxX0TQoyjFzJx5ohvNFFsPR+hMTtPll8yVDROZWd9noKc7UOYX+i4BuiAL1eXJsGkfntaaGR7bv3VsnrtqkO/H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE2NGYgk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE2NGYgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775852410; x=1807388410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5sAUndeE9EvHVWhMgw6PXKxYIBKFzUxCcMZhMz+h3rw=;
  b=gE2NGYgkNYC6CiWlxjtc13te5CJBmL2rL4Tru7s260F9JwqLHwCdeUfj
   HKkVzzFbGiInwTpO2Tvls+4AhI1kv48I4oKVxxL6xghABWCS9AmswmZiQ
   wtQta3HPOgHJZXcURl8BRVq2AQ9K5G7eiNGvZKnLz0WS35yMNFUeYBQVY
   Uq2hgQKiyx9uX+gjnQOSMFmep3s5lrYCSi5I6TbT9pz0etcMmNs8bjFBN
   iTtFMa5xKZ2ioCJfNg/8VOPYgJgB4FO/H9RUbQmDn6he6JGXY++DkD1zi
   UkeQEgUyhHlVZnKnvyDl8oyOWWlSyQqdWDOlxDlaIxCPt8eP6mPN4I0sz
   A==;
X-CSE-ConnectionGUID: LZ5M/4JKSBecSRQM+oGZJQ==
X-CSE-MsgGUID: 6JPecJIkSjS/Q2pCRteipg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76787981"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76787981"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 13:20:09 -0700
X-CSE-ConnectionGUID: RdNsPOuvTT+XXpFSpgH4Gg==
X-CSE-MsgGUID: i0gqxtNsTla5pcl9Z/yGIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="259636813"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.104])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 13:20:07 -0700
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
Subject: [PATCH v2 2/2] perf/annotate: Fix missing branch counter column in TUI mode
Date: Fri, 10 Apr 2026 15:19:57 -0500
Message-ID: <20260410201957.226869-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410194000.219846-2-thomas.falcon@intel.com>
References: <20260410194000.219846-2-thomas.falcon@intel.com>
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

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v2: Sent an older version by mistake, updated to the latest version.
---
 tools/perf/builtin-annotate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5e57b78548f4..7bddbaee1cde 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -563,6 +563,10 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	if (ret)
 		goto out;
 
+	if ((use_browser == 1 || ann->use_stdio2) && ann->has_br_stack)
+		if (session->evlist->nr_br_cntr > 0)
+			annotate_opts.show_br_cntr = true;
+
 	if (dump_trace) {
 		perf_session__fprintf_nr_events(session, stdout);
 		evlist__fprintf_nr_events(session->evlist, stdout);
@@ -926,11 +930,8 @@ int cmd_annotate(int argc, const char **argv)
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

