Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701033;
	b=CvmF6Q3FCHQ1PjkVe24ozhq0B2BCHXT1QKVquo2A3jpbhw1feCUcPj151go4EYWA1ZtE
	 mZKjLb46J7avO7n6I43940jbYAv+z+7Cy5eM3BCEAGdJaTlJLGzes0pOQSj8hTKemyagJ
	 l14e7oftohyyJDJr9Rs+ftOFwVqwUwWVI+VB849UFdxiKQpEpIQyXr/s47AMEjFP0bMp6
	 mV+WidjZZCcRHerykxrZuDr9wieZotZ4AZ9W/AANuJPSPIITYBzI/iI8VFKXW6l8MY/e0
	 SGs7Ln/8SelUPptosA50d8nwsnbHmTLIN47K/YfmY8RfwC8DqTrT6X91o7HDskvCJ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=UY6vYCjzl6RWP12t6xo6wccEftbOC1VbjOrMfkoQ/Og=;
	b=UgSdpL32LLSl/RG9y92LvtEftOZyZoGCHV+LcHOwwXv32RkrjxJ/0QddHZT5jjARgSmU
	 Ca2rkfU12x9Gy/k/4aJTHBjWLADq+yqNO3J76AGvdFuDH5pqTV/pzjNjby7p1gI6xaE59
	 eOeZbxlLnZwp0OH6gJ5PCAXIGFCNA0NOsoFozxLH3azLlAMUrTIJvlMRpz040K0hu2thD
	 aMY86KKGQu4+bQ63ZUJVYzgAWHzf6ZG2m8aWucncGk+/hLlpn3kLVP0goaTa8cdpi3WQh
	 afRQUKXfexgF+FbgIcuVtojCtdtXacQlTZIv4C7sYYJrFr+GVrPmxf216rF1azesu+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bFKxRHn0;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8F60A2611
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD8F60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bFKxRHn0
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3425098ae4bso1666621eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792701032; x=1793305832; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UY6vYCjzl6RWP12t6xo6wccEftbOC1VbjOrMfkoQ/Og=;
        b=bFKxRHn0LxtGQpoRzjHvJGgSSoxoOn2otcRtH2ZVn7JFz76Jc8Zy9oAodzi97JmLBx
         ybQVvLnePilBQw0u+o5wpsivBYqcxTX3reBDMlzz582W7uwLm6N3fjtWpCq3Fw351UYg
         FVDv1GdbsMBiRd5pstzWV2O2kn2XFxmhpFxw0S1Aez699z8QmMbb6xCscM5CKXFdZ7UL
         +rElISNfRoRqpuRybZM2SKLh6UBSQne6QCMtA/xzVvbsd+qQ1z/EqlJh19/z6bgTzguU
         25tiIUFTpu+DDYgP8KqZvuPctmmhPjO0zPLGMxtISE4VM4WaEirtC732iQYv7KmE7QtO
         cQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701032; x=1793305832;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UY6vYCjzl6RWP12t6xo6wccEftbOC1VbjOrMfkoQ/Og=;
        b=e6BQymxqJTJk5cvnpparEFOLBWu+Vb1B/ZBI1ps6KSqnQCNDAb3qw78oc6YSA6Imcp
         Klvupfh3AOx4rk442nLMRFYH0wzFSY+mXOw2r1R5H/4Xu0rnat0pkNAgjE4VO1EtUCPa
         eKXLLbEagnucWQS9rt1U6PQ4NEASTHDYJDAvKZ1O69Wb91spXbYLcr8exGYmbSMcBQe1
         AjlDt9BWlG6MKWDVOHYLi9q4UCzrfUowwidttG0xofY+fPyTvhecehWSTRPRL4xWw1QO
         2xsQB/KVikmWgPLEfkqz3/jr1R1mGLKT/Zhe3pfd0iwXQEZ/ItxcsKhNZsugWe581UFs
         Wc4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwO2EB3M0drCPXFMI/e9IMxdEjrXpssHqq1w0KzWbgoY+5NYzvu8/zEpkGCbB+CH5wHjNPS1S3RQ/Uu7AJ7Bx4M@vger.kernel.org
X-Gm-Message-State: AFq9FYKO0V4q5Htgh3uqvPk8OPqoaGRo7p/0USKmc+JzzcTPPM/3sySj
	PRRN9QIWI5vGkVGv5MqJmd+EIRRictPKQ/+CnZqrfomiEFOJizlul865XwpXfPWgiN0juE0zoZ8
	u5WXK0JjkkQ==
