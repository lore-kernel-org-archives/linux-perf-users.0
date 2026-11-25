Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567892;
	b=ShKB8jvKzXMig5aTklNQKgkkdD9xX4L+JJJ8KqLmmtZtHLBPImcV36pLmhCpeizELFNb
	 Wmx8S7oviDeZ+V4xYKW30s6KU8JRpE8dA1ww9dy4DWv3V4YsSWIw8xy9s1IMdeqJyQGwY
	 l808tkpfZQ05TbPLkbyIrxnQgyyRSm5wCyau9SXcptBcDrNt2thV4A8GwdLMwLM/zzRX/
	 wKCgRSmTTiN53UZVUHWyeQiyLq4AxGq6E1AFJrR3BY0znXRFDQtFDvqdCYYoRgRbVXrVw
	 lV9t47Lad7zHS14Hu1ekl6LmIDsZeS6eoDVSjYSUhZHBKEiOc7jFBocuEI5/tiLpKLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Ch8U4bObunn7rS7WsavHJXD4li791CkBj4Ye2ULy+kE=;
	b=zv9H/xZBqa6DZ8IZF+ZJ25Rk8U677aovDc/m6Er2ctp+CTuPYsXtUb1EMd67Dv8y63OU
	 8BKWF+YkvFPtULb70aRSF+dm9DpvZc9cT5ZNN6150WPluBkkli68kNOnpJ0HGpcVaFF0K
	 yIm0VJPbTEqv7QGCM01VCEl59POydzEZMSvBDrX6r49comyJyT4B/ger0Sfi6yPdGDbp7
	 IYR5cHsogHodERqvrqwfsVE/QSju8clu7JpP8bqrOHYFbMEBd6j9v45qsS4ku9EmkXlVL
	 FYhHdiCZBDAq3qBpO/OORPOnesW0RXe96qH/ENrVp0Prpg15kw9lOe5nIqb9bOU18EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jN5vHEaw;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE90606A329
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE90606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jN5vHEaw
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386a65fca25so4002125eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567891; x=1796172691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ch8U4bObunn7rS7WsavHJXD4li791CkBj4Ye2ULy+kE=;
        b=jN5vHEawZ3oRTkPqPDvQPKMcInt37gkLXcRPZSbVJ0MSQ7zzuvOArUGhGp3JiwCRB8
         X4Nbeb2znE3Rc2prTG07d73sBLWQJ3ERdMBkBjUZ17K9d0zRWG7j2jWI05eoZOKQ3FGG
         X79JSluPnmYWhLjsSpYXTgggLIJLMxKN2OPDPINR7rPSDdlk9fDHp6FQWb/h9k96DUZq
         7rr8iyl9QcDC5Yu73XO5jImerrTybo/BVmdzfVALQDTAC3PkxLJnGxgDHFdbq1CQUEZS
         Ytcq0HAKE2MoGxKal69r+PcD9a6G1w9NMNypbm+n0qFTxjFZUYXFIkXkgasD2GMLvjMW
         irHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567891; x=1796172691;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ch8U4bObunn7rS7WsavHJXD4li791CkBj4Ye2ULy+kE=;
        b=TlupUlDIx1KCn9FwSa+YCRi30dWKljM6jP/zDncX7hzsrFhVtNTF5Lj5Yz+R43Sc+y
         cpvL5S+jtW/RaISawPbhrVF4PJn+X9l78GweWwvCRpR8YBrJ894VLfW13mzjtZkRTKF9
         Gu0QpoPzpFydHZ8+FjfSi+BRaaI/Ox38CcIUWL0NDNBRCbAvFBX/0c4qBAEDA+rvkVHO
         iq3xG2E+96/vLyJvjFa5tQJ4maLk11/SE9ZioQshZMJb62UDhilxL330DIPD6wsN46sX
         KrR2B4kzWcLr/bACQdpyBcnTNcMr4gAJJ05Hlw5mtja7ZAxhP9Z0z3jEtNze2/mN2+6I
         IfGQ==
X-Forwarded-Encrypted: i=1; AL+hErF3wq8IbxnsGGMKUsEsWAcTZabl1xZGsn/ZgqAfpRwl7e6GZZWyRqDo0fULp6T7+CsI0RFD3NSXjPtwFUmbqeEQ@vger.kernel.org
X-Gm-Message-State: APuU4Z/xsPsu0+cIQCZ27HY0q9jrSF20vREiJ8dpWLEZ1bnxu+mM7ICz
	yYQgNtyhhp5bcMkfaP4VpnOcgYQIuPMVwmrrqewcZchNP/96qWxR1vm0GdKVpt4Opjv24FxLFIo
	sJE41AqTCuw==
