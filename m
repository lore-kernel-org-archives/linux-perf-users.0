Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599791;
	b=Yzp5E9V2/FPw1Hs8T4Igm3YRNlC7CskLPKuTCliSByo52UolHHXtETvNbvW0D3zv3FO3
	 PDobj4/9UGeo8zT9Us/4SvGk4aCz5m8At89M6KpgA+PMTO/b5lfaT2Ff4aXojoNp5/FHI
	 F5DlX/c94xRyYLOMEOyo6CAPQU5dmBRWj6BUKObzvL5DOV75K/M4d75na3n8mjqpj05zz
	 A94acq/QP841w6uh3k6p7S8AAYNZrEjist7njMSEgPiK6H2LG7dablzfU3y6DgopVb9RC
	 CdurG2LSjikb4H/RqoChn+RqUZCL4HEPaG1NxnqPfkSy5T3SQPQNioEaNHKuT0Xy2WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=WHeTHmrB7DIAjgCmjri0/g1fCWtn3STru0M2k09ou28=;
	b=4DvNTIbOV8YJlB8/iLDAlTitF9pNDFVaA7gZ+oEPQWQjtarRsdnIwzMaefCidmea9d0m
	 7OQWb1Zo5ct6K/wtsXWuLLWFIu8M8jYMgkeU9l8Sn5tH2zvixF+V29qga6E4/O32uBx8d
	 BlNm4Vlj+xgKQg6VCIT+Hvn3JVxE4OxmAVd+pgT83j88PTXLrnvzTlgdFxXVtVfsPgoqQ
	 tDN5Usxn1/igPMbgPWQ2/NaSOrFB1j9ZZIHYmMEzqmgJWR0+JPx3GOyNiwkLRPVdT8P30
	 DP1Rd3aCxKmHpNSjWFYzKPHWVh7hTCn1iWmKUPtuH+xdO0mtV6DEXtiWTIaGmanZ1zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S8AljhnB;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE979606B567
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE979606B567
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S8AljhnB
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-370230d93efso5997293eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599790; x=1795204590; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHeTHmrB7DIAjgCmjri0/g1fCWtn3STru0M2k09ou28=;
        b=S8AljhnBq6lcwvaQxv38KdnoesZRBGfElFpoTb2chQq+550OLvqcspXpQqpGmdBHYm
         R8WCjqt8MCjAloFeeXx+Fure9TLqx+CPyw5XiaKfHOBEH/JVEivDOy4wdmphis+kL2L/
         GLDoxGn/S9q1Nzg2D8qOx/KqMb3YiN73UxP/Gd4zJUkSVT1GHUHhPjt7pPYhHxeCjSP5
         glTle7XMhj1St/doih9M31n1SXJhMdMGtm6rKJuB5H9uCsTTsb666FI7VxMKEHfGVMwK
         S1PgMgWpUG9N6SjP/mwBM/9YQB0DjlPu5k1camt2NIFdIIArxwN6WBAd9I0xRMr+MVk5
         GC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599790; x=1795204590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WHeTHmrB7DIAjgCmjri0/g1fCWtn3STru0M2k09ou28=;
        b=prleFR71FuimSEaW2lgytvLqTuaosuD9ts9/Mdq+SOb5hJNaklXn7EkI6SP2xiJ8Eo
         DuRNSjmbRVcaHZo4lP2p4QQCGjtiYoJRG6pFi/e6gw6VI5qnX/Xdd2aqHET4G9iqgDAc
         7rgcgHkOAl00mfXLf/EKmdBGzneQEj63MbhV0+3TqT2OZqH++5I+Om9W2DaV+wP4RkEw
         7KoVWxifQsRoYtJt5GNDlyKbQQ4SUDbPVwWXx0aKYgguMcqKpcI8/nx8/p5YELeIxXwm
         /JpvayueQhtiSQNKkgb1t2C/fTjYmysOuuHrEli8+7w9XlfHssvhgJPzpVFSmXrK2zST
         oKIA==
X-Gm-Message-State: APuU4Z9MN5FvLjbpHLsR0voVK5XZ/AuEqSMQW7VN4z2I3sSXjpxoqASN
	GN3QFEFxus5e5C4ALcqOO2kWUafOCLNhYhInwTKOUsSgGOMxLr3y6gupTl5WdZVOdciHemGuLV0
	7IExX+O292Q==
X-Received: from dyp6.prod.google.com ([2002:a05:693c:65c6:b0:370:f640:2508])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:60ce:b0:36e:8410:ecf6
 with SMTP id 5a478bee46e88-37966387d74mr3427093eec.13.1794599789512; Fri, 13
 Nov 2026 11:56:29 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:55 -0800
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
Message-ID: <20261113195601.2872738-11-irogers@google.com>
Subject: [PATCH v2 10/16] perf pmu: Probe interrupt registers that require
 precise sampling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some interrupt registers can only be sampled with precise sampling, for
example on x86 the XMM registers are captured in PEBS records and
x86_pmu_hw_config() rejects them in sample_regs_intr without precise_ip.
The interrupt register probe tried precise sampling as a fallback, or
for the legacy extended registers unconditionally, so the probed mask
didn't show which registers require it.

