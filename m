Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9B3C279B;
	Tue, 16 Jun 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638247; cv=none; b=Q0xt91MZuCqXK7rdrxw6Xd9ssfy5XAwgrIZ46/bpe9Jqy8Jic9ddawJXe33ILKN0+abqTe2CoGHvRBcQMjRr0V4YzXQak4LQgz7HGROx1Kk6P2hANqcj7+Yg8WyNGatuuh1nm0Al8fFUSGAUcIShqMWZxgJF+967IRHJdq1gDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638247; c=relaxed/simple;
	bh=tk8Bousy+78P6P/mwsGgIMtgaE8cxbUtUTJmenm+Z7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1RjlUGOrMvKGktQ4WDh5v90wve0g6W9nRoNWcYQ8/Y4JE6qw5SlFWBENeyFvGqnmUmBR/d81QmQ+o1snIJTmclRqfs27Uy8N6OiypFpRYzv1ts1WBM6VYbFrbbrpgmunfh2em/ljo7AdIMllMM5kTkPtNgdaBIOQef0drVunR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdJPcoKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdJPcoKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B131F00A3A;
	Tue, 16 Jun 2026 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781638246;
	bh=9SehUfuVy3hGHIxBoZ/7dkoHz4RYmXildsCANCx8iDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FdJPcoKTuOqaTgPT8ojwS1hInzG8Ka0otzqleI56xWitBsqHo8Xmo18/nrGve4bqs
	 ltfO57W71t2MfLVaIsjV1zgQEFTRdkFoTa3/AWaJYYPT2qXDSVyj7gF8jVzTHOWnvK
	 4aJV3CRiDoRDX31GlA7Go8b50b+npXdVpB3GViH6NlSekXAbr2g4IMfKqgCxpOSh36
	 21n24NwO85bsXK4wWGD/8LlH01/K+WndxAzLtktRoZ5q1zED33o2myEMht/GEE6NNW
	 HG4qcQZ/sK9qlzcBbuU83+2pvzVxMSpY0pz6bgIFOf2tNZb0Pk1opT7pR/v4MThKs/
	 ShfBc/PuiG5sw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 1/9] perf machine: Propagate machine__init() error to callers
