Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF017A918
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807953; cv=none; b=t3t4q4qC9irnE8KcSPx97H/7naHBrgDX2TbujjpO2ty0ANgFg1ZvjxVjWioCctcB9M6IA7rJCG3hgg0yVbrqml07dnCT12sUUUUcRbUhVdmQtqn++vXcxM7Vf9f+o5siMgB49Lrg2uRLX2pMiM1YvzhFJwW9NL0wA3HAMjARxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807953; c=relaxed/simple;
	bh=LWeT84SQaD/ZqxsdujULbunWNxfNaZERjhKf3ganreg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BQYN7c4TDQilzL6WXH/EbqtDab9rnpFwctUFC70+p/TEh8G84D4BJV32nHw11tbFYIkK8SY8ecUTfAoABm9fg280GRTYWhc18mktkhZocM0aoC7ji+NoX+NFaaGb/2w8EPmmiWlA+WK3CoVh3KCYH+UNSSg92Iv2MN+wcpkHx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wbr92Zo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wbr92Zo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-652c6e92147so40530837b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807950; x=1721412750; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf/366lvU4AUPtbGBpn9zhF7c/C+EcohgCe44YuCQ7Y=;
        b=3wbr92ZoWcB9ueDv6oKidA3jdtZEPVFK+TxOSUOUL0E71QA+F0oI0J0NzZBxzXxbYp
         qNphE0IhHEHk2VZSvwLKvYuCTRqLB2VwG/UbuV4u2hYQ8pNQHY14CoygDk/W2bg3L5AS
         E07A1BHRqTpUPQCV9Tt4Okr+K+dotW9qLp+crlhmjulCaG69xJ1HJqUa1uI24eVbTMza
         xc1xZjtUn438kqAgKqoiosVxOOtszkCDy3Mr3t3n/VLh3XbHLseYtJD+aC0/nqAMS+iQ
         cowkGKmM2BPqpsDEhHlyrVfEaFiUEvxalH3P4IEwERaxvh0Kh7rXyrYQ2M7Pos1Dd/k6
         UJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807950; x=1721412750;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jf/366lvU4AUPtbGBpn9zhF7c/C+EcohgCe44YuCQ7Y=;
        b=v02tEuM+joslepp4xGqqsRk5w4soWQQQmaR8+PUsM/FidqlLeHKRzaXcqwnd2fbOmb
         rlHdRY6BxPPInrQ2xYtq+s/+KXehnlYSkamZyIF3yDOIff8CQrBwWQmIl4lY/G3c5UhK
         /mNJ8i6buf8VB+1luO74vrIHWj1cqPwuumrXNfmg1v7zsF3pVUL0z4C9PUGf5xyE0Jo1
         zwRzGvBz4yHxXsLk/1qaIBOn+1ac5pUlBQu0CcmQ4bxlKBcj9ou7uO8hhLeFkOXV3UKQ
         +nD3klWLn34mH47P5f17kOtqY0MjoSZDYPWzwg9SonZxosDzgqdiaA4jV8EIQtrMYI8z
         xUeA==
X-Forwarded-Encrypted: i=1; AJvYcCUS4t1Wu2CBW+VWIxwT1P/+q9yU7UNVqtJ6f0UPliLId1j5FY47QH5srBaHOf46hrZZJPYMHBTTVatlXoCW6MCWBUm0bqvxkYwtUrWXu6o5RQ==
X-Gm-Message-State: AOJu0YxRb0BIt+HdaiNqbwBzKqT6k4RIWDKAI+a3RsPMGH0MZBso0svh
	+GOqrA2AObdA9Cra9fgsKDX5ysocqkcAZvC2DuYPx2+Tyl1unCjYUpEVoWDz3exMdD5LJqTwi9M
	ueuRzSw==
X-Google-Smtp-Source: AGHT+IFlsKuGpxVNyWoLObgwAYJDkigpd5ozGArlXoag4yrjnwDea6v3GSNUcs145Zpeoo6bG+3lCKfvRy4y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:25c5:b0:62a:4932:68de with SMTP
 id 00721157ae682-658f06db413mr2068187b3.8.1720807950582; Fri, 12 Jul 2024
 11:12:30 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:50 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 09/27] perf lock: Use perf_tool__init
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
 tools/perf/builtin-lock.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6efa9d646637..2c216427e929 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1933,22 +1933,21 @@ static bool force;
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.namespaces	 = perf_event__process_namespaces,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.namespaces		 = perf_event__process_namespaces;
+	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2069,15 +2068,7 @@ static int check_lock_contention_options(const struct option *options,
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -2100,6 +2091,14 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.result = &lockhash_table[0];
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.tracing_data	 = perf_event__process_tracing_data;
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-- 
2.45.2.993.g49e7a77208-goog

