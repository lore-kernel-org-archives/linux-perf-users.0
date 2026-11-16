Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815120;
	b=APNLQfqqed4/kORvbif0+5aHquErT06NlaSsYL3qpX01A9z8YZoz+7MSwwzIIGiqi/1r
	 TJQOJ/GTrai4CsZxSSRzWcTz636ZKrD2gv6GbiC+unSCno/aELOaESde6UOY7CM9Q447E
	 bNP4qj96s1HZd3kuV/I/zUfXgbDpjukDhl7yNa8473IzSTTmhieFWEoc4rXCZadq+hCU7
	 gn9RO6V9uF47Y23+rV7uwCkbbX0+yUTvSbnSE147/IEFNO6g5qKIxNLd7QFyLsuuwzNYQ
	 2aWP1rFZaSmq7IhuowcqrvpgSjFGGKlYNLq7aekYxO/VgYSxYT/OTM6aI/HlgX8oo2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=f8rqEbjLwdRyTylEhtvgluRCvoFpSMUEoqJc1YQaMNQ=;
	b=yEP6RN+M2nkoqcMbYnQ1aDsi42OU6MJs2z/0LN9U+VWWjJWmHIEJNfB+OncipKHuzFwS
	 FFuc8WqlSm+QVZFFgFgmX+TlIQMgMiTSc9lXmtTJPsMXjTF3+E9B8YvCkOlyCQzRINoTr
	 68ZyXFGObQgiJrT1cu90yqVVHaKDtD9e1amtQta+zLzy8Wbh//QwknHu0B+DKUeoxD40K
	 we8nyFH5Z/3StXh9PQTLv5V4BHyDWeVvpP3Z/WCANfbwfvm6JDqxOYGezyov9FOuKqebz
	 r+A+ltxcmbX4S01WCuO9t+L0N5Md2XOUncyvp9fqY+v04Lif7CbA82PmwXFM/5WUp0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TRc9xPEY;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A48606A329
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A48606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TRc9xPEY
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36de26cb4b3so3916076eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815118; x=1795419918; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f8rqEbjLwdRyTylEhtvgluRCvoFpSMUEoqJc1YQaMNQ=;
        b=TRc9xPEYg6gwaD8AlW9muyCIV0jM8Cc0tCt8Izm7CG4xZwMW4I6bzPpiIe2MM2k7Oq
         tliMOiqdsbcjYGWsXz4Ik/6hoDaf666ctAUsbDAZxR5myGxO5wIDVQEn4aQQvlk1f9PZ
         TQMMFwAvExuxNXUjKlYObZ+uNl3ZFcKhKss32CUb2z1YVDwLwKtocje2xKkUWj0Wxbj+
         0cTuWMCPAyLJK44/KrbWqLcx45hmzeaRnxr3KZzs+mAjOqx/sxy8pLZUVCPZA1elUcuA
         WbYHxIWinEsy7rXjhHh7a87UozEEe95xNXHksfXIgAlnqf8V9qGQFQHqWyk298V3SbOd
         2pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815118; x=1795419918;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f8rqEbjLwdRyTylEhtvgluRCvoFpSMUEoqJc1YQaMNQ=;
        b=m85dHCoMuFtuuHX9wjbT4JbymFMqLWtR7WL+AKDjvwdnslRIVzF3e5EqByLGlk5CZY
         PUAqiG0ofgHSTxOEaw4IuvdHH5n6UaWcbuij5oIhH66BvmvCbxDXAPCXllEHMNetr6aC
         +99UFHHofnFo9jaXCW8UUqEJwiZyQGbSF2S0CR0M0l01VuRiH57pqR3Wz/5bGS1DZnmz
         cZmZFf76FQYqRPe0zavNAaQY7rUmzELMyK7U2kCvw9xdCvWz8+RMTh4yDxwPILRgTirJ
         KanhxFcyvpzjciXzT1AT/Sd/cme7/5DzuNs5VWRuhO0iTxvywPihT1PIdpjoQ2Uv1jon
         celw==
