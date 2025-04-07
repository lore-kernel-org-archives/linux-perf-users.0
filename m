Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB04221569
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002082; cv=none; b=r66gEPd1dVA41b1T1SabZBKGgNrpeWr3m/SlE9r3ZYNP7eCGIlm8JGUsdeIAXXY7ryRd+x18qC2JTlSXxrDyzW4lj6J04tYSFHaKZpx65peRg40ieuSPez3mm5ShOy4/yEZNEo/bN0oRvCGhs6rvHexGfxqnW/XsVG4a0zB8syM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002082; c=relaxed/simple;
	bh=uzrqNAXM/KeEjp8qWr6xTf3VLWW7e0MNaK/cvBjUNjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M2DvU42Y3CudUL1zpqms/IL8JVQmr0Ri9AwIUfRnfMFsgYdluWZDKZXgsVlQSDkNpIybQ0+ZzhU9WmIs7mzCZIBQ1GSnY474/KIQCYxvBgqvN90fOe9xBQdYnBraZsfPOGnAjnzAdE6/dlUwFCgq5wPtkp4uF6lerr5d+3aICd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTvnBtMd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTvnBtMd"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so3705359a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002080; x=1744606880; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=cTvnBtMd2pCzZMYgbDbOFBMH53bcb3oZgfT1Q/FjpLlot9mZwTf4C1BmmhPx0hnAo1
         FlIiD3+OfXicErPm6ayesfD5cMWAE6RJSQxon2hmd984XnVCGcjmi0WTSqmF1xDZ1DXV
         cI+eruNWjKbAoff6hcIBOZcrx6mnxJy9iB9Rf/rFA861IjGEN+qIJml+pVZEhEBsbRuG
         uL1aWTsJG+L5p7WHge2HLwMpilzFbOatmp96ZVMas+/ShIwNWvraEen9UEpTSN3+6Qis
         85X6DZg9WavDPC+Fdw6j+uy1yEY783tztK2AGMOks/waC4Km/qnbyoHzhWoxHzk/yIDW
         wfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002080; x=1744606880;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=YVhlQAFO7Opu1PuYNNldsBnei5V75v6R7N1Pa2GZRh6dlSSellZXNYGOR9KKj4rjsZ
         9Otud8vBtNV9vRQujVAZDbeiHCi01901zrGy1QaBTSZ7aDMLGXsp9Gc4Bq6Uklps7hgx
         aFyYkyH1YQZ3qyn639oa/jOS/cpipdRfX1Mx2WllLl8QLvClzBuFcCTRzYxTgJSbv3ZD
         LcEXZ7z7twgLAvVNYP4aLDSsEJ6wHwUkcbpcR/Z9nKsM/GHgyzEn2j/vtHuVZhWarSjn
         tYsKrqoRYlvWXs8ujmERSKj8th4rqdiAxfcHAutJLeYcZx6qVzkUj7SbRImQhjy699sy
         dcTg==
X-Forwarded-Encrypted: i=1; AJvYcCVyLM0WotzNfSXV/wtPzTJwPbTyvzn6906YrI5s/zJvhCMOHMgtIkLjPute2GmbZBokMGimWVhvJdI0DVb/Gzbd@vger.kernel.org
X-Gm-Message-State: AOJu0YzBf1kdVS6CKsQCrTiddON3Eqf3nkyrS9Otz8StPqCNLcaGcJXj
	ML2obLErnNdbH2A29YoMgYoiQPQxQlhJLfhdiVMLv4I0i32hGDi6CDOAuTIfQbW8pPBB3jgW5Ua
	fpOs98w==
X-Google-Smtp-Source: AGHT+IGmcAVt5EMV3QErs7No50mhGib7CCW7DyRluV6DypHgyQ+07hXaXEDAfyGrowz+s51DmBz1jIqqE+KR
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:2fc:2c9c:880])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a4e:b0:2ff:6fc3:79c4
 with SMTP id 98e67ed59e1d1-306a4b70f41mr15349365a91.27.1744002080157; Sun, 06
 Apr 2025 22:01:20 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:51 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-7-irogers@google.com>
Subject: [PATCH v2 06/16] perf intel-tpebs: Reduce scope of tpebs_events_size
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

