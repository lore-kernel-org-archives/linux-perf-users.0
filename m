Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB53438BC;
	Tue, 19 May 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213076; cv=none; b=Og5Ct6aTdbCFUiQ3HBWGDhqmoCDPb4pxyg0g5HugnsEs+pfrQNv5xVudScuXy+Ql7pbi7Vjrlt9lKCXBSbu/ZKZCVGHvCddpOqW8pyIW8+XZG1h6Omyg5VQgrKsXQu5RgZmKA55sjjACWbno+QRMXGNluvTOyG3YylhYuKYstFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213076; c=relaxed/simple;
	bh=rbY7XNFUi9oFN8eybd6jhNDwJvQYonWeWVw8mn92lzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvv9JYV82L2QOl1yiokQwSbxBVUDBg/W4BKn9IvDJ7deA21DjajiF/oWlfyqcP6Vsez0YdlrS2CNbAc+dlZvYIARQHWF+Xaiy0s/WdIJP7Fh11gbXdWZqC5ii7UJtPMVvcrfYjDV9XBQPYvUn5OgIpwqx0Azn0sM6i2qZyR2YBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyE5Qp1o; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyE5Qp1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779213071; x=1810749071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rbY7XNFUi9oFN8eybd6jhNDwJvQYonWeWVw8mn92lzw=;
  b=FyE5Qp1olB3KScATqHdtvOLyDq/R7dVhnxCpzCJlcrmkcIBWNh+ayD9L
   rCDPPN/FV67f1kIwwfgHnrGY7BY9KK1Hwnjpksk/ipqs+xipprctIDFnh
   wySxFqISJgGFeNnAcIVTTE/k6Pc0BYXlBSnHURQ2YuuI7Vwz7HTRWYMeE
   qY+ws6QFe74Z9EsvubW4HED5sXNnPLYFyq3C5mA/erQvSoMMKwWuaLr8k
   qepMj+F7DCtyhqiJGr64KFmUPdW9dLSLUzzLGQeNsXvjGnSoNXMhlEx3u
   AC0FxccKGLRUMRC4XQSIbMSD/zQW7duxvRO6MaSV5bV5VMnXPxUYacT0D
   A==;
X-CSE-ConnectionGUID: ozNXdRw8RD+KnAhfco05pA==
X-CSE-MsgGUID: Gj8ZVykjTpeOMTGSZkglNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79951795"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79951795"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:50:57 -0700
X-CSE-ConnectionGUID: 7WmiCiw7T5Og++4KwM74AA==
X-CSE-MsgGUID: j8cptfm1RuqyZ67F8VV3Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233475602"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.238])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:50:56 -0700
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
Subject: [RESEND PATCH 2/2 v2] perf annotate: Fix missing branch counter column in TUI mode
Date: Tue, 19 May 2026 12:50:43 -0500
Message-ID: <20260519175043.1490261-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519175043.1490261-1-thomas.falcon@intel.com>
References: <20260519175043.1490261-1-thomas.falcon@intel.com>
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

