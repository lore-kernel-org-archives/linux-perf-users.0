Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447775;
	b=hnlPNXbPyPDmTKFaGQr7MmH+XI47VCbBRQJ5s24OM2sEfCQSkNkxKynP4e/q1TvijVtl
	 MXxtU9uy2lV9bSWtYsjoJsRtkOUn1FMjQ3kjwXS+nOzVlAmp8jTKLCLWA6iMRthrazBDQ
	 4AtEtQN5fATkq0Q3SHSjeHBZfgwLR6OLMOvTnjJkdvmiQ1RPiUlE+3YfptXb6zCS/Tui9
	 F7pdBLBG8upfMN3zzlwiXvTNM8X8fTU3bzM9P6Es90rNWnc9hGQE6ZTAYuOv6D/Yf7PQB
	 kSXXZ/m/J/NesbNAGdF13KSfNgeRJuK8ldWsKb7xGCenRyK8B6PWvbsbRQCjd+JwCzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ez0sBtW/aXAY60CLvQQn9ZSDvDfeSletdmhwTWVxkOI=;
	b=hieiffD3zFLIH8rzYBwNHArBxqDHSXl6kFjF678AyLyCfaElF4Zp2g6uMvEf6FM1UTKS
	 0Uback2w9f2NPfIJxWmM8ydD3XP0xIJCntXTgrfy4hkDawPM8NStpqn4HKLIBygFUp8TB
	 1qMsxFWkmRatSgdWy+T/VaAFUXriXJMRXyQ/U5MScx1HhOH/B6gDf442CxBxBE78EtIxR
	 J6dYe4VtLCplegFTeDfDddD5Jz3fB6mdErlLBr2LW54Id44kuYJYwExM4U5217jU3xgob
	 Ihqy7r68YcLAGanNyO+wGnt35SHIIpqVhpXV5oaRdUxYALDaKkJKqq18OwTDAP47Y3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VEC7N9cG;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61798606A32C
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61798606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VEC7N9cG
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso6601259eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792447774; x=1793052574; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ez0sBtW/aXAY60CLvQQn9ZSDvDfeSletdmhwTWVxkOI=;
        b=VEC7N9cGN9GfZCXNJ6hWqNGH9oh+iKqJR6x6TgeC1f+/6v3oCZmhFSjxcJHMCRJ/bu
         mhVamcmT41aDnhqC9RyT6QnqUlrlnymmChqTsQBadNHldIBSMXPB8+kftIkwFJ02M2TV
         /bxlHa8OIYJvPHnTAGXmQv67yNeFfuH+kqKuI6kuvej3PRFbNocAQRfGgEuv6eQ1Aaai
         yDWYkYTaYksuxydVawX2HVTyIdYD2QaVkfaZyP/PzSD6bJdHODhBGd0Xe0wAtEUXNW87
         Gw1wyRuQzEKOCwnIr17aRHS6CzFYZjTvtP1iZnQHSQUkjU1TD2CcG8VClB2TFReTmxQM
         08Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792447774; x=1793052574;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ez0sBtW/aXAY60CLvQQn9ZSDvDfeSletdmhwTWVxkOI=;
        b=NW2nBjzTKxeQiUtAMEfHjON6S3m1h+S6FRMOr5tqkcvPSuucGqTF8XlGJ8TDdJ629m
         DR5G2GGnaRdOwxAAFbGururZaSt4fxEmNuPOQRiQPw/RDwxkCxHO3jwW/IjY7TYKbmlB
         kx9tgDqvIhCrZKPVqoyZcP/kEAzZDxfvboRtkinnOtl3fmWaUB1hfjwjB41MIlXpXolI
         BuyiOy8a6s/whoZZoX9+etvtt7QA8ifIEfMgDzXeWHJPBi2e58EeXZUwdwenoirxwawC
         Dfj8NlbJIt60UdsRI+HbmTk5I/AzFEsSkMQ2sABqtbP3rtZQ3sFjQkS4iPMLfzlbk3SS
         PwHg==
X-Forwarded-Encrypted: i=1; AKwUvBzDqmdBuBhL0wWRV2/Vjq0IoQVcg06vIiK0BPQVg5MiK0BUPBwJEZhO8kSRr4meHxxhQ/2g5Gi/VJny3dPxDQ0F@vger.kernel.org
X-Gm-Message-State: AFq9FYIi8n5Sate2cDi2IPhe+lS82q+dbgv/s7S0eQmOoswFnOphuJbk
	Ce/lneicsiVW5JgPMtXG41hRTFmxY0EgOb88XPvDeSOVheM0On6w8upL2xl6E8e8DeYdHYBMsU2
	EgxHnnWgQdQ==
X-Received: from dycmq10.prod.google.com ([2002:a05:7301:78a:b0:358:eddb:1107])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:638d:20b0:35b:cb8a:8d0e
 with SMTP id 5a478bee46e88-361a18634c7mr12810201eec.16.1792447774003; Mon, 19
 Oct 2026 15:09:34 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:09:13 -0700
