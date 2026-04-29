Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6B37C93F;
	Wed, 29 Apr 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476568; cv=none; b=VS0dxY2o7FyEa63T4KUV6KDa4TbPbk1wGRctNlt+UCZbrGSjcmFtgpwCPhMP74HpVhywcZIQcGrqqwQ+1ppIYjqq7MHj+l4gEET8b0Zs3nzScFfIMRhyAoyNktReapCohM/c4KgBUEkEFMzIUgGyjB8VqavNgXml75/XiFt42bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476568; c=relaxed/simple;
	bh=rbY7XNFUi9oFN8eybd6jhNDwJvQYonWeWVw8mn92lzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzhDg9NOKg7ZKnnwZ/4QpiPBaIDy9h2t1ewaHQRRTRbJL9OWdR+lOKufePEbOzCeHM+HAvKtyDXK9amKZ41OpwuORC7bgWtpN2DAXB5RvqtsDL676alwFU4NEdeFyCoLVl2zqcA0fD4U9u7t4a+Q+u/uR8epNuSKR9nB8xJ230U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHZ2n16R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHZ2n16R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777476567; x=1809012567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rbY7XNFUi9oFN8eybd6jhNDwJvQYonWeWVw8mn92lzw=;
  b=QHZ2n16Rp+gN/WeNdw9k7LPdNfZpKGDvIw2YR3RxXamxeehS2f54kvjE
   q9aqw32KM4fVrMF5YhMuQMaXox5XY++Ea6LVENdtSeucM+Q5pV8FVPXyP
   7MOc3FlwXOPo8Pynej/ulKcBjKENUCYdEChdojy8u3cl+MaJGuOkksw05
   4HnC6FLRO2CUkSFhI2cupAgCDQ0PEi+VjERc9itKZILlFJ53CkiBFD0vr
   qEYsueRwl7Sggwdkpo8wBfE6gxba1564bOMKGvKELDfPM4Yef5GBv4wv+
   JT7h2h7urABJua/ASki0oo+seickpjaousGqn+QpvxZwFNmYImoLTmQuH
   A==;
X-CSE-ConnectionGUID: XjUI8CO4RDq5tBkAa2czaA==
X-CSE-MsgGUID: 0UVwlpx1TgqspPeW+CnAyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65937607"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="65937607"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:29:25 -0700
X-CSE-ConnectionGUID: cqxRvDu7S1+fg+q/w0ZQWg==
X-CSE-MsgGUID: JtedEalDS/uq3ea7914+Og==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:29:24 -0700
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
Subject: [PATCH 2/2 v2] perf annotate: Fix missing branch counter column in TUI mode
Date: Wed, 29 Apr 2026 10:29:17 -0500
Message-ID: <20260429152917.178803-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429152917.178803-1-thomas.falcon@intel.com>
References: <20260429152917.178803-1-thomas.falcon@intel.com>
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

