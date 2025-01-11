Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274EF1FECCE
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622140; cv=none; b=oJRuX/MdT/D9ic/+IELymApsM4o2KZwFNbO/HoSkbCuXaVHn2y4d6hwEj7oqm4gASOcb5rSI86mZGlI0kYB5DWOtH87OCKhFSbWyayU+FC8hpFdwGRAXnWr+Wq6w1N1FAeakatjUM8QNRzfqW2javl342T5Gc0Ub9uYT6BJEMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622140; c=relaxed/simple;
	bh=jw95DsSah39EFCB6wIos9k/jmDl0fO+APaljFVuh7GU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=opZj5Ygl0lJ7FRodqcFdk9MqHHNxA9c3WRyl4E9/Gf82R9hc9PsLfSBmHCOJEnCYva9ivKaa10gtntvfSS1EINnPGqMhnHdVH4O00sYbLGnmTHlaCpXdCdqFG9a8PMrU1/4c70CZaiw+U6uBi6ajJsYDzGl5v5CepS6QAeaqa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5ViytjB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5ViytjB"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5382ab0b41so7488253276.2
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622138; x=1737226938; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ykf/YNCf3GJy9g72qoRrq28DSjwK5D2gHldZswBy/4=;
        b=Q5ViytjBU47FXLskcxJSzb7dAC1bkgPzpiBetNw6pS+pWBbLiYEd0ltpbg1Rz+eJRL
         UGy2Qp+mYfEF0LKBjlcPCgE7bFCH6GS2o92sF8Z3puZmKc+2xSyiVeKFTU37nR5Erf+t
         sRm0GulAPePdDSoANLstKwfdL0hVZkBf6xsFZ/B3ACSg1eQwhlIu/ZdKWhCot8Ps+BH1
         sI6z3BuSagnwZpK7+LjCjepxcWdZgViqIuDsU9M1ZKlx0mu9VUqEBQKn5nLK2ftSAVtH
         Uhx3eDAGChBsASpm5nuXbSOnaCmUOLSwSV1OFf/ML/JydUT4Opgnwm5h97lolnCe98/q
         9m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622138; x=1737226938;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ykf/YNCf3GJy9g72qoRrq28DSjwK5D2gHldZswBy/4=;
        b=Fxo8gTXObunKzAAvSjn1fqSUqFNn0faCCBkSeI1VoDIjvGyPvfkmLsG1F4ttlyfYLq
         RntlD0MZWCdxm3D8ghQbz3WefXN8kLCxy8zdYARnH5gAGtPn6UBQ2RngY4gfI+7h5I/H
         L5/yiUz7xfasCQ0PUYPVy0SejQAiXujsENmmQCKOZ2OW+Au29XgIFN8pqMOMtRLWp0OK
         68d6Mx9fpKisMyLiM+yVLfiPVYeyu8SbVY6F1Ram8KiSgl0moHdA3mWAv7GT2dY4mYZA
         agDHzIzv3m4g7HpRRDGlLRys5usj9RvfTLzHAdf754LxnfaATcrOSxM+X9g/CQqoyFJi
         qIjA==
X-Forwarded-Encrypted: i=1; AJvYcCVtBxD0iGFVyy6XLp0ZktbkjRLT5o49gpv/KsjCsqdVrFcHNAzOolAV0iVeherM+awyuwQbc+2nR8pXUFBT2Tt6@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBk20A/0guZ4hfXRLA4qbugIMNGeE0W5TCX4R5lTq4dqPTlVn
	nkQucttNtB3KvVrRrI4rzhxNhHcV3RuiQgchDtVZx1WQUsMGy+/49npS/PgTxdfLCvQGS0Zu39z
	IDHMFhw==
