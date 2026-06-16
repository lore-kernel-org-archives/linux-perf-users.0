Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEC37BE89
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573276; cv=none; b=nBZ0TpDab6is56BiaySWZETNBKx+7peDGLYgy1Lvaz1mF699ClO/LpdESBhqk2tp+R9ULlgNmKiKrB0DtuRNNF7ZDp3we9lioRxTCPVgu7EqZWt1TNoNha9RPHzd8lRykjqFAnyYP7QBHWUUCG4VWkXrHqeS6heJ6w+p2FR6cdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573276; c=relaxed/simple;
	bh=sPYzRjbpTmYh6WnA/XVL9tykD0oj/aKMXc8GjK3UNnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BU+r1Wy9ES9J8jKGbQYzBlkEmZm4JYwhhY4ugmEHpnH2ObwCM2e2289L5MMcE6DIbRqwZc4VlA7fBLaQ6GAB1YGWCW0VCyO8yGOk4YGWjDWvqbP/71FGLsoPL1QQl6JBtgXNY/6pyhX8gWgnXbkPOJGKxhHa5m/oISi5S2xMPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qp9CRwWe; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qp9CRwWe"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30761ab3483so865849eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573275; x=1782178075; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0Xw2oqgt5kvzYUTl6pa4eK8iujXfqPpa8YiWPPWKQs=;
        b=Qp9CRwWeTT12DVNGqR3iwnW+r9xqmmBseI6I+EMQqOusCO455faNenYZyrxISpzt1n
         03HStyXtQVOPU3mB2PwB/VgDCGHPEmfaPWEuto2LsQLpArLDox1oxB9FKbeuQEooI3UR
         J2pdslwafaxFCIe1JbWyQfBO3uJmxgiQf6Xl/MTZq788GjKUjdOgYIJeL1XKW7fgO4qP
         0v4UuElVIdsfbzRIT5ICLdhWJjvzTXqK9a6xgUj5yDT3PExqdWqQHRh6AMoQq3ZPw1fG
         6caJnxHouTRDfFn+lh7sB8KRqudE2bNC0BA8eiwDeKpizf7AeYoiunWguvaRfQdyMgRz
         A3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573275; x=1782178075;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0Xw2oqgt5kvzYUTl6pa4eK8iujXfqPpa8YiWPPWKQs=;
        b=FDlH0f+PS2tSfLeX+S/AX7cqSU4Vq4hVP7kCpgfKgnlsjc+pdmrQ9ONLCp12nkWyCc
         jcLFjUmOIIhQpcZJjZWrcvQqvAzfufKTlSED0KHrf/iB/XTeSu+A8Z92xrbK8yBlO2bB
         vfb8iidF2y10ycmGfb7S8+eLyWMlTwXSkaEPCSZW7jY9Qc0hWMWSLt0ZCpKOJR8SVvY8
         2MJzJg1zi4ys0kDfInmh3zRl3sgCMLIH3olMINhsz9NtuPvdu2tmjXX2nyGp4chZUVYV
         RCgnJs0DI54YVV+Kqgq56I+mIkiI655JpmayoMY0dQ4WbskPCDgim0HG2CjBuB7aDENJ
         CSFA==
X-Forwarded-Encrypted: i=1; AFNElJ92cv+AVB7HNX226Af/sjmepi00wNDImeDz0SziEuSAj1AamcuReiMdwHACydx+wVeplAffIvYfayFAKa6ZHAaX@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9MJVTMek1010tUq4eR8aL6QYexuSnhUBSRsJeMFKPkqGUpvg
	yLN98mMryaUnXdkc3sxDkaIP5YzoZAFnBvWaQ/KHvaQefF5HGcXZEEcoTuEtgcC5laB68aGCTB/
	Eyoh73HVxrA==
X-Received: from dybtk5.prod.google.com ([2002:a05:7300:d945:b0:307:34ee:a27b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:691e:b0:306:f474:7389
 with SMTP id 5a478bee46e88-30ba5fe212amr970853eec.25.1781573274216; Mon, 15
 Jun 2026 18:27:54 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:35 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-4-irogers@google.com>
Subject: [PATCH v1 03/12] perf tests workloads: Support sub-second durations
 in noploop and thloop
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, the noploop and thloop workloads only support sleep durations
in integer seconds because they parse the argument using atoi() and use
alarm() for timer signaling.

To support much shorter execution times in tests (speeding up test suites
and allowing faster retries), change the input parsing to use atof() for
double floating-point seconds. Use ualarm() for fractional durations less
than 1.0 seconds, and fall back to alarm() for durations of 1.0 second or more.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/workloads/noploop.c | 15 ++++++++++++---
 tools/perf/tests/workloads/thloop.c  | 14 +++++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
index 656e472e6188..3fcba5ceaa3d 100644
--- a/tools/perf/tests/workloads/noploop.c
+++ b/tools/perf/tests/workloads/noploop.c
@@ -15,15 +15,24 @@ static void sighandler(int sig __maybe_unused)
 
 static int noploop(int argc, const char **argv)
 {
-	int sec = 1;
+	double sec = 1.0;
 
 	pthread_setname_np(pthread_self(), "perf-noploop");
 	if (argc > 0)
-		sec = atoi(argv[0]);
+		sec = atof(argv[0]);
+
+	if (sec <= 0.0) {
+		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);
+		return 1;
+	}
 
 	signal(SIGINT, sighandler);
 	signal(SIGALRM, sighandler);
-	alarm(sec);
+
+	if (sec < 1.0)
+		ualarm((useconds_t)(sec * 1000000.0), 0);
+	else
+		alarm((unsigned int)sec);
 
 	while (!done)
 		continue;
diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index bd8168f883fb..bed3047fe9c2 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -31,14 +31,15 @@ static void *thfunc(void *arg)
 
 static int thloop(int argc, const char **argv)
 {
-	int nt = 2, sec = 1, err = 1;
+	int nt = 2, err = 1;
+	double sec = 1.0;
 	pthread_t *thread_list = NULL;
 
 	if (argc > 0)
-		sec = atoi(argv[0]);
+		sec = atof(argv[0]);
 
-	if (sec <= 0) {
-		fprintf(stderr, "Error: seconds (%d) must be >= 1\n", sec);
+	if (sec <= 0.0) {
+		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);
 		return 1;
 	}
 
@@ -67,7 +68,10 @@ static int thloop(int argc, const char **argv)
 			goto out;
 		}
 	}
-	alarm(sec);
+	if (sec < 1.0)
+		ualarm((useconds_t)(sec * 1000000.0), 0);
+	else
+		alarm((unsigned int)sec);
 	test_loop();
 	err = 0;
 out:
-- 
2.54.0.1136.gdb2ca164c4-goog