X-Received: from dlbdm42.prod.google.com ([2002:a05:7022:6baa:b0:190:dcfa:8eb6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:251b:b0:183:e184:86b
 with SMTP id a92af1059eb24-192f2d21e23mr3564940c88.5.1792701031383; Thu, 22
 Oct 2026 13:30:31 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:30:00 -0700
In-Reply-To: <20261022203003.1779152-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020205859.1080743-1-irogers@google.com> <20261022203003.1779152-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022203003.1779152-9-irogers@google.com>
Subject: [PATCH v6 08/11] perf bpf-filter: Support slab cache locks (&<name>)
 in lock_held()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the lock_held() BPF sample filter to support dynamically
allocated kernel locks inside slab caches prefixed with '&' (e.g.
lock_held(&dentry), lock_held_read(&dentry), lock_held_write(&dentry)).

Reuse do_slab_cache_iter() from lock_data.h via a SEC("iter/kmem_cache")
program to resolve the requested slab cache name to its kernel
struct kmem_cache * address, and use the bpf_get_kmem_cache() kfunc in
record_lock_acquired_owner() and record_lock_released_addr() to match
held locks allocated from that slab cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     |  25 ++--
 tools/perf/util/bpf-filter.c                 | 125 ++++++++++++++++---
 tools/perf/util/bpf_skel/sample-filter.h     |   5 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  48 +++++++
 4 files changed, 175 insertions(+), 28 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 2b2aaaead76b..8fc3196ed93d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -222,13 +222,15 @@ OPTIONS
 	(alias 'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to
 	<lock> (e.g. 'lock_held(mmap_lock:R)' or 'lock_held(mmap_lock:W)').
 	<lock> can be a kernel lock symbol name (e.g.
-	'lock_held(cgroup_mutex)'), a hexadecimal lock address, a well-known
-	lock name ('mmap_lock', 'siglock', 'rq_lock', 'zone_lock'), or a lock
-	type ('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
-	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
-	'semaphore').  Both read/shared and write/exclusive tracking are
-	supported for 'rwsem' (including 'mmap_lock') and 'rwlock'; 'mutex',
-	'spinlock' (including 'siglock', 'rq_lock', 'zone_lock'), 'rt-mutex',
+	'lock_held(cgroup_mutex)'), a hexadecimal lock address, a slab cache
+	name prefixed with '&' (e.g. 'lock_held(&dentry)',
+	'lock_held_read(&dentry)'), a well-known lock name ('mmap_lock',
+	'siglock', 'rq_lock', 'zone_lock'), or a lock type ('mutex',
+	'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock', 'rwlock:R',
+	'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W', 'semaphore').
+	Both read/shared and write/exclusive tracking are supported for
+	'rwsem' (including 'mmap_lock') and 'rwlock'; 'mutex', 'spinlock'
+	(including 'siglock', 'rq_lock', 'zone_lock'), 'rt-mutex',
 	'semaphore', and 'percpu-rwsem' ('percpu_down_write()') support
 	write/exclusive tracking only.  Note that 'semaphore' tracking
 	('down*()' / 'up()') assumes binary mutex-like usage where the
@@ -254,16 +256,17 @@ OPTIONS
 	'owner' field directly in kernel memory on each sample without attaching
 	any BPF fentry/fexit hooks.  For locks that do not maintain an
 	authoritative per-task owner pointer (such as spinlocks, rwlocks,
-	semaphores, reader-locked rwsems, and lock type filters), it attaches
+	semaphores, reader-locked rwsems, and slab/type filters), it attaches
 	BPF fentry/fexit programs to kernel lock acquire and release functions
 	to track held locks in a BPF map.  These BPF hooks run on every kernel
 	lock acquisition and release for the attached lock family, even when no
 	perf sample is being taken.  To minimize this overhead, only the hooks
 	for the relevant lock family and mode are attached when known (for
 	example, 'lock_held_read(mmap_lock)' only hooks rwsem read functions
-	and 'rq_lock' only hooks spinlock functions), whereas raw hex addresses
-	or symbols without a recognizable lock-type suffix attach hooks across
-	all lock families (including high-frequency spinlocks).
+	and 'rq_lock' only hooks spinlock functions), whereas slab filters
+	('&<slab>'), raw hex addresses, or symbols without a recognizable
+	lock-type suffix attach hooks across all lock families (including
+	high-frequency spinlocks).
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index f542920f914f..1a75d779e891 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -655,10 +655,14 @@ static unsigned int supported_lock_prog_groups(struct btf *btf)
 static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
 				unsigned int needed_groups,
 				unsigned int required_groups,
