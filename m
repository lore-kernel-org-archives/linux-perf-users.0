Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AA719DFA2
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495704; cv=none; b=ek3rhiaZOFCZeSXuVr0So/EedewQPfNKkj74HMY/B/opQBdNKqkJ66uun2zeuEnQtWkWha7OkgfmWSnh+COJPJI06fENlIAOErbWGmEHvjB4RBCUO9IfUGqD2TGbIlFLCQVYcVwU5taxUPyB686H+BqbnilmSd+jqdWWGrsiHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495704; c=relaxed/simple;
	bh=FLTvjXHovNyna5ZBwBF6nqPFWuGC2tBGevzyvrjl4G4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TcgCkRw+LMFjH/7kHs3DPh7V6+cfG/V5CJF97WO52RlDWnwFTuBMYbUZmd22pvTfcBJVsjkRYKBGxXrv//wKTr14q3ARr3RBaYyGpsCB6ni8vMNYJxZsmbQAp4btK0DGAkcLqmHHDR2+m8OTA5Nx3Mx8S9FHYmxhlH2e4k4UOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SB0zJLQ6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SB0zJLQ6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0e3eb3feaeso8114678276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495702; x=1724100502; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EG3+lgGDXwaf2Ajxqw2qZsx+igBWdkgUMhQ+ezR45jQ=;
        b=SB0zJLQ6gyuySldCwqgLWk4tiNuJu4cHxXbz1rzmHIS+WQBcWj/hwBFu/hFv/plyzS
         vVH8fit/jP5QeQ1z7G0+rwbLVuWydpqxr53EsIB7OxTsMNOYrGKBShNqWA12WKtoXiWc
         iqQk+rbs0j6uW66u+cwor2K2uWBspeZp94VUxru9mOvrWoRF4aTr/Oy0JWus4WfRfEj3
         LBE5+yBOz8R+vNji3MuR34z4cmMXj2X6x3rAw7LixjUDO8LoM4g2quKs8EWtV5l48TG9
         +i7ngKmpzgBM35Y23xNfyYhd35HyZ1pqN+wBQmfVrp8pggCp7ADot0kqHZJ29vBPW7L4
         efQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495702; x=1724100502;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EG3+lgGDXwaf2Ajxqw2qZsx+igBWdkgUMhQ+ezR45jQ=;
        b=dIZOFh9DkjAkW1ohVGKxuJVygvmdG3NJhNtKJzLI3NX0rA+AupRDptZIo+42yOZr34
         seTlcOn0FvGvjUHHCbwT7A9JCekE+wCNtmY5fmSV3lGikllku+dnbSjS02vj5INoOtU9
         kegG3/rS/3ZN+aGMz47bPXr+O/cyluXeWKXL50AEHPOljeVgH/8Ybu2z+rYFVu6D5dwJ
         CUbs6qjw1SCtShJe3lg8IyujtsVDPjr44CZdhs4uYq8t9craWolJAE71rgU+g6JxBJsK
         Ts5DlwkWJraiCbWAU6JNXKOxys2DZ8VwqkCXsjvxvO+J99tmOiGNd6dWeWZi4j7vDOAT
         JJrA==
X-Forwarded-Encrypted: i=1; AJvYcCU7X4TkGilyfFQ1uSmDNFiNaAVSjx71A1Q9zuB4y+58vJ6ynjoQrOXg3ucxsUiWZU5AndrCkscuP/j9zYMQrlG6irEB/e7zBPKGa4jpk4TxsA==
X-Gm-Message-State: AOJu0Yxvy2HAF5cKIsxro+ex2+n4Ugg/YG0SloDAeTxQNZAI/qwPr1Jf
	tfi7c+IOAfCSEgs4TFbLfVxBZT1jYgN58B4oG8AURiQsfQLPGTWJ2BkNgXtmK153g1zaQpH1q7r
	aG/X0yg==
X-Google-Smtp-Source: AGHT+IGZn6iEjUKcrQKI/ImnhvzHRsCJ2piQaoANKaHrQYq3pioz3Dhmz7+UNU8tS+gq5ZENrkMtgqBdNl6C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a5b:485:0:b0:e0e:445b:606 with SMTP id
 3f1490d57ef6-e113c918693mr3653276.0.1723495701802; Mon, 12 Aug 2024 13:48:21
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:17 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 25/27] perf kwork: Use perf_tool__init
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
 tools/perf/builtin-kwork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8ffaa80a2d1d..6a4281b8fd10 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2322,12 +2322,6 @@ int cmd_kwork(int argc, const char **argv)
 {
 	static struct perf_kwork kwork = {
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
-		.tool = {
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.sample		= perf_kwork__process_tracepoint_sample,
-			.ordered_events = true,
-		},
 		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
 		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
 		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
@@ -2462,6 +2456,11 @@ int cmd_kwork(int argc, const char **argv)
 		"record", "report", "latency", "timehist", "top", NULL
 	};
 
+	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
+	kwork.tool.mmap	  = perf_event__process_mmap;
+	kwork.tool.mmap2  = perf_event__process_mmap2;
+	kwork.tool.sample = perf_kwork__process_tracepoint_sample;
+
 	argc = parse_options_subcommand(argc, argv, kwork_options,
 					kwork_subcommands, kwork_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.46.0.76.ge559c4bf1a-goog

