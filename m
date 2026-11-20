Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213631;
	b=MDDcAmbQOis9iWITugJOGyitpBAvJp5EKurPOK1zeSgfSscLd5n/fEP2n9mygGy9EjYX
	 5ihL6hvoTaVkPTewClH7BDgaWBRYxxJfFyrSvB3CeIdAp1PdCUq6WPaqRtfREKP4t1uqd
	 B8iZadTUshi4EHZfi7SKRwkC6m+tEK5126oeYxTzq9a/a+pjMIYMDKm6gONWmBGEVdcBi
	 58xPz2droleNmr7R6i868UUn4KrF0gpOnYoieJEyOh9rrXimPHrY3o2nIZUIW951O/RGs
	 2j/CcUWAjfjybhYYVaFZAhL+OGSGq0DFavdGODjVvQoOwqLIdSuwg1c5SpYSrf8DEhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=REixFHG6yTrG5DXLKTEITtLEwFXA5pRnRS0W7V0xIcs=;
	b=X7QD9H2Niyd3OVib9fqCtFWnG5/raLysRIcOX26hnz9O9ZSuiS2GasvQdQ3YyY8taj4z
	 EZeSWnSsk5sHbQoKnYbFaSJIs9ac8kslHUNzo+cH+PqoAIWS5yMMNg5FoP9merSbJkRQS
	 CLxHXkPDTt7PixKOV3YXvyf6as4s/HP3FCJD0ohqqeIThavvCYpUtnk+WImmBBpG5zdeo
	 S0jd5yvMRMMt6nb1laTxs8MrpKoWldVn+2lsY0evRUMYoQH6MUlA1BC7WY6UKYQ5d78mF
	 Y+gFFj9dB6bRr1Ru1FeGNn3g52fg+0kXR01VNxHVSZnfvSe0spYb6ORK31ncdm9yS6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iIO8SO5b;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC27606A6AE
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FC27606A6AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iIO8SO5b
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1780183eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213629; x=1795818429; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REixFHG6yTrG5DXLKTEITtLEwFXA5pRnRS0W7V0xIcs=;
        b=iIO8SO5bsIsUAz35WhZL0wBCyLtcK+orEpQlMWqsy98KWF/qKGIOUxl1ZpcdIpRwzp
         d/l3jUC0P8VyjwPpaCfY7jz9cAu34wUiQSPKeYVZntaH22OqjWT/r4p5u6GMKb8ZDKj4
         zwaTZ6E0c+meQM0sfWlZ/kISxaSGt8aJHSBh6Baed2PiIyNYg1rcGThhTWHBoSYABAJW
         AXQOaNoSEQLWtOlxRMv5hsbcNZtZqA6HQm8jXr49b0YVTsCRqNmkiw7wCIav7c3axsTy
         BdLD04q3N9I8ehj+aFmRO8jQRv9axY5FKJnkOVZtFvi3Vv4JbSrTxYY9sNEFUo3cmqm+
         H87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213629; x=1795818429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REixFHG6yTrG5DXLKTEITtLEwFXA5pRnRS0W7V0xIcs=;
        b=dixb63d18lmheBknwVU6BcW+VE6FXkI6CynTAzmP/jw+vOtmtwXXSvrAPcR7l6YkrS
         n5aYXMJhZj/dTCD/wVv25UHU4v4j3GALHBylo9/OKubZY6BFbbucUHGOG2xmthmA5c5p
         g2sRka3/v/1ZowKGHg3wyyUV33lYS5w/8X2n3nFy8QAPvartm89SK8keRl0ltKFR+ay2
         vvctHHYd9Scz+bCaiJouuoWnSXnPKG/hmK+1bCGb7bBGz8MD1E8/AFN3GtGza4E++YFn
         E6+KMRcgmG8i25L3a7hiB4ymGCvnTJUsGq794ePUpm61OuiRWeJShqYWOQ2K8Y2nMrbQ
         kzHg==
X-Gm-Message-State: APuU4Z8QaJa9r801JDGFcJPMzcFDvT3h8f3wHQkocZMjmTY/D4374MJk
	C8B5uWEJNv2lNS1Vs4nqMLfpVhduQTqX4Hc1s8XGs/M++J4aBYBmNUrD3LzII8ZjSBUIN6hBNfW
	87eLU/beF5g==
X-Received: from dybmb7.prod.google.com ([2002:a05:7301:1907:b0:36a:16ac:9308])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8209:b0:36a:4a68:84e5
 with SMTP id 5a478bee46e88-3856f14bcfbmr4407453eec.8.1795213628344; Fri, 20
 Nov 2026 14:27:08 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:09 -0800
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
Message-ID: <20261120222615.2291168-11-irogers@google.com>
Subject: [PATCH v3 10/16] perf pmu: Probe interrupt registers that require
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
index 4fe98639b7af..3f6c1d8bdf6e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3407,18 +3407,50 @@ static void probe_sample_types(struct perf_pmu *pmu,
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
@@ -3489,14 +3521,11 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
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
@@ -3505,22 +3534,16 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
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
@@ -3531,7 +3554,7 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 		u64 class_mask = intr ?
 			perf_intr_simd_reg_class_mask(EM_HOST, pred) :
 			perf_user_simd_reg_class_mask(EM_HOST, pred);
-		u64 supported_classes = 0;
+		u64 supported_classes = 0, precise_classes = 0;
 
 		for (int reg_c = 0; reg_c < 64; reg_c++) {
 			struct perf_event_attr s_attr = *base_attr;
@@ -3567,22 +3590,22 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
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
@@ -3595,8 +3618,6 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 		x_attr.disabled = 1;
 		x_attr.sample_period = base_attr->sample_period ?: 10000;
 		x_attr.sample_type = sample_type;
-		if (intr && max_precise > 0)
-			x_attr.precise_ip = 1;
 
 		if (ext_mask) {
 			if (intr)
@@ -3604,10 +3625,11 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
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
@@ -3620,10 +3642,11 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
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
@@ -3631,6 +3654,12 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 
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
@@ -4037,7 +4066,10 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
@@ -4045,7 +4077,10 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.1.750.gf70dc682cf-goog

