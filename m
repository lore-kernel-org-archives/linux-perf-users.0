Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EC35B63A
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806132; cv=none; b=qFFsZU43c+xKpForZrJ8wX8anQxeC6JwggorozFs/BVYE87JR+YY1UQsK6DsEPIERUBc+uhcu9kVWRmLi2Uw3bYLPdDgv76G/cjweC0t0IWDL7OWEZnTYET8gc3k29ELaN8bI4Ki7l4ilKWNVFTWDs+ADZ9V187ATR74xfBOuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806132; c=relaxed/simple;
	bh=zl55HFZnBS29a+7Lxq4Y4Fp1AbgahaDuXMHEYyrIiew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0EPbhGHGavAIrNbkREDxgTLZsrNQb1ry/XwMTmQUZrdT7km2xx0NKFRsf+mZa+z+BNFP8C35pX1d7uyiLJE+HNu41+yllJ5AxjF73Hta/R+Hv6ZNZJ80YGOC9+Av1FrvgUhCLRKbGZaGfPYeVmVJfa/iMwVoCdLh6CwF9Vul6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfMm1wYP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfMm1wYP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so108473155e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 06:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772806130; x=1773410930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdnYy4pqHOHDMEp3XhdGrBeoVKwJbjAtI69wSRa1lMc=;
        b=LfMm1wYP8S7fdtYr7wK/+Ez77oFuBC6duzAY/udnK17YmB4sHlswptWRGkOC9a9XEN
         ktOvOn0PDQeVrNYAcYyFJFpgFBY11WPSRGqgCCJ5WXRv0ok8oxvECTwVmIDRrGL2qO+C
         AFXY6fXoOGVoMx/xKcmkEp9y6pR/4boxr12tYhEHOqDaYSJboBhyMhZkL3nqlSSJyvPT
         RyWHQy6wAyKcsiENULYEBnBLY6mMP1NNL26GyNEw+Mov2+2+oup1bsCFLKiwEUMPY3IY
         VMjxYmKzBTXVwgXpOu0Z8/9NZ4L8kEB/WDYEXn5S+0dpGXh7k4GAtimQ3oo04Iv2bVuh
         yM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772806130; x=1773410930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdnYy4pqHOHDMEp3XhdGrBeoVKwJbjAtI69wSRa1lMc=;
        b=R38I6EURBl2j7J49ZR54W/zNp55wTJjk3QPdJ+uUEEosQktuqfL8DC8TY4inDAzvAr
         KMW9M3TWhrydF7u/enmd+e4o9dTuGQNrKUvbE7Y6lkcv6wgcPV0+YcXD/Sk8uzulfluS
         ygV5SzMJKCbcZJs5i0s6cYd+QjIB6asmm8L6BdN0jlXtlp6kri6OK4I1y5F+PU/LVoK7
         U0hP40oOQRGMwzZS6oBBJVfYI0QRq0GY7DZUNmjPnjujUltxN2JAMx7YHXrS6RyYyj13
         0awc9G2QNDzfDK0H8uTlhcqMhXPBQx21WnVWS49GkLl7wYSUMVEa8kFhbI8EPlyT3qZc
         aL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWElfBvNeIKRqJPiX3t5DBX95tlo29BGOchJ42Sqy3okGc3KYY9Ig4xpjDZ/cO4TsVrV7EkKm7gxUyKlsAf2Ls3@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKSVy/sggatJRGICTtsxMZ3Z0FewGw5ZK/FWDToZYV7TcPoSX
	hi5AI0Xt/fyY464hZ2rAZ3DuKunWq3ku+lgNHh6SfDgZ0k1ncE4Kf3/nTwcgEprLeo4=
