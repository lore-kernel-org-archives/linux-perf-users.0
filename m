Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949A1B7E9
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511821; cv=none; b=AjGGd2acchgP+4liG9ij6ABMW0s3pbPAE9NBpfMwF2Dpfa9UoWOXJZ2ZcvtFX91bFpW8rWy4TttnRSZ1iZxyY46wVKX5GI7+ZKZ6vrZqaKvoC47ituF1SX9xAxI5AOGxfvni1YYPKOg4t6m5ZDcJ705BIvh8F63F+yocUM+cjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511821; c=relaxed/simple;
	bh=v4L2Yvy+TPTB2iQqHtTEg47KRn3FjqMxg156ChWAFME=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dxUJLFhdKn7e5DKVovvUECQ4lRR8X8eRNJv6H5L/ePNFQ3OTw7LfJGZJi7op4YfMlryJQjh2zLrgXTZzXJCv1D3M9RPiWucHnKOmJtczkkbktWBpiuQ6l1+PJDsETka1ty5O8WWaVOmfw4NaVp4GLzEPd3yjoQqQOqkVLppd+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iyt/ez/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iyt/ez/"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc7441509bdso1789880276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 12:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511819; x=1708116619; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gknoLaUB2sz5KFXkBLXORn9pUeJlqgUBUUSyFz57kQs=;
        b=0iyt/ez/4MjLd32489GYk3uUVOgqHjeKF5X618nVPzfmlb+NkyBI0PkQmB+g4+GupH
         +XIOM6NebXMjQZRRD7y/tEyWAp/WzB+lYzqdNJiN9k7S6UJIPck/zqBSNPgBdYOJrUVl
         35vgmLWgKjnE5Fx/NzXsS7PuopUgDYEwZdtrHrLDTMozkWXUpVPb03k0dKeW2dLtVfgH
         iHqH4Y1mAEA/UvflvjQoCWxI5/vDg93hPtQS/+krEBOZVoNNgUhj3RVsXxwsjVBWoSJx
         4G6EmQGl3cY6RIYvGwITZBL+RLUfNAzXdTHDcwZnOf4b4a9CjlxGpCZZOAvPc4AaXh9l
         rMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511819; x=1708116619;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gknoLaUB2sz5KFXkBLXORn9pUeJlqgUBUUSyFz57kQs=;
        b=tQAQ2FUT5cB8V5J9kDT0Z5JeRXqBwsBf1LUcxI0/BPIOKeU1hWgy4SC/UtfljL9FAC
         NewUXJaEPdV2WdoWJUlN6ldTxs4bLc/6lJ+k5wShv1uJRDTWP1bLW1I/fLlqJEgjF0Wb
         EcdCP0VsfmQkXfhDevjr4rkVrdZancXec252vRhRtRyPAdb1M4GK+AfNLl5u9d5MXEZC
         7zzR49SYVS51/6dbs4BlxgRMW8HT2w0mwbRZFLt1eI837CoWXzzwes1byOZ/nltwl2gz
         PQp3pCcDQoMruDAW8NVQpOeefOlMH2aQXwNlrzhqkhtffWIAfsr3OFQZtWdK3H+kkVcn
         H8eA==
X-Forwarded-Encrypted: i=1; AJvYcCVOCEWyVOAZ/+sDKP5isQicoRA2Senkqeyh9hxjpwTTLbDWfJOK/xZio4sn1CDO4IUwxZ/9zNlRFGUtjhP9m2/lib14/UrCCzYCqLab60IY5w==
X-Gm-Message-State: AOJu0YzUTwZAsSZbYMN0e5V3wB31GSY3V1zKXVM3uDBYB+r39LbhE1hJ
	XeXjmzasnKh3wmeyGU9oo1c/aR/uZ+/cNcfRxCBOMbIpQP2xOk1MJwxMBsqWv2fTqyQQC+U9lA3
	zcA+pmw==
X-Google-Smtp-Source: AGHT+IGEWg8J1iOGAYwp5/i/iMbjcwAa2gGukyNU06noyL1m3zapgRwM6609RJcQllvTA2fSM0tl40LH6ykJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:2201:b0:dc6:d890:1a97 with SMTP
 id dm1-20020a056902220100b00dc6d8901a97mr5150ybb.9.1707511818829; Fri, 09 Feb
 2024 12:50:18 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:47 -0800
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Message-Id: <20240209204947.3873294-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 4/4] perf metric: Don't remove scale from counts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Counts were switched from the scaled saved value form to the
aggregated count to avoid double accounting. When this happened the
removing of scaling for a count should have been removed, however, it
wasn't and this wasn't observed as it normally doesn't matter because
a counter's scale is 1. A problem was observed with RAPL events that
are scaled.

Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e31426167852..cf573ff3fa84 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -414,12 +414,7 @@ static int prepare_metric(struct evsel **metric_events,
 				val = NAN;
 				source_count = 0;
 			} else {
-				/*
-				 * If an event was scaled during stat gathering,
-				 * reverse the scale before computing the
-				 * metric.
-				 */
-				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
+				val = aggr->counts.val;
 				source_count = evsel__source_count(metric_events[i]);
 			}
 		}
-- 
2.43.0.687.g38aa6559b0-goog

