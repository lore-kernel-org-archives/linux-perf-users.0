Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879144;
	b=AK7G8YROh05u92/QUDwcLq07KVjE2x20pgULF0VMSG0S1xexWEAK6e5iJUnIWr0WRUQi
	 uyWA8vEcwmqMRgMEHBDzwaHZJb2Wnfl8iivQZBPw+N+YApkh7ffmNpOT3higKl0Ggxam/
	 uk5MFryhUxv3bme6ABKrHodU43JtAYjK85yvf3wz10XGHm+5GPcBkazZfIlWrE5GqLgdW
	 Sz8OH9KFeMq8Dat4eHKGOVEdt2W2GmLMi6aUT4sWgb84BGXJ1Vf1bEJTmWT39fjWhjNfq
	 NIeyhuWY3aurNZe/7xVaGIAgOOVAlUm/OgmmLwsAoConbuO+em+QBj9ipQoNO6PKjnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YBXbNjgUg+UURoPn7/k5hFGZ3UtlzmwcEk29veboZWk=;
	b=b4z8aC4cSPJ0Dbw6QYi/Y0eiUGMDdRZGTbZRCw8u7behNvNoCesCMO41TI5FhfySiJAe
	 nejwvzqvn2OjLhRX50dSu6ii5/JiW89lbMyIGMoIBLLav2EyUMnTPiITD/qPZuJ13IUNy
	 ihKF81YXjj6DgR8r0D6IWZX0KcMh0b/R0y9Rf8F+CotyEAzx1lTLTbvhvGrOfJWwIIGOL
	 yzJMwIihu/OJy5PM+vTr21+9dsWF8Xt64U4e5m0TaOLqNKYn4AsDOBGouBYx5PYLR/kqS
	 +jXwjEgpvPMMBmxXxNcvZbHCb43R+DmzzSmz8Qi+scVqUraREqcZkJCBcNZ6GVhPh0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ffnYhgre;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD8607471F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CCD8607471F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ffnYhgre
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b467581b98so12486755e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879143; x=1794483943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBXbNjgUg+UURoPn7/k5hFGZ3UtlzmwcEk29veboZWk=;
        b=ffnYhgre80JTE6GQbfcmOoogm1GEw6pB/olqD6Pi1ruPdtAO6t7DhUHa823IrDzazI
         mF20ZMylqkZUhvyvC1kC5pZazDdN3cwH+P82Kq+6dftQQbQfglD0lQTV4bkBuRzq/jh2
         K9/OxvBgSyM0gEftd3i54k7HPrtEcon5khFTY/nuRtkaX49d0A5QQOYtb7Y+RZhLl+xP
         R6URnplKlOCn1nzeoG7mgoZkx31vH7NTbB39C3U5SDFToE1NjDCfE9idbRtqMJUi4E0z
         6flVKd1/8AKTVTNksba/2gLHNVDpRQfZIac0OxWIrhZQ+DOSRkwPj0ejufk6/LmTGVu+
         EgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879143; x=1794483943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBXbNjgUg+UURoPn7/k5hFGZ3UtlzmwcEk29veboZWk=;
        b=yRXeVf8OMxxufJPCDZqaBjHZS3BQw8Yb3BhuYuuI3dpAsAvTdGC93UZCq/lnK34g3l
         x+r/auyl3gnHn6OeunCT1kFfKAc8Wrpao7BStrJw3ctve+7fAw7e+pUweSz1oOoaAgDe
         eoDoswbexI3xmeY0t4pGE+McR0JoxFGguo3S2zPyNUtFh2Tv5/wRIOay4T8qoNTeFX/g
         xPddXXnXP6oeeIuROkG5H+MbeAaPkwb68nohAF6nB84wdDaj+klhxy2dBqBJuD6EUUx6
         hcsIkhDCGUQizPi0LNwkxUzSTYyb1phuoYxpxWyJxggJHDJn4J9H/chE8LoiqLTWESl1
         cbDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlBlmABIREuyGIHkEYf9LLD3CNE9NezoHJtAK5pLRB1JgwOrmn29qgjk6EdkCRAuMCokQexQmxtOyXztkQq2Kr@vger.kernel.org
