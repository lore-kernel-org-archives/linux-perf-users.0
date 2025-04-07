Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC5224240
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002086; cv=none; b=mKo6cA/fnpn8tqbeDAgj18WeRzPkmXVQ9jlFIOJF7H9gqyKriurqR6ZKeaN9zeMDPErCEh/6U5WKPEDOVTF1b/mU/hS3lkFaXcNSUQ9dLUu5VsslUXouiN8P2tm0BtMTIpWty+sXBK3D4xffWkUM+FqRPu02bnFloH2HhsbrqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002086; c=relaxed/simple;
	bh=6EEZTd9lf9aeTITKws4CXHLVcUfJH0Aqr7eXP+eg5Q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QLlHpzj0D8BH26TEFTXRoTuCuuyyyh8JGUPY53+l17LDdt+s9ZHT/wCKArIVee8WpQI4SVbGAEMb+iFH96gwlz8PoXlD+OMmjZCMYZD7W2eputYv0f329gml8Oy3rtv+sk4AhwRJWqpSAKu8OZu3iLWmE7v2v2Zl8Ge1eEI5hck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ydYH0lkM; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydYH0lkM"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6017ee6038aso4004730eaf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002084; x=1744606884; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=ydYH0lkMBXAVfQXp4vR7PxaJbZbktEJU2L88I7E8KaPHtvwEmqqAsogid0XL4fwKdv
         U+JDTLKZRgNE2vByMUf2jVDfsiHGgV5nwds4ieNcJqiIRZYsaLGxD4QPRjF/UT5X7rx8
         5hrMnXPEE7WUS0t+ctLxcv2V5MkZvpXlwNJF34rphm8V00BRroODXwGUaR4hbD0rXRs5
         E/bI1YCYDNV3h4QkpG2R5eb1cbv1htxYMwvf2MTeh3jgWb1Up5GBh0/qqrrzWWw5e2hU
         dpLB7tSIH2CC3Qnx3dJiDYWkEuguAg32tGF9WldO7BcRq52IKH8HWKawi8QXsEZNvNsL
         f34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002084; x=1744606884;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4eUmflRE5uebU4/SNO43FiJCwVtS3ISrTa0e4ce5bk=;
        b=Af6mZRKDeB2fR1x4bzWvRq1H7JN0YNFoWudA4nMZ+oCvjSqCW4MvMTYQC25xCZjMja
         sCqgIzconn1cwkGVmQ3YeC5V3L7Sf/PjZMNb3yiyRSUHNotHSHXQ9ljLG54UfRcomg6Y
         SvbkQB2Jndh9Bn9ULJqg5u4XPh9W76UmMVUXOh//eCDrmF6G75Bi74nsGoSupQdRC61h
         bcp8SqwvwSp3iBDkPUHYSGUWN3nfzMgxw5+JsbOYtupaZ1wpnZ6scKiFEOTOjFg2A/I1
         Z/upGaX4ReHQtBvF7Aw2YTk3lpX0+7kxDIokxhKfFcWjUqkpsMcLZU8+I0fJAqgBLF/K
         aRsw==
X-Forwarded-Encrypted: i=1; AJvYcCXubzL9hdo/CBjGMSptbHx9oYIScJWBGDI6B9e7gAYUxWTqf6NfNj0uV5GPsy/5SoEZk0a5GdaSsQ4ianD+5p8S@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6eaFwKepcKDgxIE+qzrDNe30PP7uYZxiedt6KlVOpY49rIni
	dlKuojOUyYENr3UIGEOw0lFTIe0r70Cy7Il+fs9cWak3mpwPyU8rvL1A6KWSs2Um/mqlTEYl7K7
	DzDcAlA==
X-Google-Smtp-Source: AGHT+IGfdfeZHDwYGdcI8n801pAf5P+Uopk1if+BxycztRji+1E9SmPXJxfweFzNVoVlCGV6oYhyxlAwVp1t
X-Received: from oablu21.prod.google.com ([2002:a05:6871:4315:b0:2c2:5b99:3e17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:788b:b0:2c1:539a:6071
 with SMTP id 586e51a60fabf-2cc9ef50083mr6757489fac.10.1744002084142; Sun, 06
 Apr 2025 22:01:24 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:53 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-9-irogers@google.com>
Subject: [PATCH v2 08/16] perf intel-tpebs: Ensure events are opened, factor
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

