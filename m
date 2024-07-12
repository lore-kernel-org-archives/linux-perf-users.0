Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C817E919
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807988; cv=none; b=leyetIXGsK6rtgwe8HU8fJWbOr0N6ab64QZF+3KeTfUxKAiAhg4XTgzbNovxN7//07e2I12EynhFfrjWaOXChL1Lsp+UtUZ+k5+AghinitwMnAAMQMFPdnxFkBfR9ujMUCxTuPrYVEkNzX7aqMR2nWFjO8buEu5RqZ1CBBc2fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807988; c=relaxed/simple;
	bh=Vut48/dGoEfPl82dZRBs1EiuBD2BZmTC7MWAiL1FIkY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l8Vqt8qfOYu7Fo8Akh/5LQCgHGUIS4wOio9JBMio7DfyUNFUNg/tx04gYzvaDf2t1OaOEjVjh/cHLVseTWFmyh9SCJGGO2pxlS+WaGEcQERWTztuV3Aq0DhlN2KY/t5fMa73dlg1KK78Q16CSPOibF11H3wOEeK0MQDqJn5SseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVyQYX1S; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVyQYX1S"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654d96c2bb5so38506427b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807986; x=1721412786; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=YVyQYX1S3LMTGLFTT5Y3VofmBblpBhm40WZsFqC0DhUR+YCrormI6gn17OAEveBj7A
         e8TqMKC50XcDb6pJ4Jt64k3XN/4OP53GfroTcB8+6X+sJzMXcgrvzvCy2ODo4TuWTwrJ
         OwMbD6S4pQLBph4IHIYqHINMGJkvzLplMBMMufplUOnYYx5zQKiUrMmuRiLC3O/lJlJA
         HlILyqc4/ZS1at0nwlk/285wsL+MuyZGR+5newwO2UpPx6KLjYzbkZ+1QjgC67n68S88
         IYpb7CRi3qNd1OykG7141ASiobJLzeXSJoEQd9zGbOK4dDKYACpHa2TjXjnrLXDEgJez
         gLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807986; x=1721412786;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=kt8TViA7yN1SO0Q6xfZwnB8qKGP1L5FE5fiV4eMhYJRkL5VK0HdQWd9q2w8IDMzDDW
         SRcp/CKCqgygfDSp7RyYJpVZvSVLJ04WqKK3dlJhKwYm2BK9W1OHgNNdvTI5cuqNt+rj
         0EpGVNFeofK+nRgU1isKamYnRQh4iH7Ui50zamTq4IjH3ANvepItdBHwRf69M9hQPL6D
         YmLfMUdJlbYDaQ/VgqBGiXq1E01vgPCGinbDVlyDIXbgAidUzLGPL9xXOL5Hw21BxfXk
         a1T7qHnYXlMTOS/HvafXxGnJC4z0Ztf3igRwbcENpxD+0buI3mY8HkUTg/8ThsxY3cNS
         WXTw==
X-Forwarded-Encrypted: i=1; AJvYcCUt0YS/fo9Ob0MgdwiHBCuJTHMr6bd7KVeYIl3U9dUh/XhhzR5glCaqs1hBocC+e3RzVv8IxgydPCL+EcKYX5SkpzsBFLeup8LfS2scJEqZZg==
X-Gm-Message-State: AOJu0Yw4lRHnwugWiLhLtsWBVhM7XfG/EhbkE3WXr/R31B98xItIiUa4
	dC3QmtdjteQKzzjqQOQbIAVBbdDzRQ/lym8B2GDAlwCSRkj1o5sstjmzVx+WxV9aW6R0Jq7wa8W
	NRG6bIg==
X-Google-Smtp-Source: AGHT+IH55ouNUARRkV/7vwiojtMsBJqnZMjnyHFWfmbeG3E2oRRjNgYMj3GXuyIvTVcz6xeK7mzL5W5Xp8yA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b0c:b0:dff:396c:c457 with SMTP
 id 3f1490d57ef6-e041b0364b6mr21640276.3.1720807985767; Fri, 12 Jul 2024
 11:13:05 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:06 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 25/27] perf kwork: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog

