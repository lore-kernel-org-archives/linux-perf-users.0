Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599789;
	b=jJuHmDrfTeU39V98EMYu1VKWnWlHMjoUJTnjuLMzDky6OtpIDH+TWtez725qUyFQlPOf
	 Yjg0uwQR9IUgrsSHW2DOebEWYl3Qit8NVP8tRf2hYZBINGxlYCs0GI1eYXAvCrsnKvdhe
	 TZmf1yrqRrma0wzNlsrPG2AMLvJmk2dVZMu3a9PZw9UzZlS5wqWzGxCrfBbMsyBDezatP
	 9Jd6SbJh0n4dpJnuw4RtXv7QLkS69POQaw/klrwTib8XyRlw7BPBx83kWbYJk1Hb5kWRu
	 LVm16MFmMRhI6PCnRN8Y+HaStpHCww9n4zjw+lCauKjZ2tbysj55pqmg/bWU/bfXQIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bX4pcxEKG2ohU+3GOdY4b0otEPuYT1yF5dLVL0983no=;
	b=4GNrogyf1UJbIAwOlaV2iOx6XlQ2YSRVn45nBN2UcGNIk/oA0nMDbZ0ojdk6iuFsvuIh
	 YWHmvInwKnj3FwhnveCKIeXiHVsezwtMDkeVgSItHPSZHcavKLzawF02nKn2a8I2gekpL
	 lxpOq37kkCJVGn8cnZ7HgL753pmEcRbroiFK9djWZsNC3WKA9GHPYbBQrSNrP3H9t2nyh
	 iPzmjRmmzetb2zo4OsS8lv337C0841mBH3wnppgCptBbhIWWqjsgmbx5If6P2ULv4Qra1
	 Z9ULqxNEJLbzNRYkOKvZru/ivM8nt+2ZE+KSQPa9xweWrRcvu/bR+LqZ2Mh+yszX0gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pIaAED33;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87660A6F6B
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B87660A6F6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pIaAED33
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f26e6abe9so1651018eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599787; x=1795204587; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bX4pcxEKG2ohU+3GOdY4b0otEPuYT1yF5dLVL0983no=;
        b=pIaAED33uD7RTwAp4fKFjxBgK8Aj74rkzOvj7SZQZyW1BlL7OcD64maSX26NBDGyAP
         H0s5/r8fU07Zn7uY94DIqCEpJSnDw2/zQqiNR4RxV822vfZqYNObwVW7P65HOBnVXmFn
         w1397hpva+jngqpYNYC8T4gw4ySE3KasG1yn10auvSNQVcWpBEZRMeZ2ycf65R4Ycm2u
         Q5sDSF0qUB4nz94OOY8/rDHh17UINgJHHWTc28LHgRsa5TyKSOdDJXQgEIP9qI4K7omb
         HXI9Uy2UUxuVQnzcieraI0gCbDdIra+vNa6rB/5zXnzDmL7YiBUgGNcmcdX0JFrvCpA0
         mmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599787; x=1795204587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bX4pcxEKG2ohU+3GOdY4b0otEPuYT1yF5dLVL0983no=;
        b=S9gZZScb0rYUci/eowRhLAlXegMGYu7zO8ctF9lR9Dwd+PybYJ01kXicDb96Lp74oA
         7nOLmZ1pv+Jt7BX3h9YoSZ79AhTph0yH+8cshoWXdexCu5ekEspsUkdpTSRPqluKDXtU
         S3+9X0lYbtZV13IAWGDOZn04mEBoXWqqDB0r5yH+jAhtSsr2KekbYPjybn5SvaLVDc9e
         RAOkp/a876cT0hTKRafmfnJ/2XU4BHR3W24q2AbRK79Bodm0dqwBZMU59tQgQEtEdz9O
         MA91NY1q34qv+SzvEeGHGzAd3x4WoLHrh/uy2TiXRqXk/+2sucAtLleyQHoN4xfyoUYe
         eGCQ==
