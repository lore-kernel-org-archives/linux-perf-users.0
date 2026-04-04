Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584033372D
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274218; cv=none; b=JrulyVftgCfC1IfZbcEEvteHhNtZ8xgDajWkqG2NyQMP5CFzzZV67QZuWrW4nFXcaUCC+5xfLe8U1ACZldV7E4WaWoTnXTqPDKEfbUZWXFaeeJn2zVXgMBcJH0G1luu7NUJVk7Di9b4x88jKkYOJc8RhaIS013967VcWdoUKQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274218; c=relaxed/simple;
	bh=LJ0rCMMxmzCEmLBaFftojzkhfuDC5lZaRit25xvqCjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jDA/aYlb9/cii5Wc8l/6igJVRCxmR4qHG5vZoXvAFB8JNU7qUtrIPWJoDzmvBEKCV0kvPTUhMPW5zm4YjrU3pXqccAohwgm91Qc4oxC/VYPPiPjq+3SizBTowVVUDtwwl0EwFFMWk2Flfv2bQrpi5DK/aUlJs7xFPEeWQ4zf2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhc9uc0r; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhc9uc0r"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so15730134eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274216; x=1775879016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0EJppbfK+NrXWp6WattbotTNCAPlbqRovRFGgZkVK3U=;
        b=rhc9uc0r0kdEX4KIJbcGbJIR0QCAlJEk44J+tb9scrBNf/3QjEVy3QERuyYGh6dUEw
         7E+Ur2lkP1g2+lhtf0qZeVx9qyR+a9sp/hgeP7OWG1CJC7+nmmL+0wJr8w86/nJPoT/Z
         WuOifx9vk8vaWK8g23x9wCBnetPdUrMw68Yfo3KrpqgaNkslarEhS5uuoo2gXUbnsviY
         Rhlu6bk/91N2W2hLc6h1rafDdJ7wkhJ/c3+BuzjjtHnO+/CFMkAnA/VeUEbTAezGNn4j
         NYmmjqDOsKSrPqhlCDiDSO8GZcYTK8Fp0ZtyfBA+WZ7im+i+0e84dz6ZObDnk/FVhRm7
         EFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274216; x=1775879016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EJppbfK+NrXWp6WattbotTNCAPlbqRovRFGgZkVK3U=;
        b=ggO56TRbI9wLxUwxAE+5NK/S+WvEPzbH+W1y4N6NSRLwCi8Ct5NJP79sCZ7l4uU6d5
         NWjJWbh/bGO+zIVBHZAmNaBOQHZsq4YupUOPewV5SenaTshQBBZMUQG+4AtPrRj84dG9
         dktGw/qWra13MH6lHbUfgorpWOOSEt0a3HeyXzLr8bhEbZQBml3kCjD+PdGk/CoK2DLk
         OaXuJyYGpivnEqsQQYYjgtUyqepkx6060d8SA/8poov7phRnXOR59O5KhLqC0/X/IIpX
         BV04Qsxqa5qBB5Di+Nvij4RPZpsKWUqugvfWNwdxgRc1TOQec3CXqM+p8gYOHmIH/1j5
         w1tw==
X-Forwarded-Encrypted: i=1; AJvYcCWFsrPG8JdN3WmlVbPpALJfbNYUjQE5f4aI5GUIMPX3i1lhDPI2MDwrAwMFA7ZtrBwn2Xn1kzWl4kwbxcCzic3n@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFCPTI2VIU0IxbZdWRSuJnyU3LzsHKoepoS9AUIsGIq2tQOPv
	Pg3dEjwi51q+1cI7soeyDFdeDpKeb75LwFRnBm/DnYz5yGg/wVfiGGT0QwCiBEHZNRJFtRrHOsa
	KLFOLO5bz2g==
X-Received: from dyckg5.prod.google.com ([2002:a05:7301:d185:b0:2c1:264d:62f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:748b:b0:2c7:2c0b:f33b
 with SMTP id 5a478bee46e88-2cbfba8e8eamr2808115eec.20.1775274215695; Fri, 03
 Apr 2026 20:43:35 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:01 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-2-irogers@google.com>
Subject: [PATCH v6 01/25] perf sample: Document struct perf_sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
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
2.53.0.1213.gd9a14994de-goog