Add probe_regs_open() that opens without precise sampling first and
records when only the precise open succeeds, and record the interrupt
registers and SIMD register classes that require precise sampling in
intr_regs_precise_mask, intr_simd_precise_mask and
intr_pred_precise_mask.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 117 +++++++++++++++++++++++++++---------------
 tools/perf/util/pmu.h |  16 ++++++
 2 files changed, 92 insertions(+), 41 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cf1bf1a871e9..80159358318e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3397,18 +3397,50 @@ static void probe_sample_types(struct perf_pmu *pmu,
 	pmu->probed.can_weight = !!(pmu->probed.sample_types & PERF_SAMPLE_WEIGHT);
 }
 
+/*
+ * Open @attr, if that fails and @try_precise then retry with precise sampling,
+ * setting @needs_precise when only the precise open succeeds. Returns whether
+ * either open succeeded.
+ */
+static bool probe_regs_open(struct perf_event_attr *attr, pid_t pid, int cpu,
+			    unsigned long flags, bool try_precise, bool *needs_precise)
+{
+	u8 precise_ip = attr->precise_ip;
+	int fd = sys_perf_event_open(attr, pid, cpu, -1, flags);
+
+	*needs_precise = false;
+	if (fd < 0 && try_precise && !precise_ip) {
+		attr->precise_ip = 1;
+		fd = sys_perf_event_open(attr, pid, cpu, -1, flags);
+		attr->precise_ip = precise_ip;
+		*needs_precise = fd >= 0;
+	}
+	if (fd < 0)
+		return false;
+	close(fd);
+	return true;
+}
+
 /*
  * Probe supported general-purpose, extended GPR, and SIMD vector/predicate
  * register sampling masks for either PERF_SAMPLE_REGS_USER (!@intr) or
- * PERF_SAMPLE_REGS_INTR (@intr).
+ * PERF_SAMPLE_REGS_INTR (@intr). For interrupt registers, the registers and
+ * register classes that can only be sampled with precise sampling are
+ * recorded in @out_precise_mask, @out_simd_precise_mask and
+ * @out_pred_precise_mask, which may be NULL for user registers.
  */
 static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 			       const struct perf_event_attr *base_attr,
 			       pid_t pid, int cpu, unsigned long flags,
 			       int max_precise, bool intr,
 			       u64 *out_mask, int *out_abi,
-			       u64 *out_simd_mask, u64 *out_pred_mask)
+			       u64 *out_simd_mask, u64 *out_pred_mask,
+			       u64 *out_precise_mask, u64 *out_simd_precise_mask,
+			       u64 *out_pred_precise_mask)
 {
+	bool try_precise = intr && max_precise > 0;
+	u64 precise_mask = 0, simd_precise_mask = 0, pred_precise_mask = 0;
+	bool needs_precise;
 	int dummy_abi = -1;
 	u64 gpr_mask = intr ? perf_intr_reg_mask(EM_HOST, &dummy_abi) :
 			      perf_user_reg_mask(EM_HOST, &dummy_abi);
@@ -3479,14 +3511,11 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 			else
 				e_attr.sample_regs_user = ext_gpr_mask;
 
-			fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
-			if (fd < 0 && intr && max_precise > 0) {
-				e_attr.precise_ip = 1;
-				fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
-			}
-			if (fd >= 0) {
-				close(fd);
+			if (probe_regs_open(&e_attr, pid, cpu, flags, try_precise,
+					    &needs_precise)) {
 				mask |= ext_gpr_mask;
+				if (needs_precise)
+					precise_mask |= ext_gpr_mask;
 				abi |= PERF_SAMPLE_REGS_ABI_SIMD;
 				ext_batch_ok = true;
 			}
@@ -3495,22 +3524,16 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 				for (int b = 0; b < 64; b++) {
 					if (!(ext_gpr_mask & BIT_ULL(b)))
 						continue;
-					e_attr.precise_ip = base_attr->precise_ip;
 					if (intr)
 						e_attr.sample_regs_intr = BIT_ULL(b);
 					else
 						e_attr.sample_regs_user = BIT_ULL(b);
-					fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
-					if (fd < 0 && intr && max_precise > 0) {
-						e_attr.precise_ip = 1;
-						fd = sys_perf_event_open(&e_attr, pid, cpu, -1,
-									 flags);
-					}
-					if (fd >= 0) {
-						close(fd);
-						mask |= BIT_ULL(b);
-						abi |= PERF_SAMPLE_REGS_ABI_SIMD;
-					}
+					if (!probe_regs_open(&e_attr, pid, cpu, flags,
+							     try_precise, &needs_precise))
+						continue;
+					mask |= BIT_ULL(b);
+					precise_mask |= needs_precise ? BIT_ULL(b) : 0;
+					abi |= PERF_SAMPLE_REGS_ABI_SIMD;
 				}
 			}
 		}
@@ -3521,7 +3544,7 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 		u64 class_mask = intr ?
 			perf_intr_simd_reg_class_mask(EM_HOST, pred) :
 			perf_user_simd_reg_class_mask(EM_HOST, pred);
