Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE241BF38;
	Thu, 27 Jun 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512358; cv=none; b=ayeCNiEllfZT8CqcQk5QGoAW1Y8Quqsl8bxO+GGke2zy1w8/VqDlvLyRr3UGY4ZhGop5Bd6nniZAx+8xiXtMZoAEiOLdqtcfazuwChcidLeTcF5fWGDo3Dj0/frvUVhrLAykelOyuu4J08DXpsPPSsCDcU9fPLKhlW/iW4L5qbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512358; c=relaxed/simple;
	bh=gr6oWfFtPj7v+3PQUG98mSXnWnFpCuUOqhVB7V63gZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDFYAM1NGquLSlqzvBBZAd8WSDGhKJ/yg2rFM9fdX19i34HltYcWToIT2OjdTnFtbLpXIt5pffZVS/0TTS/opGrH8l02x3m1nf8XukmkIXCVEH1fOMo3KkQRJ+fROgizNj2SqckEvluEWU2TLBIsRihljKQZ8VIOzHArPRRrXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpLILaJb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpLILaJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476DEC2BBFC;
	Thu, 27 Jun 2024 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512357;
	bh=gr6oWfFtPj7v+3PQUG98mSXnWnFpCuUOqhVB7V63gZM=;
	h=From:To:Cc:Subject:Date:From;
	b=hpLILaJbJWrO+OYKP1h8ISPFZla8fe6/QyKYA0orOJW8pjUDXalNav1lYxQXlWYAI
	 lJ2bxQxb2EDzcbiYhDTcsAJEi86RyTgXRJYnG8v89nEVVHVAsBIiU6aszVsVex7KiX
	 wZu5A0kbGg20n5WQ3rKXeKmR6dA3NnxQCRGWs8gVLRm7gK5xp89tIMqtgypmw11IQU
	 wy0lM7y0/ziqzBhXfztZZP0yn1nyDRgTLgbg9MOJUWCw7jiB73cjTAt8/z22WICDIS
	 EM+2gpxlA6p5Nfh6Fg0I50y9j78yvoUW2et5wyeMefPTopWc3+OMxupnX0A6OWe4UD
	 4FqLPzDCGSbrQ==
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
Subject: [PATCH] perf report: Display pregress bar on redirected pipe data
Date: Thu, 27 Jun 2024 11:19:16 -0700
Message-ID: <20240627181916.1202110-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible to save pipe output of perf record into a file.

  $ perf record -o- ... > pipe.data

And you can use the data same as the normal perf data.

  $ perf report -i pipe.data

In that case, perf tools will treat the input as a pipe, but it can get
the total size of the input.  This means it can show the progress bar
unlike the normal pipe input (which doesn't know the total size in
advance).

While at it, fix the string in __perf_session__process_dir_events().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0ec92d47373c..5596bed1b8c8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2050,6 +2050,7 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
+	struct ui_progress prog;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
 	void *buf = NULL;
@@ -2057,9 +2058,21 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	u64 head;
 	ssize_t err;
 	void *p;
+	bool update_prog = false;
 
 	perf_tool__fill_defaults(tool);
 
+	/*
+	 * If it's from a file saving pipe data (by redirection), it would have
+	 * a file name other than "-".  Then we can get the total size and show
+	 * the progress.
+	 */
+	if (strcmp(session->data->path, "-") && session->data->file.size) {
+		ui_progress__init_size(&prog, session->data->file.size,
+				       "Processing events...");
+		update_prog = true;
+	}
+
 	head = 0;
 	cur_size = sizeof(union perf_event);
 
@@ -2131,6 +2144,9 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	if (err)
 		goto out_err;
 
+	if (update_prog)
+		ui_progress__update(&prog, size);
+
 	if (!session_done())
 		goto more;
 done:
@@ -2144,6 +2160,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	err = perf_session__flush_thread_stacks(session);
 out_err:
 	free(buf);
+	if (update_prog)
+		ui_progress__finish();
 	if (!tool->no_warn)
 		perf_session__warn_about_errors(session);
 	ordered_events__free(&session->ordered_events);
@@ -2523,7 +2541,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 
 	perf_tool__fill_defaults(tool);
 
-	ui_progress__init_size(&prog, total_size, "Sorting events...");
+	ui_progress__init_size(&prog, total_size, "Processing events...");
 
 	nr_readers = 1;
 	for (i = 0; i < data->dir.nr; i++) {
-- 
2.45.2.803.g4e1b14247a-goog

