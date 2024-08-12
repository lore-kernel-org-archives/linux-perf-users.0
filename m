Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6919CCF0
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495690; cv=none; b=Y4VbFO/1fcxoq0tNZ3s/4+mNIYLWs0CJoGAp4XHv4Fe5peGYaLxsXHHetO5mWC1UnKr75Dp+pIgQ7gSwLE1/GuKq8WksiJhSBT56XHgi4hhxjSanTEthQkj3zqAqPav1SgGvmxchzxE1l3U8pBXvW/hl7anjndxKWBs3oW0gTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495690; c=relaxed/simple;
	bh=uMeETZnKr9ceLX3mZKKN/OlGgP2NNBbj5KRHpf1r41o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EKrvgTDMcCVXHNz1jqUk/V4Fl5gze9VI/oxYBE++4wNpZ+MTlj7eOfjtwNQGz/Ukd/RLFfQyMHE2bvMGCk6T/R/mj3o/LblU0GOLECG9/oT9miT4ONeTGA0tDoAmmwClFUXtaR/MXedji+IoltRQxNV3gecLx9q/on+AIKozMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbmqWTt5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbmqWTt5"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0e4cd64909so8234041276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495688; x=1724100488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0Iqy/44loZSDwT/r8c2v4LhcCsuhaAB0dsDAg6CBI4=;
        b=VbmqWTt5zTGiat2HfBahE5++U7gJ2sCMfji52TxClUwn9g3dKDc4bnw2lWNWXEE0Pn
         /zMcnxcHmxhnhD3N2abo2LPBYlmMqgT41MnnAbJtIdgyyc/cmRjhMwIaLSsgoLlXEgSF
         UJitS9oTNvlSzh1t6lbiyfrXwAqmi2PAI+nr4Co66QvyMRphoJ6NfxY8W9QeEO4I3lPV
         ibfhdp+TjGZ7vj7yDNOxF7S2tUUEPLB9lZx9tOMytvaEyl2s7l3zqO8w0nkNqi2Vf9k+
         s6SAWtvRzIuU4rMsBoEV1o5Z1oj9cbnNu8pw0LMdrC5covuWZL4sG8yd/oVGKGei/1EA
         Cblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495688; x=1724100488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0Iqy/44loZSDwT/r8c2v4LhcCsuhaAB0dsDAg6CBI4=;
        b=aB5+Cm+2/hRM6KmMxbQDJKzproY0bMHoNTwGRe9hvlKFA035V/5JxfN7cQEbGnwDQF
         /VWreUdEjl0WhnCBw9hB75QXPhkoL0eTUYZMEs7SMy9IOCc9/CwFlyhitffdpCaK6x+F
         v5vcdaHUy3hULnLx6z+ZXbpDsr4SvzHX6Ui8yPZrmW6t4OJ/HXhuNKetf485bPHhEaUi
         WyJBZ+LC3Y8tzrXJUktvbYluWaKs6qYxriHhCGUG6VGqCtpJm80SJzus1xqTsh+Cvfwf
         poADW6T46vHviixiyVvhhpCBCRnv7Ml2XWMHEz12r/P+DZQx+JhGzes2aYhyapKxsiVp
         O0oA==
X-Forwarded-Encrypted: i=1; AJvYcCXrtFXF1FLYpK7fEOAFR1vHvlJSfIaesmv3eX3LGEGeSHb6yb73ZzrzwPydCvfgf+Siu/nDwMPrQnKtlmhGM5pQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAWcWjZazD6so5b/bdCFVapSOurJ4pr+opXMINFgPfOSmfCgB
	f/f1PALJDhdxjGblJ3voaDgP/qm9btTmVBZk9TBnSGn4uFJMU5sQPlZ0xkdqJewe3Lt/UNznQPe
	QadDg2A==
X-Google-Smtp-Source: AGHT+IG/7kJRP8j4jNVxK+WTTnpF6wR6SbG8no+zediDqWUX8ohQa7y85641LKDUVIohBUMZwU7EgY1/qeBy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:3002:0:b0:e05:6e45:84b6 with SMTP id
 3f1490d57ef6-e113d176384mr2038276.8.1723495688336; Mon, 12 Aug 2024 13:48:08
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:11 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 19/27] perf mem: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-mem.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 0fb4d75ab959..18e5f9a0ddc2 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -276,7 +276,23 @@ static int report_raw_events(struct perf_mem *mem)
 		.force = mem->force,
 	};
 	int ret;
-	struct perf_session *session = perf_session__new(&data, &mem->tool);
+	struct perf_session *session;
+
+	perf_tool__init(&mem->tool, /*ordered_events=*/true);
+	mem->tool.sample		= process_sample_event;
+	mem->tool.mmap		= perf_event__process_mmap;
+	mem->tool.mmap2		= perf_event__process_mmap2;
+	mem->tool.comm		= perf_event__process_comm;
+	mem->tool.lost		= perf_event__process_lost;
+	mem->tool.fork		= perf_event__process_fork;
+	mem->tool.attr		= perf_event__process_attr;
+	mem->tool.build_id	= perf_event__process_build_id;
+	mem->tool.namespaces	= perf_event__process_namespaces;
+	mem->tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	mem->tool.auxtrace       = perf_event__process_auxtrace;
+	mem->tool.auxtrace_error = perf_event__process_auxtrace_error;
+
+	session = perf_session__new(&data, &mem->tool);
 
 	if (IS_ERR(session))
 		return PTR_ERR(session);
@@ -458,21 +474,6 @@ int cmd_mem(int argc, const char **argv)
 {
 	struct stat st;
 	struct perf_mem mem = {
-		.tool = {
-			.sample		= process_sample_event,
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.comm		= perf_event__process_comm,
-			.lost		= perf_event__process_lost,
-			.fork		= perf_event__process_fork,
-			.attr		= perf_event__process_attr,
-			.build_id	= perf_event__process_build_id,
-			.namespaces	= perf_event__process_namespaces,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.auxtrace_error = perf_event__process_auxtrace_error,
-			.ordered_events	= true,
-		},
 		.input_name		 = "perf.data",
 		/*
 		 * default to both load an store sampling
-- 
2.46.0.76.ge559c4bf1a-goog

