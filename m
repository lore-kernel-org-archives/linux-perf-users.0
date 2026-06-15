Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8026ED33;
	Mon, 15 Jun 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559429; cv=none; b=XryPBDc5cPyS0qwW536b1EDCg95Kk+I3xvG3qxnPzP7sRexFkC0DBwKQImWYfzKMYvvnh+Nrz9499vSE+obMuywDukvrzjMFBmwF/3rpxcLA3SxGbRyVFqx3SICvdBRF8HgGM1LezwYpJTEXOBDAUC0TKnBzUqFSO57t7sDP1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559429; c=relaxed/simple;
	bh=vVvqpmLlRhJbv/MHXBAXoedXUejbXO4TlfUXXKFC1yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mssfLWLW/+4+Yedhdr8LfVq9y5TPJ85kluKEmMWEGgFQpOr5DL6R6fOv5Pn2LDt+J+9cKxYlFCYOykocY2fF9du2pBbmh+WUelEBwcwyW0xhMqr/y7AC1sG9msyGlfxG3oJrEMSUIWLglg6gYbatEpgw/5deTcgN16NH5yeFDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmCWmFoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmCWmFoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275551F00A3A;
	Mon, 15 Jun 2026 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781559428;
	bh=ZZ7Wse6DLRRqIaZGFPMmMSsP7jpbNmEcKHjwnsqkgt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hmCWmFoN/iPvuC1OdtikeEtkaz8qG3iNCtaJzI7OJJC8uvFwlWCWv0daj+D5q5vSl
	 cb3bl7eA/9Kn0zNRo3J4fJe4Gc8Nm3vH5ddrUYdQ74l917UxIcxQTez09nOyExaSgy
	 B6A1FS8YVySc9U8mNm1SezTPPGWkeVEQMBG8BsqoX2OhRBWXFthB5fxLhOGnolcBwa
	 sODx4ftUJHBfSB7/UklWtojxcIz6pJyJA6sZM6H3S5pHN0Myv95/0wwjsS0n9T8oFu
	 gYqLGX6COuq/waAciERBXydu8G7dfs832mFzNwNtSCYEDUoQrZx2d4/u5kwA2M2SkB
	 CX2X9kUOiJj5g==
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
Date: Mon, 15 Jun 2026 18:36:49 -0300
Message-ID: <20260615213657.35776-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615213657.35776-1-acme@kernel.org>
References: <20260615213657.35776-1-acme@kernel.org>
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
it too can propagate the error to perf_session__new() and test callers.

The error cleanup also used zfree(&machine->kmaps), but kmaps is a
refcounted maps structure — use maps__zput() to properly drop the
reference, matching machine__exit().

Fixes: 81f981d7ec43ed93 ("perf machine: Free root_dir in machine__init() error path")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/hists_cumulate.c    |  3 ++-
 tools/perf/tests/hists_filter.c      |  3 ++-
 tools/perf/tests/hists_link.c        |  3 ++-
 tools/perf/tests/hists_output.c      |  3 ++-
 tools/perf/tests/thread-maps-share.c |  2 +-
 tools/perf/util/machine.c            | 15 ++++++++++-----
 tools/perf/util/machine.h            |  2 +-
 tools/perf/util/session.c            |  4 +++-
 8 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 267cbc24691acd77..9f4d4e281e11edaa 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -723,7 +723,8 @@ static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subt
 		goto out;
 	err = TEST_FAIL;
 
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 002e3a4c1ca59b9d..fa47e995de82d427 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -131,7 +131,8 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
 		goto out;
 	err = TEST_FAIL;
 
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 996f5f0b3bd17fe5..05078dac93c4ec6b 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -303,7 +303,8 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
 		goto out;
 
 	err = TEST_FAIL;
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index fa683fd7b1e5ebb2..1ec51c15b1046eb4 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -610,7 +610,8 @@ static int test__hists_output(struct test_suite *test __maybe_unused, int subtes
 		goto out;
 	err = TEST_FAIL;
 
-	machines__init(&machines);
+	if (machines__init(&machines))
+		goto out;
 
 	/* setup threads/dso/map/symbols also */
 	machine = setup_fake_machine(&machines);
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
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 31715366e29ff704..7cf20ace3dbb5e55 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -124,11 +124,11 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 
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
@@ -138,7 +138,10 @@ static struct machine *__machine__new_host(struct perf_env *host_env, bool kerne
 	if (!machine)
 		return NULL;
 
-	machine__init(machine, "", HOST_KERNEL_ID);
+	if (machine__init(machine, "", HOST_KERNEL_ID) != 0) {
+		free(machine);
+		return NULL;
+	}
 
 	if (kernel_maps && machine__create_kernel_maps(machine) < 0) {
 		free(machine);
@@ -231,10 +234,12 @@ void machine__delete(struct machine *machine)
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
index 1a9a008ddda35120..26bacb6c1a572a62 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -160,7 +160,9 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	session->decomp_data.zstd_decomp = &session->zstd_data;
 	session->active_decomp = &session->decomp_data;
 	INIT_LIST_HEAD(&session->auxtrace_index);
-	machines__init(&session->machines);
+	if (machines__init(&session->machines))
+		goto out_delete;
+
 	ordered_events__init(&session->ordered_events,
 			     ordered_events__deliver_event, NULL);
 
-- 
2.54.0

