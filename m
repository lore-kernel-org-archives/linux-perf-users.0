Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EB3F8E09
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962644; cv=none; b=PXUFOupvWTHfALUQFvbPZPwmvpjjXnFwlwwvz/YOqVkTZUu8Fw4j7a3dijHHBKv2i6lDLkmVB38pJrZMltELwAue1+vwNp/CJMBjzh03pez1dd1lOvtoFDMWT8G38EYWP2WdsemRGlJnHDVD/NGAcgcdD1ix6VQzohWYDGH6r9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962644; c=relaxed/simple;
	bh=p+8j09y1FyGo9ACvwOtcz+yNEqZiJ3Fz0Rzzqj3M3sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jYqRUnbC2QT6M7BlBTb3ISxxypdO0D9S7ke7GQ2fPCE3MWox9oKrfJCN4XSIjXtGftY3ZbGskNLbSKl2IKHS3bSUYofEaw63IzBYFckC6K+xBqwGBByL64LrPhwCzv7Pm9XQTtCwF7ExDrfXPv6vR9j2pp6tgs1kDTwDIgFo8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWF4xwI1; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWF4xwI1"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12737f276a2so1389615c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962642; x=1774567442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGwLOw5TQbWpR3/XxIqkjD3gfTI56RqD3egsR4RKFmo=;
        b=dWF4xwI1rY7lOoHSHonmV0VHbNZ0OEJ6E0bB/t5ZKieY6FpmUUNIp+JqEV+H0KzLmV
         /9gVsxxf/o3WnCtduK8DlknF3kkR3wElITgyOtYqmMJWWcC8Nxl61Fp2W+DZXHEdYSAL
         aqVESeDZjUkP/gbCk8lhvh2zkNePmfSoLdduK4/LJnodIvCF+fkSZRVupm9aDlZj6fvY
         u/2jNgfBBGBr+7pX0vVHI3Hmlb6UUQAbNOjztlx6/GWMjkPpfxvu/Gd8+0edX4uO6dry
         guIV17EEdU5AasMfsBlU+G4EL/GIm1nlhEQzXjEMETM+/VBfoVJjaCHAJl5UmPreuTN1
         5iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962642; x=1774567442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGwLOw5TQbWpR3/XxIqkjD3gfTI56RqD3egsR4RKFmo=;
        b=hGzjTIyoeZmYzactZHX4FkOBeZFNP8BAQCjps9+GYNnPtmOG2CUh5y1Avi8i8RCGHM
         l/NUCkmJdRGDxAsJSwcu7EFFUliXioo/fLwBHdMWk4KjzOz4Bouh4Bg09BhOgaDsefFx
         Kj6tWDD7/mso5qdXkgkSH2bbUCHYYuJCZEmdum0HrRpocyjhvfWLjjkPQ4lluGZ2mdco
         XggmuEeCR/XHENo+jciahA4QIcttoB01bdhues5BgGJxw5dwbRQmzsvh4+zqPfw6fseM
         e+AK6jNhdULDOXlzNuZCqhn/D1ZUwmohCAIpXBe4PLfVRPfm23zpn2mVPysFd+8Egg58
         uZeg==
X-Forwarded-Encrypted: i=1; AJvYcCXu33DYGZD1tYVtbb2tDsfSgA7FVaMBJdkkCjPM6Bypf2IqmKXa8etgV9sH9WraMEukZpRZWxymzKjWF/bwGZyj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0FfkZk+i8yllhT0+TMQdlYW4Wp5lsLRYjd+anS0oF6x6tQ75
	ycCG6ZT6zHqpKw37CzHUfghFeyqCwJw5vrtDk/rGvPZ3st+R/ErFGIOtO7Wm8APL+IJ3LEWPfhR
	Id/7oRg/UPQ==
X-Received: from dlbqq5.prod.google.com ([2002:a05:7022:ed05:b0:128:eccd:75b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:220c:b0:12a:67b7:53f8
 with SMTP id a92af1059eb24-12a7263d550mr536013c88.8.1773962641535; Thu, 19
 Mar 2026 16:24:01 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:10 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-2-irogers@google.com>
Subject: [PATCH v2 01/25] perf sample: Document struct perf_sample
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
 tools/perf/util/sample.h | 110 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 3cce8dd202aa..88ff154b630c 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -81,47 +81,149 @@ struct simd_flags {
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
+	 *            alignment reasons this should always be a multiple of
+	 *            sizeof(u64) + sizeof(u32).
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
+	 *                      user callchain marker was encountered. When set
+	 *                      the callchain entry is allocated.
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
+	 *             data. If deferred_callchain is not set, it just points to
+	 *             data in the mmap buffer and it should not be freed.
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

