Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D63A1CEA
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406280; cv=none; b=Cv4kTToYUZVjwRvGXi3feDHFWtMvpdZxZhULhT2/AqwnY4cCf/bvKu+RS+eDMhGJ8/5EUbc3HuLQ12o3UDM0X37k50G5zztzstXmBIf4DfmPsE6/H94qr9Mdg9kXJyZum6k+a3bngIhB8R8Imr1t/BYNvZOgJNCZSu/dwU1ewj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406280; c=relaxed/simple;
	bh=Yn4z8inxk4Yu0wDEan+xH+yZELLyctFmTteyMjKe+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oe/qoRrKAqMNXKMUA6m5LnQ2cN+HyeXxpg/6dofBG7LuQQynpTgPIvMIiVBasrKapxqQcsIbjeTpq1ZqEUWO3wilB9wU1nzkAP8/pEfBG2+f7W/vrq24v3Qg0RT0wdssBZOo3gFqU0i0pK3skK7Ils8A91u7NDttK20I7NlbIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBdzWLfS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBdzWLfS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47edffe5540so4175e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406273; x=1769011073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFlRacjoMKjxtVCuFA3rtMsDNUnCiwPHWXGI0rppnjk=;
        b=JBdzWLfSTaF0nf8yXUO5ZN2g6Ab7tJmF12wD1xNu1vQELH5921mvn+eXz24ndGxkNe
         4S4EdfYW89TN0WrOmd8hVATIn5dO/oBzapz3rKBwtZOsz3uW+2BaWRxT7TYcMNdzbnph
         CXMEEW9iXbp5W8PsATJ0Ikw2jZt4W4/b/CFLGuaihczlh8gnFVLGb7SBjbxko8FaGmH/
         7S4VyqeoCfFUzpTx4udLVLnyOaO6TZDlUiRXaKHpNvvTsFZyW2HZOp9EO9uxQKjzTpS8
         aFOBwHj0GDW85sHniBAOD5WYNNbDhrD6Tdbe0H1D2KXRnnYTUELZiOsXvFl+HTZc6Eh1
         2nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406273; x=1769011073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFlRacjoMKjxtVCuFA3rtMsDNUnCiwPHWXGI0rppnjk=;
        b=WfRitm+GExCTMXV1t5X9wQLY1RSISIVHDWnBdRG0T22Od6aif+ryhNRouqXgnDBqDi
         RjaK+zixfdIQZ5rPkPJhdsdmkUFtP9JQscF7I6WHWPCT46rnRfCn/DG/bSNS1O+D/c9e
         Sacx2QjOETtPH5VlAkPAjhkHZUKU8xVl/rD1TTMvLcfCSShhd8OZK4eOgo7ZnGxvl+K+
         Ak6KwQdTPLecRiD7FDoUNqFwHc5/DDp02nyzwCNlb2Nv1weOGSBAGFbcqYGcsGzCngqk
         CU3Vj8iJzlJxZsWNIceq5TQBKpf8ymvyhAJP+SveKBkaar8BMZXRYzTfmwRkEnRnqqrR
         QCUQ==
X-Gm-Message-State: AOJu0YzrX5dH+WwceBZQzgsG81nhzcUadSxGvKZAtTI75pNuvte+yY8e
	z/7kPDYnpAMSTnswoEiaekqhAZUDkjKqfxqGNL/dVaC/JkLv7SRGWBO40Vpwo72RUuQ=
X-Gm-Gg: AY/fxX5Dlimbiz0HZYWiLWq3Vs0jr4jNpYwdJeU2Y2JkvlJ8evZMt39fJ6ldURJ7n7m
	86188KkP21EBTPO9NiWiW80FFyTjFpqljvwcfzI6FMGekzmO91kDcydo8NJ1obMEFPjncxEn7HE
	Etn+1PGfKXCKpulJ73M+h40NRmvr7l+73p/JiQfvXTIQwlTPwioA59mMJbEXcFcgOO11yGl4rSn
	+n76WY0AjcSu6Jfz+gQrE8ywiSqakNNEiprmtwypeqOw3O8E8bZMIg38Uf6uKfPwXz+bYHdSkVE
	A7wmcAAI0ub4jKSCDUP5zmzRap/RKAFSeVGe9n8nCwdePiQ/Jux2e+0mMNWSKtluXAUO3zEP5oX
	zm23Dn3xK2LuHDIu8QuCr/r6GyLFYVsMIPIOkmR3bgcki4UjPpDLonmwdgrqI1j0keHkDs6Gq/t
	Ke9ZiDgQG7fjCtkVCQfjsw0253jvoW6LM=
X-Received: by 2002:a05:600c:3586:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47ee32e09c0mr40202995e9.5.1768406272596;
        Wed, 14 Jan 2026 07:57:52 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:52 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:24 +0000
