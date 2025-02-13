Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FA2139A2
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437738; cv=none; b=ZR9oQVY95bHgBaTlZ09FPtxr0p3QZYi3+lLLyCRJ+o7UbwhHcr9ks/HjiRMuIKp4auv5akc/9s34OlyEZFes68JRS2b+FAiSGxftpeTPoqIg+u7/94wlPWKr7z4DxtuB/Oj/R3UbLW8t7pSaSeYbXSaHuSRcolER7FIUlfPU9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437738; c=relaxed/simple;
	bh=XfN24f35OJ2vk/m+e6pUtd4T3vptKtMhhNopu2gMhYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bpe+2ufX65EoBL4s//C9tGyfo1DOV0PuRfpdudKNYsx0Awuda1ae8QFvJHoatJyGzfqE4Yb+IYsbhzeOL+ucQ6ydEij9QBnPoEwCDICtjcQR5x0JaeniRfdmraghReRxL2TKf1KPh9jITGfWFjOvCwzKAc9L8XSh1LVOfGmHi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZkTIhPl; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZkTIhPl"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab7e1285f55so73252366b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437733; x=1740042533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgMJGG8J9qWcW3TupvJXIyqnEtZAoqP7JYM6BoJGJhw=;
        b=AZkTIhPlKAICxka45kVGwQQindk/IfD24e6ylVuJ2Qy41Lyoc0Y8G0hEePhcOU/ffu
         1e6EE6n4EaGV33DEAPCPHKkL2/SrL9C4iiyrlhWYz3KuEMfmqqDN9AOQDP8KfZ4Zt4Mv
         VOl6KDnk8DP/DI6SeLA2dxk9PDdO8jAWEMJX29bO2gnMCN6QO6TzFkWMgBtwpdMwZW1g
         t3YmAtnYn+6HgD+sly9+YvZZFSdHVtRa9dojFWGwUQZr17zthwMx/Vs5Fdz4he0rgBik
         azsMrK8L2g/JkYyksdksPoHtiAzLoXRpadm3Vokc/4/hoWJRl2cenB83UqyZQKb1ilgf
         fVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437733; x=1740042533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgMJGG8J9qWcW3TupvJXIyqnEtZAoqP7JYM6BoJGJhw=;
        b=uMn9F92mk+/z0z7u/k+9P1VzclAaxp23/iKU8HQ0whAE+aSXCpzSdWXal27LgdXo8a
         YteBNypss+ywcJVKLHzyuN81O3a2M+/j4E4pGNnMlOBEyN2OA+hYdvjla8sYjwhJM7Es
         BHQ4nd07w25ldVoku2Fp9nn3MVWYYzbtVKgZbTFJnaKzLWpFu5DLVg/BGZzUMJjOsDcb
         E1RW2Hl0deVqpQp/PiRalgaIuufnXkaEKwK4XjPyqLLC0uDnl5GBKK/wVqUS8QhdsunN
         KCGGCQrDpAdy+2U0h9HKLKrZ9oOxtubytmoeh9BnVW42Azc9nhcje4eNgfSMw6cik/yl
         tjyA==
X-Gm-Message-State: AOJu0YyuKpWy9I51msb7O4Hx56pTCUBu7Ru8xFaHaczLUwhW87bgA1jH
	CuWpJQzU3XQplUUfD1re2DGY6F7Qkp+61feklNm603n+u7wZtJojwvpvOz7aNtv//aNZQMwmsJs
	s8sBIFQ==
X-Google-Smtp-Source: AGHT+IESQcCr8+K8FwNJFz7mKQPjJ9j9o1aqQnbiHg2o232jZMxRV6+6jYX0sYilojk6zt9/4a+CTtA4JxXR
X-Received: from ejv1.prod.google.com ([2002:a17:906:3081:b0:ab7:b298:3b76])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:dab:b0:aa6:8cbc:8d15
 with SMTP id a640c23a62f3a-ab7f338ef2fmr650865366b.14.1739437733104; Thu, 13
 Feb 2025 01:08:53 -0800 (PST)
Date: Thu, 13 Feb 2025 10:08:22 +0100
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739437531.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <7c1cb1c8f9901e945162701ba7269d0f9c70be89.1739437531.git.dvyukov@google.com>
Subject: [PATCH v7 9/9] perf hist: Shrink struct hist_entry size
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Reorder the struct fields by size to reduce paddings and reduce
struct simd_flags size from 8 to 1 byte.

This reduces struct hist_entry size by 8 bytes (592->584),
and leaves a single more usable 6 byte padding hole.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Pahole output before:

