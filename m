Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561073DB319
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590456; cv=none; b=AOXQUk2sGrif0We35yL8jkIGFz0cYjzJ6prVJKmNyr74y66Qr0S8B7J9AFbi2Y5P5Ov4oW5QYMxQd/wbJqBxG1aTGnxUSZS6YQGb0Vl8a93y5wmp+UEnw3li7W5Zhpuw1lHIAzmwrWPMTEc57aFWp+6kOD+7FyunUYQpMXiJ7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590456; c=relaxed/simple;
	bh=zuIWOcLpmO70PmrK0LCIAPSKEwRDbPiO6E/rXetLP0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGxbiXp9MKbh+/LaeVEGjB8mKoGaGMHff3UJO1/1Mw+Lr4qiunxmCTcBVhAIQOcPodMX3C0MIkcn4xwXWVgHRQlPiFyJU7F3mBFahKK9TgxGGkYkZrbLXOgeH5lINYswIJyl79ycbKLeT5AA8OxdcB5kaNVl+aGR1R+z9cAe/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upd/Yo9Q; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upd/Yo9Q"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30761ab3483so245799eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590454; x=1782195254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vVxS69dxoLoHg9/Ohp7m95G+LDDLgEWjofQVfqpy5s=;
        b=upd/Yo9QIHN8+JGI0xXJrl9WV3UvyW9D8XCMp4P9hRARqi0eSLYvSnNKRxBLVb8418
         xxg49FbZrIuQi1vYESDZSItOtw1Y0Z5sVFR8J9e0ryz6+Tb05JCXd2WtB9ZX/dxrq4X0
         nXVF03D4avstwTAq7adPErDO2x5mOYutFju0I5pnin3tg+lW9rVhYN7NhQQgMuRcp85A
         SmsyBor0deKdtX0rzHAt4n85f7vjZiu9aqCEmLusuLqfKpW5gm0JBkfhZ/9xZ8XMRDKU
         +JVzzlul4KRg5r83nbuskkRWNghi78JQlqWx67e38d0cS81qSrt2mbow57FbpG1q4UxD
         YSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590454; x=1782195254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vVxS69dxoLoHg9/Ohp7m95G+LDDLgEWjofQVfqpy5s=;
        b=Fa/8uKeD2x/GPOcWevzTg6/USsmqGHUVFFsAlgxglAVgivt50HdDWwTLxSwBk4/mlZ
         QUEB3hljJlPezCCzGwTiwU2SjY61PlQOJtv7lLH9wQx8DQX7gCVQT4j1/3+DY155f3Gs
         fBgDKhbumKyVYjMXG+/wDR5sBNW4jhqqTQozzrtH4JIPThwAWzwUVpum5unsnSNjizCa
         r6fvkH+8xycg1pqiGSWVKZGuLrIRDQtXU922RqyLZ0EBX6DsS25OtNwH+MRQpHE0XUim
         0Xx2TlCONGywIHFp3BUj5skCbP5aaOszLdWWsgaJO+21xoJeNt0Eda2DKdQ77imaMuzJ
         rOSA==
X-Forwarded-Encrypted: i=1; AFNElJ8MC6OJbzidJw/57JB5+ia23fUFwSvZTGRpkPpQZF0hQY/16tKxqfYCAS1KduDpeXnmbgOg5ozYH7gLkTs/gMSv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz36uI7uG2z9/Ep9uihHXARDGqFUnmzWxJtyDug0E4Po7g5teW
	DoAYZAbHy/4yPyGLIR32KIcSSjwW1nm/TWfqBYXVgm3gWB0tTsEG86Hy3tblFWiTPbyPMV9D351
	+u1XqCzPGYw==
X-Received: from dldyr9-n2.prod.google.com ([2002:a05:701b:4509:20b0:138:3595:6c48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d08:b0:138:37a6:6cff
 with SMTP id a92af1059eb24-13985d0e1cemr990402c88.0.1781590454171; Mon, 15
 Jun 2026 23:14:14 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:13:55 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-4-irogers@google.com>
Subject: [PATCH v2 03/12] perf tests workloads: Support sub-second durations
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
than 1.0 seconds, and fall back to alarm() for durations of 1.0 second or more.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/workloads/noploop.c | 17 ++++++++++++++---
 tools/perf/tests/workloads/thloop.c  | 16 +++++++++++-----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
index 656e472e6188..2a6636c020f6 100644
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
+	if (sec <= 0.0) {
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
index bd8168f883fb..cf1ad6f92509 100644
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
2.54.0.1136.gdb2ca164c4-goog

