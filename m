Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A4259C94
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469545; cv=none; b=Te3dBe1WYt+EM5Dnngcp2TcpgOVgKl9HUL0zf/GPfn+oxRvrN+WZ58tODd012wfcRTgoURJ4oeXUr29pR5s2vNa1kPQSRU07wdnkEoquNCAB5yfVUFnEf6t8AI3Ip0GeASk2EX4+zww5cBwuwXhF7EFNNIpSaQ06tx7RV/JN1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469545; c=relaxed/simple;
	bh=ppHlmYUuAHv5DYS9QXKLT4UzrfJvaJA2xgfk+czayuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ghj6Sy6fRTLq6rpiB2NfGrr26FDeDIdbBXiFinUY3Zpicd80wydMDpnaTd710ynjB6/52IZL3Wk7uO+N8Q3PzRRKf/RKv/5O8EH0+LJzZNEr0XYH3laeo+cAtRY0nC+H1N9F0wm6TgDuCwiady2pnszHWn0217HbjaHlJaRsnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pw0GqT70; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pw0GqT70"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234a102faa3so22047755ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469543; x=1754074343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sA4i8xTnlF3/CS6H5DH4dmVmv5iGDQy59prS9DyuVBA=;
        b=pw0GqT70A2PF0RKFSY/2LVPyWsnECzRW15SEiv4hMIa3lF8Eko0a7sh/jL27LG7x/a
         RK4wXn06wm4i79YuTkIxL2vqKD/6BBoKSsUoIhy95HgDHR2/mxGCT7hS6dvnByRbFu4x
         xygNum52K6eTuKpgiGoL677zFJTqGsvoENrsHau7TG9OxaZN3XJlHsYw6wBQ61Tp0qxo
         fMW8RJQ4yjfwLR5mCYhcK5Ld6jtvvjnUwVhNChPj74Rb6za+3vYdGOdvJeJ9ENVJz2xK
         Fy7vNOyf0MY6kMtAslV9l8Eh+b7x0Ws9SYomp6qdJDwm/rNvqCBrJtBr2G7qjdIuuNc5
         QMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469543; x=1754074343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA4i8xTnlF3/CS6H5DH4dmVmv5iGDQy59prS9DyuVBA=;
        b=FJm87X3FgNJDU1HmR0oimY9jmGOdqw+zP0G8zqr4wXFgdWH2sw1R5gN8GSs/vfu+te
         /5ifJG443uO1LyyKTxnDu7vvDXlQXpniFDKuwQj1V8FnoykL8sH2MEkT+LJRxUysD8Yu
         BvIVNqdZm4iYMFbCv9TM5qNGDnhpChBvShvIzG+pimXhOgS2vwp4JwTL+RvxLw6rGOzV
         QPSRiVWYKXjQsdkEhfcwosjwgIkpXLq2IC48DSOj0pBDlqwNB8hw4YKLG24R27A2D8+V
         T4mgs2fw/2Pqfdgo7plD5SIvKs7qbmFij7cq41ufx4Z/971DvTKFSCInU6yJWdJv3fkY
         VYLw==
X-Forwarded-Encrypted: i=1; AJvYcCWT6lxNmdS1OHgUdzBc44c3ExaKVzxAR0pT3ELX87kTT5OER6tqjYs/PkOWLJjSmCb0Ze0qHgTXEI4RKeGMJIPt@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgXol1PRCuY/IoRJt5rdvaZCAKpvIKt+LDNrOt88MoAxCB1LG
	ukatBiUJdSUPGOiuLCPGEkwacZ/klOU1/1QRJqi96gpF55ts7hzC3PVZo2jKuwJ0r8NBtRLoP/f
	o6xfulN7XpQ==
