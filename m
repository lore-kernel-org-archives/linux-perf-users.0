Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D092D0C82;
	Fri, 16 Oct 2026 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109983; cv=none; b=mGlcbnXZS550Ku2/54BJM6JSg3XuycEonHPFJHExFc8Dz+thppkp92SAQvH0qCzVpcBQc2+FHCr5Xd7CJ6A9xmIK4Xbh8T99gCLnGFU/xI8z0VBLEx/o0yS+ZOApaMQP3B8gy4aJu1N+GkXcg+u1aV3zYmEODRqkjg9/nTCE4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109983; c=relaxed/simple;
	bh=tYuNntQX+VhkyDnGRpMnXXJ0cS/bk4g8fFPdVnAK2cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQVgkWekDlvjEt0GWdidzugun8kYu5t/0l0b21Zpr9mJ76448yVl9hyZzueDITTdPRPnw4qHYUZd+R7yGVEiikhGJeLjKThpLrq4h7sScFirhiUifd7kD5bW7VXQbxQTlehIG0ybsFG8rFlGaZUjUHIqZfDZzsCC2Vdx2J9rpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMGAG4mS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMGAG4mS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8501F000C5;
	Fri, 16 Oct 2026 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109982;
	bh=WAIR/akJxd95Ix6TcjTLIgVZ1vucr1GFD1U3jTzatP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMGAG4mSSzsARkORkehZvMMq5sgiU7NvRB4QMmPPxnARTiNUuOxaVK6wH2DUW7HnQ
	 7jef0EnQEt6G8Jtem5LnJCicfYdF3O9uyUe6GlUne02VVMpDYQ/TbvoUlDVxJbbIvI
	 ee4FGt5js9EVrFTgl0k0QFa2cBGeYN/okECGQM3/dxuf9/Kq5rRpTQdsQV+wd+2kXe
	 stRekfu6FY+euPh+BP0FVIVRkaIN4y8Y0mpKx0LcLr8Y/UiJi0NObRobBGoRoavBwn
	 bT2/1DjiFbQ6JwTbq9CehSOwZHOHH4OSrhrbBP8YorQhBlqXaQHDzHRuAlB8XNPVqa
	 biTMpsWEMei3g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 19/19] perf test: Take turns using the perf mlock budget in the mmaping tests
Date: Thu, 15 Oct 2026 21:18:43 -0300
Message-ID: <20261016001843.71978-20-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The mmap size used when none is asked for is derived from
kernel.perf_event_mlock_kb itself (see perf_event_mlock_kb_in_pages()),
that after rounding down to a power of two number of pages ends up being
about all of a single CPU's share of that per user budget, so with 'perf
test' starting all the selected tests at once, any further mapping done
while another test still has its ring buffers mapped fails with:

  Permission error mapping pages.
  Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
  or try again with a smaller value of -m/--mmap_pages.

that then shows up as a failure or, worse, as an "unsupp" skip in tests
like the attr ones, i.e. as a false pass.

Instead of making those tests exclusive, which would serialize them
against every other test, keep them running in parallel with the tests
that don't map ring buffers and have them take turns using the budget,
via a robust, process-shared mutex (see mutex_init_pshared_robust()) in
a MAP_SHARED|MAP_ANONYMOUS area that is inherited by the forked test
processes: a test killed by a signal doesn't leave the budget locked,
the kernel marks the mutex owner-died and the next locker takes it over;
a signal that is caught rather than kills ends up the same way, with the
longjmp out of child_test_sig_handler() leaving it held until the child
exits and the kernel hands it over.

Perf's struct mutex is used, so the lock discipline is checked in clang
builds via -Wthread-safety; as the thread safety analysis can't verify
conditionally held locks, the tests that map ring buffers run through a
helper taking the mutex unconditionally around the test function call.

Robust mutexes aren't always available, at build time or, as glibc and
musl can do when get_robust_list(2)/set_robust_list(2) aren't usable, at
run time: in that case the budget is not shared and the tests run as
before, failing or skipping on starvation instead of hanging on a lock
left behind by a test killed by a signal.

Taking turns is unnecessary when nothing can exhaust the budget: once it is
spent, whatever maps on top of it is charged against RLIMIT_MEMLOCK and the
mapping is refused with EPERM when that runs out too, but only for the
processes the kernel is paranoid about and that have no CAP_IPC_LOCK to
lift the check, see perf_mmap_calc_limits().  Root, then, has no turns to
take: it never has a mapping refused, so the turnstile only buys it the
wall clock cost measured below, for a budget nothing is contending for.

