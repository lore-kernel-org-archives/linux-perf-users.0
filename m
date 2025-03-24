Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF91F4176
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855720; cv=none; b=dh4jHZqPqzdZmzN57flXxiys2nYQZIUk66jl2ZKtulo5Xmrc8OjtCMl9Q0UrOXFwIY/sHl8HvqcIZf4q8BTA36uFgPgqVwNNmFmCITvfFJ1CPOXwhdxM5xd4nbT/mtrYc+VwQH0fWk+iGqGzREHbzH8RVN0NICVujZ0/mr+MuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855720; c=relaxed/simple;
	bh=/LfS5vvH7BDvXT1ZxYvfdUx210V73ZgYJ/XIaS8om8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m0DHJHQs+Xox2VWT/6Audntf5M4pglCqKULiarVy0CVF1PJvgrg48jU2E5QcqqO38yTuji2TzGgFfv25j6p10VIKmrtY7oWYy+t3/HWs2UO1uOWyp2jOGSb9eSsHH2hoWAcBe0ShNM6ScT/D6gZ6fRCu7lx1BhUfmEaPFXG6oFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYj44wEF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYj44wEF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so128561455ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855716; x=1743460516; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Tug84NNGxWWUCgp7kdrw30UYr/sdQhmVez8IuJKNko=;
        b=eYj44wEFcu4iupMeY9byennsgUI3RZx/EtWhMyKRfs5FGlClpjcD/NEE5GlEDIXroO
         ISRRQybSpE99NFP3BZuYDZJfTe6pi6o3xp7Y6Z5Nisl+hUJ/WkH0sK58wTRFF+Tb8VaU
         zsG7U7nuXe4JTHtAh8vvdc6vcWqYHCqORas8toNa6edBxXz3ci+kQvPj8BXUtxsRykji
         f6c9ly5ZJ4DudGQQfAc/3ChBsS81yjwQUFV48RTA13vrql3MQYarKRR8+Z9Fd0G1DFG3
         2xqEG0jJl3hm/CiPlCJo8J46EtrdGRbHBjDP8f071QfCsgi75mO5pO/2/gQ5PHbm5NRh
         citg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855716; x=1743460516;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tug84NNGxWWUCgp7kdrw30UYr/sdQhmVez8IuJKNko=;
        b=V5Wu+yx3hKCOGFK4pfU6i1Wwipg6YHVPJElpPVGUYMk7vjxILbQHqxET/Qy421qRGt
         M17/BVgQDjaq5kaeXvd6AMHvfEEefmxmE2W0k1gV6B+UxEKMYnEgQn3M3COtiZTK0z/h
         LIoYdVDgOVbGp9l2gzsDa6dpNZdXQOe6gY3N+8kC3ZhXvjI9BzTFGTz3vAXLn1U9c7eR
         O6KZFqWlJ64CcYuz9ZcqpyEErE+qntHeXgQWaEylruh70IWJXB0SvJAnYGf6xuknFtl2
         ZBjvFxc0dxT6g1I+xEfJgLXSjDfK6yaanwsVHm53LnXDW/Lzp29cboIbsqg4Pl570p2s
         JMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTZCj2Nwf3bIlLB2XrkpG6Pcv1crbtd5BSpS6sMgLHKsCG1STgx5UarsgSXgCJ3ln+UnpyPSc5JoJX+79UQLQq@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuRh7wZgxezQq/vXxrecNDsfbLepoA+CuMK9V982NvDILkcJP
	mksQoBmLSyx81zrTSacuWv2btW4wsAnbvtM4DGuJhdVpP3/gcbKhwNZ3qbmA+woxpbAGwcpqIIy
	NunHnew==
X-Google-Smtp-Source: AGHT+IHPv+hUXkIYxiKXGAJ7LMWSFQLfSJP6JUWOGvhjOKn95LIYO7mLPmSdDgffDoI2oy24qzTYLpO1Fk96
X-Received: from pjk16.prod.google.com ([2002:a17:90b:5590:b0:2ea:29de:af10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c6:b0:215:7421:262
 with SMTP id d9443c01a7336-22780c78291mr242123945ad.12.1742855716519; Mon, 24
 Mar 2025 15:35:16 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:48 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-11-irogers@google.com>
Subject: [PATCH v1 10/14] perf intel-tpebs: Add mutex for tpebs_results
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
index 486218757872..05e1a0a296c5 100644
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
@@ -31,6 +32,7 @@ bool tpebs_recording;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
+static struct mutex tpebs_mtx;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -50,6 +52,19 @@ struct tpebs_retire_lat {
 
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
@@ -58,13 +73,15 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
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
@@ -100,6 +117,7 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	list_for_each_entry(t, &tpebs_results, nd)
 		t->started = true;
 
+	mutex_unlock(tpebs_mtx_get());
 	return ret;
 }
 
@@ -111,9 +129,12 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
@@ -122,6 +143,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	t->count += 1;
 	t->sum += sample->retire_lat;
 	t->val = (double) t->sum / t->count;
+	mutex_unlock(tpebs_mtx_get());
 	return 0;
 }
 
@@ -228,7 +250,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 		return NULL;
 	}
 	result->evsel = evsel;
-	list_add_tail(&result->nd, &tpebs_results);
 	return result;
 }
 
@@ -276,16 +297,22 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
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
@@ -311,6 +338,7 @@ static int evsel__tpebs_prepare(struct evsel *evsel)
 int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret;
+	bool tpebs_empty;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
@@ -330,7 +358,10 @@ int evsel__tpebs_open(struct evsel *evsel)
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
@@ -430,8 +461,10 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	 */
 	tpebs_stop();
 
+	mutex_lock(tpebs_mtx_get());
 	t = tpebs_retire_lat__find(evsel);
 	val = rint(t->val);
+	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
 		count->val = old_count->val + val;
@@ -454,9 +487,13 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
2.49.0.395.g12beb8f557-goog

