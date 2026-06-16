Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334A379C28
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573145; cv=none; b=jrVjzzrwm6MoNUX98Q1NVuhzH16/7DZPNJLA8w7CtY6bZzl+oOI6DR/ELay35JCdoeeJpODQ5oBzC78+XIxjZ21cP+GGLSNT9/vb9PK7ByoTkkp16k0gn15WOPa9jO6mRu/DA4AO53m8ETkAQTTAebJpVn5pjNgL3txCH9s0CSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573145; c=relaxed/simple;
	bh=z8cj7+XJMmPVwLhmOKB6KQcaPO6wu+6KFYbI1UoOB7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D9BF5StlbxNSxcXzcIK1YFLhefx1tjTJ1I5UUIxmk4S95o4jnEwsjZ1WkapMFmgHxs+RcinyQpVQzxHt7Ha4OEQwWgH7mLzyxYp87UGUUsDblpIgMeMUmzbjKng0TQTTcrrPeTBvxkupcgSfNkXJAFtiaG4NKL/DxgaYw2QBJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3qqFSJj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3qqFSJj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30761ab3483so856693eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573143; x=1782177943; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybHAwnIeIr3M04cBqGgiNtZgO4DE4FyzgzXKD88uT88=;
        b=f3qqFSJj5z52+RAQOIqigYJgk0o5NOWbF1FwTGvlsx4dRTJtwgxVlMnUvgE99jrFHs
         f1SgljoZBUT8HAawjcoH31A1fmmjWH8rZXh4QwqAjTwzRLCKwQNLlX0u6LimItYQeVQj
         gM326jOXoOX0Fdmsq2m0gI49Txa2y0OkRoerlGr4xHL/yMfAucC4Zaky4V4GQcnReBlw
         udFxvWQm8wRW+JMet7nLdTOFeoACKwxlAYlnW4rSWI4T9+89uDkV9rH9SG/C+69AhuIV
         dhGRQ3hDOCJPfQQT45MiODkjXs0ueP21lagaFhJ/ShK2Xf2anewWOp8i2FNsak2SyKTe
         SLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573143; x=1782177943;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybHAwnIeIr3M04cBqGgiNtZgO4DE4FyzgzXKD88uT88=;
        b=DUwHdiM5w/Se/NxpnEmRz8a/JMeHrMUN0RIfmGRwzuaqkgmeybCNJhCuEW8/Auee+4
         RN7RRCNk3oIofUv5CUSThyJLwydMUHjZiyB70ffea7/zSfxMD5eKCA9ZMLSwcHxFNs/B
         ExCMmKcBkFbv0WZzaCqYhkwUMu/Azb9zGyr4HDuvEYwaELOIgiU8hqBZYLoaK9rk4f8f
         PA3UtPKEILVDvGZrRaCQCViiHyGTFgEYgowslPeN239ChPI/ltA+0WvnB2R/uKK5uScJ
         ug1GY+3n2F+oe47jKkX57KKiRuXt8E2di7FcEcCOQD33z1uy7heGLnMBzF0ZNkFwmTML
         FzRA==
X-Forwarded-Encrypted: i=1; AFNElJ+knB2DdOavV+vkPUgn+xMDHLMAmbuCW0HkzsozFVF2jk2uFlwEqs1DE8PdMzjRnys6OgPWzYxk7hnfViXl9kQP@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLZ1TZi649ChbNS09kZ16AttQF546fKYJ+FoYFCRVtOT5h8l6
	2rIcfY1B1NqhPhso2lVKu18oy9b791ONi9Qi/isQPPD7Dg5ubshKe0cQshlSIiBDIGqYW+ihFku
	mSMTj0samMw==
X-Received: from dybtk5.prod.google.com ([2002:a05:7300:d945:b0:307:34ee:a27b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1907:b0:2d9:fa9c:87a9
 with SMTP id 5a478bee46e88-30ba598cf1bmr1040059eec.5.1781573142826; Mon, 15
 Jun 2026 18:25:42 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:12 -0700
In-Reply-To: <20260616012521.4045202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012521.4045202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-4-irogers@google.com>
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
TAG=agy
CONV=7e7ee33a-e940-4a8a-8e64-878da6a68b59
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

