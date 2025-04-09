Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF91E2307
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178887; cv=none; b=IXMpAv3AKBoOS7xoRkfiCjdIzogxankdoFcRPbyhSqJV2Ixi1pz9DVuTXtZCUMNIB50Pa2OeBKxvt1wKHiMmYEiMbZUT/vFSE/wPt+HeHxH+Hy1Kz8UjkphKIYsfn3VKn3lM+tKmzi8C9kEgjXYP6c5yCyKD9RAiAzsWKM35438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178887; c=relaxed/simple;
	bh=uzrqNAXM/KeEjp8qWr6xTf3VLWW7e0MNaK/cvBjUNjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tSrZOrTHEgvsIJgaXNSraV0TBxB7oGK27/qPzvCwXZPBVq5mbOAmJ6T/Bi98nZpiJf56XYWV0GrcSSFBgYWcKFC93nRZkWwzTDnZ3bK5smol/brGcu/tcqkndMT/qkVoik8SdN3e1phRmc6i/KNlW33VL8wPf6Wfd2dOys/XWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I34j8etq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I34j8etq"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af534e796baso3936049a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744178885; x=1744783685; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=I34j8etqwYCKPAG69VVcArKZXNyedo1jZ7rQ3JAjxtEgiF4JB59tKqjG7Ty2aI9eAn
         HK+0dtuj1z54Owb/B9tOxdMCvFvbAdWPku4otg3Z+5uoUnUSg9YQQm+qIcp6b2+EYJbc
         6zn5Ehff641dvARiLJpkCtHSZgOVK5a6drGxJXwbxfE8wJhFcWUsGnLC57q2VvVc61LL
         xE5kt54+gM5ySw7kXL1rhvBRbpZwn78yUW8UqB7aiFx5Oj3nlCFt6oYjx1jJ2ePqcvyU
         Ls7DP52F7Y3X+IMj47qfYsbIfj1Fxwr5weOYnTpgxDJbkjNSvtaxF2m6PmmlT86Y2Laq
         zSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744178885; x=1744783685;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=nx/mHJ3VwwX75gw1CwJAARiljfH3xxJmhvfXklS3lW0YTkdel2OsKlk3UkymxItfyO
         6+AJiaXLcdXT4AekvoKx2mQtBqemfg6WewRqJr1IocDgCOQrcOE0XYFhjUwc1+dnIwz+
         g98fIAPSqT8pTBHxgcsaiclpYQRENJnQVixsZ51hqnMYf+E+yKktzQPQD/dL3jcWMYDR
         a/tIt5FaOq6pvzawT6WA7qwXh0S2OGf+rTRIq/Lazut6Jl29R2pr+QG6ucvKzuZtKJEQ
         H79D62yPv37JOUElNxxQn/hGVD57a/P4USergBcHkwPmzaL6WwfOD0hJM5/4nAvm4BYg
         s5BA==
X-Forwarded-Encrypted: i=1; AJvYcCVHBRuOUfaP28efBPsodlP0hxzs+1azp13xM8n32xFasTyTfSWRcdwoLcDDJ6/jHfYvpsfpKnZNKBoJpHhqeBSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRMKnuhu0vf0nni753SkxOtxEVmMGsVxjKvlAoxsC/mFumzS4
	EUJRfskxkvuHKEztdD1Og9oniHuE0MrrqwMP/WDS1dGSKbFN+8RbMFNoh5f/ISTy//L7qEBc0tW
	0C8il7g==
X-Google-Smtp-Source: AGHT+IG0pJRslTNcNP+002dMo4HlPMsGJJwm++yerAUjbx/PU0Xt3EuaNZpL77KqfnRswdrndUHGOCYfKaBn
X-Received: from plbkp4.prod.google.com ([2002:a17:903:2804:b0:220:ca3c:96bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cd:b0:223:325c:89de
 with SMTP id d9443c01a7336-22ac298f936mr27850565ad.1.1744178885158; Tue, 08
 Apr 2025 23:08:05 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:07:33 -0700
In-Reply-To: <20250409060744.698511-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409060744.698511-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409060744.698511-7-irogers@google.com>
Subject: [PATCH v4 06/16] perf intel-tpebs: Reduce scope of tpebs_events_size
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Moved to record argument computation rather than being global.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2b04deaf66ff..e3bed86145b9 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -29,7 +29,6 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
@@ -86,15 +85,20 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
+	size_t tpebs_event_size = 0;
 	int ret;
 	char buf[32];
 	char cpumap_buf[50];
+	struct tpebs_retire_lat *t;
 
 	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
 			 sizeof(cpumap_buf));
 
 	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
 
+	list_for_each_entry(t, &tpebs_results, nd)
+		tpebs_event_size++;
+
 	record_argv = calloc(12 + 2 * tpebs_event_size, sizeof(char *));
 	if (!record_argv)
 		return -ENOMEM;
@@ -226,7 +230,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 		return NULL;
 	}
 	list_add_tail(&result->nd, &tpebs_results);
-	tpebs_event_size++;
 	return result;
 }
 
@@ -289,7 +292,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (ret)
 		return ret;
 
-	if (tpebs_event_size > 0) {
+	if (!list_empty(&tpebs_results)) {
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
-- 
2.49.0.504.g3bcea36a83-goog

