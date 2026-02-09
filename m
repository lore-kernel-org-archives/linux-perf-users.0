Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CD38759D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658846; cv=none; b=OgxtXGZzgPx+HWBTAhZ7KwHDb8a67XyWlXzhoxD3+lOQF6rMzREH50HDHBnNJR2FLsmmnuqTOWALwubnKTI7QhjqDhv0wGWKeECvnE5QycOncmki/4HJG93EP4RJMvzVWqbAkMLNFm1AWZw9+Dm47bw+Vp77q4t4cUi7O55r1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658846; c=relaxed/simple;
	bh=W2k2Dv572oESzD/6aH/e5XkoOB+eYC9gSnqV3dsFzHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mAXhQa++WtVD7zcsh7788me+n42QDrtRdYMjJKtKAVS0FqNknBMOWVgrKkQwOfL1Zns/nv3873h5siqrxemIkAtxpFGyQym89RWKX91mGmzB55WL+p18JWbwcHMorQXoZ5JHqmpKBBg7RsbtwDFTQFR44lWQYEGDRLGzqrXSIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXHvF1jd; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXHvF1jd"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123349958b2so6574612c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658845; x=1771263645; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhrgD/0R8fUND7aFxU6KhFICaZF4XG2WJzxDe3FyZ6Q=;
        b=gXHvF1jd+fx7F/8YJhJAnjIjtWcsCc6IbLsE4RiIcwhFLjoG1AnUfzUwnLisjJz+3d
         djV5F2l5gTy5yMqDG/8FeFDaxvUdSDbYjMWtMBMxfiMP0htdAslUtSIBGo4M+lBXIbnn
         ulnSKJLeALfZLfvkkTDsa+4OyLPvvCEkdRiK7rKeVwxj4IMlxANwUPWH6NF1EPJGYwDe
         4yYbMV+lk2dHtmJy41YXqRnn7J4QQ8vyFlCOgdolvvdn6Gi92h3MJDPK5OxIi0bWS9Lj
         S2r/PQpseN317HQJ3P+JdamHLvISRLH2pc7Nwu3OwyIuiFT6NKtKiXyFhCtSaBvib4Px
         ZJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658845; x=1771263645;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhrgD/0R8fUND7aFxU6KhFICaZF4XG2WJzxDe3FyZ6Q=;
        b=cvffFiIsJQ/oJ2k35abtstqAYN4+9SGv+TzAxXEUMXsnvIL6++TILoujICypxl5XLv
         DIy4QM0nyJMja+eMKkOoTo4vM/ev7vqM6PzK9nr/mUbuT067aOaRZqwqfL6Luqxcxe8d
         Nwxe/S+Zbf7PoTYlHGF2EHf+fdDQk3JjYjEjEBzopNrF37wOaQMKe4soOw0IKZNhe3E6
         sQ/7bD+En/zu6ShKCwWK3LhbaD4CQHx+yB1+6wiiQPEvAHESNLwvfU6/2ODkiJRYGsSz
         dbaebEe1DKBgdHCjgjVeW62u1AnwowPcOoQpvcXeLMTE8KJRBQTSXfVHy/hBB6bYLoYe
         y+8w==
X-Forwarded-Encrypted: i=1; AJvYcCUKc0ntaRpgq4g4fhKmRXPJiueCPDt2P85PwjrHaakupxW4PPnYoT1XytOl2tjYN/c6Cil47XIfsAhU+ZVY1g9X@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZdH8i4esjlpEn7gIYdFjZCp2hvNxWwyPVs+TJ0dZp7BwT7kk
	mWyGtcWrYPAdYjXTWVozX/nZphw+zH68oBo2FW45GRbn35BKMvnpMtstDALFBxNCoMoKV+h47qR
	R4QjCbcflPQ==
X-Received: from dll7.prod.google.com ([2002:a05:7022:207:b0:126:f8d3:3aea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:220:b0:11a:3734:3db3
 with SMTP id a92af1059eb24-12704003559mr7403170c88.32.1770658845121; Mon, 09
 Feb 2026 09:40:45 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:08 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-2-irogers@google.com>
Subject: [PATCH v1 01/25] perf sample: Document struct perf_sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add kernel-doc for struct perf_sample capturing the somewhat unusual
population of fields and lifetime relationships.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample.h | 90 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 3cce8dd202aa..3fd2a5e01308 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -81,47 +81,131 @@ struct simd_flags {
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
+	/** @insn_len: Instruction length from auxiliary events like intel-pt. */
 	u16 insn_len;
+	/**
+	 * @cpumode: The cpumode from struct perf_event_header misc variable
+	 *           masked with CPUMODE_MASK. Gives user, kernel and hypervisor
+	 *           information.
+	 */
 	u8  cpumode;
+	/** @misc: The entire struct perf_event_header misc variable. */
 	u16 misc;
+	/** @ins_lat: Instruction latency information from auxiliary events like intel-pt. */
 	u16 ins_lat;
 	/** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_cyc. */
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
+	/** @raw_data: Byte aligned pointer into the original event for PERF_SAMPLE_RAW data. */
 	void *raw_data;
+	/** @callchain: Pointer into the original event for PERF_SAMPLE_CALLCHAIN data. */
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
+	/** @read: The sample event PERF_SAMPLE_READ counter values. */
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
2.53.0.239.g8d8fc8a987-goog

