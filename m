Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6400202980
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050957; cv=none; b=UYQTFwUffSsWjtPa+5PWk/YITr9ThZtbmltnStCUW5q/6X1ZuARSDN5VExAGc+S/hmCCc1+7rCTgmxnCO8t+A+ugF5f0u4zQFkBCooomgwdhUOnM6IOwVgsn7wUDbotS4xzuCtOLIrkZCV526RRpLpHd3M8j1Nk0fQtrwaJalz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050957; c=relaxed/simple;
	bh=5g6NXNZKvaIDA4lgIQvx83+6XNu6ZjqforAQL/j1ROM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hPUT0TT0WrG65vQvcH39k7eBBim8jf7Dww5TS3B+c6fBWgkML3DnKK4ETkvdDI7uiKtPfuATlQK9UKtOFo2r48/VGglbECRe8fKMpFhl65h3KpWuOCKELJOqK9c9IVawkTKlKPSY1SercZ/dhrPYcXhFtIERgwcLb7RZDesUhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEMLnpWP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEMLnpWP"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740270e168aso3299302b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050955; x=1750655755; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VtBOHd4FHxz+dBPYGp95I2JdXXzZIX3WKfTkMyniMg=;
        b=EEMLnpWPdwOrUs1+rsa6ZEsYoKmp6pdP+Zap3iALL+Fc+6YhCsBSx4zyLVs8vQPFe8
         qvZjxTx6OkcJ3LihH5xiwj+o+B3a4NwIc0C8Kly9el2IIEU3UsM0zJ/GeAlkGZecGo7i
         F8nNH5AhNQdDIQGfgbu5MAx0blC2ly4bfuRwaWqrHybs65abIxg3+YL9JjpJlbdxuwjy
         WYnCnoXaxIiMMR0jbAbvAWlzWLgAVdX7a7kdG1+tTgPwciG5YEuGOgxfgv6VA7Xef5+7
         J+eB603T7MNU4txSs3HUiRVx28YHzPs6NvdcAR/Ca2tTp5nqdFL4+hxAbCEy7XKylzOg
         d1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050955; x=1750655755;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VtBOHd4FHxz+dBPYGp95I2JdXXzZIX3WKfTkMyniMg=;
        b=drCTYp7HusAMULYH7e0u4YSV+GzUncoYnvsELkBwku5FmfEkQjn+IQDNNX7BfARSPc
         66Q1gxn89XMLD7GjcHGopw2mAphRsZ1Nj2R+9yZNSf7O7HdXsFoP9lx3VMeizIAtZbwC
         7I32NtI81RKEChD8JInAXi0KkHUir5Wn4wUpCPQvmLXk4P11glOUw25/G5aw327FiABH
         cLbysylm5T2EUqPrOuyDbRCYfwcgXqeMWjBetqCVs0yu7n1JQI/N5uVkK0jNU5J8+R4M
         p/Gd50ypNg/JSMZASrimERZyU2kgv8S6L+PvEWdtXcT187Z/sih1sWO/keykrv3Ez9BG
         lkOw==
X-Forwarded-Encrypted: i=1; AJvYcCXqiCpxASVvi9nQsCOXFAGTUObgKGZ8CvdgOBkcJO1HeMs9/jGsCJMuEyToacayVS+tdVp5C5/CDfQjiwx7lj2V@vger.kernel.org
X-Gm-Message-State: AOJu0YyuaJR9m60ws3SO/4APOUuNAA/BN3ZFP5OzAHkgmz1f9jUtn1Y0
	7yW1pDLvf0LE6fYNzvsMYAHQuyYIskgFNc64Z64/2u2iQnLcfrXBeZJ9SKyPSDfeEn6JDpMSyVU
	ywGO97LZr7g==
X-Google-Smtp-Source: AGHT+IFLk65fyoJ7KOKDxz1UROvvFsVIsqxvU8icq1XV0ID2ECOpvVHpmEJH4MG6fmiJloKnmRSPFNck84U8
X-Received: from pge21.prod.google.com ([2002:a05:6a02:2d15:b0:b2f:a049:b765])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:330b:b0:21f:5674:3dd8
 with SMTP id adf61e73a8af0-21fbd63161cmr11001622637.26.1750050954791; Sun, 15
 Jun 2025 22:15:54 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:59 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-15-irogers@google.com>
Subject: [PATCH v3 14/15] perf list: Remove tracepoint printing code
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that the tp_pmu can iterate and describe events remove the custom
tracepoint printing logic, this avoids perf list showing the
tracepoint events twice.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 28 +++++++---
 tools/perf/util/print-events.c | 93 ----------------------------------
 tools/perf/util/print-events.h |  1 -
 3 files changed, 22 insertions(+), 100 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 674bb0afbf93..3216be404f27 100644
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
@@ -665,13 +675,20 @@ int cmd_list(int argc, const char **argv)
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
@@ -682,7 +699,6 @@ int cmd_list(int argc, const char **argv)
 					event_symbols_hw, PERF_COUNT_HW_MAX);
 			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			print_tracepoint_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
 			default_ps.metricgroups = true;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 362e93fc33d2..8e629409f45e 100644
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
@@ -418,8 +327,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			/*long_desc=*/NULL,
 			/*encoding_desc=*/NULL);
 
-	print_tracepoint_events(print_cb, print_state);
-
 	print_sdt_events(print_cb, print_state);
 
 	metricgroup__print(print_cb, print_state);
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 8f19c2bea64a..02511ed6ecad 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -37,7 +37,6 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max);
-void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
 #endif /* __PERF_PRINT_EVENTS_H */
-- 
2.50.0.rc2.696.g1fc2a0284f-goog

