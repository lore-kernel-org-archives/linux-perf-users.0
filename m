Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489635CBC4
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994122; cv=none; b=qQ/81LKZvHHnoslfK/sZBa7tcsE6zFvvVLqH8bW6/gBvQwuURXvfwIrcok6u1ZYt5OX3V494lUjCtirtolkKULGkqCs3I2xcbum+DhLPBzzuWJnNLVr3yYxtI8k5cUnVwPDKDmAmDYlu8GlY98hnDmlgbmt4pBtb7kJbzhP8w+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994122; c=relaxed/simple;
	bh=0J+tzsB/zv3tCoAAxLPG2GzAUsuid824vgLLijslKCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MOQ1Xl5JHtqniU2d7Nv2KUg/g2yU5gZa0wVYXFF4tJvGSbiTByq60GasVTF43zLcoh5yK/eOCWSLWOadxZlDlfWsiMBrF2yqbRq6cVx1t5UxkxOgkTO5TyPEl9CsCKBdxW6wmYD9lmUeK9G4OuxjWhtpF2IZLi6T+QuYbYjqHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eaBQVoRJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaBQVoRJ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0c85c38acso902351eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994120; x=1774598920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9M0DEriZZ8im4zaxxybCqkXNkamyBHNGLBSXPw4d3I=;
        b=eaBQVoRJv1Cd/sNyS3QnmhMzQ9VXm5Ak4U8jc0QroE+66/6KDgI6cgV0wc38gJNEaD
         1s1RDwF9BtRoA4oaXU9vnlKBx34rP4VqJekSFmstUKOTg0YcUgRvBR1RdcUpndtYDRhU
         Bb400uRITpPuhs3bbXgy0xuZY9T7QTmyAt9WmjEG3ULK/tno+/gBbDUQQefDNUbRWXo8
         T0aDSJw48K38MKjsSxGdZsirJOkR7gBdodINCQcVO6hsXwjSfZmDiUuHvDXxt3oHubn7
         RD60SaJ/eFOn2H3MLcsej529T9tLPpUjSOojwiqgvsmKOfS/9ZU/MQbdInsK3Yt2Rozw
         1Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994120; x=1774598920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9M0DEriZZ8im4zaxxybCqkXNkamyBHNGLBSXPw4d3I=;
        b=QLcm/AJW6J5fin5vX1+ZGbLeOxl3VLs5cNhlcvQIjFvLIJT1AZLnYdqKNTp5L9bDyF
         yvGniRYBgNgayCWmwB0vuoCVPySomPXC1sGRI2yEHTyAciGG/ydzG0X+mJLbl5MrZdUz
         uLFJluACXjE2CFEddcrMoGcQ7U4iD5hLt/qq5S0bCgOhaXIxUGwhB31sQYNFfagwfQlE
         wRxEzFpj8dayxCWp/XSeJV761k4x4v260z77KGsF+jilEuQQnxJFHNJln275xdb0YxLm
         lAFaAQtrBRjhiu/lOcrgiK+jxgwLL8+ubwlZulK/r7f/Zj/h1icUnSi2Pj1timi6i1r8
         wS3g==
X-Forwarded-Encrypted: i=1; AJvYcCX8ajjUADE/GZnmUrOQ/Av0eshS0gxg2a9EVy/KVdqSl99YaoSwB7SXTV9X1rgTk9kz8Lv/8uhPloXlgHeL3EHY@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMvZwZWdniHjt3p4G3r9ewpQy3jXb2dkU1yVPNdZkJ8fcml8l
	oDd4VQ2gl+iC8yPN5FPtNaAdOfsO5/PzqivVKCuYJqHnBMYuLeDcAlqM1yD3I5EdOPPDkuXqRaj
	32zH3/cp8iA==
X-Received: from dyff16.prod.google.com ([2002:a05:693c:8050:b0:2c0:d493:ae08])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:572a:b0:2be:171c:5040
 with SMTP id 5a478bee46e88-2c1095a632bmr1057515eec.3.1773994120285; Fri, 20
 Mar 2026 01:08:40 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:10 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-2-irogers@google.com>
