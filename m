Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD6511180
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962759; cv=none; b=sZoUemqzpr8lu+jzDiEtQH/QGqSafXxy85wdACwjY8/LlPT+sD69edxtzvPZJKWf2u7SjaacxtzIuIY+933jpUcB3BViB1FRVY93yOaJYlu+I+QTT0MqW3XEtSPS8osZSXuRgf+IzxM5Rwpq6jxImj/Yz1EsmsRGMWBHlRy87jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962759; c=relaxed/simple;
	bh=CMzijwOnhUqGvTpwakUmeuxhzHujfavjnl3VBeyf+yA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NIcnYjdTmpwXsPu8ntVz4h2n9N9AeTa3mqzQ28fs1wmZavYaWYgdTTUyvoysn5Jl48UoTEa4imWALvll/o4IxvhsSzlKcS6R/aNm8wGFMIvx0QG+vt3+HNfaA26OL22i/UbxF+OZgn8fxt77SFW3g6G36RkaibtPc7TWNCbe+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDenhtgi; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDenhtgi"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34e676375d9so1643383eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790962747; x=1791567547; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68X3ApZEvBvgqt6sZPlAdyoMSaW46naAFLLLljM6n2U=;
        b=EDenhtgi0p1XWbkmN3GQhxWERr0O0A+8ikJiqaDgYbS/UqdQ83VK+70N/x7lE5kOiy
         BHDQYyQtoiMJCJqfC1GqICTOtTEGHmHhpcskfhMR0hpzhd8Ua3IpL5iChp0x6dhjQ4h8
         wUgYxaMTeKwKB9a/CSLuRlVvxy7PssDpRcLD3sSbWHVnmJSp+8d2WF1/dwhjvNo60XN9
         dvBGOfJI35HgYIXhSoSwE0wCI5oWvZCdEBnDPAS0Sq9KMxLh3z4Oxp3dgwdu8QcgAHp1
         xc/+I6FmxowHXFpWboeyWhun+wa7Sh3s5I4hgPw8x0fdJYLAnCVD/NugM2WzfAK19d5O
         iIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962747; x=1791567547;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68X3ApZEvBvgqt6sZPlAdyoMSaW46naAFLLLljM6n2U=;
        b=e0Xn+jUpElYCi8WO8lIDoPisxm/vC0OPmYwcRTSU0lzKLTj0I5HPm+dAOOjdMUEhtP
         kJOvvD9Zr6ekXhikQsKzmWpSlp/utUlEK9P9LE28nxc/yKNwKfPJqk1DUGcqg+wTwX72
         bElQDbdYDbs0MHCKnyY8coVS0bWf3qeghhPK77JA/2W/nBbFUF/ZwkeExYYGElOOr0eq
         0f5i5QzoVJ3v70V4unXbYj56Tki54P1lZv39K1Ithv3g0JoP9V1+Ib3V29LLfbaWoa37
         BBvvw7GwQR3JpEzMxPl4Jyn9FuJ5+SayOVkyjmtjThTSfWHA2kqq5F2t1ss/p9MroaHP
         UZEA==
X-Forwarded-Encrypted: i=1; AKwUvBwy6Z5AY50zVwBx9kuFczYk5DZ6oWxsBrYLBhHivwqwzwNcJ1TOHHPe8f/T8m51VrwKbuK0wnu35gVzh02UfUJr@vger.kernel.org
X-Gm-Message-State: AFq9FYJhj8mc8srq3arYhfNZNbJb8nvlfiIzR0HQty5Z6cxxHb8R1KOP
	3kNiSHTuIH8EPrBENKZj83bee+1SvsYuA198nZ7gvy6dieXAngtvw+inNVxVtvDHsp/v42OBWEa
	fVlioVOnj7A==
