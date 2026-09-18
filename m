Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429F3C9429
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713176; cv=none; b=aJOClEA+xaQrU9dbrvi45+nl3IUO/jSeDiHdVOFLxw2khHe6AC1Wk61wHoOmMt9ToGQqA0V50g7ilEVVPfLaPv8HN6rj71vPo+0p1UQHq6wjGA9ypGZYH+AFsRvBiWai4unbxPBffcxaduzQF5TYQHf7Hp4BFCwo8X1kTuhNnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713176; c=relaxed/simple;
	bh=dIPvBV5m1XYpsGMWImgGjBXKGPvtWXXZWXBA2YSCgUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubHKzvhBmvkIHsByFVA5Ls3+5eO/LcWy7ErNnRje6/Eg4d1HWn2ixRamzKYYchYqgsc0hGd28mM+yWBR5DFsSGWgTuoTSHm+FCMfuMQqzdA8b0cTXvjhtGe6VRx2uYu4tETZwN7znBbztc9kcJnrLh0vePN7JfTeQeVQHNpqhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2xIhL/r; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2xIhL/r"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so1205393a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 23:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789713175; x=1790317975; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BpesHv/rYkWgPvEqpfqRdL4BWaPoNf2A+UdcBx5dbmY=;
        b=n2xIhL/rox3UX9O3pakSCFUorqRAkvsPefgZ5eXSG1sWMUwjjRfCBX79GU5dxM3AWO
         27yfWyXZG8aj/yM1/eKApsbmbUQNBKHmvJzzG0g+61jefPYYr/+45mQKnPe24EVNUjyF
         4zdrQ0lQg9iDoAww2drYeZRDXv2OHJxtXQK4laA7OxUBshvDaA4j45Bftd29k3XpkmAJ
         nW9xnJJN1VmneR73M0QU0u2lNlHNKN1pyrH0vX75PXI3WF19EyElAsaNQnsd97LUCMXb
         y7fsHg4cyQdKzhPr52trVx+rLVaTOGtqr05bTqs9XyM4a/ODlakrzCyXTlFpDJi2Nb2+
         Xb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789713175; x=1790317975;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BpesHv/rYkWgPvEqpfqRdL4BWaPoNf2A+UdcBx5dbmY=;
        b=rhadfC/sTGycVSpn9H7TUBVqnWAZZwTAzrKdTLwbxp3yeoVypDUANu3BiWtCIyOvJx
         0JQaVsmkBxbVGSah3n8stVuf2BGNUX2J6px6320a1RrTUMm5GokHk6XxVQbtzCpwwfwS
         jx7coEYkFPPtdaMtKhFaIu7mf0/kQ8spJsAJXFJGy8vQVEqcRh2Lq/CMiTAed4H8JIP6
         fbqhoeh/Qlh3bk4U7Av5kkMqaYLv94lVwYiXbkpUXKFdCaAW9CM2TsRaiEaY2Tzbgk3o
         EVuITpkdsN5tqjmmRSp8hl0amxfC9mlUtqFD3A2NFGBcpZBjXK9Iwa7mkpDP6sHpV53t
         aWcw==
X-Forwarded-Encrypted: i=1; AKwUvBxWxUNQyEaajxkybXLUfXAnC2alD4XbwFPAGEBf2WRIhV8JeHLwWbrDDswaGmqGfzagLdh1seWQ6ScU4hx0pafn@vger.kernel.org
X-Gm-Message-State: AFuF++kTUkuq9/YZM/XG+lgDBBtpOO1WjmdYY3tm/jzXck+pNTGBSUmx
	haQyPg23FRoNRzQr+vwPcd56KqE9ICXISAJPf1nAjgdYr5AV7tP8TUB0Bxat4FkclAJNTwcnLod
	gI3b5K7hP0A==
X-Received: from dlan4-n2.prod.google.com ([2002:a05:7022:eb44:20b0:144:d065:6639])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da88:b0:39e:4c81:6c97
 with SMTP id 98e67ed59e1d1-39e54f91d31mr3537519a91.29.1789713174549; Thu, 17
 Sep 2026 23:32:54 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:32:45 -0700
In-Reply-To: <20260918063249.2172589-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918063249.2172589-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918063249.2172589-2-irogers@google.com>
Subject: [PATCH v1 1/5] perf trace-event: Report tracepoint format errors with
 NULL and errno
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_event__tp_format() encoded failure with ERR_PTR() while
trace_event__tp_format_id() returned a plain NULL when tep_find_event()
found nothing, and tp_format() itself returned NULL when
tep_parse_format() failed, as its return value was discarded. Callers
test with IS_ERR(), which NULL does not satisfy, so those two failures
were taken for success. In syscall__read_info() that leads straight to:

	if (IS_ERR(sc->tp_format)) {
		...
		return err;
	}
	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))

which dereferences NULL when a format file fails to parse.

Mixing encoded error pointers with pointers that are compared against
NULL is what allows that to happen, so drop ERR_PTR() here and report
failures the way the rest of these paths already expect, by returning
NULL with errno set. evsel__tp_format() no longer has to translate the
error back into errno before printing it with %m, and the remaining
callers become NULL tests.

syscall__scnprintf_args() gains back its fallback of printing raw
arguments: it asked for IS_ERR(sc->tp_format), but syscall__read_info()
had already replaced the error pointer with NULL, so the branch could
never be taken.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c     |  3 +-
 tools/perf/builtin-sched.c    |  5 ++--
 tools/perf/builtin-trace.c    | 10 +++----
 tools/perf/util/evsel.c       |  5 +---
 tools/perf/util/trace-event.c | 52 ++++++++++++++++++++++++++---------
 5 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index e1b2f5bc1ba8..8693c6b135ca 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1870,8 +1870,7 @@ static bool slab_legacy_tp_is_exposed(void)
 	 * means the tool is running on an old kernel, we need to
 	 * rollback to support these legacy tracepoints.
 	 */