Date: Tue, 16 Jun 2026 16:30:25 -0300
Message-ID: <20260616193033.10035-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616193033.10035-1-acme@kernel.org>
References: <20260616193033.10035-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machine__init() always returns 0 even when memory allocation fails,
because commit 81f981d7ec43ed93 ("perf machine: Free root_dir in
machine__init() error path") introduced 'int err = -ENOMEM' and an
error cleanup path but left the final 'return 0' instead of
'return err'.

Fix by returning err, check the return value in __machine__new_host()
which was ignoring it, and change machines__init() from void to int so
it too can propagate the error to perf_session__new(), aslr_tool__init()
and test callers.

The error cleanup also used zfree(&machine->kmaps), but kmaps is a
refcounted maps structure — use maps__zput() to properly drop the
reference, matching machine__exit().

Move dsos__init() and threads__init() before the first fallible
allocation (maps__new) so that machine__exit() is safe to call on
any machine struct that machine__init() touched, even on early failure.

Fixes: 81f981d7ec43ed93 ("perf machine: Free root_dir in machine__init() error path")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/hists_cumulate.c    |  5 +++--
 tools/perf/tests/hists_filter.c      |  5 +++--
 tools/perf/tests/hists_link.c        |  5 +++--
 tools/perf/tests/hists_output.c      |  5 +++--
 tools/perf/tests/kallsyms-split.c    |  7 +++++--
 tools/perf/tests/thread-maps-share.c |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c  |  8 +++++---
 tools/perf/util/aslr.c               | 12 +++++++++---
 tools/perf/util/machine.c            | 24 ++++++++++++++----------
 tools/perf/util/machine.h            |  2 +-
 tools/perf/util/session.c            |  7 ++++---
 11 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 267cbc24691acd77..09ee08085b06b14f 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -704,7 +704,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
 static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
-	struct machines machines;
+	struct machines machines = { 0 };
 	struct machine *machine;
 	struct evsel *evsel;
 	struct evlist *evlist = evlist__new();
@@ -723,7 +723,8 @@ static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subt
 		goto out;
 	err = TEST_FAIL;
 
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 002e3a4c1ca59b9d..ac5affb7afff11be 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -116,7 +116,7 @@ static void put_fake_samples(void)
 static int test__hists_filter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
-	struct machines machines;
+	struct machines machines = { 0 };
 	struct machine *machine;
 	struct evsel *evsel;
 	struct evlist *evlist = evlist__new();
@@ -131,7 +131,8 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 		goto out;
 	err = TEST_FAIL;
 
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 996f5f0b3bd17fe5..e55990163865e66f 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -287,7 +287,7 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 {
 	int err = -1;
 	struct hists *hists, *first_hists;
-	struct machines machines;
+	struct machines machines = { 0 };
 	struct machine *machine = NULL;
 	struct evsel *evsel, *first;
 	struct evlist *evlist = evlist__new();
@@ -303,7 +303,8 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 		goto out;
 
 	err = TEST_FAIL;
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index fa683fd7b1e5ebb2..5e59dba92e8132a3 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -590,7 +590,7 @@ static int test5(struct evsel *evsel, struct machine *machine)
 static int test__hists_output(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
-	struct machines machines;
+	struct machines machines = { 0 };
 	struct machine *machine;
 	struct evsel *evsel;
 	struct evlist *evlist = evlist__new();
@@ -610,7 +610,8 @@ static int test__hists_output(struct test_suite *test __maybe_unused, int subtes
 		goto out;
 	err = TEST_FAIL;
 
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsyms-split.c
index 117ed3b70f630a97..244daa01bd5d85fb 100644
--- a/tools/perf/tests/kallsyms-split.c
+++ b/tools/perf/tests/kallsyms-split.c
@@ -97,7 +97,7 @@ static int create_proc_dir(void)
 static int test__kallsyms_split(struct test_suite *test __maybe_unused,
 				int subtest __maybe_unused)
 {
-	struct machine m;
+	struct machine m = { 0 };
 	struct map *map = NULL;
 	int ret = TEST_FAIL;
 
@@ -113,7 +113,10 @@ static int test__kallsyms_split(struct test_suite *test __maybe_unused,
 	signal(SIGTERM, remove_proc_dir);
 
 	pr_debug("create kernel maps from the fake root directory\n");
-	machine__init(&m, root_dir, HOST_KERNEL_ID);
+	if (machine__init(&m, root_dir, HOST_KERNEL_ID)) {
+		pr_debug("FAIL: failed to init machine\n");
+		goto out;
+	}
 	if (machine__create_kernel_maps(&m) < 0) {
 		pr_debug("FAIL: failed to create kernel maps\n");
 		goto out;
diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index e9ecd30a5c058076..0431bff31b3a18c3 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -27,7 +27,7 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	 * other  group (pid: 4, tids: 4, 5)
 	*/
 
-	machines__init(&machines);
+	TEST_ASSERT_VAL("failed to init machines", machines__init(&machines) == 0);
 	machine = &machines.host;
 
 	/* create process with 4 threads */
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7409abe4aa3692ea..9396c8a77c863718 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -192,7 +192,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	struct rb_node *nd;
 	struct symbol *sym;
 	struct map *kallsyms_map;
-	struct machine vmlinux;
+	struct machine vmlinux = { 0 };
 	struct maps *maps;
 	u64 mem_start, mem_end;
 	struct test__vmlinux_matches_kallsyms_cb_args args;
@@ -203,8 +203,10 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * Init the machines that will hold kernel, modules obtained from
 	 * both vmlinux + .ko files and from /proc/kallsyms split by modules.
 	 */
-	machine__init(&args.kallsyms, "", HOST_KERNEL_ID);
-	machine__init(&vmlinux, "", HOST_KERNEL_ID);
+	if (machine__init(&args.kallsyms, "", HOST_KERNEL_ID))
+		goto out;
+	if (machine__init(&vmlinux, "", HOST_KERNEL_ID))
+		goto out;
 
 	maps = machine__kernel_maps(&vmlinux);
 
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index a946fff2ac4dd4b4..6a7542e7db827d1b 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -1237,12 +1237,13 @@ void aslr_tool__strip_attr_event(union perf_event *event, struct evlist *evlist)
 	}
 }
 
-static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
+static int aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 {
 	delegate_tool__init(&aslr->tool, delegate);
 	aslr->tool.tool.ordered_events = true;
 
-	machines__init(&aslr->machines);
+	if (machines__init(&aslr->machines))
+		return -ENOMEM;
 
 	hashmap__init(&aslr->remap_addresses,
 		      remap_addresses__hash, remap_addresses__equal,
@@ -1276,6 +1277,8 @@ static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 	aslr->tool.tool.auxtrace = aslr_tool__process_auxtrace;
 	aslr->tool.tool.auxtrace_info = aslr_tool__process_auxtrace_info;
 	aslr->tool.tool.auxtrace_error = aslr_tool__process_auxtrace_error;
+
+	return 0;
 }
 
 struct perf_tool *aslr_tool__new(struct perf_tool *delegate)
@@ -1285,7 +1288,10 @@ struct perf_tool *aslr_tool__new(struct perf_tool *delegate)
 	if (!aslr)
 		return NULL;
 
-	aslr_tool__init(aslr, delegate);
+	if (aslr_tool__init(aslr, delegate)) {
+		free(aslr);
+		return NULL;
+	}
 	return &aslr->tool.tool;
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 31715366e29ff704..9329d319bd033699 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -79,15 +79,14 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	int err = -ENOMEM;
 
 	memset(machine, 0, sizeof(*machine));
-	machine->kmaps = maps__new(machine);
-	if (machine->kmaps == NULL)
-		return -ENOMEM;
-
 	RB_CLEAR_NODE(&machine->rb_node);
 	dsos__init(&machine->dsos);
-
 	threads__init(&machine->threads);
 
+	machine->kmaps = maps__new(machine);
+	if (machine->kmaps == NULL)
+		goto out;
+
 	machine->vdso_info = NULL;
 	machine->env = NULL;
 
@@ -124,11 +123,11 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 
 out:
 	if (err) {
-		zfree(&machine->kmaps);
+		maps__zput(machine->kmaps);
 		zfree(&machine->root_dir);
 		zfree(&machine->mmap_name);
 	}
-	return 0;
+	return err;
 }
 
 static struct machine *__machine__new_host(struct perf_env *host_env, bool kernel_maps)
@@ -138,7 +137,10 @@ static struct machine *__machine__new_host(struct perf_env *host_env, bool kerne
 	if (!machine)
 		return NULL;
 
-	machine__init(machine, "", HOST_KERNEL_ID);
+	if (machine__init(machine, "", HOST_KERNEL_ID) != 0) {
+		free(machine);
+		return NULL;
+	}
 
 	if (kernel_maps && machine__create_kernel_maps(machine) < 0) {
 		free(machine);
@@ -231,10 +233,12 @@ void machine__delete(struct machine *machine)
 	}
 }
 
-void machines__init(struct machines *machines)
+int machines__init(struct machines *machines)
 {
-	machine__init(&machines->host, "", HOST_KERNEL_ID);
+	int err = machine__init(&machines->host, "", HOST_KERNEL_ID);
+
 	machines->guests = RB_ROOT_CACHED;
+	return err;
 }
 
 void machines__exit(struct machines *machines)
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index aaddfb70ea665452..26f9827062f5eb5b 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -152,7 +152,7 @@ struct machines {
 	struct rb_root_cached guests;
 };
 
-void machines__init(struct machines *machines);
+int machines__init(struct machines *machines);
 void machines__exit(struct machines *machines);
 
 void machines__process_guests(struct machines *machines,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1a9a008ddda35120..f391a822480db001 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -160,11 +160,12 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	session->decomp_data.zstd_decomp = &session->zstd_data;
 	session->active_decomp = &session->decomp_data;
 	INIT_LIST_HEAD(&session->auxtrace_index);
-	machines__init(&session->machines);
+	perf_env__init(&session->header.env);
+	if (machines__init(&session->machines))
+		goto out_delete;
+
 	ordered_events__init(&session->ordered_events,
 			     ordered_events__deliver_event, NULL);
-
-	perf_env__init(&session->header.env);
 	if (data) {
 		ret = perf_data__open(data);
 		if (ret < 0)
-- 
2.54.0