X-Received: from dybsc11.prod.google.com ([2002:a05:7301:4b0b:b0:33e:55a2:f3c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1c1a:b0:34e:2150:e5a4
 with SMTP id 5a478bee46e88-34e2150e886mr6245976eec.16.1790962746101; Fri, 02
 Oct 2026 10:39:06 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:38:36 -0700
In-Reply-To: <20261002173848.3228217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20261002173848.3228217-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002173848.3228217-4-irogers@google.com>
Subject: [PATCH v2 3/8] perf/core: Implement BUILD_ID_OFFSET sample type
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Cc: ak@linux.intel.com, alexander.shishkin@linux.intel.com, 
	atrajeev@linux.ibm.com, dvyukov@google.com, fzczx123@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, kjain@linux.ibm.com, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, m.liska@foxlink.cz, mark.rutland@arm.com, 
	martin.liska@hey.com, mpetlan@redhat.com, quic_zhonhan@quicinc.com, 
	scclevenger@os.amperecomputing.com, sesse@google.com, 
	stephen.s.brennan@oracle.com, thomas.falcon@intel.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

Implement PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET payload writing in the perf event
core by reusing BPF's stack_map_get_build_id_offset().

When attr.defer_callchain is set, user-space IPs and callchains request
a deferred unwind via unwind_deferred_request() and emit a
PERF_CONTEXT_USER_DEFERRED marker and cookie in the sample. In the
faultable task_work callback (perf_unwind_deferred_callback), the
unwound user IPs are resolved to build IDs and file offsets using
stack_map_get_build_id_offset(..., may_fault=true) and emitted in
PERF_RECORD_CALLCHAIN_DEFERRED with PERF_RECORD_MISC_MMAP_BUILD_ID set.

When attr.defer_callchain is not set (or if deferred unwinding is
unavailable), user-space IPs and callchains are resolved in-place during
perf_output_sample() using stack_map_get_build_id_offset(...,
may_fault=false). If the mmap_lock cannot be trylocked or the ELF
header/note pages are not present in the page cache (nor mlocked into
memory), resolution falls back to emitting a zero-sized build ID
(size = 0) with the virtual address as the offset. Using the deferred
approach (attr.defer_callchain and attr.defer_output) is therefore
preferred as it can fault in pages and wait on locks, resolving more
build IDs without requiring ELF header pages to be mlocked in the page
cache.

Kernel-space IPs and callchain entries are emitted with a zero-sized
build ID (size = 0) and the virtual address as the offset.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/bpf.h        |  14 ++
 include/linux/perf_event.h |   1 +
 kernel/bpf/stackmap.c      |   4 +-
 kernel/events/core.c       | 298 +++++++++++++++++++++++++++++++++++--
 4 files changed, 304 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e57af902560c..750133762436 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4217,4 +4217,18 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PERF_EVENTS)
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+				   u32 trace_nr, bool user, bool may_fault);
+#else
+static inline void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+						 u32 trace_nr, bool user, bool may_fault)
+{
+	for (u32 i = 0; i < trace_nr; i++) {
+		id_offs[i].status = BPF_STACK_BUILD_ID_IP;
+		memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
+	}
+}
+#endif
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5842552294c1..3868923f6a79 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1347,6 +1347,7 @@ struct perf_sample_data {
 	u64				data_page_size;
 	u64				code_page_size;
 	u64				aux_size;
+	u64				callchain_bid_nr;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index d09d4c3fe547..4e06c1697786 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -411,8 +411,8 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
  *     id_offs[i].build_id is zeroed out and id_offs[i].status is set to
  *     BPF_STACK_BUILD_ID_IP.
  */
-static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u32 trace_nr, bool user, bool may_fault)
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+				   u32 trace_nr, bool user, bool may_fault)
 {
 	struct mmap_unlock_irq_work *work;
 	bool has_user_ctx = user && current && current->mm;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 33210aff3ee6..7f6bf96f7473 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -460,6 +460,8 @@ static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
 static atomic_t nr_text_poke_events __read_mostly;
 static atomic_t nr_build_id_events __read_mostly;
+static atomic_t nr_build_id_offset_events __read_mostly;
+static atomic_t nr_callchain_build_id_offset_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -2048,6 +2050,14 @@ static int __perf_event_read_size(u64 read_format, int nr_siblings)
 	return size + nr * entry;
 }
 
+struct perf_sample_build_id_offset {
+	u8	size;
+	u8	res1;
+	u16	res2;
+	u8	build_id[BUILD_ID_SIZE_MAX];
+	u64	offset;
+};
+
 static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 {
 	struct perf_sample_data *data;
@@ -2086,6 +2096,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		size += sizeof(data->code_page_size);
 
+	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		size += sizeof(struct perf_sample_build_id_offset);
+
 	event->header_size = size;
 }
 
@@ -5341,7 +5354,7 @@ static bool is_sb_event(struct perf_event *event)
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
 	    attr->context_switch || attr->text_poke ||
-	    attr->bpf_event)
+	    attr->bpf_event || attr->defer_output)
 		return true;
 
 	return false;
@@ -5619,6 +5632,10 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_mmap_events);
 	if (event->attr.build_id)
 		atomic_dec(&nr_build_id_events);
