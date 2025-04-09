Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666761EDA37
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179078; cv=none; b=aDZuciKex3olDelEMvr4Yy0zPjvF9MFJj07GArRAzgAs8UsJqoCBNePD47CDJEcwYurL6Q14sveFShKgSn3U2lkTSM+CUIuzIjs6gwguZ17Xb2C4ZfiIfXbem8L4bJv4YlHtZv6WGRYyj/RVb1ErGUZQeFBpivwKg2ayYpR/wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179078; c=relaxed/simple;
	bh=DOdUTxLI7/zQjgCEpln88RgVE7J5L5+nYgmvVB4LmPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Jk16N4L8Ka/nvrGnp16zOW7PH2vt1+qraIDZhNLl+mf4lp0la08BEdXwq107tvb7wB5QNiymXOauCvKbToDRGWTzA3cQkHaelz5Gp2H1dODjjZujzEhjZYxInEiP9TUM7Zm0VMxIkQsJeyaBRrM2KHuZPIba7WqGnRUfXGDxxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiYopxWL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiYopxWL"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so4830781a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179076; x=1744783876; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbV+FoNiQvVRc13/UCAfNK3Jak/b5U1tJ5tpMxpqA0g=;
        b=tiYopxWLTVW9GlcaBpiyVJ+d/pvbALD6fJ6/voKX3tS2BnL6QZjtKyfU3NakGiR/oJ
         5bvOInU+dJBS12/s1CxPqde4rDbeC8alpA3E0+d0egO9eiSuIVoeklTCaCzEOwsKfdej
         SP+Ptheb2WVS5l+uQ78HDURAzNKVOuVr5++Vv5HOEgI+PM6fj3u9oySawNVV6Yyz0xGL
         LMavk2JbeIMJ49T76uhBZ0ELQgZ1FlPnODYa04gSDtY2mvRZYvmWzu1T/7aYf24akyHu
         wTjM3M4K1C9g28AsuBit/TVowFinLFtzkH3GGbT0Pki5fJaq5KMw9rv41vhXpYI1wt8L
         2wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179076; x=1744783876;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbV+FoNiQvVRc13/UCAfNK3Jak/b5U1tJ5tpMxpqA0g=;
        b=nFl1zeJqJNrvxwoE9oD+g5l0UMWaqR0TMs3PS2j4tkHSU9SlfD7Lxgk28rqc3nozm+
         mz/Iad6KOwZ/3EBc8XXG9QuK5tKiG0jD9CHfH9A1uG05dg7fkN1S9UyZs4CmGghNdZVi
         ocOUU9xQ0pZHxpSYpylEKb1dg5e4FYvq1/wmIXh4lDnvGo6+jOwroAeGne7qf9L5pmx3
         dL/2cS0RowJixnkJoofOpA+BzzMsCnTLQPv4AjpRtQWMTr1WcHxkcbFZnI6lgAKkQ+x7
         /DKZ0ae2572QqcJ/GLLNntiiXpT67XhaAGYYQR7a70FHs93R4BfO2vm3G7p0yxRqTnug
         iSMA==
X-Forwarded-Encrypted: i=1; AJvYcCXKBzm9xZ9DqhX05eu5YS0U5rqRVtyPXCV753jJNbwJBPout6Ie1cVnjV+UC8dde5Jd44NJydCpoEQa7KR+3KRE@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbjTWLFZJMF3JmgdY9cEgR1LUXMH3FrSy1I7MN2kyCwr8pTSl
	CUzAWNZzMhh/Vrq7oZJAovGJfargL8svHkf7LX21VaXdSu1XWB1PGobQJ+4vCbapM+MGOBWUu2a
	W2Ajyyg==
X-Google-Smtp-Source: AGHT+IG140Zd6/7lVXAjnge1pa3Un7YaR/FXpKWuwkcmM+zdDiv8SQSei2XhleF7r5K3eMIAKQY2frnqpZoe
X-Received: from pjbsv7.prod.google.com ([2002:a17:90b:5387:b0:2ff:5df6:7e03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5243:b0:2ff:64a0:4a57
 with SMTP id 98e67ed59e1d1-306dd5565damr1543288a91.26.1744179076598; Tue, 08
 Apr 2025 23:11:16 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:40 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-14-irogers@google.com>
Subject: [PATCH v4 13/16] perf intel-tpebs: Use stats for retirement latency statistics
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

struct stats provides access to mean, min and max. It also provides
uniformity with statistics code used elsewhere in perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index a9446e7a1c5c..de9fea601964 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -18,6 +18,7 @@
 #include "evsel.h"
 #include "mutex.h"
 #include "session.h"
+#include "stat.h"
 #include "tool.h"
 #include "cpumap.h"
 #include "metricgroup.h"
@@ -42,12 +43,8 @@ struct tpebs_retire_lat {
 	struct evsel *evsel;
 	/** @event: Event passed to perf record. */
 	char *event;
-	/* Count of retire_latency values found in sample data */
-	size_t count;
-	/* Sum of all the retire_latency values in sample data */
-	int sum;
-	/* Average of retire_latency, val = sum / count */
-	double val;
+	/** @stats: Recorded retirement latency stats. */
+	struct stats stats;
 	/* Has the event been sent to perf record? */
 	bool started;
 };
@@ -145,9 +142,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
-	t->count += 1;
-	t->sum += sample->retire_lat;
-	t->val = (double) t->sum / t->count;
+	update_stats(&t->stats, sample->retire_lat);
 	mutex_unlock(tpebs_mtx_get());
 	return 0;
 }
@@ -522,7 +517,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			return ret;
 		mutex_lock(tpebs_mtx_get());
 	}
-	val = rint(t->val);
+	val = rint(t->stats.mean);
 	mutex_unlock(tpebs_mtx_get());
 
 	if (old_count) {
-- 
2.49.0.504.g3bcea36a83-goog

