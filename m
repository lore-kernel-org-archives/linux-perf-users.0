Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F79158A31
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085295; cv=none; b=kIM3TLFhO7vtz20VOyS0C9geunoGpETRgyVG/WH2/g2Tf2HJ/sbgqyj3niUpFDRMBKp2Gy6bvWNsFO0VaDK5UaKPJONbB9juI0fufXSU+MItcXc9AQ6EEN6uY4o6j3qvz2NrXjUMNXiz6wwYxR9pzOd+e+RKiW8hxSRXzD/fa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085295; c=relaxed/simple;
	bh=WH6U5UKcSxKz080nFhPzA6BhGHtiiakcmSbMwKhmscg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cEf73c1Nqr9dK8Iu7eBmG7EgrCuTxX6UVW49q20/0UVuzNFiAxN/Mk1L0kgiRmiYz1vFVst4eqqg0pEFn5mjtIqpQNPzFPA6w5Hk8ZBmJsA7P1FCshyTHdSl/VqE2ovRNzpofSQOZX6Eu9ip5aiVEFaPJxZEYMWcdl//lD97dFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPrmzqT0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPrmzqT0"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28694ff555so4271136276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085293; x=1728690093; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbHvBR/EzAqjLypHxbH5hOAD+Tff2Cbq3GElgEXpZ6I=;
        b=vPrmzqT0DMXQTv2hokqIuAxiwMTUWb3vr1SsUTyRyZgBti4/SiEv1rg9BAn2cOUPLn
         pE3QQaNWr+gRBzaj8xlBPfWSQpRieXD5ygKYrQwjaZ9Jd/6wmCHAtaRSEfJh9+t10SJ+
         tm2hiCatqyYgOF3Swa4/HPAxkxgtJh5b8Vkzku2VFkYp7YajWZJw0x6VqHSfWijGt0RJ
         P07kiUxvWTesmQS8EGMYFDwLT8oekUB/ZKOB/E70jHVRkE5qicM7TG+Ap7HMTF6lWMGN
         FvksCBc9IrhoolzEe8YN9sG/DWxg4AeTR443pun/HubifWOhSO2MFhr+bhAdTKoSkmkd
         4nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085293; x=1728690093;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbHvBR/EzAqjLypHxbH5hOAD+Tff2Cbq3GElgEXpZ6I=;
        b=RgurKBEbhGBgup2Z9REG+S2X4lBuM4AKTxeFNJgQow7idv12UoyZq1RstKDxiSeB4u
         KFKTnzoNEHAXZWI0YsbUq1zMTfK29x3vJmGzER1hiiyzXokcCJjueeGbVCOevsQTISrS
         5+8qqKKp0MnY+8chMB+vlnMQ+Pt/ARgt3ifCDkZG85tVOpFWkqNV6xQGsLMWWL6MXJXs
         Eq+jH0eLPd0uqOBX7T7grfr4xiiFBi6XjK3Rvbc6srpz6mpB2n6beER9fRfi4GC6Oyga
         CdDt5oUH8Pm4ZloUuFnNY8VWhAM8r4FnCq0EqCs1qqauI3itrX+S/xNUU2Uu/wb66qUm
         Eh/A==
X-Forwarded-Encrypted: i=1; AJvYcCUg+fyQV/0gAIPGoKevAJUjg9CXKUEz32VMgPJWcy6L4b0wTST9ep6JaqPQAvch6zYqQN7sLRjRCy5BaEeURKp2@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmofY2eD49L1miP4EUohbMHbrLEJIN8PuKRc8Bzv1MWeL0kxY
	X6j9F5xekznAJ2n5KU7ZuxvDo/ihUv3GzvBqOnzeFZDYt1zQseZTC5DSHJc1m9x1AFFCVwIkfB0
	cRet6bA==
X-Google-Smtp-Source: AGHT+IH22Jbpim2TnHZNa9RN1uITcqq/n+FuZ5urdZ2d5c5YMlnYHZNc5wFzlIOwE/NB2tBENvRcUrdAHqAL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:6908:0:b0:e22:624b:aea2 with SMTP id
 3f1490d57ef6-e28934fc7a7mr3438276.0.1728085292542; Fri, 04 Oct 2024 16:41:32
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:16 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 4/8] perf stat: Drop metric-unit if unit is NULL
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e392ee5efb45..9b65968e37d1 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -470,8 +470,9 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	fprintf(out, "\"metric-value\" : \"%f\"", val);
+	if (unit)
+		fprintf(out, ", \"metric-unit\" : \"%s\"", unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog

