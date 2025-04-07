Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F42248B8
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060243; cv=none; b=new/WIoc0SRp74VtzBJJom0/U03cO3WjlszeKOs5E/zSFnmYNtpnbrsj9LAxcFbhPUww9PmfSv5xgtmmaM33bkExRNmH3Y03s9uKIGawllBetttH+0UuORPzzFK0w0xFmb9+QWqn5sL54hx/7OD71OU9sJ50R1f9gK3r5LAd5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060243; c=relaxed/simple;
	bh=ljmD0cTVkTPSjeRTew6uc5xLS1AYn1ipDaRrb9bphs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Y5RmmJcF7DTDRoGBYGw+G0iEP/tG/hjEZKijBg2NL/baxV6G50mcC7VKAjXYLNf+/4jwVsa1vaZR5wnZYwlGLvMcLdvgg+58fImXgh7Utu0Oev5HSKAux648DTV/58xFMhlW1d3zMZ/rSNU7TIvY+hJR+nbci744MHQVhjl+og8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nxiuIhy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nxiuIhy"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so4659295a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060241; x=1744665041; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0AuvTirY7qrM/gCswfIrUXj0T0vw1kKdRIHGiOGwYc=;
        b=2nxiuIhyxew/GaSsn8TRIwUvxK1nemuPdmhjsxrj5jX7lKVtRL1I10nDzfnI3BmF7l
         qEIQKr7yDEWy2fBxTfXtDCKBOyZJojcU15zucr3l6kZyBhQBVNek3zD/mDD1vD59WPT9
         pCNbPrMlBwVK3gdulTbicZkYCOa+9LMvcQAyWfNCcG+39dt8BzuNE2/SN71T+suANscL
         xWn5f3O6Yjj28MB0wTlhacZzZa3wnoo4HUkOVHsgFGYst5abuAn0j+eQlpJrCYBb6f5H
         u+ODMT1686S6Q0bH7RXAR6YIPYJBQVJLK0yr5KOia7Djm2WYLOoPcz7LTgJXGtlHmb0B
         zTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060241; x=1744665041;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0AuvTirY7qrM/gCswfIrUXj0T0vw1kKdRIHGiOGwYc=;
        b=rjabF/f/1wHNDdbgmRaIXxO11AZRccGXij5qVmhTmy0r6t1GWLtRkKMXmzRb6xWdLc
         5lMo9GDHKPOSY11nUcBfn6kOot7NbkDsjQjIR/WEt+3mwIjP5kCRAwH6kZ3BuhDJE5TM
         M/At4NZ0gyMyhHYZCCsX7jwZdtyfUz0ep0PzCzcoh4EGQCNGPal06fcWPNnlaU4vQON4
         eDEydwxWwT1pjJu874wipYd6ltNHFpXwJcYAM/HnFdlDSWRgyl7bjrjF3tP1g9XNvpaL
         ++Ef5FtHbhaxJJ2ZPl4W4bzBJrUceE8Qg9tjSg0b7wkhTBBpQIbbYHDEwhXKpueU08rm
         t+zw==
X-Forwarded-Encrypted: i=1; AJvYcCWQJx7Un8NRp4A828TFQJAJdMN1iMwah5vSt3X6YbWWvt9egiPpOUU6abyZLeVU5Abj3UNtMZKeI/sFrBfcYS7h@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZiwRp+kCOPrzi5GA8oYdMutYKtkbSEWMRgC95wnhJw7vUEsH
	K8j7YWWoBNqjCmg5f0eXz33u9iMN+aOHUgJTIaWek0nhUinS2BZZ+1MTa7zBpiH59fpXjWeVrgh
	hQObvuQ==
