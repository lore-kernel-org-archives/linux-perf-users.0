Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749599;
	b=yDvQpOH9tYXLmji0gmt/208r+DSB/s/lUXUmo2IyaOn/ZBc4GS/8PTWjbtMXS0MrHOFa
	 DU9WWOthHkaQe3geKQoosGJtT66K18j7UuRYbYnkMh8CQGc+k4GtWSUUzZeMMLhhct616
	 x2IQnJE6yEczztURYJdg25FgbMpw44O4IfUfdDyURr39kD83qeQR2s3rzd2aZ1wcpkdl6
	 0QO8jSCyFXEStn99JPVVF8Rig8ySSsBI6d7n3ZVhQe+NAVTaikSgVArUHM524W7YrxPco
	 SDx8GBm9MO+0cO4gvGC6QJG4aSGRmYynJAtamgFcCNhoJpfxlzR0IggskzVEzMQeClQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=GEWu8PuLG2Ft+HArhhXScagBJNxG2RL6FgTVaDjHZhk=;
	b=q56fgS8ihCkmDe9VtEzUK0uU6oun4Iw8Nc4SGEYS3M4PvYKHnyiyBSCfhYCIH99K+4CV
	 3Zi6bjQ2We2EZRUFzt9gj0uly+dD+qhlxdfWH+oWV1JH4kH1LTxUjkHBE1iP8iWsPQquI
	 i+olBC+VAejesqdgc0pdUbkLmxQk3ztrWNU5UaxWNHsc2upvTASJwTKw3cqX/o+KXwv7I
	 ihxHhY1k/JEcxM578RNSD9VgSz29eFUgF7ZifLvWCi5S9MI9XypVbpVudx8W+Zkz2sM8A
	 3iImdlVR5RsjgRKlugZaV1Y55TN53SMX843x+9e5vN8Fw5ugGH3XVgz+CB+Z3pjgBEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jGsVrHO5;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8F6083639
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52F8F6083639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jGsVrHO5
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0589ff620so136052b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749599; x=1794354399; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEWu8PuLG2Ft+HArhhXScagBJNxG2RL6FgTVaDjHZhk=;
        b=jGsVrHO5mutMjbg0ex0Peck4cKCqIp0BDU//tC0s/6MxmPiKoMM++muYqnuh3EkpGk
         3yWRyCkEPBkHBdUwdolSYNKLU9P4R5ziJBwxJN/UvqvQHrmaMbNqho9bh7ohuu3WjpRE
         swtdhmY5WXZMAuddfJfLLctsg07PBZRI0kL7by1NSUgnE36F5xynX5xfREz8nP5xYh6+
         nHmECDH5gl405sM+dRYwSvJrHZ4HY8bVKdEykctyTPp4t0N0qHCUxQmiBW1ygmR9enFz
         frURwBcvxtUmruWuQKQKo06P9MyhmQfYuPrWoszzfcMuThb1Nz3c4ZAbPjzT4QYUalHS
         b2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749599; x=1794354399;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GEWu8PuLG2Ft+HArhhXScagBJNxG2RL6FgTVaDjHZhk=;
        b=wRUf2Af6LS5NrwojX3zEI434tQKLG4ZNxUDORUrvbi24/RWaY5nhNBHCrZ/f71FCcI
         zsLtq1MWCYmmsKPBLz9MYK0j49FXU9Cd5HlS3ch6RO0eH9p/EnTE5R2Au+/4qpfzQK1Z
         1KYyCjUsOLkkb7CdFW5z7i0k2Q+YrwrVOmizenbVhusRkpUs9sM25Ww31ImC52D+bXce
         6im6jSGFEs1mlZYq+YTUILiQrrGU3r0Su/3dQiz487xzt+YhvioRDmvHU3lsFzSzAjf9
         tHg0qnyh8bRChvwksq/UJlHyI8xO4hcLgCfB6rmd8RKVdmjn1tZcSs5RwI53/+vL6XIj
         3OiA==
X-Gm-Message-State: APuU4Z82lzwaD57JkBsuPDqxQJbUhSf7ueIkWBm9GE3HD8/y04Bw9xY9
	d8GdD6xtjJikd52gFl09Qv5pHOdbMM+bagOERxg+6pfFVsrkbM65vanQuiWHHTRYDuzP9jAmonn
	E+9a4Nv9xdoLy6aaItHF2kJfuyc0DgenkXfbK3PZJNXpqPKaAqAcmbedDqCXvC+uB0Zo6C3hKVd
	Ax9GRXwwDWFNw1iE2yUKbJNqQXuXln8tIgJdExnt1kNId0EMFBV0/oupI=
X-Received: from pfeu3-n1.prod.google.com ([2002:a05:6a00:c0c3:10b0:89e:65fd:e92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4189:b0:8a0:3ed7:93a9
 with SMTP id d2e1a72fcca58-8a9bffd2b12mr11644180b3a.46.1793749598214; Tue, 03
 Nov 2026 15:46:38 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:50 -0800
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
Message-ID: <20261103234502.1008382-35-irogers@google.com>
Subject: [PATCH v1 34/41] perf pmu: Probe user and interrupt sample register masks
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

Extend perf_pmu__probe() with probe_pmu_regs_one() to probe supported
register sampling masks for PERF_SAMPLE_REGS_USER and
PERF_SAMPLE_REGS_INTR when supported by the PMU.

Test the architecture's base general-purpose register mask as a batch
before falling back to per-register probing if needed, and on hardware
PMUs also probe extended GPRs (such as x86 APX R16-R31 and CET SSP) and
SIMD vector/predicate register classes via PERF_SAMPLE_REGS_ABI_SIMD.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 249 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  28 +++++
 2 files changed, 277 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3585147c5242..9179231aa7d5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3386,6 +3386,237 @@ static void probe_sample_types(struct perf_pmu *pmu,
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
+	 * Probe extended GPRs outside the base GPR mask when the host ABI
+	 * supports PERF_SAMPLE_REGS_ABI_SIMD (e.g. APX R16-R31 and CET SSP).
+	 * Note: perf_pmu__probe() actively probes the running host kernel via
+	 * perf_event_open(), so EM_HOST is used intentionally here.
+	 */
+	{
+		int host_abi = 0;
+		u64 host_mask = intr ? perf_intr_reg_mask(EM_HOST, &host_abi) :
+				       perf_user_reg_mask(EM_HOST, &host_abi);
+		u64 ext_gpr_mask = host_mask & ~gpr_mask;
+
+		if ((host_abi & PERF_SAMPLE_REGS_ABI_SIMD) && ext_gpr_mask) {
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
+		u64 ext_mask = GENMASK_ULL(63, 32) & ~gpr_mask;
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
+				const char *rname;
+
+				if (gpr_mask & BIT_ULL(b))
+					continue;
+				rname = perf_reg_name(b, EM_HOST, EF_HOST, 0);
+				if (!rname || !strcmp(rname, "unknown"))
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
@@ -3762,6 +3993,24 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.0.385.gac671c819a-goog

