Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA72187341
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495661; cv=none; b=n4aGGOiY/HApiSCMsF0v04P3mcoK46mEYs3l2JT8YciG+uZN6U+vHboh7FTkECtT++KRfvf8naHGp8f3wpI5sNeIww0CuKiwk1er7XMlgf/enfPO56ZwL+16t1F4tuGfQUbRubPWCqsqIW/fXeR2B8vl5Bxbdin79heSSvWSy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495661; c=relaxed/simple;
	bh=BZDDhHpINt7zFZ2dnVQIsF8i2MQFy9+sdU32bNgre40=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PPWxnYeVh7jVj3/3bgxr5EhSuoK6R8txtj1C2PUUwzwjrNtNHFRkRCsBRn+Lc+W3EqY7Ekr/jLKlyauFXYwZSIMWX2EYuP1pcRBCJsqWVbDnd6yZYNrq0sOJ9YGfN5JW7jf12Px5+KHEBrKDzbGWa1AXe1zPlf8UjyiYgwx6GhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAGCs56W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAGCs56W"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664bc570740so91227287b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495658; x=1724100458; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSnhy3Vr2qERdCmMnBMzUq3MwYF2csqFbHWhPN6IO30=;
        b=hAGCs56WtHyG15DEwuSycxd1DSMAOq+dK2loIwmLQiyZ3HJElN7mT/U5PtPbh6fm0S
         5c0hh6yd+wDKcHc0JBS/BFpS8iEI8yRD7dHdl2js2U1EewaAadlIQe72dHPWDdpYydsk
         UkzhDi2E9ZXn4bN1yE9TwnEUZgxl1PbG8QPzi+W5Zcsj0InhB+9EJKw9v1Ud5GgWgvL1
         O27pmZ3JxOM4N5hB7OD4ilyNqdjWcu2fTPwhQXhYgU7J1PWFoEktzj4sjFkDRigCojsC
         xAv4FEWHWoa794ILitW1JKdI4bTv0x6GTlivsPo4xEcpgn1GG+z1OY5zhXjaoXaSvwx+
         8RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495658; x=1724100458;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSnhy3Vr2qERdCmMnBMzUq3MwYF2csqFbHWhPN6IO30=;
        b=bL6dbhNk7uH6NUDDqvJWOsRxiIxORHcGigYg+9VOqOMpKOtAKqE961m6ElIsK7/PO7
         ZiLbaS9i/FfpLRuHrqe5MlhqxC27RNJDE2tsPuEwhLISva6UsJ1FTVaJfgMr29mCJ+z4
         J75F6EGe/bnGq01wjsheVkQ6KSNrdJH+/qrnXG0WWpb85Sy+jLalNakWR7FDHKV8FuiK
         1iqQfHE8eBG3oq8sKPsFn/PZ8p6s3JuaUcj3aypxPDvgS4JY47filty/cjAtgSYg35em
         u6T+X8QxUiAxMxq8DdGXAMF0b+0jUPVMYpcvqiMgYJGsd+oEyE5WJ1vD21HBOOngwp/w
         bQvA==
X-Forwarded-Encrypted: i=1; AJvYcCW/qxlb6JBDQis0eYU1jMCjWFVgEBAXeG7J31qTOz1wpB1RsGo25jd+3dmjV+Uf3eCuiPRYYHLELeFR0bj+wmbHZEa2kcsmgpe0OaN+PsnUGw==
X-Gm-Message-State: AOJu0YwWCYubCU3nUSq6Ko0REwlaSDojPaNJol/rj0roJLnr2s5q8Ilr
	NsDUYqAmu/AkJ5o7nL0SvoNTTXC0C2f6wD7L2BBqPcfA5dm+zjk4FJtRtYQDCEHIVhhm8l4oAf0
	rtVJSlw==
X-Google-Smtp-Source: AGHT+IEblpJwdl6278PFoZ+5cEGAgnioMooSJ+8EN/KwaqJevyVV+yvBEdMZq1rxI0gSMePlMu8pFsWGn/7c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:ce01:0:b0:6a1:741b:b723 with SMTP id
 00721157ae682-6a9ea8e5238mr117867b3.5.1723495658586; Mon, 12 Aug 2024
 13:47:38 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:58 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 06/27] perf kmem: Use perf_tool__init
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

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.46.0.76.ge559c4bf1a-goog

