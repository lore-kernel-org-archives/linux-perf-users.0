Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C9221F3C
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002075; cv=none; b=ijhEqgS8QQTWJmjmO6g8r1Snafn8Y6O+D0pX2t55bGf1cNdkWZm34ucqn0edx2W9neZylrUf45tM7/VCuKsbjEtPmY655zVGestnHhUuUdtMX4yvnTBHhVuEt2QW5dACleJuX5hZGAEVkUrl4m/0QWmvMR5J+bj59iG9B3Fpbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002075; c=relaxed/simple;
	bh=ifUhHpvB3YWjewd+FCiG+bnPL8N1hMQyEOj1ALhK2zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bJDcdTGCTLVgu/snFelOfRkyiHfaiMR9df53V19uU1C2yQxqx0xAFS7TJqwDrseyyGLX8EYdxn/U0Im3JgStnKG3c6Gi8UN3q4+7aKnolIRutaEi/EUCJELRXpD6MbjGQixc2R4X32BIsFknCkTXnvK7oxM7XTdky98VDaUdHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twQf/uXz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twQf/uXz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af9b25da540so2600569a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002073; x=1744606873; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kljzr7zwrGyBJiGR5feDDMzqEBYffKkoUZPkiCSQTN4=;
        b=twQf/uXzxXIf9QY9dl5uK5xQfd2qPgKQEhdQHWx6GqaEKh/DiXEwPSW0xBDDSjUesw
         kcwMz5uy1tIePEmcgAjn0J1kq1sdrtAjRJDS1+gwCTc0FDXxQ8CRwKgeFhtgK6ZTwMEl
         LMBq0GnttcEOOgzhLQgHVuQhfxTnS0I1mMsl+a0twno8jHAN7Gv96yyntIcq9muNcgEf
         /J+wWe6ycL1hsWU61NPMWC57Tftroz3/2vMofT1dg2fkQrAUcl1YL7EEAXEEKa5/WA/L
         Wo0aJ4xXpXCtr8OXGRKgt7N1q7U9bmD3Q+EjysXBD+tlifrI6fwDHAdRzY21ya7CFtKj
         BEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002073; x=1744606873;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kljzr7zwrGyBJiGR5feDDMzqEBYffKkoUZPkiCSQTN4=;
        b=LuZEsRDv22zmEeSi89539XYyomB16ClpgQPKi9BJZ3mNI08EtHY2jj0dhPPvOPL10c
         aDx46tvirKsGdOKJougzGnPsafrfM5vq2Cicy7j6FoOTkrCMdOLMO6/CqxoKlC3i4Owx
         lML1fqIbfafE69G/zxQHR/CzoU8v/vF+G81+FuN1wTBodojJVaSaJyioIysLZolY99kN
         94Rfac5/atAnbNXklSRH6/nA7zNxXNV253BXL9XNDhzHgDtZiIl26OWKGz7/TeFpkcmb
         8UHBRg+2Xqp0c4nwu+STTk2T3wEGZ+xrqbeiuqDXg0XhPZDaXCYfC+EZoiMouz/PUpGC
         CvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZAnzY09mZoX2FLpm/PHCUYrEf+HdDrII5QiX3JH0Mau/Y5Q3eQhBAY7K/UIQYa/xmuVj7zUxjjEhEmQ1E7a2U@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/unbMz5Fk4PDif5UI5eVQmU/NxkcBILKMi9yevfgqmI5ey6xw
	TDg2EioHVbJqhFw9qX2RYumlDTXABQ9kIC9z62pB7wGKNKAEcF2pgmRw96v8k/Dps7unzuT5si6
	QsW5iCA==
X-Google-Smtp-Source: AGHT+IGXOEpn+ENpgqWaSgghPpFJxN+0lXMimIDgaO3K2fwkBbHciFVHEAl+hivZM8eAmZAhQfPo2toYXBqQ
X-Received: from plbh6.prod.google.com ([2002:a17:902:eec6:b0:223:536f:9461])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64e:b0:21f:6546:9af0
 with SMTP id d9443c01a7336-22a8a0b38b2mr172584875ad.44.1744002072672; Sun, 06
 Apr 2025 22:01:12 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:47 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-3-irogers@google.com>
Subject: [PATCH v2 02/16] perf intel-tpebs: Simplify tpebs_cmd
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
index 3503da28a12f..74b43faab986 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -28,11 +28,10 @@
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
@@ -83,16 +82,6 @@ static int get_perf_record_args(const char **record_argv, char buf[],
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
@@ -110,10 +99,10 @@ static int start_perf_record(int control_fd[], int ack_fd[],
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
@@ -156,14 +145,13 @@ static int process_feature_event(struct perf_session *session,
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
 
@@ -189,12 +177,12 @@ static int tpebs_stop(void)
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
@@ -219,7 +207,7 @@ int tpebs_start(struct evlist *evsel_list)
 	 * We should only run tpebs_start when tpebs_recording is enabled.
 	 * And we should only run it once with all the required events.
 	 */
-	if (tpebs_pid != -1 || !tpebs_recording)
+	if (tpebs_cmd.pid != 0 || !tpebs_recording)
 		return 0;
 
 	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
@@ -284,10 +272,11 @@ int tpebs_start(struct evlist *evsel_list)
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
@@ -416,18 +405,10 @@ void tpebs_delete(void)
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
2.49.0.504.g3bcea36a83-goog

