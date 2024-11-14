Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79B1B21AE
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625644; cv=none; b=m3Ds5A4PVZ+yJ3VmUwdgX9Wz8vep5nuKrdDd4M+SHQHEU1k4cmTMV80sWc0srf7ld57oxkoOCSVw9uXXazWi9QlsuF5iefrnqjefWqcusRxjS6yyXotQBd6KRTx+SvBQJIGG3rVZVvJ/zEs0wpZ7rkfZLAO5C4OB1N3izSQvImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625644; c=relaxed/simple;
	bh=+cGZw+tvHLTewZNjqPb2GZKmgFpnAggUx3gDJN+OFw4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MYvlBbOL/PT8sZxVAnkzfaGcF1cBMlKf+5JhXiZvGH751KqXq7g7Hn4g/4nz7orTqKYu3PX/bUm+McfbFon9u6jn0oNj0lWoGZs98pTj/RML5Q7HUdw1YHWpWr6ybLdgUsROpGH2tpIxbvnuKmfvj97+usCxxWTio+pmMaNS+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3tVzvBK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3tVzvBK"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso25045707b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 15:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731625641; x=1732230441; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awvak6BK0I2zeOsGhl415ZTiOmR3ErcblxICLfuyEXo=;
        b=m3tVzvBKr12WpJ1OGYTCHpYQCtvOJ2h0IPSglL1IXiplk/n1F++GkOivCQvARLiRs6
         I6ahqm039LEDnFKymw7MLoubZa9SyzzhFbZuiTUx6o19TKr9sMpd9R8+S9bnmkktWqbS
         NRJrBIoFhuOdhFMV3cl9BFciOHGEz4cE6+UEvssmT3y4YEyT1/7R6bhSp2l3RhYvQecB
         7PsIlUKbfz1kb3bV4MZcMibRFaXG3uT3gTNVe4+2QIMwnRRTkHuiZ9U/3DRvcRchFRZa
         XCC50sSDwD8/BgmyrO8g+QNNFyYFUEYU/UVWbSIO01uL4zK0e6GpHeCyeSyJ+pITuiwP
         KPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625641; x=1732230441;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awvak6BK0I2zeOsGhl415ZTiOmR3ErcblxICLfuyEXo=;
        b=KhAlogGgEseKIImd08rWygjM0CSq680hT9W9cWlHPe3UkQxKb4mu+Cx4+e1CvXuXhv
         xfY4NAq3r2HLXb6p9SWmfKU9PjZv3y6ZORlK1qZsNtp+xEFhS3c03DsKWS4KqomobTu/
         uT6H+ASsAH6xQLoGfFPBJ7wlYS/k0AxDt7eCCgtXHnesakCbqmZD+XTKq+DT4+k02tpS
         QjdLaqK/osRr7AxzIiCHoDdJ2BftRmcrYUg+Udt2YADsSEIWwtfdTa9jOYg93RL5cAbj
         uH88lT6PNXDnJOiDouX9dWMuFJAJyVC3WVkvTT5mAyk43z5eSbFjUWxm5DzeNMvzzQXy
         USYA==
X-Forwarded-Encrypted: i=1; AJvYcCX0TvGjSw31siKAGPDaHS5jKvwW1zQde42Alq1bvj5Xkw3TECiT1qPUv8ldXf3FcCBd31W4FI1YaB2c9kIQFGbO@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/jyGzsZ+1n0M+IFu/rQ2abtgN5YM22wWDG48wZXzkCjQpysv
	UIXONRs+pUiXCmjP4mMzfyficr8roqFPjnxd6Ts9Le3cbdf8tbOvrIbUOQz6JhLjWmxxa/2ckcp
	TZMFo1Q==
X-Google-Smtp-Source: AGHT+IE01ZeBfC+uVoy8uSyATfWpgc2iMl0fBqMumClpOcR0gGEexzjcXqB7R5akVW/056emwX3JEbH44xkV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7595:be86:b969:ac41])
 (user=irogers job=sendgmr) by 2002:a0d:c687:0:b0:6e3:ce76:103f with SMTP id
 00721157ae682-6ee55cb79a4mr291297b3.6.1731625640890; Thu, 14 Nov 2024
 15:07:20 -0800 (PST)
Date: Thu, 14 Nov 2024 15:07:11 -0800
In-Reply-To: <20241114230713.330701-1-irogers@google.com>
Message-Id: <20241114230713.330701-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114230713.330701-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 1/3] perf stream: Use evsel rather than evsel->idx
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An evsel idx may not be stable due to sorting, evlist removal,
etc. Avoid use of the idx where the evsel itself can be used to avoid
these problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c |  4 ++--
 tools/perf/util/stream.c  |  7 +++----
 tools/perf/util/stream.h  | 10 +++++-----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 82fb7773e03e..f72c791dada4 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1019,12 +1019,12 @@ static int process_base_stream(struct data__file *data_base,
 			continue;
 
 		es_base = evsel_streams__entry(data_base->evlist_streams,
-					       evsel_base->core.idx);
+					       evsel_base);
 		if (!es_base)
 			return -1;
 
 		es_pair = evsel_streams__entry(data_pair->evlist_streams,
-					       evsel_pair->core.idx);
+					       evsel_pair);
 		if (!es_pair)
 			return -1;
 
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 545e44981a27..3de4a6130853 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -52,7 +52,6 @@ static struct evlist_streams *evlist_streams__new(int nr_evsel,
 			goto err;
 
 		s->nr_streams_max = nr_streams_max;
-		s->evsel_idx = -1;
 	}
 
 	els->ev_streams = es;
@@ -139,7 +138,7 @@ static int evlist__init_callchain_streams(struct evlist *evlist,
 
 		hists__output_resort(hists, NULL);
 		init_hot_callchain(hists, &es[i]);
-		es[i].evsel_idx = pos->core.idx;
+		es[i].evsel = pos;
 		i++;
 	}
 
@@ -166,12 +165,12 @@ struct evlist_streams *evlist__create_streams(struct evlist *evlist,
 }
 
 struct evsel_streams *evsel_streams__entry(struct evlist_streams *els,
-					   int evsel_idx)
+					   const struct evsel *evsel)
 {
 	struct evsel_streams *es = els->ev_streams;
 
 	for (int i = 0; i < els->nr_evsel; i++) {
-		if (es[i].evsel_idx == evsel_idx)
+		if (es[i].evsel == evsel)
 			return &es[i];
 	}
 
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index bee768874fea..50f7e6e04982 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -2,7 +2,9 @@
 #ifndef __PERF_STREAM_H
 #define __PERF_STREAM_H
 
-#include "callchain.h"
+struct callchain_node;
+struct evlist;
+struct evsel;
 
 struct stream {
 	struct callchain_node	*cnode;
@@ -11,9 +13,9 @@ struct stream {
 
 struct evsel_streams {
 	struct stream		*streams;
+	const struct evsel	*evsel;
 	int			nr_streams_max;
 	int			nr_streams;
-	int			evsel_idx;
 	u64			streams_hits;
 };
 
@@ -22,15 +24,13 @@ struct evlist_streams {
 	int			nr_evsel;
 };
 
-struct evlist;
-
 void evlist_streams__delete(struct evlist_streams *els);
 
 struct evlist_streams *evlist__create_streams(struct evlist *evlist,
 					      int nr_streams_max);
 
 struct evsel_streams *evsel_streams__entry(struct evlist_streams *els,
-					   int evsel_idx);
+					   const struct evsel *evsel);
 
 void evsel_streams__match(struct evsel_streams *es_base,
 			  struct evsel_streams *es_pair);
-- 
2.47.0.338.g60cca15819-goog