In-Reply-To: <20261019220915.3943592-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261018053710.2572636-1-irogers@google.com> <20261019220915.3943592-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019220915.3943592-6-irogers@google.com>
Subject: [PATCH v4 5/7] perf test: Add tests for lock_held() BPF sample filter
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, eranian@google.com, 
	ddhariwal@google.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add unit tests in parse-events.c for parsing lock_held(),
lock_held_read(), and lock_held_exclusive() BPF filter expressions
(standalone predicates, negated predicates, and compound group
expressions) and extend record_bpf_filter.sh with lock_held(),
lock_held_read()/lock_held_write(), and ':R'/':W' recording tests.

Example output:

  # perf test -v 'Parsing of BPF sample filters'
    5: Parse event definition strings               :
    5.7: Parsing of BPF sample filters              : Ok

  # perf test -v 'perf record sample filtering (by BPF) tests'
  112: perf record sample filtering (by BPF) tests  :
  Checking BPF-filter privilege
  Basic bpf-filter test
  Basic bpf-filter test [Success]
  Failing bpf-filter test
  Failing bpf-filter test [Success]
  Group bpf-filter test
  Group bpf-filter test [Success]
  Multiple bpf-filter test
  Multiple bpf-filter test [Success]
  Cgroup bpf-filter test
  Cgroup bpf-filter test [Success]
  Lock-held bpf-filter test
  Lock-held bpf-filter test [Success]
  112: perf record sample filtering (by BPF) tests  : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c             | 108 +++++++++++++++++
 tools/perf/tests/shell/record_bpf_filter.sh | 122 ++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5f6f95c8a5b4..4cf9192762f2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -8,9 +8,11 @@
 #include "debug.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "bpf-filter.h"
 #include "strbuf.h"
 #include <dirent.h>
 #include <errno.h>
