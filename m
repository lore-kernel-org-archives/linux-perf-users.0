Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2F16C865
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643186; cv=none; b=W70gGPTeCr+4eCCVlV18fuGZV95Tw0ifhu3kas7LMFDVN1wIVNgnwujl2dJa528f3lXoe923vXVUmIg5mDZwZUUHCOvqVg90ECueu2rZBlmtlV0z1frajJfeuYo1o4j0JwhAWYr7P78ZGdeKCFf5PHOKFPf7DtWXS2nKFM4LWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643186; c=relaxed/simple;
	bh=HZ25YlbVFoFr5t4xgKqcTOie+si0xupMEcbp2D/SGlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpEcnGkF0xF6aEGyHDhGoA0O+l6m+bo5t0SA5skTIZWU5PLLMKm+Q93XGE66gunK64drV/ehcMW48VWM0r7VQimG8r8afOLFAZg/F3CRax71etCjYoY3mwL82i1iiPY6V5FNct7ScH2ce5XDvcQ7w/Gc9ELEC3cPJ8GaiX/4WSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X63YxQjr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X63YxQjr"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so12975381fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643183; x=1722247983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22WWYz2tUVGtuasGpu3eN+nV++HsU5p2cQus0dyDbEs=;
        b=X63YxQjrWeJVaglm3si75C5ZH6zjeHxKrq/dnCGPKmvuu/x30cWZpXbLnFnoFcEMm5
         8grVh7Xc1GCgXAqDKiU0fkRayj+n4VWzhnYhdJ1AUDibdrJbBD5a6HyJnp2YC8PLYgFW
         ebjTMbg+pHAmSnl3o+c9YDA7KkwCDhiO2DZKgQI/tFyeBelqHj0Q2p33dboJbPt19nSS
         mdt2r3bGfkv2ERUNgGe8xrpBNxzuwNUzjoXGBcn/7CxVUiJfN7eDCYiLqoz5oJkcICaF
         RsBtDiMBq7/6+bGgyxkp2FnVIiQlpHYH1z4Nd4UbdQl5M1rSA3gw1wkLGOpNz47F/J7l
         h3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643183; x=1722247983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22WWYz2tUVGtuasGpu3eN+nV++HsU5p2cQus0dyDbEs=;
        b=lnlTmxIAyaNmb6rl78xW36QovwdjB1+jiE3mu9jsf4HtNhR4ks/0Xl0NHKbOdZNMKI
         K6P8YCEgLFIUSwHLt/CBdh+od0nFoZZFt8KWXyoOt16Qp7TFKbvyeeuIzLOPNeKTKsIU
         J7/cLkTzAThY20DsR7zTNKlpFE+4X9R5m88TPGBnneWLGhDG9AEa2N3jv+mEiRRibVZR
         opvlr/z6jpSV2fMAbA+fDGZOD5RyhUrxwWDHa+klu9G4VIj0S3Ct4mrm2tEL+avSzkMX
         RVatdJ7mmOuaue+wPgjL+iB/O9l2AXQYVXAFx5CIbEgai5ducsPOLLj/LUaT2vbHT9ki
         Zm0g==
X-Forwarded-Encrypted: i=1; AJvYcCUx5F/rLZ+LmNjiy1zk8M69xUjRF3nlyHq3HbDIzhjbW1haV6TgTjnTEqPfJh2ZxKybJ5CPMhEC75T7BmozP8QMvZvERX9ItIMvwp+sI8FZpg==
X-Gm-Message-State: AOJu0YwWKCgNvU1j164afOKGrWizZriD5k2M2Nk8ub9dDLMjHVtDJkCD
	ewboL0gv0ejjrwpNXEP0x/1xgciIqfVh4JymAP1K6Kn8VyyzkJgmugXLSRZjtfY=
X-Google-Smtp-Source: AGHT+IGUJY+LiEZGDA07U+K/qkfthMc8al4V942XRBG+OJuyhgexjuNQfTeA3mz1e0/Ia/+b/eMfWw==
X-Received: by 2002:a2e:8059:0:b0:2ef:24e0:6338 with SMTP id 38308e7fff4ca-2ef24e06429mr37487261fa.27.1721643183124;
        Mon, 22 Jul 2024 03:13:03 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:02 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 07/17] perf: cs-etm: Print queue number in raw trace dump
Date: Mon, 22 Jul 2024 11:11:49 +0100
Message-Id: <20240722101202.26915-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

Now that we have overlapping trace IDs it's also useful to know what the
queue number is to be able to distinguish the source of the trace so
print it inline. Hide it behind the -v option because it might not be
obvious to users what the queue number is.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
 tools/perf/util/cs-etm.c                        | 13 ++++++++++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index d49c3e9c7c21..b78ef0262135 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -41,7 +41,7 @@ const u32 INSTR_PER_NS = 10;
 
 struct cs_etm_decoder {
 	void *data;
-	void (*packet_printer)(const char *msg);
+	void (*packet_printer)(const char *msg, void *data);
 	bool suppress_printing;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
@@ -202,7 +202,7 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
 	const struct cs_etm_decoder *decoder = p_context;
 
 	if (p_context && str_len && !decoder->suppress_printing)
-		decoder->packet_printer(msg);
+		decoder->packet_printer(msg, decoder->data);
 }
 
 static int
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 272c2efe78ee..12c782fa6db2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -60,7 +60,7 @@ struct cs_etm_trace_params {
 
 struct cs_etm_decoder_params {
 	int operation;
-	void (*packet_printer)(const char *msg);
+	void (*packet_printer)(const char *msg, void *data);
 	cs_etm_mem_cb_type mem_acc_cb;
 	bool formatted;
 	bool fsyncs;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b11b0cae608e..6298a5c7a651 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -762,15 +762,22 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 	}
 }
 
-static void cs_etm__packet_dump(const char *pkt_string)
+static void cs_etm__packet_dump(const char *pkt_string, void *data)
 {
 	const char *color = PERF_COLOR_BLUE;
 	int len = strlen(pkt_string);
+	struct cs_etm_queue *etmq = data;
+	char queue_nr[64];
+
+	if (verbose)
+		snprintf(queue_nr, sizeof(queue_nr), "Qnr:%d; ", etmq->queue_nr);
+	else
+		queue_nr[0] = '\0';
 
 	if (len && (pkt_string[len-1] == '\n'))
-		color_fprintf(stdout, color, "	%s", pkt_string);
+		color_fprintf(stdout, color, "	%s%s", queue_nr, pkt_string);
 	else
-		color_fprintf(stdout, color, "	%s\n", pkt_string);
+		color_fprintf(stdout, color, "	%s%s\n", queue_nr, pkt_string);
 
 	fflush(stdout);
 }
-- 
2.34.1

