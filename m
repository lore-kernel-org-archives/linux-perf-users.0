Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889217E
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680127; cv=none; b=MrZGTErlsjSmJZ2Uxd5nmxn6NpkFr6d95N1YF+JmlYzllPVqP3Tj+O72qvEpiISyIbViEZ0vfg4w2GPstIuMc+vYOXlcAuLxYSnv5QdQ2UvuqJx9RgcKaHrIrT7yNRJtd6FsB3gfmhV6BEWFuLQ/QehZKrAsw8DxgCaQrQGUJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680127; c=relaxed/simple;
	bh=NDHUMEVtpT8BBqHlqxN8t5Rwk4C3RoH4vobOKCzjG+8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=r52SHJ1AKhKHiX5X2OUgM13csHvvfhfrjmFRXzxJ1SrtI/XFkA7J6DReNi0BIQCbv7oCiUPQC9nVSvI4o2zKXSFWKHU4RJpGZsKho8kRWnutQ6SAFSH2JDIq6e9cUmvWKdMrF2aCR67ElWSv41EgOPspoiwT/ldbCEINIAUyFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYvJ+5ry; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYvJ+5ry"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74880a02689so58229b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749680125; x=1750284925; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PK+kHs9R+YEyDeaq/iOtt1yi0JG1jfvYaQ+pZdNqmUc=;
        b=VYvJ+5ryzCpYE08JNQpsmyxhbf7ljA1voUxugK0zjEywI6vy1hbZpTvG1Qqh166lOt
         ErfA6Ww9s+2RJdqU5dNEAAgm2rUh04cKCSTjDyzrSWluwqLKz9XLW3M0iuxArYSolKyp
         wkN4Ym7PI/vMi+wc5i5fpHRpdvf8FREnZs4fGZx9prP/Yzd/C1r/SfbJs5kUVOifHdWX
         DMH33DQupFN4U8nY5wje0lzyTNmL4zsv0JkdOzPmxVkMFJS/Wk96qcFkcLZOtDmzMTyo
         c6KzOP6OVIapZmGdPxU9IWiZe+OvjfUxi8VUpeCALcXfaJEIY6cGhxOOFJNvUtLjFs2y
         7j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749680125; x=1750284925;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK+kHs9R+YEyDeaq/iOtt1yi0JG1jfvYaQ+pZdNqmUc=;
        b=s2kxxeM23z6Gt8EOzT8pnjUN2udgpILdQcvnHQTkuAtsEK/vAhUF2JcY0hck5+gUyI
         1KbQDdD/v1imiqg+E7/sXhc8gK1Zv1fWwwthaMlSMt6h11fDKFhvi/HgbRC3ADykMZkE
         5mo+9qo5OAOfGjXLVjuc2gLabETpu6QQm0j9U2G83uRsXenZB6soQ9E/nUP6re+Zp/UH
         lcKUOlEwwYtknIrUlNOSfBZHw5FetWSweWaglk+Sex+2T1A28hmvzcjUvKlE3dodQLMk
         u0bzrftb4cVntxqpKNCqzmmnGU8rNRUjMGNjpfbDham47yNRUg7xSVStxXZV8m7eLf6W
         Mclg==
X-Forwarded-Encrypted: i=1; AJvYcCVadSihBG15EtkbT5kEeNBJvHK0JaI5xRlfFymERPYtev9xNjYKBT+Ulnd8Jwk56JYlx5KHjNL1usrfeQTrwwFG@vger.kernel.org
X-Gm-Message-State: AOJu0YydRxNo0F94yKG5ibWviaBufW8k6QBju6un3AP4QlvxK4UVD3ry
	YOGWp6FMwMQMXbIM4rNnZSUqLb08DrhWA1fWsYXIOxENBrcFvg63F+Eer+/CIezjf+FDC5fqD/9
	hzifemL4IvA==