+#include <string.h>
 #include "fncache.h"
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -2938,6 +2940,111 @@ static int test__pmu_events_alias2(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+#ifdef HAVE_BPF_SKEL
+static void clear_bpf_filter_exprs(struct list_head *expr_head)
+{
+	struct perf_bpf_filter_expr *expr, *tmp;
+
+	list_for_each_entry_safe(expr, tmp, expr_head, list) {
+		list_del(&expr->list);
+		perf_bpf_filter_expr__delete(expr);
+	}
+}
+
+static int do_test_bpf_filters(struct list_head *expr_head)
+{
+	struct perf_bpf_filter_expr *expr, *group;
+	const char *compound = "lock_held(rwsem:R) == 1 || lock_held(&dentry) != 0, period > 100";
+
+	/* Simple lock_held(&cgroup_mutex) */
+	TEST_ASSERT_VAL("parse lock_held(&cgroup_mutex)",
+			__perf_bpf_filter__parse(expr_head, "lock_held(&cgroup_mutex)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 1", expr->val == 1);
+	TEST_ASSERT_VAL("lock_name is &cgroup_mutex",
+			expr->lock_name && !strcmp(expr->lock_name, "&cgroup_mutex"));
+	clear_bpf_filter_exprs(expr_head);
+
+	/* Negated !lock_held(cgroup_mutex) */
+	TEST_ASSERT_VAL("parse !lock_held(cgroup_mutex)",
+			__perf_bpf_filter__parse(expr_head, "!lock_held(cgroup_mutex)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 0", expr->val == 0);
+	TEST_ASSERT_VAL("lock_name is cgroup_mutex",
+			expr->lock_name && !strcmp(expr->lock_name, "cgroup_mutex"));
+	clear_bpf_filter_exprs(expr_head);
+
+	/* Read/shared and write/exclusive predicates */
+	TEST_ASSERT_VAL("parse lock_held_read(&mmap_lock)",
+			__perf_bpf_filter__parse(expr_head, "lock_held_read(&mmap_lock)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("part is PBF_LOCK_MODE_READ", expr->part == PBF_LOCK_MODE_READ);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 1", expr->val == 1);
+	TEST_ASSERT_VAL("lock_name is &mmap_lock",
+			expr->lock_name && !strcmp(expr->lock_name, "&mmap_lock"));
+	clear_bpf_filter_exprs(expr_head);
+
+	TEST_ASSERT_VAL("parse !lock_held_exclusive(mmap_lock)",
+			__perf_bpf_filter__parse(expr_head,
+						 "!lock_held_exclusive(mmap_lock)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("part is PBF_LOCK_MODE_WRITE", expr->part == PBF_LOCK_MODE_WRITE);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 0", expr->val == 0);
+	TEST_ASSERT_VAL("lock_name is mmap_lock",
+			expr->lock_name && !strcmp(expr->lock_name, "mmap_lock"));
+	clear_bpf_filter_exprs(expr_head);
+
+	/*
+	 * Comparison and compound group:
+	 * lock_held(rwsem:R) == 1 || lock_held(&dentry) != 0, period > 100
+	 */
+	TEST_ASSERT_VAL("parse compound lock_held filter",
+			__perf_bpf_filter__parse(expr_head, compound) == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("group op", expr->op == PBF_OP_GROUP_BEGIN);
+	TEST_ASSERT_VAL("groups not empty", !list_empty(&expr->groups));
+	group = list_first_entry(&expr->groups, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("first group member lock_name",
+			group->lock_name && !strcmp(group->lock_name, "rwsem:R"));
+	TEST_ASSERT_VAL("first group member op", group->op == PBF_OP_EQ && group->val == 1);
+	group = list_last_entry(&expr->groups, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("second group member lock_name",
+			group->lock_name && !strcmp(group->lock_name, "&dentry"));
+	TEST_ASSERT_VAL("second group member op", group->op == PBF_OP_NEQ && group->val == 0);
+	expr = list_last_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("second term is period", expr->term == PBF_TERM_PERIOD && expr->val == 100);
+
+	return TEST_OK;
+}
+#endif
+
+static int test__bpf_filters(struct test_suite *test __maybe_unused,
+			     int subtest __maybe_unused)
+{
+#ifdef HAVE_BPF_SKEL
+	struct list_head expr_head = LIST_HEAD_INIT(expr_head);
+	int ret = do_test_bpf_filters(&expr_head);
+
+	clear_bpf_filter_exprs(&expr_head);
+	return ret;
+#else
+	return TEST_SKIP;
+#endif
+}
+
 static struct test_case tests__parse_events[] = {
 	TEST_CASE_REASON("Test event parsing",
 			 events2,
@@ -2952,6 +3059,7 @@ static struct test_case tests__parse_events[] = {
 			 "no aliases in sysfs"),
 	TEST_CASE("Parsing of aliased events", pmu_events_alias2),
 	TEST_CASE("Parsing of terms (event modifiers)", terms2),
+	TEST_CASE("Parsing of BPF sample filters", bpf_filters),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 383574cb3bd3..ebaf8ee41622 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -176,6 +176,124 @@ test_bpf_filter_cgroup() {
   echo "Cgroup bpf-filter test [Success]"
 }
 
+test_bpf_filter_lock_held() {
+  echo "Lock-held bpf-filter test"
+  lock_sym="cgroup_mutex"
+
+  if [ -r /proc/kallsyms ] && ! grep -qw "${lock_sym}" /proc/kallsyms
+  then
+    lock_sym="slab_mutex"
+  fi
+
+  if ! perf record -e task-clock --filter "lock_held(${lock_sym})" \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    if [ "$(id -u)" != 0 ]
+    then
+      echo "Lock-held bpf-filter test [Skipped permission]"
+      return
+    fi
+    if [ -r /proc/kallsyms ] && ! grep -qw "${lock_sym}" /proc/kallsyms
+    then
+      echo "Lock-held bpf-filter test [Skipped missing ${lock_sym}]"
+      return
+    fi
+    echo "Lock-held bpf-filter test [Failed ${lock_sym}]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter "!lock_held(${lock_sym})" \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed !lock_held(${lock_sym})]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(&dentry)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed &dentry]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(mmap_lock)' \
+       -o "${perfdata}" perf bench mem mmap -t 2 -l 10 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed mmap_lock]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(rq_lock) || lock_held(spinlock)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    if ! perf record -e task-clock --filter 'lock_held(rq_lock) || lock_held(spinlock)' \
+         -o /dev/null true 2>&1 | grep -q "Kernel BTF lacks required"
+    then
+      echo "Lock-held bpf-filter test [Failed rq_lock/spinlock]"
+      err=1
+      return
+    fi
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(mutex) || lock_held(rwsem)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed lock type]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock \
+       --filter 'lock_held_read(mmap_lock) || lock_held_write(mmap_lock)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed lock_held_read/write(mmap_lock)]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(mmap_lock:R) || lock_held(mmap_lock:W)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed mmap_lock:R/:W]"
+    err=1
+    return
+  fi
+
+  if perf list tracepoint 2> /dev/null | grep -q kmem:mm_page_alloc
+  then
+    if ! perf record -e kmem:mm_page_alloc --filter 'lock_held(mutex) || lock_held(rwsem)' \
+         -o "${perfdata}" true 2> /dev/null
+    then
+      echo "Lock-held bpf-filter test [Failed tracepoint kmem:mm_page_alloc]"
+      err=1
+      return
+    fi
+  fi
+
+  if perf record -e task-clock --filter 'lock_held_read(rq_lock)' \
+       -o /dev/null true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed lock_held_read(rq_lock) should fail]"
+    err=1
+    return
+  fi
+
+  if perf record -e task-clock --filter 'lock_held(nonexistent_lock_xyz)' \
+       -o /dev/null true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed nonexistent lock should fail]"
+    err=1
+    return
+  fi
+
+  echo "Lock-held bpf-filter test [Success]"
+}
+
 test_bpf_filter_priv
 
 if [ $err = 0 ]; then
@@ -198,5 +316,9 @@ if [ $err = 0 ]; then
   test_bpf_filter_cgroup
 fi
 
+if [ $err = 0 ]; then
+  test_bpf_filter_lock_held
+fi
+
 cleanup
 exit $err
-- 
2.56.0.212.g129ede20d9-goog

