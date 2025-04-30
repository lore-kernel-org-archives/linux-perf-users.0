Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6902C2AA1;
	Wed, 30 Apr 2025 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046551; cv=none; b=eaolyptMEdw4ZEx34kil6KMBx6nVNAPap4jigEtn7kCQ6FQtfpc5rnj70i7LP7hQ4dq+c1rukjepCpyWrTkldr4t1TQ5pHFS8LQfjiHvb/N+0aYCV8IUsg/oiQBGHnP12w4OGzeY0tURIUm33qUFlef6qZTByFWFFz7fbO0BSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046551; c=relaxed/simple;
	bh=YuF+Y8lZeJUIfvxlu78X3rIBrk+bdi/gly1rdAM22iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6ZZT3jg3Epexs7Fpw68pnlbfTh8/m6jK9+FoHYcfPvNY6pZIdt75/n7mXLrhGb1OpF1rJaz4+nsuJg/6KBWVgGi+zxLhCgKzoRycUOUtTt+1i1FYO99Ugu4MCQkL3NJtQLMECbqt+U7cBtvDGJRPPaPN6J4mlU779uugurYBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNsp71HH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNsp71HH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDF0C4CEED;
	Wed, 30 Apr 2025 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046550;
	bh=YuF+Y8lZeJUIfvxlu78X3rIBrk+bdi/gly1rdAM22iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNsp71HHnYHBZ65kQLDdo16/9nhDVe9NbJ2kYeYWWgduY70k7w0lhdW4kxP16ekBX
	 UJN7iOJvMEUIbELQIk5daL8TsyxfpouTQNAUADwd5A0B/delqPERQx6y6GIHSQQ+2G
	 pvfRSyaln7Emfj3LA8bELNh+MxRzuWQze9cdB2d49aL/Y6i+G8GKHM+ucXSnsJpdlA
	 rUEODn+RTKrqc/soEyZ1llJbqUfm+dD6k/aUPQrNDdH0yzFn3NjgKzo2tEz6++jla6
	 kq/INArrvsi0i4i73p+pQMX2xFYnjqKlqZ9XIhGA+dIvStW3vIo0JvH/JywqEhCecM
	 0cyW3ZuplyDGQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 01/11] perf hist: Remove output field from sort-list properly
Date: Wed, 30 Apr 2025 13:55:38 -0700
Message-ID: <20250430205548.789750-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
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

