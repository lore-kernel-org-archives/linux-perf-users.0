Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5D214211
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593089; cv=none; b=gbuffi/EAgT8TLkhYHLEyNd9jpjybNj/QlGvM5FWOirZ2ILQdQxDzpT4wNf6BMqornmxZdN1CsdJPcu8pviwN8xfAaGlsko1AM7uOny1r0SCZPXnjQ/bwPrwJJCzyrPoepC/9GbXQV461/IrvvN2SpwkU6IaNdFI+QWQ5LLLxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593089; c=relaxed/simple;
	bh=Flm72J3X3TDvLIeQHIIlYLGaUwFP9lEWoVmqSXmZ1ZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BouIkKwebrkAyGzEufbxzZZOa5Kyl+zuEXYC9jr5k5rKHnWlWpObjzDGODudOGXDDxSaQMXiiZYoDwhVvuGO23oQJSFf7abk5EIbANWyx8mQPWVSF7cxSY/MljAljyYeNxzgFjsdMEOdC866PFGk+gTajefA6aCCbfCha5OmLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvj2hamA; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvj2hamA"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab6fe8d375eso239990666b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 06:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593085; x=1739197885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpow2I7r2epfm+Hk8LQFmWg+JcDtDThGqhtUFrwFWBU=;
        b=cvj2hamAai2/9ImeLSc7Cj2UzUCDy61eWDZzMf7BGDoKk4MxmIJkOP/M+rDWihXYwy
         6vNPB/7yzH8/dkfNjy/uXNnWyH+l5Ukfvfd1m191ITGIjpwnQ2ee52YSp4FiPMRLjJ0U
         I2+JHTl4oYueWJDHW/z0o3gEAcSB0PINHZ66YhwnFLvimzKGphiwTDxFaU571Y11E+jK
         opvYJCmU0fem80/q1S4BS/z6JMQf2o3lDw6Te/fGGuD3EUlX2owOQmV1mk/W/0THfBZG
         VLcmHXEuh+Fws/QqiK2pDVtEmMQWIo8l9C1W7rbrCADWlAi4cFPQSqivy7wRDR/IszPS
         vGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593085; x=1739197885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpow2I7r2epfm+Hk8LQFmWg+JcDtDThGqhtUFrwFWBU=;
        b=hi9WZq6Tx7J60mrPt7VLw16o2w0NX6LkxOx38gvUyPjSpku2klCvS1dz5vQfAKm/8r
         vAEeCpsm+eof+DjfhqTccUPbopXZ7ruviRgkM4UPj6o/BK0eQtoKNITKNIPh+21P3XXW
         3i1hh7u6pdJe+ZDFHdeNFG6VJDfhj8O2fTFtLbh8wTqMdjEQKFnCHC6c/GG4zbZljQZZ
         V6PsoOKfycgDRdzgDJpuFYGH/DyX9DZxzNp9s7YGSXKyOlIB9+SX2iq/cFRgo+L1BfJf
         TBESrR5pJcHo4aAiQ56fRQnn9hKlTdBgqR0IwIcQ0Fl2Aka2+TOGJUuRAwk/ckhAbNzL
         uYhg==
X-Gm-Message-State: AOJu0Yw4UlamtS26/ox8mz3YrorqybdhIJO6jO5cLUZHBnUH8TLmiqht
	awakTyf2IrTjTzJh7SCnRGE/TH+pm1WelAPUryXajt7PRWiORwJd3RCSLSMzKjp6Gx39dRscU+a
	UbDR5UQ==
X-Google-Smtp-Source: AGHT+IESlhe7llB78fQq9cR6AMRTd5TrK+EdBY2CrigYoNTWQ4dq1OthZTxMn6H/ntBH49eMrwOOSPH/Mle4
X-Received: from edbfj18.prod.google.com ([2002:a05:6402:2b92:b0:5dc:4848:561d])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51ce:b0:5db:efcc:c19c
 with SMTP id 4fb4d7f45d1cf-5dc5efc4e33mr23491573a12.19.1738593085721; Mon, 03
 Feb 2025 06:31:25 -0800 (PST)
Date: Mon,  3 Feb 2025 15:30:43 +0100
In-Reply-To: <cover.1738592865.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738592865.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <75dd56a2d467515dc354d8fc8d5acd841d63b565.1738592865.git.dvyukov@google.com>
Subject: [PATCH v3 8/8] perf hist: Shrink struct hist_entry size
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org
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
2.48.1.362.g079036d154-goog

