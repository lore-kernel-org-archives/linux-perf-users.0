Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF924D8CB
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950532; cv=none; b=H1T6yzKb/ujt5aoasPovBHUtQrvU0xJ8NfLbGh9ADvZM2ZogWTNGu0ISwmpwWXqRs97RH1klUDYphINe655V+M7zQ4d5Q205PI5nT1SvwV2Rk7BjoItMr7Y0t3L5wcEtsfkPReHZ4JrYyggkNKpUyF4W22ieTTWj4tidDV3Fmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950532; c=relaxed/simple;
	bh=dwg8gNhh7v9B1ydGubuqneMwz+VTpM9C3AFrPIq1XfQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JxNs6S8AFPAZvWAu+9mpDm9I3Aoy5/Gsd9M+hfuWlX8/rLPDfTmaJ/rQKEQ4YFhefcE9mDo6gdXiM3iitzJ2BPVJbdxxcWpKD7Oe4l+QimhecWo1DskEtvDTV60iVlGr2foVWYVkTolfAfNzRnECh6LI6uR7aucb8rzS6DME6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBdXw8/1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBdXw8/1"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3204db795so70230097b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728950528; x=1729555328; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4J9mwWpiQPgKMgt+V2+vAl0A41SMcH0GEk0Bg23ggvI=;
        b=GBdXw8/1dcm5UrmhZKCPLCM3j9MhJcY9V1j/CPily9nlbsKU0GK8J1S4nFfZSKKXq8
         +KZSyKnlDHcAZXxE2PQ6FUb1TQWxDAc+OJGftT+gXqOrVq2bCAdi1m9XDK6m6ukE2A1v
         f7kq7oNq+C9Jy2iuWl1vM/SVAG0GALHNwDjaGOmuCu7TDUlaQSOJr+1pDf57o4apMnb6
         9v6Rt3O/LIGn1Kv6xSC8bkZeEQL1m12utVapeI0f7VPWWRwUXhXfYaM18LcPlpVxla8/
         7BiGVNqynL0k5OhUfDlybEBoMwokglMv4PT2ryWlRFt6AFx6gM9oBPwsxWX68fggkySG
         RDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950528; x=1729555328;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J9mwWpiQPgKMgt+V2+vAl0A41SMcH0GEk0Bg23ggvI=;
        b=iI1sGXeEsS2zEbbD4FUekD25e7JGZnXRNyB6DVxbT52Tbvux9LPfLx4l+38gGdjZ84
         Z/UVKBr0YidZlLjIajJ+DHaIEKzXfrOENZPnMsgSGJbTdX/AGR25q7+Q+qoV1vKf6Ylv
         2PWP47auSARm1DUIRUy3TovCXkllrKOoLkbU282BcK8Jq8xYASUO/LbNz/kdk/E2U4Wq
         6Awb+bO9l8Ffsm257sV/PrGCSs/C5kuFACLmsCVRyRv/KY01nECXLb76CHzTpQTGWW4p
         fGpUYQMG897cbv6J240tqK9EjLHBoY0IIFEU9leZsoQTkGYxgZWt67F2qJ6UvNqNNo2w
         u3LA==
X-Forwarded-Encrypted: i=1; AJvYcCV7ocVwx8F1CAJYq0ZV1UArNeEXJMGtOdkkbTIZ5NpeuYOkJb/i3GJ0xl6CTCmwdjovgfKhp1qG/iNVnf3yUWTb@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeK0moq1Xm6erQwjZcUnrPmLafgKFVMZ1MX29dl3p3Q8yagrt
	WnoL2Kbin6+Jd2IhWvnA5GtrBI4wub9hsMK/DoiGTj+LVzjHrbgJy5AdTvDTasuVk2Fk0DUUU9/
	8mv94ug==
X-Google-Smtp-Source: AGHT+IHjvCADWqRvwff+Ci3msyOigV+EFk1j+JPxW4tWPKBSwmWrcqq9CcDpGbe0cYOLMLdn6nzZkXX/Qrgb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f1f9:f6b6:68bc:5a14])
 (user=irogers job=sendgmr) by 2002:a05:690c:6012:b0:6e3:8cf8:7b7 with SMTP id
 00721157ae682-6e38cf80813mr389547b3.8.1728950527863; Mon, 14 Oct 2024
 17:02:07 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:01:57 -0700
In-Reply-To: <20241015000158.871828-1-irogers@google.com>
Message-Id: <20241015000158.871828-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015000158.871828-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 2/3] perf test: Remove C test wrapper for attr.py
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
	linux-perf-users@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

Remove the C wrapper now a shell script wrapper exists. Move
perf_event_attr dumping functions to evsel.c and reduce the scope of
variables/defines. Use fprintf to avoid snprintf complexities in
WRITE_ASS.

Add __SANE_USERSPACE_TYPES__ to evsel.c to fix format flag issues on
PowerPC triggered by moving attr.c functions to evsel.c.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/perf.c               |   2 -
 tools/perf/tests/Build          |   1 -
 tools/perf/tests/attr.c         | 218 --------------------------------
 tools/perf/tests/builtin-test.c |   1 -
 tools/perf/util/evsel.c         | 127 ++++++++++++++++++-
 tools/perf/util/util.h          |   7 -
 6 files changed, 123 insertions(+), 233 deletions(-)
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
index a771e4928247..03cbdf7c50a0 100644
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
index 3b30f258c395..50533446e747 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -80,7 +80,6 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_evsel__tp_sched_test,
 	&suite__syscall_openat_tp_fields,
 #endif
-	&suite__attr,
 	&suite__hists_link,
 	&suite__python_use,
 	&suite__bp_signal,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ed0d4d20e357..b138deaa5199 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -5,6 +5,11 @@
  * Parts came from builtin-{top,stat,record}.c, see those files for further
  * copyright notes.
  */
+/*
+ * Powerpc needs __SANE_USERSPACE_TYPES__ before <linux/types.h> to select
+ * 'int-ll64.h' and avoid compile warnings when printing __u64 with %llu.
+ */
+#define __SANE_USERSPACE_TYPES__
 
 #include <byteswap.h>
 #include <errno.h>
@@ -76,7 +81,123 @@ static int evsel__no_extra_init(struct evsel *evsel __maybe_unused)
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
@@ -2144,8 +2265,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 				goto out_close;
 			}
 
-			test_attr__ready();
-
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
@@ -2166,7 +2285,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
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
2.47.0.rc1.288.g06298d1525-goog

