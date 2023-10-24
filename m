Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFC3CD06
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn8jJcXA"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0EA10D1
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso5755609276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186261; x=1698791061; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JudBbpLKu9DuXeuHBT9WbAyZXtZgx6Ki97wXYqwU0f4=;
        b=Wn8jJcXA6Fcc8ZZdIe/342psqZ6dlwfGzMng4izWmLtVxwmxiHpO/a5Hh32LXlyUC+
         3ejotriifsZcJcDIe5eDtq50jIJxR9e1NdM9hwrB4QwHc61sU3bqoUlstdz1ZW8WFlXv
         LeiC77txrHDheLX/8g/R/Fsd6mtXc9k928SpPhlyTlxfTxZCstuGtrcgi5j9PZjlUmDG
         vVFcmAlsetjQxgRsKw3IrJ/lp9T/W8k932LqxfzBeBLuDDumiw2jXf6Ctozjwdq2yUQn
         bFADo9IwERtlRzKAHb3GJvs2fh3kLGeSVdEP/ecvvtqAyrzQFJhYLcGudx0MrXyOzRBN
         sNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186261; x=1698791061;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JudBbpLKu9DuXeuHBT9WbAyZXtZgx6Ki97wXYqwU0f4=;
        b=GlkjDZ0wSzoDIKXH2Eq6x6vMWa5JjuYP5harttTYXj+TY39wS4gUSqYEeIU8F1WvTY
         eat1C+csNwy1r+YtF2vrW0ATaXRQxzCo5SEXJipUggNkCcgd1If9X2PEqV2s2w22f4Nq
         s/vvUrcn0A3tzFRPPbGHxhr5iX6yI9M4ySeEaHNuNburRavG4/YJOfHGZautF7iUj5R7
         9uHZqVKGJwaI/d3UobXrQKy/NgQBi4GoEg3hcrpt8rdmGXk2RnmNVAgrA/OFM+NL4MKO
         lnbtGvXCb1UhDicbNBqJwHqhXj/oxzYmoHpDIAtPleipQ81a58XbhnJt6Exb7E/tucHl
         RVYg==
X-Gm-Message-State: AOJu0Yzd6RiHDBi4XcI7bqzNWc1UiMol4RUmSMom4AZ4YLQ5zVfIwWxO
	bMSU7g9erTwNjk700SoBaTYKooDb1fci
X-Google-Smtp-Source: AGHT+IF9LfkNPhdx45+6NQ08KOPcu7PNSPufjWnRsC2hWE9ceHk7S0CBFIGC4rvsbMjvH7/xXHIGSxirMRmI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:d386:0:b0:d9a:6b49:433d with SMTP id
 e128-20020a25d386000000b00d9a6b49433dmr242608ybf.6.1698186261582; Tue, 24 Oct
 2023 15:24:21 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:07 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 04/50] libperf rc_check: Add RC_CHK_EQUAL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Comparing pointers with reference count checking is tricky to avoid a
SEGV. Add a convenience macro to simplify and use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 7 +++++++
 tools/perf/builtin-sched.c                 | 2 +-
 tools/perf/tests/hists_link.c              | 4 ++--
 tools/perf/tests/thread-maps-share.c       | 9 ++++-----
 tools/perf/util/callchain.c                | 2 +-
 tools/perf/util/hist.c                     | 2 +-
 tools/perf/util/machine.c                  | 4 ++--
 tools/perf/util/sort.c                     | 2 +-
 tools/perf/util/symbol.c                   | 4 ++--
 9 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
index e88a6d8a0b0f..f80ddfc80129 100644
--- a/tools/lib/perf/include/internal/rc_check.h
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -54,6 +54,9 @@
 /* A put operation removing the indirection layer. */
 #define RC_CHK_PUT(object) {}
 
+/* Pointer equality when the indirection may or may not be there. */
+#define RC_CHK_EQUAL(object1, object2) (object1 == object2)
+
 #else
 
 /* Replaces "struct foo" so that the pointer may be interposed. */
@@ -101,6 +104,10 @@
 		}				\
 	} while(0)
 
