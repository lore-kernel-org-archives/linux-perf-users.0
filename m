Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406515;
	b=tJnjd0ytRQxl52ysWnUNrYPV4bPDziM0Q9nTjAzEVR7Cayviz6R2YBp7UwIWutTYGYSI
	 mQKhjE/OimDVSg09vBkFT8n3TvP2g9xBEbth3+bbjHGaptNNLmEyphZGHVQbi2Jib8DX5
	 2pL8MjP6hqppnAeaQvBIRZcTqdizUAQ8hyW2ITWcUnwrN5gBSgaQTIjhCfeAQTpMbcjzh
	 7/ahLqdXrE1kyqirQjIh4M8XB3RcKnrppMAxDD+BsHcX2OUvv1VDpu4KfUVk83Z8R5Oz7
	 5bafeoskA0c2KpbZYbUe3nG3bRe6ZErmLCzgnwDYUQmHd7cXirO4YTIxxVfGjV8hqag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=GtDhvKBJc8x7dyEVR/EcwLML19EeT65DnVYzDRX84WM=;
	b=fEH/V22Wt8fvYGyXk19/Jzv3DmOHeo7gb8xHLPGHvH1a3rea5aIcSxpJMSHlazHhoFL+
	 wwdG/qcH7oVV0+VaWUqQXf9fQOwnu3Bpkcx0V1CKOSg+Dtg7EMJ9guSNKhtbmdv/xQxaf
	 5zyfEXqITm6PT+1J1t+ukhNbXNZ2hwgzqNjPaIV7PBSPvzxa4OWlO/QmqSMGKa3x+5lMZ
	 gHwwqRFspA3KUkackQPEx0aeyDg5R4pl2ZfKh4/eGp8eKwmNYmzmsTCrehkXChoGNJlDI
	 VLdwaO9Z6zKGTeASuIWk41Mm5EILulDXeMebQ7cUx6Aqspt92ydq2MUsaZ5byME0r3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IiQDtfNS;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F9606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 04:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 826F9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IiQDtfNS
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386a0f79047so2261833eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 20:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795406514; x=1796011314; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GtDhvKBJc8x7dyEVR/EcwLML19EeT65DnVYzDRX84WM=;
        b=IiQDtfNSjmTd3lOujnY03z1t32zshwmh3oNEjLheH++xhQKOxBpC+V41uIc+DnyQ0L
         /5CkkJNp3uOso6qh6NULno09ItcgBFS1Is8R58CJU3dItV2FDjUt5msmI2PeMNDsaSy4
         ya1AsnbZ1Z2NuUdFW+s0dZw4F1NS8R1y4Cgu33muWyT5ndDFo8y4xvIDbGG0ERiIN+BN
         SvKntDFrjBo8d0gwFAkJVgDuyYAxlvYv/0EvquiVw6+R4QMWPlGegh4GSLGTbA0TKcKI
         17iRGJzxK03IN2E6o2uQPO1HX58l7p9FNtPRb6fP6w7prsh9R68lG/7TiS+ovmZ1cqS1
         YYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795406514; x=1796011314;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtDhvKBJc8x7dyEVR/EcwLML19EeT65DnVYzDRX84WM=;
        b=Gku9j0PECTJpexX++QgtgKh1WOOhbK2m2b+x/KebXzlH65lsHeMJj8w3DEYI8jIM0/
         WHwexAMAzIB5QSgoR+yhuHwN/sncsb4IzRm5SVJVRNss4asp7pYuazG/+VkhBz9ESxhI
         yYSqiJQnxvl6hQZRl3qIjXf6AlJHOLbdY+P6F5ZdoD3SwOhVmYeuuAeveA01txybyhWD
         4iTEcpzAOQf5u+Hu9XYSP9JGu0FXX2J6SzC+th5QmPPOvwHFxshrfL7EJNCiyhhJ0sL6
         ZyBn9O+jvzVGs9s+0XTghzrPsCc+OCp0R8TCnbu8i9AlotGXKT7zvUYxRJ3QkdtSuE1E
         zJXg==