X-Google-Smtp-Source: AGHT+IE9tzEHAMiNyuTwW377rgcB9bsvzp1uKKQSjK3foDoLgEGlRVU8n4sUzGc8Ye3JTVjB6ogwLs0mckA0
X-Received: from pgh13.prod.google.com ([2002:a05:6a02:4e0d:b0:b2f:5aa2:87c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9186:b0:218:96ad:720d
 with SMTP id adf61e73a8af0-21f865bd1bamr8018774637.1.1749680124980; Wed, 11
 Jun 2025 15:15:24 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:15:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611221521.722045-1-irogers@google.com>
Subject: [PATCH v3] perf debug: Add function symbols to dump_stack
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Symbolize stack traces by creating a live machine. Add this
functionality to dump_stack and switch dump_stack users to use
it. Switch TUI to use it. Add stack traces to the child test function
which can be useful to diagnose blocked code.

Example output:
```
  8: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
^C
Signal (2) while running tests.
Terminating tests with the same signal
Internal test harness failure. Completing any started tests:
:  8: PERF_RECORD_* events & perf_sample fields:

---- unexpected signal (2) ----
    #0 0x5590fb6209b6 in child_test_sig_handler builtin-test.c:243
    #1 0x7f4a91e49e20 in __restore_rt libc_sigaction.c:0
    #2 0x7f4a91ee4f33 in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:71
    #3 0x7f4a91ef0333 in __nanosleep nanosleep.c:26
    #4 0x7f4a91f01f68 in __sleep sleep.c:55
    #5 0x5590fb638c63 in test__PERF_RECORD perf-record.c:295
    #6 0x5590fb620b43 in run_test_child builtin-test.c:269
    #7 0x5590fb5b83ab in start_command run-command.c:127
    #8 0x5590fb621572 in start_test builtin-test.c:467
    #9 0x5590fb621a47 in __cmd_test builtin-test.c:573
    #10 0x5590fb6225ea in cmd_test builtin-test.c:775
    #11 0x5590fb5a9099 in run_builtin perf.c:351
    #12 0x5590fb5a9340 in handle_internal_command perf.c:404
    #13 0x5590fb5a9499 in run_argv perf.c:451
    #14 0x5590fb5a97e2 in main perf.c:558
    #15 0x7f4a91e33d68 in __libc_start_call_main libc_start_call_main.h:74
    #16 0x7f4a91e33e25 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #17 0x5590fb4fd6d1 in _start perf[436d1]
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 15 +++++++-
 tools/perf/ui/tui/setup.c       |  2 +-
 tools/perf/util/debug.c         | 64 +++++++++++++++++++++++++++------
 tools/perf/util/debug.h         |  1 +
 4 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 45d3d8b3317a..80375ca39a37 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -6,6 +6,9 @@
  */
 #include <fcntl.h>
 #include <errno.h>
+#ifdef HAVE_BACKTRACE_SUPPORT
+#include <execinfo.h>
+#endif
 #include <poll.h>
 #include <unistd.h>
 #include <setjmp.h>
@@ -231,6 +234,16 @@ static jmp_buf run_test_jmp_buf;
 
 static void child_test_sig_handler(int sig)
 {
+#ifdef HAVE_BACKTRACE_SUPPORT
+	void *stackdump[32];
+	size_t stackdump_size;
+#endif
+
+	fprintf(stderr, "\n---- unexpected signal (%d) ----\n", sig);
+#ifdef HAVE_BACKTRACE_SUPPORT
+	stackdump_size = backtrace(stackdump, ARRAY_SIZE(stackdump));
+	__dump_stack(stderr, stackdump, stackdump_size);
+#endif
 	siglongjmp(run_test_jmp_buf, sig);
 }
 
@@ -244,7 +257,7 @@ static int run_test_child(struct child_process *process)
 
 	err = sigsetjmp(run_test_jmp_buf, 1);
 	if (err) {
-		fprintf(stderr, "\n---- unexpected signal (%d) ----\n", err);
+		/* Received signal. */
 		err = err > 0 ? -err : -1;
 		goto err_out;
 	}
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index 16c6eff4d241..022534eed68c 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -108,7 +108,7 @@ static void ui__signal_backtrace(int sig)
 
 	printf("-------- backtrace --------\n");
 	size = backtrace(stackdump, ARRAY_SIZE(stackdump));
-	backtrace_symbols_fd(stackdump, size, STDOUT_FILENO);
+	__dump_stack(stdout, stackdump, size);
 
 	exit(0);
 }
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index f9ef7d045c92..8987ac250079 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -14,11 +14,18 @@
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #endif
+#include "addr_location.h"
 #include "color.h"
-#include "event.h"
 #include "debug.h"
+#include "event.h"
+#include "machine.h"
+#include "map.h"
 #include "print_binary.h"
+#include "srcline.h"
+#include "symbol.h"
+#include "synthetic-events.h"
 #include "target.h"
+#include "thread.h"
 #include "trace-event.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
@@ -298,21 +305,56 @@ void perf_debug_setup(void)
 	libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_debug_wrapper);
 }
 
+void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
+{
+	/* TODO: async safety. printf, malloc, etc. aren't safe inside a signal handler. */
+	pid_t pid = getpid();
+	struct machine *machine = machine__new_live(/*kernel_maps=*/false, pid);
+	struct thread *thread = NULL;
+
+	if (machine)
+		thread = machine__find_thread(machine, pid, pid);
+
+	if (!machine || !thread) {
+		/*
+		 * Backtrace functions are async signal safe. Fall back on them
+		 * if machine/thread creation fails.
+		 */
+		backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
+		machine__delete(machine);
+		return;
+	}
+
+	for (size_t i = 0; i < stackdump_size; i++) {
+		struct addr_location al;
+		u64 addr = (u64)stackdump[i];
+
+		addr_location__init(&al);
+		if (!thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al))
+			continue;
+
+		al.sym = map__find_symbol(al.map, al.addr);
+		if (al.sym)
+			fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
+		else
+			fprintf(file, "    #%zd %p ", i, stackdump[i]);
+
+		map__fprintf_srcline(al.map, al.addr, "", file);
+		fprintf(file, "\n");
+		addr_location__exit(&al);
+	}
+	thread__put(thread);
+	machine__delete(machine);
+}
+
 /* Obtain a backtrace and print it to stdout. */
 #ifdef HAVE_BACKTRACE_SUPPORT
 void dump_stack(void)
 {
-	void *array[16];
-	size_t size = backtrace(array, ARRAY_SIZE(array));
-	char **strings = backtrace_symbols(array, size);
-	size_t i;
-
-	printf("Obtained %zd stack frames.\n", size);
-
-	for (i = 0; i < size; i++)
-		printf("%s\n", strings[i]);
+	void *stackdump[32];
+	size_t size = backtrace(stackdump, ARRAY_SIZE(stackdump));
 
-	free(strings);
+	__dump_stack(stdout, stackdump, size);
 }
 #else
 void dump_stack(void) {}
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index a4026d1fd6a3..6b737e195ce1 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -85,6 +85,7 @@ void debug_set_display_time(bool set);
 void perf_debug_setup(void);
 int perf_quiet_option(void);
 
+void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size);
 void dump_stack(void);
 void sighandler_dump_stack(int sig);
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog

