Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749586;
	b=JgySDP1UzTIxx6+TCX0Rz4ma4IXPmZ2X/IddOGyPb1YmqlEwxHyLOlOlIo5B92euLbnr
	 1QO+ikUU5vIHu8iUU1mQM8E8OpGl89b1pHWIfAZ3n+qzhEC9tnlIHq1Bp5SFP9n4ZUWs1
	 NDR7mSmMOnM2YvY44Iu3rL0KrbnH2NcQUYz8v4CCrGuFFcDvnfBVmzWqTeLQhud4Xxdua
	 OGdMqgqWrAZmwmiTLrPCQ6a53Lvonxg9OrUY9tAWpX2rCP2B3IFiO4l0QmvnGDgwEvP3x
	 yUwXDpMnVo9S/O5N984VKeiZPmwQjr0BHXS9/kxEKmPH2fKNGv00ijm1llTJ7vJsWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QWrUOGCpXzdW7m/vGfdI2/6APYtveX3HL+c/34q2WdQ=;
	b=r9aTo9Acszzip9e780pO18k9mm9MM/2Sm5/OPQlENDSqQgoU/ZIOBHTd6S9I6Ek+w+9K
	 UoxHmr/Rj9rMsEctnGC0q07b0QLtBcpQr1u2klVduyXWVdSRvbLPZFhkKz9vjVoIpFeHt
	 4ueovksFANEYAjKqdPwhcUxs6qpSe3nDL6O7XlztVJq/sG8vWNpRNpG5E/7wIbFqnWacC
	 +i1hB5K9lfvyWLLDYWU1Xds6Z7A4d88CNQ6JEUcSOvPvjb4f9frY6eV1jk6W8qZK8QBEr
	 TTLAFlFH5zKGMRi2bu+TJne4GOcKg6+KPE1FVHCsv6dlUbpoSUnuwmvzUMOUH77nhnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NfkjKTze;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287006083629
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 287006083629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NfkjKTze
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so341194eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749585; x=1794354385; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWrUOGCpXzdW7m/vGfdI2/6APYtveX3HL+c/34q2WdQ=;
        b=NfkjKTzek8lzSet5DGBywnwWYRt5MxP4wEt7V+7kY8cUayxmk0BVa09YVneuSVsxZx
         0oA0L5OIRxDfAwQcqWijZPHlJtYoyNrpEWtCevLwVROmVtKMmcj1ZvA9Iy414qrNhVW+
         8qV/UEOPb0mXKGCwPgslwISNhy+Lf/xQLwI2eQetk5RXrD9ibnTFJD8/G55va6PxooBo
         88eZZmLvxBsoFSwxhYtIAaa+QhfG7/fyADlY4lADhp9Rw+nQ7rMNoNeMl8lHCl4YgbuO
         34jIvV0MW07wxyLMp6mgf6uTO0pHSrEC8077OYBvXg6XKWQN9mKLv93ccB+i1TqT2XAT
         v9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749585; x=1794354385;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWrUOGCpXzdW7m/vGfdI2/6APYtveX3HL+c/34q2WdQ=;
        b=Oa1djkad4HEThDLsiCCqDQR0hwtn7GigLV90P9vxKW89Cjan5ryvBoikdim9zVjn21
         sNVSmFpXXWSB2rRPoriLp2bDW64qagiex6QlLMroWV73IWc9nUiI7+Jt/cCh0RWG+UVT
         +T8pUcwQT1AcjiG2VgYOjiL3msizI1aFMs7rRIXRn2TK6cd4utCHlPIbQFCBKerhXWcu
         OYX8SAFDkGoEaBpuq1Yp7QXM4Svi9hSJ2Yu/epj1oPOz9TN8xZqDMCzICB8cEwCzzX4L
         CaoOXLj8O4ZlWa898RcYCcm7Dm0yRWT2iWyjB2Uo7ZGFilSRT9u3qhY85u+ig/lgxdQa
         c+Rg==
X-Gm-Message-State: APuU4Z/Ah7eZYvXXbAS3T0acCIYzyDkzHctXBg5TzQNeRBC6y+jpQru3
	LJuFolFBjZrZ+mzPe8ovBbSCvHvcZtiBr7eNbynY9H3M9BTUfnWz4uZA3jQGGtjuxCAF+BoJ/Ra
	O9ZMVvEVVR23S2BHKhNvoMD1hgBVCtROyDMmrx0vkwzjlgfDGasNcd7xNhqidKjKPBwa91UrGCy
	XD0OoHVFnHa+WLva3mYpzV7t0oyhOdJf7Knk/bCiV3uem67gNAKBVgaFo=
X-Received: from dybgs18.prod.google.com ([2002:a05:7301:2092:b0:35f:390d:248a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e9d6:10b0:36a:1e0c:e28d
 with SMTP id 5a478bee46e88-36a42206318mr24426125eec.4.1793749584946; Tue, 03
 Nov 2026 15:46:24 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:45 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-30-irogers@google.com>
Subject: [PATCH v1 29/41] perf pmu: Probe supported sample_type flags
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/util/pmu.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h | 13 ++++++
 2 files changed, 108 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9033bada9f47..164ed926184e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3118,6 +3118,97 @@ static bool try_open_attr_variants(struct perf_event_attr *attr,
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
+	u64 reg_bit = BIT_ULL(perf_arch_reg_ip(EM_HOST)) ?: 1ULL;
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
+	b_attr.sample_regs_user = reg_bit;
+	b_attr.sample_regs_intr = reg_bit;
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
+			attr.sample_regs_user = reg_bit;
+			break;
+		case PERF_SAMPLE_REGS_INTR:
+			attr.sample_regs_intr = reg_bit;
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
@@ -3358,6 +3449,10 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.0.385.gac671c819a-goog

