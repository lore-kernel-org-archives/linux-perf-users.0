Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA220E03A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241908; cv=none; b=HE/fBSx1YJfT3jj4CC2oJgEO2EANUlhNNYzWeIbF1KvML1oWppCHi45a0pLZ1VtL8O7j18Zo+gbLaKLKP54QwLTtyYBGSTdQugybKwgkOa6pvt8ZxeYCU4wALMOVLE/qy7NcJ4jA46tM5FX7e2gzrMIFqqq5Ig8RLhnaG7NwqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241908; c=relaxed/simple;
	bh=VDsV7b3OX/emG3gjapt2R1JtoaiE0+25N7pa2k/w/TA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CzOBjkPlKESDEgEtILG7FPU7Nh8uhgZ6UkWmJ/klqLw0cltPsAmHm8Hd6xxtcfxr97LpL5QvknBH4DxDINSZrRE6mCagHBhKwZeV11MADCqlY1wDOFhq+w+p80KOViDdy4wL7YuV3FAR0seX7gP/Z6AUEc4uKE0SYmvz0uLlJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GM6qnQyW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GM6qnQyW"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38562155bso88018207b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241905; x=1730846705; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bq7Yn07vcD3vGYwxT4kETwlahqFzcX5Rgl53aad5ETM=;
        b=GM6qnQyWvhQ6jsh6irPkfvcKDBOFAgD+c0uLrxoZl8KOUqM12Nz5kpimv6BMSaJgjb
         PX5PHV58yUqRoQRjhAyaiHHLEW0JvH0Me8cm4JfGl/iej0fPxLygC9FxJxnBnPMWv5ES
         foQL9tS8xyjNgiC73rh1o2SeUprNAdGKPzQFSfT9bFSsOkTs/0q76o/yiuqqU/X4QyLp
         JU3HrF9KPtlx60jsic4xOBim3Nly+uLahPxIkoQPACMeKVZDp5LD70BZk5qUemucjGI7
         D7QHDF4DB2KmYQIqNldsTmQl5irgmThF8eJAMYMXyFPl9wFxiFE3kbSNhGU1jOuSQ0Kk
         hedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241905; x=1730846705;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq7Yn07vcD3vGYwxT4kETwlahqFzcX5Rgl53aad5ETM=;
        b=Vw1mFvJPDtKPORZ4CTw3yR9pgtfJdW7ay+VGMNLnVO8rEzFszIt0rpUxyu44O1UEVg
         Q5XT30V+OXGq9wi5vQyN2BCAIjjXSVOnejCgL/hgm0gobQZEK6IYr+p0hDfKy+IBNulR
         u3NZHck0eccvzH9XKQZcpuNIIPxUHvW0w2g4qjSos2DS6/ezptst2YL4V4hkBJQKY2Fz
         tOUigIX0S3my5pkV+7gB8sUODZoEP1A3cKGfkfWaObYAVHkjeJuD712X2gHJH89Q9FVn
         bDkFeGjuCM6YIaT8BGmmb5Oj90V5I+wPt93GN9lGpIGoBGyiLxsEODycx9ct1K4IFKb8
         dgGA==
X-Forwarded-Encrypted: i=1; AJvYcCXN9w91szlkLVBmVFoxy5QL3zcV4eRQwTOijsnYdx1ryq9Wx/ErfGCmAnW6fncW4ilXyiBmd7uzD+LhV6coJi9v@vger.kernel.org
X-Gm-Message-State: AOJu0YxVq250Iwd0D1P5FscAo04wENIt+KxFF7ejVDZEJG9LdQGHpnxL
	S1DaPxOC3t68zOYn/mT1KGCeRSP/b3W+9Vt7oPtyIJt066RJ6dsqr+brn+oE6JT+RP1bZIcU+OE
	Z1m2Z0Q==
X-Google-Smtp-Source: AGHT+IHOuhal+mAGelAxUnrI8QP+h//1b0G8Ky0o5eO4R/EMlbmG9cgGa1znQd0Et9hMZhFTYOtvQwYOX4aj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a02:b0:6e3:b08:92c7 with SMTP id
 00721157ae682-6e9d87070a8mr8170337b3.0.1730241905103; Tue, 29 Oct 2024
 15:45:05 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:24 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 12/19] perf lock: Move common lock contention code to new file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid references from util code to builtin-lock that require python