X-Forwarded-Encrypted: i=1; AL+hErG37O1eiN4zlPAUBCWJNLvVNZnWl8A3nv2uJq+dTgeRKH4ie9X0FgEEHlhEk0y9LvDhWGlwq+9xshObZd7dRqC+@vger.kernel.org
X-Gm-Message-State: APuU4Z/oOBGLFTofkvr06oLs8LsoQv8wQeke/M6BkgyxocOmdLG3YFZq
	sn378ufc19oL/o6C6SkA1k81WiVqpRlzlC3dHa1q9K6FFI8ug1bI+eWS5SQe0kMaq/ymtDiKMUa
	d8W5HXUQvtQ==
X-Received: from dyvt16.prod.google.com ([2002:a05:7301:d810:b0:36d:c15d:8d80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8107:b0:36c:b7b4:407e
 with SMTP id 5a478bee46e88-37967cdd709mr11074169eec.22.1794815117360; Sun, 15
 Nov 2026 23:45:17 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:00 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-6-irogers@google.com>
Subject: [PATCH v3 05/19] perf/core: Implement BUILD_ID_OFFSET and
 CALLCHAIN_BUILD_ID_OFFSET sample types
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Implement synchronous PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET payload writing in the perf event
core using stack_map_get_build_id_offset(..., may_fault=false).

For callchains, extend the per-CPU callchain buffers in
kernel/events/callchain.c to provide scratch space to deduplicate build
IDs and encode the compressed build ID table and tagged 64-bit offsets
(with the top 8 bits storing the 1-based build ID index).

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/perf/core-book3s.c |  10 +-
 arch/s390/kernel/perf_cpum_sf.c |   7 +-
 include/linux/perf_event.h      |  43 ++++++-
 kernel/bpf/stackmap.c           |   6 +-
 kernel/events/callchain.c       | 206 +++++++++++++++++++++++++++++++-
 kernel/events/core.c            | 132 ++++++++++++++++++--
 6 files changed, 385 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 10ded865583c..bc51ab537851 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2271,10 +2271,11 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 			/*
 			 * If address is not requested in the sample via
-			 * PERF_SAMPLE_IP, just record that sample irrespective
-			 * of SIAR valid check.
+			 * PERF_SAMPLE_IP or PERF_SAMPLE_BUILD_ID_OFFSET, just
+			 * record that sample irrespective of SIAR valid check.
 			 */
-			if (event->attr.sample_type & PERF_SAMPLE_IP)
+			if (event->attr.sample_type &
+			    (PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET))
 				record = siar_valid(regs);
 			else
 				record = 1;
@@ -2297,7 +2298,8 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	 * these cases.
 	 */
 	if (event->attr.exclude_kernel &&
-	    (event->attr.sample_type & PERF_SAMPLE_IP) &&
+	    (event->attr.sample_type &
+	     (PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET)) &&
 	    is_kernel_addr(mfspr(SPRN_SIAR)))
 		record = 0;
 
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 7bfeb5208177..30b0b6ba5b41 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -840,8 +840,11 @@ static bool is_callchain_event(struct perf_event *event)
 {
 	u64 sample_type = event->attr.sample_type;
 
-	return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER |
-			      PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_STACK_USER);
+	return sample_type & (PERF_SAMPLE_CALLCHAIN |
+			      PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET |
+			      PERF_SAMPLE_BUILD_ID_OFFSET |
+			      PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR |
+			      PERF_SAMPLE_STACK_USER);
 }
 
 static int cpumsf_pmu_event_init(struct perf_event *event)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1e11500df09..9b5d9613a6f3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -61,6 +61,31 @@ struct perf_callchain_entry {
 	u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
 };
 
+#define PERF_CALLCHAIN_BUILD_ID_MAX_NRS		254
+#define PERF_CALLCHAIN_BUILD_ID_MAX_SIZE	20
+#define PERF_CALLCHAIN_BUILD_ID_TABLE_MAX_SIZE	\
+	ALIGN(PERF_CALLCHAIN_BUILD_ID_MAX_NRS * (1 + PERF_CALLCHAIN_BUILD_ID_MAX_SIZE), sizeof(u64))
+
+struct perf_sample_build_id_offset {
+	u8				size;
+	u8				res1;
+	u16				res2;
+	u8				build_id[PERF_CALLCHAIN_BUILD_ID_MAX_SIZE];
+	u64				offset;
+};
+
+struct perf_callchain_build_id_entry {
+	u32				build_ids_len;
+	bool				has_ip_bid;
+	struct perf_sample_build_id_offset ip_bid;
+	struct {
+		u32			nr_build_ids;
+		u32			nr_offsets;
+		u8			build_ids[PERF_CALLCHAIN_BUILD_ID_TABLE_MAX_SIZE];
+	};
+	u64				offsets[]; /* /proc/sys/kernel/perf_event_max_stack */
+};
+
 struct perf_callchain_entry_ctx {
 	struct perf_callchain_entry	*entry;
 	u32				max_stack;
@@ -1347,6 +1372,7 @@ struct perf_sample_data {
 	u64				data_page_size;
 	u64				code_page_size;
 	u64				aux_size;
+	struct perf_callchain_build_id_entry *callchain_build_id;
 } ____cacheline_aligned;
 
 /* default value for data source */
@@ -1377,7 +1403,8 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
-	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+	if (!(event->attr.sample_type &
+	      (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)))
 		return;
 	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
 		return;
@@ -1385,7 +1412,8 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 
-	data->dyn_size += size * sizeof(u64);
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		data->dyn_size += size * sizeof(u64);
 	data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
 }
 
@@ -1747,6 +1775,17 @@ extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
 extern void put_callchain_entry(int rctx);
+struct bpf_stack_build_id;
+extern struct perf_callchain_build_id_entry *
+get_callchain_build_id_entry(int *rctx, struct bpf_stack_build_id **bpf_bids);
+extern void perf_callchain_encode_build_ids(struct perf_callchain_build_id_entry *entry,
+					    const u64 *ips, u32 nr, u32 user_start,
+					    const struct bpf_stack_build_id *bpf_bids,
+					    u32 nr_bpf_bids, u32 max_size);
+extern struct perf_callchain_build_id_entry *
+perf_callchain_build_id(struct perf_event *event,
+			struct perf_callchain_entry *callchain,
+			u64 ip, bool resolve_ip, u32 max_size);
 
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 11f6349b2b8d..1f4a0c425af6 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -691,7 +691,8 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	int ret;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
-	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+	if (!(event->attr.sample_type &
+	      (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)))
 		return bpf_get_stackid((unsigned long)(ctx->regs),
 				       (unsigned long) map, flags, 0, 0);
 
@@ -982,7 +983,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	int err = -EINVAL;
 	__u64 nr_kernel;
 
-	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+	if (!(event->attr.sample_type &
+	      (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)))
 		return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 9d24b6e0c91f..935b34d2dd33 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/perf_event.h>
+#include <linux/bpf.h>
 #include <linux/slab.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uprobes.h>
@@ -31,6 +32,26 @@ static inline size_t perf_callchain_entry__sizeof(void)
 				 sysctl_perf_event_max_contexts_per_stack));
 }
 