-				bool needs_lock_syms, bool is_tracepoint)
+				bool needs_lock_syms, bool needs_slab_iter,
+				bool is_tracepoint)
 {
 	unsigned int supported_groups = supported_lock_prog_groups(btf);
 	unsigned int enabled_progs = 0;
+	bool has_slab_iter = needs_slab_iter && btf &&
+			     btf__find_by_name_kind(btf, "bpf_iter__kmem_cache",
+						    BTF_KIND_STRUCT) > 0;
 
 	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoint);
 	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepoint);
@@ -691,6 +695,7 @@ static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
 	}
 
 	bpf_program__set_autoload(skel->progs.collect_lock_syms, needs_lock_syms);
+	bpf_program__set_autoload(skel->progs.slab_cache_iter, has_slab_iter);
 
 	if (needed_groups && !enabled_progs) {
 		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
@@ -708,7 +713,8 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 				  bool *has_lock_filter,
 				  unsigned int *prog_groups,
 				  unsigned int *required_groups,
-				  bool *needs_lock_syms)
+				  bool *needs_lock_syms,
+				  bool *needs_slab_iter)
 {
 	char base[128];
 	bool has_amp;
@@ -720,9 +726,16 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 
 	*has_lock_filter = true;
 	if (split_lock_name_mode(expr->lock_name, expr->part, base,
-				 sizeof(base), &has_amp, &mode) < 0 || has_amp)
+				 sizeof(base), &has_amp, &mode) < 0)
 		return;
 
+	/* Leading '&' is reserved for slab cache locks (e.g. '&dentry'). */
+	if (has_amp) {
+		*needs_slab_iter = true;
+		*prog_groups |= LOCK_PROG_ALL;
+		return;
+	}
+
 	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
 		/*
 		 * Write ownership of mm->mmap_lock is inspected directly via
@@ -795,7 +808,8 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 static void prescan_lock_filters(struct evsel *evsel, bool *has_lock_filter,
 				 unsigned int *prog_groups,
 				 unsigned int *required_groups,
-				 bool *needs_lock_syms)
+				 bool *needs_lock_syms,
+				 bool *needs_slab_iter)
 {
 	struct perf_bpf_filter_expr *expr, *group;
 
@@ -803,20 +817,72 @@ static void prescan_lock_filters(struct evsel *evsel, bool *has_lock_filter,
 	*prog_groups = 0;
 	*required_groups = 0;
 	*needs_lock_syms = false;
+	*needs_slab_iter = false;
 
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
 		prescan_one_lock_expr(expr, has_lock_filter, prog_groups,
-				      required_groups, needs_lock_syms);
+				      required_groups, needs_lock_syms,
+				      needs_slab_iter);
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
 			list_for_each_entry(group, &expr->groups, list) {
 				prescan_one_lock_expr(group, has_lock_filter,
 						      prog_groups, required_groups,
-						      needs_lock_syms);
+						      needs_lock_syms, needs_slab_iter);
 			}
 		}
 	}
 }
 
+static void run_slab_cache_iter(struct sample_filter_bpf *skel)
+{
+	struct bpf_link *link;
+	int fd;
+	char buf[256];
+
+	if (!bpf_program__autoload(skel->progs.slab_cache_iter))
+		return;
+
+	link = bpf_program__attach_iter(skel->progs.slab_cache_iter, NULL);
+	if (!link || IS_ERR(link)) {
+		pr_debug("cannot attach slab cache iter\n");
+		return;
+	}
+
+	fd = bpf_iter_create(bpf_link__fd(link));
+	if (fd >= 0) {
+		while (read(fd, buf, sizeof(buf)) > 0)
+			continue;
+		close(fd);
+	}
+
+	bpf_link__destroy(link);
+}
+
+static bool find_slab_cache(struct sample_filter_bpf *skel, const char *name,
+			    u64 *kmem_cache_addr)
+{
+	int cache_fd;
+	u64 key, *prev_key = NULL;
+
+	if (!skel || !bpf_program__autoload(skel->progs.slab_cache_iter))
+		return false;
+
+	cache_fd = bpf_map__fd(skel->maps.slab_caches);
+	while (!bpf_map_get_next_key(cache_fd, prev_key, &key)) {
+		struct slab_cache_data data;
+
+		if (bpf_map_lookup_elem(cache_fd, &key, &data) < 0)
+			break;
+
+		if (!strcmp(data.name, name)) {
+			*kmem_cache_addr = key;
+			return true;
+		}
+		prev_key = &key;
+	}
+	return false;
+}
+
 static int normalize_lock_expr_op(const struct perf_bpf_filter_expr *expr,
 				  enum perf_bpf_filter_op *op_out)
 {
@@ -903,12 +969,13 @@ static bool is_percpu_rwsem_sym(struct btf *btf, const char *name)
  * and populate the corresponding BPF filter maps and BSS control flags.
  *
  * Resolution order:
- * 1. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
+ * 1. Slab cache name (when prefixed with '&', e.g. `&dentry`).
+ * 2. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
  *    `rq_lock`, `zone_lock`.
- * 2. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
+ * 3. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
  *    `rwlock`, `percpu-rwsem`, `semaphore`, etc.
- * 3. Hexadecimal lock address.
- * 4. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
+ * 4. Hexadecimal lock address.
+ * 5. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
  */
 static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
 			     struct perf_bpf_filter_expr *expr,
