Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E22918D7
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652545; cv=none; b=Vp6p2L7dcVOcbQo1+TwE+TsY8mSSHvWDrzkUuvo3OL4ZhxTn/O/0Ck70wzTtxRanZGAJF+jQFGLkA4ght2ngYDQAIQI8NoZSztkiH9PXYNKZ2CxaawBWmtOC3qSiOp56PaimbAUikAuSxa2SamrU0BrUEpWICZyjqMYcwN/mYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652545; c=relaxed/simple;
	bh=jxvwzo+E0Y6REh0vGM59W3ZsATahVyXgFYiSUfatgsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oK819JMhdq3rUx2PD0scNbP5yNUNqD6vABnp6UenUJYsDOCcJM2srMERyMa2orCfwVr7yrhM/E+b/GKl5GD7JwoTMb4lZAFvOd8TvHQjBeGg/HOkP2RW9DPtmToLlnFQDFCo9rfRAUXc0RzPjICBbGaUhtxLoBxlp56CVCNOqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzvo4LZm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzvo4LZm"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-306b51e31c7so3752607a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652543; x=1745257343; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wtTJDwGjBW9lW9i9Wpstm5B+fjJHY6yZ6LuJ53a/ko=;
        b=qzvo4LZmuCuWQw/IbbW9Jo/cweA62B5pb+/jCFhnvqdqWOqiKpxWeYLWIrc0E5GWfu
         Pl/wAJYGwc78mlWhSCO6hS9zuLHLwqlOL9ADq8iubJxMJVEnqXzPuBS2ivawzv0qR526
         bIUubW+RxM4/MbpFUbR47/Gv7Y48DbRuvbulp1b0e+doZMqjbKtQnnRFwKDfLdOzuVv1
         o262rOFXztwXka7x0qZiXq1ZXndtDyviAUb89XP3rqFWxSqZYHopPbcCNz3f6mO6hV7O
         R+pzCKcfS03qXJlh4uldAAENOa23lqUQyHNhPGpBucPCtrtsRex8m5CirtEJYXczYuh4
         pKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652543; x=1745257343;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wtTJDwGjBW9lW9i9Wpstm5B+fjJHY6yZ6LuJ53a/ko=;
        b=gBhvUn/FPe6V0o+aEcNMNfR9twIRfofkmZGnmckp9r9c+tW9KyTiSlk9BufyOeU+br
         qFF67VX+MYatMnQEONKKXni1gsyhiiNlZ6UpzT4eCLd1WwCUKKUZmiW72cLX/sLEmYoO
         cOJZh3yK8wwfOAUIIDkOLnaLv1woZXngv7F1/v5fv/Xr7RHb+TPCRDM11Yr2Jg25ssQW
         U7+hwe7GqxxDqwmJdeKhZtkt8lrPC0sRKwHPrXwiwtHMzBdenTDlAVa9f1NjxYVggBOq
         7GtztOiNj9oYSjEHrtewCQNalN6dsrm8uThIsO8AkpWV11y4j+RTDiJyNKYAANE472Xm
         U8yw==
X-Forwarded-Encrypted: i=1; AJvYcCW8suGe1nLAoMBSUQU5AN1B3oNznWk5iou0JjcLk/bEpejnJjDBoyzErlJMABfJO7ULi1du2YzfRbCqGZ4iXmCu@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwKJnVr5RNMoccHxPv+YMZPTB9anZ3AElIuRB89LpbnLdoRb7
	55OL31H/BldexZNTHSmiRvoz3BiqE0HM/rGIaI+3GXXKO4S53WhgpEy5puS54YXn2yjZcZj/q/Z
	uQpayfw==
