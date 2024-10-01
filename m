Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34651CC88F
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803201; cv=none; b=dCACxR5nhbBFia+10g8/tIv6TSj6Y55RPBG7x7UmWDxyN5mmSaDIp81YVqD2DUqOwFkSK44/yJQ6SEcdR1RZpJEVhnR+WvECLfeSSi+UfBr9sUSELDHanjCKora24+2XFV7lLP1ASwRoZ0Cqpdgm+WT2opFNaGwTVi9WV34/aG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803201; c=relaxed/simple;
	bh=U5GZCI2mMtbcfS+fCk063olLvizfCuvFlsop2gs63i4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OCrOpo1+j+pcQnC5y1R0USl0GzTbs40rY+ktMthoKoaL8fBsGemF7y/KYfDTXLVPM1tDy5MMb6EZCGP4KhgIp/LwBR7f+4YCwlQ0Drj+a2GaMskGXnU2XvF7lJx0fiPtAzEI1Vg3r/yOlh+H4fjCGq/sDeHMzXVrTy7POt4s/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DmTSdqAI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DmTSdqAI"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso10501624276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727803199; x=1728407999; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zeh2kJP86MimfYD9ikkIGzulOg4azE1B18tS5LSfp94=;
        b=DmTSdqAIZQsK7Fg9swHXfs0qvRulLbZD7/Pf+SurO8QIhgk64/LOocxLl5ABSEP+ie
         RWutjKyypyj3l+lD8OisCZHpDypPjZ0ZGdGbLrc0g3W5PEKaWg4jRb3/0zkMJRs6gYLk
         HMMn98etVK/011nfOR2w5i7oX7rqXMELncMQkm8kbWe0V1usUxHL3lZLNyQ8Ej+eXunF
         d4k8AjSZLLhyUb9fziO+Dp9UC8FAiBENFGmBzVVZRaKNGjta03MBpmcw5q2wo6v1z7lf
         L5maqHhnT+84aCjiQk6IQbV7tposOIelLmY6i3qoXRHqudWzAlkB+b7csUhB65yAt0UX
         8CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803199; x=1728407999;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zeh2kJP86MimfYD9ikkIGzulOg4azE1B18tS5LSfp94=;
        b=tvWTTDHWynnJPMkbb+1zS5DNfeb6XHzkLMfAJhZuq6nisC1mEya+EayNh4sZGBDKHe
         7BWeMJ7x7xchFE4PclJCMUFnghdXD49zbXSnxTLzBLSodWncVDxWM3oui5oyjjox3phM
         fi7UHLaW7zez7Hgad5Eij6m74NazudFd9vb67h5d4XHGBBXJ058zcMMtusjqX7Viwcqj
         Z9iaQyh13O3V2J229x7s6rVai5swXatDteLYwPob1z1IB3BT32O5M+N8iWEdJBVwiAGj
         dc3A1/b3v1MgNHY9kk9XlpuxdQIM2YaM+UgPP+o9JvN8V2FeFw2yfojwqYJ49F02Gql1
         IYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUHt+AsweXFdTEbz9F7D5SEmoklAdo5+MKKRP5JcPnxJcC5yjLwmiICzLkgMGvF6keJCPmCgl95GS8qcyoZi8WC@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/BbN8eX+JzN9fo6v/ggAc4QIkzhxcnSMwWazYSX6b4UAb0Vw
	7CrblOwf4D23qzT706KBD7EJB72Ys2+lr0YXSayo5KMd2BfsCyq7sTNzQg7S7EWh5t0YgGJ9fmU
	UKBqYxw==
X-Google-Smtp-Source: AGHT+IGZGyUW9yJtgWZ/CKA9OPY006KwA37vNXhvo979JnxrX8mcWAWKj6gKrZ6B6UPQRV/7dZ5t+nm/PWKw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a25:fc06:0:b0:e11:5a3c:26c7 with SMTP id
 3f1490d57ef6-e263843deabmr459276.9.1727803198869; Tue, 01 Oct 2024 10:19:58
 -0700 (PDT)