-		u64 supported_classes = 0;
+		u64 supported_classes = 0, precise_classes = 0;
 
 		for (int reg_c = 0; reg_c < 64; reg_c++) {
 			struct perf_event_attr s_attr = *base_attr;
@@ -3557,22 +3580,22 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 					s_attr.sample_simd_vec_reg_user = bitmap;
 			}
 
-			fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
-			if (fd < 0 && intr && max_precise > 0) {
-				s_attr.precise_ip = 1;
-				fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
-			}
-			if (fd >= 0) {
-				close(fd);
+			if (probe_regs_open(&s_attr, pid, cpu, flags, try_precise,
+					    &needs_precise)) {
 				supported_classes |= BIT_ULL(reg_c);
+				if (needs_precise)
+					precise_classes |= BIT_ULL(reg_c);
 				abi |= PERF_SAMPLE_REGS_ABI_SIMD;
 			}
 		}
 
-		if (pred)
+		if (pred) {
 			*out_pred_mask = supported_classes;
-		else
+			pred_precise_mask = precise_classes;
+		} else {
 			*out_simd_mask = supported_classes;
+			simd_precise_mask = precise_classes;
+		}
 	}
 
 	if (!(abi & PERF_SAMPLE_REGS_ABI_SIMD)) {
@@ -3585,8 +3608,6 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 		x_attr.disabled = 1;
 		x_attr.sample_period = base_attr->sample_period ?: 10000;
 		x_attr.sample_type = sample_type;
-		if (intr && max_precise > 0)
-			x_attr.precise_ip = 1;
 
 		if (ext_mask) {
 			if (intr)
@@ -3594,10 +3615,11 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 			else
 				x_attr.sample_regs_user = ext_mask;
 
-			fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
-			if (fd >= 0) {
-				close(fd);
+			if (probe_regs_open(&x_attr, pid, cpu, flags, try_precise,
+					    &needs_precise)) {
 				mask |= ext_mask;
+				if (needs_precise)
+					precise_mask |= ext_mask;
 				batch_ok = true;
 			}
 		}
@@ -3610,10 +3632,11 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 					x_attr.sample_regs_intr = BIT_ULL(b);
 				else
 					x_attr.sample_regs_user = BIT_ULL(b);
-				fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
-				if (fd >= 0) {
-					close(fd);
+				if (probe_regs_open(&x_attr, pid, cpu, flags, try_precise,
+						    &needs_precise)) {
 					mask |= BIT_ULL(b);
+					if (needs_precise)
+						precise_mask |= BIT_ULL(b);
 				}
 			}
 		}
@@ -3621,6 +3644,12 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 
 	*out_mask = mask;
 	*out_abi = abi;
+	if (out_precise_mask)
+		*out_precise_mask = precise_mask;
+	if (out_simd_precise_mask)
+		*out_simd_precise_mask = simd_precise_mask;
+	if (out_pred_precise_mask)
+		*out_pred_precise_mask = pred_precise_mask;
 }
 
 /*
@@ -4027,7 +4056,10 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 				   &pmu->probed.user_regs_mask,
 				   &pmu->probed.user_regs_abi,
 				   &pmu->probed.user_simd_mask,
-				   &pmu->probed.user_pred_mask);
+				   &pmu->probed.user_pred_mask,
+				   /*out_precise_mask=*/NULL,
+				   /*out_simd_precise_mask=*/NULL,
+				   /*out_pred_precise_mask=*/NULL);
 	}
 	if (pmu->probed.sample_types & PERF_SAMPLE_REGS_INTR) {
 		probe_pmu_regs_one(pmu, &base_attr, pid, cpu, flags,
@@ -4035,7 +4067,10 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 				   &pmu->probed.intr_regs_mask,
 				   &pmu->probed.intr_regs_abi,
 				   &pmu->probed.intr_simd_mask,
-				   &pmu->probed.intr_pred_mask);
+				   &pmu->probed.intr_pred_mask,
+				   &pmu->probed.intr_regs_precise_mask,
+				   &pmu->probed.intr_simd_precise_mask,
+				   &pmu->probed.intr_pred_precise_mask);
 	}
 
 	/* 4. Privilege / exclusion modifiers */
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 66ee3841872a..21c4b1a4b608 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -333,6 +333,22 @@ struct perf_pmu {
 		 * register classes.
 		 */
 		u64 intr_pred_mask;
+		/**
+		 * @probed.intr_regs_precise_mask: Subset of intr_regs_mask that
+		 * can only be sampled with precise sampling, such as x86 XMM
+		 * registers that are captured by PEBS.
+		 */
+		u64 intr_regs_precise_mask;
+		/**
+		 * @probed.intr_simd_precise_mask: Subset of intr_simd_mask that
+		 * can only be sampled with precise sampling.
+		 */
+		u64 intr_simd_precise_mask;
+		/**
+		 * @probed.intr_pred_precise_mask: Subset of intr_pred_mask that
+		 * can only be sampled with precise sampling.
+		 */
+		u64 intr_pred_precise_mask;
 	} probed;
 };
 
-- 
2.56.1.703.gf848ed807c-goog

