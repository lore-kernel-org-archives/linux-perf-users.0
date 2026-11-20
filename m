Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213602;
	b=l95Kf2EBItGODhs2+Uw6upwJNrcuWEjF2NRdcIrtgVVUO90RpoQJ+qA7nA/XMxpJ3Hmz
	 JpQRhuFrGkCxdurC9smzBvuRuO9mlg+pys8DSbHdbxUeF2ZzHCQVLL7JtKvsnqK9N9XgI
	 siIXLERK3tE+gi0IgEIUSo7pvKTMqqVZ91yX1aVn7WwVKHhJJQVhR0GMifCsTqgdwv6Te
	 K88KJuwH8SuJ9KHZC4Pra8rs8TbOpEe5Gum7H3uXFOMV+jy1neY5pm4Mrcb6XWRDnDH1B
	 FRnbOVnSbBIhXuIrMB+cuQUqgdGVMfw5mJLuMKTO4SU6mbibVwWzhQikoc6dWIP1Whg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XzVFXLEpQAhP3RSrGRow2AFakf2rMWqo48qyJBP4QEE=;
	b=ITmf4Dkjm/mYDTWLymtOAVCQaIiDCbS6Q/1ox+QRHtXa4HVcYgyw16ABvXEQKmBU2l9L
	 gu0XOjPvdQQvx6L0UT/QGCpCSkyn5Je7WtNSy7ZNoskOL+ebs5mbur3ZVOfKZqrMfPbU0
	 d4jYVTbk0eveoEXL8kINtyffdw0XmIoxyNOaLy4f+wOSdy0ZBvaFf/x7j3FCxYu742uLc
	 K9ldRYbHPVXRimBIFnK9Z7ZL4/B7jaDsyEkGvGwMWEDFluwUEUlMstiTM8Zn2IijzQXgl
	 JdgEcNd3D+535uQRHYEwBs3RPS6Uc6v2zWW0aU06U4Wd8LNY13ZmW+lJDx+y5qQXgig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="qAr7/LzE";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9EF606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A9EF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qAr7/LzE
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-375bac6bd21so1489171eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213601; x=1795818401; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzVFXLEpQAhP3RSrGRow2AFakf2rMWqo48qyJBP4QEE=;
        b=qAr7/LzE4NxYhLkOZhAXjjRnzd0arBSF3fSFCqb5BlXtBThxugDtViTxqiyjQw6OO6
         +MY43ci7W1w9UWgDVHJQIj4TW22aA4ynS9/scx6Wys+Wh4gbPjUzO5eRiVU0shl5GtM9
         Lji09Z/66QS+w5TnBxrhKSBLhPs4kCyxHxFh1jxHkvH3tJJsct7PEKnTQoL+d+97k50X
         1W0qfGYu9dmXXX5z/AcaxQyLMUs4Ekir8w665X2h9XzhBngK1Zqm0g3RUwgWzeXKXFgE
         00uv0g+pxXI1QVKZLRV5zsP99bH2L8hHfZj3BbzFDfLJSoz+ytBfGP+WZ5zVkIvubqWF
         9CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213601; x=1795818401;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzVFXLEpQAhP3RSrGRow2AFakf2rMWqo48qyJBP4QEE=;
        b=zH8Ek3tdaJNf4WWnh7tyLAEOHianCiiZlKeAsC/q0otmel861YNNHpktaJHRe6FG5F
         ueXemZoGGc9oNWVIHFGMRX2uzx1PA8zFUuJCu4YloVI3xhlYSOORuucB29L3Fp1wnivi
         K8Jz8sit52gC7NgzOlVtz3SE2my/jDzH/NbbBf8vZgLskEqDkvGOnbvhjLgiJeg9KXzC
         PtMDA/FYznMB5RREX9JzxpMPiRBY2uA13Hup2X3kPa6id7gb/g/HzzDXUXXQPPUFfgtS
         W+BJns9CH1XaNRscaoT/5kIK/aoEA0SrTNCGoQUAqypMN0e1fXZzt5RxAp6n+DR5OV0p
         rr2A==