Date: Tue,  1 Oct 2024 10:19:49 -0700
In-Reply-To: <20241001171950.233723-1-irogers@google.com>
Message-Id: <20241001171950.233723-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001171950.233723-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v1 2/3] perf test: Remove C test wrapper for attr.py
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove the C wrapper now a shell script wrapper exists. Move
perf_event_attr dumping functions to evsel.c and reduce the scope of
variables/defines. Use fprintf to avoid snprintf complexities in
WRITE_ASS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf.c               |   2 -
 tools/perf/tests/Build          |   1 -
 tools/perf/tests/attr.c         | 218 --------------------------------
 tools/perf/tests/builtin-test.c |   1 -
 tools/perf/tests/tests.h        |   1 -
 tools/perf/util/evsel.c         | 122 +++++++++++++++++-
 tools/perf/util/util.h          |   7 -
 7 files changed, 118 insertions(+), 234 deletions(-)
 delete mode 100644 tools/perf/tests/attr.c

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 4def800f4089..a2987f2cfe1a 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -542,8 +542,6 @@ int main(int argc, const char **argv)
 	}
 	cmd = argv[0];
 
-	test_attr__init();
-
 	/*
 	 * We use PATH to find perf commands, but we prepend some higher
 	 * precedence paths: the "--exec-path" option, the PERF_EXEC_PATH
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5671ee530019..5476199adc67 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -4,7 +4,6 @@ perf-test-y += builtin-test.o
 perf-test-y += tests-scripts.o
 perf-test-y += parse-events.o
 perf-test-y += dso-data.o
-perf-test-y += attr.o
 perf-test-y += vmlinux-kallsyms.o
 perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall.o
 perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-all-cpus.o
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
deleted file mode 100644
index 97e1bdd6ec0e..000000000000
--- a/tools/perf/tests/attr.c
+++ /dev/null
@@ -1,218 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * The struct perf_event_attr test support.
- *
- * This test is embedded inside into perf directly and is governed
- * by the PERF_TEST_ATTR environment variable and hook inside
- * sys_perf_event_open function.
- *
- * The general idea is to store 'struct perf_event_attr' details for
- * each event created within single perf command. Each event details
- * are stored into separate text file. Once perf command is finished
- * these files can be checked for values we expect for command.
- *
- * Besides 'struct perf_event_attr' values we also store 'fd' and
- * 'group_fd' values to allow checking for groups created.
- *
- * This all is triggered by setting PERF_TEST_ATTR environment variable.
- * It must contain name of existing directory with access and write
- * permissions. All the event text files are stored there.
- */
-
-#include <debug.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <subcmd/exec-cmd.h>
-#include "event.h"
-#include "util.h"
-#include "tests.h"
-#include "pmus.h"
-
-#define ENV "PERF_TEST_ATTR"
-
-static char *dir;
-static bool ready;
-
-void test_attr__init(void)
-{
-	dir = getenv(ENV);
-	test_attr__enabled = (dir != NULL);
-}
-
-#define BUFSIZE 1024
-
-#define __WRITE_ASS(str, fmt, data)					\
-do {									\
-	char buf[BUFSIZE];						\
-	size_t size;							\
-									\
-	size = snprintf(buf, BUFSIZE, #str "=%"fmt "\n", data);		\
-	if (1 != fwrite(buf, size, 1, file)) {				\
-		perror("test attr - failed to write event file");	\
-		fclose(file);						\
-		return -1;						\
-	}								\
-									\
-} while (0)
-
-#define WRITE_ASS(field, fmt) __WRITE_ASS(field, fmt, attr->field)
-
-static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
-		       int fd, int group_fd, unsigned long flags)
-{
-	FILE *file;
-	char path[PATH_MAX];
-
-	if (!ready)
-		return 0;
-
-	snprintf(path, PATH_MAX, "%s/event-%d-%llu-%d", dir,
-		 attr->type, attr->config, fd);
-
-	file = fopen(path, "w+");
-	if (!file) {
-		perror("test attr - failed to open event file");
-		return -1;
-	}
-
-	if (fprintf(file, "[event-%d-%llu-%d]\n",
-		    attr->type, attr->config, fd) < 0) {
-		perror("test attr - failed to write event file");
-		fclose(file);
-		return -1;
-	}
-
-	/* syscall arguments */
-	__WRITE_ASS(fd,       "d", fd);
-	__WRITE_ASS(group_fd, "d", group_fd);
-	__WRITE_ASS(cpu,      "d", cpu.cpu);
-	__WRITE_ASS(pid,      "d", pid);
-	__WRITE_ASS(flags,   "lu", flags);
-
-	/* struct perf_event_attr */
-	WRITE_ASS(type,   PRIu32);
-	WRITE_ASS(size,   PRIu32);
-	WRITE_ASS(config,  "llu");
-	WRITE_ASS(sample_period, "llu");
-	WRITE_ASS(sample_type,   "llu");
-	WRITE_ASS(read_format,   "llu");
-	WRITE_ASS(disabled,       "d");
-	WRITE_ASS(inherit,        "d");
-	WRITE_ASS(pinned,         "d");
-	WRITE_ASS(exclusive,      "d");
-	WRITE_ASS(exclude_user,   "d");
-	WRITE_ASS(exclude_kernel, "d");
-	WRITE_ASS(exclude_hv,     "d");
-	WRITE_ASS(exclude_idle,   "d");
-	WRITE_ASS(mmap,           "d");
-	WRITE_ASS(comm,           "d");
-	WRITE_ASS(freq,           "d");
-	WRITE_ASS(inherit_stat,   "d");
-	WRITE_ASS(enable_on_exec, "d");
-	WRITE_ASS(task,           "d");
-	WRITE_ASS(watermark,      "d");
-	WRITE_ASS(precise_ip,     "d");
-	WRITE_ASS(mmap_data,      "d");
-	WRITE_ASS(sample_id_all,  "d");
-	WRITE_ASS(exclude_host,   "d");
-	WRITE_ASS(exclude_guest,  "d");
-	WRITE_ASS(exclude_callchain_kernel, "d");
-	WRITE_ASS(exclude_callchain_user, "d");
-	WRITE_ASS(mmap2,	  "d");
-	WRITE_ASS(comm_exec,	  "d");
-	WRITE_ASS(context_switch, "d");
-	WRITE_ASS(write_backward, "d");
-	WRITE_ASS(namespaces,	  "d");
-	WRITE_ASS(use_clockid,    "d");
-	WRITE_ASS(wakeup_events, PRIu32);
-	WRITE_ASS(bp_type, PRIu32);
-	WRITE_ASS(config1, "llu");
-	WRITE_ASS(config2, "llu");
-	WRITE_ASS(branch_sample_type, "llu");
-	WRITE_ASS(sample_regs_user,   "llu");
-	WRITE_ASS(sample_stack_user,  PRIu32);
-
-	fclose(file);
-	return 0;
-}
-
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
-		     int fd, int group_fd, unsigned long flags)
-{
-	int errno_saved = errno;
-
-	if ((fd != -1) && store_event(attr, pid, cpu, fd, group_fd, flags)) {
-		pr_err("test attr FAILED");
-		exit(128);
-	}
-
-	errno = errno_saved;
-}
-
-void test_attr__ready(void)
-{
-	if (unlikely(test_attr__enabled) && !ready)
-		ready = true;
-}
-
-static int run_dir(const char *d, const char *perf)
-{
-	char v[] = "-vvvvv";
-	int vcnt = min(verbose, (int) sizeof(v) - 1);
-	char cmd[3*PATH_MAX];
-
-	if (verbose > 0)
-		vcnt++;
-
-	scnprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
-		  d, d, perf, vcnt, v);
-
-	return system(cmd) ? TEST_FAIL : TEST_OK;
-}
-
-static int test__attr(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	struct stat st;
-	char path_perf[PATH_MAX];
-	char path_dir[PATH_MAX];
-	char *exec_path;
-
-	if (perf_pmus__num_core_pmus() > 1) {
-		/*
-		 * TODO: Attribute tests hard code the PMU type. If there are >1
-		 * core PMU then each PMU will have a different type which
-		 * requires additional support.
-		 */
-		pr_debug("Skip test on hybrid systems");
-		return TEST_SKIP;
-	}
-
-	/* First try development tree tests. */
-	if (!lstat("./tests", &st))
-		return run_dir("./tests", "./perf");
-
-	exec_path = get_argv_exec_path();
-	if (exec_path == NULL)
-		return -1;
-
-	/* Then installed path. */
-	snprintf(path_dir,  PATH_MAX, "%s/tests", exec_path);
-	snprintf(path_perf, PATH_MAX, "%s/perf", BINDIR);
-	free(exec_path);
-
-	if (!lstat(path_dir, &st) &&
-	    !lstat(path_perf, &st))
-		return run_dir(path_dir, path_perf);
-
-	return TEST_SKIP;
-}
-
-DEFINE_SUITE("Setup struct perf_event_attr", attr);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427d..4f8b4e3260b4 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -79,7 +79,6 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_evsel__tp_sched_test,
 	&suite__syscall_openat_tp_fields,
 #endif