+static inline size_t perf_callchain_build_id_entry__sizeof(void)
+{
+	return (sizeof(struct perf_callchain_build_id_entry) +
+		sizeof(__u64) * (sysctl_perf_event_max_stack +
+				 sysctl_perf_event_max_contexts_per_stack));
+}
+
+static inline size_t perf_callchain_bpf_build_id__sizeof(void)
+{
+	return sizeof(struct bpf_stack_build_id) *
+	       (sysctl_perf_event_max_stack + 1);
+}
+
+static inline size_t perf_callchain_context__sizeof(void)
+{
+	return perf_callchain_entry__sizeof() +
+	       perf_callchain_build_id_entry__sizeof() +
+	       perf_callchain_bpf_build_id__sizeof();
+}
+
 static DEFINE_PER_CPU(u8, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
 static DEFINE_MUTEX(callchain_mutex);
@@ -86,7 +107,7 @@ static int alloc_callchain_buffers(void)
 	if (!entries)
 		return -ENOMEM;
 
-	size = perf_callchain_entry__sizeof() * PERF_NR_CONTEXTS;
+	size = perf_callchain_context__sizeof() * PERF_NR_CONTEXTS;
 
 	for_each_possible_cpu(cpu) {
 		entries->cpu_entries[cpu] = kmalloc_node(size, GFP_KERNEL,
@@ -169,7 +190,22 @@ struct perf_callchain_entry *get_callchain_entry(int *rctx)
 	cpu = smp_processor_id();
 
 	return (((void *)entries->cpu_entries[cpu]) +
-		(*rctx * perf_callchain_entry__sizeof()));
+		(*rctx * perf_callchain_context__sizeof()));
+}
+
+struct perf_callchain_build_id_entry *
+get_callchain_build_id_entry(int *rctx, struct bpf_stack_build_id **bpf_bids)
+{
+	void *base = get_callchain_entry(rctx);
+
+	if (!base)
+		return NULL;
+
+	base += perf_callchain_entry__sizeof();
+	if (bpf_bids)
+		*bpf_bids = base + perf_callchain_build_id_entry__sizeof();
+
+	return base;
 }
 
 void
@@ -178,6 +214,172 @@ put_callchain_entry(int rctx)
 	put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
 }
 
