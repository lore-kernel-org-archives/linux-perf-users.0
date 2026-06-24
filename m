Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20F367B72;
	Wed, 24 Jun 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334734; cv=none; b=OyNjfjIps2zvKKkIaMchSXzJ29FPOqr0dgLjau2NB6Hvu+ABDOWIk2ihEqrVdXQbRcjri2ujHXawYk4VJTzNUwKZhLQuIJ7ff7WMRtno10XFsEfL13wEqjQGdNqitWosFbFlk0qLDCH1ppqKg5Paq2j9Po+sclU3RUQbkHt+mOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334734; c=relaxed/simple;
	bh=KdxgcECqm+qrERwlmnvXPMYXtp127joW5LFlLMsHqtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOJB/bEe10jdJBoa3EqLmjeuK9jiTtCbNHcPCjhFeelkuYXignRnctdOUaoWlUiqQN8gKbaKTSXFg5eNjMKsXZMgPmFlv5ZtEeMpRoEwyX7YyX2zXumLVX9rKG62tAm7zKIMNewHJpxBts56BnoweHEzHGHfGtZ0McVL0cKyXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9czairo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9czairo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A321F00A3A;
	Wed, 24 Jun 2026 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782334733;
	bh=hgjY3OY8rh+9sfUyFUybuoCbbl4I+M29zfMhhh6u2K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X9czairoRw4WaPEfEbignRTLDoRhofK6DQsta0heM1eFQeQcKm02whM/bKwDzjPrn
	 VjAy1yY21L2zFPeGbXVGjVTN/wHU39HCo2UGckqX8xWt+GYHrxvlkgacRBOLdtyE4W
	 ehZbOCAccmOwUGKms/TBGrYdoBS4gYDH1R5mI6PiLOAnGtRQpvh68A3/QGWtaHUP2V
	 /tu363B8+C/dYJ4MkkeWl9TcMn+6Pyt+4RvaFsu3efZ3taNpLpyT+8R+PdiSfn+Z0I
	 3/p4erAjbZBNz92Lmdeht02DcRMgmD9s2uaSN5t0010yaGpdiAr6232Q4Y23ysyEn0
	 TnJRF5ts3Hs8A==
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
Subject: [PATCH v3 1/8] perf timechart: Don't pass @event to cat_backtrace()
Date: Wed, 24 Jun 2026 13:58:27 -0700
Message-ID: <20260624205852.3864874-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624205852.3864874-1-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