stubs. Move the functions and related variables to
util/lock-contention.c. Add max_stack_depth parameter to
match_callstack_filter to avoid sharing a global variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c             | 137 +--------------------
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   2 +-
 tools/perf/util/lock-contention.c     | 170 ++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h     |  37 ++----
 tools/perf/util/python.c              |  17 ---
 6 files changed, 185 insertions(+), 179 deletions(-)
 create mode 100644 tools/perf/util/lock-contention.c

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..f66948b1fbed 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -46,15 +46,6 @@
 static struct perf_session *session;
 static struct target target;
 
-/* based on kernel/lockdep.c */
-#define LOCKHASH_BITS		12
-#define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
-
-static struct hlist_head *lockhash_table;
-
-#define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
-#define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
-
 static struct rb_root		thread_stats;
 
 static bool combine_locks;
@@ -67,24 +58,13 @@ static unsigned long bpf_map_entries = MAX_ENTRIES;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
 static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
-static LIST_HEAD(callstack_filters);
 static const char *output_name = NULL;
 static FILE *lock_output;
 
-struct callstack_filter {
-	struct list_head list;
-	char name[];
-};
-
 static struct lock_filter filters;
 
 static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
 
-static bool needs_callstack(void)
-{
-	return !list_empty(&callstack_filters);
-}
-
 static struct thread_stat *thread_stat_find(u32 tid)
 {
 	struct rb_node *node;
@@ -477,93 +457,6 @@ static struct lock_stat *pop_from_result(void)
 	return container_of(node, struct lock_stat, rb);
 }
 
