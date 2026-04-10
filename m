Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F4369970;
	Fri, 10 Apr 2026 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850018; cv=none; b=nm+CFJ7272KYaGiBKiA/Y8lch8msGYFrACDm17g4L2/JutqiE2r47Zbu+1X1GgS4rGjq3rhTnOFH80frJ3GfpEBret0P3FV+FTaQf02Bf1nhFnuqvxjAOT39l2iICsLVyLfQMKXo6PgLjMq13b23fWBnhWD6JRR+l8hYj3TMx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850018; c=relaxed/simple;
	bh=SZRbF2V9cH/xRIPq5gbjFT69OHMzCMHlDpzUw//I9oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGlw3rSbRVIHOU+P9NNcthgT7o37C7ciWbjjqqrWq62EUHSFrwe56TZsNHlbijyiXRW9R1UzYceB9hPhCUaTP7Gm791mrvLw05jOAo5z1LaCYF0hID7+gh+UMChrciGUsKYuE+OuX6jd3M+liK/OrH4B6zQGs0t/TJayUVayERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKsSVtWU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKsSVtWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775850016; x=1807386016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SZRbF2V9cH/xRIPq5gbjFT69OHMzCMHlDpzUw//I9oo=;
  b=nKsSVtWUoPJzkItPopvUriku6C5NyS+YrBVzNzfsqgMFo7eWLqUuq+Ye
   tfXtRs2ByaOcp/AWBRAdtp1l9Qa4KaScgaZQz7HJ8LAVaPIqKKUVPBIi0
   45I7piDUNKs1VF5aZ1oty7eR94UstUSOpG+4M7+wY98STs0Bwh6b5WSdY
   02e269AhSazanRik+RUSzn9UykZGF7+bWbk7EFGPcoWIJ6PW/ECJW7Rfb
   J4y2UZ1hpiiY/hmhb8h0mtumqjnRIl9gHwvzygGAbeTChQFB8Tx/pAthj
   VMFtzDlfJ1yhy0K5JdceWpQofqP/8XWiXGhVx0Ee625pYWFK3/Ux96c/c
   w==;
X-CSE-ConnectionGUID: AMq4j9v5Tfq9DM45XDDTSQ==
X-CSE-MsgGUID: 7rlkH9xVSqaKGlIi8+zJvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76767568"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76767568"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 12:40:11 -0700
X-CSE-ConnectionGUID: Xktafb8bRLiHI4wvRGfSnw==
X-CSE-MsgGUID: 6Bi/vppXQlePIKqSaHPlew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="225999195"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.104])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 12:40:08 -0700
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
Subject: [PATCH 2/2] perf/annotate: Fix missing branch counter column in TUI mode
Date: Fri, 10 Apr 2026 14:40:00 -0500
Message-ID: <20260410194000.219846-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410194000.219846-1-thomas.falcon@intel.com>
References: <20260410194000.219846-1-thomas.falcon@intel.com>
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
 tools/perf/builtin-annotate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5e57b78548f4..7fe23b05306f 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -563,6 +563,9 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	if (ret)
 		goto out;
 
+	if (session->evlist->nr_br_cntr > 0)
+		annotate_opts.show_br_cntr = true;
+
 	if (dump_trace) {
 		perf_session__fprintf_nr_events(session, stdout);
 		evlist__fprintf_nr_events(session->evlist, stdout);
@@ -928,8 +931,6 @@ int cmd_annotate(int argc, const char **argv)
 	 */
 	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
 		sort__mode = SORT_MODE__BRANCH;
-		if (annotate.session->evlist->nr_br_cntr > 0)
-			annotate_opts.show_br_cntr = true;
 	}
 
 	if (setup_sorting(/*evlist=*/NULL, perf_session__env(annotate.session)) < 0)
-- 
2.43.0

