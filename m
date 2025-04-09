Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF501F2BA4
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179082; cv=none; b=IQ4t2apgO+eOM+hIWG9ly4D1i+QaHzPK4c0CllbXPSyc0jBUme+2UmbPTOa6IpwHehaKMA1mfMA4Kc4aPOEP+kdkcrzFtSKGtvwmIJX7GITG8Ghc8Kk1K/NMvmJbkO/XDlN1JjnKKkAdETlqB0WIIyMgb99maViaB47ZQEf9tVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179082; c=relaxed/simple;
	bh=j+ajFhze8XNvNedW0+qQsxa4xJpNyLgqbtH3uNHZnh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gRZBWXBxrQr+lSCL0z+/XzNqj9++nsnIavBHeUAkYoPSfLMs3FDN5XnfKXUDjnkqgzP9J1x9Yqxx8gAkqTE8FieKiY9JUd7GrQ5nQKhHAbK54FzprTtCyT0wnWN3HSel1ZWWujqlMF0THdMynpvZTwHR27/n+NU6qCyZLANdh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXhWyLPy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXhWyLPy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso9740578a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179078; x=1744783878; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHpmhSJgyl8CfNQkTk9ozGn6lbmpXan8KmxzNdnU62A=;
        b=rXhWyLPysaQYBQ0ieVesEH6ygF3/xP4eK6U1pcYm5mOm5wU2VgGrPvVfKYTd6XAffG
         nspDjLuI59LEo+ZjXAVlEtJdP76M17J2Ej2B2TqYvx89x7vkQ3OrEdMtVmKSWcC+Gmsd
         nORiTnsTav1B2tHJ0X03M/p/T/s5VQk6u/GR51kCycVoEfvMqBeakg4FyaJvPnJgG/6I
         iutytKRxtOiSTin9TYCPmIMWeuOXnC3j0mvuie5+6o24zjoINsYqy9amKn9NSu+Bw8eF
         UI0JqKjMKPjysLVLGvmT7kAF5wE396F5kFB9GDhlcSa8ys+vLwZ1QMCKfbWAtnZVXwxC
         LmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179078; x=1744783878;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHpmhSJgyl8CfNQkTk9ozGn6lbmpXan8KmxzNdnU62A=;
        b=iQSuUm8PK7rJthj80g40eQET+RaUm3qM1kc0afhpuw9P7+JVw+Ianuzfae9q04gQte
         eDx9R1t7nN69l8//4FMfW66Epz4GR74ZnVmxGatJU1HvRfzgu5ZA08nVrtcbVxDX2nWp
         l8b0RLStUIhSpFwzm8PpKVx0PJY5pqAw2E6pnLDKzqQZDmIc1ocJyzgpNGEYKABwzzTa
         JMW4d/ESXhSkWlCp2kqOln64ko3xditBozfEl0FNXa8tgZdtjRhgdA9I1h+Rs1CkgiqF
         GhQcZfk8UvUZrayZKolUqTuKIl/Obe/RBLYEFk0Gz4f8LTonGGshJIS1MwrNvoFQ7VNG
         7TBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVytrFyqqbmo7+ObjZPm15bIG1s4+cvHHfAgjKUFqMl5rMx+CxsQNwDJ2BhI6UkOSLYk94JNoJnueLgurpmyM25@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpa4OH6kbeqnBpauXbWnUb43tfXb6bA/AoIobe2pttEGA3Twib
	SknBakDX6KI27v1uiWoAywEDP8rGodok4rNPkGRa21cAzIJnNLNMLIeV+EP2/BBH9qC9OaLwH0o
	JKBG6qA==
X-Google-Smtp-Source: AGHT+IGdvPE4F53XVdwo/U3wL0FozvzxXNLjuDuOddsx+hzCG+0dueONRQ1yvtowNc8rrzczZUGLSQxJO5Xi
X-Received: from pjbsz16.prod.google.com ([2002:a17:90b:2d50:b0:2ef:786a:1835])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5344:b0:2ea:712d:9a82
 with SMTP id 98e67ed59e1d1-306dbc3ba42mr2486031a91.29.1744179078561; Tue, 08
 Apr 2025 23:11:18 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:41 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-15-irogers@google.com>
Subject: [PATCH v4 14/16] perf stat: Add mean, min, max and last --tpebs-mode options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add command line configuration option for how retirement latency
events are combined. The default "mean" gives the average of
retirement latency. "min" or "max" give the smallest or largest
retirment latency times respectively. "last" uses the last retirment
latency sample's time.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.49.0.504.g3bcea36a83-goog

