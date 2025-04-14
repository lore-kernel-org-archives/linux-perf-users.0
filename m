Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13628F507
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652534; cv=none; b=gLlbSxbXYdhxUWAJNUMGtOTfbuBA6UyuD67UJR2VCYiDfMFyZuX/9Toq95YIrc8/AH+GBqhkEk/jBeFgOagQpJZsKlM1P3kkrZC4B0zuAgcfi66ioxOeU5m9WFDpmTAJQ3sZrOAS/a3eA3eqDB8vOUBc6folZ/Nyb0CzSKp8OHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652534; c=relaxed/simple;
	bh=5clFH5cBbA9DkiIJRGFWXyQBekw3Gsouq1gTcIF6OIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZsYbqS2QVM1FM09/2sH4u8VMEIX/YnaCPhh2n3WZMjnY+BYopmWWpLX2BU2HYdakceQnz63i/OGP/LMXPen3aT96dM/XTOAl6Oacd9Wg77+CS1q58uXppoGg5YVaJyaj2+w51M+KNx78PgfGyu7nVZZ1O+wIXmdShGFxWfOJvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8Aac6ut; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8Aac6ut"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240c997059so53067205ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652531; x=1745257331; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2H/tpH/91QrndnjLgNTFU53UhH+5V7b1PzR5S5R0EcM=;
        b=r8Aac6utzPDOKuLGbT0KWcn/7v919Tyt8kEfjkft3La72vw2HJlHQhlQlPUwYr+zp+
         kXvE7ZInrur3GoBZ+ZKFC0e9ziqDNWpd4dDefFY7ge1nOanutzK/0n2Yml5dc3fZ0H3w
         aOEz0Pd4LUGCXpZWKu50zUzq3SRXIETN5zHyYYSX2V7Mmb1ofJqBGw6j3pvxYjDBJ9Fc
         L8x4DMgzXG9Qsu3vs9ewhA7URHh63vWwk2slQF7wiGTdGr+rENQdYD/HJV0kW1pmkWAb
         dWtkQXLEULooEUvIz+Znvt4zbAOxKZsgTpN8WGO4+VoQLfZvMoZX9wdCivDMAN41WveH
         2/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652531; x=1745257331;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2H/tpH/91QrndnjLgNTFU53UhH+5V7b1PzR5S5R0EcM=;
        b=u3BQkCO05oeK4DHu51xYZ0Y2yCvZphnvF9ImVI4yDISAC5lEVb/3NfUe14Efcm6JAO
         lPst0pPt2CEonzs+aRLjIVtRbUDrHX95SjrDcXbK6ypID06MHd5cMaxOnh0I1o18IV5w
         ZRf0vvVHRIfECPrFAYqvOgg6MBlCx2newwNF4/0fD0sixSvLZyMy1Q9KnGOY7Kn5jn47
         6GAt1Fjm4LriX4xvL6BPH6/11UNdEl/JbHQizKpsn30L7T2Ojp2nLjdjPV/wswuTBc6Q
         Y3BXOBj52khDXveZBB+9BWNLqLlg28juZuR1d81K/7h9ZFrlbWiX2y0H41FIVL058Ccg
         WB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5oPRo8rtjG/vgNyN79x8ewwcILeNuHY45VtO7l63U4ZuzY0hc9X/aZ0CrUDFHEwqD15FAD4+Nu3OzFqSbIBr9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2sURvg8MSaUbUe0bdH6McvUVZqs4hOgJj0IPJUDMUo7T2Hwf
	QE3wGT8+vgEA0pQhSQzsxHhHLGZCEfXD6aJ5MbOcSyHdtnBsfUdrBMRfuhbVx3+cC/1HbexOTIu
	kc5jL5Q==
X-Google-Smtp-Source: AGHT+IGxaixyz+5/bRId9UGgT/WpZ2tOtE4HFXXb6ZT+XhmhnXMMxhswPag0zV/Fr6Kb+wIMZNm0WsyOIfnb
X-Received: from plbba6.prod.google.com ([2002:a17:902:7206:b0:21f:b748:a1c8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54b:b0:224:24d3:6103
 with SMTP id d9443c01a7336-22bea4efe70mr190994685ad.35.1744652531685; Mon, 14
 Apr 2025 10:42:11 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:26 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-9-irogers@google.com>
Subject: [PATCH v5 08/16] perf intel-tpebs: Ensure events are opened, factor
 out finding
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Factor out finding an tpebs_retire_lat from an evsel. Don't blindly
return when ignoring an open request, which happens after the first
open request, ensure the event was started on a fork of perf record.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog

