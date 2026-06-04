Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADDF37646E;
	Thu,  4 Jun 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600095; cv=none; b=bygHsnZTA+c6yiRuDbo90nznJkG+RXMic1TDPTEZXymEfPQT68/E2utYhL7r9rZNg+gTlxy/NTGnqfQGSosBX8AediCROeaXBKh2R/37BSA2xOL3XJ0VuIItXZEQvjIb3MvAV6eyQBa+brXrNJ5IdDys9wislmSNQHtApH7Hg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600095; c=relaxed/simple;
	bh=s9T70sQxiQJvjGYD/9kQcsxcsPLn/NwTDO7wW7XLcLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3z0XRJS4hr7hln6dOR9NHtyQuiGZ6QbRf6PgO+R+2LWI1eJHvtMcck0wRlGqQC+k428cgejjCBNQXIglNEnOIYNWzHcyCnRU07flmqHgD27a80xNjIHcJ3QJNJOMXmT9YypQGpQ16M5P/507sFNuouXlxA7WAG8O2QeX4y/BPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOGFM32c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOGFM32c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F941F0089B;
	Thu,  4 Jun 2026 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600093;
	bh=X7r0P5w2HbxKFj1JMinted+quLZ0T7Kak6r1aDsmJWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOGFM32cUMm5Kj0GvDtKRYbIhLqt2SxkhpVm/ZS2WW56TxO88RRbpUJI5TrvlMeN5
	 7GjdLItdjzpUPewYIlmuQwVzOZZUWDdr2EW3F+Z1oThufnLX9t/SzV37pZNfrZHHQN
	 h1Eh4jMP/cOCGSqAbT7jgmHU97Q5HGmCKRBBDAZTQRmh2OJ5GAqA78Udnik8vvEvlc
	 lhnn/brffynfgU7HEfY48OzWQXRJ2XbWAq7/UXiGTa/WR7y6SI8mUi1ehIlJkBIr6U
	 pyCPCIVu0Ckc9ikkeNYJQKrukSvZ4dHgqX933muh7IhjQ79JQ8P822BNoF+m2RcBR6
	 eXqQ8s/NHikPQ==
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
Subject: [PATCH 1/4] perf timechart: Don't pass @event to cat_backtrace()
Date: Thu,  4 Jun 2026 12:08:07 -0700
Message-ID: <20260604190812.2168118-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604190812.2168118-1-namhyung@kernel.org>
References: <20260604190812.2168118-1-namhyung@kernel.org>
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