X-Gm-Message-State: APuU4Z/7zGHqkh9ck+LXDuihu+OoFohFcqWqZw/cuXciorqhstzhDjdU
	cVVERrbHgyqQaHstkp3Z9BpuQyr46VagntZSqjjIkG8ES/K3Q2/owjX5UXPsyV1/4mbyvw+Gr36
	HYoqs3JxScw==
X-Received: from dyvp16.prod.google.com ([2002:a05:693c:8850:b0:36a:184b:374c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c88:b0:36d:7f5f:7e97
 with SMTP id 5a478bee46e88-37967dd734emr4600385eec.40.1794599786888; Fri, 13
 Nov 2026 11:56:26 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:54 -0800
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
Message-ID: <20261113195601.2872738-10-irogers@google.com>
Subject: [PATCH v2 09/16] perf pmu: Probe user and interrupt sample register masks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() with probe_pmu_regs_one() to probe supported
register sampling masks for PERF_SAMPLE_REGS_USER and
PERF_SAMPLE_REGS_INTR when supported by the PMU.

Test the architecture's base general-purpose register mask as a batch
before falling back to per-register probing if needed, and on hardware
PMUs also probe extended GPRs (such as x86 APX R16-R31 and CET SSP) and
SIMD vector/predicate register classes via PERF_SAMPLE_REGS_ABI_SIMD.
Without the SIMD ABI, probe registers like the x86 XMM registers. Add
perf_reg_probe_candidates() so the architecture provides the candidate
extended registers for each ABI and sampling direction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  10 +
 tools/perf/util/perf_regs.c                   |  16 ++
 tools/perf/util/perf_regs.h                   |   2 +
 tools/perf/util/pmu.c                         | 244 ++++++++++++++++++
 tools/perf/util/pmu.h                         |  28 ++
 5 files changed, 300 insertions(+)

diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 8cb9dfa6c7d3..6dd2439d5a4a 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -318,6 +318,16 @@ uint64_t __perf_reg_mask_x86(bool intr, int *abi)
 	return mask;
 }
 
+uint64_t __perf_reg_probe_candidates_x86(bool intr __maybe_unused, bool simd)
+{
+	/* With the SIMD ABI, the APX eGPRs and CET SSP. */
+	if (simd)
+		return GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16) | BIT_ULL(PERF_REG_X86_SSP);
+
+	/* Otherwise the XMM registers, supported via XSAVES or PEBS. */
+	return PERF_REG_EXTENDED_MASK;
+}
+
 static const char *__arch_reg_gpr_name(int id)
 {
 	switch (id) {
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index c8242b7e1db5..76be1f2f823f 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -275,6 +275,22 @@ uint64_t perf_user_simd_reg_class_mask(uint16_t e_machine, bool pred)
 	}
 }
 
