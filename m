Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7032C948
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416504; cv=none; b=KA+YGKHVACZB4X+niYG2ipPS0IaYhKSJAmFtVUI3YpSrhvGdv2M+k48gdjt2R+zYKXGvH9O1M2aeKGTHd7OvioBURpZZoS0PZLtGyw3fI7Cynqd77q+HnWNLE57M3pXKCZyjxRVDWl1Xp45rS4s3WxIH5GUMeOBM+m8iysOKQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416504; c=relaxed/simple;
	bh=Yn4z8inxk4Yu0wDEan+xH+yZELLyctFmTteyMjKe+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr4Mwb5Z/pXLcH4o6kw7nhqIm08HTmUF3M1ihaXtsePQlh3lEac3ixPsPm8eiNsaJmSIEWSXrMmjV60S3c7GSYx5Xf8XncVtQPz2MZom1SkdP3sbioF9A6TB2UYhfUHi2hhnfeEO9zuDPg0E30YDt9bzmZUScVAtU9FgCn3ovJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U1XH6R5u; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1XH6R5u"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so1900145f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416500; x=1767021300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFlRacjoMKjxtVCuFA3rtMsDNUnCiwPHWXGI0rppnjk=;
        b=U1XH6R5unBVryP29uMZdzGAZkaX6s1QTYaWdlChAlOmiM1gpkt1dEVI7RpCgBz76Cb
         jmELjgV5lLOpD7+9ncAtpUUF3JdAaNa2ZGQbQX/wOhnlankOMN49uW02zNTomV2IB8lf
         Rid0mENNRrHZz1wmIGmuYGwdrhw05+YnfOznHn191vCToggrfAsg/6+qGr2ybcwtuzZ/
         NXumSbLROrqmMphaVQXEFGXnJYy5ZSJex4RsGMXJ5jEWshCp7YEg2h7nC4HvgSCCU/Z2
         C/JnWZYRsNM1/gkh5MKLCAP6oKHbgGO1SP4kUtHzjCzX6djDsgGWMCMdHAjpt+7e7IWm
         yAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416500; x=1767021300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFlRacjoMKjxtVCuFA3rtMsDNUnCiwPHWXGI0rppnjk=;
        b=g3SAobxo/hEwvb2IggHkurCyblHNj25HYFgMqXbMoiwzVKZQCdiwfXY3TBnk9BS1N5
         PeOt0YRvGa4oYGBTZVHnzyaVkOECNh3H9bPTaUqgfloBexbQO3GW74Coj9a7mnuJEBbw
         Z5r3JF5zYlqJtFusBrAaUnAs2MzUciaMHLeS/nNfygZEGUIs0rGTVndFDxjSAX873HoP
         tkHn0yuFRA1gQ4IcBEmJlfxTOuTwIEj37p8EOFzwTxwNfdF89h/EfgaO1ATsRXTD2J3F
         wlmFEw+FxtCxWBvRI8Rd2cQbjEamZ9ARYzilvxvufif9yaCG+F2M6K9mJqWXo4c4gWOK
         jrBQ==
X-Gm-Message-State: AOJu0YzyDULxM+1PL3OEHDvpr/gNC7Qy6e8J+C1FSRZerewRgClYxnhJ
	fROsX7eIECIfZALfSUuypzRCzHEq/1s/eUQZNU7bl8Ycx0HHhAcVTtFGZqNMwwUqdUI=
X-Gm-Gg: AY/fxX4HFHHxxSY5q/7jo4u7jqhE6eT9rJj5D/f8d89NNC5IbGw78mFqNfM/ypvJ6IA
	wTw170C6iI8zSTrLfmcyR6GYZvl0IC9RjFDnko9ywPBUE08EF/Pga1tyLkpxZb38BQH9OgZmwPs
	AvjuV4h9FxCSswyM+KENrTpw9tv2BjQbMAGyTEO9CZpPYN9ZYr+v+Fn3XnswQpVdMBuauQNWH0D
	6soiZKX8C1BcVmepbgbM3NXJ21RrZuESgbnsNYFyZcToWFPdOaYLCTvivCIrFkIVlJrJIQXbGoG
	RlJKbWfN3+EgcucOup6dflRz0km3mYhkBsvtPSRJUA1RBJ8fFtxzJ7OtfKr8X9YJDby61ZkSksm
	pEr1OsvSfTEY334S7zZHNOuiXc+ggsTU1WKlOHTDGhXiNRwZxZW3X5LH/nRXkH2If4XcjLPRVQ3
	oax09E+1tsl52ZVi0rTuHW
X-Google-Smtp-Source: AGHT+IEPUJNPy274HZi+qkvi/OeAVZd7MGQfUITqEL+CFL0dU4WibIBI9+G5uNVA8U0GZWyYh6O1PQ==
X-Received: by 2002:a05:6000:2881:b0:430:96bd:411b with SMTP id ffacd0b85a97d-4324e70111dmr11870001f8f.58.1766416499926;
        Mon, 22 Dec 2025 07:14:59 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:59 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:37 +0000
Subject: [PATCH v4 12/14] perf cs-etm: Don't use hard coded config bits
 when setting up TRCCONFIGR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-12-0608438186fc@linaro.org>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
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

