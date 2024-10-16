Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725651D5164
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115530; cv=none; b=MrUUCR4JZETGN2JKYiWG/Bm1R7e8RHmnbUcvcEMQSbUQun6I0DKreCnWLQcgB681M4Peb55rZu7bt6Rkp9h6oSsnSsfoHqNGY7odRX6WXO/UqpIhUEhUj2+N2VEDIqN6H8TDf4l4bKkfR++n8bslzKVou0i7d6Z1ym6taU0OzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115530; c=relaxed/simple;
	bh=xxNoLSb6kFTUL1OnMX+2sTQ86EFI5XTgz4LWu0BFnc8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Tor9TWJ96G2QM+3UnYKdNNndgHKWK2pmOOUf9dryKuE1tNPtrd9DpSz7DOAUM4y0nU/KR/c+ytD3Q6ilX1CLVwkambyv6lBwTGagJ+aL6IYSpIAj67ctHvKBFPW385FRgZaq2agdj2NEgetmWSr0Pm746oySEBPDsQE58JQozxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkXn++DS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkXn++DS"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3c638cc27so8628777b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115528; x=1729720328; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PO/jFnTS1VOsCUFZImr0igUuGTgy/DTrx5IiSFpgwUc=;
        b=GkXn++DSPhaPxgg9orAmlw9FWKSHH1hNzkEZjZLQy08dQEY1uO5udxPtRI1PZ+dYu0
         z7NvNYfAYscu5UaYNHCn3Y7R/bbE3F36kJLAkGiPQosDNbkgga/YoecBHkYxikwI5/3Q
         S1erpEb7Uums1J3krqH+7fXhmsjsnxZhIRmc+nBy0wk6jBnFlD+dsPCGITU19xLrqaTy
         UwFHGYQVop3G2NB/hp2SHKh2sM7yOE4s4T+Wjuuk8eje2fSeoG7Ce8adGdkGSPucSzO3
         AlgfgZ329IROfD0QcfrHQkniORoWFUtsEctZqW2flNUTxHYa0bqUPjUg8LjkBn3bypVf
         tkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115528; x=1729720328;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PO/jFnTS1VOsCUFZImr0igUuGTgy/DTrx5IiSFpgwUc=;
        b=jrvZA+6N1z9LRo+vIVo4X7pOrDWHEygmbbFoMEbzQ2diNBWMv5FxvUO+6+6PKV6dxc
         ruTWzArBVlo0oFHyYBnwlAxOnUOa+rBix7r2RTG25RPIsYoaxY7i8ZEeonV4G1uGz9aE
         XQQ2KKuQUKdfsxDTTkCPBe+qLv8N+4mJVYCv9AJmeW9eoh8BpfQrQM6ExcDy82HxbSIu
         T/nPUhhKyNyc24vKlQUFAkL/L8EgG5NcugRgpFC/fz8twG7LCp5NQF2uppwFmBBQGrUK
         KGS5tx7A5dJAzTLDTUa6wlIw3eWtOXS/2W15mn3D58D/7nEPWwVJVzZtQ8My9P9s6c9A
         1yEg==
X-Forwarded-Encrypted: i=1; AJvYcCVvrZU38K9fY/qrgTrONBELMHQeegcX9CGG3VHGYQpoFVFpH0whp47QExxrmJSSRzx1l0r4KxFU7mHhvd1Jmy2F@vger.kernel.org
X-Gm-Message-State: AOJu0YyZl69jwTOq/964HUm5J78YaBGdUfLlWVeSXo6nmx6yEBEyyY47
	UFIZXFMUFwkgQ9KVUlUlXcFW8hraWKNPjsbVqT2E5GFhig86ZEU9NXtFiUv6gF9MrlCY2birnJX
	fnbDfyw==
X-Google-Smtp-Source: AGHT+IEZ/3okGxqKo52wIDEn7oVplnHQSqmsfGn8AYDNPEd7z/jQScRIZ0BVQENfrM+1EqkxY/OrF8JWG4El
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f11:b0:6e3:1023:3645 with SMTP
 id 00721157ae682-6e3d41ea284mr1443167b3.8.1729115528496; Wed, 16 Oct 2024
 14:52:08 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:38 -0700
In-Reply-To: <20241016215139.212939-1-irogers@google.com>
Message-Id: <20241016215139.212939-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016215139.212939-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 7/7] perf stat: Disable metric thresholds for CSV and JSON
 metric-only mode
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

These modes don't use the threshold, so don't compute it saving time
and potentially reducing events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b5e18853982c..7639ecda6c05 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2561,6 +2561,14 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.csv_output || (stat_config.metric_only && stat_config.json_output)) {
+		/*
+		 * Current CSV and metric-only JSON output doesn't display the
+		 * metric threshold so don't compute it.
+		 */
+		stat_config.metric_no_threshold = true;
+	}
+
 	if (stat_config.walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
-- 
2.47.0.105.g07ac214952-goog

