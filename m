Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0582198A29
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434259; cv=none; b=O3R1KyirQwAvURRjN/h9mZzAUBdhtYyiMzdkKJATUqHTHOJepfa5scEeQc7e1NIt+uuDSfk0I9c2q64n7UKVka98y+S/0fPUUGUEv6DvgvIgnpN5ZJY0HQCFIfk7PxLxx7cB6Q1wqZdPxSG51y27nincRskvpOaOIEPcdgUDEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434259; c=relaxed/simple;
	bh=k7QXVgVjC5ziryU8iqEZw+jIGB8CNwx93bpexssSTVM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i7SE6h9oBr+f496aAMaMuyG68sDOTv/1j0N0L/YbuPHRBXtcPyqS+0iWUhaAIYbkzN1LeAdab9OaOCLT7tANkhaHpHwEq26SYv8r2SXl6p/wOzhtbhE6tW/N+map5jJGI9zMZcDWcLD/iSQT5bmWlAJIHG5wPmkIs/+h6MIz3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csLlomA4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csLlomA4"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e033554101bso2078917276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434257; x=1720039057; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=csLlomA4V33m+n0q2DIs3soA7tA9GynU/l3cLSo0YWQXJyqDq0wbg4pS30Hs4Ilu3n
         18hvqw5wSngwnL1bPhgvRm96ku6aOeJIncDgBS1PrYJi2tKv9HUgqMr/XxZKeeP70ah0
         vQHZ2IJ8XvIUg3NCP1hkPWdB5KbNA0zbXMqbjb6ddWMvOOPf286UhtAw9weQAB4LFxeF
         xnr/+Zs0mnjBqi7EK3SyH0vm2CTjOk4xMwGK7eBbIiFNkbDnQHpio/nzjMV6T00OzChw
         mzeRM9rOzKKOrQrECZ+YLQ6JjvFRL7ystxiLyrgGtARh7F7PFKnN6q5hZDNn2eFmhh3a
         vtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434257; x=1720039057;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=TyCvEgkkbEFf5/GHwLtqLfG/JnZIf8LHK+w1H+9rzuyZZ0+yTZTZD0RpS4E43OyjVD
         JgTs0YK5CRXNBUgCSYUhJq9aVUtU1nBTiSPArCFHAutb0yceJNMENZ0TPLew6crVlIQA
         EiBKI3nKSxCPmmXZQOEvVi+LmW7H5dnEA0z5/3lWwLh/+7ryIgyasqSgGOzPpo/CABcw
         OycUgVOlPwlOOi/A2ouz4oUgeGQU5hLAwGraOP6bLqirM3HRaY1w2nUf8Y39WxrzixmE
         BzlfhlQu+FRwL479vlYIYIJFRQU1MhknNUwaSyGKdk7aSdwKHqUZKfc5K43gmr70lvJq
         TY0g==
X-Forwarded-Encrypted: i=1; AJvYcCUDIuBMXCvohG6fW1L66GCykeg28vKGMHULJ8w67+CHv5vYja5bRkRueQA1TJecnNSl2DgFKMeb9XtLUhk0Hf9lrCbPscbR4lU4TcbJbG77tA==
X-Gm-Message-State: AOJu0YzjI8N4JI9TmMC8Z/F2NZsbP3oN69oskIE4DO4oOnIZOFEbjNH4
	Mh7/aCK5atMoKgi/jERdEB2fNSmH7pDddqwsoeNAbAWe7/j8ny8vHObKGFjhbhCJiuHopVErMhB
	MZoI4Mw==
X-Google-Smtp-Source: AGHT+IFNDgaSsvKWEhCLp/cJqqx8LLIcQIa91shbF03zPhK2DmfMDZISVjpcNxywqGfQrHzWLCzDwMoXnqBo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:dcd3:0:b0:e03:40f0:bdcd with SMTP id
 3f1490d57ef6-e0340f0bf60mr1486276.4.1719434256549; Wed, 26 Jun 2024 13:37:36
 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:27 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 25/27] perf kwork: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
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
2.45.2.741.gdbec12cfda-goog

