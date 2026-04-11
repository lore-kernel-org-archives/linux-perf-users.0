Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A232E6BC
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890674; cv=none; b=s3svX0XsBLHhB2YjYzB0zoNWRrVM0uqxyAItXqDjqLqXQFykzQemaj4q6Zr0yAjgZqfehVgXuejZFolu1Nb5vkTYr5lvzvqIjEThr3MtjZX2k1gD/SuI0q1f82zuAXcAdj40te524yp6ZRr8Y1TY9ToFz2CAiRCJOI/HNhQW7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890674; c=relaxed/simple;
	bh=s03PR3NdhraoAct+z3ztP2wak5yT9JPVUBwMWmour+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=liooG58enyL7ZFxt9C5euO8/JlU8hcgXcUi049QWw1esAWhCf6hOrPLZDezjW0BCqcVYbIMgy4b643Zj7zwtn+qUIjqzjREYfV2FfHHQFlDDZyNI3X6oVz0WwNJPTV+Q7Dx6SIGfA5ujpK32Q0nW0Y+hYiwoBJf3Sheo5n/R7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UctZoMJn; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UctZoMJn"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c28353912so1655300c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890672; x=1776495472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=UctZoMJns09rL3wpcQMyZBP3xwkqTvzo7fL4FjyrNqG4mqJPq58DzrmVwD7Hdp5EWt
         NgesHSPIjuzhvavXWJhj0XhO41Y15/x7FmITQEf558Qi8PhSmerVdDVLB5n1GQnwXPUU
         XWEq9pKshhX8az9PMCZRf2yuZFBf08gn77owtUBS13c7KsqmxYVwkRpCk9BkGW1jTly/
         f1Xlqsbe6mUj+QFHHrdS6Y1T/wgIUB54TeYMryn0OcJ9JaYmV2/4X0RAcggltwJ4DA2T
         vslu8GVuHwR7cz0dfzcFwDyPencVcdeQzB/u1qOqgpB0dASiLeOeJMVv96MlfzZ4Hhdy
         XM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890672; x=1776495472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=SyEtLoTbgkGjhRXedVKJPcJAy9Zmxz/Y1FVNEd8hDKSiJDRplnFgklLMozTCEfMmam
         M85V94smDX+0Yha0GOS9i9cDxqg105+Jmz90ZeuJ1oIcI5d9jDenT2O1kC5wPpFglSm/
         xWIub4IxOP/SDOVfSFum7QCfeb6bk6/dWmswjiV25i69mv/75WqP6vdg8Vg1khh+SbpA
         lPYISgbc4B344+k8NiwwaRB1rHsf+FySCjgC/kXg8mP2z5NHHw1fYPQzroTupY71xBmb
         aNAmot8Ddz4UoSXHJSRqakQfqvW2Sgiirmcv0L26EKUjP1wqoJJRAHzBcq81Xo/Kqd5t
         8duQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEIxAXTw2owB6PCgkK4tXq0Q+NGEmM2NZfgEsJ4XDbnuYQcQTtpSJPkXQEsm1u6DKgE3IU19+Loqpwv3xP65oN@vger.kernel.org
X-Gm-Message-State: AOJu0YyvyDCg2punqf+VyYo2WZFe2VGF+zuKpo+2wrq39s7DQR4L7P6m
	QKbs8VOY7wHgk1ZlOnQPQI1BSpxO+Z3uu2sscwWRjh0asPjlVECUAcGcQfAMwt3ZRhHBV9Vkoql
	iwY2sE+stJQ==
X-Received: from dldz7-n2.prod.google.com ([2002:a05:701b:4187:20b0:128:f2cd:cb37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60a0:b0:128:d51a:5161
 with SMTP id a92af1059eb24-12c34eeb884mr3337243c88.27.1775890671611; Fri, 10
 Apr 2026 23:57:51 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:02 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-14-irogers@google.com>
Subject: [PATCH v8 13/29] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f8be9ead43b..719b36d4eed5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -232,11 +232,11 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
-			     struct addr_location *al, struct perf_annotate *ann,
-			     struct machine *machine)
+static int add_sample(struct perf_sample *sample,
+		      struct addr_location *al, struct perf_annotate *ann,
+		      struct machine *machine)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 	int ret;
 
@@ -298,7 +298,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.53.0.1213.gd9a14994de-goog

