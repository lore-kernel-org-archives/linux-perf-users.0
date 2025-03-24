Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6091EE7C4
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855701; cv=none; b=uvAKHKHyDS7jrn/V6uMlp7NvAX5iMQz37LWo4E53WvgziXLdoNs3sothi7xZ6qVyzlRLYePV6gUhxrmVisWRINxSt9OOOZqCXFnUYfmm/K6qePGxe9KH/eJU8PqYJlfX2kSc+7la/zqLCV87l6N6qCZjl4Nxn6WQrH8gyPYEiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855701; c=relaxed/simple;
	bh=yBzhhPVypfmeolNblUD88KPAtlHzfIA0bxATlPMR4zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rA3syQVw7J82xPlaO1wkP1frs3ivGnNlVXmrmG2w0iI7S6ZYo+4RbhZLZQfOq26wiKkW+DkqskqhWdr0fM3jVHDcRw5Pe2R2iUUc7YPLPMBKakkWnJdxrkiFnA3kKs3WHUNx9m42XHu+JSNzN9PhAWlOHZ4Y7wVPtHa96wtX6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykaDy1Vh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykaDy1Vh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225ab228a37so72661015ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855699; x=1743460499; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElJ2vHXmu+8BFmjOSMBFYzJE6czzTLhTmjrbpJ1kYko=;
        b=ykaDy1VhbUZN5jwCY3X0ew5+6grU3HbZLlGeD7jID8qiN646gdjR9vb5gX++P2OUuI
         iNdIik32nOmpS5b3XCiiZGzKS71NcxZT5RNcgtvpJqPwaxTdeg075h9+B7clN9EKRxa4
         WwCJriKxdI8zcgJAN2CVPrbnKnXPgfx+S1kr0bEQvnQJNhXx8qRsXcen+bXUvLJ8Tmds
         taQP8XS0gClI4fuo+9IF3BRp95R1tzjliFU8ZZl9CrMTMSiXNovB4wLqCcGZI8BIXakV
         pyerDqVeahoVwtaW06iZxyxuuamsDVz+JD4BhWn974s+EXTT3PkIAepwOgtsT6rPzJiF
         dgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855699; x=1743460499;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElJ2vHXmu+8BFmjOSMBFYzJE6czzTLhTmjrbpJ1kYko=;
        b=u0gD1dxdyQ9hbddl8S4KmuwC3nEBUmGOQOe6FPcAUjIDh6hilfqXl67L+P5WihqxT9
         zP4kdzrwHm/IN66UPdnhuU1trkBIJWb3FxKq2mZT2w8LnoL3Yewkzp9HEQwx+szP+jIn
         g5CUKtOEQ6+5ko/letFcG0U5RgIIOz1/WmODUQ1DY/LZUeu+1RqWV//nt8xHSDWc79y5
         0HxqyYOutmsj9bcn8aO3cLdpo/mYKuU3Lfsygcf9yNA45pqO0sP0S5FDVTGmjb6H5A4d
         UZEM7iU4gP9GOm6WciObNbRjSu6260MCy0rz78JNKdoOHjq0dYCm5mozFAIc5hDib9QV
         PAGg==
X-Forwarded-Encrypted: i=1; AJvYcCXNuS+OcqrxRpE+zF9Lx5swO/dhZoJsSE6BJxwNN2p5mTHEyWF1An7GKqd57oouy7aSeMxFCRlPRDgi0Wduxvc0@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSpO5a26zpHaI0r1Q+5zpDd/W2EcGsKFk9+QdGvZHF/rafb+F
	iSTI7ZE0qEQzVT5II1d5HE8bP4ILmyD4LQ9w7RxJcIaGaxAgJuS5r/1K7V4+ZpQVTNn797otR2b
	bLxo4qg==
X-Google-Smtp-Source: AGHT+IEnNH3RKdFoCflDCnsGBhUKHdODz4nzYGEOJhKeyuWPq9Up7F1CddDsmGctnCkl6aL4xQ9/GS6elFAD
X-Received: from pfun23.prod.google.com ([2002:a05:6a00:7d7:b0:736:a134:94ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230e:b0:223:5645:8e26
 with SMTP id d9443c01a7336-22780d7fb17mr179400475ad.20.1742855698710; Mon, 24
 Mar 2025 15:34:58 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:39 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-2-irogers@google.com>
Subject: [PATCH v1 01/14] perf intel-tpebs: Simplify tpebs_cmd
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

No need to dynamically allocate when there is 1. tpebs_pid duplicates
tpebs_cmd.pid, so remove. Use 0 as the uninitialized value (PID == 0
is reserved for the kernel) rather than -1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 55 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2c421b475b3b..fb28aa211a63 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -27,11 +27,10 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static pid_t tpebs_pid = -1;
 static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
-static struct child_process *tpebs_cmd;
+static struct child_process tpebs_cmd;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -82,16 +81,6 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 	return 0;
 }
 
-static int prepare_run_command(const char **argv)
-{
-	tpebs_cmd = zalloc(sizeof(struct child_process));
-	if (!tpebs_cmd)
-		return -ENOMEM;
-	tpebs_cmd->argv = argv;
-	tpebs_cmd->out = -1;
-	return 0;
-}
-
 static int start_perf_record(int control_fd[], int ack_fd[],
 				const char *cpumap_buf)
 {
@@ -109,10 +98,10 @@ static int start_perf_record(int control_fd[], int ack_fd[],
 	if (ret)
 		goto out;
 
-	ret = prepare_run_command(record_argv);
-	if (ret)
-		goto out;
-	ret = start_command(tpebs_cmd);
+	assert(tpebs_cmd.pid == 0);
+	tpebs_cmd.argv = record_argv;
+	tpebs_cmd.out = -1;
+	ret = start_command(&tpebs_cmd);
 out:
 	free(record_argv);
 	return ret;
@@ -155,14 +144,13 @@ static int process_feature_event(struct perf_session *session,
 	return 0;
 }
 
-static void *__sample_reader(void *arg)
+static void *__sample_reader(void *arg __maybe_unused)
 {
-	struct child_process *child = arg;
 	struct perf_session *session;
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = PERF_DATA,
-		.file.fd = child->out,
+		.file.fd = tpebs_cmd.out,
 	};
 	struct perf_tool tool;
 
@@ -188,12 +176,12 @@ static int tpebs_stop(void)
 	int ret = 0;
 
 	/* Like tpebs_start, we should only run tpebs_end once. */
-	if (tpebs_pid != -1) {
-		kill(tpebs_cmd->pid, SIGTERM);
-		tpebs_pid = -1;
+	if (tpebs_cmd.pid != 0) {
+		kill(tpebs_cmd.pid, SIGTERM);
 		pthread_join(tpebs_reader_thread, NULL);
-		close(tpebs_cmd->out);
-		ret = finish_command(tpebs_cmd);
+		close(tpebs_cmd.out);
+		ret = finish_command(&tpebs_cmd);
+		tpebs_cmd.pid = 0;
 		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
 			ret = 0;
 	}
@@ -218,7 +206,7 @@ int tpebs_start(struct evlist *evsel_list)
 	 * We should only run tpebs_start when tpebs_recording is enabled.
 	 * And we should only run it once with all the required events.
 	 */
-	if (tpebs_pid != -1 || !tpebs_recording)
+	if (tpebs_cmd.pid != 0 || !tpebs_recording)
 		return 0;
 
 	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
@@ -283,10 +271,11 @@ int tpebs_start(struct evlist *evsel_list)
 		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
 		if (ret)
 			goto out;
-		tpebs_pid = tpebs_cmd->pid;
-		if (pthread_create(&tpebs_reader_thread, NULL, __sample_reader, tpebs_cmd)) {
-			kill(tpebs_cmd->pid, SIGTERM);
-			close(tpebs_cmd->out);
+
+		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
+				   /*arg=*/NULL)) {
+			kill(tpebs_cmd.pid, SIGTERM);
+			close(tpebs_cmd.out);
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
@@ -415,18 +404,10 @@ void tpebs_delete(void)
 {
 	struct tpebs_retire_lat *r, *rtmp;
 
-	if (tpebs_pid == -1)
-		return;
-
 	tpebs_stop();
 
 	list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
 		list_del_init(&r->nd);
 		tpebs_retire_lat__delete(r);
 	}
-
-	if (tpebs_cmd) {
-		free(tpebs_cmd);
-		tpebs_cmd = NULL;
-	}
 }
-- 
2.49.0.395.g12beb8f557-goog