Subject: [PATCH v3 01/25] perf sample: Document struct perf_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Add kernel-doc for struct perf_sample capturing the somewhat unusual
population of fields and lifetime relationships.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample.h | 109 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 3cce8dd202aa..8d4ace0e6594 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -81,47 +81,148 @@ struct simd_flags {
 #define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
 #define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
 
+/**
+ * struct perf_sample
+ *
+ * A sample is generally filled in by evlist__parse_sample/evsel__parse_sample
+ * which fills in the variables from a "union perf_event *event" which is data
+ * from a perf ring buffer or perf.data file. The "event" sample is variable in
+ * length as determined by the perf_event_attr (in the evsel) and details within
+ * the sample event itself. A struct perf_sample avoids needing to care about
+ * the variable length nature of the original event.
+ *
+ * To avoid being excessively large parts of the struct perf_sample are pointers
+ * into the original sample event. In general the lifetime of a struct
+ * perf_sample needs to be less than the "union perf_event *event" it was
+ * derived from.
+ *
+ * The struct regs_dump user_regs and intr_regs are lazily allocated again for
+ * size reasons, due to them holding a cache of looked up registers. The
+ * function pair of perf_sample__init and perf_sample__exit correctly initialize
+ * and clean up these values.
+ */
 struct perf_sample {
+	/** @ip: The sample event PERF_SAMPLE_IP value. */
 	u64 ip;
-	u32 pid, tid;
+	/** @pid: The sample event PERF_SAMPLE_TID pid value. */
+	u32 pid;
+	/** @tid: The sample event PERF_SAMPLE_TID tid value. */
+	u32 tid;
+	/** @time: The sample event PERF_SAMPLE_TIME value. */
 	u64 time;
+	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
 	u64 addr;
+	/** @id: The sample event PERF_SAMPLE_ID value. */
 	u64 id;
+	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
 	u64 stream_id;
+	/** @period: The sample event PERF_SAMPLE_PERIOD value. */
 	u64 period;
+	/** @weight: Data determined by PERF_SAMPLE_WEIGHT or PERF_SAMPLE_WEIGHT_STRUCT. */
 	u64 weight;
+	/** @transaction: The sample event PERF_SAMPLE_TRANSACTION value. */
 	u64 transaction;
+	/** @insn_cnt: Filled in and used by intel-pt. */
 	u64 insn_cnt;
+	/** @cyc_cnt: Filled in and used by intel-pt. */
 	u64 cyc_cnt;
+	/** @cpu: The sample event PERF_SAMPLE_CPU value. */
 	u32 cpu;
+	/**
+	 * @raw_size: The size in bytes of raw data from PERF_SAMPLE_RAW. For
+	 *            alignment reasons this should always be sizeof(u32)
+	 *            followed by a multiple of sizeof(u64).
+	 */
 	u32 raw_size;
+	/** @data_src: The sample event PERF_SAMPLE_DATA_SRC value. */
 	u64 data_src;
+	/** @phys_addr: The sample event PERF_SAMPLE_PHYS_ADDR value. */
 	u64 phys_addr;
+	/** @data_page_size: The sample event PERF_SAMPLE_DATA_PAGE_SIZE value. */
 	u64 data_page_size;
+	/** @code_page_size: The sample event PERF_SAMPLE_CODE_PAGE_SIZE value. */
 	u64 code_page_size;
+	/** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
 	u64 cgroup;
+	/** @flags: Extra flag data from auxiliary events like intel-pt. */
 	u32 flags;
+	/** @machine_pid: The guest machine pid derived from the sample id. */
 	u32 machine_pid;
+	/** @vcpu: The guest machine vcpu derived from the sample id. */
 	u32 vcpu;
+	/**
+	 * @insn_len: Instruction length from auxiliary events like
+	 *            intel-pt. The instruction itself is held in insn.
+	 */
 	u16 insn_len;
+	/**
+	 * @cpumode: The cpumode from struct perf_event_header misc variable
+	 *           masked with CPUMODE_MASK. Gives user, kernel and hypervisor
+	 *           information.
+	 */
 	u8  cpumode;
+	/** @misc: The entire struct perf_event_header misc variable. */
 	u16 misc;
+	/**
+	 * @ins_lat: Instruction latency information from weight2 in
+	 *           PERF_SAMPLE_WEIGHT_STRUCT or auxiliary events like
+	 *           intel-pt.
+	 */
 	u16 ins_lat;
-	/** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_cyc. */
+	/**
+	 * @weight3: From PERF_SAMPLE_WEIGHT_STRUCT. On x86 holds retire_lat, on
+	 *           powerpc holds p_stage_cyc.
+	 */
 	u16 weight3;
-	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
-	bool deferred_callchain;	/* Has deferred user callchains */
+	/**
+	 * @no_hw_idx: For PERF_SAMPLE_BRANCH_STACK, true when
+	 *             PERF_SAMPLE_BRANCH_HW_INDEX isn't set.
+	 */
+	bool no_hw_idx;
+	/**
+	 * @deferred_callchain: When processing PERF_SAMPLE_CALLCHAIN a deferred
+	 *                      user callchain marker was encountered.
+	 */
+	bool deferred_callchain;
+	/**
+	 * @deferred_cookie: Identifier of the deferred callchain in the later
+	 *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
+	 */
 	u64 deferred_cookie;
+	/** @insn: A copy of the sampled instruction filled in by perf_sample__fetch_insn. */
 	char insn[MAX_INSN];
+	/** @raw_data: Pointer into the original event for PERF_SAMPLE_RAW data. */
 	void *raw_data;
+	/**
+	 * @callchain: Pointer into the original event for PERF_SAMPLE_CALLCHAIN
+	 *             data. For deferred callchains this may be a copy that
+	 *             needs freeing, see sample__merge_deferred_callchain.
+	 */
 	struct ip_callchain *callchain;
+	/** @branch_stack: Pointer into the original event for PERF_SAMPLE_BRANCH_STACK data. */
 	struct branch_stack *branch_stack;
+	/**
+	 * @branch_stack_cntr: Pointer into the original event for
+	 *                     PERF_SAMPLE_BRANCH_COUNTERS data.
+	 */
 	u64 *branch_stack_cntr;
+	/** @user_regs: Values and pointers into the sample for PERF_SAMPLE_REGS_USER. */
 	struct regs_dump  *user_regs;
+	/** @intr_regs: Values and pointers into the sample for PERF_SAMPLE_REGS_INTR. */
 	struct regs_dump  *intr_regs;
+	/** @user_stack: Size and pointer into the sample for PERF_SAMPLE_STACK_USER. */
 	struct stack_dump user_stack;
+	/**
+	 * @read: The sample event PERF_SAMPLE_READ counter values. The valid
+	 *        values depend on the attr.read_format PERF_FORMAT_ values.
+	 */
 	struct sample_read read;
+	/**
+	 * @aux_sample: Similar to raw data but with a 64-bit size and
+	 *              alignment, PERF_SAMPLE_AUX data.
+	 */
 	struct aux_sample aux_sample;
+	/** @simd_flags: SIMD flag information from ARM SPE auxiliary events. */
 	struct simd_flags simd_flags;
 };
 
-- 
2.53.0.959.g497ff81fa9-goog

