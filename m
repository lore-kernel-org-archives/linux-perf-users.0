Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782381;
	b=Ifp4cIuVp43nimF38oFxJw5q4dNq8P0Y9Wzz0Vd2kheQyerv/+y1WsDIpgTyChbaoLRa
	 R70yD1QMMcPZCHHL95Aa7ByIe3YQ9mv7nOGryF7bn0YZ27LWN2Zsy9bCHFSEOUTs+5Gf4
	 fKzkgmVqC2OJq3lWKxkrAuRO+MWz9giO4DikXpVsxCFwVi+X+fSjZky6dQcHRLgwLQvan
	 GvgP+JHBgZilWOOM7j4fQW30gxJPJSer0eCH0PuLZoCsTWUjTCCwtwwye58PKyV1iHbyH
	 77JK6Q0XpxJ+7N9F0hdPppUEmON7uZIAJedZGXOxDhNB66daoF1IRBPEvPhQP3nXhjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=L1PspVo9C7amwO7tmn/RdlC8aBvzwkxDTHKaY3eUkf4=;
	b=oPgz0VGaQUuuido0NA0F5vVdnhggQfpNGZNE7QJX912u88JWP7cz+mbe62zq6N1q7sI8
	 GJhWFKgZrrK13ihoRTRbCZj/wBB0SDfQKqiR4kv0PpCkfAJSSh9EimY82bQgnRoJNV/eC
	 ayYnRvD+RhxY9MMf8OAzzzPcwH5Dyeb2MdjlH5b/lV9gBJPaFgRDDm0xxesl/0dZ3VKmH
	 pmrNkAB1ZmdLmXQJBWK/oX7T4Y1CqDOXhoo4Zhsdcaaa1SRwJw+l1na3nMP/pqphMoRst
	 LGyR4t+ArdSpT7wuE0QqKMg9T+cdtjOAjehCW980vOfC/VaGnk0BNo5MPXQwutuQLVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JiM0PRpF;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E7606A33B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 350E7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JiM0PRpF
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so2821042eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782380; x=1793387180; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1PspVo9C7amwO7tmn/RdlC8aBvzwkxDTHKaY3eUkf4=;
        b=JiM0PRpFMfNUsXblJsnYN4bDHW/0koSl3aQfA0eC/+gzT8UWOrPFWQNnDFYRlTFIau
         4sm2Wcd1uo05RXuAFuGC67f7HAJ9hjwCHtv/q3VzQ9ivftmwnJwJJrHNlwMUxULAr9CO
         JnNEM/VLVEEJbBJtjB+swD7qKzyOSgAGTBbQU4QijWFknnNnjh4Keoa2qN6OKQiPtSC5
         2VK34trP3N0K8I9gzqZk0q+GecB0tfYQKzQt1t9GdD67iHF58n4B5M3nJM28V3bayu//
         cNSB2AeHCjNGxW57UrWb11Y3iOCiglOJ+0hv3ZMCG2X/P1I+xjIahvzOLPkIpZ1KK93H
         1M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782380; x=1793387180;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L1PspVo9C7amwO7tmn/RdlC8aBvzwkxDTHKaY3eUkf4=;
        b=0hz7n+5OvTQNSmCT/sgLxdg2i/OfLlAxL2sa0hJnjKjrvXTIRiapMq6frY1dbj5b5J
         2ikkGQ3OqUWku2y6qUcUs9cFxjfFmfM6siXo7uhQkiTaAqINg2x89nKQGbkfX46X8bfZ
         boF5x65Ez0wQ5iGwWOE7DGhYvt7rrKou3auEG4+9tHi2O8rsY5YSUZiiZDQfOEDB/qSk
         z/l1InKksQCiTvM+aSN5wmJM3roMywEtJay1Ax0y3EaieaLSxtH6Eh2Gdkm8u8lJoGOg
         K9vhaoKCnCKwS5d83LGwvXOj4QK+p1juzL13o3bs3RWiuEAKu0Epbhse0Q7SZqWmvVa3
         wPnw==
X-Forwarded-Encrypted: i=1; AKwUvBytF4b6j1BL8KdqXKzhBGrEJeHNyq3h1NZV1158Xo9udCFK4vX4KYZpfVlrZWHtM/UtM7bdQKY+9Yqjj11366Ny@vger.kernel.org
X-Gm-Message-State: AFq9FYIXbG4JuRsBeH5xEN2LiZ97aOYd4ANSpxZbL+WFI7ekscBO8pnv
	g29gfDy6GcMWKqjjsh2VcF9JNMZ91gSoEaJbyjkmKX4IQa5xfMWXFUpoNampKfh2Z+PxnLeWZFn
	C9QaOmoKYKg==
X-Received: from dycok8.prod.google.com ([2002:a05:7301:db08:b0:351:1da6:c2e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d183:b0:369:d8e1:7bb6
 with SMTP id 5a478bee46e88-369e84dd32fmr317915eec.25.1792782380039; Fri, 23
 Oct 2026 12:06:20 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:56 -0700
In-Reply-To: <20261023190558.3050796-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022203003.1779152-1-irogers@google.com> <20261023190558.3050796-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023190558.3050796-10-irogers@google.com>
Subject: [PATCH v7 09/11] perf test: Add tests for lock_held() BPF sample filter
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
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
2.56.0.307.g5fe7bd680c-goog

