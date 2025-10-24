Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C5346E72
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328751; cv=none; b=f+YeQjCG7WCmW+/1b4au8S72MEDWKXDEUjJfDZ1abFBc+SRiETkKSwGSVhnBHvXQfS285q0xXKKkuJdeSv269/y6+ws/ZE0cHBJ8cCeXxu5TLOyjlYENEK+JVO06EAcr4HlhUgHR4Fv90M1EYnxIgAR6OBnn2culIMvudWhTAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328751; c=relaxed/simple;
	bh=y6HnQZia41UtwY0YyvlgW3W6qOJoIv/4XqLTxzvxWN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=c+JFXJD5dVOmiRVWOfSyXh7zrFBx+EavRgUjlAV5FccOIK60Os38TppIqx2OmI8egYG2GlkMMVN9UKJSIG/eQC4zNT4raXX8W31S8EOJXFxfarLXRRFjqlnxs5+ebE6Wc06wnU84Z5lyOVr810mcEec1tlQNTlP8ZpWKmc7TB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDuB+VzJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDuB+VzJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so1975652a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328749; x=1761933549; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cokO0Sr9XTu+ExHguyCo1Sd9Y8GFVn9rZjxHL+N1gsY=;
        b=KDuB+VzJfuNUl2ISsqcccc5Z8S3dwFepPPJRJJ+APjLE46jE5s3bBWinFcMYq4RwyO
         cWLJ25qeenTm0LPBSWbP1eynyHa3pHZNhYbbtxZtDfa9sSvlk+F2L+afrufSdF7PzRc0
         E0L5S5D5+jY4N1jngkRhNf4k6nuXJ04627DMeTUf9jcuci6m4sf/ICjK/6RaQZxVk91m
         M9bsAev4QihTYnIBZKb8XbHNQFJLtDXA2PDpd26j5n6vSt+kcfy2ymzJHJ8ht9tijzH0
         8di0qVSp434+opU7N5ngJRDdOw1qaRes1MGy746XeSaGRQv8DNJ01+BnMWeIRiJMpUSB
         DamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328749; x=1761933549;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cokO0Sr9XTu+ExHguyCo1Sd9Y8GFVn9rZjxHL+N1gsY=;
        b=NNHKaqVGJ+Guyh6E15LLFIRpj2HI3kE4VTGJ/52GT/D3gWe1iBVR6dd2GdzZK8Sf3J
         h+pzzlngI7evUtOSoyVXUmIXbY0nZUQAYiGVfhgL/XUQ9HWq/zeUv9UXAtVhmUtsbJKL
         6XzH22SHJILgBa9SiR/je9kK1SHIuxLyRNZI0TalBIrWs6oAoy2VKTUhMrNlqjRBsSEm
         y+PRg6Jpu0DsVJ1dKv/62g+eiJ0jcwCWpmK4ANdOqtADr88t8wg2meOG4xg7RaxcKNJ4
         Ge7WiMAqlO5I3+w63DNm4d6E/ivsmOqyi6lES5A2DtwrWjLlObik3ADc+rR5PVeKsB6g
         LDiw==
X-Forwarded-Encrypted: i=1; AJvYcCVNQOHgyPLkEL7Eo2lmaSd/6ALlYKrv8X6bRCcreViK1TghNLoWeGlSJ2eecQG5FgE0+hA9bpg5W/LViWkf5xrS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlmulzx7pk4G5900spi8wGsJ5z0lbhmhQ0eajCe1iBpnXFHX4s
	nj1dZgberSpGHYY/Is9gFZvqrwsj72QCDOqLPftoFAX6nDqbAO4gLWzyS/SFEOeoU64J1BKml10
	LD/Am4EsLhA==
X-Google-Smtp-Source: AGHT+IGI+JqHMiuTh4v84Dx/JIanazWnP/wdgwfnIy5TXQtNZAoVhJ96nHZKWoCgTLxJW1ADY9HnHnWuFdNC
X-Received: from pjzg18.prod.google.com ([2002:a17:90a:e592:b0:33b:9e06:6b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cc:b0:33b:ba50:fccc
 with SMTP id 98e67ed59e1d1-33fafc1bc67mr8458246a91.18.1761328748903; Fri, 24
 Oct 2025 10:59:08 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:39 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-5-irogers@google.com>
Subject: [PATCH v1 04/22] perf metricgroup: When copy metrics copy default information
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When copy metrics into a group also copy default information from the
original metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c822cf5da53b..48936e517803 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1608,6 +1608,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 		pr_debug("copying metric event for cgroup '%s': %s (idx=%d)\n",
 			 cgrp ? cgrp->name : "root", evsel->name, evsel->core.idx);
 
+		new_me->is_default = old_me->is_default;
 		list_for_each_entry(old_expr, &old_me->head, nd) {
 			new_expr = malloc(sizeof(*new_expr));
 			if (!new_expr)
@@ -1621,6 +1622,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 
 			new_expr->metric_unit = old_expr->metric_unit;
 			new_expr->runtime = old_expr->runtime;
+			new_expr->default_metricgroup_name = old_expr->default_metricgroup_name;
 
 			if (old_expr->metric_refs) {
 				/* calculate number of metric_events */
-- 
2.51.1.821.gb6fe4d2222-goog