X-Received: from dybkf17.prod.google.com ([2002:a05:7301:3a91:b0:359:198a:8046])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:88db:20b0:386:1920:ea0c
 with SMTP id 5a478bee46e88-3861920f023mr14216244eec.37.1795567890386; Tue, 24
 Nov 2026 16:51:30 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:54 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-6-irogers@google.com>
Subject: [PATCH v4 05/19] perf/core: Implement BUILD_ID_OFFSET and
 CALLCHAIN_BUILD_ID_OFFSET sample types
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Implement synchronous PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET payload writing in the perf event
core using stack_map_get_build_id_offset(..., may_fault=false), placing
both fields prior to PERF_SAMPLE_AUX so AUX continues to consume the
remaining sample space up to U16_MAX.

For callchains, introduce separately refcounted per-CPU scratch buffers
in kernel/events/callchain.c (allocated on demand only while at least
one PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET event is active) to
deduplicate build IDs and encode the compressed build ID table and
tagged 64-bit offsets (with the top 8 bits storing the 1-based build ID
index). At the default perf_event_max_stack=127 and
perf_event_max_contexts_per_stack=8, each recursion slot uses 10,560
bytes (42,240 bytes / 41.25 KiB per possible CPU across
PERF_NR_CONTEXTS=4), while plain PERF_SAMPLE_CALLCHAIN events incur no
extra memory overhead.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/perf/core-book3s.c |  10 +-
 arch/s390/kernel/perf_cpum_sf.c |   6 +-
 include/linux/perf_event.h      |  45 ++++-
 kernel/bpf/stackmap.c           |   4 +-
 kernel/events/callchain.c       | 308 ++++++++++++++++++++++++++++++--
 kernel/events/core.c            | 137 +++++++++++++-
 6 files changed, 483 insertions(+), 27 deletions(-)

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
index 7bfeb5208177..f3722dc707ff 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -840,8 +840,10 @@ static bool is_callchain_event(struct perf_event *event)
 {
 	u64 sample_type = event->attr.sample_type;
 
-	return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER |
-			      PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_STACK_USER);
+	return sample_type & (PERF_SAMPLE_CALLCHAIN_TYPE |
+			      PERF_SAMPLE_BUILD_ID_OFFSET |
+			      PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR |
+			      PERF_SAMPLE_STACK_USER);
 }
 
 static int cpumsf_pmu_event_init(struct perf_event *event)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1e11500df09..401c62b401bc 100644
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
@@ -729,6 +754,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_EXCLUSIVE		0x0080
 #define PERF_ATTACH_CALLCHAIN		0x0100
 #define PERF_ATTACH_ITRACE		0x0200
+#define PERF_ATTACH_CALLCHAIN_BUILD_ID	0x0400
 
 struct bpf_prog;
 struct perf_cgroup;
@@ -1347,6 +1373,7 @@ struct perf_sample_data {
 	u64				data_page_size;
 	u64				code_page_size;
 	u64				aux_size;
+	struct perf_callchain_build_id_entry *callchain_build_id;
 } ____cacheline_aligned;
 
 /* default value for data source */
@@ -1377,7 +1404,7 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
-	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_TYPE))
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
 
@@ -1745,8 +1773,21 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
+extern int get_callchain_build_id_buffers(int max_stack);
+extern void put_callchain_build_id_buffers(void);
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
index 11f6349b2b8d..e39b26f0f1df 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -691,7 +691,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	int ret;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
-	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_TYPE))
 		return bpf_get_stackid((unsigned long)(ctx->regs),
 				       (unsigned long) map, flags, 0, 0);
 
@@ -982,7 +982,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	int err = -EINVAL;
 	__u64 nr_kernel;
 
-	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_TYPE))
 		return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 9d24b6e0c91f..14d4c8d7d8c3 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/perf_event.h>
+#include <linux/bpf.h>
 #include <linux/slab.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uprobes.h>
