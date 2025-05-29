Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CB253956
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496217; cv=none; b=c04fI0JHCfM0EFOq5sCiFbH09u+9ZH9XwyxSNqYkV7oUzcZrgV3Va7yTMYquGAl7Cnx+l1MyPAvO4hDNd1Llh/I8CGqzHNHtZjb0F2kcFCiAJf3z729jyJAzLMGhlQS/TSTCUEpcZP9Og6tehxLpX11NtzW9v5/+8DRhXrGEGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496217; c=relaxed/simple;
	bh=0YK11AKqhjoRKYDxHvSIEJcOYyta3COzMYDd4Um1i7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=f5krxVNiabE2KCKJ91Ik/luIacRampnLiiwP4diVYjtnziu/ML50/zajU6VNWg5jeI/EkgUenWTI1Y3OSvtKYdqmMsiAeUwmJcD2X24E8H16WPgYt44TCvjjpnxi1Cyqgm01V/ANNiRGRIKWZQEqAAVJJPvOyG3YByGCiqZFiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5bDGRiA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5bDGRiA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311cc665661so473006a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748496215; x=1749101015; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0tZJWunWeOBIfa57iIk43kpKwVpCuyAkS2URVOmbEY=;
        b=n5bDGRiA3BBPOcsZdtRfb5DgDRuv5HIYgVY8wm3GmlGtErcltKe8koToDUzPzjkFtC
         z6VsjOftBqDcjPjejmnrEzUmiCnr5kJ8TF33pHpAmAfQkFEA605qPbwoZ7GQS61XitFQ
         hSYE+dU+uSS2eymhXCsgyZHxpcBs1dNYjTPf2ukeqxnuCs1a1z+WQGI09RLyLAM6u5iy
         zOEfKOs5227SrsOQXIcW/7vDN4CIpFNqF8E98ks3Bw70RhImJLDol3s7yBvwHMUai0HK
         MW2Tu1/VpYCzrbIO7ie/m5bdoCttAxAt9G7rH2JBg3vttB68f5kKHw5QlO7VRiGRiv9b
         NE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748496215; x=1749101015;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0tZJWunWeOBIfa57iIk43kpKwVpCuyAkS2URVOmbEY=;
        b=xG0wk2N7u5t+yYOd0VVn9h1yiOKEw1WhECyl3+RVszZYKbLO3lxtJ3pNxU+ksiupnQ
         v+fmsR/pdySKd4SrHEcbSfxcGeN7UTVE1LHamdNFU1S5Da7LgmG04JOCwVbJB1J5V2G6
         c27kPJc1er+ui0/PuLI5CIcO9P27CqVpDdSb1a0PvtAaqL+5WlpOygSlf8Ye6zcs3o8h
         bfiY2lfC7qLnZQp8kKu2VfYZloRfYn+tMUbqi2SbtC/F4hSERrJJIZdoME1yE/KRrv37
         /A0n4AxRe8cKCsufHToR4ijfd4EkV5pAHS4Q2Lpbc6BgRBTuem5aCMxsFfcMTFNesr/p
         a5nA==
X-Forwarded-Encrypted: i=1; AJvYcCWKsRTYG30k6yPibM6zoPccZRh+S2iIdkNVgDbrJlbPfNVaCyW9h1KsVuYVqQ5tG46G0VMir6BVpyZHHqpzbj00@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf94vueiKKHpjTBoHA3GxrAgCte8WhkbgYtA0/m3QdYDnkp3+v
	urCDba7MeUSsX2/lY9v5nqzBOJeADJSABmFa7Vgeyg6NqsZ1eHejtNWQ0WM/2PCt1ibt4ybLd9N
	d4D8wLjumKg==
X-Google-Smtp-Source: AGHT+IGTOXLMiSNzffXo3eesVNT7Gt1URo0B2f1tJZBy9jPPxv0O8tKXfajV4puFgEzIPfcTl/LVU2hcNQRo
X-Received: from pjur3.prod.google.com ([2002:a17:90a:d403:b0:311:b070:3683])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f8c:b0:311:ea13:2e6e
 with SMTP id 98e67ed59e1d1-311ea13318cmr7219271a91.28.1748496215517; Wed, 28
 May 2025 22:23:35 -0700 (PDT)
Date: Wed, 28 May 2025 22:23:22 -0700
In-Reply-To: <20250529052322.381947-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529052322.381947-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529052322.381947-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf debug: Add function symbols to dump_stack
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
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

____ unexpected signal (2) ____
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
v2: Fix NO_BACKTRACE=1 build (Arnaldo)
---
 tools/perf/tests/builtin-test.c | 15 +++++++-
 tools/perf/ui/tui/setup.c       |  2 +-
 tools/perf/util/debug.c         | 68 +++++++++++++++++++++++++++------
 tools/perf/util/debug.h         |  1 +
 4 files changed, 73 insertions(+), 13 deletions(-)

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
index f9ef7d045c92..0c7c6a9e158b 100644
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
@@ -298,21 +305,60 @@ void perf_debug_setup(void)
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
+#ifdef HAVE_BACKTRACE_SUPPORT
+	if (!machine || !thread) {
+		/*
+		 * Backtrace functions are async signal safe. Fall back on them
+		 * if machine/thread creation fails.
+		 */
+		backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
+		machine__delete(machine);
+		return;
+	}
+#endif
+
+	for (size_t i = 0; i < stackdump_size; i++) {
+		struct addr_location al;
+		u64 addr = (u64)stackdump[i];
+		bool printed = false;
+
+		addr_location__init(&al);
+		if (thread && thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
+			al.sym = map__find_symbol(al.map, al.addr);
+			if (al.sym) {
+				fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
+				printed = true;
+			}
+		}
+		if (!printed)
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
2.49.0.1204.g71687c7c1d-goog