-	&suite__attr,
 	&suite__hists_link,
 	&suite__python_use,
 	&suite__bp_signal,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 6ea2be86b7bf..b246db5abf83 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -83,7 +83,6 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
-DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
 DECLARE_SUITE(dso_data_cache);
 DECLARE_SUITE(dso_data_reopen);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index edfb376f0611..0a5c9cd6b30f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -103,7 +103,123 @@ static int evsel__no_extra_init(struct evsel *evsel __maybe_unused)
 	return 0;
 }
 
-void __weak test_attr__ready(void) { }
+static bool test_attr__enabled(void)
+{
+	static bool test_attr__enabled;
+	static bool test_attr__enabled_tested;
+
+	if (!test_attr__enabled_tested) {
+		char *dir = getenv("PERF_TEST_ATTR");
+
+		test_attr__enabled = (dir != NULL);
+		test_attr__enabled_tested = true;
+	}
+	return test_attr__enabled;
+}
+
+#define __WRITE_ASS(str, fmt, data)					\
+do {									\
+	if (fprintf(file, #str "=%"fmt "\n", data) < 0) {		\
+		perror("test attr - failed to write event file");	\
+		fclose(file);						\
+		return -1;						\
+	}								\
+} while (0)
+
+#define WRITE_ASS(field, fmt) __WRITE_ASS(field, fmt, attr->field)
+
+static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
+		       int fd, int group_fd, unsigned long flags)
+{
+	FILE *file;
+	char path[PATH_MAX];
+	char *dir = getenv("PERF_TEST_ATTR");
+
+	snprintf(path, PATH_MAX, "%s/event-%d-%llu-%d", dir,
+		 attr->type, attr->config, fd);
+
+	file = fopen(path, "w+");
+	if (!file) {
+		perror("test attr - failed to open event file");
+		return -1;
+	}
+
+	if (fprintf(file, "[event-%d-%llu-%d]\n",
+		    attr->type, attr->config, fd) < 0) {
+		perror("test attr - failed to write event file");
+		fclose(file);
+		return -1;
+	}
+
+	/* syscall arguments */
+	__WRITE_ASS(fd,       "d", fd);
+	__WRITE_ASS(group_fd, "d", group_fd);
+	__WRITE_ASS(cpu,      "d", cpu.cpu);
+	__WRITE_ASS(pid,      "d", pid);
+	__WRITE_ASS(flags,   "lu", flags);
+
+	/* struct perf_event_attr */
+	WRITE_ASS(type,   PRIu32);
+	WRITE_ASS(size,   PRIu32);
+	WRITE_ASS(config,  "llu");
+	WRITE_ASS(sample_period, "llu");
+	WRITE_ASS(sample_type,   "llu");
+	WRITE_ASS(read_format,   "llu");
+	WRITE_ASS(disabled,       "d");
+	WRITE_ASS(inherit,        "d");
+	WRITE_ASS(pinned,         "d");
+	WRITE_ASS(exclusive,      "d");
+	WRITE_ASS(exclude_user,   "d");
+	WRITE_ASS(exclude_kernel, "d");
+	WRITE_ASS(exclude_hv,     "d");
+	WRITE_ASS(exclude_idle,   "d");
+	WRITE_ASS(mmap,           "d");
+	WRITE_ASS(comm,           "d");
+	WRITE_ASS(freq,           "d");
+	WRITE_ASS(inherit_stat,   "d");
+	WRITE_ASS(enable_on_exec, "d");
+	WRITE_ASS(task,           "d");
+	WRITE_ASS(watermark,      "d");
+	WRITE_ASS(precise_ip,     "d");
+	WRITE_ASS(mmap_data,      "d");
+	WRITE_ASS(sample_id_all,  "d");
+	WRITE_ASS(exclude_host,   "d");
+	WRITE_ASS(exclude_guest,  "d");
+	WRITE_ASS(exclude_callchain_kernel, "d");
+	WRITE_ASS(exclude_callchain_user, "d");
+	WRITE_ASS(mmap2,	  "d");
+	WRITE_ASS(comm_exec,	  "d");
+	WRITE_ASS(context_switch, "d");
+	WRITE_ASS(write_backward, "d");
+	WRITE_ASS(namespaces,	  "d");
+	WRITE_ASS(use_clockid,    "d");
+	WRITE_ASS(wakeup_events, PRIu32);
+	WRITE_ASS(bp_type, PRIu32);
+	WRITE_ASS(config1, "llu");
+	WRITE_ASS(config2, "llu");
+	WRITE_ASS(branch_sample_type, "llu");
+	WRITE_ASS(sample_regs_user,   "llu");
+	WRITE_ASS(sample_stack_user,  PRIu32);
+
+	fclose(file);
+	return 0;
+}
+
+#undef __WRITE_ASS
+#undef WRITE_ASS
+
+static void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
+		     int fd, int group_fd, unsigned long flags)
+{
+	int errno_saved = errno;
+
+	if ((fd != -1) && store_event(attr, pid, cpu, fd, group_fd, flags)) {
+		pr_err("test attr FAILED");
+		exit(128);
+	}
+
+	errno = errno_saved;
+}
 
 static void evsel__no_extra_fini(struct evsel *evsel __maybe_unused)
 {
@@ -2366,8 +2482,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 				goto out_close;
 			}
 
-			test_attr__ready();
-
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
@@ -2388,7 +2502,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			bpf_counter__install_pe(evsel, idx, fd);
 
-			if (unlikely(test_attr__enabled)) {
+			if (unlikely(test_attr__enabled())) {
 				test_attr__open(&evsel->core.attr, pid,
 						perf_cpu_map__cpu(cpus, idx),
 						fd, group_fd, evsel->open_flags);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9966c21aaf04..14f2c70906be 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -81,13 +81,6 @@ char *perf_exe(char *buf, int len);
 #endif
 #endif
 
-extern bool test_attr__enabled;
-void test_attr__ready(void);
-void test_attr__init(void);
-struct perf_event_attr;
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
-		     int fd, int group_fd, unsigned long flags);
-
 struct perf_debuginfod {
 	const char	*urls;
 	bool		 set;
-- 
2.46.1.824.gd892dcdcdd-goog

