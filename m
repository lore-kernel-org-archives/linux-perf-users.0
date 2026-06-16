Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71A47A0B4
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628513; cv=none; b=Ya54wdEvIIEhAh1ww9voKeMyJjab3M8eBsYMmFIRPWGKUNKiMzHmuO8ohCIiA2V43a1pVzGzi9OClvoUjrdBIiqaxAS8Xwq1wcBBbMA7Qr9jLqmsTSamYSb8e8xFwJD4PnMlrpjj9ID9fywMhfUmFajq5XHskHJzGSIh3IsVaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628513; c=relaxed/simple;
	bh=Z1eJjbumhJa9EvDqz+ZQYDqGKgyB4pXDI6d6kWbBTRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSi1yZby/q7j8JboPFxrSR+khuXz2xUW+KkNJU4fC22e0J55G9lRaGMsbjZ8yBzm4T5gfF7NZG5sdHHlWz/DJ1UG9DRr1wxBuj6iTX3A6D5GcOqlA70HzSLuxxA9Kc5pG3PuAW+2HIGQqmcCt2N4+Awg/eeRdKZGBIlR0eM+z1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPwFsxC6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPwFsxC6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-307fd7138b1so7000186eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628511; x=1782233311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1d5y401PNNFCdF8+BK5lnYLSP8NUBaQ4PbHS+Gxyvk=;
        b=iPwFsxC6+mVPbOSRfaHDc7VdX6/TteXQpWAHYO8ZGibK22k9KwsBMXDTOjdDieypMr
         3Zen/OHvilOpfKB7hK9EjuGzavdkeBdd9jiHuT9H4P3+4CLjW0rmiNDqROyqEiNpwXQA
         5lQ2lqSCZrZPpA+HsRaDYfFghyIYcggF+787q4vfXLNTjbUSowlq1srEaPFmlad1MnoU
         Dpa0XFlPtwAQVfxlUMkCakoDYeAMuPgptcIyAWQzOFznDKKinND0TGtsle/5HIticOmD
         gOtXFMXT/dqwsEcpeJzARX9B0ZZnnKq9J+q6OHcALzPluis9BKD1UUVlxoEE497OqQQ8
         vAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628511; x=1782233311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1d5y401PNNFCdF8+BK5lnYLSP8NUBaQ4PbHS+Gxyvk=;
        b=tHO4WIe6qzbtbt7lGnr9N4Tmhx5vQUFXOYSgTojD1hypisXsyxmyYzyaO/bCNJDGeB
         gImO7nLnpXdWs8y6kohzJaDdzmCgQZ8e6HOKmmR5Ad1Hm3vUwJDosXVGUfac6OGdfpw9
         8OD8I1vgJshboaIZiG7KUCigXcfQB9i0HN7CTkjXjyaSSMnZtxZMAJF+uAmUHRtnj+Y0
         qQ855VCtxWIVU320V43q5hfqq+X5E+oJAFYOENeP9mZqbKNCwXzJ+wRpCtsER154LQvV
         cqSDX3OWFCChvDkaIrHNK/PNIw4UNyZcD5D4T+hqCv6g55I7+1mY6n/ZJxrQ5wK05CsG
         G2iQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HvCh1o+XL4QoIsIdyFgboyTA9GKMceDkGOonppDmjRLPxVU2Q2yYEJ5linIWcWRoHTpth/6VuGLu1Kt/867u+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3F0hrPwCTmGse+NiMGDbY7as4TFhn4Wxmb6jVJYVctOfjSQma
	VJszpdxMtVfmTAE9MCc4noScAMD6vxSEcSztCELA+Mbak/JZVg6bJGnjQhK4Q5OxQH1/IDYH49o
	2krhpOq/p0Q==
X-Received: from dled11-n2.prod.google.com ([2002:a05:701b:42cb:20b0:138:1652:bf26])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2902:b0:139:8172:76b2
 with SMTP id a92af1059eb24-1398172785bmr1932755c88.21.1781628510753; Tue, 16
 Jun 2026 09:48:30 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:08 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-4-irogers@google.com>
Subject: [PATCH v3 03/13] perf tests workloads: Support sub-second durations
 in noploop and thloop
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Currently, the noploop and thloop workloads only support sleep durations
in integer seconds because they parse the argument using atoi() and use
alarm() for timer signaling.

To support much shorter execution times in tests (speeding up test suites
and allowing faster retries), change the input parsing to use atof() for
double floating-point seconds. Use ualarm() for fractional durations less
than 1.0 seconds, and fall back to alarm() for durations of 1.0 second or
more.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/workloads/noploop.c | 17 ++++++++++++++---
 tools/perf/tests/workloads/thloop.c  | 16 +++++++++++-----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
index 656e472e6188..ca9f871e136f 100644
--- a/tools/perf/tests/workloads/noploop.c
+++ b/tools/perf/tests/workloads/noploop.c
@@ -15,15 +15,26 @@ static void sighandler(int sig __maybe_unused)
 
 static int noploop(int argc, const char **argv)
 {
-	int sec = 1;
+	double sec = 1.0;
 
 	pthread_setname_np(pthread_self(), "perf-noploop");
 	if (argc > 0)
-		sec = atoi(argv[0]);
+		sec = atof(argv[0]);
+
+	if (!(sec > 0.0)) {
+		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);
+		return 1;
+	}
 
 	signal(SIGINT, sighandler);
 	signal(SIGALRM, sighandler);
-	alarm(sec);
+
+	if (sec < 1.0) {
+		useconds_t usecs = (useconds_t)(sec * 1000000.0);
+
+		ualarm(usecs > 0 ? usecs : 1, 0);
+	} else
+		alarm((unsigned int)sec);
 
 	while (!done)
 		continue;
diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index bd8168f883fb..c830d739489f 100644
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
+	if (!(sec > 0.0)) {
+		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);
 		return 1;
 	}
 
@@ -67,7 +68,12 @@ static int thloop(int argc, const char **argv)
 			goto out;
 		}
 	}
-	alarm(sec);
+	if (sec < 1.0) {
+		useconds_t usecs = (useconds_t)(sec * 1000000.0);
+
+		ualarm(usecs > 0 ? usecs : 1, 0);
+	} else
+		alarm((unsigned int)sec);
 	test_loop();
 	err = 0;
 out:
-- 
2.54.0.1189.g8c84645362-goog

