Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FC3ADBA2;
	Mon, 31 Aug 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158382; cv=none; b=cjFoTfgthb3mxZEALTB8vNZJTlkuY3SWNP1O5pS9KVY7l6sPVZcfJY73pinVGqX08EKNOgl42JtXYnGF9gzjgoJuLlDjFgOycO+O5h8wYb7OHV9AGS+NgrYKAc9PqeooyuUtRoMROT96hZweYQG1cSQUBv8evP3XtrbJcmmGVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158382; c=relaxed/simple;
	bh=KgtvohubLZrKx4Fc2Q6bbWwfXQtViOhlgrcX6f1HEoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcUIUPwc5IDVNkK3JauO8sN8flV7qKzz7Y1f3JpN/lXz9N0cnL9ZU1R8hNWnFcdSriqFIa84xZJflGaq/tfiVWUBQBVLeYMiF5FUoSLShJ2lsN/bylyRnosp3NSZD/ZdjRufC5uL/nnJoK7x+3U4fteTlICTsapo8QpyipgEPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjTTjrg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjTTjrg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959A81F000E9;
	Mon, 31 Aug 2026 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788158381;
	bh=dxCMIo0808LUrMDDNnYd/e+0ivNlTaHKCRjwh/R5qRI=;
	h=From:To:Cc:Subject:Date;
	b=jjTTjrg+RYyqGU21JtWs647avWVMaMgiUCXBHUSTatgXUwqdKI4rRaZMvnewJKP2D
	 BwKxEUDltLBRYe8ELb/MBzsy+WHX03KhmKSmkpwN/NqTsyBUF2WNGteIA+9K4xXqDn
	 /+OlNCh6nsA8PgQbOkYtPYfa0lL3B75FIJv5D1kcrSqMxNhyz2XC2+xRbSEZmmdx61
	 6lNQw+I8miaiIo9ANGCduJiNQ/Peqsky9PVUoA+AXg43CHF4EFMKpfvKEMEqH3mDwg
	 lJXuhmsoThit44KzLFZAp/9hepj1wzOeXA3WKI6qNNnE3FhCjAAKg8vgIypUrFVwD6
	 i8KsjagUCTaGw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2] perf ftrace latency: Do not read trace files when BPF is used
Date: Sun, 30 Aug 2026 23:39:38 -0700
Message-ID: <20260831063938.756610-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've realized that it didn't set up the tracing files when BPF is used
so poll() just returns immediately.  It ends up with calling poll()
unnecessarily in a loop.

BPF still needs the loop to wait for the target process exiting or a
signal from users.  Let's use a semaphore instead.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4f881a40c311ae52..6017493ff179758b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -6,23 +6,23 @@
  * Copyright (c) 2020  Changbin Du <changbin.du@gmail.com>, significant enhancement.
  */
 
-#include "builtin.h"
-
+#include <ctype.h>
 #include <errno.h>
-#include <unistd.h>
-#include <signal.h>
-#include <stdlib.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <math.h>
 #include <poll.h>
-#include <ctype.h>
+#include <semaphore.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
 #include <linux/capability.h>
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <sys/stat.h>
 
+#include "builtin.h"
 #include "debug.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -45,6 +45,7 @@
 
 static volatile sig_atomic_t workload_exec_errno;
 static volatile sig_atomic_t done;
+static sem_t sig_sem;
 
 static struct stats latency_stats;  /* for tracepoints */
 
@@ -53,6 +54,7 @@ static char tracing_instance[PATH_MAX];	/* Trace instance directory */
 static void sig_handler(int sig __maybe_unused)
 {
 	done = true;
+	sem_post(&sig_sem);
 }
 
 /*
@@ -68,6 +70,7 @@ static void ftrace__workload_exec_failed_signal(int signo __maybe_unused,
 {
 	workload_exec_errno = info->si_value.sival_int;
 	done = true;
+	sem_post(&sig_sem);
 }
 
 static bool check_ftrace_capable(void)
@@ -1146,6 +1149,11 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 
 	line[0] = '\0';
 	while (!done) {
+		if (ftrace->target.use_bpf) {
+			sem_wait(&sig_sem);
+			break;
+		}
+
 		if (poll(&pollfd, 1, -1) < 0)
 			break;
 
@@ -1852,6 +1860,8 @@ int cmd_ftrace(int argc, const char **argv)
 	INIT_LIST_HEAD(&ftrace.nograph_funcs);
 	INIT_LIST_HEAD(&ftrace.event_pair);
 
+	sem_init(&sig_sem, 0, 0);
+
 	signal(SIGINT, sig_handler);
 	signal(SIGUSR1, sig_handler);
 	signal(SIGCHLD, sig_handler);
@@ -2015,5 +2025,11 @@ int cmd_ftrace(int argc, const char **argv)
 	delete_filter_func(&ftrace.nograph_funcs);
 	delete_filter_func(&ftrace.event_pair);
 
+	signal(SIGINT, SIG_DFL);
+	signal(SIGUSR1, SIG_DFL);
+	signal(SIGCHLD, SIG_DFL);
+	signal(SIGPIPE, SIG_DFL);
+
+	sem_destroy(&sig_sem);
 	return ret;
 }
-- 
2.55.0.897.gb25b4bd76c-goog

