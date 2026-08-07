Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D13BA246
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087114; cv=none; b=sxKMh1HtCqowo8d138I2RJvdL6YroLP/zbAyBgkNObkwgZqRy0iYsHYRxgROSP7My9BiB8ZOBvlxm2aR+Q2Gq/CppaInsV0EB1fM0tm6JFYVELTzisurdj7CHMD/aujPBNKw0MxGFV61KBx2zTj/pReWcD/3fCcWe6cjDnOCGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087114; c=relaxed/simple;
	bh=cpzuJlngGAm43tFscMlXRZnMARJWPTr0CBcPuQjRuwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OkSMPcGIyTpHK4whzjvYtuUs/TEgyjv0O/9clWXal1QCjmd0CpqB1iIpGQWdoT1UjhvA/sXRaXR4RAHRfjAS9iUfHhhORrFu5aikY0LbH5P59f6/NAnyki2tDZDNocswHtjNd5IagZ9FG9zahgu19EO5oklK6B238AITNINrduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmz1Nh3U; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmz1Nh3U"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso3791322a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087111; x=1786691911; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bcl1RSiBLZ6miVSqvsuamblwEoHgWcooZQBMrgJQ6Do=;
        b=tmz1Nh3UxVxDDDGNhoshXuYXF3gKWvhFUBSf5Z0hK8J7224n2DQQNB8CN2LWP5nu9S
         WfcD45hBaOWS3wxFtyZr/zJVSBcicvWGbPZnN+kZfuQlg8uRaTDxXDXIkKwMOGiRvLMr
         SAwFnnqaYeEm3PSi3dCNleIQczulVaZsauFWymsE/9Qec4Vre5nrlFGkElH4F/q+QSj2
         1zN3vDOy9Ip9OFnx0qsDkBjiG0+qWjJYLwin+7D1WrZfyF2e6XqS9YxnyRM6UYGJdejT
         nnchRa6BI6F7sytMV2+4pj+KWn7ybS82BZw6+P23upCBcdT8VYNu6PJe8vt/5q+L4Ajh
         Q5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087111; x=1786691911;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bcl1RSiBLZ6miVSqvsuamblwEoHgWcooZQBMrgJQ6Do=;
        b=D3dfdGuoh2+VDFh6/k1R5ZKEJR7IuNGMvWIi8XsrvGmJlK/Va1IKxwSqt7+/1cQuU+
         ScU4y3+wO/35Oy/HqbQgkbUDZvDuwl//d2DYm8Nf9F/RsyvoZ3uk50ShTQkLOkRCMBTf
         OD3Augrxm1LHkLFIVhVv36h5XXvdZvJ6pzQlQ3Knr/c16jbyGQ4Ux9wmRONLeB4SVjZp
         g7Ztt9XXer5z5IPiIv+1CjSvQmJhYsUDGBywuoqfp6+o3L5E7/sgBnM/Emi05wELA/Xx
         KxqSrbszAKKz3U1j/FeRm3WfkaZUbSM328mWYMWuwlvAUY/d0jXpA2KFXyp1dCgnk8WA
         CZXA==
X-Forwarded-Encrypted: i=1; AHgh+RrWxfQCO4o15xEZemHhGfQO5VxEJ7IvK/pLw6z+h+yuG6CBc2X29P6w34UL/8+cTFNCvpXpB2QLZ+9pCSTc6bLR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5CE0iBtCrS47atYpNht/KEe5DQlwZHdaf0EBOCnR/CloDvy+
	WiX4j2T/bjAzOLlTbVYtN/eyLJ5Px+ZEhm0ZrkcKmUuqG/LUWhyTyosbn5qAQ/94h1P8cT22S0G
	GBob1ssSG4Q==
X-Received: from dled12-n2.prod.google.com ([2002:a05:701b:42cc:20b0:13b:9ad0:582f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e53:b0:381:1f51:1ff0
 with SMTP id 98e67ed59e1d1-3903c54b3a1mr18644417a91.2.1786087110681; Fri, 07
 Aug 2026 00:18:30 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:13 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-4-irogers@google.com>
Subject: [RFC PATCH v1 3/8] perf/core: Implement BUILD_ID_OFFSET sample type
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Expose stack_map_get_build_id_offset for perf_events to use when generating
these samples, and implement the payload writing in the perf event core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/bpf.h   | 13 +++++++
 kernel/bpf/stackmap.c |  2 +-
 kernel/events/core.c  | 85 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..fd76900a8e47 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4209,4 +4209,17 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+struct bpf_stack_build_id;
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PERF_EVENTS)
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+				    u32 trace_nr, bool user, bool may_fault);
+#else
+static inline void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+						  u32 trace_nr, bool user, bool may_fault)
+{
+	if (id_offs)
+		id_offs->status = 1; /* BPF_STACK_BUILD_ID_EMPTY */
+}
+#endif
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 41fe87d7302f..889ceb7cf29b 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -411,7 +411,7 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
  *     id_offs[i].build_id is zeroed out and id_offs[i].status is set to
  *     BPF_STACK_BUILD_ID_IP.
  */
