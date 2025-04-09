Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481F1DE2D7
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179065; cv=none; b=j2ivnIhQnZth5UkWsF3sB5MwFITIKfJGp1696RdMSelNy63LsTSAaarLq1eDr9tNX09CzGHvVdiSY0t/LwA1fhOGkvlY1MlONO5W0zw7J3FBSIiFjj8ZV+5XEsrHMFymyXlm0mzNHGzEjENcSWNyauLt5gn/eEZoYT2YSmI4/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179065; c=relaxed/simple;
	bh=uzrqNAXM/KeEjp8qWr6xTf3VLWW7e0MNaK/cvBjUNjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GBu1dX+ww1o7jHjVf4FF2BPbEAwZ+r0Y8L/CogHaRc4tRWbjLcAA/gUUZarw17Tj8sFvseNDFAnLhQTqccgOsowmb4y1S3BqJ/Z+H4g+dkmv7AeBA+0eQsDGy8I3s6nINlzqLDtj0gHFdiRuaIdXkH5pzXCuNMB/v3QIz3oa/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04tfdLzP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04tfdLzP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22aa75e6653so25006915ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179064; x=1744783864; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=04tfdLzPg+OYrx2Yw8YBqJUCyctuZyYvwRhqMjfU8Bsth/HilwXGitzZynMVJ9CZeJ
         oeCkjAy2vTUsahFASX7Dwe2Rf4g2C9kONn3LL5Gi2DVY4KNHP+wwNdpmKb1jbWysYK4e
         N07fmaMxq8oqScJ1MpsRO2/H5d3gYEqJIDIEE0FjvC4fv0Lm8eik9d4H++xsMU6MBzZF
         i9UjY9yCT4JmvYREIhr3juGeCw1637B8miYU/QlEl61hbyMp0rJ6t3smZQi/pUn8S8/9
         1aMI97gIMNseFdiVudjlrnXOskknxMYGEpERzsclU40sHwV+UrRCYHKNK0az3JBLh4Uu
         snZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179064; x=1744783864;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqf5UWKI2N4Og32+0x3lkK0y6IoadYAF1NX3nVy0tDA=;
        b=xEKgplZ4OzWoEPMR5lvT5nmLEdsyYcs7Y5pktR+vDU8MB3a8nlN8X8Y3qIIgkqMv6g
         92Rmg4gKXhVFA5i418xEp0LrJIRcHNjXzkCf7O21ElCBNiUy8ZcGWffdR1vxnVJ3+ST3
         9QLhxF0m6gx8k6k0y7a515+fduVGfyQZFGKv/dotPNWiX/EAP7pIviW7ZlLXzayh7Tr/
         jEHI2f+ndI4MY33m6XgHTFzxSpw7ja5wiva9qE6Ihrz/pmFIHBg/CvWAgApy1mFoEDSG
         8E67tW1iYQ9/TsRasrXzfwATBJFRHzHR1eInKSlcHpRm/fgGjkrVwvVJWfoC77Ix40W3
         97YQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4mzv/koVni3ha6YuFwCLJX18gndZ/U0pYFQyigEpu2CgswFKbez4zVuPlI7yw8sKJtQU/T2pQYHvra9vEavVj@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcFWqmmwKbMbf/DwThYp7FBoTi4g7syrLZn16BFpA54kAxOGJ
	Y5G6p2RSxZha2VWfe33kzzOqjfKZIPfH2Vl+pVKUwIq/ue70ADPAQYcyuACYeDywMWkt/w79A2a
	9rOBVYQ==
X-Google-Smtp-Source: AGHT+IGTJmhyKoOQj5ofXOm1qSdH7c8rI40Gef8T69sqKGe8/stfnPpqWWQ8Denfs/4DODYgAhfMLIhSLSVj
X-Received: from pltf12.prod.google.com ([2002:a17:902:74cc:b0:224:2ae9:b271])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2d0:b0:223:5525:6239
 with SMTP id d9443c01a7336-22ac2a1a660mr27592605ad.38.1744179063507; Tue, 08
 Apr 2025 23:11:03 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:33 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-7-irogers@google.com>
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

