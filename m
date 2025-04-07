Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203F254AE4
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060237; cv=none; b=JRfjvBXO4yfM/5WbGLMZa4YH75CofTx5fVM2FyB2TMp5Fh2d1Bsy0haMO2WLtQprCPHmX2dJlz5y3dRsPx9PEI7IQBitPgZYlqAUzrgMYBHdIKMGHTZf36jOkk8rwloBtYbtj2zfQLuos+V98XBD0ThGTFOP0ynnp1qYBlLNWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060237; c=relaxed/simple;
	bh=6EEZTd9lf9aeTITKws4CXHLVcUfJH0Aqr7eXP+eg5Q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ejZWGEhHbFGOcn4DlXR0cgVrE52HzAYePxXufi8pxXZdHwft9riaN3pXGNVLCbXhNH8sqRLPJZavdu31lRFOh/ip7R3UCOsTlniTOn8IZaX13I8MR3sMVdOgvI9HjXW3kCZ0XdN7CbdbCRjpkLf9wgVuQU1F+SPf+wUgvho888c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0ZdOWDY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0ZdOWDY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso6805465b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060235; x=1744665035; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=b0ZdOWDYPzkKlLBSwuPn98o9jZQxubFiLbREpnTjOoNZyWrPhzmFJJd7vboG48wi+3
         F+vU6GoDAp/mMNSJi3r88OHFCREUMRAbWCmUA76aaW2IaLpUSLBrZoxKJTDGMIJv3QeZ
         7j3/naKX9qQcl+uI2Xt8UCiN4+nkiPtjrH7+4ZW2WMKBs3teWk/qTL3rm/p6NB/kZaqK
         UQ24uEPIwnOasz86px5ugdD8iOEEsULBODJ0lzZcgU51A9z2UXEEKSbnBwpTwyJY7vgB
         pj2B2/VgV/4JcbgkSV4zGuo2u2MUDyl3sjd/4r+yeAAQHILwSyJ75uqLnPsTfV/PS4rp
         xyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060235; x=1744665035;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=Dfe0L1aTBNFog8Hr0hM/niZbSC4zQpRYnGfJc0ZJQn9E8pePFhRVFkKbzmboEwRuXz
         az5161CHkoOGllWRZchHXSS6iUPNkkxvYIAqt59+H+f9vIb79//yfqYSirogyY7wDLyU
         y4ia69iUK0TtAK4b9u6j5zsoKq4mh0muS0Cf+XAAw0Ji6vOcSrtMTemFAeydvpidMEe2
         X6OS1C/d6KIDkrJBGToaenKZ3KnqgUUR0wElvvh138YVcqWpXzRxraPxIj2PqMt9iwMt
         MpRDTg0nxyg9JvrTTzWNbmA6VBhDiKkS5JZ2FCt5RIszT7l34Miun8WzBXpcjLlaBEOD
         fXNg==
X-Forwarded-Encrypted: i=1; AJvYcCWoYwP2jy5fbBgLQ550MGtwh5XQ04Ta2KWaQ26CGLFVm/uTEkSFNDlDgzIIS+GyCG0FPmCwSq7aYb8FVQonel2s@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sG0xaxmPQhP+XHshWtpiMXL5xSr7iCwkRs2Dc/VPRJma8Xix
	DVYsGj3Tv3jJalzUf42AZB996Le2qKAMvhJdyndFxJm93LLWjCXbZGStTuiD1q6KPjcOzST37df
	wVqfOww==
X-Google-Smtp-Source: AGHT+IG2gReaDEhE7AblA2Y3U9htDI7NfqmCOk34FgpaGt3QgefP3GK+JbE++vQfUPtqb40kDnRoF1PxAKTC
X-Received: from pgbgb3.prod.google.com ([2002:a05:6a02:4b43:b0:af9:1196:c39c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c896:b0:1f5:889c:3cbd
 with SMTP id adf61e73a8af0-20113d5539amr17830240637.35.1744060234905; Mon, 07
 Apr 2025 14:10:34 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:29 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-9-irogers@google.com>
Subject: [PATCH v3 08/16] perf intel-tpebs: Ensure events are opened, factor
 out finding
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

Factor out finding an tpebs_retire_lat from an evsel. Don't blindly
return when ignoring an open request, which happens after the first
open request, ensure the event was started on a fork of perf record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 61 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index c4c818f32239..e42f3ec39a64 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -45,6 +45,8 @@ struct tpebs_retire_lat {
 	int sum;
 	/* Average of retire_latency, val = sum / count */
 	double val;
+	/* Has the event been sent to perf record? */
+	bool started;
 };
 
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
@@ -94,6 +96,9 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
 	zfree(&tpebs_cmd.argv);
+	list_for_each_entry(t, &tpebs_results, nd)
+		t->started = true;
+
 	return ret;
 }
 
@@ -214,6 +219,19 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 	return result;
 }
 
+static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
+{
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, &tpebs_results, nd) {
+		if (t->tpebs_name == evsel->name ||
+		    !strcmp(t->tpebs_name, evsel->name) ||
+		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id)))
+			return t;
+	}
+	return NULL;
+}
+
 /**
  * evsel__tpebs_prepare - create tpebs data structures ready for opening.
  * @evsel: retire_latency evsel, all evsels on its list will be prepared.
@@ -221,16 +239,11 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 static int evsel__tpebs_prepare(struct evsel *evsel)
 {
 	struct evsel *pos;
-	struct tpebs_retire_lat *tpebs_event;
-
-	list_for_each_entry(tpebs_event, &tpebs_results, nd) {
-		if (!strcmp(tpebs_event->tpebs_name, evsel->name)) {
-			/*
-			 * evsel, or an identically named one, was already
-			 * prepared.
-			 */
-			return 0;
-		}
+	struct tpebs_retire_lat *tpebs_event = tpebs_retire_lat__find(evsel);
+
+	if (tpebs_event) {
+		/* evsel, or an identically named one, was already prepared. */
+		return 0;
 	}
 	tpebs_event = tpebs_retire_lat__new(evsel);
 	if (!tpebs_event)
@@ -262,12 +275,19 @@ int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret;
 
-	/*
-	 * We should only run tpebs_start when tpebs_recording is enabled.
-	 * And we should only run it once with all the required events.
-	 */
-	if (tpebs_cmd.pid != 0 || !tpebs_recording)
+	/* We should only run tpebs_start when tpebs_recording is enabled. */
+	if (!tpebs_recording)
 		return 0;
+	/* Only start the events once. */
+	if (tpebs_cmd.pid != 0) {
+		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
+
+		if (!t || !t->started) {
+			/* Fail, as the event wasn't started. */
+			return -EBUSY;
+		}
+		return 0;
+	}
 
 	ret = evsel__tpebs_prepare(evsel);
 	if (ret)
@@ -352,7 +372,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 val;
-	bool found = false;
 	struct tpebs_retire_lat *t;
 	struct perf_counts_values *count;
 
@@ -367,19 +386,13 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 	tpebs_stop();
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	list_for_each_entry(t, &tpebs_results, nd) {
-		if (t->tpebs_name == evsel->name ||
-		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id))) {
-			found = true;
-			break;
-		}
-	}
+	t = tpebs_retire_lat__find(evsel);
 
 	/* Set ena and run to non-zero */
 	count->ena = count->run = 1;
 	count->lost = 0;
 
-	if (!found) {
+	if (!t) {
 		/*
 		 * Set default value or 0 when retire_latency for this event is
 		 * not found from sampling data (record_tpebs not set or 0
-- 
2.49.0.504.g3bcea36a83-goog

