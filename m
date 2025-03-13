Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D981FA851
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843801; cv=none; b=mhMB7VMH2/3od7umWaE1UVhhLcaaOuhozXLgK9SF9WAa6GSrCt9im4l0FAARtmowKvnzWpbS+J57TsAyshOk0xlsNIF0AtE1mBO3p9XbvN6UJ7GFULzttRL3pJWFMSSOwR6hgAu2HSr0fGgLhGZB1guFR+sAdr6Uua2r9GA7qQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843801; c=relaxed/simple;
	bh=I+AitRafweBNjLK+ItMt1YQTcH9oIsWQ0Y4C9TRgoxc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kOcESex8MKHK3dIvq3eqoaUGW7QnU9dCBZX8AArKTuc1HF46UfSnwj7JZo/g4e05dotv5wwfLr/CjJbegu4OC9nOL5qp4Uopm2uL2qhc5dsfzJD7ZocbfX6ciQ4+//+ohKMIENMYP0p55ZNNfdM/b2YSDCPuBuW7q9BKiUIfl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZxxh6Zc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZxxh6Zc"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240a96112fso18060295ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 22:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741843799; x=1742448599; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhuCtOZ0Nw0QyjR0+NS8fO75xwUE+0obsDVVi6fim1o=;
        b=QZxxh6Zc1Ma7J1Usxb43KIrBQXzLcxIDOZgIPRh63DRru7WVnC5cZmxD0NdVnYo+ZN
         m7Jj4C9XaoQN7wvh6h4Z0lSKA0JsAAeDHBaea3Q4Jplq2I1UrcahUc+k9jtLGsk1S5fn
         1OkEEPDNmQj7bH1i/MRk7sIPkCTe8YWaBwkTL3hzOaVhXUv+67G6zeeaQiaQltT1pwXO
         3dpfJSLdb4W4QByDKEvf/3xGa+bgxhyJlZq6CmKr1sUhwJAn4eEh/9SrUbE/xTxhy7QN
         dj3eyEDfjtiAWRxlOJsR+wZzEwuidqWE+N+1Ssg7juU1PdCnea61aN/yZvovGH0ga3FQ
         /DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741843799; x=1742448599;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhuCtOZ0Nw0QyjR0+NS8fO75xwUE+0obsDVVi6fim1o=;
        b=ATLgRzosq8961mKy553cyL0dBVgWmZnEA+M6fxj+tXo/qhQ0vTzyXBhAOtF1NecCgX
         NjLRemGQ/OPRenSdqPMoQ8LNvJi2ZCfCrr5kEzXvrkFjWrL1kYJw6ONQQEACjb9n5I/x
         +I+eMW26xoxV1AIoNKeZ0N/UERxapbpv7T8xDiKtmtQKsE7HefLIJDDEpMUW6JIgruDv
         m04csDleHt47vfCH8wD/cQ3yJqNxHwxRSOWXwrYxvxh3HoIEnyvMu3UG00HY6JhnFtWh
         hJYRTLYksx3nn7ZQs/9E8HuRSozjUEuZXWgX+/Xnw+OQ5gUhHXdXNV4sSj6E63rdg5qP
         GkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwqU71qKd9BliZDw/MzOXkjZiybKJAc1kQwKLAacSL51CvEVhNxj1wI3pZ+3yLVwhyAT2nlaEOY4ngBp9X7AG5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54RUcoF2lMUJdoKUKt+ys0zzmwiIbJr8lWL/DKCQ/lOhPBMoY
	cDBk/nF2jVulGdosSmVxrs1HeNwuMrupIXoZ8ioyfRMAx8IHtcvzxiUDS4P7e7/tYDsiFXSE11X
	uWS3rmA==
X-Google-Smtp-Source: AGHT+IEA4yYXIJttaSID3iAibVCdp2nLabuEtam5BZ2XvBfQ8zrE7bzNl+BBpwH8uXhyZoUDyvWbtJdbTLTO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de85:e25e:4e36:1ea5])
 (user=irogers job=sendgmr) by 2002:a63:5d1b:0:b0:af5:3653:f036 with SMTP id
 41be03b00d2f7-af53653f07cmr10510a12.3.1741843798600; Wed, 12 Mar 2025
 22:29:58 -0700 (PDT)
Date: Wed, 12 Mar 2025 22:29:52 -0700
In-Reply-To: <20250313052952.871958-1-irogers@google.com>
Message-Id: <20250313052952.871958-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313052952.871958-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v1 2/2] perf debug: Add function symbols to dump_stack
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Anne Macedo <retpolanne@posteo.net>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index 14d30a5053be..358bccc75d40 100644
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
@@ -230,6 +233,16 @@ static jmp_buf run_test_jmp_buf;
 
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
 
@@ -243,7 +256,7 @@ static int run_test_child(struct child_process *process)
 
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
2.49.0.rc0.332.g42c0ae87b1-goog