X-Gm-Gg: ATEYQzw8/d943GaBYJfwQ6OA8uEZhbNPVbbCo4R2jYaBLptQkC6KBvp0+6HSJrRLjt1
	yxnMW9xG4tU7ENbsTo2k15soSjc8FmLh9gFcF84x9Yo1QIdwdkfrfeJEYppG4RFp3UYBekOwPlY
	tDqJ/R7SyKR9srlEXk/p/3mQWHWnIZn7mVUmjVpN+/CYQTWyZ6GF1tDPxmESIl1O3IQzCC26o//
	2NWBEQYxPW+r47OmA+V8QYRfpRDL8EIk9JCqoFRh8/LCgGetyi/YCicidedTM2d/WqRmDRint+D
	mOk10rB2iGivG/1K1f2Qaer9ZJZPMW7p9DlPTujxgmYXf/FQFmniiGjlAMeJLgLAYEa3a3fRbLW
	hFHYI/rOYe6STMurqfKhGASDHbieNRuFqw/orXTrr2wFBatzER8nWDpaF3uhuvD4U3nsk48VA1N
	8WFnAWQJvpyLFx/Q/Mp3iy4T8E6TuY/ZEU
X-Received: by 2002:a05:600c:4710:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-48526978dc0mr34177745e9.31.1772806129556;
        Fri, 06 Mar 2026 06:08:49 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2bdf8sm4212967f8f.25.2026.03.06.06.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:08:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 06 Mar 2026 14:08:34 +0000
Subject: [PATCH v2 1/2] perf cs-etm: Finish removal of ETM_OPT_*
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-james-perf-remove-etm_opt-v2-1-b411d3ae24b3@linaro.org>
References: <20260306-james-perf-remove-etm_opt-v2-0-b411d3ae24b3@linaro.org>
In-Reply-To: <20260306-james-perf-remove-etm_opt-v2-0-b411d3ae24b3@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0

These #defines have been removed from the kernel headers in favour of
the string based PMU format attributes. Usages were previously removed
from the recording side of cs-etm in Perf. Finish the removal by
removing usages from the decode side too.

It's a straight replacement of the old #defines with the new register
bit definitions. Except cs_etm__setup_timeless_decoding() which wasn't
looking at the saved metadata and was instead hard coding an access to
'attr.config'. This was vulnerable to the same issue of .config being
moved to .config2 etc that the original removal of ETM_OPT_* tried to
fix. So fix that too.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c               | 14 ----------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +-
 tools/perf/util/cs-etm.c                        | 36 +++++++++----------------
 tools/perf/util/cs-etm.h                        | 15 +++++++++++
 4 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index dc3f4e86b075..4418d21708d6 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,20 +68,6 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
-/* ETMv4 CONFIGR register bits */
-#define TRCCONFIGR_BB		BIT(3)
-#define TRCCONFIGR_CCI		BIT(4)
-#define TRCCONFIGR_CID		BIT(6)
-#define TRCCONFIGR_VMID		BIT(7)
-#define TRCCONFIGR_TS		BIT(11)
-#define TRCCONFIGR_RS		BIT(12)
-#define TRCCONFIGR_VMIDOPT	BIT(15)
-
-/* ETMv3 ETMCR register bits */
-#define ETMCR_CYC_ACC		BIT(12)
-#define ETMCR_TIMESTAMP_EN	BIT(28)
-#define ETMCR_RETURN_STACK	BIT(29)
-
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3050fe212666..212f17a3dc72 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -549,7 +549,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 	/*
 	 * Process the PE_CONTEXT packets if we have a valid contextID or VMID.
 	 * If the kernel is running at EL2, the PID is traced in CONTEXTIDR_EL2
-	 * as VMID, Bit ETM_OPT_CTXTID2 is set in this case.
+	 * as VMID, Format attribute 'contextid2' is set in this case.
 	 */
 	switch (cs_etm__get_pid_fmt(etmq)) {
 	case CS_ETM_PIDFMT_CTXTID:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 95f439c96180..8a639d2e51a4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -194,7 +194,7 @@ int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu)
  *   CS_ETM_PIDFMT_CTXTID2: CONTEXTIDR_EL2 is traced.
  *   CS_ETM_PIDFMT_NONE: No context IDs
  *
