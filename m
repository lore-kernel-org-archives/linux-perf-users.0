Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E645026
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636872; cv=none; b=GU4bkjlGl9nX+TFdHvqwDpEGFQVMeu5pqDyespemm6ZhBnzDWRnlMxP1vr6zNDczLCUU638txZVDae30nfme7ZRGore6izDMxwI2M3Kl0nNgxJup8HwMZW8ALPaylyfuTwOfiPrxpl+YWrDlhmD7SDmfBz+XSrH+MgnK1lK7LiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636872; c=relaxed/simple;
	bh=y2+uH6E5wsGVJ4sb2lGYYk0HQa/dwZSisA2TqI+36Zs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t2NEumK47YzHzDXa0xM9IEp54BZjku8fvwHIt/fWA+jGWIbMntzieRjDrhPgVNTZZZdY3WzRJLZKIgFWy/KFMvSH5KKnmtJmCwoc0rj4w4efCQPwd9ix3NH70YUOJjWp3me1TidG468c2nYMpLMUTkG47Vr/QSI9BIs/51LPfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFamT/nr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFamT/nr"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so2311407276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636870; x=1720241670; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJsf6c3nLHtNKwj8s9NHyYgKgE50TTB53CM1nmVFjJs=;
        b=uFamT/nrdBT1RwWjc1aOOfS4en/c+pJmAflKbLUbkE7paPbfaYjOTPRIhCkhIMHW2+
         abxUfq83Gxe3dUo4EI1qtwlrU5JLwbFKUKFXnwbQ+cdXFxGdd1+ZTaLneQWieiHXYWB0
         cxRTOdIVUDc0NstUaz5jd4SdsHtHWTLlTeTbCAj4FGAPkFY7mhOEFr4kyNcOD7V8qVZQ
         f+wsQdAXZBhDl2sHs9qVQAmNy8OENPT0gDGHDd7IltoBrvkS92q/E2vBmJpCJ0lVwv6b
         ZJqHyl0bVAS1ZHb6+YSHgUGCXlV/xmtyJ6eMCCccjDoeA3sSWu1frzlij1DbLjFvClGG
         uPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636870; x=1720241670;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJsf6c3nLHtNKwj8s9NHyYgKgE50TTB53CM1nmVFjJs=;
        b=IF9Gkcj/78vctqJLaaKMhVKYPCEXaMbqde72Utoy03qFIXCALHYPQvWdEJUmIgjZBP
         cDEusm6QYBOYTBnzixfGuMrk36OiaiRQudRHzqpWkbQqGbYsVuGt4w9A2NUg+6xPqInr
         J+aEzkixowNheXA3nLQJo1emYX+FdEiZGppnw3tnV6x9cOJgbmqwpcTM/v8jmyaIHwB6
         HCDT+ROBhp58Xe/SDrdaEKjHeSIZwyiZiWZXYntZhoYZUaP8066VhQ+P3Cpj/TibG8dx
         mDWGgqmr84BmfPuIotAUmQwN3UI0P3YIFmLQYD/VS18JXW9VNmztzFMFwc1JU74cLTvd
         Ergg==
X-Forwarded-Encrypted: i=1; AJvYcCWOVUC4XRr4IP0ybySidwqRmUJEthkWSazeCYNEyWURLFiqgKhCbk1LzYvDFgI6LB5uZneFuiRxM0y8NzPrqQtoBbOBGeKMvYj350FJb+uLVw==
X-Gm-Message-State: AOJu0Yzor5hmgwhye+0gHaFuvlg6vXIaTOxSNwRbxcJFd1+Z7h+Sh1Yu
	8YZovY6KdSvCNJkAaoiTg0nNLe24F1bYhSYdyOt/o1iItRV2ReEa0TQ2am0ZH/AXMnowovyMA0L
	+1hzgxw==
X-Google-Smtp-Source: AGHT+IHBuals/aehTdAhZ4NXFT1QkYgIb3fJfqmnR2TQzmGp3twPbjHBFtlF3mFyTyEe1cQ2t21rdGyN49BP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a25:db85:0:b0:e03:572c:30d8 with SMTP id
 3f1490d57ef6-e036ec5d6e6mr568276.11.1719636870256; Fri, 28 Jun 2024 21:54:30
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:32 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 10/28] perf lock: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog

