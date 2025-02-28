Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2D1DF271
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781440; cv=none; b=VLGtAevcVVw+tKX8h8TYXcIsRMytH869zs2oD2ngWZcTfyb4XZrZAfEDqOP9c2ejFbQwHPezz0L19451VriNf3SA74porjAkc6SIvHQDCasTsZyoNm96JXQpkrciPkLA13sM+GwHnzU3nGXdJ4s3US1BizUoXzNOIVTqaCCanKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781440; c=relaxed/simple;
	bh=1QIgufyKX//dArN5ELC42cSlOnJMqn/N6xXRUEwesp8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=DLZcwU3OCY9yyCb8DQ+1dW+VquR9+u9Ms5dXg5rgoHfkrUjQa89BP9Ehbzij21qHeufoqSKzVnE5ds4iPed/BDxFY9LgyAN9214eJlvr3WnO/Cwd0mb/lubEWjdnNQ08ZD03yjmQNpwsmiwlVLJkHWB6Lsa5wuA66h5f8MPFbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZpqNINu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZpqNINu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fd5b2883b7so9550007b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781438; x=1741386238; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsPMBkH69637TTeUcT12GL6mDYxITCSmP/v5bZ3zoSc=;
        b=3ZpqNINuMmRm+VsPbvi8OGKHitqQN41gkBY1nEg8eRsD1t7CRThVgfL5hXe36UVmB+
         T7X7oFEc63iFCzhrw31UOk+qTVyd5pGeOhcm/7juHGUikaUnw2+7DIRSp+gap5+rFYJL
         Pc80K6EKPt6jCMDHOtE5unJTScgHKAHJeEVduwMYos8GMTcCYCCK77dFqPYV0cqjrcdQ
         IueALOZdHH/B9kaC8PK8n5fTUbWC0VHQQ2BJ+kxkNqjDuH7a4SWvceN9jSGjmg2zJOcu
         J52Rcs/UdOYj3wLaJTi8Jq2K8nOoAkNUzn+OAMIJ0q/sIJ0mAueYk/Mglr+2gc87s308
         wgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781438; x=1741386238;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsPMBkH69637TTeUcT12GL6mDYxITCSmP/v5bZ3zoSc=;
        b=EyGJ0YkQCfKYL2apAGNddqfmlW/kgaziQZ2WTOTTL1+fVU9hbMmSKiTQUdx8hrrcAN
         yUXnLUg2hQDV5evCj+zd2QAC7kB3qo5xWprVKpW+kvwa82Z89wpxWHcQ/qijhBNg2coU
         GKzoypqSn1lfZFfRDXoWI+qyICku+VmLAFhAuJjmyE4XDdkh+x9cG3y9h+1a6tyMG1pG
         8xZFm5sd+FKfRMh0cFjcRSNSrCnAbTwgRDbpuO/A6SrTbxU4jJ6KhUig4exPUOBoO2XZ
         eAZBWptdFtmgwAKQwpiE17TzhyV+GEWyFL2iJR2Wbnfh2e+rAUkVmMg7Z4vmAt6Trs9P
         GRcA==
X-Forwarded-Encrypted: i=1; AJvYcCXN8JcqUYFtC4pIp1d142eXgISqJ6Wj5zRF9BDk5EPO7x82Q1vP1GSPjXgl0BoLU1IicMRl+EtmV4RycwnvX4Pu@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQ6eUPdrw58wGqOxl6lYE8WgCJe8etNx13n5vVU5+jidkP2df
	lE9uhXAEvc3UqPafMbla70qbGwPAf4LF4vKL4PPJxR9UfyCyiM+3bqe5q13f0qB1fAaQ3qenZTi
	KQ2Vrfw==
X-Google-Smtp-Source: AGHT+IGZdRCkerahb9c4wxk645+PM+BR2jUS+KgFNjUrlkGATtsekS5Ap18M/puYq5Y6YdfL36FIgTPIx/hT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:8e06:b0:6ef:7372:10f8 with SMTP
 id 00721157ae682-6fd4a0f729fmr6305367b3.5.1740781437790; Fri, 28 Feb 2025
 14:23:57 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:00 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 03/11] perf evsel: tp_format accessing improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure evsel__clone copies the tp_sys and tp_name variables.
In evsel__tp_format, if tp_sys isn't set, use the config value to find
the tp_format. This succeeds in python code where pyrf__tracepoint has
already found the format.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a0ef095db92..1974395492d7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -521,6 +521,16 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	}
 	evsel->cgrp = cgroup__get(orig->cgrp);
 #ifdef HAVE_LIBTRACEEVENT
+	if (orig->tp_sys) {
+		evsel->tp_sys = strdup(orig->tp_sys);
+		if (evsel->tp_sys == NULL)
+			goto out_err;
+	}
+	if (orig->tp_name) {
+		evsel->tp_name = strdup(orig->tp_name);
+		if (evsel->tp_name == NULL)
+			goto out_err;
+	}
 	evsel->tp_format = orig->tp_format;
 #endif
 	evsel->handler = orig->handler;
@@ -644,7 +654,11 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
 	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 		return NULL;
 
-	tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+	if (!evsel->tp_sys)
+		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
+	else
+		tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+
 	if (IS_ERR(tp_format)) {
 		int err = -PTR_ERR(evsel->tp_format);
 
-- 
2.48.1.711.g2feabab25a-goog

