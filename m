Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642142;
	b=1DG3/Uf55mQNtzqIef1NszbAJRXwl17kWMZ6xiRzw1aC3YCml/d8bcDyjqASR68z+xsW
	 R++y4wdivR5abSIyqTK4x6e21lbdqeBCb5qosqS/LwRfXlBROtHyvfRtn13Ux+y9/jiQg
	 pf7pc2sAMpfRAuk+gX7MdzVbEEIysDBoeletZJH08dKTjcolq7RyZqRsBpgLK2zb6qa76
	 2kFg8uJlYs7LzkJJrBaUzTrLRdy/oiCyFPP9amgZy1QTE4EhP6NGX7sPcJ2zQgcU/pY1K
	 /aM9j/SVOBnM4k2ZCc/VFB3nLH83m5JH8kXT8EzBeAw+cANm11v9NmnYQZfZdV/93Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642142;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vfB9zDUtk2VQgoe83tkg2uhdgvYdLQfXnRZh82yLSJM=;
	b=WaoHQVRDh5PCgJCdpsj18IKKIpTwSs4bs639kmZeaDIWHT9XJkUvTZmipnz+UAHcPjoW
	 BhBErF8wevFO3CrRwF8K7q4VfWy5TktTm9Gs+dybypHpkWNB/iJDv8v5mVGH6Kt50DgA7
	 eoQkbDD6CClDQrwldGEuOjgqdY9KjZiLiEEQPWNy4eKVh9Zze3KBzXoP0+yBnIVXhwuDG
	 GmLRnAg8KHLoHNJIrlaQHTNifOA/1wcXLAXXffEHdElwNVKJAI3dYLlLuX7nDlmZfNKFQ
	 UKbg9so3N1UxQoaG5x7JG5w1vlj1ZL6ozX/9UuVnhDdcjFL4pdrP8/gi3LyOyAIESRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUKngMzB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0D606A6AF;
	Wed, 25 Nov 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUKngMzB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF5C1F00ACF;
	Wed, 25 Nov 2026 21:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642142;
	bh=vfB9zDUtk2VQgoe83tkg2uhdgvYdLQfXnRZh82yLSJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iUKngMzBfUWL+MP377b4dWP2AeMWg8fwc6RGjQmy1GtFAbwTiygDbvYFnTD8OxyTi
	 Cy4WWYF+KmYOVxAr7MBp8Wozn5HH3Q6eaTIJxA6i/Ytqz+bH3Pgb82cloFYESwcwPP
	 3q2NssiZl/s5l+basPj3VFUMnks71NGCoykZIIUrv8ZJ/fPSqrecJERHyKIInXIcic
	 fH7y8GFF5z3LSqLdKc70WG9PBQq/Wac0kOwZtSiPbVWycJrNGrYumMI92IuFQokyII
	 B6iMgHDDqJf5elNGAsTgNoyYb6ioTCAXIi2UQuRa+oCm3BwD6X/CFRLYdlGxfRQiEN
	 Jgsq1mBEC+oFA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 11/11] perf tests: Add namespace, nsinfo, and boot ID tests
Date: Wed, 25 Nov 2026 13:28:51 -0800
Message-ID: <20261125212851.1792988-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261125212851.1792988-1-namhyung@kernel.org>
References: <20261125212851.1792988-1-namhyung@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "Namespace and nsinfo tests" suite covering HEADER_BOOT_ID,
perf_env__is_same_boot(), deferred /proc lookup, raw nsinfo__copy(),
PID/TID recycling detection, thread exit and fork liveness tracking,
dso_binary_type__needs_ns(), and isolated mountns, overmounted /proc,
and chroot resolution.

Also verify the boot ID header matches /proc/sys/kernel/random/boot_id
in the perf header and perf pipe shell tests.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/Build              |    1 +
 tools/perf/tests/builtin-test.c     |    1 +
 tools/perf/tests/namespaces.c       | 1189 +++++++++++++++++++++++++++
 tools/perf/tests/shell/header.sh    |    9 +
 tools/perf/tests/shell/pipe_test.sh |   21 +
 tools/perf/tests/tests.h            |    1 +
 6 files changed, 1222 insertions(+)
 create mode 100644 tools/perf/tests/namespaces.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 1377dd465586653f..a95ca6cbcb6d6809 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -75,6 +75,7 @@ perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
+perf-test-y += namespaces.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c447432dc41f0591..ad43dcd252602791 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -193,6 +193,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__util,
 	&suite__subcmd_help,
 	&suite__kallsyms_split,
+	&suite__namespaces,
 	NULL,
 };
 