X-Gm-Message-State: APuU4Z84hedU8EuZIR4eqRBTC/hsRjiCf2Ocen9J0kVMRizbUWgdTEfN
	qbVYmeCnkbmogoM8IzvSAv6WBJfQ0TqfdVWf4edufJyZaeJnrh9mYujvXYHJhVhpLR8=
X-Gm-Gg: AYBFou3c/pPxaWbnOW9k6aY7EiguWtZiiLIKlxk3HnY+A6fDSx1Ji6SI7rjwSYozGB9
	t0kZXWLroaM4agO4wxvG7NrlJdLXFjwGKausgusqmDIzNEjLmlKiJSx/4X+Co7k5B2gbry81W56
	slcBlj7EgKTVyDc02Y8DjtHfZlWylfOmneJBG9oXGMm/Qxcvxz9Bjy8ryUvLQ+ZSs9HM7+2pM80
	MtMZMtmJHikiIu7p7fT0xLaCx2382VWaLmWKo3vIV8JjKiYdt/mJ2PtsQ0vRozeXrHjb5OtA7/G
	cPuByk+vvRzIR2fcwpoORK+nFRtZrEoX0qJXP1vYCGsGicpKuDwewnl6My9lOQyrLSUBDUzNdrA
	wnu8OOQPGienY1bHZ36/Q3LCLsNwgBr9AAnGAcEM7/PeHEYy1zGoVM+3QcbnC7Cmj07iiDkl3Ml
	LvLmd3wyqCZW2pJA6cv9bOWEg/cRapIxYrApgQHjrI+Tt8cDdE+ZU8wiiqWvTKkVU1L75G/5aZd
	iQnDtMgEJPKk+LmAUOinkShCoJRoDhUaJnF52ylpKs/GxwMll8lIxYMTysRD2l20DazRbukFQlf
	zUDu35wskNVmZzyM6U/D9qzoN0aevcu1
X-Received: by 2002:a05:600c:348d:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4ac19234acbmr385559145e9.33.1793879143001;
        Thu, 05 Nov 2026 03:45:43 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:42 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:45:04 +0000
Subject: [PATCH v4 16/19] perf test: Allow infinite named_thread loops
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-16-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

The following test will want this to run forever, so add support by
treating 0 loops as infinite.

Convert i and named_threads_work to be unsigned to avoid undefined
signed overflow behavior in infinite loop mode.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt     | 2 +-
 tools/perf/tests/workloads/named_threads.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index f66ccd77bfe7..9fbfe7819a61 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -98,7 +98,7 @@ OPTIONS
 		nrloops: brstack, context_switch_loop
 
 	'named_threads' accepts the number of threads and the number of loops to
-	do in each thread.
+	do in each thread. Use 0 for an infinite loop.
 
 	The datasym, landlock, deterministic and callchain workloads don't accept
 	any.
diff --git a/tools/perf/tests/workloads/named_threads.c b/tools/perf/tests/workloads/named_threads.c
index d051d41a3cfe..6672c2f77684 100644
--- a/tools/perf/tests/workloads/named_threads.c
+++ b/tools/perf/tests/workloads/named_threads.c
@@ -11,7 +11,7 @@
 #define MAX_THREADS 25
 
 static int iterations = 500;
-int named_threads_work = 1234;
+unsigned int named_threads_work = 1234;
 
 typedef void *(*thread_fn_t)(void *);
 
@@ -19,7 +19,8 @@ typedef void *(*thread_fn_t)(void *);
 noinline void *named_threads_thread##n(void *arg __maybe_unused)	\
 {									\
 	pthread_setname_np(pthread_self(), "thread" #n);		\
-	for (int i = 0; i < iterations; i++)				\
+	for (unsigned int i = 0;					\
+	     i < (unsigned int) iterations || iterations == 0; i++)	\
 		named_threads_work += 3;				\
 									\
 	return NULL;							\
@@ -65,7 +66,7 @@ static thread_fn_t thread_fns[MAX_THREADS] = {
 
 /*
  * Creates argv[0] threads that run a unique function named "thread[x]" which performs
- * a multiplication in a loop for argv[1] loops.
+ * a multiplication in a loop for argv[1] loops (use 0 for infinite loop).
  */
 static int named_threads(int argc, const char **argv)
 {

-- 
2.43.0

