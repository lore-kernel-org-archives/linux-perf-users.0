Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40434179BC
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518860; cv=none; b=WpefqWfjTPt7dUA/K9LANYes1kqSg3yaCBLRx1vskRxyB/6HGzEojW9bS2qLEZtNQwOwnHdIQTrgWDRQ+zLJVfxKO+n0JfCkzdUkqLpesIWCotfuw9yYnQE9CIweG96YZwO3ZO0XjaVLH0W/YHyMI/QEEArvHyQZ8FNPqOnIC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518860; c=relaxed/simple;
	bh=1azV7E7FNm5ZgpAvEIdQ64JI8F44TJjzhA8h4p43pa4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EgWWASYtkK0YeBXML/G5QrnfmLOozPw81lYYEs6+4siXy7td9kE46ncuuC5aQIWu9nNeYuBT9X6lFzZAmX6XNP8aSnOuMk8BGBMad7xX2n7Z0UeP+xOEReFLHmlyMHglOZd43jOE9MvTLObw+H+6QrtEeQyOne5lGka6Ruwzwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGieEpAe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGieEpAe"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2b049b64aso7618097b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518858; x=1729123658; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=RGieEpAeKcEcm6ar4g37YNJ/+hhVQQ0v3QKEwbfxT8cIWzdyxPoT26P0C1LeU4FduR
         WbTetQ/hPDeLAbICJAYajGrcMQOnObKJDH7RJP6xoj+xDBYUdn9cx5ES+8mP/6Gxi381
         6gdmGWEf35S3kdjQXWgOQZrkhVjXBNnfsiOQZ8vGbMPJBU4qdCiW17YPOJk+EfjofJV7
         RYrfijZFmSKA3z+Ef6XRancPQgCqFUz8Jw6G2oK9KZdvA6RkfOOvPwTbmipNxdfWXiqQ
         g4szAFyUa/YjFApEnrYqsf+EQqwCU5dsqliDnNoSRN2HaW0FNkBnafsfTCXGPM0BGdRT
         3g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518858; x=1729123658;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=xHVXfSeBlYy2K+OAHCZbp6LaJZ2aghQ9rls8Eq7AZbbJVmlam/vyNUqBcR4uQXZyci
         WmMxlHdYUqdie5ks5ZyWiG9XQe6yFUK0dnmRTqfsLL+xGTLkvoj+6rK35E17QspXCcCr
         2t/m7iKa+0eFaZvbCJhxd+FHED2PLKa3yJaUtBqihdulcI4A8d7CksjwO8kkHC/IEs7S
         vFcM1+MeBQfD04QEt/R4F0FA71H24Yu85tEkKF/8amF9y08cOnub2fxLkRs1FVhpa5Xy
         Rknn6HOpYW7I+njIP/CIA7VQt2yUXrPPX0tRQIGaaBo/LM8b6e5IZmXOkkEvWbNCrpag
         ZT3g==
X-Forwarded-Encrypted: i=1; AJvYcCVx0e7cpexcypHQAhZCY+67pQ63nDyaTKIK8gL8dq8AgTcWGBYnN3wyjulH11dIg3F0C4aMz1GVhwfW9Yt9c9VT@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpleR/6abOCzpOnwNcpdbdvdXuX2LJvkiUxMyAAocbjAmbu24
	NB1iPU94WSH3mmolhIgUfDm2TotKUG3h+ai/sYsP5i5S1rBPN0cRtaCRYIHDskC6tvKBG+lmGqI
	ImwQHOQ==
X-Google-Smtp-Source: AGHT+IHNoxyro9XdhuFfsc7bf+vWfsjYtcZE7l/ylvctEy37DlR4T6Q+7ItK2XwAF8/IOsc1WpU2LePV/ENR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a87:b0:6e2:70e:e82e with SMTP id
 00721157ae682-6e3224227fcmr167887b3.6.1728518858075; Wed, 09 Oct 2024
 17:07:38 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:07:17 -0700
In-Reply-To: <20241010000719.1172854-1-irogers@google.com>
Message-Id: <20241010000719.1172854-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010000719.1172854-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 4/6] perf stat: Drop metric-unit if unit is NULL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid cases like:
```
$ perf stat -a -M topdownl1 -j -I 1000
...
{"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit" : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-running" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
...
```

If there is no unit then drop the metric-value too as:
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e392ee5efb45..6bb048fefe9d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -470,8 +470,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (unit)
+		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.rc1.288.g06298d1525-goog