X-Google-Smtp-Source: AGHT+IHxhg/HSfq/QtHRtd4AIxDQ/mcgJ4pFkSlpMKM/NqthKSS7lzqjhJF0YGsGpeUc3yVgHHsYEitGrfcf
X-Received: from pjbsl16.prod.google.com ([2002:a17:90b:2e10:b0:2fe:800f:23a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2751:b0:305:2d68:8d39
 with SMTP id 98e67ed59e1d1-3082377c2c4mr23724970a91.12.1744652543036; Mon, 14
 Apr 2025 10:42:23 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:32 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-15-irogers@google.com>
Subject: [PATCH v5 14/16] perf stat: Add mean, min, max and last --tpebs-mode options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add command line configuration option for how retirement latency
events are combined. The default "mean" gives the average of
retirement latency. "min" or "max" give the smallest or largest
retirment latency times respectively. "last" uses the last retirment
latency sample's time.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt |  7 +++++++
 tools/perf/builtin-stat.c              | 27 ++++++++++++++++++++++++++
 tools/perf/util/intel-tpebs.c          | 20 ++++++++++++++++++-
 tools/perf/util/intel-tpebs.h          |  8 ++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 2bc063672486..61d091670dee 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -506,6 +506,13 @@ this option is not set. The TPEBS hardware feature starts from Intel Granite
 Rapids microarchitecture. This option only exists in X86_64 and is meaningful on
 Intel platforms with TPEBS feature.
 
+--tpebs-mode=[mean|min|max|last]::
+Set how retirement latency events have their sample times
+combined. The default "mean" gives the average of retirement
+latency. "min" or "max" give the smallest or largest retirment latency
+times respectively. "last" uses the last retirment latency sample's
+time.
+
 --td-level::
 Print the top-down statistics that equal the input level. It allows
 users to print the interested top-down metrics level instead of the
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 80e491bd775b..4adf2ae53b11 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2327,6 +2327,30 @@ static void setup_system_wide(int forks)
 	}
 }
 
+static int parse_tpebs_mode(const struct option *opt, const char *str,
+			    int unset __maybe_unused)
+{
+	enum tpebs_mode *mode = opt->value;
+
+	if (!strcasecmp("mean", str)) {
+		*mode = TPEBS_MODE__MEAN;
+		return 0;
+	}
+	if (!strcasecmp("min", str)) {
+		*mode = TPEBS_MODE__MIN;
+		return 0;
+	}
+	if (!strcasecmp("max", str)) {
+		*mode = TPEBS_MODE__MAX;
+		return 0;
+	}
+	if (!strcasecmp("last", str)) {
+		*mode = TPEBS_MODE__LAST;
+		return 0;
+	}
+	return -1;
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
@@ -2431,6 +2455,9 @@ int cmd_stat(int argc, const char **argv)
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 		OPT_BOOLEAN(0, "record-tpebs", &tpebs_recording,
 			"enable recording for tpebs when retire_latency required"),
+		OPT_CALLBACK(0, "tpebs-mode", &tpebs_mode, "tpebs-mode",
+			"Mode of TPEBS recording: mean, min or max",
+			parse_tpebs_mode),
 #endif
 		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
 			"Set the metrics level for the top-down statistics (0: max level)"),
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index de9fea601964..6b00bd5b0af1 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -31,6 +31,7 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
+enum tpebs_mode tpebs_mode;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
@@ -45,6 +46,8 @@ struct tpebs_retire_lat {
 	char *event;
 	/** @stats: Recorded retirement latency stats. */
 	struct stats stats;
+	/** @last: Last retirement latency read. */
+	uint64_t last;
 	/* Has the event been sent to perf record? */
 	bool started;
 };
@@ -142,6 +145,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
+	t->last = sample->retire_lat;
 	update_stats(&t->stats, sample->retire_lat);
 	mutex_unlock(tpebs_mtx_get());
 	return 0;
@@ -517,7 +521,21 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			return ret;
 		mutex_lock(tpebs_mtx_get());
 	}
-	val = rint(t->stats.mean);
+	switch (tpebs_mode) {
+	case TPEBS_MODE__MIN:
+		val = rint(t->stats.min);
+		break;
+	case TPEBS_MODE__MAX:
+		val = rint(t->stats.max);
+		break;
+	case TPEBS_MODE__LAST:
+		val = t->last;
+		break;
+	default:
+	case TPEBS_MODE__MEAN:
+		val = rint(t->stats.mean);
+		break;
+	}
 	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 218a82866cee..9475e2e6ea74 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -8,7 +8,15 @@
 struct evlist;
 struct evsel;
 
+enum tpebs_mode {
+	TPEBS_MODE__MEAN,
+	TPEBS_MODE__MIN,
+	TPEBS_MODE__MAX,
+	TPEBS_MODE__LAST,
+};
+
 extern bool tpebs_recording;
+extern enum tpebs_mode tpebs_mode;
 
 int evsel__tpebs_open(struct evsel *evsel);
 void evsel__tpebs_close(struct evsel *evsel);
-- 
2.49.0.604.gff1f9ca942-goog

