Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983C142E83;
	Wed, 30 Apr 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036203; cv=none; b=AwITFrNRQHvaQy8azM88l4QHZneWMIq7zp0dQc6nnBapX1ygwcia4g66h0lseKdvMWnO0nD7EZ58jF2+lGweVSYZKE5App94lii/7XRstS08qn5+xyJqQ1LsJ20VvYO+2xe/GBZJL5d38PuWfBTLqmTCohRmVWnR8bTGUM1Hc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036203; c=relaxed/simple;
	bh=YuF+Y8lZeJUIfvxlu78X3rIBrk+bdi/gly1rdAM22iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlCBjRbcAI4CrQqQ4xXLm/Cdn5huCe+ZaVjGld9duFiP69aOpW5uFEHg9LPwGWrBgVzKgd+39bM8LKIViTFNeL+5gIdW1yRwDN2ooENGdXmxX3nsjQHKQtFRPY5254OCqfZuk9dX8DmT3244Slb0IONqPYOHJCY5IAAzUJpE6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKgckvvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKgckvvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCD1C4CEE7;
	Wed, 30 Apr 2025 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746036202;
	bh=YuF+Y8lZeJUIfvxlu78X3rIBrk+bdi/gly1rdAM22iA=;
	h=From:To:Cc:Subject:Date:From;
	b=EKgckvvDJIaD4a02ANaemOglZ69Cv40ZB8TtfULV5L39tyWQhJgX2OVfx5uWdBkrQ
	 mFq7gAZG5sl+Cg/E6RdaJQDBc/u0cL/4VxWJcxua1+I5fF5mXvTjYTlluDnxKdsYj7
	 Fjcrd9ADH+ciryo65hVcgu2jshrDNW+V5lPJstB3hyd/FGrd/wZ/RO++cNHf7gvic9
	 Reo90L+ALxY3FZIN6ucEM7F/p09MDwD1aFoBjoPyZrfJf4xujdsALWyLtKyWp0wBSM
	 gAL77UOn6g+uNPhVFBOIA5eWakTb8/sB/VAU3U4K2agBusWxd0W9iWA9ZkPq3A2dGS
	 lejfAi9bYvyMg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf hist: Remove output field from sort-list properly
Date: Wed, 30 Apr 2025 11:03:21 -0700
Message-ID: <20250430180321.736939-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it removes an output format for cancelled children or latency, it
should delete itself from the sort list as well.  Otherwise assertion
in fmt_free() will fire.

  $ perf report -H --stdio
  perf: ui/hist.c:603: fmt_free: Assertion `!(!list_empty(&fmt->sort_list))' failed.
  Aborted (core dumped)

Also convert to perf_hpp__column_unregister() for the same open codes.

Fixes: dbd11b6bdab12f60 ("perf hist: Remove formats in hierarchy when cancel children")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 3ffce69fc823e0bf..bc0689fceeb18bde 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -696,6 +696,7 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
 static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
 {
 	list_del_init(&format->list);
+	list_del_init(&format->sort_list);
 	fmt_free(format);
 }
 
@@ -818,18 +819,12 @@ void perf_hpp__reset_output_field(struct perf_hpp_list *list)
 	struct perf_hpp_fmt *fmt, *tmp;
 
 	/* reset output fields */
-	perf_hpp_list__for_each_format_safe(list, fmt, tmp) {
-		list_del_init(&fmt->list);
-		list_del_init(&fmt->sort_list);
-		fmt_free(fmt);
-	}
+	perf_hpp_list__for_each_format_safe(list, fmt, tmp)
+		perf_hpp__column_unregister(fmt);
 
 	/* reset sort keys */
-	perf_hpp_list__for_each_sort_list_safe(list, fmt, tmp) {
-		list_del_init(&fmt->list);
-		list_del_init(&fmt->sort_list);
-		fmt_free(fmt);
-	}
+	perf_hpp_list__for_each_sort_list_safe(list, fmt, tmp)
+		perf_hpp__column_unregister(fmt);
 }
 
 /*
-- 
2.49.0.906.g1f30a19c02-goog

