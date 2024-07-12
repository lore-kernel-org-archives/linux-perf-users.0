Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1817C9F8
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807974; cv=none; b=nSDAUuoWNX1/6VNmHYpFamBgsNBW85iox6hBxdRlfgDsdTv0hvPtqu3DRofoCwIBmvEenBqrhx4Y9eTkQ5ALMYEOpInlRGsGcBIPdR+rwqb86fLUNO8cJdDA4vU6NmhN0r4GulKZJQgMbuF67uTBqIKEcXBHONY1DacC+bfbicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807974; c=relaxed/simple;
	bh=PQFAc94b+3E6J2xiJdbKRsuyLtZHAm+NZj3v+mP90Hc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lkAT6ZdDQvD4Yp1eVATlCaaL1ZCGWBasG4g2CX9eOs5rcY71vDbdAjtZ+oy1BcHujAzf9QImoadLZYoyU7sbm26sRP05lou41sM3cLvAsSehkbt95SmK15JUsxT0mqIMUcU29/YSNuIfvKUnsfZCQcKXjKU3zqlz6iZRJL4vf0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGLxMRCj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGLxMRCj"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a92302d1so3686679276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807972; x=1721412772; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dI8yaROyMxBgkl/C6HStDZ1DbB4Rpu7ZnQVumFggSVU=;
        b=CGLxMRCjyiGKsZNLZBfsHfkedwFQZ/BLnEm30ySaBUPCUrpaBZqZIsOPlloR6SiN97
         zZRuFO+kEcbmnO5RgXYvnKC2jGvcRe5Ms4fodNBADG3UHGM0cfCRWlm62buB6b/aQ9Ms
         8MDtg6ZnpJ8Sx9FaL+AVEMu2UGMF3PvpHa5pO9rrpHVNhaXjApCq2GrxitURLF8CUNfT
         80PUzkYsYSeXHfJvJJM6aBU5EY7Yy4epd/HHDtd428elb2hIv8XbiYYBadPesa/60ChQ
         UWtlI91Oqe5Tr4gpdf3h4YcaQywa3QdNxlRYBcp1OlUVE3bfpIaBJ4QolgvZ4KHZfc6w
         sOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807972; x=1721412772;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dI8yaROyMxBgkl/C6HStDZ1DbB4Rpu7ZnQVumFggSVU=;
        b=YGzKhxT0QTLOAR6xn7YR7GZHltNAQKCATOWthxJUlV0yC+jvgizRwZx5XcuKrJhSBb
         D9E/xvTjd9RoTB+hwuoW8gRdJ6rGWkNF1BfY9JV9oPSTtlA2w9F9Sy7vkE26uYilCBDv
         24FOruuFAojv+nACmRjta++oBuFtmBmq2ukASRQd1oyVJBGQgyhYa/B6weomwk0ZE6GJ
         RgaQBPvHnY5CpkDguTaoY4MIDo9ycDokSJN6GKCrTQ7RLB+BjPhq7BQT6n8UxRABMR9o
         rmw9lMInfr2MoQ82LwN8JroCH7v8z3b3h7/8vrNeLbwWrrf1yB02XZAP2AaIzbsIPWie
         UdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWioQw+9TOlgtdJx7EnWdmkov/HqndBJQuxQpLCyMbVm8XSBzVAY/xlDHvyvq/vM0XxDOWNjH22tNFlKAvPGan+vKsw3BwoJZzSYxlKLoQ2w==
X-Gm-Message-State: AOJu0YyeVjcgvOJ/HHQ2IrpK/o7FCNz0jroh2m0UXW3+ioqYWK7iXCTo
	hmA362wWw6GMjWhXcgss+SFtRS55dIKrgDpUCTNvY77q1MEjAWELrRHtVRb4GSZ9kxZuTRPLK02
	b5OPaZg==
X-Google-Smtp-Source: AGHT+IEdjKOWNbH6lHnQ3hQD9ZpV0aONsOjoRMeD9l9g2HUs1hV6yUVjuLwzYNk5GAitqb5lFTEdkOp686G6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1146:b0:e03:6556:9fa1 with SMTP
 id 3f1490d57ef6-e041b11d3demr762464276.8.1720807972320; Fri, 12 Jul 2024
 11:12:52 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:00 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 19/27] perf mem: Use perf_tool__init
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
index c2038a32543c..c12ca0ec1237 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -285,7 +285,23 @@ static int report_raw_events(struct perf_mem *mem)
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
@@ -449,21 +465,6 @@ int cmd_mem(int argc, const char **argv)
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
2.45.2.993.g49e7a77208-goog

