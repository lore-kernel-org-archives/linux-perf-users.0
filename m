Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638E2F0E42
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191887; cv=none; b=t0DmojivvQB+1D/sEuzGxeRJajmL+VnbUekz4ZQHMrQscagTMLEP9YlXe7hbkt0pANRx7B0QEPXheZ35Jqu6Xx20uEcgEijM82ca4kh2U+xs5C2Bhv+z1r0pnW7Q+zBSPkApiaxSxbrMA2fiYc6dMteVxgaMRwnmfjQ90IIXkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191887; c=relaxed/simple;
	bh=Le7QYk5ewKhVR0KfjzP7e5zYRhwCNT3h9zVSLbbTSyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hW7QZzNiX2uzxG7ckyNJChlrraYrWH4uomiqRbl7mX9o55RpFIy15dC65HBnsXactzfa7GYtNt1Jc2Ml1UHVs3TJwR4BBXdpZ1NJEvPUepqz5AwERw+yNZzhrNLn0Nz6jYU2v3oJnrMdbKdVd4JwMCP4/XjPpY47chCnM4nBNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHrblDTU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHrblDTU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so1093863a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191885; x=1752796685; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uF/yydA2LLHLkSIXR9wu8iMwdqKiKLaNFSdET/2T+tA=;
        b=BHrblDTUc/4n/NzoxQxl6lUvzSUo2UhUpuLfStbOxEvYtIiG6NCsgXmQJJUaMuY4vT
         LhOlHZFNaHtAzhN+dAsJEAXbQEHIpbOwsLltzKUddFjbkHWOHwvXXA0efptGJloBI5sN
         4JF7Lk6LHdGpPEuINab5jfNV/z1hAUOY0/nkM70Q0VT9geEGhAta9sRCazyv6wElT2o6
         VxKNV65Q7Dq3vk/fpyh/iC1A8bntMezB34XWPXK13bVbC6h295WeW/l/W+YUYJDnxwJD
         8a+znhiUuYXlyYzP//vS/kNTtJNeiHIr7hUWE2PDX61cP2byihtICVwP0XaN+w38vu/z
         +Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191885; x=1752796685;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uF/yydA2LLHLkSIXR9wu8iMwdqKiKLaNFSdET/2T+tA=;
        b=FPFhTmde/Un71VLtrX4gVNyPFYW5OmMgD/rTNuNzLKGM7/SzZDD3LK8KlL4YZM1CA1
         VlAFx2QecBVykH8lkP96liHBRzP2Tk03TOQaB5ZYEJmJAMwonDM+WxkEgQWdNA/wD9aG
         bYtd61sOElBER4FLYJnZYgKjZIJP0Uqa1DilJET01C5S3u2jwvN2/a+KcsEnEHXPPoaa
         I76KDrztGXVuiOjoqbPtzqyQFpm4IaQ++W4H3kCoSAsoZw3FfSnsdJilSkDmoE6ad74s
         aPm23OxUG3evBBhSWkBSaZO5KykzsQ4SIQHIcmR4CoveZHH2KL0XcQU3S87BYr7N+U0c
         qwSA==
X-Forwarded-Encrypted: i=1; AJvYcCWp0ooLwPJa62Ka9t9qQCORS0gVocsRz4DwMy3kAImNXJWMoabkVkmN/D6FZgfp51sdBwzZuO1Kxu8avSUQwEei@vger.kernel.org
X-Gm-Message-State: AOJu0YznaY54XePrILpnRmECq3wbCrD71jawtfnBhPvkVqDz4BlV8IT/
	dCdBIz01qNVyTo8HEBw3lJlsIya+KENUBCi65FzCpTPzDJEYJqQ3nxSSNzRzzlpWqsAiOZ7+DL+
	g0SzpkBjwLg==
X-Google-Smtp-Source: AGHT+IH29nX46juBnUV3CrYqY7h3suucckbiH2gL7CbLwOKrz/2zR6d9TWcvcm8MFpfJUpxHKQqyQHWO8hJu
X-Received: from pjbpb15.prod.google.com ([2002:a17:90b:3c0f:b0:30e:7783:edb6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3949:b0:311:c1ec:7cfb
 with SMTP id 98e67ed59e1d1-31c4f53f6demr667587a91.21.1752191884960; Thu, 10
 Jul 2025 16:58:04 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:26 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-6-irogers@google.com>
Subject: [PATCH v6 05/14] perf list: Remove tracepoint printing code
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
Content-Type: text/plain; charset="UTF-8"

Now that the tp_pmu can iterate and describe events remove the custom
tracepoint printing logic, this avoids perf list showing the
tracepoint events twice.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.50.0.727.gbf7dc18ff4-goog

