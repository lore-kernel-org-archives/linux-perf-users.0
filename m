Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134F1E3DF2
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179069; cv=none; b=qrO3fC8iXW7j8FcLnIW8j0GyExhbUHMH2EoblP2EpzVf7Zl44v9Fgb9k1U8R3Y2O6LfmgfY/ODpGk8lkVtg66NUTmQ8DaHOPuwiEJa/H2S/vGm1/JbW+NhXlK1ei31i85D93YXI1Bb7fKvrL3Rkn4lpOJyhetxAUZMB6AzZYJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179069; c=relaxed/simple;
	bh=6EEZTd9lf9aeTITKws4CXHLVcUfJH0Aqr7eXP+eg5Q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=j1depXMHvfYBjUqw/LUxe8uXjN7sOR0JOUeoXb0psxmZS+0fhgiqrfw/rc8xFeUzv77q+j7FBEaQjhaz+3XDBK19XgFsZbHqaBRmu6CO6OcNgkKYRE6m96H69Jqk8PbK1YAwgJqMJNwQsTM/8UDyCU8dVCCuvleRrHa7Zx6WtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ha0LfPb3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ha0LfPb3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so90816485ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179067; x=1744783867; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=Ha0LfPb3kjIPBE2h+l0SwGjTbYwD/osRantbRTFcaKXcN2IXJXH+UuHTGPwqmE1sAN
         OPT9+44uNWZKPDTMGR+iq2qZUxSnUeiy739Cbp+6vYC/rdGkcG1tqEsrNpio9KdOmpM9
         iGmImQkzx2V+YscdSVADh8txgQOExCd4TJ/5frqGhRozCyJ/9M2ujMKNTY+7zOw2X9jx
         i9JBWrq1/+R4qnhy9JsKIAzzuv1xQyw0/++t0X8Gl5hnsRYHK3/uteT2dZC9ogy6tPSn
         RCAx8SmUTLOk8t399u4Iystq6x7nMiRGUfjXxFnXnN3TTE/tlu0HtsaND+zds5+DQwke
         /+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179067; x=1744783867;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=To+yFO9qnkt4KczJY/SYN20s3BM+zGwEkzmL/4BRLm+CLaxp0WF9D9AjFIARjWxRtF
         nYO/Ekkg3fwqtNzxDxpnjs6vGEITj+8HycbnDm4LtY9XSEKwAfgx9lkFYcQL7DHdA4hs
         9jRshs1kesECRM1TQL/57ycHKIYTf7QlK9invNpHHho+xC98uYQoozuo70dNQ5L8Rl4e
         Vyp4L4JrirhzJCpleRO1bwXmed3ovdmiloJm0aby3Y6sqJWA7H5e2ZYN2Is5MA/Drd2l
         DOyraeDi6w+r3d01HzXBI/T+rL4zufky84vlwxQDd0RfaPC0kC1QP30zMGQOFtQXRPTr
         4XUA==
X-Forwarded-Encrypted: i=1; AJvYcCXuntwY204dPMAhDbDyvbcNe4S7iOy/P6p2m04966A9Bo+3HdJGqPKKdpVXyivFLj87em499SZKm/KD31jeFHda@vger.kernel.org
X-Gm-Message-State: AOJu0YypENHeJ/QdOrHn83AxqRbID2e+YkqGwTGAsPXYp0xvKf3Kw/yf
	4by/fdK4i04GByfR4e8qcWUkWWtyIpBq4S5Teq8zPszjn+QUJjvfNx9M6jNSnvWMv3mUsMoqE9L
	lFVnf+g==
X-Google-Smtp-Source: AGHT+IGV2SIOtm4Sd/ugRfmKy7/RZhK8aFGnp7ffz5MI2gMIKEoBwi3D2d0ZLkxtbbOLymHM0N6z9CAq29kU
X-Received: from plth11.prod.google.com ([2002:a17:902:704b:b0:220:e84e:350c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0e:b0:21f:c67:a68a
 with SMTP id d9443c01a7336-22ac3f9d5a3mr25229815ad.31.1744179067271; Tue, 08
 Apr 2025 23:11:07 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:35 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-9-irogers@google.com>
Subject: [PATCH v4 08/16] perf intel-tpebs: Ensure events are opened, factor
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

