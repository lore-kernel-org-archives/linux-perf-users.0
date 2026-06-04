Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9DF329E6C;
	Thu,  4 Jun 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609774; cv=none; b=EHhud9q1CmWFNKlutNtesw96XssSAJjYGQ+Nr/nFD3daQ5qo1fXQZXzVOkVdFSpWnUfOaIw8hEWzqV5kHEgCcSjZLpX8e6W9eBJn7dkypl/B4HPH+umXFLaBez/59fCHGFsrGtxBO935GL7+vPiLvlAQ0uy7vDkaEca06Uxwze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609774; c=relaxed/simple;
	bh=s9T70sQxiQJvjGYD/9kQcsxcsPLn/NwTDO7wW7XLcLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+KbCn56aTm7CRNJ26se/AWIQtQWLW64zNHA1ak36p9sPkbmkC8ne8v5Ou1iN/WUOxVLIgxyw8yCZhDr71aaCuHhf4uuLzFJmf3zMX3hHSTZqRRRh4jS0UfsdBrMPhCgZXTJw+GE40+jY7zulE+HdH/YujcG5YfGI0Fsg3Dtm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPI2RBfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPI2RBfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5361F00898;
	Thu,  4 Jun 2026 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609772;
	bh=X7r0P5w2HbxKFj1JMinted+quLZ0T7Kak6r1aDsmJWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KPI2RBfpXISn6d3ycTjkmMCEmyS6abmqRurYMVtU8sFLxgpDMwAH5+7jcglLulMIi
	 UIfn1RYZind/ZvkP4Y5cBtQGdvWlLpEwxeDu/HuFsvQOsQHcLZ6jZTQ508pAfl+W0/
	 EXFftecI8XNyIk2/tvT60vJJblbocdryfVF8Kmv+1rpE7ZjNDpW/YLb2H9xLhSSeu0
	 m8ETYXiPgD+ipve4gxDQIHjKR2plOPGGqoS1a6jbgnkedyfSMoP+XvhB1ohYEjTjZF
	 jBMHPXfzLZqrZZkBzXKaIE3dQ9ObLvaHOezVS5e8l5pMZlTWv4/MCeBWvADjQhR2sv
	 PzQMh5hDWnL4Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/4] perf timechart: Don't pass @event to cat_backtrace()
Date: Thu,  4 Jun 2026 14:49:27 -0700
Message-ID: <20260604214931.2202322-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604214931.2202322-1-namhyung@kernel.org>
References: <20260604214931.2202322-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cat_backtrace() is only called from process_sample_event() which
means the event type is always PERF_RECORD_SAMPLE.  We don't need to
pass the event just because to print already known info.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 85a9ad0455aecccd..dafd361ecf9d8cd7 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -493,8 +493,7 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
  * Returns a malloc'd backtrace string built via open_memstream, or NULL
  * on error.  Caller must free() the returned pointer.
  */
-static char *cat_backtrace(union perf_event *event,
-			   struct perf_sample *sample,
+static char *cat_backtrace(struct perf_sample *sample,
 			   struct machine *machine)
 {
 	struct addr_location al;
@@ -516,9 +515,8 @@ static char *cat_backtrace(union perf_event *event,
 		goto exit;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_err("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
-		       perf_event__name(event->header.type), event->header.type,
-		       sample->file_offset);
+		pr_err("problem processing SAMPLE (%u) event at offset %#" PRIx64 ", skipping it.\n",
+		       PERF_RECORD_SAMPLE, sample->file_offset);
 		goto exit;
 	}
 
@@ -578,7 +576,7 @@ typedef int (*tracepoint_handler)(struct timechart *tchart,
 				  const char *backtrace);
 
 static int process_sample_event(const struct perf_tool *tool,
-				union perf_event *event,
+				union perf_event *event __maybe_unused,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
@@ -595,7 +593,7 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		char *backtrace = cat_backtrace(event, sample, machine);
+		char *backtrace = cat_backtrace(sample, machine);
 
 		ret = f(tchart, sample, backtrace);
 		free(backtrace);
-- 
2.54.0.1032.g2f8565e1d1-goog