diff --git a/tools/perf/tests/namespaces.c b/tools/perf/tests/namespaces.c
new file mode 100644
index 0000000000000000..a9ab0a7ca3c0a53e
--- /dev/null
+++ b/tools/perf/tests/namespaces.c
@@ -0,0 +1,1189 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <api/fs/fs.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+
+#include "debug.h"
+#include "tests.h"
+#include "util/build-id.h"
+#include "util/dso.h"
+#include "util/env.h"
+#include "util/event.h"
+#include "util/header.h"
+#include "util/machine.h"
+#include "util/map.h"
+#include "util/namespaces.h"
+#include "util/session.h"
+#include "util/symbol.h"
+#include "util/synthetic-events.h"
+#include "util/thread.h"
+#include "util/tool.h"
+#include "util/util.h"
+
+#define CHILD_EXIT_SKIP 2
+
+static int read_host_boot_id_str(char *buf, size_t sz)
+{
+	char *tmp = NULL;
+	size_t len = 0;
+
+	if (procfs__read_str("sys/kernel/random/boot_id", &tmp, &len) < 0)
+		return -1;
+
+	strlcpy(buf, strim(tmp), sz);
+	free(tmp);
+	return buf[0] ? 0 : -1;
+}
+
+struct boot_id_feature_tool {
+	struct perf_tool	tool;
+	struct perf_session	*session;
+};
+
+static int process_boot_id_feature(const struct perf_tool *tool,
+				   union perf_event *event,
+				   struct perf_sample *sample __maybe_unused,
+				   struct machine *machine __maybe_unused)
+{
+	struct boot_id_feature_tool *ftool =
+		container_of(tool, struct boot_id_feature_tool, tool);
+
+	return perf_event__process_feature(tool, ftool->session, event);
+}
+
+static int test_boot_id_feature_event(struct perf_env *host_env)
+{
+	struct boot_id_feature_tool ftool = {};
+	struct perf_session *session;
+	int ret = -1;
+
+	perf_tool__init(&ftool.tool, false);
+	session = __perf_session__new(NULL, &ftool.tool, false, host_env);
+	if (IS_ERR(session))
+		return -1;
+
+	ftool.session = session;
+	session->header.env.offline = true;
+	if (perf_env__is_same_boot(&session->header.env)) {
+		pr_debug("empty offline session unexpectedly matched host boot_id\n");
+		goto out;
+	}
+
+	perf_header__set_feat(&session->header, HEADER_BOOT_ID);
+	if (perf_event__synthesize_features(&ftool.tool, session, NULL,
+					    process_boot_id_feature) < 0) {
+		pr_debug("perf_event__synthesize_features(HEADER_BOOT_ID) failed\n");
+		goto out;
+	}
+
+	if (!session->header.env.boot_id ||
+	    !perf_env__is_same_boot(&session->header.env)) {
+		pr_debug("processed HEADER_BOOT_ID feature failed to match host boot_id\n");
+		goto out;
+	}
+
+	ret = 0;
+out:
+	perf_session__delete(session);
+	return ret;
+}
+
+static int test__nsinfo_boot_id(struct test_suite *test __maybe_unused,
+				int subtest __maybe_unused)
+{
+	struct perf_env live_env, off_env;
+	char host_boot_id[64];
+	const char *bid;
+	int ret = TEST_FAIL;
+
+	if (read_host_boot_id_str(host_boot_id, sizeof(host_boot_id)) < 0) {
+		pr_debug("SKIP: cannot read host boot_id from procfs\n");
+		return TEST_SKIP;
+	}
+
+	perf_env__init(&live_env);
+	perf_env__init(&off_env);
+
+	if (!perf_env__is_same_boot(NULL)) {
+		pr_debug("NULL env should match current host boot\n");
+		goto out;
+	}
+
+	if (!perf_env__is_same_boot(&live_env)) {
+		pr_debug("live env should match current host boot\n");
+		goto out;
+	}
+	bid = perf_env__boot_id(&live_env);
+	if (!bid || strcmp(bid, host_boot_id) != 0) {
+		pr_debug("unexpected live env boot_id: %s vs %s\n",
+			 bid ? bid : "(null)", host_boot_id);
+		goto out;
+	}
+
+	/* Offline environments must not fall back to or cache the host boot_id. */
+	off_env.offline = true;
+	if (perf_env__boot_id(&off_env) != NULL) {
+		pr_debug("offline env without boot_id unexpectedly returned host boot_id\n");
+		goto out;
+	}
+	if (off_env.boot_id != NULL) {
+		pr_debug("offline env->boot_id was poisoned\n");
+		goto out;
+	}
+	if (perf_env__is_same_boot(&off_env)) {
+		pr_debug("offline env without boot_id should not match current boot\n");
+		goto out;
+	}
+
+	off_env.boot_id = strdup(host_boot_id);
+	if (!off_env.boot_id)
+		goto out;
+	if (!perf_env__is_same_boot(&off_env)) {
+		pr_debug("offline env with matching boot_id failed to match\n");
+		goto out;
+	}
+
+	zfree(&off_env.boot_id);
+	off_env.boot_id = strdup("00000000-0000-0000-0000-000000000000");
+	if (!off_env.boot_id)
+		goto out;
+	if (perf_env__is_same_boot(&off_env)) {
+		pr_debug("offline env with mismatched boot_id unexpectedly matched\n");
+		goto out;
+	}
+
+	if (test_boot_id_feature_event(&live_env) < 0)
+		goto out;
+
+	ret = TEST_OK;
+out:
+	perf_env__exit(&off_env);
+	perf_env__exit(&live_env);
+	return ret;
+}
+
+static int test__nsinfo_init_and_copy(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	struct nsinfo *nsi = NULL, *copy = NULL, *copy2 = NULL;
+	pid_t pid = getpid();
+	int ret = TEST_FAIL;
+
+	if (nsinfo__new_thread(0, pid) != NULL ||
+	    nsinfo__new_thread(pid, 0) != NULL ||
+	    nsinfo__new_thread(-1, -1) != NULL ||
+	    nsinfo__copy(NULL) != NULL ||
+	    nsinfo__need_setns(NULL) ||
+	    nsinfo__check_proc(NULL)) {
+		pr_debug("invalid nsinfo boundary condition succeeded\n");
+		return TEST_FAIL;
+	}
+
+	nsi = nsinfo__new_thread(pid, pid);
+	if (!nsi)
+		return TEST_FAIL;
+
+	if (nsinfo__inited(nsi) || nsinfo__exited(nsi)) {
+		pr_debug("nsinfo__new_thread() unexpectedly ran /proc init eagerly\n");
+		goto out;
+	}
+	if (nsinfo__pid(nsi) != pid || nsinfo__tid(nsi) != pid) {
+		pr_debug("unexpected pid/tid on new nsinfo\n");
+		goto out;
+	}
+
+	/*
+	 * Copying before initialization (e.g., for [vdso] mappings) must not
+	 * force eager /proc lookups on the source nsinfo.
+	 */
+	copy = nsinfo__copy(nsi);
+	if (!copy)
+		goto out;
+	if (nsinfo__inited(nsi) || nsinfo__inited(copy)) {
+		pr_debug("nsinfo__copy() unexpectedly triggered lazy init\n");
+		goto out;
+	}
+
+	nsinfo__clear_need_setns(copy);
+	if (!nsinfo__inited(copy) || nsinfo__exited(copy) || nsinfo__need_setns(copy)) {
+		pr_debug("nsinfo__clear_need_setns() state mismatch\n");
+		goto out;
+	}
+
+	/* Querying triggers lazy initialization cleanly. */
+	if (nsinfo__need_setns(nsi)) {
+		pr_debug("same-namespace task unexpectedly needs setns\n");
+		goto out;
+	}
+	if (!nsinfo__inited(nsi) || nsinfo__exited(nsi) ||
+	    nsinfo__tgid(nsi) != pid || nsinfo__nstgid(nsi) <= 0) {
+		pr_debug("lazy init failed to populate expected fields\n");
+		goto out;
+	}
+
+	copy2 = nsinfo__copy(nsi);
+	if (!copy2)
+		goto out;
+	if (!nsinfo__inited(copy2) ||
+	    nsinfo__tgid(copy2) != nsinfo__tgid(nsi) ||
+	    nsinfo__nstgid(copy2) != nsinfo__nstgid(nsi) ||
+	    nsinfo__in_pidns(copy2) != nsinfo__in_pidns(nsi)) {
+		pr_debug("nsinfo__copy() did not preserve initialized fields\n");
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	nsinfo__put(copy2);
+	nsinfo__put(copy);
+	nsinfo__put(nsi);
+	return ret;
+}
+
+struct worker_ctx {
+	pthread_mutex_t lock;
+	pthread_cond_t cond;
+	bool ready;
+	bool stop;
+	pid_t tid;
+};
+
+static void *worker_thread_fn(void *arg)
+{
+	struct worker_ctx *ctx = arg;
+
+	pthread_mutex_lock(&ctx->lock);
+	ctx->tid = syscall(SYS_gettid);
+	ctx->ready = true;
+	pthread_cond_broadcast(&ctx->cond);
+	while (!ctx->stop)
+		pthread_cond_wait(&ctx->cond, &ctx->lock);
+	pthread_mutex_unlock(&ctx->lock);
+
+	return NULL;
+}
+
+static pid_t spawn_reaped_child(void)
+{
+	pid_t child;
+	int status;
+
+	child = fork();
+	if (child < 0)
+		return -1;
+	if (child == 0)
+		_exit(0);
+
+	if (waitpid(child, &status, 0) != child)
+		return -1;
+
+	return child;
+}
+
+static int test__nsinfo_proc_and_recycled_tid(struct test_suite *test __maybe_unused,
+					      int subtest __maybe_unused)
+{
+	struct worker_ctx wctx = {
+		.lock = PTHREAD_MUTEX_INITIALIZER,
+		.cond = PTHREAD_COND_INITIALIZER,
+	};
+	struct nsinfo *dead1 = NULL, *dead2 = NULL;
+	struct nsinfo *valid = NULL, *recycled1 = NULL, *recycled2 = NULL;
+	pthread_t thr;
+	bool started = false;
+	pid_t dead_pid, self_pid = getpid();
+	int ret = TEST_FAIL;
+
+	dead_pid = spawn_reaped_child();
+	if (dead_pid <= 0) {
+		pr_debug("SKIP: cannot fork dead child\n");
+		return TEST_SKIP;
+	}
+
+	dead1 = nsinfo__new_thread(dead_pid, dead_pid);
+	dead2 = nsinfo__new_thread(dead_pid, dead_pid);
+	if (!dead1 || !dead2)
+		goto out;
+
+	if (nsinfo__check_proc(dead1)) {
+		pr_debug("reaped child unexpectedly passed nsinfo__check_proc()\n");
+		goto out;
+	}
+	if (!nsinfo__exited(dead1) || !nsinfo__inited(dead1) ||
+	    nsinfo__need_setns(dead1)) {
+		pr_debug("failed nsinfo__check_proc() did not mark dead1 exited\n");
+		goto out;
+	}
+
+	if (nsinfo__need_setns(dead2)) {
+		pr_debug("reaped child unexpectedly needed setns\n");
+		goto out;
+	}
+	if (!nsinfo__exited(dead2) || !nsinfo__inited(dead2) ||
+	    nsinfo__tgid(dead2) != dead_pid || nsinfo__nstgid(dead2) != dead_pid ||
+	    nsinfo__in_pidns(dead2)) {
+		pr_debug("failed lazy init corrupted fallback fields on dead nsinfo\n");
+		goto out;
+	}
+
+	if (pthread_create(&thr, NULL, worker_thread_fn, &wctx) != 0)
+		goto out;
+	started = true;
+
+	pthread_mutex_lock(&wctx.lock);
+	while (!wctx.ready)
+		pthread_cond_wait(&wctx.cond, &wctx.lock);
+	pthread_mutex_unlock(&wctx.lock);
+
+	if (wctx.tid == self_pid) {
+		pr_debug("worker tid unexpectedly matched tgid\n");
+		goto out;
+	}
+
+	valid = nsinfo__new_thread(self_pid, wctx.tid);
+	if (!valid)
+		goto out;
+	if (!nsinfo__check_proc(valid) || nsinfo__need_setns(valid) ||
+	    nsinfo__exited(valid) || nsinfo__tgid(valid) != self_pid) {
+		pr_debug("valid live thread (pid, tid) failed proc checks\n");
+		goto out;
+	}
+
+	/*
+	 * Simulate TID recycling: /proc/<tid>/task/<tid>/status exists in
+	 * procfs for our live worker thread, but its Tgid is self_pid != tid.
+	 * Both check_proc and lazy init must reject it and preserve fallback
+	 * fields without overwriting tgid/nstgid/in_pidns.
+	 */
+	recycled1 = nsinfo__new_thread(wctx.tid, wctx.tid);
+	recycled2 = nsinfo__new_thread(wctx.tid, wctx.tid);
+	if (!recycled1 || !recycled2)
+		goto out;
+
+	if (nsinfo__check_proc(recycled1) || !nsinfo__exited(recycled1)) {
+		pr_debug("mismatched Tgid passed nsinfo__check_proc()\n");
+		goto out;
+	}
+	if (nsinfo__need_setns(recycled2) || !nsinfo__exited(recycled2)) {
+		pr_debug("mismatched Tgid passed lazy init\n");
+		goto out;
+	}
+	if (nsinfo__tgid(recycled2) != wctx.tid ||
+	    nsinfo__nstgid(recycled2) != wctx.tid ||
+	    nsinfo__in_pidns(recycled2)) {
+		pr_debug("mismatched Tgid overwrote nsinfo tgid/pidns fields\n");
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	if (started) {
+		pthread_mutex_lock(&wctx.lock);
+		wctx.stop = true;
+		pthread_cond_broadcast(&wctx.cond);
+		pthread_mutex_unlock(&wctx.lock);
+		pthread_join(thr, NULL);
+	}
+	nsinfo__put(recycled2);
+	nsinfo__put(recycled1);
+	nsinfo__put(valid);
+	nsinfo__put(dead2);
+	nsinfo__put(dead1);
+	return ret;
+}
+
+static int test__nsinfo_thread_liveness(struct test_suite *test __maybe_unused,
+					int subtest __maybe_unused)
+{
+	struct machines live_machines, off_machines;
+	struct machine *live_m, *off_m;
+	struct perf_env live_env, off_env;
+	struct thread *idle_th = NULL, *off_th = NULL, *off_sub = NULL;
+	struct thread *th = NULL, *bad_parent = NULL;
+	struct nsinfo *nsi1 = NULL, *nsi2 = NULL, *nsi3 = NULL;
+	struct nsinfo *old_parent_nsi = NULL, *del_nsi = NULL, *off_nsi = NULL;
+	struct perf_record_namespaces *ns_ev;
+	struct perf_sample sample = { 0 };
+	struct perf_tool tool;
+	union perf_event ev;
+	pid_t self_pid = getpid();
+	int ret = TEST_FAIL;
+
+	perf_env__init(&live_env);
+	perf_env__init(&off_env);
+	off_env.offline = true;
+	perf_tool__init(&tool, /*ordered_events=*/false);
+
+	if (machines__init(&live_machines, NULL) != 0)
+		goto out_env;
+	if (machines__init(&off_machines, NULL) != 0) {
+		machines__exit(&live_machines);
+		goto out_env;
+	}
+
+	live_m = &live_machines.host;
+	live_m->env = &live_env;
+	off_m = &off_machines.host;
+	off_m->env = &off_env;
+
+	/* Idle (0, 0) thread must not evaluate boot_id or populate env->boot_id. */
+	idle_th = machine__findnew_thread(off_m, 0, 0);
+	if (!idle_th)
+		goto out;
+	if (off_env.boot_id != NULL) {
+		pr_debug("idle thread init poisoned offline env->boot_id\n");
+		goto out;
+	}
+	thread__put(idle_th);
+	idle_th = NULL;
+
+	/*
+	 * Create both leader and sub-thread before removing the leader so
+	 * thread__init_maps() does not re-create (self_pid, self_pid) later,
+	 * then verify thread__e_machine_endian() does not recreate it either.
+	 */
+	off_th = machine__findnew_thread(off_m, self_pid, self_pid);
+	off_sub = machine__findnew_thread(off_m, self_pid, self_pid + 1);
+	if (!off_th || !off_sub)
+		goto out;
+	off_nsi = thread__get_nsinfo(off_th);
+	if (!off_nsi || !nsinfo__exited(off_nsi) || thread__is_alive(off_th)) {
+		pr_debug("offline session thread stayed alive\n");
+		goto out;
+	}
+	machine__remove_thread(off_m, off_th);
+	thread__put(off_th);
+	off_th = NULL;
+
+	thread__e_machine_endian(off_sub, off_m, NULL, NULL);
+	off_th = machine__find_thread(off_m, self_pid, self_pid);
+	if (off_th != NULL) {
+		pr_debug("thread__e_machine_endian() unexpectedly recreated exited leader\n");
+		goto out;
+	}
+	machine__remove_thread(off_m, off_sub);
+	thread__put(off_sub);
+	off_sub = NULL;
+
+	/* Live thread tracking, reset on exec/namespaces, and exit propagation. */
+	th = machine__findnew_thread(live_m, self_pid, self_pid);
+	if (!th || !thread__is_alive(th)) {
+		pr_debug("current live thread reported as dead\n");
+		goto out;
+	}
+
+	nsi1 = thread__get_nsinfo(th);
+	if (!nsi1)
+		goto out;
+
+	if (__thread__set_comm(th, "execed", 1000, /*exec=*/true) != 0)
+		goto out;
+	nsi2 = thread__get_nsinfo(th);
+	if (!nsi2 || RC_CHK_EQUAL(nsi2, nsi1)) {
+		pr_debug("exec did not replace thread->nsinfo\n");
+		goto out;
+	}
+
+	ns_ev = calloc(1, sizeof(*ns_ev) + sizeof(ns_ev->link_info[0]));
+	if (!ns_ev)
+		goto out;
+	ns_ev->nr_namespaces = 1;
+	if (thread__set_namespaces(th, 2000, ns_ev) != 0) {
+		free(ns_ev);
+		goto out;
+	}
+	free(ns_ev);
+
+	nsi3 = thread__get_nsinfo(th);
+	if (!nsi3 || RC_CHK_EQUAL(nsi3, nsi2)) {
+		pr_debug("PERF_RECORD_NAMESPACES did not replace thread->nsinfo\n");
+		goto out;
+	}
+
+	thread__set_exited(th, true);
+	if (!thread__exited(th) || thread__is_alive(th) ||
+	    !nsinfo__exited(nsi3) || nsinfo__check_proc(nsi3) ||
+	    nsinfo__exited(nsi1)) {
+		pr_debug("exit propagation or prior DSO nsinfo isolation failed\n");
+		goto out;
+	}
+
+	machine__remove_thread(live_m, th);
+	thread__put(th);
+	th = NULL;
+
+	/* Replaced erroneous parent in machine__process_fork_event() gets marked exited. */
+	bad_parent = machine__findnew_thread(live_m, self_pid + 1, self_pid);
+	if (!bad_parent)
+		goto out;
+	old_parent_nsi = thread__get_nsinfo(bad_parent);
+	thread__put(bad_parent);
+	bad_parent = NULL;
+	if (!old_parent_nsi)
+		goto out;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.fork.header.type = PERF_RECORD_FORK;
+	ev.fork.header.size = sizeof(ev.fork);
+	ev.fork.ppid = self_pid;
+	ev.fork.ptid = self_pid;
+	ev.fork.pid = self_pid + 2;
+	ev.fork.tid = self_pid + 2;
+	if (machine__process_fork_event(live_m, &ev, &sample) != 0)
+		goto out;
+	if (!nsinfo__exited(old_parent_nsi) || nsinfo__check_proc(old_parent_nsi)) {
+		pr_debug("replaced parent thread nsinfo was not marked exited\n");
+		goto out;
+	}
+
+	/* perf_event__exit_del_thread() also marks removed thread's nsinfo exited. */
+	th = machine__find_thread(live_m, self_pid, self_pid);
+	if (!th)
+		goto out;
+	del_nsi = thread__get_nsinfo(th);
+	thread__put(th);
+	th = NULL;
+	if (!del_nsi)
+		goto out;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.fork.header.type = PERF_RECORD_EXIT;
+	ev.fork.header.size = sizeof(ev.fork);
+	ev.fork.pid = self_pid;
+	ev.fork.tid = self_pid;
+	ev.fork.ppid = 1;
+	ev.fork.ptid = 1;
+	if (perf_event__exit_del_thread(&tool, &ev, &sample, live_m) != 0)
+		goto out;
+	th = machine__find_thread(live_m, self_pid, self_pid);
+	if (!nsinfo__exited(del_nsi) || nsinfo__check_proc(del_nsi) || th != NULL) {
+		pr_debug("perf_event__exit_del_thread() did not mark nsinfo exited\n");
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	thread__put(th);
+	thread__put(off_sub);
+	thread__put(off_th);
+	thread__put(idle_th);
+	thread__put(bad_parent);
+	nsinfo__put(del_nsi);
+	nsinfo__put(old_parent_nsi);
+	nsinfo__put(off_nsi);
+	nsinfo__put(nsi3);
+	nsinfo__put(nsi2);
+	nsinfo__put(nsi1);
+	machines__exit(&off_machines);
+	machines__exit(&live_machines);
+out_env:
+	perf_env__exit(&off_env);
+	perf_env__exit(&live_env);
+	return ret;
+}
+
+static int test__nsinfo_dso_needs_ns(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
+{
+	static const enum dso_binary_type needs_ns_types[] = {
+		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
+		DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE,
+		DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP,
+		DSO_BINARY_TYPE__DEBUGLINK,
+		DSO_BINARY_TYPE__GNU_DEBUGDATA,
+		DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
+		DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
+		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
+		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	};
+	static const enum dso_binary_type host_only_types[] = {
+		DSO_BINARY_TYPE__KALLSYMS,
+		DSO_BINARY_TYPE__GUEST_KALLSYMS,
+		DSO_BINARY_TYPE__VMLINUX,
+		DSO_BINARY_TYPE__GUEST_VMLINUX,
+		DSO_BINARY_TYPE__JAVA_JIT,
+		DSO_BINARY_TYPE__BUILD_ID_CACHE,
+		DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
+		DSO_BINARY_TYPE__GUEST_KMODULE,
+		DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
+		DSO_BINARY_TYPE__KCORE,
+		DSO_BINARY_TYPE__GUEST_KCORE,
+		DSO_BINARY_TYPE__BPF_PROG_INFO,
+		DSO_BINARY_TYPE__BPF_IMAGE,
+		DSO_BINARY_TYPE__OOL,
+		DSO_BINARY_TYPE__NOT_FOUND,
+	};
+	struct dso *dso = NULL;
+	struct nsinfo *nsi = NULL;
+	struct build_id bid = { .size = 0 };
+	char *resolved = NULL;
+	int ret = TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(needs_ns_types); i++) {
+		if (!dso_binary_type__needs_ns(needs_ns_types[i])) {
+			pr_debug("binary type %d should need ns\n", needs_ns_types[i]);
+			return TEST_FAIL;
+		}
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(host_only_types); i++) {
+		if (dso_binary_type__needs_ns(host_only_types[i])) {
+			pr_debug("binary type %d should not need ns\n", host_only_types[i]);
+			return TEST_FAIL;
+		}
+	}
+
+	/* Guarded chroot/build-id lookups must bail out immediately when exited. */
+	dso = dso__new("/bin/sh");
+	nsi = nsinfo__new_thread(getpid(), getpid());
+	if (!dso || !nsi)
+		goto out;
+	nsinfo__set_exited(nsi);
+	dso__set_nsinfo(dso, nsinfo__get(nsi));
+
+	resolved = dso__filename_with_chroot(dso, "/bin/sh");
+	if (resolved != NULL) {
+		pr_debug("dso__filename_with_chroot() did not respect exited nsinfo\n");
+		free(resolved);
+		goto out;
+	}
+	if (filename__read_build_id_ns("/nonexistent_perf_chroot_test", &bid, nsi) >= 0) {
+		pr_debug("filename__read_build_id_ns() succeeded on nonexistent path\n");
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	nsinfo__put(nsi);
+	dso__put(dso);
+	return ret;
+}
+
+static int copy_file_mode(const char *src, const char *dst, mode_t mode)
+{
+	char buf[4096];
+	int in_fd = -1, out_fd = -1;
+	ssize_t n;
+	int err = -1;
+
+	in_fd = open(src, O_RDONLY);
+	if (in_fd < 0)
+		return -1;
+	out_fd = open(dst, O_WRONLY | O_CREAT | O_TRUNC, mode);
+	if (out_fd < 0)
+		goto out;
+
+	while ((n = read(in_fd, buf, sizeof(buf))) > 0) {
+		ssize_t off = 0;
+
+		while (off < n) {
+			ssize_t w = write(out_fd, buf + off, n - off);
+
+			if (w <= 0)
+				goto out;
+			off += w;
+		}
+	}
+	if (n == 0)
+		err = 0;
+out:
+	if (out_fd >= 0)
+		close(out_fd);
+	close(in_fd);
+	return err;
+}
+
+static int write_proc_map(const char *path, const char *text)
+{
+	int fd = open(path, O_WRONLY);
+	ssize_t len = strlen(text);
+	ssize_t n;
+
+	if (fd < 0)
+		return -1;
+	n = write(fd, text, len);
+	close(fd);
+	return n == len ? 0 : -1;
+}
+
+static int enter_private_userns(void)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char map_buf[64];
+
+	if (unshare(CLONE_NEWUSER) < 0)
+		return -1;
+
+	/* Required before writing gid_map in unprivileged user namespaces. */
+	if (write_proc_map("/proc/self/setgroups", "deny\n") < 0)
+		return -1;
+	snprintf(map_buf, sizeof(map_buf), "0 %u 1\n", uid);
+	if (write_proc_map("/proc/self/uid_map", map_buf) < 0)
+		return -1;
+	snprintf(map_buf, sizeof(map_buf), "0 %u 1\n", gid);
+	if (write_proc_map("/proc/self/gid_map", map_buf) < 0)
+		return -1;
+
+	/*
+	 * Create a private mount namespace owned by the new user namespace so
+	 * nsinfo__mountns_exit() has CAP_SYS_ADMIN to restore nc->oldns.
+	 */
+	if (unshare(CLONE_NEWNS) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int test_chroot_resolution(const char *chroot_dir, const char *chroot_bin,
+				  bool has_exe_bid, const struct build_id *exe_bid)
+{
+	int cpipe[2] = { -1, -1 };
+	struct nsinfo *cnsi = NULL;
+	struct dso *chroot_dso = NULL;
+	char *resolved = NULL;
+	struct build_id ns_bid;
+	struct stat st1, st2;
+	pid_t cpid = -1;
+	char sig = 0;
+	int ret = -1;
+
+	if (geteuid() != 0 || access("/chroot_elf", F_OK) == 0)
+		return 0;
+
+	if (pipe(cpipe) < 0)
+		return -1;
+
+	cpid = fork();
+	if (cpid < 0)
+		goto out;
+
+	if (cpid == 0) {
+		close(cpipe[0]);
+		if (chroot(chroot_dir) < 0 || chdir("/") < 0) {
+			sig = 'S';
+			if (write(cpipe[1], &sig, 1) != 1)
+				_exit(1);
+			_exit(CHILD_EXIT_SKIP);
+		}
+		sig = '1';
+		if (write(cpipe[1], &sig, 1) != 1)
+			_exit(1);
+		pause();
+		_exit(0);
+	}
+
+	close(cpipe[1]);
+	cpipe[1] = -1;
+
+	if (read(cpipe[0], &sig, 1) != 1 || sig != '1') {
+		ret = sig == 'S' ? 0 : -1;
+		goto out;
+	}
+
+	cnsi = nsinfo__new_thread(cpid, cpid);
+	chroot_dso = dso__new("/chroot_elf");
+	if (!chroot_dso || !cnsi)
+		goto out;
+
+	dso__set_nsinfo(chroot_dso, nsinfo__get(cnsi));
+	resolved = dso__filename_with_chroot(chroot_dso, "/chroot_elf");
+	if (!resolved ||
+	    stat(resolved, &st1) < 0 ||
+	    stat(chroot_bin, &st2) < 0 ||
+	    st1.st_dev != st2.st_dev ||
+	    st1.st_ino != st2.st_ino) {
+		pr_debug("chroot resolution mismatch: %s vs %s\n",
+			 resolved ? resolved : "(null)", chroot_bin);
+		goto out;
+	}
+	zfree(&resolved);
+
+	if (has_exe_bid) {
+		memset(&ns_bid, 0, sizeof(ns_bid));
+		if (filename__read_build_id_ns("/chroot_elf", &ns_bid, cnsi) <= 0 ||
+		    memcmp(exe_bid, &ns_bid, sizeof(*exe_bid)) != 0) {
+			pr_debug("chroot build-id mismatch\n");
+			goto out;
+		}
+	}
+
+	kill(cpid, SIGKILL);
+	waitpid(cpid, NULL, 0);
+	cpid = -1;
+
+	resolved = dso__filename_with_chroot(chroot_dso, "/chroot_elf");
+	if (resolved != NULL) {
+		pr_debug("exited chroot task resolved /proc/<pid>/root\n");
+		goto out;
+	}
+
+	ret = 0;
+out:
+	if (cpid > 0) {
+		kill(cpid, SIGKILL);
+		waitpid(cpid, NULL, 0);
+	}
+	if (cpipe[0] >= 0)
+		close(cpipe[0]);
+	if (cpipe[1] >= 0)
+		close(cpipe[1]);
+	free(resolved);
+	dso__put(chroot_dso);
+	nsinfo__put(cnsi);
+	return ret;
+}
+
+static int run_mountns_and_chroot_tests(void)
+{
+	char tmpdir[] = "/tmp/perf-test-mntns-XXXXXX";
+	char exe_path[PATH_MAX], target_bin[PATH_MAX];
+	char chroot_dir[PATH_MAX], chroot_bin[PATH_MAX];
+	struct build_id exe_bid = { .size = 0 }, ns_bid = { .size = 0 };
+	int to_child[2] = { -1, -1 }, to_parent[2] = { -1, -1 };
+	struct machine machine;
+	struct nscookie nsc;
+	struct dso *dso = NULL;
+	struct nsinfo *nsi = NULL;
+	bool has_exe_bid = false;
+	pid_t child = -1;
+	char sig = 0;
+	u8 magic[4];
+	int status;
+	int ret = TEST_FAIL;
+
+	if (geteuid() != 0 && enter_private_userns() < 0) {
+		pr_debug("SKIP: user namespace not permitted\n");
+		return TEST_SKIP;
+	}
+
+	if (mkdtemp(tmpdir) == NULL)
+		return TEST_FAIL;
+
+	perf_exe(exe_path, sizeof(exe_path));
+	has_exe_bid = filename__read_build_id(exe_path, &exe_bid) > 0;
+	snprintf(target_bin, sizeof(target_bin), "%s/testbin", tmpdir);
+	snprintf(chroot_dir, sizeof(chroot_dir), "%s/chroot", tmpdir);
+	snprintf(chroot_bin, sizeof(chroot_bin), "%s/chroot/chroot_elf", tmpdir);
+
+	if (mkdir(chroot_dir, 0700) < 0 ||
+	    copy_file_mode(exe_path, chroot_bin, 0700) < 0)
+		goto out_rmdir;
+
+	if (pipe(to_child) < 0 || pipe(to_parent) < 0)
+		goto out_rmdir;
+
+	child = fork();
+	if (child < 0)
+		goto out_rmdir;
+
+	if (child == 0) {
+		char cmd = 0;
+
+		close(to_child[1]);
+		close(to_parent[0]);
+
+		if (unshare(CLONE_NEWNS) < 0 ||
+		    mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0 ||
+		    mount("tmpfs", tmpdir, "tmpfs", 0, NULL) < 0 ||
+		    copy_file_mode(exe_path, target_bin, 0700) < 0) {
+			sig = 'S';
+			if (write(to_parent[1], &sig, 1) != 1)
+				_exit(1);
+			_exit(CHILD_EXIT_SKIP);
+		}
+
+		sig = '1';
+		if (write(to_parent[1], &sig, 1) != 1)
+			_exit(1);
+
+		/* Phase 1.5: overmount /proc if permitted to simulate container /proc. */
+		if (read(to_child[0], &cmd, 1) != 1)
+			_exit(1);
+		if (mount("tmpfs", "/proc", "tmpfs", 0, NULL) == 0)
+			sig = 'p';
+		else
+			sig = 's';
+		if (write(to_parent[1], &sig, 1) != 1)
+			_exit(1);
+
+		/* Phase 2: switch to another mount namespace to test inode check. */
+		if (read(to_child[0], &cmd, 1) != 1)
+			_exit(1);
+		if (unshare(CLONE_NEWNS) < 0) {
+			sig = 'S';
+			if (write(to_parent[1], &sig, 1) != 1)
+				_exit(1);
+			_exit(CHILD_EXIT_SKIP);
+		}
+		sig = '2';
+		if (write(to_parent[1], &sig, 1) != 1)
+			_exit(1);
+
+		/* Wait until parent releases us. */
+		if (read(to_child[0], &cmd, 1) < 0)
+			_exit(1);
+		_exit(0);
+	}
+
+	close(to_child[0]);
+	to_child[0] = -1;
+	close(to_parent[1]);
+	to_parent[1] = -1;
+
+	if (read(to_parent[0], &sig, 1) != 1)
+		goto out_wait;
+	if (sig == 'S') {
+		pr_debug("SKIP: mount namespace operations not permitted\n");
+		ret = TEST_SKIP;
+		goto out_wait;
+	}
+	if (sig != '1')
+		goto out_wait;
+
+	/* File in child's tmpfs must not be visible on the host filesystem. */
+	if (access(target_bin, F_OK) == 0) {
+		pr_debug("child mount leaked to host namespace\n");
+		goto out_wait;
+	}
+
+	nsi = nsinfo__new_thread(child, child);
+	if (!nsi)
+		goto out_wait;
+	if (!nsinfo__need_setns(nsi) || nsinfo__mntns_ino(nsi) == 0) {
+		pr_debug("nsinfo did not detect differing mount namespace or inode\n");
+		goto out_wait;
+	}
+
+	if (has_exe_bid) {
+		if (filename__read_build_id_ns(target_bin, &ns_bid, nsi) <= 0 ||
+		    memcmp(&exe_bid, &ns_bid, sizeof(exe_bid)) != 0) {
+			pr_debug("failed to read build-id inside child mountns\n");
+			goto out_wait;
+		}
+	}
+
+	memset(&machine, 0, sizeof(machine));
+	if (machine__init(&machine, "", HOST_KERNEL_ID) != 0)
+		goto out_wait;
+
+	dso = machine__findnew_dso(&machine, target_bin);
+	if (!dso) {
+		machine__exit(&machine);
+		goto out_wait;
+	}
+	dso__set_nsinfo(dso, nsinfo__get(nsi));
+#ifndef HAVE_LIBELF_SUPPORT
+	/* Without libelf, filename__has_section() cannot auto-detect binary_type. */
+	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
+	dso__set_bintype_searched(dso);
+#endif
+	if (dso__data_read_offset(dso, &machine, 0, magic, sizeof(magic)) != sizeof(magic) ||
+	    memcmp(magic, "\x7f" "ELF", 4) != 0) {
+		pr_debug("failed to read ELF header from binary inside mountns\n");
+		dso__data_close(dso);
+		dso__put(dso);
+		dso = NULL;
+		machine__exit(&machine);
+		goto out_wait;
+	}
+	dso__data_close(dso);
+	dso__put(dso);
+	dso = NULL;
+
+	{
+		struct thread *cth = machine__findnew_thread(&machine, child, child);
+		struct map *map = NULL;
+		struct dso *ldso;
+
+		if (!cth) {
+			machine__exit(&machine);
+			goto out_wait;
+		}
+		map = map__new(&machine, 0x100000, 0xffffffff, 0, &dso_id_empty,
+			       PROT_EXEC, /*flags=*/0, target_bin, cth);
+		thread__put(cth);
+		if (!map) {
+			machine__exit(&machine);
+			goto out_wait;
+		}
+		ldso = map__dso(map);
+		if (dso__load(ldso, map) < 0 ||
+		    (has_exe_bid && (!dso__has_build_id(ldso) ||
+				     !dso__build_id_equal(ldso, &exe_bid)))) {
+			pr_debug("dso__load() failed inside child mountns\n");
+			map__put(map);
+			machine__exit(&machine);
+			goto out_wait;
+		}
+		map__put(map);
+	}
+	machine__exit(&machine);
+
+	/* Test ENOENT + nsinfo__check_proc() when child mountns overmounts /proc. */
+	sig = 'p';
+	if (write(to_child[1], &sig, 1) != 1 || read(to_parent[0], &sig, 1) != 1)
+		goto out_wait;
+	if (sig == 'p') {
+		bool check_ok;
+		char *resolved;
+
+		if (filename__read_build_id_ns("/nonexistent_proc_overmount_test",
+					       &ns_bid, nsi) >= 0) {
+			pr_debug("filename__read_build_id_ns() unexpectedly succeeded\n");
+			goto out_wait;
+		}
+		if (nsinfo__exited(nsi) || !nsinfo__need_setns(nsi) ||
+		    !nsinfo__check_proc(nsi)) {
+			pr_debug("overmounted /proc inside mountns falsely marked nsinfo exited\n");
+			goto out_wait;
+		}
+		nsinfo__mountns_enter(nsi, &nsc);
+		check_ok = nsinfo__check_proc(nsi);
+		nsinfo__mountns_exit(&nsc);
+		if (!check_ok || nsinfo__exited(nsi) ||
+		    !nsinfo__need_setns(nsi)) {
+			pr_debug("nsinfo__check_proc() failed after entering overmounted /proc\n");
+			goto out_wait;
+		}
+		dso = dso__new("/nonexistent_proc_overmount_test");
+		if (!dso)
+			goto out_wait;
+		dso__set_nsinfo(dso, nsinfo__get(nsi));
+		resolved = dso__filename_with_chroot(dso, "/nonexistent_proc_overmount_test");
+		dso__put(dso);
+		dso = NULL;
+		if (resolved != NULL) {
+			pr_debug("unexpected chroot prefix with overmounted /proc: %s\n",
+				 resolved);
+			free(resolved);
+			goto out_wait;
+		}
+		if (nsinfo__exited(nsi) || !nsinfo__need_setns(nsi)) {
+			pr_debug("dso__filename_with_chroot() falsely marked nsinfo exited\n");
+			goto out_wait;
+		}
+	}
+
+	/* Have the child unshare again so mntns_ino changes while staying alive. */
+	sig = 'n';
+	if (write(to_child[1], &sig, 1) != 1 || read(to_parent[0], &sig, 1) != 1)
+		goto out_wait;
+	if (sig == 'S') {
+		ret = TEST_SKIP;
+		goto out_wait;
+	}
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	nsinfo__mountns_exit(&nsc);
+	if (nsinfo__need_setns(nsi) || nsinfo__exited(nsi) || !nsinfo__check_proc(nsi)) {
+		pr_debug("mntns_ino change should clear need_setns without setting exited\n");
+		goto out_wait;
+	}
+
+	sig = 'q';
+	if (write(to_child[1], &sig, 1) != 1)
+		goto out_wait;
+	waitpid(child, &status, 0);
+	child = -1;
+
+	/* Once reaped, nsinfo__check_proc() must detect exit. */
+	if (nsinfo__check_proc(nsi) || !nsinfo__exited(nsi)) {
+		pr_debug("exited child still passed nsinfo__check_proc()\n");
+		goto out_wait;
+	}
+
+	/* Also verify chroot resolution when chroot(2) is permitted. */
+	if (test_chroot_resolution(chroot_dir, chroot_bin, has_exe_bid, &exe_bid) < 0)
+		goto out_wait;
+
+	ret = TEST_OK;
+out_wait:
+	if (child > 0) {
+		kill(child, SIGKILL);
+		waitpid(child, &status, 0);
+	}
+	nsinfo__put(nsi);
+	dso__put(dso);
+out_rmdir:
+	if (to_child[0] >= 0)
+		close(to_child[0]);
+	if (to_child[1] >= 0)
+		close(to_child[1]);
+	if (to_parent[0] >= 0)
+		close(to_parent[0]);
+	if (to_parent[1] >= 0)
+		close(to_parent[1]);
+	unlink(chroot_bin);
+	rmdir(chroot_dir);
+	unlink(target_bin);
+	rmdir(tmpdir);
+	return ret;
+}
+
+static int test__nsinfo_mountns(struct test_suite *test __maybe_unused,
+				int subtest __maybe_unused)
+{
+	int status;
+	pid_t pid;
+
+	if (geteuid() == 0)
+		return run_mountns_and_chroot_tests();
+
+	/* Run in a dedicated child so unshare(CLONE_NEWUSER) never mutates the caller. */
+	pid = fork();
+	if (pid < 0)
+		return TEST_FAIL;
+	if (pid == 0) {
+		int rc = run_mountns_and_chroot_tests();
+
+		if (rc == TEST_SKIP)
+			_exit(CHILD_EXIT_SKIP);
+		_exit(rc == TEST_OK ? 0 : 1);
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return TEST_FAIL;
+	if (!WIFEXITED(status))
+		return TEST_FAIL;
+	if (WEXITSTATUS(status) == CHILD_EXIT_SKIP)
+		return TEST_SKIP;
+	return WEXITSTATUS(status) == 0 ? TEST_OK : TEST_FAIL;
+}
+
+static struct test_case tests__namespaces[] = {
+	TEST_CASE("boot_id", nsinfo_boot_id),
+	TEST_CASE("init_and_copy", nsinfo_init_and_copy),
+	TEST_CASE("proc_and_recycled_tid", nsinfo_proc_and_recycled_tid),
+	TEST_CASE("thread_liveness", nsinfo_thread_liveness),
+	TEST_CASE("dso_needs_ns", nsinfo_dso_needs_ns),
+	TEST_CASE("mountns_and_chroot", nsinfo_mountns),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__namespaces = {
+	.desc = "Namespace and nsinfo tests",
+	.test_cases = tests__namespaces,
+};
diff --git a/tools/perf/tests/shell/header.sh b/tools/perf/tests/shell/header.sh
index e1628ac0a61401a7..ae3cd2b50d1c3437 100755
--- a/tools/perf/tests/shell/header.sh
+++ b/tools/perf/tests/shell/header.sh
@@ -37,6 +37,7 @@ check_header_output() {
     "sibling (cores|dies|threads)"
     "sibling threads"
     "total memory"
+    "boot id"
   )
   for i in "${fields[@]}"
   do
@@ -46,6 +47,14 @@ check_header_output() {
       err=1
     fi
   done
+
+  if [ -r /proc/sys/kernel/random/boot_id ]; then
+    host_boot_id=$(tr -d '\n' < /proc/sys/kernel/random/boot_id)
+    if ! grep -q "boot id : ${host_boot_id}" "${script_output}"; then
+      echo "Failed to find matching host boot id ${host_boot_id} in output"
+      err=1
+    fi
+  fi
 }
 
 test_file() {
diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index f4eb129afda2040f..9552bdf904656879 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -115,11 +115,32 @@ test_inject_bids() {
   echo "Inject ${inject_opt} build-ids test [Success]"
 }
 
+test_inject_boot_id() {
+  echo
+  echo "Inject boot-id pipe test"
+
+  if [ ! -r /proc/sys/kernel/random/boot_id ]; then
+    echo "Inject boot-id pipe test [Skipped - no /proc/sys/kernel/random/boot_id]"
+    return
+  fi
+
+  boot_id=$(cat /proc/sys/kernel/random/boot_id)
+  if ! perf record -e task-clock:u -o - ${prog} | perf inject -b | perf report -i - --header-only -I | grep -q "boot id : ${boot_id}"
+  then
+    echo "Inject boot-id pipe test [Failed - boot_id mismatch in pipe]"
+    err=1
+    return
+  fi
+
+  echo "Inject boot-id pipe test [Success]"
+}
+
 test_record_report
 test_inject_bids -B
 test_inject_bids -b
 test_inject_bids --buildid-all
 test_inject_bids --mmap2-buildid-all
+test_inject_boot_id
 
 cleanup
 exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index d9e0b5ad92a24aff..a3d9a3a5008d77c0 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -204,6 +204,7 @@ DECLARE_SUITE(util);
 DECLARE_SUITE(uncore_event_sorting);
 DECLARE_SUITE(subcmd_help);
 DECLARE_SUITE(kallsyms_split);
+DECLARE_SUITE(namespaces);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.56.1.831.g720f3f5937-goog