+/*
+ * Registers, beyond the basic general purpose registers, that a PMU may
+ * support sampling and that should be probed for with perf_event_open(). The
+ * PERF_SAMPLE_REGS_ABI_SIMD ABI (@simd) may change the meaning of bits.
+ */
+uint64_t perf_reg_probe_candidates(uint16_t e_machine, bool intr, bool simd)
+{
+	switch (e_machine) {
+	case EM_386:
+	case EM_X86_64:
+		return __perf_reg_probe_candidates_x86(intr, simd);
+	default:
+		return 0;
+	}
+}
+
 uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
 						uint16_t *qwords, bool pred)
 {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index c9f461b6f11f..095dd603bca9 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -27,6 +27,7 @@ uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
 uint64_t perf_user_simd_reg_class_bitmap_qwords(uint16_t e_machine, int reg_c,
 						uint16_t *qwords, bool pred);
 const char *perf_simd_reg_class_name(uint16_t e_machine, int id, bool pred);
+uint64_t perf_reg_probe_candidates(uint16_t e_machine, bool intr, bool simd);
 
 int __perf_sdt_arg_parse_op_arm64(char *old_op, char **new_op);
 uint64_t __perf_reg_mask_arm64(bool intr);
@@ -81,6 +82,7 @@ uint64_t __perf_simd_reg_class_mask_x86(bool intr, bool pred);
 uint64_t __perf_simd_reg_class_bitmap_qwords_x86(int reg_c, uint16_t *qwords,
 						 bool intr, bool pred);
 const char *__perf_simd_reg_class_name_x86(int id, bool pred);
+uint64_t __perf_reg_probe_candidates_x86(bool intr, bool simd);
 
 static inline uint64_t DWARF_MINIMAL_REGS(uint16_t e_machine)
 {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index eb7a4736b30e..cf1bf1a871e9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3397,6 +3397,232 @@ static void probe_sample_types(struct perf_pmu *pmu,
 	pmu->probed.can_weight = !!(pmu->probed.sample_types & PERF_SAMPLE_WEIGHT);
 }
 
+/*
+ * Probe supported general-purpose, extended GPR, and SIMD vector/predicate
+ * register sampling masks for either PERF_SAMPLE_REGS_USER (!@intr) or
+ * PERF_SAMPLE_REGS_INTR (@intr).
+ */
+static void probe_pmu_regs_one(const struct perf_pmu *pmu,
+			       const struct perf_event_attr *base_attr,
+			       pid_t pid, int cpu, unsigned long flags,
+			       int max_precise, bool intr,
+			       u64 *out_mask, int *out_abi,
+			       u64 *out_simd_mask, u64 *out_pred_mask)
+{
+	int dummy_abi = -1;
+	u64 gpr_mask = intr ? perf_intr_reg_mask(EM_HOST, &dummy_abi) :
+			      perf_user_reg_mask(EM_HOST, &dummy_abi);
+	u64 sample_type = intr ? PERF_SAMPLE_REGS_INTR : PERF_SAMPLE_REGS_USER;
+	u64 mask = 0;
+	int abi = 0;
+	struct perf_event_attr attr = *base_attr;
+	int fd;
+
+	attr.disabled = 1;
+	attr.sample_period = base_attr->sample_period ?: 10000;
+	attr.sample_type = sample_type;
+
+	if (gpr_mask) {
+		if (intr)
+			attr.sample_regs_intr = gpr_mask;
+		else
+			attr.sample_regs_user = gpr_mask;
+
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			mask |= gpr_mask;
+		} else {
+			for (int b = 0; b < 64; b++) {
+				if (!(gpr_mask & BIT_ULL(b)))
+					continue;
+				if (intr)
+					attr.sample_regs_intr = BIT_ULL(b);
+				else
+					attr.sample_regs_user = BIT_ULL(b);
+				fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+				if (fd >= 0) {
+					close(fd);
+					mask |= BIT_ULL(b);
+				}
+			}
+		}
+	}
+
+	if (perf_pmu__is_software(pmu)) {
+		*out_mask = mask;
+		*out_abi = abi;
+		return;
+	}
+
+	/*
+	 * Probe extended GPRs outside the base GPR mask with the
+	 * PERF_SAMPLE_REGS_ABI_SIMD ABI (e.g. APX R16-R31 and CET SSP).
+	 * Note: perf_pmu__probe() actively probes the running host kernel via
+	 * perf_event_open(), so EM_HOST is used intentionally here.
+	 */
+	{
+		u64 ext_gpr_mask = perf_reg_probe_candidates(EM_HOST, intr, /*simd=*/true) &
+				   ~gpr_mask;
+
+		if (ext_gpr_mask) {
+			struct perf_event_attr e_attr = *base_attr;
+			bool ext_batch_ok = false;
+
+			e_attr.size = sizeof(e_attr);
+			e_attr.disabled = 1;
+			e_attr.sample_period = base_attr->sample_period ?: 10000;
+			e_attr.sample_type = sample_type;
+			e_attr.sample_simd_regs_enabled = 1;
+			if (intr)
+				e_attr.sample_regs_intr = ext_gpr_mask;
+			else
+				e_attr.sample_regs_user = ext_gpr_mask;
+
+			fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+			if (fd < 0 && intr && max_precise > 0) {
+				e_attr.precise_ip = 1;
+				fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+			}
+			if (fd >= 0) {
+				close(fd);
+				mask |= ext_gpr_mask;
+				abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+				ext_batch_ok = true;
+			}
+
+			if (!ext_batch_ok) {
+				for (int b = 0; b < 64; b++) {
+					if (!(ext_gpr_mask & BIT_ULL(b)))
+						continue;
+					e_attr.precise_ip = base_attr->precise_ip;
+					if (intr)
+						e_attr.sample_regs_intr = BIT_ULL(b);
+					else
+						e_attr.sample_regs_user = BIT_ULL(b);
+					fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+					if (fd < 0 && intr && max_precise > 0) {
+						e_attr.precise_ip = 1;
+						fd = sys_perf_event_open(&e_attr, pid, cpu, -1,
+									 flags);
+					}
+					if (fd >= 0) {
+						close(fd);
+						mask |= BIT_ULL(b);
+						abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+					}
+				}
+			}
+		}
+	}
+
+	for (int is_pred = 0; is_pred <= 1; is_pred++) {
+		bool pred = is_pred != 0;
+		u64 class_mask = intr ?
+			perf_intr_simd_reg_class_mask(EM_HOST, pred) :
+			perf_user_simd_reg_class_mask(EM_HOST, pred);
+		u64 supported_classes = 0;
+
+		for (int reg_c = 0; reg_c < 64; reg_c++) {
+			struct perf_event_attr s_attr = *base_attr;
+			u16 qwords = 0;
+			u64 bitmap;
+
+			if (!(class_mask & BIT_ULL(reg_c)))
+				continue;
+			bitmap = intr ?
+				perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred) :
+				perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred);
+			if (!bitmap || !qwords)
+				continue;
+
+			s_attr.size = sizeof(s_attr);
+			s_attr.disabled = 1;
+			s_attr.sample_period = base_attr->sample_period ?: 10000;
+			s_attr.sample_type = sample_type;
+			s_attr.sample_simd_regs_enabled = 1;
+			if (pred) {
+				s_attr.sample_simd_pred_reg_qwords = qwords;
+				if (intr)
+					s_attr.sample_simd_pred_reg_intr = bitmap;
+				else
+					s_attr.sample_simd_pred_reg_user = bitmap;
+			} else {
+				s_attr.sample_simd_vec_reg_qwords = qwords;
+				if (intr)
+					s_attr.sample_simd_vec_reg_intr = bitmap;
+				else
+					s_attr.sample_simd_vec_reg_user = bitmap;
+			}
+
+			fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
+			if (fd < 0 && intr && max_precise > 0) {
+				s_attr.precise_ip = 1;
+				fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
+			}
+			if (fd >= 0) {
+				close(fd);
+				supported_classes |= BIT_ULL(reg_c);
+				abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+			}
+		}
+
+		if (pred)
+			*out_pred_mask = supported_classes;
+		else
+			*out_simd_mask = supported_classes;
+	}
+
+	if (!(abi & PERF_SAMPLE_REGS_ABI_SIMD)) {
+		/* Registers like x86 XMM without the SIMD ABI. */
+		u64 ext_mask = perf_reg_probe_candidates(EM_HOST, intr, /*simd=*/false) &
+			       ~gpr_mask;
+		struct perf_event_attr x_attr = *base_attr;
+		bool batch_ok = false;
+
+		x_attr.disabled = 1;
+		x_attr.sample_period = base_attr->sample_period ?: 10000;
+		x_attr.sample_type = sample_type;
+		if (intr && max_precise > 0)
+			x_attr.precise_ip = 1;
+
+		if (ext_mask) {
+			if (intr)
+				x_attr.sample_regs_intr = ext_mask;
+			else
+				x_attr.sample_regs_user = ext_mask;
+
+			fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
+			if (fd >= 0) {
+				close(fd);
+				mask |= ext_mask;
+				batch_ok = true;
+			}
+		}
+
+		if (!batch_ok) {
+			for (int b = 0; b < 64; b++) {
+				if (!(ext_mask & BIT_ULL(b)))
+					continue;
+				if (intr)
+					x_attr.sample_regs_intr = BIT_ULL(b);
+				else
+					x_attr.sample_regs_user = BIT_ULL(b);
+				fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
+				if (fd >= 0) {
+					close(fd);
+					mask |= BIT_ULL(b);
+				}
+			}
+		}
+	}
+
+	*out_mask = mask;
+	*out_abi = abi;
+}
+
 /*
  * Pack @value into the perf_event_attr config field named by the sysfs format
  * @name of @pmu, e.g. "rdpmc" defined as "config1:1". Returns false if the
@@ -3794,6 +4020,24 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 		}
 	}
 
+	/* 3b. User and interrupt register sampling masks */
+	if (pmu->probed.sample_types & PERF_SAMPLE_REGS_USER) {
+		probe_pmu_regs_one(pmu, &base_attr, pid, cpu, flags,
+				   pmu->probed.max_precise, /*intr=*/false,
+				   &pmu->probed.user_regs_mask,
+				   &pmu->probed.user_regs_abi,
+				   &pmu->probed.user_simd_mask,
+				   &pmu->probed.user_pred_mask);
+	}
+	if (pmu->probed.sample_types & PERF_SAMPLE_REGS_INTR) {
+		probe_pmu_regs_one(pmu, &base_attr, pid, cpu, flags,
+				   pmu->probed.max_precise, /*intr=*/true,
+				   &pmu->probed.intr_regs_mask,
+				   &pmu->probed.intr_regs_abi,
+				   &pmu->probed.intr_simd_mask,
+				   &pmu->probed.intr_pred_mask);
+	}
+
 	/* 4. Privilege / exclusion modifiers */
 	pmu->probed.exclude_user =
 		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_USER);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index cacb8bc5198b..66ee3841872a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -300,11 +300,39 @@ struct perf_pmu {
 		 * in a group counted simultaneously, without multiplexing.
 		 */
 		int max_gp_group_size;
+		/** @probed.user_regs_abi: ABI flags for user_regs_mask. */
+		int user_regs_abi;
+		/** @probed.intr_regs_abi: ABI flags for intr_regs_mask. */
+		int intr_regs_abi;
 		/**
 		 * @probed.sample_types: Bitmask of supported
 		 * enum perf_event_sample_format flags.
 		 */
 		u64 sample_types;
+		/** @probed.user_regs_mask: Bitmask of supported sample_regs_user registers. */
+		u64 user_regs_mask;
+		/** @probed.intr_regs_mask: Bitmask of supported sample_regs_intr registers. */
+		u64 intr_regs_mask;
+		/**
+		 * @probed.user_simd_mask: Bitmask of supported user SIMD vector
+		 * register classes.
+		 */
+		u64 user_simd_mask;
+		/**
+		 * @probed.user_pred_mask: Bitmask of supported user SIMD predicate
+		 * register classes.
+		 */
+		u64 user_pred_mask;
+		/**
+		 * @probed.intr_simd_mask: Bitmask of supported intr SIMD vector
+		 * register classes.
+		 */
+		u64 intr_simd_mask;
+		/**
+		 * @probed.intr_pred_mask: Bitmask of supported intr SIMD predicate
+		 * register classes.
+		 */
+		u64 intr_pred_mask;
 	} probed;
 };
 
-- 
2.56.1.703.gf848ed807c-goog