- * It's possible that the two bits ETM_OPT_CTXTID and ETM_OPT_CTXTID2
+ * It's possible that the two format attributes 'contextid1' and 'contextid2'
  * are enabled at the same time when the session runs on an EL2 kernel.
  * This means the CONTEXTIDR_EL1 and CONTEXTIDR_EL2 both will be
  * recorded in the trace data, the tool will selectively use
@@ -210,15 +210,15 @@ static enum cs_etm_pid_fmt cs_etm__init_pid_fmt(u64 *metadata)
 	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 		val = metadata[CS_ETM_ETMCR];
 		/* CONTEXTIDR is traced */
-		if (val & BIT(ETM_OPT_CTXTID))
+		if (val & ETMCR_CTXTID)
 			return CS_ETM_PIDFMT_CTXTID;
 	} else {
 		val = metadata[CS_ETMV4_TRCCONFIGR];
 		/* CONTEXTIDR_EL2 is traced */
-		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
+		if (val & (TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT))
 			return CS_ETM_PIDFMT_CTXTID2;
 		/* CONTEXTIDR_EL1 is traced */
-		else if (val & BIT(ETM4_CFG_BIT_CTXTID))
+		else if (val & TRCCONFIGR_CID)
 			return CS_ETM_PIDFMT_CTXTID;
 	}
 
@@ -2914,29 +2914,21 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
+static void cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
 {
-	struct evsel *evsel;
-	struct evlist *evlist = etm->session->evlist;
+	/* Take first ETM as all options will be the same for all ETMs */
+	u64 *metadata = etm->metadata[0];
 
 	/* Override timeless mode with user input from --itrace=Z */
 	if (etm->synth_opts.timeless_decoding) {
 		etm->timeless_decoding = true;
-		return 0;
+		return;
 	}
 
-	/*
-	 * Find the cs_etm evsel and look at what its timestamp setting was
-	 */
-	evlist__for_each_entry(evlist, evsel)
-		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
-			etm->timeless_decoding =
-				!(evsel->core.attr.config & BIT(ETM_OPT_TS));
-			return 0;
-		}
-
-	pr_err("CS ETM: Couldn't find ETM evsel\n");
-	return -EINVAL;
+	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic)
+		etm->timeless_decoding = !(metadata[CS_ETM_ETMCR] & ETMCR_TIMESTAMP_EN);
+	else
+		etm->timeless_decoding = !(metadata[CS_ETMV4_TRCCONFIGR] & TRCCONFIGR_TS);
 }
 
 /*
@@ -3499,9 +3491,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
-	err = cs_etm__setup_timeless_decoding(etm);
-	if (err)
-		return err;
+	cs_etm__setup_timeless_decoding(etm);
 
 	etm->tc.time_shift = tc->time_shift;
 	etm->tc.time_mult = tc->time_mult;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index a8caeea720aa..aa9bb4a32eca 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -230,6 +230,21 @@ struct cs_etm_packet_queue {
 /* CoreSight trace ID is currently the bottom 7 bits of the value */
 #define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
 
+/* ETMv4 CONFIGR register bits */
+#define TRCCONFIGR_BB		BIT(3)
+#define TRCCONFIGR_CCI		BIT(4)
+#define TRCCONFIGR_CID		BIT(6)
+#define TRCCONFIGR_VMID		BIT(7)
+#define TRCCONFIGR_TS		BIT(11)
+#define TRCCONFIGR_RS		BIT(12)
+#define TRCCONFIGR_VMIDOPT	BIT(15)
+
+/* ETMv3 ETMCR register bits */
+#define ETMCR_CYC_ACC		BIT(12)
+#define ETMCR_CTXTID		BIT(14)
+#define ETMCR_TIMESTAMP_EN	BIT(28)
+#define ETMCR_RETURN_STACK	BIT(29)
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 void cs_etm_get_default_config(const struct perf_pmu *pmu, struct perf_event_attr *attr);

-- 
2.34.1