-struct lock_stat *lock_stat_find(u64 addr)
-{
-	struct hlist_head *entry = lockhashentry(addr);
-	struct lock_stat *ret;
-
-	hlist_for_each_entry(ret, entry, hash_entry) {
-		if (ret->addr == addr)
-			return ret;
-	}
-	return NULL;
-}
-
-struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
-{
-	struct hlist_head *entry = lockhashentry(addr);
-	struct lock_stat *ret, *new;
-
-	hlist_for_each_entry(ret, entry, hash_entry) {
-		if (ret->addr == addr)
-			return ret;
-	}
-
-	new = zalloc(sizeof(struct lock_stat));
-	if (!new)
-		goto alloc_failed;
-
-	new->addr = addr;
-	new->name = strdup(name);
-	if (!new->name) {
-		free(new);
-		goto alloc_failed;
-	}
-
-	new->flags = flags;
-	new->wait_time_min = ULLONG_MAX;
-
-	hlist_add_head(&new->hash_entry, entry);
-	return new;
-
-alloc_failed:
-	pr_err("memory allocation failed\n");
-	return NULL;
-}
-
-bool match_callstack_filter(struct machine *machine, u64 *callstack)
-{
-	struct map *kmap;
-	struct symbol *sym;
-	u64 ip;
-	const char *arch = perf_env__arch(machine->env);
-
-	if (list_empty(&callstack_filters))
-		return true;
-
-	for (int i = 0; i < max_stack_depth; i++) {
-		struct callstack_filter *filter;
-
-		/*
-		 * In powerpc, the callchain saved by kernel always includes
-		 * first three entries as the NIP (next instruction pointer),
-		 * LR (link register), and the contents of LR save area in the
-		 * second stack frame. In certain scenarios its possible to have
-		 * invalid kernel instruction addresses in either LR or the second
-		 * stack frame's LR. In that case, kernel will store that address as
-		 * zero.
-		 *
-		 * The below check will continue to look into callstack,
-		 * incase first or second callstack index entry has 0
-		 * address for powerpc.
-		 */
-		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
-						(i != 1 && i != 2))))
-			break;
-
-		ip = callstack[i];
-		sym = machine__find_kernel_symbol(machine, ip, &kmap);
-		if (sym == NULL)
-			continue;
-
-		list_for_each_entry(filter, &callstack_filters, list) {
-			if (strstr(sym->name, filter->name))
-				return true;
-		}
-	}
-	return false;
-}
-
 struct trace_lock_handler {
 	/* it's used on CONFIG_LOCKDEP */
 	int (*acquire_event)(struct evsel *evsel,
@@ -1165,7 +1058,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		if (callstack == NULL)
 			return -ENOMEM;
 
-		if (!match_callstack_filter(machine, callstack)) {
+		if (!match_callstack_filter(machine, callstack, max_stack_depth)) {
 			free(callstack);
 			return 0;
 		}
@@ -2449,34 +2342,6 @@ static int parse_lock_addr(const struct option *opt __maybe_unused, const char *
 	return ret;
 }
 
-static int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
-			   int unset __maybe_unused)
-{
-	char *s, *tmp, *tok;
-	int ret = 0;
-
-	s = strdup(str);
-	if (s == NULL)
-		return -1;
-
-	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		struct callstack_filter *entry;
-
-		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
-		if (entry == NULL) {
-			pr_err("Memory allocation failure\n");
-			free(s);
-			return -1;
-		}
-
-		strcpy(entry->name, tok);
-		list_add_tail(&entry->list, &callstack_filters);
-	}
-
-	free(s);
-	return ret;
-}
-
 static int parse_output(const struct option *opt __maybe_unused, const char *str,
 			int unset __maybe_unused)
 {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 650974413849..e6404d2c598b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -121,6 +121,7 @@ perf-util-y += topdown.o
 perf-util-y += iostat.o
 perf-util-y += stream.o
 perf-util-y += kvm-stat.o
+perf-util-y += lock-contention.o
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 41a1ad087895..37e17c56f106 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -458,7 +458,7 @@ int lock_contention_read(struct lock_contention *con)
 		if (con->save_callstack) {
 			bpf_map_lookup_elem(stack, &key.stack_id, stack_trace);
 
-			if (!match_callstack_filter(machine, stack_trace)) {
+			if (!match_callstack_filter(machine, stack_trace, con->max_stack)) {
 				con->nr_filtered += data.count;
 				goto next;
 			}
diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
new file mode 100644
index 000000000000..841bb18b1f06
--- /dev/null
+++ b/tools/perf/util/lock-contention.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
+#include "env.h"
+#include "lock-contention.h"
+#include "machine.h"
+#include "symbol.h"
+
+#include <limits.h>
+#include <string.h>
+
+#include <linux/hash.h>
+#include <linux/zalloc.h>
+
+#define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
+#define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
+
+struct callstack_filter {
+	struct list_head list;
+	char name[];
+};
+
+static LIST_HEAD(callstack_filters);
+struct hlist_head *lockhash_table;
+
+int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
+		     int unset __maybe_unused)
+{
+	char *s, *tmp, *tok;
+	int ret = 0;
+
+	s = strdup(str);
+	if (s == NULL)
+		return -1;
+
+	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		struct callstack_filter *entry;
+
+		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
+		if (entry == NULL) {
+			pr_err("Memory allocation failure\n");
+			free(s);
+			return -1;
+		}
+
+		strcpy(entry->name, tok);
+		list_add_tail(&entry->list, &callstack_filters);
+	}
+
+	free(s);
+	return ret;
+}
+
+bool needs_callstack(void)
+{
+	return !list_empty(&callstack_filters);
+}
+
+struct lock_stat *lock_stat_find(u64 addr)
+{
+	struct hlist_head *entry = lockhashentry(addr);
+	struct lock_stat *ret;
+
+	hlist_for_each_entry(ret, entry, hash_entry) {
+		if (ret->addr == addr)
+			return ret;
+	}
+	return NULL;
+}
+
+struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
+{
+	struct hlist_head *entry = lockhashentry(addr);
+	struct lock_stat *ret, *new;
+
+	hlist_for_each_entry(ret, entry, hash_entry) {
+		if (ret->addr == addr)
+			return ret;
+	}
+
+	new = zalloc(sizeof(struct lock_stat));
+	if (!new)
+		goto alloc_failed;
+
+	new->addr = addr;
+	new->name = strdup(name);
+	if (!new->name) {
+		free(new);
+		goto alloc_failed;
+	}
+
+	new->flags = flags;
+	new->wait_time_min = ULLONG_MAX;
+
+	hlist_add_head(&new->hash_entry, entry);
+	return new;
+
+alloc_failed:
+	pr_err("memory allocation failed\n");
+	return NULL;
+}
+
+bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth)
+{
+	struct map *kmap;
+	struct symbol *sym;
+	u64 ip;
+	const char *arch = perf_env__arch(machine->env);
+
+	if (list_empty(&callstack_filters))
+		return true;
+
+	for (int i = 0; i < max_stack_depth; i++) {
+		struct callstack_filter *filter;
+
+		/*
+		 * In powerpc, the callchain saved by kernel always includes
+		 * first three entries as the NIP (next instruction pointer),
+		 * LR (link register), and the contents of LR save area in the
+		 * second stack frame. In certain scenarios its possible to have
+		 * invalid kernel instruction addresses in either LR or the second
+		 * stack frame's LR. In that case, kernel will store that address as
+		 * zero.
+		 *
+		 * The below check will continue to look into callstack,
+		 * incase first or second callstack index entry has 0
+		 * address for powerpc.
+		 */
+		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
+						(i != 1 && i != 2))))
+			break;
+
+		ip = callstack[i];
+		sym = machine__find_kernel_symbol(machine, ip, &kmap);
+		if (sym == NULL)
+			continue;
+
+		list_for_each_entry(filter, &callstack_filters, list) {
+			if (strstr(sym->name, filter->name))
+				return true;
+		}
+	}
+	return false;
+}
+
+#ifndef HAVE_BPF_SKEL
+int lock_contention_prepare(struct lock_contention *con __maybe_unused)
+{
+	return 0;
+}
+
+int lock_contention_start(void)
+{
+	return 0;
+}
+
+int lock_contention_stop(void)
+{
+	return 0;
+}
+
+int lock_contention_finish(struct lock_contention *con __maybe_unused)
+{
+	return 0;
+}
+
+int lock_contention_read(struct lock_contention *con __maybe_unused)
+{
+	return 0;
+}
+#endif  /* !HAVE_BPF_SKEL */
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 1a7248ff3889..bfa5c7db0a5d 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -67,10 +67,11 @@ struct lock_stat {
  */
 #define MAX_LOCK_DEPTH 48
 
-struct lock_stat *lock_stat_find(u64 addr);
-struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
+/* based on kernel/lockdep.c */
+#define LOCKHASH_BITS		12
+#define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
 
-bool match_callstack_filter(struct machine *machine, u64 *callstack);
+extern struct hlist_head *lockhash_table;
 
 /*
  * struct lock_seq_stat:
@@ -148,7 +149,14 @@ struct lock_contention {
 	bool save_callstack;
 };
 
-#ifdef HAVE_BPF_SKEL
+struct option;
+int parse_call_stack(const struct option *opt, const char *str, int unset);
+bool needs_callstack(void);
+
+struct lock_stat *lock_stat_find(u64 addr);
+struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
+
+bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth);
 
 int lock_contention_prepare(struct lock_contention *con);
 int lock_contention_start(void);
@@ -156,25 +164,4 @@ int lock_contention_stop(void);
 int lock_contention_read(struct lock_contention *con);
 int lock_contention_finish(struct lock_contention *con);
 
-#else  /* !HAVE_BPF_SKEL */
-
-static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
-{
-	return 0;
-}
-
-static inline int lock_contention_start(void) { return 0; }
-static inline int lock_contention_stop(void) { return 0; }
-static inline int lock_contention_finish(struct lock_contention *con __maybe_unused)
-{
-	return 0;
-}
-
-static inline int lock_contention_read(struct lock_contention *con __maybe_unused)
-{
-	return 0;
-}
-
-#endif  /* HAVE_BPF_SKEL */
-
 #endif  /* PERF_LOCK_CONTENTION_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 35d84a96dbec..91fd444615cd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -18,7 +18,6 @@
 #include "mmap.h"
 #include "util/kwork.h"
 #include "util/sample.h"
-#include "util/lock-contention.h"
 #include <internal/lib.h>
 #include "../builtin.h"
 
@@ -1311,22 +1310,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 	return NULL;
 }
 
-bool match_callstack_filter(struct machine *machine __maybe_unused, u64 *callstack __maybe_unused)
-{
-	return false;
-}
-
-struct lock_stat *lock_stat_find(u64 addr __maybe_unused)
-{
-	return NULL;
-}
-
-struct lock_stat *lock_stat_findnew(u64 addr __maybe_unused, const char *name __maybe_unused,
-				int flags __maybe_unused)
-{
-	return NULL;
-}
-
 int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
 {
 	return -1;
-- 
2.47.0.163.g1226f6d8fa-goog