The area is shared by the tests of one 'perf test' invocation only: a
second invocation running at the same time maps its own, so the two
don't take turns with each other.

The sysctl is left alone.  Growing it, to leave room for whatever else
the user has running, would need the original value shared between the
invocations, so that the last one out puts it back, and it only helps a
user who can write the sysctl but lacks CAP_IPC_LOCK, the one capability
that lifts the limit.

Raising the soft RLIMIT_MEMLOCK to the hard one when a mapping is refused
is left for a follow-up: it would buy back the wall clock above without
taking turns, where the hard limit allows the raise.

None of this is done when just one of the selected tests maps ring
buffers, as there is nothing to share the budget with in that case.

Taking turns isn't free: a test that hangs while holding the budget now
holds with it every other test mapping ring buffers, where before it
would fail, or skip, by itself.  And there is a cost even when nothing
goes wrong, this being the whole suite on a Ryzen 9 9950X3D, kernel 7.2.7,
32 CPUs, with the default 516 KiB budget, before and after taking turns:

  budget not shared:   42 s wall clock,  72 tests Ok, 28 failed
  tests take turns:   133 s wall clock, 101 tests Ok, 10 failed

Both are non-root runs of the whole series applied, the shell test markings
included, and none of the ten failures is about the budget: eight of them
pass as root, where it can't be exhausted, and the two that fail there too,
the addr2line inline unwinding one, with no branch stack sampling to ask
this machine for, and the BPF metadata collection one, whose output isn't
what the test expects, are not budget related either.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-test.txt |   5 +-
 tools/perf/tests/builtin-test.c        | 129 ++++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 156c6e8caa75f153..f66ccd77bfe749e4 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -29,8 +29,9 @@ REQUISITES
 ----------
 Shell tests run perf, that maps ring buffers, so they are taken to need room
 in the per user budget set in kernel.perf_event_mlock_kb, shared by the tests
-running at the same time.  Tests state what they need, or waive, in a comma
-separated list in the parens ending their description line, e.g.:
+running at the same time, that take turns using it.  Tests state what they
+need, or waive, in a comma separated list in the parens ending their
+description line, e.g.:
 
 	# perf stat tests (no_mlock)
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index acffa0d0d33d6d30..fb8b6d77b5cdd396 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -32,6 +32,8 @@
 #include <subcmd/parse-options.h>
 #include <subcmd/run-command.h>
 
+#include <sys/mman.h>
+
 #include "builtin.h"
 #include "color.h"
 #include "config.h"
@@ -42,6 +44,9 @@
 #include "symbol.h"
 #include "tests-scripts.h"
 #include "tests.h"
+#include "util/cap.h"
+#include "util/event.h"
+#include "util/mutex.h"
 #include "util/rlimit.h"
 #include "util/strbuf.h"
 #include "util/term.h"
@@ -62,6 +67,17 @@ static bool list_requisites;
 static unsigned int runs_per_test = 1;
 /* Number of lines to include in failure snippet. */
 static unsigned int failure_snippet_lines = 10;
+/*
+ * The tests mapping ring buffers take turns using their share of
+ * kernel.perf_event_mlock_kb via this mutex, shared with the forked test
+ * processes and robust so that a test killed while holding it doesn't leave
+ * the budget locked, see mutex_init_pshared_robust().
+ */
+struct mlock_budget {
+	struct mutex lock;
+};
+
+static struct mlock_budget *mlock_budget;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 static const char *workload_control;
@@ -378,12 +394,30 @@ static void child_test_sig_handler(int sig)
 	siglongjmp(run_test_jmp_buf, sig);
 }
 