+	if (event->attr.sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		atomic_dec(&nr_build_id_offset_events);
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
+		atomic_dec(&nr_callchain_build_id_offset_events);
 	if (event->attr.comm)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
@@ -8276,6 +8293,155 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
+static struct unwind_work perf_unwind_work;
+
+struct perf_bpf_build_id_buf {
+	local_t active;
+	struct bpf_stack_build_id bids[PERF_MAX_STACK_DEPTH + 1];
+};
+
+static DEFINE_PER_CPU(struct perf_bpf_build_id_buf, perf_bpf_build_id_buf);
+
+static void perf_bpf_to_sample_bid_offset(struct bpf_stack_build_id *bpf_bid)
+{
+	struct perf_sample_build_id_offset *bid = (void *)bpf_bid;
+	u8 size = 0;
+
+	static_assert(sizeof(*bid) == sizeof(*bpf_bid));
+	static_assert(offsetof(struct perf_sample_build_id_offset, build_id) ==
+		      offsetof(struct bpf_stack_build_id, build_id));
+	static_assert(offsetof(struct perf_sample_build_id_offset, offset) ==
+		      offsetof(struct bpf_stack_build_id, offset));
+
+	if (bpf_bid->status == BPF_STACK_BUILD_ID_VALID)
+		size = BUILD_ID_SIZE_MAX;
+	else
+		memset(bid->build_id, 0, sizeof(bid->build_id));
+
+	bid->size = size;
+	bid->res1 = 0;
+	bid->res2 = 0;
+}
+
+static void perf_output_sample_build_id(struct perf_output_handle *handle,
+					struct perf_event_header *header,
+					struct perf_sample_data *data,
+					struct perf_event *event)
+{
+	u64 sample_type = data->type;
+	bool sample_bid = sample_type & PERF_SAMPLE_BUILD_ID_OFFSET;
+	bool callchain_bid = sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
+	bool crosstask = event->ctx->task && event->ctx->task != current;
+	bool has_user_ctx = is_user_task(current) && current->mm && !crosstask;
+	bool is_user = (header->misc & PERF_RECORD_MISC_CPUMODE_MASK) ==
+		       PERF_RECORD_MISC_USER;
+	u64 defer_cookie = 0;
+	u64 callchain_nr = callchain_bid ? data->callchain_bid_nr : 0;
+	u64 user_start = callchain_nr;
+	u32 resolve_ip_nr = 0, resolve_cc_nr = 0, total_resolve_nr;
+	struct perf_bpf_build_id_buf *buf = NULL;
+
+	if (sample_bid) {
+		bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) &&
+				  is_user && has_user_ctx &&
+				  event->attr.defer_callchain &&
+				  !(sample_type & PERF_SAMPLE_CALLCHAIN);
+
+		if (defer_user &&
+		    unwind_deferred_request(&perf_unwind_work, &defer_cookie) < 0)
+			defer_cookie = 0;
+
+		if (!defer_cookie && is_user && has_user_ctx)
+			resolve_ip_nr = 1;
+	}
+
+	if (callchain_bid && has_user_ctx) {
+		for (u64 i = 0; i < callchain_nr; i++) {
+			if (data->callchain->ip[i] == PERF_CONTEXT_USER) {
+				user_start = i + 1;
+				break;
+			}
+		}
+		if (user_start < callchain_nr) {
+			resolve_cc_nr = min_t(u64, callchain_nr - user_start,
+					      PERF_MAX_STACK_DEPTH);
+		}
+	}
+
+	total_resolve_nr = resolve_ip_nr + resolve_cc_nr;
+	if (total_resolve_nr) {
+		buf = get_cpu_ptr(&perf_bpf_build_id_buf);
+		if (local_cmpxchg(&buf->active, 0, 1) == 0) {
+			if (resolve_ip_nr)
+				buf->bids[0].ip = data->ip;
+			for (u32 i = 0; i < resolve_cc_nr; i++) {
+				buf->bids[resolve_ip_nr + i].ip =
+					data->callchain->ip[user_start + i];
+			}
+			stack_map_get_build_id_offset(buf->bids,
+						      total_resolve_nr,
+						      true, false);
+			for (u32 i = 0; i < total_resolve_nr; i++)
+				perf_bpf_to_sample_bid_offset(&buf->bids[i]);
+		} else {
+			put_cpu_ptr(&perf_bpf_build_id_buf);
+			buf = NULL;
+		}
+	}
+
+	if (sample_bid) {
+		if (defer_cookie) {
+			u64 deferred_bid[4] = {
+				0,
+				PERF_CONTEXT_USER_DEFERRED,
+				defer_cookie,
+				data->ip,
+			};
+
+			perf_output_put(handle, deferred_bid);
+		} else if (buf && resolve_ip_nr) {
+			perf_output_copy(handle, &buf->bids[0],
+					 sizeof(buf->bids[0]));
+		} else {
+			struct perf_sample_build_id_offset bid_offset = {
+				.offset = data->ip,
+			};
+
+			perf_output_put(handle, bid_offset);
+		}
+	}
+
+	if (callchain_bid) {
+		u64 unres_prefix = buf ? user_start : callchain_nr;
+		u64 resolved_end = unres_prefix + (buf ? resolve_cc_nr : 0);
+
+		perf_output_put(handle, callchain_nr);
+		for (u64 i = 0; i < unres_prefix; i++) {
+			struct perf_sample_build_id_offset bid_offset = {
+				.offset = data->callchain->ip[i],
+			};
+
+			perf_output_put(handle, bid_offset);
+		}
+		if (buf && resolve_cc_nr) {
+			perf_output_copy(handle, &buf->bids[resolve_ip_nr],
+					 resolve_cc_nr * sizeof(buf->bids[0]));
+		}
+		for (u64 i = resolved_end; i < callchain_nr; i++) {
+			struct perf_sample_build_id_offset bid_offset = {
+				.offset = data->callchain->ip[i],
+			};
+
+			perf_output_put(handle, bid_offset);
+		}
+	}
+
+	if (buf) {
+		local_set(&buf->active, 0);
+		put_cpu_ptr(&perf_bpf_build_id_buf);
+	}
+}
+
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -8455,6 +8621,10 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_aux_sample_output(event, handle, data);
 	}
 