@@ -927,11 +994,25 @@ static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
 		return ret;
 
 	if (split_lock_name_mode(name, expr->part, base, sizeof(base),
-				 &has_amp, &mode) < 0 || has_amp) {
+				 &has_amp, &mode) < 0) {
 		pr_err("Error: Invalid kernel lock filter '%s'\n", name ?: "");
 		return -EINVAL;
 	}
 
+	if (has_amp) {
+		if (find_slab_cache(skel, base, &addr)) {
+			int fd = bpf_map__fd(skel->maps.slab_filter);
+
+			entry->part = PBF_LOCK_SLAB | mode;
+			entry->value = addr;
+			bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+			skel->bss->has_lock_slab = 1;
+			return 0;
+		}
+		pr_err("Error: Cannot resolve slab cache '%s'\n", name);
+		return -EINVAL;
+	}
+
 	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
 		entry->part = PBF_LOCK_MMAP | mode;
 		entry->value = 0;
@@ -1333,7 +1414,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
 	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
-	bool has_lock_filter = false, needs_lock_syms = false;
+	bool has_lock_filter = false, needs_lock_syms = false, needs_slab_iter = false;
 	unsigned int prog_groups = 0, required_groups = 0;
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
@@ -1341,7 +1422,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		return -1;
 
 	prescan_lock_filters(evsel, &has_lock_filter, &prog_groups,
-			     &required_groups, &needs_lock_syms);
+			     &required_groups, &needs_lock_syms,
+			     &needs_slab_iter);
 
 	if ((has_lock_filter || is_tracepoint) && geteuid() != 0 &&
 	    !perf_cap__capable(CAP_BPF)) {
@@ -1406,16 +1488,21 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		btf = btf__load_vmlinux_btf();
 		bpf_map__set_max_entries(skel->maps.held_locks, MAX_ENTRIES);
 		bpf_map__set_max_entries(skel->maps.lock_addr_filter, MAX_FILTERS);
+		if (needs_slab_iter) {
+			bpf_map__set_max_entries(skel->maps.slab_filter, MAX_FILTERS);
+			bpf_map__set_max_entries(skel->maps.slab_caches, MAX_ENTRIES);
+		}
 		if (needs_lock_syms) {
 			bpf_map__set_max_entries(skel->maps.lock_syms, MAX_ENTRIES);
 			init_numa_data(skel, btf);
 		}
 		ret = configure_lock_progs(skel, btf, prog_groups, required_groups,
-					   needs_lock_syms, is_tracepoint);
+					   needs_lock_syms, needs_slab_iter,
+					   is_tracepoint);
 		if (ret < 0)
 			goto err;
 	} else {
-		configure_lock_progs(skel, NULL, 0, 0, false, is_tracepoint);
+		configure_lock_progs(skel, NULL, 0, 0, false, false, is_tracepoint);
 	}
 
 	if (sample_filter_bpf__load(skel) < 0) {
@@ -1424,6 +1511,9 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
+	if (has_lock_filter && needs_slab_iter)
+		run_slab_cache_iter(skel);
+
 	ret = get_filter_entries(evsel, skel, btf, entry);
 	if (ret < 0) {
 		pr_err("Failed to process filter entries\n");
@@ -1444,6 +1534,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		bpf_program__set_autoattach(skel->progs.perf_sample_filter, false);
 		bpf_program__set_autoattach(skel->progs.perf_tp_sample_filter, false);
 		bpf_program__set_autoattach(skel->progs.collect_lock_syms, false);
+		bpf_program__set_autoattach(skel->progs.slab_cache_iter, false);
 
 		ret = sample_filter_bpf__attach(skel);
 		if (ret < 0) {
@@ -1726,7 +1817,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	configure_lock_progs(skel, NULL, 0, 0, false, false);
+	configure_lock_progs(skel, NULL, 0, 0, false, false, false);
 
 	/* pinned program will use pid-hash */
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
@@ -1823,7 +1914,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	configure_lock_progs(skel, NULL, 0, 0, false, false);
+	configure_lock_progs(skel, NULL, 0, 0, false, false, false);
 	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 836b398dc62b..a65ee780d64d 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -76,6 +76,11 @@ enum perf_bpf_lock_target_kind {
 	 * given as a hex address). `entry.value` holds the kernel address.
 	 */
 	PBF_LOCK_ADDR,
+	/*
+	 * Dynamic lock allocated inside a slab cache (`&slab_name`).
+	 * `entry.value` holds the kernel `struct kmem_cache *` address.
+	 */
+	PBF_LOCK_SLAB,
 	/*
 	 * Per-process `current->mm->mmap_lock` (or `mmap_sem`).
 	 */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 2087fb05e4c7..d1192a93179e 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -111,6 +111,20 @@ struct {
 	__uint(max_entries, 1);
 } lock_syms SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} slab_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(struct slab_cache_data));
+	__uint(max_entries, 1);
+} slab_caches SEC(".maps");
+
 volatile const int use_idx_hash;
 
 const volatile __u64 contig_page_data_addr;