-	return IS_ERR(trace_event__tp_format("kmem", "kmalloc_node")) ?
-		false : true;
+	return trace_event__tp_format("kmem", "kmalloc_node");
 }
 
 static int __cmd_record(int argc, const char **argv)
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index dd39a4fb6c7a..5b4092ae33ee 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -5182,8 +5182,7 @@ static bool schedstat_events_exposed(void)
 	 * Select "sched:sched_stat_wait" event to check
 	 * whether schedstat tracepoints are exposed.
 	 */
-	return IS_ERR(trace_event__tp_format("sched", "sched_stat_wait")) ?
-		false : true;
+	return trace_event__tp_format("sched", "sched_stat_wait");
 }
 
 static int __cmd_record(int argc, const char **argv)
@@ -5240,7 +5239,7 @@ static int __cmd_record(int argc, const char **argv)
 
 	rec_argv[i++] = strdup("-e");
 	waking_event = trace_event__tp_format("sched", "sched_waking");
-	if (!IS_ERR(waking_event))
+	if (waking_event)
 		rec_argv[i++] = strdup("sched:sched_waking");
 	else
 		rec_argv[i++] = strdup("sched:sched_wakeup");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 20fffc24507b..5bd62b61287e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2385,7 +2385,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 	snprintf(tp_name, sizeof(tp_name), "sys_enter_%s", sc->name);
 	sc->tp_format = trace_event__tp_format("syscalls", tp_name);
 
-	if (IS_ERR(sc->tp_format) && sc->fmt && sc->fmt->alias) {
+	if (!sc->tp_format && sc->fmt && sc->fmt->alias) {
 		snprintf(tp_name, sizeof(tp_name), "sys_enter_%s", sc->fmt->alias);
 		sc->tp_format = trace_event__tp_format("syscalls", tp_name);
 	}
@@ -2394,11 +2394,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 	 * Fails to read trace point format via sysfs node, so the trace point
 	 * doesn't exist.  Set the 'nonexistent' flag as true.
 	 */
-	if (IS_ERR(sc->tp_format)) {
+	if (!sc->tp_format) {
 		sc->nonexistent = true;
-		err = PTR_ERR(sc->tp_format);
-		sc->tp_format = NULL;
-		return err;
+		return -errno;
 	}
 
 	/*
@@ -2681,7 +2679,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
 								  bf + printed, size - printed, &arg, val);
 		}
-	} else if (IS_ERR(sc->tp_format)) {
+	} else if (!sc->tp_format) {
 		/*
 		 * If we managed to read the tracepoint /format file, then we
 		 * may end up not having any args, like with gettid(), so only
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c663aafa88b2..2570ea8d5d7b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -720,10 +720,7 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
 	else
 		tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
 
-	if (IS_ERR(tp_format)) {
-		int err = -PTR_ERR(tp_format);
-
-		errno = err;
+	if (!tp_format) {
 		pr_err("Error getting tracepoint format '%s': %m\n",
 			evsel__name(evsel));
 		return NULL;
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 000c1e1d68c1..10a7652f0305 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -7,7 +7,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-#include <linux/err.h>
 #include <event-parse.h>
 #include <api/fs/tracing_path.h>
 #include <api/fs/fs.h>
@@ -77,7 +76,7 @@ void trace_event__cleanup(struct trace_event *t)
 }
 
 /*
- * Returns pointer with encoded error via <linux/err.h> interface.
+ * Returns NULL and sets errno on failure.
  */
 static struct tep_event*
 tp_format(const char *sys, const char *name)
@@ -90,38 +89,65 @@ tp_format(const char *sys, const char *name)
 	char *data;
 	int err;
 
-	if (!tp_dir)
-		return ERR_PTR(-errno);
+	if (!tp_dir) {
+		errno = ENOMEM;
+		return NULL;
+	}
 
 	scnprintf(path, PATH_MAX, "%s/%s/format", tp_dir, name);
 	put_events_file(tp_dir);
 
 	err = filename__read_str(path, &data, &size);
-	if (err)
-		return ERR_PTR(err);
+	if (err) {
+		errno = -err;
+		return NULL;
+	}
 
-	tep_parse_format(pevent, &event, data, size, sys);
+	err = tep_parse_format(pevent, &event, data, size, sys);
 
 	free(data);
+
+	/*
+	 * A parse failure leaves no event behind, report it rather than
+	 * letting a NULL be mistaken for a successfully parsed format.
+	 */
+	if (err != TEP_ERRNO__SUCCESS || !event) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	return event;
 }
 
 /*
- * Returns pointer with encoded error via <linux/err.h> interface.
+ * Returns NULL and sets errno on failure.
  */
 struct tep_event*
 trace_event__tp_format(const char *sys, const char *name)
 {
-	if (!tevent_initialized && trace_event__init2())
-		return ERR_PTR(-ENOMEM);
+	if (!tevent_initialized && trace_event__init2()) {
+		errno = ENOMEM;
+		return NULL;
+	}
 
 	return tp_format(sys, name);
 }
 
+/*
+ * Returns NULL and sets errno on failure.
+ */
 struct tep_event *trace_event__tp_format_id(int id)
 {
-	if (!tevent_initialized && trace_event__init2())
-		return ERR_PTR(-ENOMEM);
+	struct tep_event *event;
 
-	return tep_find_event(tevent.pevent, id);
+	if (!tevent_initialized && trace_event__init2()) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	event = tep_find_event(tevent.pevent, id);
+	if (!event)
+		errno = ENOENT;
+
+	return event;
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