X-Forwarded-Encrypted: i=1; AL+hErHi1TtylqzfntJ46/Yq3dC9ABHTqebqOcMX8C6odoVNyVLdOjJ22GvqwUVjdY2zRy5GXccrEymsPUbCYOj1iGMl@vger.kernel.org
X-Gm-Message-State: APuU4Z/+xeV7ImqR73pzprO9byw3QE/n8k88kxBE7+pgjLGp7GG7+Zrg
	5vv+OjdvgSLpgROVxbEHZyT5KOw4DaqbCY3zbQmT5v45YUtAwrT/pjaFk5j2pipK2TvGDepesgO
	O295877qOCA==
X-Received: from dlbur8-n2.prod.google.com ([2002:a05:7022:ea48:20b0:1ab:a092:67c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1583:b0:16e:c820:b20d
 with SMTP id a92af1059eb24-1b5567b2204mr10771796c88.5.1795406514022; Sun, 22
 Nov 2026 20:01:54 -0800 (PST)
Date: Sun, 22 Nov 2026 20:01:51 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123040151.4094997-1-irogers@google.com>
Subject: [PATCH v1] perf build: Fix bpf-gcc skeleton codegen and CO-RE relocations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When building perf with CC=gcc and bpf-gcc installed, commit
63bdd143c589 ("perf build: Support building BPF skeletons with bpf-gcc")
selects bpf-gcc -O2 by default for tools/perf BPF skeletons. Several
BPF skeletons compile with bpf-gcc -O2 yet fail at runtime during
libbpf relocation or kernel BPF verification:

1. -fivopts strength-reduces bounded array loops over BPF map values
   (such as bperf_cgroup.bpf.c) into PTR_TO_MAP_VALUE != PTR_TO_MAP_VALUE
   end-pointer comparisons. In kernel/bpf/verifier.c, is_branch_taken()
   returns unknown for non-packet pointer comparisons, causing the
   verifier to explore one iteration past the map value end and reject
   the program with -EACCES. Pass -fno-ivopts so bpf-gcc preserves
   scalar loop induction variables.

2. -fipa-sra and -fpartial-inlining outline cold tails of static BPF
   functions into .isra/.part subprogram clones (such as
   task_traced.part.0 in augmented_raw_syscalls.bpf.c and do_exit.part.0
   in syscall_summary.bpf.c) without .BTF.ext func_info entries, causing
   libbpf call relocation to fail with -ENOENT. Pass -fno-ipa-sra and
   -fno-partial-inlining.

3. -ftree-loop-im and -fmove-loop-invariants treat CO-RE LDIMM64
   relocation builtins as pure loop-invariant constants and hoist them
   out of bpf_core_field_exists() conditional blocks into enclosing loop
   preheaders (such as cgrp_old->ancestor_ids in bperf_cgroup.bpf.c).
   When the guarded field is absent on the running kernel, libbpf
   poisons the hoisted LDIMM64 with call 195896080 on an unconditionally
   reachable path. Pass -fno-tree-loop-im and -fno-move-loop-invariants.

4. In sample_filter.bpf.c, accessing members inside the anonymous inner
   structs of union perf_sample_weight and union perf_mem_data_src
   through preserve_access_index kctx->data causes bpf-gcc to emit CO-RE
   relocations rooted at anonymous struct types, which libbpf rejects
   with -EINVAL. Read the named union words (.full and .val) into local
   union variables before extracting the subfields.

5. In lock_contention.bpf.c, collect_zone_lock() and collect_lock_syms()
   use C offsetof() on preserve_access_index structs (pglist_data, zone,
   rq___new, and rq___old), which bpf-gcc evaluates to compile-time
   offsets without emitting CO-RE field offset relocations (computing
   offset 0 for struct rq___new.__lock). Use the 1-argument
   bpf_core_field_offset(ptr->field) and bpf_core_field_exists(ptr->field)
   forms via typed NULL pointers so bpf-gcc emits BTF CO-RE relocations.

6. -fif-conversion, -fif-conversion2, -fssa-phiopt, -fschedule-insns,
   and -fschedule-insns2 convert pointer NULL checks into branchless
   (-ptr | ptr) >> 63 pointer ALU (rejected with "pointer |= pointer
   prohibited") or schedule non-trapping pointer offsets (such as
   rq + lock_off in collect_lock_syms) ahead of their NULL or bounds
   checks (rejected with "pointer arithmetic on ptr_or_null_
   prohibited"). Disable those passes for bpf-gcc builds.

Fixes: 63bdd143c589 ("perf build: Support building BPF skeletons with bpf-gcc")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bpf_skel.mak                       | 19 ++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 15 ++++--
 tools/perf/util/bpf_skel/sample_filter.bpf.c  | 52 ++++++++++++-------
 3 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index 7b7edf506509..400e84c4fd34 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -32,7 +32,24 @@ ifeq ($(CONFIG_PERF_BPF_SKEL_BPF_GCC),y)
   QUIET_BPF_CC = $(QUIET_BPF_GCC)
   IS_LITTLE_ENDIAN := $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
-  BPF_OPTIONS = -Wall -mcpu=v3 -fno-ident -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes \
+  # Disable GCC passes that emit BPF code rejected by libbpf or the verifier:
+  # - -fno-ivopts: keep scalar loop counters instead of PTR_TO_MAP_VALUE
+  #   pointer-equality latches that is_branch_taken() cannot bound.
+  # - -fno-ipa-sra -fno-partial-inlining: avoid .isra/.part subprogram clones
+  #   that omit .BTF.ext func_info records.
+  # - -fno-tree-loop-im -fno-move-loop-invariants: keep CO-RE relocations
+  #   inside bpf_core_field_exists() guards instead of hoisting them into loop
+  #   preheaders where libbpf poisons missing-field relocations.
+  # - -fno-if-conversion -fno-if-conversion2 -fno-ssa-phiopt
+  #   -fno-schedule-insns -fno-schedule-insns2: prevent converting pointer
+  #   NULL checks into branchless (-ptr | ptr) >> 63 pointer ALU or hoisting
+  #   pointer arithmetic above NULL / bounds checks.
+  BPF_OPTIONS = -Wall -mcpu=v3 -fno-ident \
+		-fno-ivopts -fno-ipa-sra -fno-partial-inlining \
+		-fno-tree-loop-im -fno-move-loop-invariants \
+		-fno-if-conversion -fno-if-conversion2 -fno-ssa-phiopt \
+		-fno-schedule-insns -fno-schedule-insns2 \
+		-DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes \
 		-D__TARGET_ARCH_$(SRCARCH) $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
   BPF_SYS_INCLUDES = $(call get_sys_includes,$(CC),)
 else
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 0d9c6f55050e..d4c4ddf0f979 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -925,12 +925,14 @@ struct rq___new {
 
 static void collect_zone_lock(void)
 {
+	struct pglist_data *pgd_null = NULL;
+	struct zone *zone_null = NULL;
 	__u64 nr_zones, zone_off;
 	__u64 lock_addr, lock_off;
 	__u32 lock_flag = LOCK_CLASS_ZONE_LOCK;
 
-	zone_off = offsetof(struct pglist_data, node_zones);
-	lock_off = offsetof(struct zone, lock);
+	zone_off = bpf_core_field_offset(pgd_null->node_zones);
+	lock_off = bpf_core_field_offset(zone_null->lock);
 
 	if (contig_page_data_addr) {
 		struct pglist_data *contig_page_data;
@@ -979,19 +981,22 @@ static void collect_zone_lock(void)
 SEC("raw_tp/bpf_test_finish")
 int BPF_PROG(collect_lock_syms)
 {
+	struct rq___new *rq_new = NULL;
+	struct rq___old *rq_old = NULL;
 	__u64 lock_addr, lock_off;
 	__u32 lock_flag;
 
-	if (bpf_core_field_exists(struct rq___new, __lock))
-		lock_off = offsetof(struct rq___new, __lock);
+	if (bpf_core_field_exists(rq_new->__lock))
+		lock_off = bpf_core_field_offset(rq_new->__lock);
 	else
-		lock_off = offsetof(struct rq___old, lock);
+		lock_off = bpf_core_field_offset(rq_old->lock);
 
 	for (int i = 0; i < MAX_CPUS; i++) {
 		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
 
 		if (rq == NULL)
 			break;
+		barrier_var(rq);
 
 		lock_addr = (__u64)(void *)rq + lock_off;
 		lock_flag = LOCK_CLASS_RQLOCK;
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index e5666d4c1722..9ddac8e5cd78 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -124,14 +124,19 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		return kctx->data->period;
 	case PBF_TERM_TRANSACTION:
 		return kctx->data->txn;
-	case PBF_TERM_WEIGHT_STRUCT:
+	case PBF_TERM_WEIGHT_STRUCT: {
+		union perf_sample_weight weight = {
+			.full = kctx->data->weight.full,
+		};
+
 		if (entry->part == 1)
-			return kctx->data->weight.var1_dw;
+			return weight.var1_dw;
 		if (entry->part == 2)
-			return kctx->data->weight.var2_w;
+			return weight.var2_w;
 		if (entry->part == 3)
-			return kctx->data->weight.var3_w;
-		/* fall through */
+			return weight.var3_w;
+		return weight.full;
+	}
 	case PBF_TERM_WEIGHT:
 		return kctx->data->weight.full;
 	case PBF_TERM_PHYS_ADDR:
@@ -142,35 +147,44 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		return kctx->data->code_page_size;
 	case PBF_TERM_DATA_PAGE_SIZE:
 		return kctx->data->data_page_size;
-	case PBF_TERM_DATA_SRC:
+	case PBF_TERM_DATA_SRC: {
+		union perf_mem_data_src src = {
+			.val = kctx->data->data_src.val,
+		};
+
 		if (entry->part == 1)
-			return kctx->data->data_src.mem_op;
+			return src.mem_op;
 		if (entry->part == 2)
-			return kctx->data->data_src.mem_lvl_num;
+			return src.mem_lvl_num;
 		if (entry->part == 3) {
-			__u32 snoop = kctx->data->data_src.mem_snoop;
-			__u32 snoopx = kctx->data->data_src.mem_snoopx;
+			__u32 snoop = src.mem_snoop;
+			__u32 snoopx = src.mem_snoopx;
 
 			return (snoopx << 5) | snoop;
 		}
 		if (entry->part == 4)
-			return kctx->data->data_src.mem_remote;
+			return src.mem_remote;
 		if (entry->part == 5)
-			return kctx->data->data_src.mem_lock;
+			return src.mem_lock;
 		if (entry->part == 6)
-			return kctx->data->data_src.mem_dtlb;
+			return src.mem_dtlb;
 		if (entry->part == 7)
-			return kctx->data->data_src.mem_blk;
+			return src.mem_blk;
 		if (entry->part == 8) {
+			union perf_mem_data_src___new src_new = {
+				.val = src.val,
+			};
+#ifdef __clang__
 			union perf_mem_data_src___new *data = (void *)&kctx->data->data_src;
 
-			if (__builtin_preserve_field_info(data->mem_hops, BPF_FIELD_EXISTS))
-				return data->mem_hops;
-
-			return 0;
+			if (!__builtin_preserve_field_info(data->mem_hops, BPF_FIELD_EXISTS))
+				return 0;
+#endif
+			return src_new.mem_hops;
 		}
 		/* return the whole word */
-		return kctx->data->data_src.val;
+		return src.val;
+	}
 	case PBF_TERM_UID:
 		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
 	case PBF_TERM_GID:
-- 
2.56.1.750.gf70dc682cf-goog

