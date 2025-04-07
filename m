Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693172253EF
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002095; cv=none; b=lQkqHBc59lcLP+9d+zjxJqyHe5/r4UbpM2nqIp18dJRtUANak7be2PIpD0uocQMycKo9pD7kkEPFTBfGt7uH+lKZ/P8qzXkMUYYsc+ioVnQHnpPKt7VNtzPnkQvd+q0p2eB06WloQA7nat+yGkrxjr42w0+t3x3VKh/bJg7CJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002095; c=relaxed/simple;
	bh=nqVoBCX+NQVq/fKv3GRf4qovTPQSejn32aFhaxMkhGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=op6OgDtbvId7hox4BOrtvpTaae2I8VK02cqHcggzM/dL6Fvy5PmTWU+QrScaSsIBrI3zgxQN9ut/gt+9+XYM9CJs/50HDzla8XE9lC6mHqvW/7fXQxThs58tdRaqqSm5ePJHy4WKkuKXYSkDJQsiVuSqBp+FhCIQMSu3XqnkRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmPEIdHb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmPEIdHb"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso6058637a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002094; x=1744606894; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRFvhDcXFq+LlBxT88cNN7nW7dqBbDfpT2imY8liKzY=;
        b=PmPEIdHbRWcwa0j6Ca0VH/lmqkmc/KaMCPi37O/ViBs7h56Hlo7Bm2SJNaqCudfTPb
         gs0s0gDW2NugOvqsDnYtYifA8hU+mDn3Pb5NeirfihMqrSAS/9ZhT+uk6RknVctqEkzx
         GO7r8+DXC3QAvNx0O4JxfpYUAOf7FyvJDG2MdVaIHSkgF5bRzEb0uS4Vp/67Gy28ItPt
         IkNMnqtjlOsfAA5A3J771m+CUqUbBG5qc5825MqSzm2UKvqj6M7q0Kf5cl6GPRGAfvNF
         FfRgT402PaagXcqOuFby/j3pwS5TMeIn1vI4oBIf4NSDInv1PhxDWjIBmLLLsCAgS3XS
         hA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002094; x=1744606894;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRFvhDcXFq+LlBxT88cNN7nW7dqBbDfpT2imY8liKzY=;
        b=ZXUZ6PpX6z8pnwGQrw6+WfcTFka8JOTvC0L6AVz1Wla61G60f/sYI1aRP7hlDnt/v4
         EbuwXH+oU94RwQdboGwWejDQsVcUZchobHYn8DuvFiJipbUtGCpWtb8SS49Z6+VHdUP3
         dsYB6PqVyPNNYWsq0QGjjvLd7zsOyLaOJbX9y+t64YnaMjJ+lsmgRFR3qU+DDuckCsru
         7nbvqT9CxvYz2t0L5+c4NWbejFKbEYYQ6axXwfh+xijpNATJFBmjxzIs/M//VjrdWhS5
         McmMeKWMwk6sOr3Gd2xKKKcE/2ypJbLgixUkxUEH9KfAHE3xIz8rWBAYcn39kAy4tndU
         ZAqA==
X-Forwarded-Encrypted: i=1; AJvYcCVFFSaAwAVwDKawC3EWzUHH5wIZ2jTD4Yz2JUPmjFIPP51IjSq48hTbJx0nVqPVjKYA9EJUX1DBjZIh4wyvoN4K@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1i/1Oe93/DrNPZPzwt/nQzwJX4TXYYUUgXWaDyZV+IoWWNdM
	V8M+paYhvIXq/BHFyNcCv7st3Akjh+e1jLvoI9SxmjD7SalCWi36a+7CHDriyN+zwSWM7uw37kJ
	gIr0/IA==
X-Google-Smtp-Source: AGHT+IGAxC+bZRaaNm5i6cXKhKoClDumhpYJ9DJ0SMj0GkdUyJiR3ISOmEF1F9ULliuDvJrtutKjL1CadOc5
X-Received: from pjbee5.prod.google.com ([2002:a17:90a:fc45:b0:2ff:5752:a78f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5344:b0:2ff:69d4:6fe2
 with SMTP id 98e67ed59e1d1-306a617994dmr16188183a91.16.1744002093824; Sun, 06
 Apr 2025 22:01:33 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:58 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-14-irogers@google.com>
Subject: [PATCH v2 13/16] perf intel-tpebs: Use stats for retirement latency statistics
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
index eee105dbd544..f9584b00fb05 100644
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