X-Google-Smtp-Source: AGHT+IEtTIEPINOIddrhAnqXLHcRpH0YQH7WZU5gzCPFXyCuGjFEH5RfJxdh7z/ihaa8Hk3xhz5i+C7CL3ti
X-Received: from pjbsc7.prod.google.com ([2002:a17:90b:5107:b0:2fa:1481:81f5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2744:b0:2fe:e0a9:49d4
 with SMTP id 98e67ed59e1d1-306a60e4ab5mr18849904a91.2.1744060241459; Mon, 07
 Apr 2025 14:10:41 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:32 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-12-irogers@google.com>
Subject: [PATCH v3 11/16] perf intel-tpebs: Add mutex for tpebs_results
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

Ensure sample reader isn't racing with events being added/removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 51 ++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index f648fca17556..c5ccdbc42dc6 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -16,6 +16,7 @@
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "mutex.h"
 #include "session.h"
 #include "tool.h"
 #include "cpumap.h"
@@ -32,6 +33,7 @@ bool tpebs_recording;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
+static struct mutex tpebs_mtx;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -51,6 +53,19 @@ struct tpebs_retire_lat {
 
 static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel);
 
+static void tpebs_mtx_init(void)
+{
+	mutex_init(&tpebs_mtx);
+}
+
+static struct mutex *tpebs_mtx_get(void)
+{
+	static pthread_once_t tpebs_mtx_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&tpebs_mtx_once, tpebs_mtx_init);
+	return &tpebs_mtx;
+}
+
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
@@ -59,13 +74,15 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	char cpumap_buf[50];
 	struct tpebs_retire_lat *t;
 
+	mutex_lock(tpebs_mtx_get());
 	list_for_each_entry(t, &tpebs_results, nd)
 		tpebs_event_size++;
 
 	record_argv = malloc((10 + 2 * tpebs_event_size) * sizeof(*record_argv));
-	if (!record_argv)
+	if (!record_argv) {
+		mutex_unlock(tpebs_mtx_get());
 		return -ENOMEM;
-
+	}
 	record_argv[i++] = "perf";
 	record_argv[i++] = "record";
 	record_argv[i++] = "-W";
@@ -101,6 +118,7 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	list_for_each_entry(t, &tpebs_results, nd)
 		t->started = true;
 
+	mutex_unlock(tpebs_mtx_get());
 	return ret;
 }
 
@@ -112,9 +130,12 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 {
 	struct tpebs_retire_lat *t;
 
+	mutex_lock(tpebs_mtx_get());
 	t = tpebs_retire_lat__find(evsel);
-	if (!t)
+	if (!t) {
+		mutex_unlock(tpebs_mtx_get());
 		return -EINVAL;
+	}
 	/*
 	 * Need to handle per core results? We are assuming average retire
 	 * latency value will be used. Save the number of samples and the sum of
@@ -123,6 +144,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	t->count += 1;
 	t->sum += sample->retire_lat;
 	t->val = (double) t->sum / t->count;
+	mutex_unlock(tpebs_mtx_get());
 	return 0;
 }
 
@@ -229,7 +251,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 		return NULL;
 	}
 	result->evsel = evsel;
-	list_add_tail(&result->nd, &tpebs_results);
 	return result;
 }
 
@@ -282,16 +303,22 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
 static int evsel__tpebs_prepare(struct evsel *evsel)
 {
 	struct evsel *pos;
-	struct tpebs_retire_lat *tpebs_event = tpebs_retire_lat__find(evsel);
+	struct tpebs_retire_lat *tpebs_event;
 
+	mutex_lock(tpebs_mtx_get());
+	tpebs_event = tpebs_retire_lat__find(evsel);
 	if (tpebs_event) {
 		/* evsel, or an identically named one, was already prepared. */
+		mutex_unlock(tpebs_mtx_get());
 		return 0;
 	}
 	tpebs_event = tpebs_retire_lat__new(evsel);
 	if (!tpebs_event)
 		return -ENOMEM;
 
+	list_add_tail(&tpebs_event->nd, &tpebs_results);
+	mutex_unlock(tpebs_mtx_get());
+
 	/*
 	 * Eagerly prepare all other evsels on the list to try to ensure that by
 	 * open they are all known.
@@ -317,6 +344,7 @@ static int evsel__tpebs_prepare(struct evsel *evsel)
 int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret;
+	bool tpebs_empty;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
@@ -336,7 +364,10 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (ret)
 		return ret;
 
-	if (!list_empty(&tpebs_results)) {
+	mutex_lock(tpebs_mtx_get());
+	tpebs_empty = list_empty(&tpebs_results);
+	mutex_unlock(tpebs_mtx_get());
+	if (!tpebs_empty) {
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
@@ -436,8 +467,10 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	 */
 	tpebs_stop();
 
+	mutex_lock(tpebs_mtx_get());
 	t = tpebs_retire_lat__find(evsel);
 	val = rint(t->val);
+	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
 		count->val = old_count->val + val;
@@ -460,9 +493,13 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
  */
 void evsel__tpebs_close(struct evsel *evsel)
 {
-	struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
+	struct tpebs_retire_lat *t;
 
+	mutex_lock(tpebs_mtx_get());
+	t = tpebs_retire_lat__find(evsel);
+	list_del_init(&t->nd);
 	tpebs_retire_lat__delete(t);
+	mutex_unlock(tpebs_mtx_get());
 
 	if (list_empty(&tpebs_results))
 		tpebs_stop();
-- 
2.49.0.504.g3bcea36a83-goog

