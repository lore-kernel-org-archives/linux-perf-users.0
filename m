Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667B271451
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601132; cv=none; b=Xhtprtb+L95/FbRcMerxHVBeFjyZwt5WaubS1YmeEnVPDNZdA4KODekx1lt/InaIiKZnZHJ5uSU0IWzAPJDBTWYuWfqd8kOFm0jDO9+RPAlUbH2bUPPaEa8/bb+OULzxn4CoKClmtcsQez84HZPX2hWsrsmMImUCevwQsp+n/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601132; c=relaxed/simple;
	bh=kZUHpU6S8UVYRUQDdu4Y2Rk+Jy5km31ZCsLgDDgmx3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CeItpbMCga/9RatBv6WVEgmNsQIFjEDE2KNrXZpNNBqnf/HQSbzXo9S+IR/heHhrl+saFl9vJK6fqvcHuiJYHn4NauFMQWII3qB6nomwGck8yM7o998nUV8htw185/D4p8H/zYkg5Sp0XSQ8ePN3SOUQvjc+9nzTKtSnZfHlp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2oDf8trK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2oDf8trK"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77dab334f78so3853221b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601130; x=1759205930; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAneJQAQnPj35Q6fil29jmDxaONd3Bnz5JZuwitT6KQ=;
        b=2oDf8trK5Mpjy18SHbfWQQfK6Kog4/izu9Kjj4hQcpLLKJVwi/myF7kAe07RapFNw1
         +xWGRDWDhZp/+/Kd03Y8yLHPs7U2Ih521WeY7jbEUBmCdgFUZpJZYL7YBjCYhxrftZlF
         hAHYyOjvKrlCahTc8pRCek7A0x9zNM+rFOw4FVWo+o5YBTC2NgmSwgpcDcxVnptCykXj
         TzV6k2oermnv+Pt+sZNB4MH+/tVix9us0ccYxdBXvKG9spHYa6INOXj2NzTtoHmPOgD9
         ODq5sKhcZ8a6z1I7Gms2ZYbm2phEdFRAt+muX/KIf3e/m46IMIuBDSGVuilSRilqgZVS
         dZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601130; x=1759205930;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAneJQAQnPj35Q6fil29jmDxaONd3Bnz5JZuwitT6KQ=;
        b=wb7VS4nptMt++ax88xqxgcaB0HEK4c6boX/zk0jrMIJI8L7U1/KA554PVNK2KcGY4p
         PDfJChCySpEwFgu+ltSGxIotZ2r1AFgz3puUf4R6uC2gfIrD3PI5SKFVJujwIP/lvdGS
         q3+4qimLTXmzEhhZ7sXnLMIm+vmyPbY8fzpKOdr9kECcvkPlpFSi9leZtEzgj6SA5ZIY
         qUrqbsjul0D15yk1x0sjxSqnyP9IH6iM3NNIzGF6nfC40bYEMtufos9/In3Fq1Br4gZe
         oDMSAPN6Ra8nvVYrOGOHBh4cJpjDn60DPcxuN/opVbDFY5Iy+H5ni7Ouh+eu/TfLMEwJ
         ZTrg==
X-Forwarded-Encrypted: i=1; AJvYcCU4C9z6s0G+WMlc1vu/hKADJaz/dS8Pr+A3OYkzSQtojzBsrhrazf5i968kTwOhGnB5E4MG8/eeyuLItJo/5d3Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lr4Q1Es1i4n6h7Dkgm9uxP1BdW4RNpVFMZXWo6wG8kBTr/37
	jHAnK5qqIcWa+og3AvNCS+XIpwZI1g+ifX2j7bb+lO/uOyC6Yv5n2fEsSe16yF1gz25GHWOowvS
	hgSsSVj1OxQ==
X-Google-Smtp-Source: AGHT+IF6cYJDVK0H1bznB4eKbhN5Iu7fH1Fhc2pqoTFchudp7dMnQGWMpjFfFdl4jZSERPz88R1Nl3DJuiwZ
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:b4e:3302:ce42])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9990:b0:246:354:e0ff
 with SMTP id adf61e73a8af0-2cfd603fad0mr1701034637.8.1758601130012; Mon, 22
 Sep 2025 21:18:50 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:20 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-2-irogers@google.com>
Subject: [PATCH v5 01/25] perf stat: Allow retry for default events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Default events are marked skippable. Checking skippable first means
retrying and adding modifiers like exclude kernel isn't
performed. Push the skippable checking after fallbacks are tried and
avoid warning multiple times for the event.

Fixes: 9eac5612da1c ("perf stat: Don't skip failing group events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ab567919b89a..303628189004 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -616,16 +616,7 @@ enum counter_recovery {
 static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 {
 	char msg[BUFSIZ];
-
-	if (counter->skippable) {
-		if (verbose > 0) {
-			ui__warning("skipping event %s that kernel failed to open .\n",
-				    evsel__name(counter));
-		}
-		counter->supported = false;
-		counter->errored = true;
-		return COUNTER_SKIP;
-	}
+	bool warned = false;
 
 	/*
 	 * PPC returns ENXIO for HW counters until 2.6.37
@@ -635,6 +626,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
+			warned = true;
 		}
 		counter->supported = false;
 		/*
@@ -642,13 +634,15 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		 * cpu event had a problem and needs to be reexamined.
 		 */
 		counter->errored = true;
-	} else if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
+		goto skip_or_fatal;
+	}
+	if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
-		   evsel_list->core.threads &&
-		   evsel_list->core.threads->err_thread != -1) {
+	}
+	if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
+	    evsel_list->core.threads && evsel_list->core.threads->err_thread != -1) {
 		/*
 		 * For global --per-thread case, skip current
 		 * error thread.
@@ -658,15 +652,29 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 			evsel_list->core.threads->err_thread = -1;
 			return COUNTER_RETRY;
 		}
-	} else if (err == EOPNOTSUPP) {
+		goto skip_or_fatal;
+	}
+	if (err == EOPNOTSUPP) {
 		if (verbose > 0) {
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
+			warned = true;
 		}
 		counter->supported = false;
 		counter->errored = true;
 	}
 
+skip_or_fatal:
+	if (counter->skippable) {
+		if (verbose > 0 && !warned) {
+			ui__warning("skipping event %s that kernel failed to open .\n",
+				    evsel__name(counter));
+		}
+		counter->supported = false;
+		counter->errored = true;
+		return COUNTER_SKIP;
+	}
+
 	evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
-- 
2.51.0.534.gc79095c0ca-goog

