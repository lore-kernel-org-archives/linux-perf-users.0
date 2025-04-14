Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AB29114E
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652539; cv=none; b=MNIlnhBN8mjCJlx0Xq36uQfx3cmpvg4F6MQ0SluVyGxB5wsmshRqfEsAGYzIBxkwqlzqkjPI0kX/ntIu2CODDUkTqYxFLH/rfpwC7+ju9DiTaZtfTmlH80dKTec9Uqv98Pkr4h55nbUa9eUPfLchoBUdvWG1PQCVzeUyJbfN9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652539; c=relaxed/simple;
	bh=WKPQcboFiB+hGHxUYzO4w2ckiNZXOOLFUP7lGFlNwWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NZnB3GYzcnFpsqKZhRm7sIN5fUOCLkwpYHJUWfm0DdrEV13yYZyAjz563IJt3E3puWuqj/km9m6uDx5d6eZChfDk9DHoFUgeUZ4FklSld3qiJRxOm4LyImkqy5HsdjA76uWLu7psC+iji53R1e14a30PAq5gSjr6/yTX7rc91lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cveDsJxu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cveDsJxu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-227ed471999so39953945ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652537; x=1745257337; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYPEm9NL3VZPHY9E6/DgquYd8q3uRuheFZCN9+58cmE=;
        b=cveDsJxutt5Esx7vRc6ahsFtupQ1pLbf28taPIyCCU4ywMW2bO1h1eaEPFd+4rPxSo
         Wx7Nlie1VOATzUGTgf9jyrg+kU4h5F46P3UWq8uehPPr4hAI2Sm7QwLpUrfqo3D4Ao0V
         ygn4sU/5MOJTBnXdVascGSmMX/D1O2WrR8tyz7XyLmBxUK2wHoLFIn67zsV+D5Zu1gYW
         pwhaG9nzLv24Mq/Hc7VlJ0er6pgFyx1LLcAtFcYhUM/RNFEWHJQwTKMc+S7vhAPUuzwb
         azdO4/LMFf7978cnUyRzhni07H8GUMh57Pu//icpHe/nGtpE+uPbNmztGMNuWjaR4If1
         kFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652537; x=1745257337;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYPEm9NL3VZPHY9E6/DgquYd8q3uRuheFZCN9+58cmE=;
        b=SSUKDpMZZIbX/+sCz+zZseBPv9z+Si+Arpy7I/coWbHsoPcpiU6bHdkwtHaMpNf+aC
         Qmr4RUDWctpSDOcEqHKaZzKgjermGwY0EiXEyLIjxTpuGk+eQVADfKTveaqA8EiKU6lr
         Jn4syMT5jT+qKFtKOhFCBGTv5GTece1lrSKa2PYwRHRuXTwWAP++LMCcj9yDwlfyPjmh
         1L2aSErNxIy01yy0Iw+aqlvKzqsruOUntXGvrmjNIrLRMp4wLv8f+8fnKTHYpOzemFOq
         WNACY7xYEJirN1fyJkVYcINw6ddGIp8ITWVN4rCIRVyVT/XLEWNCwqqiGfmE8yKPMmHf
         Gzpw==
X-Forwarded-Encrypted: i=1; AJvYcCWS5thokuQTGy+/eFJr69hIZ5yQNtkZhFLvbGcauBv0TyCSZZroQ1fAZMrB9719Q7gLeIqbAJWCjYBwBlOZHN/D@vger.kernel.org
X-Gm-Message-State: AOJu0YybNcRCv8v0pfuZnFeOevjJMInq7NKraox3ajVD7zRv2ASIB6Nt
	xn8q7KQk/5/DFIMavg01ej6xVGG+y3qZOg+k+GzdD0lY+KWRcv7AnVeUnhW9ANlpNsoWW/mukZy
	XGakmQQ==
X-Google-Smtp-Source: AGHT+IGyKIuM07n7cmrhe91nvxQ1s4pZVlktHt4FzYtDlOdKGZpHGdcVIsvx1wZO0pb66Pi24JVdJeZGgAqF
X-Received: from plly18.prod.google.com ([2002:a17:902:7c92:b0:223:5c97:5c3c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c7:b0:223:4537:65b1
 with SMTP id d9443c01a7336-22bea4efec4mr187177005ad.36.1744652537178; Mon, 14
 Apr 2025 10:42:17 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:29 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-12-irogers@google.com>
Subject: [PATCH v5 11/16] perf intel-tpebs: Add mutex for tpebs_results
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

Ensure sample reader isn't racing with events being added/removed.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/intel-tpebs.c | 54 +++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index f648fca17556..aa6bcdf2bf6c 100644
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
 
@@ -282,15 +303,22 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
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
-	if (!tpebs_event)
+	if (!tpebs_event) {
+		mutex_unlock(tpebs_mtx_get());
 		return -ENOMEM;
+	}
+	list_add_tail(&tpebs_event->nd, &tpebs_results);
+	mutex_unlock(tpebs_mtx_get());
 
 	/*
 	 * Eagerly prepare all other evsels on the list to try to ensure that by
@@ -317,6 +345,7 @@ static int evsel__tpebs_prepare(struct evsel *evsel)
 int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret;
+	bool tpebs_empty;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
@@ -336,7 +365,10 @@ int evsel__tpebs_open(struct evsel *evsel)
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
@@ -436,8 +468,10 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	 */
 	tpebs_stop();
 
+	mutex_lock(tpebs_mtx_get());
 	t = tpebs_retire_lat__find(evsel);
 	val = rint(t->val);
+	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
 		count->val = old_count->val + val;
@@ -460,9 +494,13 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
2.49.0.604.gff1f9ca942-goog

