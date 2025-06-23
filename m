Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6429C335
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695592; cv=none; b=LO/iRVzhdwbggEUunGAziNyhdhI6HQ1K6ytmyTtQ+LnMzEmq9c0N+zkLVf3sUV/L1DOLd6ZcD1tLSmwPxlMdhf0YSb1+PeM3gLSkxjwPiKyeQbgIfCwqPTRyZlq69bJlBomgS/8+hCV1FX76mNTJpomk/0n4or97xsfIXvFTWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695592; c=relaxed/simple;
	bh=PfwlW/jOgob5NqNxkjKR1RjlaciTJ4sjq2GU2b9U6RM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=DUtXKyMRlrDJcYEM5O5Mk7W2ZUoOaO2lABO8R43lxNhxtIRBq7QM/KiqQeXdNAUVSkJ7o6cS8JY6O/pSKnS6p0Y/EEZUcPJnbgYbO83+a5Z5Zk1l4ZLxDv1dPnKTViIM6ZBtfu0ydOZM7ydlyOSVGIvxs80iZ1rmAMGQWrBnqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdMAQPVO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdMAQPVO"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74858256d38so3517745b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750695590; x=1751300390; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/VHoFZJBt9mLW5xhSPpLIBgzLkwb7/Ik662r2IIQBgg=;
        b=bdMAQPVOai2cH8Lz69XWbu9aDcRoaQXIIGLjL5wMk+Mx3eTFXAP+k2O65ZF6+OaRJJ
         qIMnLmG4wit0WHyddt/Xge35MrJOUYJknGsWMOHZqvMWDjCJGectmVPN1sjq35ZowQDi
         w2BX1LGdFOmL6gIqzjH6zs0lj5RmW68CI7TvZFt+lhq0NctAwfCqXR4Nn9DWFbdPFIHv
         mxA0yj68NNoYr/+0o2edCQDQJNZXXoGhpwbvwt4ItarYGTU3gU5NeU6WFkGFIo7lMpYX
         +3KpYZ3s2LxEig4LqDlStLw42WWrc0ID7tdT7IUO4V2f2/REnmPN/CodG2rwK6PgeSKE
         zQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695590; x=1751300390;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VHoFZJBt9mLW5xhSPpLIBgzLkwb7/Ik662r2IIQBgg=;
        b=EkxM2BtzYWzGnpsmWvCJXOkv9RmK6P+Q8j81t2odNwYDOEElkjkR2dm5TYFqtKHoMP
         +z28rlNCrk8FQCUtKt+8k/uslItt4grWksAxSqGQCbobKHm9N4hqn+Uk1gkH+Vvylzvb
         l78oUa+ZnuEfVXi+1stWQW2Fm2+by5SkwJCSODc5leThdD/2XHeaA4vIVY5bXcchJhj3
         b8OyD2M+jpHk308m67lXj7EOIDvuMm+yuxSM9t6/iHFB5AjxyiFk22FBANnv9RTh0oDP
         OZi5JP/MyRFOwf/cV3gQyL1GhijVxqdjQY8Y5maEZDDWrfyUtgIzf+gQV+vdv26VW9hB
         3Aiw==
X-Forwarded-Encrypted: i=1; AJvYcCXEQtswn+1rawo7oisKf9/p6RgERqtLY8/fs7nTHG4svMEYY4b94lHD2u+md3pDcnmh/bA5XEHXrzQx2w7pwGiG@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFgRue2/8gnF38L34OsvPnybJ/h+jMwm5fUY0/srypGNCQYW+
	08LN4QbdGI+lS9U18HcYA/9YLpxOuEBkJwdv7ZTfC6OnS6SAws1l0r1ju8umMqwBeaf3TZ9bZjP
	BCBEETncrQQ==
X-Google-Smtp-Source: AGHT+IEchm4hD2aPIKKUQK7cRbeJHTcWSwWi6KRdm9P1Bnkm1z1d7Bi76ClsM8zMNT2jnTm52g/7jCB0nVYF
X-Received: from pgbcq2.prod.google.com ([2002:a05:6a02:4082:b0:b2d:aac5:e874])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7485:b0:21f:563e:b7e8
 with SMTP id adf61e73a8af0-22026e65dd7mr21255650637.4.1750695589873; Mon, 23
 Jun 2025 09:19:49 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:19:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250623161930.1421216-1-irogers@google.com>
