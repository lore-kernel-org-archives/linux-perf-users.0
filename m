Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966123845AC
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178090; cv=none; b=q/54+f7dmi6R3hRkUJr84WoWhXss2eiD6E0aCEVV+OcIgwwkujnZ7gQyaxyjROzEXAm/YTZJ2ou+JvLmnJohxlIBxUCU5+ZxkYkbE1ASYxTKx6OTy7SEmoKL1xd3eLrc4m+Ae4/WVYKVCwsitLXlU933RK6U2dcVxDqrYooQpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178090; c=relaxed/simple;
	bh=APmFoGm4ITAgg2azRynMJp0sFMMLDdTzMdeW4BLj+Mg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kw42xKk9JBabni8B35ezb3c5DOYvsI9kZRh1NgvBAerbXOSEL2PklwSYMee3XUTvEdE7UoucFl8ztXxB1C+Faa5ql10NSxDY4IB2KqQvyoMbsqzKXikfcw6AN8gbEICv3d4vw1m7wZG8Jq6zRp/D1qxTtDSd1D9SFQMrH0aWe10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eM9xRk9y; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eM9xRk9y"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30ba395b047so4009481eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178089; x=1782782889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gl8Kb466gA98yrYZLHyNHPZc2QoHrdyhnvcLpXbuUZs=;
        b=eM9xRk9yzzoWZLuTaQt2HDT4GqCZP/Vua/1Nl/s4i9lGCjHwarBr/yKOqo5JQo6Y50
         U8/9l/yxX4NcrWccZ0pHOccD2YTgCu0zBRJ5Ctbj7WdH1ayyf/fCJm+6VHrcoxC8/WS7
         FnNPX4b7Ne/fEkqXavxEXWFWUJQrqR2yKxNFpfN7Mr+6THBOOLtzef6kaq7/6HsbSZNa
         d/fzAPlT6Jd90RALWjonAreemRguLXn16Ic4xINXzzVcfwfXCd7HxxCRY1fmUqMm+aCO
         yMybMDMU7aftFL0h2wMFqT/p5goO5tHYXE3dsSpiHtyl8IfMwGYwqmFm8OthoE3TuSwy
         IdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178089; x=1782782889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gl8Kb466gA98yrYZLHyNHPZc2QoHrdyhnvcLpXbuUZs=;
        b=qOHJwlplqA8uvFSYilc6/KQ7vBXgF/wo0nOK6fmqKB4yxuZp/9xZVV18DTcno8dws4
         x+Z4O+gwL2nGvKWQi9NsH2r+Wpc0wSLggL2UBC5NilP1ibZpvew/QwYlkoECCNRbOdtc
         xPqIUO1ZwbGkdw/TvYNSsrJsXlJj8QJl0lGb/dB1na2SIcSeJuXmM7tQUQK+DszEsCWQ
         9Z50kJW2F/sFu76wM7Zq67lZ6SCp2wdjKL4bO9fA/oQcXSmvOUmvQ+clyOg2xbc/ipAa
         q18RPCzNra+ZmLrzjiDseCUimoIniXq5ev51ntCBkC8Q/y6phyA536PYG0VeWdog/sJz
         VMNA==
X-Forwarded-Encrypted: i=1; AHgh+RqDp1/Yv7ZXsOlhJI7dHM+EK11d/HBg65bFGpAwq8A8JyfAFTtQp9tk22NyUa0KJNQwyhluUTJaIARJt45tuaEj@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiquS/egkeQLnycBO/a5YmoMM3Xofj7CFGtdD8h5nWOyGv3ZX
	UUsVORxL+NBEhZeNHqHhDeWbR2ABc8YuCwZSKga9ZvCU+G5xWSXUe9BraW7GOn4O4qKHWeOkxu6
	B/zkLI0HYaA==
X-Received: from dybmh13.prod.google.com ([2002:a05:7301:f0d:b0:30b:beb4:7f3e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f609:b0:30b:9e57:1e6b
 with SMTP id 5a478bee46e88-30c5b8d35edmr257455eec.17.1782178088302; Mon, 22
 Jun 2026 18:28:08 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:48 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-4-irogers@google.com>
Subject: [PATCH v4 03/13] perf tests workloads: Support sub-second durations
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
2.55.0.rc0.786.g65d90a0328-goog