-static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u32 trace_nr, bool user, bool may_fault)
 {
 	struct mmap_unlock_irq_work *work = NULL;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..97ac70441602 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2048,6 +2048,15 @@ static int __perf_event_read_size(u64 read_format, int nr_siblings)
 	return size + nr * entry;
 }
 
+
+struct perf_sample_build_id_offset {
+	u8	size;
+	u8	res1;
+	u16	res2;
+	u8	build_id[BPF_BUILD_ID_SIZE];
+	u64	offset;
+};
+
 static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 {
 	struct perf_sample_data *data;
@@ -2086,6 +2095,11 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		size += sizeof(data->code_page_size);
 
+	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		size += sizeof(struct perf_sample_build_id_offset);
+
+
+
 	event->header_size = size;
 }
 
@@ -8287,6 +8301,62 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_READ)
 		perf_output_read(handle, event);
 
+	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		struct bpf_stack_build_id bpf_bid = { .ip = data->ip };
+		struct perf_sample_build_id_offset bid_offset = { 0 };
+
+		bool is_user = (header->misc & PERF_RECORD_MISC_CPUMODE_MASK) ==
+			       PERF_RECORD_MISC_USER;
+
+		stack_map_get_build_id_offset(
+			&bpf_bid, /*trace_nr=*/1,
+			is_user, /*may_fault=*/false);
+		if (bpf_bid.status == BPF_STACK_BUILD_ID_VALID) {
+			bid_offset.size = BPF_BUILD_ID_SIZE;
+			memcpy(bid_offset.build_id, bpf_bid.build_id,
+				       BPF_BUILD_ID_SIZE);
+			bid_offset.offset = bpf_bid.offset;
+		} else {
+			bid_offset.offset = bpf_bid.ip;
+		}
+		perf_output_put(handle, bid_offset);
+	}
+
+	if (sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		u64 nr = data->callchain ? data->callchain->nr : 0;
+		struct perf_sample_build_id_offset bid_offset;
+		struct bpf_stack_build_id bpf_bid;
+		u64 i;
+
+		perf_output_put(handle, nr);
+
+		for (i = 0; i < nr; i++) {
+			memset(&bid_offset, /*c=*/0, sizeof(bid_offset));
+			memset(&bpf_bid, /*c=*/0, sizeof(bpf_bid));
+			bpf_bid.ip = data->callchain->ip[i];
+
+			if (data->callchain->ip[i] == PERF_CONTEXT_USER) {
+				bpf_bid.status = BPF_STACK_BUILD_ID_EMPTY;
+			} else {
+				bool is_user = data->callchain->ip[i] < PERF_CONTEXT_MAX;
+
+				stack_map_get_build_id_offset(&bpf_bid, /*trace_nr=*/1,
+					      is_user, /*may_fault=*/false);
+			}
+
+			if (bpf_bid.status == BPF_STACK_BUILD_ID_VALID) {
+				bid_offset.size = BPF_BUILD_ID_SIZE;
+				memcpy(bid_offset.build_id, bpf_bid.build_id,
+			       BPF_BUILD_ID_SIZE);
+				bid_offset.offset = bpf_bid.offset;
+			} else {
+				bid_offset.offset = bpf_bid.ip;
+			}
+			perf_output_put(handle, bid_offset);
+		}
+	}
+
+
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
@@ -8632,7 +8702,7 @@ void perf_prepare_sample(struct perf_sample_data *data,
 
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 
-	if (filtered_sample_type & PERF_SAMPLE_IP) {
+	if (filtered_sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET)) {
 		data->ip = perf_instruction_pointer(event, regs);
 		data->sample_flags |= PERF_SAMPLE_IP;
 	}
@@ -8640,6 +8710,19 @@ void perf_prepare_sample(struct perf_sample_data *data,
 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 		perf_sample_save_callchain(data, event, regs);
 
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		int size = 1;
+
+		if (!data->callchain)
+			data->callchain = perf_callchain(event, regs);
+
+		size += data->callchain->nr *
+			(sizeof(struct perf_sample_build_id_offset) / sizeof(u64));
+		data->dyn_size += size * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
+	}
+
+
 	if (filtered_sample_type & PERF_SAMPLE_RAW) {
 		data->raw = NULL;
 		data->dyn_size += sizeof(u64);
-- 
2.55.0.679.g6767b8d81c-goog

