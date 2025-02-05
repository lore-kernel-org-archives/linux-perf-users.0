Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F201FDE3A
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772928; cv=none; b=Tv2CJmwgknqXdR0VL6c76YExn6tNcMpFZUVlAyxeQ+e8H43t71AjW4GASXeC17ZfLFkwn1qSMvrHlmiduVvRqMCE8BQEYGpEkj6J9aOn1glKVp61Ulxfj8baows/UuPcRbq95tW7LBT/yXZCivXsZfJlMj8kiUKIPYaPUUzdFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772928; c=relaxed/simple;
	bh=Flm72J3X3TDvLIeQHIIlYLGaUwFP9lEWoVmqSXmZ1ZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G3QDQyJ9r2P1sKZ+i9Ezqf5myf2NkNR+UF68sA2uKTTJ0mNBl93Z3iRbFWDhyMR2yagbW1VKswYnMD7Y96LqbbVjmSWuhcd+jjY+7+U0z92YHzJF04kd09OfA8IOzQPwthPKXXAMyjMLZxJ7WRrDFylXhnS9xBGKPhUOqD5avJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXV4Sr15; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXV4Sr15"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dcd3120b24so1532362a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738772924; x=1739377724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpow2I7r2epfm+Hk8LQFmWg+JcDtDThGqhtUFrwFWBU=;
        b=eXV4Sr15c+apJtHWDWhJ5OWoqs1y8579w48cXMrV4qQcJ9/4jLN9y2ChMSN4AWZQtW
         kO6O6T0yXX8evZ4uU10bQPlofDWWn7vRpm9YOfFiArgBK9322hw6LBy5lgzHbFaq1j/P
         9K6Ac6BGm5lsZqjBDRFml9tDWPgAFIv1njDQLgk83QT0uPE6RNuD46lteWnDwztuS3PD
         PKgA7qwlFyw0we30DIL4NRi65yBLyflGdT9N749tUBRLWRTuH00rNvn/OKNiyzGer1by
         wkL1NS+geh1BIAnKQWun0PbKFPr/el429+Xr62TAu5B0PzLnSP6cWm2KXX495HMlvgv4
         bz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772924; x=1739377724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpow2I7r2epfm+Hk8LQFmWg+JcDtDThGqhtUFrwFWBU=;
        b=QvGGrrnlbJ1IkZbSd1QfUvFEykml1ljGivdZkZ7Wf2ntfV3bPdKbvB6fjyLZePVDpJ
         YjSxhOPuTXCkBQH7quZ05HimN0qMyWg2VujnI1kE5fLquxJzUMrtMyjfawesFZknTz1p
         943di4/d8vap2cNBRzBV7650X1QqoNXqRaVcFIyf/Di1dEboBBsyDmLo8VJkW0yZP2pZ
         UitfKMiFrAuxCKkvkKRf9EDTnUoDpiJGoSyenOPKlNsiidpg1gh/CHILjSQ1c0zEG6Zm
         sJ3+CLikFmyTXresxzKhFfh5HcoN9Y2GP4KUExxMBZRJMesukRNmMl3ri+47GJL0CEaF
         Pq5Q==
X-Gm-Message-State: AOJu0YyTONSvcBJGUWqAjCYkqy4sp/c3QEuNAcZXO5SdPYXtFcUwsc/2
	V1UQy1kUq8OS7rPuEDtK/6y2v0+5cEO2IjrAOP6LJA7eV2Nj/0iVCesaK1nKZ4fQe3c3aUMmLa9
	0IZCdqw==
X-Google-Smtp-Source: AGHT+IEWO5sJTSfqHdmMX8GbBn26uPrUyFmrXzY3rYMz3tkbrHB3NIxMZxhjCRe2TdCG65Yo+MIiPi2RQ9Sb
X-Received: from edbeo6.prod.google.com ([2002:a05:6402:5306:b0:5dc:e158:572c])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:13c8:b0:5dc:7fbe:730a
 with SMTP id 4fb4d7f45d1cf-5dcdb58fb0cmr3841951a12.0.1738772924696; Wed, 05
 Feb 2025 08:28:44 -0800 (PST)
Date: Wed,  5 Feb 2025 17:27:47 +0100
In-Reply-To: <cover.1738772628.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <7aa4afff6a1aeaef671393d414f142bec0ead68b.1738772628.git.dvyukov@google.com>
Subject: [PATCH v5 8/8] perf hist: Shrink struct hist_entry size
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
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