+void perf_callchain_encode_build_ids(struct perf_callchain_build_id_entry *entry,
+				     const u64 *ips, u32 nr, u32 user_start,
+				     const struct bpf_stack_build_id *bpf_bids,
+				     u32 nr_bpf_bids, u32 max_size)
+{
+	u32 nr_build_ids = 0, nr_offsets = 0;
+	u32 raw_bids_len = 0, aligned_bids_len = 0;
+
+	static_assert(BUILD_ID_SIZE_MAX == PERF_CALLCHAIN_BUILD_ID_MAX_SIZE);
+
+	for (u32 i = 0; i < nr; i++) {
+		u64 ip = ips[i];
+		u64 encoded_offset;
+		const struct bpf_stack_build_id *bpf_bid = NULL;
+
+		if (i >= user_start && i - user_start < nr_bpf_bids)
+			bpf_bid = &bpf_bids[i - user_start];
+
+		if (bpf_bid && bpf_bid->status == BPF_STACK_BUILD_ID_VALID) {
+			u32 pos = 0, found_idx = 0;
+
+			for (u32 b = 0; b < nr_build_ids; b++) {
+				u8 sz = entry->build_ids[pos];
+
+				if (sz == BUILD_ID_SIZE_MAX &&
+				    !memcmp(&entry->build_ids[pos + 1],
+					    bpf_bid->build_id,
+					    BUILD_ID_SIZE_MAX)) {
+					found_idx = b + 1;
+					break;
+				}
+				pos += 1 + sz;
+			}
+
+			if (!found_idx &&
+			    nr_build_ids < PERF_CALLCHAIN_BUILD_ID_MAX_NRS) {
+				u32 next_raw_len = raw_bids_len + 1 + BUILD_ID_SIZE_MAX;
+				u32 next_aligned_len = ALIGN(next_raw_len, sizeof(u64));
+
+				if (next_aligned_len + (i + 1) * sizeof(u64) > max_size)
+					break;
+				entry->build_ids[raw_bids_len] = BUILD_ID_SIZE_MAX;
+				memcpy(&entry->build_ids[raw_bids_len + 1],
+				       bpf_bid->build_id, BUILD_ID_SIZE_MAX);
+				nr_build_ids++;
+				raw_bids_len = next_raw_len;
+				aligned_bids_len = next_aligned_len;
+				found_idx = nr_build_ids;
+			}
+
+			if (aligned_bids_len + (i + 1) * sizeof(u64) > max_size)
+				break;
+
+			if (found_idx) {
+				encoded_offset = ((u64)found_idx << 56) |
+						 (bpf_bid->offset & GENMASK_ULL(55, 0));
+			} else {
+				encoded_offset = ip & GENMASK_ULL(55, 0);
+			}
+		} else {
+			if (aligned_bids_len + (i + 1) * sizeof(u64) > max_size)
+				break;
+			if (i >= user_start && ip < PERF_CONTEXT_MAX)
+				encoded_offset = ip & GENMASK_ULL(55, 0);
+			else
+				encoded_offset = ip;
+		}
+
+		entry->offsets[i] = encoded_offset;
+		nr_offsets = i + 1;
+	}
+
+	if (nr_offsets > 0 && nr_offsets <= user_start &&
+	    entry->offsets[nr_offsets - 1] == PERF_CONTEXT_USER_DEFERRED &&
+	    (nr_offsets < 2 ||
+	     entry->offsets[nr_offsets - 2] != PERF_CONTEXT_USER_DEFERRED))
+		nr_offsets--;
+
+	if (aligned_bids_len > raw_bids_len) {
+		memset(&entry->build_ids[raw_bids_len], 0,
+		       aligned_bids_len - raw_bids_len);
+	}
+	entry->nr_build_ids = nr_build_ids;
+	entry->nr_offsets = nr_offsets;
+	entry->build_ids_len = aligned_bids_len;
+}
+
+static struct perf_callchain_build_id_entry __empty_callchain_build_id = {};
+
+struct perf_callchain_build_id_entry *
+perf_callchain_build_id(struct perf_event *event,
+			struct perf_callchain_entry *callchain,
+			u64 ip, bool resolve_ip, u32 max_size)
+{
+	bool crosstask = event->ctx->task && event->ctx->task != current;
+	bool has_user_ctx = is_user_task(current) && current->mm && !crosstask;
+	struct perf_callchain_build_id_entry *entry;
+	struct bpf_stack_build_id *bpf_bids;
+	u32 nr, user_start, nr_bpf_bids = 0, ip_slot = 0;
+	int rctx;
+
+	if (!callchain || !callchain->nr || max_size < sizeof(u64))
+		return &__empty_callchain_build_id;
+
+	entry = get_callchain_build_id_entry(&rctx, &bpf_bids);
+	if (!entry)
+		return &__empty_callchain_build_id;
+
+	entry->has_ip_bid = false;
+	nr = min_t(u64, callchain->nr,
+		   sysctl_perf_event_max_stack +
+		   sysctl_perf_event_max_contexts_per_stack);
+	user_start = nr;
+	if (has_user_ctx) {
+		for (u32 i = 0; i < nr; i++) {
+			if (callchain->ip[i] == PERF_CONTEXT_USER) {
+				user_start = i + 1;
+				break;
+			}
+		}
+		if (user_start < nr) {
+			nr_bpf_bids = min_t(u32, nr - user_start,
+					    sysctl_perf_event_max_stack);
+			nr_bpf_bids = min_t(u32, nr_bpf_bids,
+					    max_size / sizeof(u64));
+		}
+		if (nr_bpf_bids > 0) {
+			if (resolve_ip) {
+				bpf_bids[0].ip = ip;
+				ip_slot = 1;
+			}
+			for (u32 i = 0; i < nr_bpf_bids; i++) {
+				bpf_bids[ip_slot + i].ip =
+					callchain->ip[user_start + i];
+			}
+			stack_map_get_build_id_offset(bpf_bids,
+						      ip_slot + nr_bpf_bids,
+						      true, false);
+			if (resolve_ip) {
+				memset(&entry->ip_bid, 0,
+				       sizeof(entry->ip_bid));
+				if (bpf_bids[0].status ==
+				    BPF_STACK_BUILD_ID_VALID) {
+					entry->ip_bid.size =
+						BUILD_ID_SIZE_MAX;
+					memcpy(entry->ip_bid.build_id,
+					       bpf_bids[0].build_id,
+					       BUILD_ID_SIZE_MAX);
+					entry->ip_bid.offset =
+						bpf_bids[0].offset;
+				} else {
+					entry->ip_bid.offset = ip;
+				}
+				entry->has_ip_bid = true;
+			}
+		}
+	}
+
+	perf_callchain_encode_build_ids(entry, callchain->ip, nr, user_start,
+					bpf_bids + ip_slot, nr_bpf_bids,
+					max_size);
+	put_callchain_entry(rctx);
+
+	return entry;
+}
+
 static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entry,
 					       int start_entry_idx)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd9f654de269..d38ffe52c301 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2096,6 +2096,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		size += sizeof(data->code_page_size);
 