Subject: [PATCH v4 1/2] perf debug: Add function symbols to dump_stack
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
$ perf test -vv PERF_RECORD_
...
  7: PERF_RECORD_* events & perf_sample fields:
  7: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
^C
Signal (2) while running tests.
Terminating tests with the same signal
Internal test harness failure. Completing any started tests:
:  7: PERF_RECORD_* events & perf_sample fields:

---- unexpected signal (2) ----
    #0 0x5628ad5570a3 in child_test_sig_handler builtin-test.c:0
    #1 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
    #2 0x7f561de99687 in __internal_syscall_cancel cancellation.c:64
    #3 0x7f561dee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
    #4 0x7f561def1393 in __nanosleep nanosleep.c:26
    #5 0x7f561df02d68 in __sleep sleep.c:55
    #6 0x5628ad5679ab in test__PERF_RECORD perf-record.c:0
    #7 0x5628ad556fb0 in run_test_child builtin-test.c:0
    #8 0x5628ad4f318d in start_command run-command.c:127
    #9 0x5628ad557ef3 in __cmd_test builtin-test.c:0
    #10 0x5628ad5585bf in cmd_test ??:0
    #11 0x5628ad4e5bb0 in run_builtin perf.c:0
    #12 0x5628ad4e5ecb in handle_internal_command perf.c:0
    #13 0x5628ad461383 in main ??:0
    #14 0x7f561de33ca8 in __libc_start_call_main libc_start_call_main.h:74
    #15 0x7f561de33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #16 0x5628ad4619d1 in _start ??:0

---- unexpected signal (2) ----
    #0 0x5628ad5570a3 in child_test_sig_handler builtin-test.c:0
    #1 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
    #2 0x7f561dea3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c:45
    #3 0x7f561de49fd9 in __GI___sigprocmask sigprocmask.c:26
    #4 0x7f561df2601b in __longjmp_chk longjmp.c:36
    #5 0x5628ad5570c0 in print_test_result.isra.0 builtin-test.c:0
    #6 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
    #7 0x7f561de99687 in __internal_syscall_cancel cancellation.c:64
    #8 0x7f561dee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
    #9 0x7f561def1393 in __nanosleep nanosleep.c:26
    #10 0x7f561df02d68 in __sleep sleep.c:55
    #11 0x5628ad5679ab in test__PERF_RECORD perf-record.c:0
    #12 0x5628ad556fb0 in run_test_child builtin-test.c:0
    #13 0x5628ad4f318d in start_command run-command.c:127
    #14 0x5628ad557ef3 in __cmd_test builtin-test.c:0
    #15 0x5628ad5585bf in cmd_test ??:0
    #16 0x5628ad4e5bb0 in run_builtin perf.c:0
    #17 0x5628ad4e5ecb in handle_internal_command perf.c:0
    #18 0x5628ad461383 in main ??:0
    #19 0x7f561de33ca8 in __libc_start_call_main libc_start_call_main.h:74
    #20 0x7f561de33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #21 0x5628ad4619d1 in _start ??:0
  7: PERF_RECORD_* events & perf_sample fields                       : Skip (permissions)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
v4: Additional addr_location__exit (Namhyung)
v3: Rebase
v2: Fix NO_BACKTRACE=1 build (Arnaldo)
---
 tools/perf/tests/builtin-test.c | 15 +++++++-
 tools/perf/ui/tui/setup.c       |  2 +-
 tools/perf/util/debug.c         | 66 +++++++++++++++++++++++++++------
 tools/perf/util/debug.h         |  1 +
 4 files changed, 71 insertions(+), 13 deletions(-)

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
index f9ef7d045c92..efc9d2c6448d 100644
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
@@ -298,21 +305,58 @@ void perf_debug_setup(void)
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
+		if (!thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
+			addr_location__exit(&al);
+			continue;
+		}
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
2.50.0.rc2.761.g2dc52ea45b-goog

