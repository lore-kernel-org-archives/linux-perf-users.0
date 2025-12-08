Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF131AA9B
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203813; cv=none; b=bAh/hI9ZhLwqfxPPo0uQFgr1rQWqdP8qGcTSgIeWNdNbSqURW/u2HIXJNdVUNFyhMUP90yp2Z4GiRmLWC+W0ol7oIfYdmI/rYfuccqdgP9VdBe8qEa8Iqy5p1GFIBCms93o9t1po4FzWGYfVBlDPpQFbKGTgCsCR7d8n9Xji9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203813; c=relaxed/simple;
	bh=OgKG9PkDZvm8ejTmX9Po9XOIWBwQKKAXku7R7Bstl64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llGd3txD3Gin79m003VERrgKunFDUkzLbr4DkSHEQw3V81KHaoOVdxn2r6plvQRG2LNoKoqxe+AObb4fodjzKNryGEF1z/dyybQDSSJMcMv1Pw345tiU0YvmrwFXamoGg2e2fDwJZi3r3mnsolq0KhQIpzqSWvu8ex9XEOZanqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OOxB094A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOxB094A"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so32442915e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203809; x=1765808609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOIYYaELVWTJuyOlfjACt8LftXuc+RvaZVZxn3iQ/Mc=;
        b=OOxB094AMe3P0hJAwIj9og5KXFRZT4Ga8FZhef2jAy0yNbMCjkw/MklPcEOHoUMnMI
         SIaz+GCwge/VnFi51xYwlqtTu344uWr+jKJXiaO8EQngZOdKbKB4/DQd9EE5OFkTwdjv
         YRyKMeKvWHwA6Lsf6BUzy2UDc1JtN9UbhDyLCcaOErEsPNj7cMevuZvchGpNUAE0lEHa
         1uRntox2wX9re3bBwXdGdO9hiItMFqM816vn+v5j04PgHl/11vVIpMC2zLC/L9l7WQe1
         BtarqvJdIJ9j9Ghon8D8V6RbAocsMTlwyeEXJuNXPuGkxEFfgsJdxzKiKOJR0u8n+o39
         CoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203809; x=1765808609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOIYYaELVWTJuyOlfjACt8LftXuc+RvaZVZxn3iQ/Mc=;
        b=MyFq8LfVddOpmvRjqVR1ZcVFso8oA5Em/eo1pXLPYiDNjrNKxI4Hqyrs6Wz3VI+Q8k
         gmsWDvswfQM3psIJ55Zg1ncKBPbp615CaRgm1+z7O5v6d+Bh+lToBuRqP2o3apQmDtvs
         EFTNJqL+uIOGN8OOXXJRALUOkuGZw1/3YsB5+I+zEYlPYfn86tbk2kSPgtpQTmW7kWhu
         pLea6zHK5Tx03kRZWj2QUwVa7sy8I3xTYHMBYyKq/L21RZp5i2qX9Agga/FZ21ajDcD2
         WO0JUFXmGF37ecXCYMlU28WsNF3zk+BuNg9pKpHh8K/HtFe6GDRzWqCXARZwyaWnamP9
         CTqw==
X-Gm-Message-State: AOJu0YyI5hOMknXh86M/oIMEFyLrile7ju50Ughu22oFeUPtX/4pEOqr
	vlK7rpdYRU+fEdWQtXP/eAdrendgBIurj6rdz7ZrDgTcQvI+0TlZX2Fwq2/bGWg/8cA=
X-Gm-Gg: ASbGncvbXaMGbmYJnZlmq3hyxcpXW3ERS5LEmtI30Uh9LozPeqkoUCYhps8sufK32bH
	wFDJ/5h8leaesjdtSxGOhsVZDPkd1Cvd0Ub2izuhU16iZIvgS9nTR5br7TCo0Z5xu7U366jCCiQ
	w5ral6aae3c22GjDzYLGsHFYdKJYnYHHfb/JZtE0LSbLEo6eIvp43GSM1P/FMsZ79c4g3eXps8s
	WQ9ndZx6mtgQ18dWZJFbclZ1K51zkDYxiubYcGxmDn4dgIYTrp2fho4Y4NcHkCh9X9eUaQgCvBe
	L2oCf/trfOFiKga+EpHUGepVEYx06T0B0ttz2Zy/OCv4WUzcddlUL8YhWy1wAuiBpPisJ/Y7l5e
	k4yevAZOJH25bf7vNgDhcNi6BYDPhH1sTVNDkSRCvM2aVD1DCQQIUy2oAXpUj5bneLOsl+vR4Mm
	poMcpqFSh/s7fxgOpMZM0/
X-Google-Smtp-Source: AGHT+IEiiKIAKZltC2nX6+7tYL9Tdb7Gn5KWFk1rr5OgzmQFNmbmqB60aAPM6H1XwO1G4r9HgabKPQ==
X-Received: by 2002:a05:600c:a11b:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-4792eb5e5b9mr134591805e9.11.1765203809123;
        Mon, 08 Dec 2025 06:23:29 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:12 +0000
Subject: [PATCH v2 09/12] perf cs-etm: Don't use hard coded config bits
 when setting up ETMCR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-9-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Perf only looks at attr.config when determining what was programmed into
ETMCR. These bits could theoretically be in any of the config fields.
Add a generic helper to find the value of any named format field in any
config field and then use it to get the attributes relevant to ETMCR.

The kernel will also stop publishing the ETMCR register bits in a header
[1] so preempt that by defining them here.

Move field_prep() to util.h so we can define it along side field_get().
Unfortunately FIELD_PREP() and FIELD_GET() from the kernel can't be used
as they require the mask to be a compile time constant.

[1]: https://lore.kernel.org/linux-arm-kernel/20251128-james-cs-syncfreq-v8-10-4d319764cc58@linaro.org/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 22c6272e8c36..a5135b743e6f 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,6 +68,12 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+
+/* ETMv3 ETMCR register bits */
+#define ETMCR_CYC_ACC		BIT(12)
+#define ETMCR_TIMESTAMP_EN	BIT(28)
+#define ETMCR_RETURN_STACK	BIT(29)
+
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
@@ -487,6 +493,33 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	return err;
 }
 
+static u64 cs_etm_synth_etmcr(struct auxtrace_record *itr)
+{
+	struct cs_etm_recording *ptr =
+		container_of(itr, struct cs_etm_recording, itr);
+	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, cs_etm_pmu);
+	u64 etmcr = 0;
+	u64 val;
+
+	if (!evsel)
+		return 0;
+
+	/*
+	 * Synthesize what the kernel programmed into ETMCR based on
+	 * what options the event was opened with. This doesn't have to be
+	 * complete or 100% accurate, not all bits used by OpenCSD anyway.
+	 */
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "cycacc", &val) && val)
+		etmcr |= ETMCR_CYC_ACC;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val) && val)
+		etmcr |= ETMCR_TIMESTAMP_EN;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "retstack", &val) && val)
+		etmcr |= ETMCR_RETURN_STACK;
+
+	return etmcr;
+}
+
 static u64 cs_etm_get_config(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
@@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
 	case CS_ETMV3:
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
-		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
+		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_synth_etmcr(itr);
 		/* traceID set to legacy value in case new perf running on old system */
 		info->priv[*offset + CS_ETM_ETMTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 		/* Get read-only information from sysFS */

-- 
2.34.1