+	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		size += sizeof(struct perf_sample_build_id_offset);
+
 	event->header_size = size;
 }
 
@@ -8396,6 +8399,78 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
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
+
+	if (sample_bid) {
+		if (is_user && has_user_ctx) {
+			if (callchain_bid && data->callchain_build_id &&
+			    data->callchain_build_id->has_ip_bid) {
+				perf_output_put(handle,
+						data->callchain_build_id->ip_bid);
+			} else {
+				struct bpf_stack_build_id bpf_bid = {
+					.ip = data->ip,
+				};
+
+				stack_map_get_build_id_offset(&bpf_bid, 1, true,
+							      false);
+				perf_bpf_to_sample_bid_offset(&bpf_bid);
+				perf_output_put(handle, bpf_bid);
+			}
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
+		struct perf_callchain_build_id_entry *entry =
+			data->callchain_build_id;
+
+		__output_copy(handle, &entry->nr_build_ids,
+			      sizeof(u64) + entry->build_ids_len);
+		if (entry->nr_offsets) {
+			__output_copy(handle, entry->offsets,
+				      entry->nr_offsets * sizeof(u64));
+		}
+	}
+}
+
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -8589,6 +8664,10 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_aux_sample_output(event, handle, data);
 	}
 
+	if (sample_type &
+	    (PERF_SAMPLE_BUILD_ID_OFFSET | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
+		perf_output_sample_build_id(handle, header, data, event);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -8804,7 +8883,9 @@ void perf_prepare_sample(struct perf_sample_data *data,
 	 * sample flags that have already been done by the PMU driver.
 	 */
 	filtered_sample_type = sample_type;
-	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_CODE_PAGE_SIZE,
+	filtered_sample_type |= __cond_set(sample_type,
+					   PERF_SAMPLE_CODE_PAGE_SIZE |
+					   PERF_SAMPLE_BUILD_ID_OFFSET,
 					   PERF_SAMPLE_IP);
 	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_DATA_PAGE_SIZE |
 					   PERF_SAMPLE_PHYS_ADDR, PERF_SAMPLE_ADDR);
@@ -8825,8 +8906,14 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->sample_flags |= PERF_SAMPLE_IP;
 	}
 
-	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, regs);
+	if (filtered_sample_type &
+	    (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) {
+		if (!(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
+			perf_sample_save_callchain(data, event, regs);
+		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
+			data->dyn_size += sizeof(u64);
+	}
+
 
 	if (filtered_sample_type & PERF_SAMPLE_RAW) {
 		data->raw = NULL;
@@ -8986,6 +9073,24 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->dyn_size += size + sizeof(u64); /* size above */
 		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
+
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		u32 header_size = perf_sample_data_size(data, event);
+		u32 max_size = 0;
+		struct perf_callchain_build_id_entry *entry;
+
+		if (header_size < U16_MAX)
+			max_size = round_down(U16_MAX - header_size, sizeof(u64));
+
+		entry = perf_callchain_build_id(event, data->callchain,
+						data->ip,
+						!!(sample_type & PERF_SAMPLE_BUILD_ID_OFFSET),
+						max_size);
+		data->callchain_build_id = entry;
+		data->dyn_size += entry->build_ids_len +
+				  entry->nr_offsets * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
+	}
 }
 
 void perf_prepare_header(struct perf_event_header *header,
@@ -10822,7 +10927,8 @@ static int bpf_overflow_handler(struct perf_event *event,
 		int callchain_rctx;
 
 		perf_prepare_sample(data, event, regs);
-		if (data->sample_flags & PERF_SAMPLE_CALLCHAIN)
+		if (data->sample_flags &
+		    (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
 			callchain = get_callchain_entry(&callchain_rctx);
 		ret = bpf_prog_run(prog, &ctx);
 		if (callchain)
@@ -10851,7 +10957,8 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
 
 	if (event->attr.precise_ip &&
 	    prog->call_get_stack &&
-	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
+	    (!(event->attr.sample_type &
+	       (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) ||
 	     event->attr.exclude_callchain_kernel ||
 	     event->attr.exclude_callchain_user)) {
 		/*
@@ -13713,7 +13820,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
+		if (event->attr.sample_type &
+		    (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
 				return ERR_PTR(err);
@@ -13868,6 +13976,15 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (attr->sample_type & PERF_SAMPLE_CGROUP)
 		return -EINVAL;
 #endif
+#ifndef CONFIG_BPF_SYSCALL
+	if (attr->sample_type &
+	    (PERF_SAMPLE_BUILD_ID_OFFSET | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
+		return -EINVAL;
+#endif
+	if (attr->defer_callchain &&
+	    (attr->sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	    (attr->sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
+		return -EINVAL;
 	if ((attr->sample_type & PERF_SAMPLE_WEIGHT) &&
 	    (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT))
 		return -EINVAL;
@@ -14096,7 +14213,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	if (!attr.exclude_kernel || attr.text_poke ||
-	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	    ((attr.sample_type &
+	      (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
 		if (err)
-- 
2.56.1.703.gf848ed807c-goog