@@ -118,9 +132,12 @@ const volatile __u64 node_data_addr;
 const volatile int nr_nodes;
 const volatile int sizeof_zone;
 
+__u32 slab_cache_id;
+
 /* Control flags set by userspace when lock_held(...) filters are active. */
 int lock_enabled;
 int has_lock_addr;
+int has_lock_slab;
 int has_lock_class;
 int has_lock_type;
 int has_mmap_lock;
@@ -259,6 +276,9 @@ static __always_inline bool is_lock_held(struct perf_bpf_filter_entry *entry)
 	case PBF_LOCK_CLASS:
 		return is_lock_in_map(entry->value, PBF_LOCK_CLASS, mode, pid, cpu_id) != 0;
 
+	case PBF_LOCK_SLAB:
+		return is_lock_in_map(entry->value, PBF_LOCK_SLAB, mode, pid, cpu_id) != 0;
+
 	case PBF_LOCK_TYPE:
 		return is_lock_type_in_map(entry->value, mode, pid, cpu_id) != 0;
 
@@ -697,6 +717,7 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 	bool matched = false;
 	bool is_read = (flags & LCB_F_READ) != 0;
 	__u32 class_id = 0;
+	__u64 kmem_cache_addr = 0;
 	__u32 type_flag = flags & LCB_F_TYPE_MASK;
 	bool match_type = false;
 
@@ -723,6 +744,14 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 		}
 	}
 
+	if (has_lock_slab && bpf_get_kmem_cache) {
+		kmem_cache_addr = (__u64)bpf_get_kmem_cache(lock_addr);
+		if (kmem_cache_addr && bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr))
+			matched = true;
+		else
+			kmem_cache_addr = 0;
+	}
+
 	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag]) {
 		match_type = true;
 		matched = true;
@@ -769,6 +798,10 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 
 	if (class_id)
 		update_held_lock_count(class_id, owner_id, PBF_LOCK_CLASS, type_flag, true);
+	if (kmem_cache_addr) {
+		update_held_lock_count((__u64)kmem_cache_addr, owner_id,
+				       PBF_LOCK_SLAB, type_flag, true);
+	}
 	if (match_type)
 		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, type_flag, true);
 
@@ -824,6 +857,15 @@ static __always_inline int record_lock_released_addr(__u64 lock_addr, __u32 flag
 			update_held_lock_count(*cid, owner_id, PBF_LOCK_CLASS, flags, false);
 	}
 
+	if (has_lock_slab && bpf_get_kmem_cache) {
+		__u64 kmem_cache_addr = (__u64)bpf_get_kmem_cache(lock_addr);
+
+		if (kmem_cache_addr && bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr)) {
+			update_held_lock_count(kmem_cache_addr, owner_id,
+					       PBF_LOCK_SLAB, flags, false);
+		}
+	}
+
 	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag])
 		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, flags, false);
 
@@ -1356,4 +1398,10 @@ int BPF_PROG(collect_lock_syms)
 				    node_data_addr, nr_nodes, sizeof_zone);
 }
 
+SEC("iter/kmem_cache")
+int slab_cache_iter(void *ctx)
+{
+	return do_slab_cache_iter(ctx, &slab_caches, &slab_cache_id);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.56.0.307.g5fe7bd680c-goog

