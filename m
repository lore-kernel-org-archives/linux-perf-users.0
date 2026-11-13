Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599777;
	b=yw13zjPmyA9VASMtfkEKLk0pZRRucOBSsSPgc9o78CTwVQoXzIWuNvcQ5VSdRHOlDPcn
	 +tlM7UchmoOVjWnPOAIHbfIMtkQ5Lwu8keR7tfh+cA/cqq1iN4NyDjN6oXvgc6Vkf8pTr
	 /ZNxXgXClQSMIO6qvP+jowffMEhunPBL6YbJZJBOD4/h2Ug2kdgx/UQmwCeWBZJ5W56Aw
	 c8PDO9VNLQUSLuLTVnuxMcmKoVv9udiUlaqv43+3175lHagYF2tPO487ln6dw2eVGnx6z
	 Mpwem0MLwyR6eNlwfcR9DvoPJByB4xsKBkeR8uH6lTCV0o02k75okaas5Q/bi+ELeog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UpLlzZWrAnxDB6IGxS+hBNOhZxc/rVEG6QvTtAQK1tk=;
	b=oNgnxNlrv113QhoP7Hdra3Uj+JtK6Jt01Vrbq1Jw2NYHfqOaUn8EGMTPi1CxmNnGTDyF
	 uPhxBxCi94T3XcHpOsKUVCAH0yFMzc02xvxcBv2rAW9kz+f5tmt+lNfwcXKBDdKjRcVAl
	 KxRfCOC6VSrU6UZ0z0WY1vifLFkjAAjLLCsKWKF/pwemAjfU2Rnr/jzYrTzELdqH8M2x+
	 F41T73Ut5lkQWKKNlFw/0MO5avBYtZcH8cepYz5msvMPYokCKXocmcGArv3u9D4Y5N1MR
	 8T2vVbx8/LdjQOtytlNF+GmcERtnqB7T0YU8atkRT0UiU/sN+09t+NDvjSQVrkNqIwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="P0VMPQe/";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEF60A5BC3
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FEF60A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P0VMPQe/
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2031049eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599775; x=1795204575; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UpLlzZWrAnxDB6IGxS+hBNOhZxc/rVEG6QvTtAQK1tk=;
        b=P0VMPQe/HoaeWP5ICK+neE8fqvcHtvW2bSm69ha7ovmSykP1TZaxa1hzE4Y9qrNJpC
         w9xG5jY9C2wFtoYiWMFGUrzV7684oyOS2PZGhl+Q4N55uYddrF8Yo9ziVzijSSwjxdzB
         czGb/AgZ98P77pHOsABNe9/7FI14kpcbdBjfM6oVDf7I6uqdo4kWMqBC7dl0iISKVYAT
         8QP6aZGA4cW8S0Hse4/SgZbJ6DT7DirFIqWbGr1KELg0A7ZhFLuo/r7fX89yZxpoayyP
         83nj3kC+/sIJ72OtiKpMr1gtrEkebrvB54JTPa4W+U4wbTmGsP0g/ARH/IK78+8Kb4aa
         Lgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599775; x=1795204575;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UpLlzZWrAnxDB6IGxS+hBNOhZxc/rVEG6QvTtAQK1tk=;
        b=L0ACPHJlzigT9C/HpoKC05zuMRQtJ8RFkbdCeY+ZVirzC1fJ6gCyyxXvyCRv6sr5M1
         z8HQgcNbzxTRynSV8XG3pMKSpRzOGcUqVQypRcIWnVX50BP8lUgp7X8kx7oR99PfVYW6
         cTGt3rL9K2peZ4uWHK3pHnLhpZ7LNvlNIVaUgIAXPPEiCfRRh859DrYhsEgv3P0WMlnv
         gUk9DXxG5VIhiaHcVhunKLgEJf8EIbZA7eBTugQK5faoDM8cogqL2XJ6mkjMm3AJ556G
         gzIqkksF8YIt+fwpAW/uP5+i8NxeI7bLBzX+o8u926H5Jq/2kn7Hjt31Zv3wRQmKgk6Y
         OnnA==
X-Gm-Message-State: APuU4Z8+0PAE9oZhYjOOZNSNDFhmNIeCsGprhINUhWIezGnB6Atj8+ap
	YgIVoonZg5Av4yMbqC/dn97KrgTFl5gOAz/ivrALLB6kNSkHJH6wGZb/231JKLflth4tdkAzJpn
	TFtsW1+qJVg==
X-Received: from dlea16-n1.prod.google.com ([2002:a05:701b:4210:10b0:17d:5c89:d119])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c81:b0:187:c940:21b9
 with SMTP id a92af1059eb24-1b5031217d2mr2843490c88.30.1794599774451; Fri, 13
 Nov 2026 11:56:14 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:49 -0800
In-Reply-To: <20261113195601.2872738-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195601.2872738-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195601.2872738-5-irogers@google.com>
Subject: [PATCH v2 04/16] perf pmu: Probe supported sample_type flags
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
index be93ff8b9948..d8bcf0e91f6f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3125,6 +3125,101 @@ static bool try_open_attr_variants(struct perf_event_attr *attr,
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
@@ -3376,6 +3471,10 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.1.703.gf848ed807c-goog

