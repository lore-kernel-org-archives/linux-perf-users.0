Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA1550DA3;
	Tue, 13 Oct 2026 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922518; cv=none; b=gDlwcR0cNMDCLZEVC69/luA0MiEsuMOG49OniG00s8cnBEWo4a3lehx5O1CaOI2taeUBQbCZOR61yCcusKsSzC2RkiuDal5lgprZeL39RjruiAMYwoI6XcAby6MBf9eeewaoqwyANpE6Ns8+/j7POb5RkE35gCyQj4IuH8lOiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922518; c=relaxed/simple;
	bh=LvIIektRJ6zWQgpnDbNNAGO7y+H0AlXggVtf1PrEIr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCJSOecg6+3Ue8dg+XSrR4EmAkkyYuQeMPh2OI4EdS+SeEfM83Yw4LQ5HWD++vtLPCTpgLeQGPypT+DMKJL7pb86GsRFDEJwk4/fk/FdynUtfXPC2XOZVInu7GpgZ6tcT6m1Gq4g3yhdwmQwoCRcq9RUi2ee7G+ICzxu62ghkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkQ8rIt6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkQ8rIt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35DD1F00898;
	Tue, 13 Oct 2026 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922515;
	bh=4AkBF9FQzFUndSNeNoNZVnCsbgmV4lpHBU2ylSj82H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mkQ8rIt6u6IPoAOpLtPDE8r6GQBSTXqJfD+U2TRpSzDc8M+4Yz8nKKpPGf370yo0z
	 pvJ7WKlkLK9QliOZRSOZhY1LF9RnW7hF5owGWvLZ5hpANDGNcpSAy+8pwHAzriBmu+
	 LUWjQbW9ntz3Xd1ldQ9Vg4tgKnF2gimadGOB4Lbh2mTESGJxcHtdCnRgQtKoWo/KTM
	 PJVCXZvW9I5ZOxDsZ8Z/2EYOG1O3zDylwTNIyL5DzwDMVflw5hvGH4Wash/MgE4eIk
	 UfqVv47h1D5o9zOU6d8elcFqK77T9hfWHB/4R7C6kfK0d/qxH2N4IecJ45ea98j5kO
	 6/yG9Kr/8YVAw==
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
Subject: [PATCH v2 17/19] perf test: Take turns using the perf mlock budget in the mmaping tests
Date: Tue, 13 Oct 2026 17:14:12 -0300
Message-ID: <20261013201415.36428-18-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
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
the kernel marks the mutex owner-died and the next locker takes it over.

Perf's struct mutex is used, so the lock discipline is checked in clang
builds via -Wthread-safety; as the thread safety analysis can't verify
conditionally held locks, the tests that map ring buffers run through a
helper taking the mutex unconditionally around the test function call.

Robust mutexes aren't always available, at build time or, as glibc and
musl can do when get_robust_list(2)/set_robust_list(2) aren't usable, at
run time: in that case the budget is not shared and the tests run as
before, failing or skipping on starvation instead of hanging on a lock
left behind by a test killed by a signal.

The area is shared by the tests of one 'perf test' invocation only: a
second invocation running at the same time maps its own, so the two
don't take turns with each other.

The sysctl is left alone.  Growing it, to leave room for whatever else
the user has running, would need the original value shared between the
invocations, so that the last one out puts it back, and it only helps a
user who can write the sysctl but lacks CAP_IPC_LOCK, the one capability
that lifts the limit.

None of this is done when just one of the selected tests maps ring
buffers, as there is nothing to share the budget with in that case.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 94 ++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index acffa0d0d33d6d30..8d6e652d3af25afe 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -32,6 +32,9 @@
 #include <subcmd/parse-options.h>
 #include <subcmd/run-command.h>
 
+#include <signal.h>
+#include <sys/mman.h>
+
 #include "builtin.h"
 #include "color.h"
 #include "config.h"
@@ -42,6 +45,7 @@
 #include "symbol.h"
 #include "tests-scripts.h"
 #include "tests.h"
+#include "util/mutex.h"
 #include "util/rlimit.h"
 #include "util/strbuf.h"
 #include "util/term.h"
@@ -62,6 +66,17 @@ static bool list_requisites;
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
@@ -378,12 +393,30 @@ static void child_test_sig_handler(int sig)
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
@@ -400,7 +433,12 @@ static int run_test_child(struct child_process *process)
 
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
@@ -1776,6 +1814,59 @@ static struct test_suite **build_suites(void)
 #undef for_each_suite
 }
 
+static bool perf_test__shares_mlock_budget(struct test_suite **suites, int argc,
+					   const char *argv[], struct intlist *skiplist)
+{
+	int sharing = 0;
+
+	/* Nothing to share the budget with if just one test maps ring buffers. */
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
+static void perf_test__setup_mlock_budget(struct test_suite **suites, int argc,
+					  const char *argv[], struct intlist *skiplist)
+{
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
+		pr_debug("Robust mutexes aren't available, not taking turns using the perf mlock budget\n");
+	}
+}
+
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
@@ -1884,6 +1975,7 @@ int cmd_test(int argc, const char **argv)
 		intlist__delete(skiplist);
 		return err ? -err : -ENOMEM;
 	}
+	perf_test__setup_mlock_budget(suites, argc, argv, skiplist);
 	ret = __cmd_test(suites, argc, argv, skiplist);
 	free(suites);
 	intlist__delete(skiplist);
-- 
2.55.0

