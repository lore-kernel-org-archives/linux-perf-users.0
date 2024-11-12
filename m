Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE1212F1D
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427298; cv=none; b=sEbVzftKZBqlL0lwm2bykvmIAwjHx6nxIBxZNw4qyzt9hp5nFps2Z2Qy/WSg7Ozg3SSeNN+1v7fD/r22VjIF7edVmR16uEYoOQUV8laTXE7T8OpQDUYVPDTn7+cmnSMskgxKfe1VtCX0PXiILEecHqONFDH7/XPQJuXW3py9MHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427298; c=relaxed/simple;
	bh=E1GO+wXsMoWY5kN68+eZphs4BdgOqmXVnV4f83AYM5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftGGhnrbeX5WHD/yewFHdgHmMey9DCokK+ovAdsssdcBZbJ2XqbDE8krH9srXDhVg1Wtjv0AaOkXnlGrUvq4lIxCObrhsDPHkNzWVC8BgzRN3TBBjDyjkWY6hF468lturDE0amyE52CramitqH0hhcR3e6yeSq4XBXVEeS8ycH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7I7C9T7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7I7C9T7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb599aac99so55433091fa.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427294; x=1732032094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1wxrEwtrIa/6tacdYcY+vjRhcRt6Rg8gQj+1ymAPK8=;
        b=V7I7C9T7l8uAfgfrw/Jpzivwl6SINQPxC+NgLuScQHz36ztp80mDLqOgi6jbLxa6wv
         0KCCgxpuAm4QOFyDT4XRA/5IwNShlvGa3Mvy5zYx+Vqu4mm6fAaC5nwvso4wwcGspaGq
         ebBhBOy0wtxxhw89OZz/bLX7t3mvzKm4YmBxLqJvp1Pj1jRe4zO95x3L9of9t/iIuvRU
         O/BYz6NcnuDhkwGP2Q4/QzIVegQxvNh9nK/blQPTTSfhhDcmDV7rJoRDzCHIDncmq/sa
         SZWShz9QhsUBt/pICrNYu3GAkNGPhKDe01DZliuYWRPb2hW/AqqnWbhYxG+SXksYe4oM
         v4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427294; x=1732032094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1wxrEwtrIa/6tacdYcY+vjRhcRt6Rg8gQj+1ymAPK8=;
        b=KH9G/3Yi4qa/fe3mcvmFtf48Po/aoq4TTjQ8fSjOXwod86RIGY73MC+FxVoGa9egTy
         A5YO807TSilLwVTKYKrRUh9iUBMQEoUGD9BmT02EGqzvs5BHkT+rVu63VPMgfluMwLM2
         GY/jUXE2vk0aCw6a6xF+NsJ6vBKggmkKEj2+bdpEF6BpzRC8fMoXsNOv9lY8Vc5UefPF
         PRavQJEZHw9+rm8GN6KwhdKsXD4dx9/QmO5ChPNsG/qcTy2gasAZ2O0+oSC+wgh4JR6C
         sMnmTVlxyZYG0dVR67nW4BsO1QYhpnDQ3DqAKig+4KEkBSVDnke3eOwxTfKxOxdtIwYy
         NGKQ==
X-Gm-Message-State: AOJu0Yx1mqIYrwhQjnOHYSiYCiZi2VEVf4QLZAIa295Ji8QSzGY4BuxL
	FYYFPnBygsLfPmVBx7QQAXjJ8XcG9lAls1VRV6415xAp1AESe+PpATqBRiMZMivRM5vKQ+jkL/6
	+aws=
X-Google-Smtp-Source: AGHT+IGx3RVHA4+byL2YTLnZZ+/5E8G3YY8XlVAXe4mp3PgtfDZjahR2xR/tDM+pFFm2RtkJYAlNcQ==
X-Received: by 2002:a2e:a99c:0:b0:2fa:d534:3ee7 with SMTP id 38308e7fff4ca-2ff2027d94emr81313131fa.35.1731427293638;
        Tue, 12 Nov 2024 08:01:33 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] perf stat: Document and clarify outstate members
Date: Tue, 12 Nov 2024 16:00:45 +0000
Message-Id: <20241112160048.951213-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112160048.951213-1-james.clark@linaro.org>
References: <20241112160048.951213-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all of these are "state" so separate them into two sections. Rename
and document to make all clearer.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8377e24602dd..ba79f73e1cf5 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -115,15 +115,29 @@ static void print_running_csv(struct perf_stat_config *config, u64 run, u64 ena)
 		config->csv_sep, run, config->csv_sep, enabled_percent);
 }
 struct outstate {
-	FILE *fh;
+	/* Std mode: insert a newline before the next metric */
 	bool newline;
+	/* JSON mode: track need for comma for a previous field or not */
 	bool first;
+	/* Num CSV separators remaining to pad out when not all fields are printed */
+	int  csv_col_pad;
+
+	/*
+	 * The following don't track state across fields, but are here as a shortcut to
+	 * pass data to the print functions. The alternative would be to update the
+	 * function signatures of the entire print stack to pass them through.
+	 */
+	/* Place to output to */
+	FILE * const fh;
 	/* Lines are timestamped in --interval-print mode */
 	char timestamp[64];
-	int  nfields;
-	int  aggr_nr;
+	/* Num items aggregated in current line. See struct perf_stat_aggr.nr */
+	int aggr_nr;
+	/* Core/socket/die etc ID for the current line */
 	struct aggr_cpu_id id;
+	/* Event for current line */
 	struct evsel *evsel;
+	/* Cgroup for current line */
 	struct cgroup *cgrp;
 };
 
@@ -473,7 +487,7 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 	int i;
 
 	__new_line_std_csv(config, os);
-	for (i = 0; i < os->nfields; i++)
+	for (i = 0; i < os->csv_col_pad; i++)
 		fputs(config->csv_sep, os->fh);
 }
 
@@ -550,12 +564,12 @@ static void print_metricgroup_header_csv(struct perf_stat_config *config,
 
 	if (!metricgroup_name) {
 		/* Leave space for running and enabling */
-		for (i = 0; i < os->nfields - 2; i++)
+		for (i = 0; i < os->csv_col_pad - 2; i++)
 			fputs(config->csv_sep, os->fh);
 		return;
 	}
 
-	for (i = 0; i < os->nfields; i++)
+	for (i = 0; i < os->csv_col_pad; i++)
 		fputs(config->csv_sep, os->fh);
 	fprintf(config->output, "%s", metricgroup_name);
 	new_line_csv(config, ctx);
@@ -837,7 +851,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
 		nl = config->metric_only ? NULL : new_line_csv;
 		pmh = print_metricgroup_header_csv;
-		os->nfields = 4 + (counter->cgrp ? 1 : 0);
+		os->csv_col_pad = 4 + (counter->cgrp ? 1 : 0);
 	} else if (config->json_output) {
 		pm = config->metric_only ? print_metric_only_json : print_metric_json;
 		nl = config->metric_only ? NULL : new_line_json;
-- 
2.34.1