+/* Pointer equality when the indirection may or may not be there. */
+#define RC_CHK_EQUAL(object1, object2) (object1 == object2 || \
+		(object1 && object2 && object1->orig == object2->orig))
+
 #endif
 
 #endif /* __LIBPERF_INTERNAL_RC_CHECK_H */
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9ab300b6f131..dd6065afbbaf 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1385,7 +1385,7 @@ static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
 {
 	pid_t l_tid, r_tid;
 
-	if (RC_CHK_ACCESS(l->thread) == RC_CHK_ACCESS(r->thread))
+	if (RC_CHK_EQUAL(l->thread, r->thread))
 		return 0;
 	l_tid = thread__tid(l->thread);
 	r_tid = thread__tid(r->thread);
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 2d19657ab5e0..5b6f1e883466 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -148,8 +148,8 @@ static int find_sample(struct sample *samples, size_t nr_samples,
 		       struct thread *t, struct map *m, struct symbol *s)
 {
 	while (nr_samples--) {
-		if (RC_CHK_ACCESS(samples->thread) == RC_CHK_ACCESS(t) &&
-		    RC_CHK_ACCESS(samples->map) == RC_CHK_ACCESS(m) &&
+		if (RC_CHK_EQUAL(samples->thread, t) &&
+		    RC_CHK_EQUAL(samples->map, m) &&
 		    samples->sym == s)
 			return 1;
 		samples++;
diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index faf980b26252..7fa6f7c568e2 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -46,9 +46,9 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 4);
 
 	/* test the maps pointer is shared */
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(maps) == RC_CHK_ACCESS(thread__maps(t1)));
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(maps) == RC_CHK_ACCESS(thread__maps(t2)));
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(maps) == RC_CHK_ACCESS(thread__maps(t3)));
+	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t1)));
+	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t2)));
+	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t3)));
 
 	/*
 	 * Verify the other leader was created by previous call.
@@ -73,8 +73,7 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	other_maps = thread__maps(other);
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(other_maps)), 2);
 
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(other_maps) ==
-					    RC_CHK_ACCESS(thread__maps(other_leader)));
+	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(other_maps, thread__maps(other_leader)));
 
 	/* release thread group */
 	thread__put(t3);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index aee937d14fbb..18d545c0629e 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1142,7 +1142,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 		if (al->map == NULL)
 			goto out;
 	}
-	if (RC_CHK_ACCESS(al->maps) == RC_CHK_ACCESS(machine__kernel_maps(machine))) {
+	if (RC_CHK_EQUAL(al->maps, machine__kernel_maps(machine))) {
 		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3dc8a4968beb..cde0078e6c90 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2142,7 +2142,7 @@ static bool hists__filter_entry_by_thread(struct hists *hists,
 					  struct hist_entry *he)
 {
 	if (hists->thread_filter != NULL &&
-	    RC_CHK_ACCESS(he->thread) != RC_CHK_ACCESS(hists->thread_filter)) {
+	    !RC_CHK_EQUAL(he->thread, hists->thread_filter)) {
 		he->filtered |= (1 << HIST_FILTER__THREAD);
 		return true;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e0e2c4a943e4..098600d983c5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -969,7 +969,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 	if (!map)
 		return 0;
 
-	if (RC_CHK_ACCESS(map) != RC_CHK_ACCESS(machine->vmlinux_map))
+	if (!RC_CHK_EQUAL(map, machine->vmlinux_map))
 		maps__remove(machine__kernel_maps(machine), map);
 	else {
 		struct dso *dso = map__dso(map);
@@ -2058,7 +2058,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread_rb_n
 	if (!nd)
 		nd = thread_rb_node__find(th, &threads->entries.rb_root);
 
-	if (threads->last_match && RC_CHK_ACCESS(threads->last_match) == RC_CHK_ACCESS(th))
+	if (threads->last_match && RC_CHK_EQUAL(threads->last_match, th))
 		threads__set_last_match(threads, NULL);
 
 	if (lock)
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6aa1c7f2b444..80e4f6132740 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -128,7 +128,7 @@ static int hist_entry__thread_filter(struct hist_entry *he, int type, const void
 	if (type != HIST_FILTER__THREAD)
 		return -1;
 
-	return th && RC_CHK_ACCESS(he->thread) != RC_CHK_ACCESS(th);
+	return th && !RC_CHK_EQUAL(he->thread, th);
 }
 
 struct sort_entry sort_thread = {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 96587fd7a5a2..822f4dcebfe6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -877,7 +877,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			*module++ = '\0';
 			curr_map_dso = map__dso(curr_map);
 			if (strcmp(curr_map_dso->short_name, module)) {
-				if (RC_CHK_ACCESS(curr_map) != RC_CHK_ACCESS(initial_map) &&
+				if (!RC_CHK_EQUAL(curr_map, initial_map) &&
 				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
 				    machine__is_default_guest(machine)) {
 					/*
@@ -1469,7 +1469,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 		list_del_init(&new_node->node);
 
-		if (RC_CHK_ACCESS(new_map) == RC_CHK_ACCESS(replacement_map)) {
+		if (RC_CHK_EQUAL(new_map, replacement_map)) {
 			struct map *map_ref;
 
 			map__set_start(map, map__start(new_map));
-- 
2.42.0.758.gaed0368e0e-goog