X-Google-Smtp-Source: AGHT+IGxhjvl84CTxgxdyhbo7AiTP5Ij1s6m1VkfrUtHM05lXZm2mLtVuYJ1Uk6vIYaIOoYroNcmyvoytsRe
X-Received: from pllt10.prod.google.com ([2002:a17:902:dcca:b0:234:952b:35a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:198d:b0:235:eb8d:7fff
 with SMTP id d9443c01a7336-23fb30be09fmr42077855ad.28.1753469543350; Fri, 25
 Jul 2025 11:52:23 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:52 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-7-irogers@google.com>
Subject: [PATCH v9 06/16] perf list: Remove tracepoint printing code
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that the tp_pmu can iterate and describe events remove the custom
tracepoint printing logic, this avoids perf list showing the
tracepoint events twice.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c      | 29 ++++++++---
 tools/perf/util/print-events.c | 93 ----------------------------------
 tools/perf/util/print-events.h |  2 -
 3 files changed, 23 insertions(+), 101 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 674bb0afbf93..3a4061d02f6c 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -614,9 +614,18 @@ int cmd_list(int argc, const char **argv)
 	for (i = 0; i < argc; ++i) {
 		char *sep, *s;
 
-		if (strcmp(argv[i], "tracepoint") == 0)
-			print_tracepoint_events(&print_cb, ps);
-		else if (strcmp(argv[i], "hw") == 0 ||
+		if (strcmp(argv[i], "tracepoint") == 0) {
+			char *old_pmu_glob = default_ps.pmu_glob;
+
+			default_ps.pmu_glob = strdup("tracepoint");
+			if (!default_ps.pmu_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.pmu_glob);
+			default_ps.pmu_glob = old_pmu_glob;
+		} else if (strcmp(argv[i], "hw") == 0 ||
 			 strcmp(argv[i], "hardware") == 0)
 			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
@@ -658,6 +667,7 @@ int cmd_list(int argc, const char **argv)
 #endif
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			char *old_pmu_glob = default_ps.pmu_glob;
+			char *old_event_glob = default_ps.event_glob;
 
 			default_ps.event_glob = strdup(argv[i]);
 			if (!default_ps.event_glob) {
@@ -665,13 +675,21 @@ int cmd_list(int argc, const char **argv)
 				goto out;
 			}
 
-			print_tracepoint_events(&print_cb, ps);
+			default_ps.pmu_glob = strdup("tracepoint");
+			if (!default_ps.pmu_glob) {
+				zfree(&default_ps.event_glob);
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.pmu_glob);
+			default_ps.pmu_glob = old_pmu_glob;
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
 			default_ps.metricgroups = true;
 			metricgroup__print(&print_cb, ps);
 			zfree(&default_ps.event_glob);
-			default_ps.pmu_glob = old_pmu_glob;
+			default_ps.event_glob = old_event_glob;
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
 				printf("Critical: Not enough memory! Trying to continue...\n");
@@ -682,7 +700,6 @@ int cmd_list(int argc, const char **argv)
 					event_symbols_hw, PERF_COUNT_HW_MAX);
 			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			print_tracepoint_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
 			default_ps.metricgroups = true;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index c1a8708b55ab..3a5e5e7bae13 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -44,97 +44,6 @@ static const char * const event_type_descriptors[] = {
 	"Hardware breakpoint",
 };
 
-/*
- * Print the events from <debugfs_mount_point>/tracing/events
- */
-void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unused, void *print_state __maybe_unused)
-{
-	char *events_path = get_tracing_file("events");
-	int events_fd = open(events_path, O_PATH);
-	struct dirent **sys_namelist = NULL;
-	int sys_items;
-
-	if (events_fd < 0) {
-		pr_err("Error: failed to open tracing events directory\n");
-		pr_err("%s: %s\n", events_path, strerror(errno));
-		return;
-	}
-	put_tracing_file(events_path);
-
-	sys_items = tracing_events__scandir_alphasort(&sys_namelist);
-
-	for (int i = 0; i < sys_items; i++) {
-		struct dirent *sys_dirent = sys_namelist[i];
-		struct dirent **evt_namelist = NULL;
-		int dir_fd;
-		int evt_items;
-
-		if (sys_dirent->d_type != DT_DIR ||
-		    !strcmp(sys_dirent->d_name, ".") ||
-		    !strcmp(sys_dirent->d_name, ".."))
-			goto next_sys;
-
-		dir_fd = openat(events_fd, sys_dirent->d_name, O_PATH);
-		if (dir_fd < 0)
-			goto next_sys;
-
-		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
-		for (int j = 0; j < evt_items; j++) {
-			/*
-			 * Buffer sized at twice the max filename length + 1
-			 * separator + 1 \0 terminator.
-			 */
-			char buf[NAME_MAX * 2 + 2];
-			/* 16 possible hex digits and 22 other characters and \0. */
-			char encoding[16 + 22];
-			struct dirent *evt_dirent = evt_namelist[j];
-			struct io id;
-			__u64 config;
-
-			if (evt_dirent->d_type != DT_DIR ||
-			    !strcmp(evt_dirent->d_name, ".") ||
-			    !strcmp(evt_dirent->d_name, ".."))
-				goto next_evt;
-
-			snprintf(buf, sizeof(buf), "%s/id", evt_dirent->d_name);
-			io__init(&id, openat(dir_fd, buf, O_RDONLY), buf, sizeof(buf));
-
-			if (id.fd < 0)
-				goto next_evt;
-
-			if (io__get_dec(&id, &config) < 0) {
-				close(id.fd);
-				goto next_evt;
-			}
-			close(id.fd);
-
-			snprintf(buf, sizeof(buf), "%s:%s",
-				 sys_dirent->d_name, evt_dirent->d_name);
-			snprintf(encoding, sizeof(encoding), "tracepoint/config=0x%llx/", config);
-			print_cb->print_event(print_state,
-					/*topic=*/NULL,
-					/*pmu_name=*/NULL, /* really "tracepoint" */
-					/*event_name=*/buf,
-					/*event_alias=*/NULL,
-					/*scale_unit=*/NULL,
-					/*deprecated=*/false,
-					"Tracepoint event",
-					/*desc=*/NULL,
-					/*long_desc=*/NULL,
-					encoding);
-next_evt:
-			free(evt_namelist[j]);
-		}
-		close(dir_fd);
-		free(evt_namelist);
-next_sys:
-		free(sys_namelist[i]);
-	}
-
-	free(sys_namelist);
-	close(events_fd);
-}
-
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct strlist *bidlist, *sdtlist;
@@ -552,8 +461,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			/*long_desc=*/NULL,
 			/*encoding_desc=*/NULL);
 
-	print_tracepoint_events(print_cb, print_state);
-
 	print_sdt_events(print_cb, print_state);
 
 	metricgroup__print(print_cb, print_state);
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 48682e2d166d..4d95b8257e23 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -37,8 +37,6 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max);
-
-void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
-- 
2.50.1.552.g942d659e1b-goog

