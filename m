Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21031DED51
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179075; cv=none; b=fKuw0YgvjZ+dnMdowl/e0lJWZdk6db4EA7Tm4qm1+IxVd8EjwnJYen2ogfBNGu+cSiVuaWjhJpnJZd1KjBN4QUwC4VMavqeb43h/PD5oDH9yBLn0kmtCkWCsEqrcXlbOVXyhf0JdfGnjPb5OAY5rgmoRNLT2GQxJjvfFUqb6lGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179075; c=relaxed/simple;
	bh=ljmD0cTVkTPSjeRTew6uc5xLS1AYn1ipDaRrb9bphs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jxncmoNY8zBWVnEtdvM6jMFJBn7qOPIxI2N53aD/khMGmlhdh8qB3bVlKIuds5k0TduwpGVuIPq9c/ZHJe9Utn2urXPFakkC4utf70ApnYK9uHol714QyfRXMaUUl0KEoDs1Atnkz7zVF/gicNZaTs9UL0uawpnAyomG5anQMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XP96Vg/A; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XP96Vg/A"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so5924978a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179073; x=1744783873; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0AuvTirY7qrM/gCswfIrUXj0T0vw1kKdRIHGiOGwYc=;
        b=XP96Vg/AvWJq7YaRXIKd7wZe6B73DLqln6ATyxzuPba7RDYea4gpD/hq45VhpZ8zzN
         K91LyMENsvm+lXL0jy6So/VU7hZz64WleSLuQM1CfR9Q51G06mARVH0qC4816hwQuic+
         Y0KCSiMCIpPUNWBr1yl2PFZbDRGdNtP6HH3Un4SzOG49l4wZHoskkCW8gtqin3FkBwEy
         gk+x/KO7E3U6S702FE2/LD2+ed8bUIJZn7izL+rSxOwUYRJngykI+zWF2ohAg0ZO8cWc
         7adlLLTRvKSD6Gj9wuuUZefbb2Xi27izfJjcXUgLFe9V8gVv+rSZHNB+iOLtP7TAzKk3
         lgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179073; x=1744783873;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0AuvTirY7qrM/gCswfIrUXj0T0vw1kKdRIHGiOGwYc=;
        b=wTfRpgmXVkEf/IjTaydCW0PwYnUu6fGrlZo8iiLxPFkL+A46xzK1AlNrptaXWdaQva
         HRAPj2OiOCiHqKa8fuq+dnzPZie/G/37N8rPjrVVTgKLPtQvpXxCjl6DHizcvt2Z+L9m
         DaD040sDwMHosNtUnm1YiRMV/mRP/NhyvxHNqOwsEncBldZqP2GCKCp3tMOZaNGzfGei
         K3mQ9GtZ9K9qptxodoeBAjFILKj4gSh9JLxi+Ax0dRJaIjdVuV8eWCIl7lOOE3pwIlf1
         JmpC3TrpW1ru2ylrYMMNIKNYv6kCj9S5quMFoKcgkOSQX40a+/5v3jLVlMbqzT9u9KZO
         EKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgQ2BjteeHgBScfcXyC/+IL6KCekxR/IeOwUUJ1Bqfv6T5YrAtWe/zwQI7jaIocK7YO/wP2zk/pPpD1j1GyIt7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5IjCBFLc7ln06/6nn4hy51Xfk0sB9lfO6odZL6VUieWur7EM
	T2IKCFChLdALE1NXlP2aiZpR76yIdP9X6zCLLqBdS3w3h1/G5JwggX/0Ae1gEQcH6p5kNFAeadl
	HXyAEoA==
X-Google-Smtp-Source: AGHT+IE6E+kla50Tl/fT5vurmHugITe6quGzXucOvI6VehiiOztSsptMxDmcUi/HFuSBEyL4l9QcD6k50nj5
X-Received: from pjbsl16.prod.google.com ([2002:a17:90b:2e10:b0:2fe:800f:23a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270b:b0:301:1bce:c26f
 with SMTP id 98e67ed59e1d1-306dd324830mr1406134a91.3.1744179073095; Tue, 08
 Apr 2025 23:11:13 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:38 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-12-irogers@google.com>
Subject: [PATCH v4 11/16] perf intel-tpebs: Add mutex for tpebs_results
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