+	if (sample_type &
+	    (PERF_SAMPLE_BUILD_ID_OFFSET | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
+		perf_output_sample_build_id(handle, header, data, event);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -8598,8 +8768,6 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
-static struct unwind_work perf_unwind_work;
-
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -8663,7 +8831,7 @@ void perf_prepare_sample(struct perf_sample_data *data,
 
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 
-	if (filtered_sample_type & PERF_SAMPLE_IP) {
+	if (filtered_sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET)) {
 		data->ip = perf_instruction_pointer(event, regs);
 		data->sample_flags |= PERF_SAMPLE_IP;
 	}
@@ -8671,6 +8839,14 @@ void perf_prepare_sample(struct perf_sample_data *data,
 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 		perf_sample_save_callchain(data, event, regs);
 
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		if (!(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
+			data->callchain = perf_callchain(event, regs);
+
+		data->dyn_size += sizeof(u64);
+	}
+
+
 	if (filtered_sample_type & PERF_SAMPLE_RAW) {
 		data->raw = NULL;
 		data->dyn_size += sizeof(u64);
@@ -8820,6 +8996,20 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->dyn_size += size + sizeof(u64); /* size above */
 		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
+
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		u32 header_size = perf_sample_data_size(data, event);
+		u64 max_nr = 0, nr;
+
+		if (header_size < U16_MAX) {
+			max_nr = (U16_MAX - header_size) /
+				 sizeof(struct perf_sample_build_id_offset);
+		}
+		nr = min_t(u64, data->callchain->nr, max_nr);
+		data->callchain_bid_nr = nr;
+		data->dyn_size += nr * sizeof(struct perf_sample_build_id_offset);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
+	}
 }
 
 void perf_prepare_header(struct perf_event_header *header,
@@ -10414,6 +10604,8 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 
 struct perf_callchain_deferred_event {
 	struct unwind_stacktrace *trace;
+	struct perf_sample_build_id_offset *bids;
+	u16 nr_bids;
 	struct {
 		struct perf_event_header	header;
 		u64				cookie;
@@ -10422,17 +10614,83 @@ struct perf_callchain_deferred_event {
 	} event;
 };
 
+static struct perf_sample_build_id_offset *
+perf_resolve_build_id_offsets(struct unwind_stacktrace *trace, u16 *nr_bids_out)
+{
+	struct perf_sample_build_id_offset *bids;
+	struct bpf_stack_build_id *bpf_bids;
+	u16 nr = trace->nr;
+
+	*nr_bids_out = 0;
+	if (!nr || !current->mm)
+		return NULL;
+
+	if (!atomic_read(&nr_callchain_build_id_offset_events)) {
+		if (!atomic_read(&nr_build_id_offset_events))
+			return NULL;
+		nr = 1;
+	}
+
+	bids = kcalloc(nr, sizeof(*bids), GFP_KERNEL);
+	if (!bids)
+		return NULL;
+
+	bpf_bids = (struct bpf_stack_build_id *)bids;
+	for (u16 i = 0; i < nr; i++)
+		bpf_bids[i].ip = trace->entries[i];
+
+	stack_map_get_build_id_offset(bpf_bids, nr, true, true);
+
+	for (u16 i = 0; i < nr; i++)
+		perf_bpf_to_sample_bid_offset(&bpf_bids[i]);
+
+	*nr_bids_out = nr;
+	return bids;
+}
+
 static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 {
 	struct perf_callchain_deferred_event *deferred_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int ret, size = deferred_event->event.header.size;
+	u64 nr = deferred_event->trace->nr;
+	size_t elem_size;
+	bool use_bid;
+	u16 header_size, orig_misc, id_size;
+	int ret;
 
 	if (!event->attr.defer_output)
 		return;
 
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		use_bid = deferred_event->bids != NULL;
+		if (use_bid)
+			nr = min_t(u64, nr, deferred_event->nr_bids);
+	} else if ((event->attr.sample_type & PERF_SAMPLE_BUILD_ID_OFFSET) &&
+		   !(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)) {
+		nr = min_t(u64, nr, 1);
+		use_bid = deferred_event->bids != NULL;
+		if (use_bid)
+			nr = min_t(u64, nr, deferred_event->nr_bids);
+	} else {
+		use_bid = false;
+	}
+
+	elem_size = use_bid ? sizeof(struct perf_sample_build_id_offset) :
+			      sizeof(u64);
+	id_size = event->attr.sample_id_all ? event->id_header_size : 0;
+	nr = min_t(u64, nr,
+		   (U16_MAX - sizeof(deferred_event->event) - id_size) / elem_size);
+
+	orig_misc = deferred_event->event.header.misc;
+	if (use_bid)
+		deferred_event->event.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+	header_size = sizeof(deferred_event->event) + (nr * elem_size);
+	deferred_event->event.header.size = header_size;
+	deferred_event->event.nr = nr;
+
 	/* XXX do we really need sample_id_all for this ??? */
+	perf_sample_data_init(&sample, 0, 0);
 	perf_event_header__init_id(&deferred_event->event.header, &sample, event);
 
 	ret = perf_output_begin(&handle, &sample, event,
@@ -10441,22 +10699,33 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 		goto out;
 
 	perf_output_put(&handle, deferred_event->event);
-	for (int i = 0; i < deferred_event->trace->nr; i++) {
-		u64 entry = deferred_event->trace->entries[i];
-		perf_output_put(&handle, entry);
+	if (use_bid) {
+		for (u64 i = 0; i < nr; i++)
+			perf_output_put(&handle, deferred_event->bids[i]);
+	} else {
+		for (u64 i = 0; i < nr; i++) {
+			u64 entry = deferred_event->trace->entries[i];
+
+			perf_output_put(&handle, entry);
+		}
 	}
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
 out:
-	deferred_event->event.header.size = size;
+	deferred_event->event.header.misc = orig_misc;
 }
 
 static void perf_unwind_deferred_callback(struct unwind_work *work,
 					 struct unwind_stacktrace *trace, u64 cookie)
 {
+	u16 nr_bids = 0;
+	struct perf_sample_build_id_offset *bids =
+		perf_resolve_build_id_offsets(trace, &nr_bids);
 	struct perf_callchain_deferred_event deferred_event = {
 		.trace = trace,
+		.bids = bids,
+		.nr_bids = nr_bids,
 		.event = {
 			.header = {
 				.type = PERF_RECORD_CALLCHAIN_DEFERRED,
@@ -10470,6 +10739,7 @@ static void perf_unwind_deferred_callback(struct unwind_work *work,
 	};
 
 	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event, NULL);
+	kfree(bids);
 }
 
 struct perf_text_poke_event {
@@ -13314,6 +13584,10 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_mmap_events);
 	if (event->attr.build_id)
 		atomic_inc(&nr_build_id_events);
+	if (event->attr.sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		atomic_inc(&nr_build_id_offset_events);
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
+		atomic_inc(&nr_callchain_build_id_offset_events);
 	if (event->attr.comm)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
@@ -13582,7 +13856,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
+		if (event->attr.sample_type &
+		    (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
 				return ERR_PTR(err);
@@ -13943,7 +14218,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	if (!attr.exclude_kernel ||
-	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	    ((attr.sample_type &
+	      (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
 		if (err)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