@@ -31,10 +32,31 @@ static inline size_t perf_callchain_entry__sizeof(void)
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
+static inline size_t perf_callchain_build_id_slot__sizeof(void)
+{
+	return perf_callchain_build_id_entry__sizeof() +
+	       perf_callchain_bpf_build_id__sizeof();
+}
+
 static DEFINE_PER_CPU(u8, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
+static atomic_t nr_callchain_build_id_events;
 static DEFINE_MUTEX(callchain_mutex);
 static struct callchain_cpus_entries *callchain_cpus_entries;
+static struct callchain_cpus_entries *callchain_build_id_cpus_entries;
 
 
 __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
@@ -69,11 +91,21 @@ static void release_callchain_buffers(void)
 	call_rcu(&entries->rcu_head, release_callchain_buffers_rcu);
 }
 
-static int alloc_callchain_buffers(void)
+static void release_callchain_build_id_buffers(void)
+{
+	struct callchain_cpus_entries *entries;
+
+	entries = callchain_build_id_cpus_entries;
+	RCU_INIT_POINTER(callchain_build_id_cpus_entries, NULL);
+	call_rcu(&entries->rcu_head, release_callchain_buffers_rcu);
+}
+
+static struct callchain_cpus_entries *
+alloc_callchain_cpus_entries(size_t slot_size)
 {
-	int cpu;
-	int size;
 	struct callchain_cpus_entries *entries;
+	size_t size;
+	int cpu;
 
 	/*
 	 * We can't use the percpu allocation API for data that can be
@@ -84,9 +116,9 @@ static int alloc_callchain_buffers(void)
 
 	entries = kzalloc(size, GFP_KERNEL);
 	if (!entries)
-		return -ENOMEM;
+		return NULL;
 
-	size = perf_callchain_entry__sizeof() * PERF_NR_CONTEXTS;
+	size = slot_size * PERF_NR_CONTEXTS;
 
 	for_each_possible_cpu(cpu) {
 		entries->cpu_entries[cpu] = kmalloc_node(size, GFP_KERNEL,
@@ -95,16 +127,41 @@ static int alloc_callchain_buffers(void)
 			goto fail;
 	}
 
-	rcu_assign_pointer(callchain_cpus_entries, entries);
-
-	return 0;
+	return entries;
 
 fail:
 	for_each_possible_cpu(cpu)
 		kfree(entries->cpu_entries[cpu]);
 	kfree(entries);
 
-	return -ENOMEM;
+	return NULL;
+}
+
+static int alloc_callchain_buffers(void)
+{
+	struct callchain_cpus_entries *entries;
+
+	entries = alloc_callchain_cpus_entries(perf_callchain_entry__sizeof());
+	if (!entries)
+		return -ENOMEM;
+
+	rcu_assign_pointer(callchain_cpus_entries, entries);
+
+	return 0;
+}
+
+static int alloc_callchain_build_id_buffers(void)
+{
+	struct callchain_cpus_entries *entries;
+
+	entries = alloc_callchain_cpus_entries(
+			perf_callchain_build_id_slot__sizeof());
+	if (!entries)
+		return -ENOMEM;
+
+	rcu_assign_pointer(callchain_build_id_cpus_entries, entries);
+
+	return 0;
 }
 
 int get_callchain_buffers(int event_max_stack)
@@ -151,6 +208,44 @@ void put_callchain_buffers(void)
 	}
 }
 
+int get_callchain_build_id_buffers(int event_max_stack)
+{
+	int err = 0;
+	int count;
+
+	mutex_lock(&callchain_mutex);
+
+	count = atomic_inc_return(&nr_callchain_build_id_events);
+	if (WARN_ON_ONCE(count < 1)) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (event_max_stack > sysctl_perf_event_max_stack) {
+		err = -EOVERFLOW;
+		goto exit;
+	}
+
+	if (count == 1)
+		err = alloc_callchain_build_id_buffers();
+exit:
+	if (err)
+		atomic_dec(&nr_callchain_build_id_events);
+
+	mutex_unlock(&callchain_mutex);
+
+	return err;
+}
+
+void put_callchain_build_id_buffers(void)
+{
+	if (atomic_dec_and_mutex_lock(&nr_callchain_build_id_events,
+				      &callchain_mutex)) {
+		release_callchain_build_id_buffers();
+		mutex_unlock(&callchain_mutex);
+	}
+}
+
 struct perf_callchain_entry *get_callchain_entry(int *rctx)
 {
 	int cpu;
@@ -172,12 +267,204 @@ struct perf_callchain_entry *get_callchain_entry(int *rctx)
 		(*rctx * perf_callchain_entry__sizeof()));
 }
 
+struct perf_callchain_build_id_entry *
+get_callchain_build_id_entry(int *rctx, struct bpf_stack_build_id **bpf_bids)
+{
+	struct callchain_cpus_entries *entries;
+	void *base;
+	int cpu;
+
+	*rctx = get_recursion_context(this_cpu_ptr(callchain_recursion));
+	if (*rctx == -1)
+		return NULL;
+
+	entries = rcu_dereference(callchain_build_id_cpus_entries);
+	if (!entries) {
+		put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
+		return NULL;
+	}
+
+	cpu = smp_processor_id();
+	base = ((void *)entries->cpu_entries[cpu]) +
+	       (*rctx * perf_callchain_build_id_slot__sizeof());
+	if (bpf_bids)
+		*bpf_bids = base + perf_callchain_build_id_entry__sizeof();
+
+	return base;
+}
+
 void
 put_callchain_entry(int rctx)
 {
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
@@ -290,7 +577,8 @@ static int perf_event_max_stack_handler(const struct ctl_table *table, int write
 		return ret;
 
 	mutex_lock(&callchain_mutex);
-	if (atomic_read(&nr_callchain_events))
+	if (atomic_read(&nr_callchain_events) ||
+	    atomic_read(&nr_callchain_build_id_events))
 		ret = -EBUSY;
 	else
 		*value = new_value;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d67bb825c504..2a6ab82d617e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2094,6 +2094,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		size += sizeof(data->code_page_size);
 
+	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		size += sizeof(struct perf_sample_build_id_offset);
+
 	event->header_size = size;
 }
 
@@ -5784,6 +5787,9 @@ static void __free_event(struct perf_event *event)
 
 	security_perf_event_free(event);
 
+	if (event->attach_state & PERF_ATTACH_CALLCHAIN_BUILD_ID)
+		put_callchain_build_id_buffers();
+
 	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
 		put_callchain_buffers();
 
@@ -8394,6 +8400,78 @@ static void perf_output_read(struct perf_output_handle *handle,
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
@@ -8580,6 +8658,10 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		perf_output_put(handle, data->code_page_size);
 
+	if (sample_type &
+	    (PERF_SAMPLE_BUILD_ID_OFFSET | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
+		perf_output_sample_build_id(handle, header, data, event);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -8802,7 +8884,9 @@ void perf_prepare_sample(struct perf_sample_data *data,
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
@@ -8823,8 +8907,13 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->sample_flags |= PERF_SAMPLE_IP;
 	}
 
-	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, regs);
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_TYPE) {
+		if (!(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
+			perf_sample_save_callchain(data, event, regs);
+		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
+			data->dyn_size += sizeof(u64);
+	}
+
 
 	if (filtered_sample_type & PERF_SAMPLE_RAW) {
 		data->raw = NULL;
@@ -8963,6 +9052,24 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->sample_flags |= PERF_SAMPLE_CODE_PAGE_SIZE;
 	}
 
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
+
 	if (filtered_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 		u16 header_size = perf_sample_data_size(data, event);
@@ -10823,7 +10930,7 @@ static int bpf_overflow_handler(struct perf_event *event,
 		/* bpf_perf_event_data::addr is readable without PERF_SAMPLE_ADDR */
 		if (!(data->sample_flags & PERF_SAMPLE_ADDR))
 			data->addr = 0;
-		if (data->sample_flags & PERF_SAMPLE_CALLCHAIN)
+		if (data->sample_flags & PERF_SAMPLE_CALLCHAIN_TYPE)
 			callchain = get_callchain_entry(&callchain_rctx);
 		ret = bpf_prog_run(prog, &ctx);
 		if (callchain)
@@ -10852,7 +10959,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
 
 	if (event->attr.precise_ip &&
 	    prog->call_get_stack &&
-	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
+	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_TYPE) ||
 	     event->attr.exclude_callchain_kernel ||
 	     event->attr.exclude_callchain_user)) {
 		/*
@@ -13710,12 +13817,19 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
+		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_TYPE) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
 				return ERR_PTR(err);
 			event->attach_state |= PERF_ATTACH_CALLCHAIN;
 		}
+		if (event->attr.sample_type &
+		    PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+			err = get_callchain_build_id_buffers(attr->sample_max_stack);
+			if (err)
+				return ERR_PTR(err);
+			event->attach_state |= PERF_ATTACH_CALLCHAIN_BUILD_ID;
+		}
 	}
 
 	err = security_perf_event_alloc(event);
@@ -13865,6 +13979,15 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
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
@@ -14093,7 +14216,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	if (!attr.exclude_kernel || attr.text_poke ||
-	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN_TYPE) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
 		if (err)
-- 
2.56.1.831.g720f3f5937-goog