X-Google-Smtp-Source: AGHT+IGVdVNplEgJ1YmjInMhNR8NwXdOlknuLCSjmZ65mMLBefHVaW1iMrUjgOvx+OmIBZYgyL33UbrhR0gs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:b293:0:b0:e39:7a90:7b2 with SMTP id
 3f1490d57ef6-e54ee1f2d7amr33639276.7.1736622138212; Sat, 11 Jan 2025 11:02:18
 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:41 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 08/10] perf bench evlist-open-close: Switch user option to
 use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/evlist-open-close.c | 36 ++++++++++++++++------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 79cedcf94a39..bfaf50e4e519 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -57,7 +57,7 @@ static int evlist__count_evsel_fds(struct evlist *evlist)
 	return cnt;
 }
 
-static struct evlist *bench__create_evlist(char *evstr)
+static struct evlist *bench__create_evlist(char *evstr, const char *uid_str)
 {
 	struct parse_events_error err;
 	struct evlist *evlist = evlist__new();
@@ -78,6 +78,18 @@ static struct evlist *bench__create_evlist(char *evstr)
 		goto out_delete_evlist;
 	}
 	parse_events_error__exit(&err);
+	if (uid_str) {
+		uid_t uid = parse_uid(uid_str);
+
+		if (uid == UINT_MAX) {
+			pr_err("Invalid User: %s", uid_str);
+			ret = -EINVAL;
+			goto out_delete_evlist;
+		}
+		ret = parse_uid_filter(evlist, uid);
+		if (ret)
+			goto out_delete_evlist;
+	}
 	ret = evlist__create_maps(evlist, &opts.target);
 	if (ret < 0) {
 		pr_err("Not enough memory to create thread/cpu maps\n");
@@ -117,10 +129,10 @@ static int bench__do_evlist_open_close(struct evlist *evlist)
 	return 0;
 }
 
-static int bench_evlist_open_close__run(char *evstr)
+static int bench_evlist_open_close__run(char *evstr, const char *uid_str)
 {
 	// used to print statistics only
-	struct evlist *evlist = bench__create_evlist(evstr);
+	struct evlist *evlist = bench__create_evlist(evstr, uid_str);
 	double time_average, time_stddev;
 	struct timeval start, end, diff;
 	struct stats time_stats;
@@ -142,7 +154,7 @@ static int bench_evlist_open_close__run(char *evstr)
 
 	for (i = 0; i < iterations; i++) {
 		pr_debug("Started iteration %d\n", i);
-		evlist = bench__create_evlist(evstr);
+		evlist = bench__create_evlist(evstr, uid_str);
 		if (!evlist)
 			return -ENOMEM;
 
@@ -206,6 +218,7 @@ static char *bench__repeat_event_string(const char *evstr, int n)
 
 int bench_evlist_open_close(int argc, const char **argv)
 {
+	const char *uid_str = NULL;
 	const struct option options[] = {
 		OPT_STRING('e', "event", &event_string, "event",
 			   "event selector. use 'perf list' to list available events"),
@@ -221,7 +234,7 @@ int bench_evlist_open_close(int argc, const char **argv)
 			   "record events on existing process id"),
 		OPT_STRING('t', "tid", &opts.target.tid, "tid",
 			   "record events on existing thread id"),
-		OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
+		OPT_STRING('u', "uid", &uid_str, "user", "user to profile"),
 		OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
 		OPT_END()
 	};
@@ -245,15 +258,8 @@ int bench_evlist_open_close(int argc, const char **argv)
 		goto out;
 	}
 
-	err = target__parse_uid(&opts.target);
-	if (err) {
-		target__strerror(&opts.target, err, errbuf, sizeof(errbuf));
-		pr_err("%s", errbuf);
-		goto out;
-	}
-
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	opts.ignore_missing_thread = opts.target.uid != UINT_MAX || opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	opts.ignore_missing_thread = opts.target.pid;
 
 	evstr = bench__repeat_event_string(event_string, nr_events);
 	if (!evstr) {
@@ -261,7 +267,7 @@ int bench_evlist_open_close(int argc, const char **argv)
 		goto out;
 	}
 
-	err = bench_evlist_open_close__run(evstr);
+	err = bench_evlist_open_close__run(evstr, uid_str);
 
 	free(evstr);
 out:
-- 
2.47.1.613.gc27f4b7a9f-goog