struct hist_entry {
	struct rb_node             rb_node_in __attribute__((__aligned__(8))); /*     0    24 */
	struct rb_node             rb_node __attribute__((__aligned__(8))); /*    24    24 */
	union {
		struct list_head   node;                 /*    48    16 */
		struct list_head   head;                 /*    48    16 */
	} pairs;                                         /*    48    16 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct he_stat             stat;                 /*    64    80 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
	struct he_stat *           stat_acc;             /*   144     8 */
	struct map_symbol          ms;                   /*   152    24 */
	struct thread *            thread;               /*   176     8 */
	struct comm *              comm;                 /*   184     8 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	struct namespace_id        cgroup_id;            /*   192    16 */
	u64                        cgroup;               /*   208     8 */
	u64                        ip;                   /*   216     8 */
	u64                        transaction;          /*   224     8 */
	s32                        socket;               /*   232     4 */
	s32                        cpu;                  /*   236     4 */
	int                        parallelism;          /*   240     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        code_page_size;       /*   248     8 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	u64                        weight;               /*   256     8 */
	u64                        ins_lat;              /*   264     8 */
	u64                        p_stage_cyc;          /*   272     8 */
	u8                         cpumode;              /*   280     1 */
	u8                         depth;                /*   281     1 */

	/* XXX 2 bytes hole, try to pack */

	int                        mem_type_off;         /*   284     4 */
	struct simd_flags          simd_flags;           /*   288     8 */
	_Bool                      dummy;                /*   296     1 */
	_Bool                      leaf;                 /*   297     1 */
	char                       level;                /*   298     1 */

	/* XXX 1 byte hole, try to pack */

	filter_mask_t              filtered;             /*   300     2 */
	u16                        callchain_size;       /*   302     2 */
	union {
		struct hist_entry_diff diff;             /*   304   120 */
		struct {
			u16        row_offset;           /*   304     2 */
			u16        nr_rows;              /*   306     2 */
			_Bool      init_have_children;   /*   308     1 */
			_Bool      unfolded;             /*   309     1 */
			_Bool      has_children;         /*   310     1 */
			_Bool      has_no_entry;         /*   311     1 */
		};                                       /*   304     8 */
	};                                               /*   304   120 */
	/* --- cacheline 6 boundary (384 bytes) was 40 bytes ago --- */
	char *                     srcline;              /*   424     8 */
	char *                     srcfile;              /*   432     8 */
	struct symbol *            parent;               /*   440     8 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	struct branch_info *       branch_info;          /*   448     8 */
	long int                   time;                 /*   456     8 */
	struct hists *             hists;                /*   464     8 */
	struct mem_info *          mem_info;             /*   472     8 */
	struct block_info *        block_info;           /*   480     8 */
	struct kvm_info *          kvm_info;             /*   488     8 */
	void *                     raw_data;             /*   496     8 */
	u32                        raw_size;             /*   504     4 */
	int                        num_res;              /*   508     4 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	struct res_sample *        res_samples;          /*   512     8 */
	void *                     trace_output;         /*   520     8 */
	struct perf_hpp_list *     hpp_list;             /*   528     8 */
	struct hist_entry *        parent_he;            /*   536     8 */
	struct hist_entry_ops *    ops;                  /*   544     8 */
	struct annotated_data_type * mem_type;           /*   552     8 */
	union {
		struct {
			struct rb_root_cached hroot_in;  /*   560    16 */
			/* --- cacheline 9 boundary (576 bytes) --- */
			struct rb_root_cached hroot_out; /*   576    16 */
		};                                       /*   560    32 */
		struct rb_root     sorted_chain;         /*   560     8 */
	};                                               /*   560    32 */
	/* --- cacheline 9 boundary (576 bytes) was 16 bytes ago --- */
	struct callchain_root      callchain[] __attribute__((__aligned__(8))); /*   592     0 */

