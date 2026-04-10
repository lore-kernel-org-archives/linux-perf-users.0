Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC473288AD;
	Fri, 10 Apr 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850016; cv=none; b=GE0pv/yuz9VS7VSserVy/9loTAz7n3VPuCjBJRFeH6VGTpfwI1G7JloUPsrPizdB47ma1ztxSvNHVeFxEHA/cRV2aiS3CdLlW/ZE6iuql9i/6BUjYgyjtNZR+4F5NAq0vQcsKHNVYXECQa2m+sgq/8dfihfxg46ok5uaZyWv9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850016; c=relaxed/simple;
	bh=24i+qD7RziDtFEWJQ0SLO7jSlBCC8TSmN8vBbRrIWf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvArN//Q8jCZ0Z6jEbRz+lYwLff22iaoEzAx4cogIU3CanehnPECtIie5qoJPfsKLWaIJWm84IOUSntXmCp17niRfSqoSN5mXj255eWKWGr+cxQg1U8740FjuuxvTipSbE2KWe4suATrrqHO7gug3+Wa807zzT74t/j1ZHuVjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFaMhfic; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFaMhfic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775850015; x=1807386015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=24i+qD7RziDtFEWJQ0SLO7jSlBCC8TSmN8vBbRrIWf8=;
  b=bFaMhficFf71lPbh6eeuLAW/+YNFaqLDskK/x2UZr1CKuEi92uaglL5W
   tI8gAXV3dBomnZfM4n4MfNGPYlic9oaONylbHh36+eF8pXbIOos/EGXYq
   h7xL2RlXofKePS/+ppFyQOaWqgPyIPq7mXdxfe8GWgJLKcKn9P56+uDpV
   oA55kFFw4QxFnk1Sdlu0FH3iyhpRv1L6ZhWWacTBR4pTWXk/r6GEwS5ge
   kFRNVeq3rp3iPVIHFPFMH3CONl3PD4s4o2og27AWfy0lQ9MkkXrLwxBHJ
   08DZmthyRfstuLBFObAtPPYYlWi18Y+9ZX/q0nB+WEUikq+ITEOoWGlTM
   w==;
X-CSE-ConnectionGUID: 5VkNqEBgSz6yKxxKDwtopA==
X-CSE-MsgGUID: wYEsb1VJTUa54kVB2mn35w==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76767555"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76767555"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 12:40:11 -0700
X-CSE-ConnectionGUID: Lz0cZJMZSjGa2Gym/GQUnw==
X-CSE-MsgGUID: DvFfogavSOCbgu1xIC61Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="225999188"
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
Subject: [PATCH 1/2] perf script: Add missed "+" if br_cntr reaches upper limit
Date: Fri, 10 Apr 2026 14:39:59 -0500
Message-ID: <20260410194000.219846-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add missed "+" if br_cntr reaches upper limit.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-script.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..f865c8b2f95f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1287,8 +1287,12 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			if (!verbose) {
 				for (j = 0; j < num; j++)
 					printed += fprintf(fp, "%s", pos->abbr_name);
-			} else
-				printed += fprintf(fp, "%s %d ", pos->name, num);
+				if (num == mask)
+					printed += fprintf(fp, "+");
+			} else {
+				printed += fprintf(fp, "%s %d%s", pos->name,
+						   num, num == mask ? "+ " : " ");
+			}
 		}
 		if (numprinted == 0 && !verbose)
 			printed += fprintf(fp, "-");
-- 
2.43.0