Subject: [PATCH v5 12/14] perf cs-etm: Don't use hard coded config bits
 when setting up TRCCONFIGR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-12-0ef97aaf1ac0@linaro.org>
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Perf only looks at attr.config when determining what was programmed into
TRCCONFIGR. These bits could theoretically be in any of the config
fields. Use the evsel__get_config_val() helper so it's agnostic to
which config field they are in.

The kernel will also stop publishing the TRCCONFIGR register bits in a
header [1] so preempt that by defining them here.

[1]: https://lore.kernel.org/linux-arm-kernel/20251128-james-cs-syncfreq-v8-10-4d319764cc58@linaro.org/

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 79 +++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index f535027ce862..12b28562c2f3 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,6 +68,14 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+/* ETMv4 CONFIGR register bits */
+#define TRCCONFIGR_BB		BIT(3)
+#define TRCCONFIGR_CCI		BIT(4)
+#define TRCCONFIGR_CID		BIT(6)
+#define TRCCONFIGR_VMID		BIT(7)
+#define TRCCONFIGR_TS		BIT(11)
+#define TRCCONFIGR_RS		BIT(12)
+#define TRCCONFIGR_VMIDOPT	BIT(15)
 
 /* ETMv3 ETMCR register bits */
 #define ETMCR_CYC_ACC		BIT(12)
@@ -517,56 +525,37 @@ static u64 cs_etm_synth_etmcr(struct auxtrace_record *itr)
 	return etmcr;
 }
 
-static u64 cs_etm_get_config(struct auxtrace_record *itr)
+static u64 cs_etmv4_synth_trcconfigr(struct auxtrace_record *itr)
 {
+	u64 trcconfigr = 0;
 	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
+		container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
-	struct evlist *evlist = ptr->evlist;
-	struct evsel *evsel = cs_etm_get_evsel(evlist, cs_etm_pmu);
-
-	/*
-	 * Variable perf_event_attr::config is assigned to
-	 * ETMv3/PTM.  The bit fields have been made to match
-	 * the ETMv3.5 ETRMCR register specification.  See the
-	 * PMU_FORMAT_ATTR() declarations in
-	 * drivers/hwtracing/coresight/coresight-perf.c for
-	 * details.
-	 */
-	return evsel ? evsel->core.attr.config : 0;
-}
-
-#ifndef BIT
-#define BIT(N) (1UL << (N))
-#endif
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, cs_etm_pmu);
+	u64 val;
 
-static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
-{
-	u64 config = 0;
-	u64 config_opts = 0;
+	if (!evsel)
+		return 0;
 
 	/*
-	 * The perf event variable config bits represent both
-	 * the command line options and register programming
-	 * bits in ETMv3/PTM. For ETMv4 we must remap options
-	 * to real bits
+	 * Synthesize what the kernel programmed into TRCCONFIGR based on
+	 * what options the event was opened with. This doesn't have to be
+	 * complete or 100% accurate, not all bits used by OpenCSD anyway.
 	 */
-	config_opts = cs_etm_get_config(itr);
-	if (config_opts & BIT(ETM_OPT_CYCACC))
-		config |= BIT(ETM4_CFG_BIT_CYCACC);
-	if (config_opts & BIT(ETM_OPT_CTXTID))
-		config |= BIT(ETM4_CFG_BIT_CTXTID);
-	if (config_opts & BIT(ETM_OPT_TS))
-		config |= BIT(ETM4_CFG_BIT_TS);
-	if (config_opts & BIT(ETM_OPT_RETSTK))
-		config |= BIT(ETM4_CFG_BIT_RETSTK);
-	if (config_opts & BIT(ETM_OPT_CTXTID2))
-		config |= BIT(ETM4_CFG_BIT_VMID) |
-			  BIT(ETM4_CFG_BIT_VMID_OPT);
-	if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
-		config |= BIT(ETM4_CFG_BIT_BB);
-
-	return config;
+	if (!evsel__get_config_val(evsel, "cycacc", &val) && val)
+		trcconfigr |= TRCCONFIGR_CCI;
+	if (!evsel__get_config_val(evsel, "contextid1", &val) && val)
+		trcconfigr |= TRCCONFIGR_CID;
+	if (!evsel__get_config_val(evsel, "timestamp", &val) && val)
+		trcconfigr |= TRCCONFIGR_TS;
+	if (!evsel__get_config_val(evsel, "retstack", &val) && val)
+		trcconfigr |= TRCCONFIGR_RS;
+	if (!evsel__get_config_val(evsel, "contextid2", &val) && val)
+		trcconfigr |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
+	if (!evsel__get_config_val(evsel, "branch_broadcast", &val) && val)
+		trcconfigr |= TRCCONFIGR_BB;
+
+	return trcconfigr;
 }
 
 static size_t
@@ -688,7 +677,7 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 
 	/* Get trace configuration register */
-	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_synth_trcconfigr(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
 	data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 
@@ -720,7 +709,7 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, st
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 
 	/* Get trace configuration register */
-	data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	data[CS_ETE_TRCCONFIGR] = cs_etmv4_synth_trcconfigr(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
 	data[CS_ETE_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 

-- 
2.34.1