+static int run_test_case(struct child_test *child)
+{
+	return test_function(child->test, child->test_case_num)(child->test, child->test_case_num);
+}
+
+/* The thread safety analysis can't express a lock held conditionally. */
+static int run_test_case_mlocked(struct child_test *child)
+{
+	int err;
+
+	mutex_lock(&mlock_budget->lock);
+	err = run_test_case(child);
+	mutex_unlock(&mlock_budget->lock);
+
+	return err;
+}
+
 static int run_test_child(struct child_process *process)
 {
 	const int signals[] = {
 		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
 	};
 	struct child_test *child = container_of(process, struct child_test, process);
+	bool needs_mlock = mlock_budget && child->test->needs_mlock;
 	int err;
 
 	close_parent_fds();
@@ -400,7 +434,12 @@ static int run_test_child(struct child_process *process)
 
 	pr_debug("---- start ----\n");
 	pr_debug("test child forked, pid %d\n", getpid());
-	err = test_function(child->test, child->test_case_num)(child->test, child->test_case_num);
+
+	if (needs_mlock)
+		err = run_test_case_mlocked(child);
+	else
+		err = run_test_case(child);
+
 	pr_debug("---- end(%d) ----\n", err);
 
 	check_leaks();
@@ -1776,6 +1815,92 @@ static struct test_suite **build_suites(void)
 #undef for_each_suite
 }
 
+static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
+					   const char *argv[], struct intlist *skiplist)
+{
+	int sharing = 0;
+
+	/* The selection rules mirrored here are __cmd_test()'s: when they change, change both. */
+	for (int curr_suite = 0; suites[curr_suite]; curr_suite++) {
+		struct test_suite *t = suites[curr_suite];
+		int curr_test_case;
+		bool suite_matched;
+
+		if (!t->needs_mlock || intlist__find(skiplist, curr_suite + 1))
+			continue;
+
+		suite_matched = perf_test__matches(test_description(t, /*test_case=*/-1),
+						   curr_suite, argc, argv);
+		test_suite__for_each_test_case(t, curr_test_case) {
+			if (test_exclusive(t, curr_test_case))
+				continue;
+
+			if (suite_matched ||
+			    perf_test__matches(test_description(t, curr_test_case),
+					       curr_suite, argc, argv))
+				sharing += runs_per_test;
+		}
+		if (sharing > 1)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Once the per user budget set in kernel.perf_event_mlock_kb is spent, what
+ * maps on top of it is charged against RLIMIT_MEMLOCK and the mapping is
+ * refused with EPERM when that runs out too, but only for the processes the
+ * kernel is paranoid about and that have no CAP_IPC_LOCK to lift the check,
+ * see perf_mmap_calc_limits() in the kernel: used by
+ * perf_test__setup_mlock_budget() below, that has nothing to take turns on
+ * when neither applies.
+ */
+static bool perf_test__mlock_budget_exhaustible(void)
+{
+	if (perf_cap__capable(CAP_IPC_LOCK))
+		return false;
+
+	return perf_event_paranoid() > -1;
+}
+
+static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
+					  const char *argv[], struct intlist *skiplist)
+{
+	/* Nothing can be denied the budget, nothing to take turns for. */
+	if (!perf_test__mlock_budget_exhaustible()) {
+		pr_debug("Not taking turns using the perf mlock budget: nothing can exhaust it\n");
+		return;
+	}
+
+	/* Nothing runs at the same time, nothing to share the budget with. */
+	if (sequential || !perf_test__shares_mlock_budget(suites, argc, argv, skiplist))
+		return;
+
+	mlock_budget = mmap(NULL, sizeof(*mlock_budget), PROT_READ | PROT_WRITE,
+			    MAP_SHARED | MAP_ANONYMOUS, /*fd=*/-1, /*offset=*/0);
+	if (mlock_budget == MAP_FAILED) {
+		mlock_budget = NULL;
+		pr_err("Failed to map the shared area used to take turns using the perf mlock budget\n");
+		return;
+	}
+
+	if (!mutex_init_pshared_robust(&mlock_budget->lock)) {
+		munmap(mlock_budget, sizeof(*mlock_budget));
+		mlock_budget = NULL;
+		pr_debug("Not taking turns using the perf mlock budget\n");
+	}
+}
+
+static void perf_test__teardown_mlock_budget(void)
+{
+	if (!mlock_budget)
+		return;
+
+	mutex_destroy(&mlock_budget->lock);
+	munmap(mlock_budget, sizeof(*mlock_budget));
+	mlock_budget = NULL;
+}
+
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
@@ -1884,7 +2009,9 @@ int cmd_test(int argc, const char **argv)
 		intlist__delete(skiplist);
 		return err ? -err : -ENOMEM;
 	}
+	perf_test__setup_mlock_budget(suites, argc, argv, skiplist);
 	ret = __cmd_test(suites, argc, argv, skiplist);
+	perf_test__teardown_mlock_budget();
 	free(suites);
 	intlist__delete(skiplist);
 	return ret;
-- 
2.55.0