	/* size: 592, cachelines: 10, members: 49 */
	/* sum members: 585, holes: 3, sum holes: 7 */
	/* paddings: 1, sum paddings: 4 */
	/* forced alignments: 3 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));

After:

struct hist_entry {
	struct rb_node             rb_node_in __attribute__((__aligned__(8))); /*     0    24 */
	struct rb_node             rb_node __attribute__((__aligned__(8))); /*    24    24 */
	union {
		struct list_head   node;                 /*    48    16 */
		struct list_head   head;                 /*    48    16 */
	} pairs;                                         /*    48    16 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct he_stat             stat;                 /*    64    80 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
	struct he_stat *           stat_acc;             /*   144     8 */
	struct map_symbol          ms;                   /*   152    24 */
	struct thread *            thread;               /*   176     8 */
	struct comm *              comm;                 /*   184     8 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	struct namespace_id        cgroup_id;            /*   192    16 */
	u64                        cgroup;               /*   208     8 */
	u64                        ip;                   /*   216     8 */
	u64                        transaction;          /*   224     8 */
	u64                        code_page_size;       /*   232     8 */
	u64                        weight;               /*   240     8 */
	u64                        ins_lat;              /*   248     8 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	u64                        p_stage_cyc;          /*   256     8 */
	s32                        socket;               /*   264     4 */
	s32                        cpu;                  /*   268     4 */
	int                        parallelism;          /*   272     4 */
	int                        mem_type_off;         /*   276     4 */
	u8                         cpumode;              /*   280     1 */
	u8                         depth;                /*   281     1 */
	struct simd_flags          simd_flags;           /*   282     1 */
	_Bool                      dummy;                /*   283     1 */
	_Bool                      leaf;                 /*   284     1 */
	char                       level;                /*   285     1 */
	filter_mask_t              filtered;             /*   286     2 */
	u16                        callchain_size;       /*   288     2 */

	/* XXX 6 bytes hole, try to pack */

	union {
		struct hist_entry_diff diff;             /*   296   120 */
		struct {
			u16        row_offset;           /*   296     2 */
			u16        nr_rows;              /*   298     2 */
			_Bool      init_have_children;   /*   300     1 */
			_Bool      unfolded;             /*   301     1 */
			_Bool      has_children;         /*   302     1 */
			_Bool      has_no_entry;         /*   303     1 */
		};                                       /*   296     8 */
	};                                               /*   296   120 */
	/* --- cacheline 6 boundary (384 bytes) was 32 bytes ago --- */
	char *                     srcline;              /*   416     8 */
	char *                     srcfile;              /*   424     8 */
	struct symbol *            parent;               /*   432     8 */
	struct branch_info *       branch_info;          /*   440     8 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	long int                   time;                 /*   448     8 */
	struct hists *             hists;                /*   456     8 */
	struct mem_info *          mem_info;             /*   464     8 */
	struct block_info *        block_info;           /*   472     8 */
	struct kvm_info *          kvm_info;             /*   480     8 */
	void *                     raw_data;             /*   488     8 */
	u32                        raw_size;             /*   496     4 */
	int                        num_res;              /*   500     4 */
	struct res_sample *        res_samples;          /*   504     8 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	void *                     trace_output;         /*   512     8 */
	struct perf_hpp_list *     hpp_list;             /*   520     8 */
	struct hist_entry *        parent_he;            /*   528     8 */
	struct hist_entry_ops *    ops;                  /*   536     8 */
	struct annotated_data_type * mem_type;           /*   544     8 */
	union {
		struct {
			struct rb_root_cached hroot_in;  /*   552    16 */
			struct rb_root_cached hroot_out; /*   568    16 */
		};                                       /*   552    32 */
		struct rb_root     sorted_chain;         /*   552     8 */
	};                                               /*   552    32 */
	/* --- cacheline 9 boundary (576 bytes) was 8 bytes ago --- */
	struct callchain_root      callchain[] __attribute__((__aligned__(8))); /*   584     0 */

	/* size: 584, cachelines: 10, members: 49 */
	/* sum members: 578, holes: 1, sum holes: 6 */
	/* paddings: 1, sum paddings: 4 */
	/* forced alignments: 3 */
	/* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));
---
 tools/perf/util/hist.h   | 8 ++++----
 tools/perf/util/sample.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 29d4c7a3d1747..317d06cca8b88 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -239,16 +239,16 @@ struct hist_entry {
 	u64			cgroup;
 	u64			ip;
 	u64			transaction;
-	s32			socket;
-	s32			cpu;
-	int			parallelism;
 	u64			code_page_size;
 	u64			weight;
 	u64			ins_lat;
 	u64			p_stage_cyc;
+	s32			socket;
+	s32			cpu;
+	int			parallelism;
+	int			mem_type_off;
 	u8			cpumode;
 	u8			depth;
-	int			mem_type_off;
 	struct simd_flags	simd_flags;
 
 	/* We are added by hists__add_dummy_entry. */
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 70b2c3135555e..ab756d61cbcd6 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -67,7 +67,7 @@ struct aux_sample {
 };
 
 struct simd_flags {
-	u64	arch:1,	/* architecture (isa) */
+	u8	arch:1,	/* architecture (isa) */
 		pred:2;	/* predication */
 };
 
-- 
2.48.1.502.g6dc24dfdaf-goog