X-Gm-Message-State: APuU4Z/VdV3jysFVA3Jyf6KSaydpxZ1isOYp+VYFp6R18jvorQmSlmmy
	F9YgHEi6cfDLNfehD096dizSzldRp8G+fiDROm8E/YXUDnjXpyz25K60/0gI0L2IbnXM6HUKFCH
	JwnvdDJ8CTg==
X-Received: from dya26.prod.google.com ([2002:a05:693c:621a:b0:376:583a:e72a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:8616:b0:385:9424:5c08
 with SMTP id 5a478bee46e88-38594245c66mr4455959eec.4.1795213600822; Fri, 20
 Nov 2026 14:26:40 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:03 -0800
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120222615.2291168-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120222615.2291168-5-irogers@google.com>
Subject: [PATCH v3 04/16] perf pmu: Probe supported sample_type flags
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() with probe_sample_types() to test which enum
perf_event_sample_format flags are supported by the PMU.

First test a common bulk sample_type mask with a single
perf_event_open() call to avoid per-bit syscall overhead when all
standard sample flags are supported, and then probe any remaining
PERF_SAMPLE_* bits individually (configuring required companion fields
such as branch_sample_type, sample_regs_user, sample_regs_intr, and
sample_stack_user). Populate probed.sample_types as well as convenience
booleans for branch stack, callchain, data_src, and weight sampling.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h | 13 ++++++
 2 files changed, 112 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b43afb8b155b..e965a47bf3b4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3135,6 +3135,101 @@ static bool try_open_attr_variants(struct perf_event_attr *attr,
 	return false;
 }
 
+/*
+ * Probe which enum perf_event_sample_format flags are supported by @pmu,
+ * testing a common bulk mask first before probing individual flags.
+ */
+static void probe_sample_types(struct perf_pmu *pmu,
+			       const struct perf_event_attr *base_attr,
+			       pid_t pid, int cpu, unsigned long flags)
+{
+	int dummy_abi = -1;
+	u64 user_regs = perf_user_reg_mask(EM_HOST, &dummy_abi);
+	u64 intr_regs = perf_intr_reg_mask(EM_HOST, &dummy_abi);
+	u64 user_reg_bit = user_regs ? (user_regs & (~user_regs + 1)) : 1ULL;
+	u64 intr_reg_bit = intr_regs ? (intr_regs & (~intr_regs + 1)) : 1ULL;
+	u64 bulk_mask = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
+			PERF_SAMPLE_ADDR | PERF_SAMPLE_READ | PERF_SAMPLE_CALLCHAIN |
+			PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD |
+			PERF_SAMPLE_STREAM_ID | PERF_SAMPLE_RAW | PERF_SAMPLE_REGS_USER |
+			PERF_SAMPLE_STACK_USER | PERF_SAMPLE_WEIGHT | PERF_SAMPLE_DATA_SRC |
+			PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_TRANSACTION |
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_CGROUP |
+			PERF_SAMPLE_DATA_PAGE_SIZE | PERF_SAMPLE_CODE_PAGE_SIZE;
+	struct perf_event_attr b_attr = *base_attr;
+	int b_fd;
+
+	b_attr.disabled = 1;
+	b_attr.sample_period = base_attr->sample_period ?: 10000;
+	b_attr.sample_type = bulk_mask;
+	b_attr.sample_regs_user = user_reg_bit;
+	b_attr.sample_regs_intr = intr_reg_bit;
+	b_attr.sample_stack_user = 64;
+	b_attr.exclude_callchain_kernel = b_attr.exclude_kernel;
+	b_attr.inherit = 0;
+	b_fd = sys_perf_event_open(&b_attr, pid, cpu, -1, flags);
+	if (b_fd >= 0) {
+		close(b_fd);
+		pmu->probed.sample_types |= bulk_mask;
+	}
+
+	for (unsigned int shift = 0; (1ULL << shift) < PERF_SAMPLE_MAX; shift++) {
+		u64 bit = 1ULL << shift;
+		struct perf_event_attr attr = *base_attr;
+		int fd;
+
+		if (pmu->probed.sample_types & bit)
+			continue;
+
+		attr.disabled = 1;
+		attr.sample_period = base_attr->sample_period ?: 10000;
+		attr.sample_type = bit;
+
+		switch (bit) {
+		case PERF_SAMPLE_BRANCH_STACK:
+			attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY |
+				(attr.exclude_kernel ? PERF_SAMPLE_BRANCH_USER : 0);
+			break;
+		case PERF_SAMPLE_CALLCHAIN:
+			attr.exclude_callchain_kernel = attr.exclude_kernel;
+			break;
+		case PERF_SAMPLE_REGS_USER:
+			attr.sample_regs_user = user_reg_bit;
+			break;
+		case PERF_SAMPLE_REGS_INTR:
+			attr.sample_regs_intr = intr_reg_bit;
+			break;
+		case PERF_SAMPLE_STACK_USER:
+			attr.sample_stack_user = 64;
+			break;
+		case PERF_SAMPLE_READ:
+			attr.inherit = 0;
+			break;
+		default:
+			break;
+		}
+
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		if (fd < 0 && bit == PERF_SAMPLE_BRANCH_STACK) {
+			attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY;
+			fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		}
+		if (fd < 0 && bit != PERF_SAMPLE_IP) {
+			attr.sample_type = PERF_SAMPLE_IP | bit;
+			fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		}
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.sample_types |= bit;
+		}
+	}
+
+	pmu->probed.can_branch_stack = !!(pmu->probed.sample_types & PERF_SAMPLE_BRANCH_STACK);
+	pmu->probed.can_callchain = !!(pmu->probed.sample_types & PERF_SAMPLE_CALLCHAIN);
+	pmu->probed.can_data_src = !!(pmu->probed.sample_types & PERF_SAMPLE_DATA_SRC);
+	pmu->probed.can_weight = !!(pmu->probed.sample_types & PERF_SAMPLE_WEIGHT);
+}
+
 static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 {
 	struct probe_candidates cands = { .nr = 0 };
@@ -3386,6 +3481,10 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 		pmu->probed.can_sample = true;
 	}
 
+	/* 2. All enum perf_event_sample_format types */
+	if (pmu->probed.can_sample)
+		probe_sample_types(pmu, &base_attr, pid, cpu, flags);
+
 	if (keepalive_fd >= 0)
 		close(keepalive_fd);
 	pmu->probed.checked = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index ddcd28b3cae5..658485faa05d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -226,10 +226,23 @@ struct perf_pmu {
 		bool can_count;
 		/** @probed.can_sample: Supports interrupt-based sampling (sample_period > 0). */
 		bool can_sample;
+		/** @probed.can_branch_stack: Supports PERF_SAMPLE_BRANCH_STACK. */
+		bool can_branch_stack;
+		/** @probed.can_callchain: Supports PERF_SAMPLE_CALLCHAIN. */
+		bool can_callchain;
+		/** @probed.can_data_src: Supports PERF_SAMPLE_DATA_SRC. */
+		bool can_data_src;
+		/** @probed.can_weight: Supports PERF_SAMPLE_WEIGHT. */
+		bool can_weight;
 		/** @probed.probe_event: Name of the event used to probe the PMU. */
 		char *probe_event;
 		/** @probed.open_err: errno if open_supported is false. */
 		int open_err;
+		/**
+		 * @probed.sample_types: Bitmask of supported
+		 * enum perf_event_sample_format flags.
+		 */
+		u64 sample_types;
 	} probed;
 };
 
-- 
2.56.1.750.gf70dc682cf-goog

