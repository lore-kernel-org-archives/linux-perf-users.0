Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82DB442B0E
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462273; cv=none; b=dFE828ZXTj9PsRal8WOEEsAai6iqGipy35o+0/VDXkEjd7okKjQRfnbKwtw6FgACLwNitFLepdUiPS9iubNs9Bcu9m/ayrNO4HAJS1nQcbBcIg76U5bpZfUX56kBToKXEIUeqlwJm17dN8+rI8MGrsgKmCeWMXmjgjJqud31lQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462273; c=relaxed/simple;
	bh=rTMPj/k3Q/u75BzRf3kKvE+NUom8emDrF383KCKzh/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tU5qIoU7WTIgTxO8zSxILUq5Iynji3LnGijd44N+mx3r95dKzDUFEolNrzQ2jNdvEn64uDYGD5f3It6hI/a/LwfZ5bcV//05YODh2XfhhvIPVVSRXppvXNfkyY5UyxyFkNZDnMbWnbqjp0br48UrCbxi1p6Ci5URCssM341UM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OFqGozdW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFqGozdW"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so18693545e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462269; x=1787067069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Jf25htTTjahKWtoEfo2hIZORvEQKfVJc2fvPx9rUTY=;
        b=OFqGozdWLw7r2uGsqLBEHS0vupOiOUTSHCnqCJjqdsKwQCWkLwXS+eHDBJcgFSOcAf
         3wIL8w3EQSvb3oehmrLk6V88cIHBt+lw/SsQVpVzecowSKVpNjSYgbcVidWVu2whAQ+z
         KGsiCWpeIUoGnzeGs0OGhTOKAI51V7um7qCZz7JxwJTycjbq8wovkdZ/dm4xhJKzhZ4e
         SnSbRM89BL2iwekIoytpuXYQFfM+YEJL3IrGDk4172d21er2PDLV8ezHrSbkTOOGK5BH
         hwJAoB5I/EUhnWgHhmQpd5ZPig6bSmNI5l4YelCv6e3hg0uoyV7b0JEv3W177jYDYVaW
         /OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462269; x=1787067069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Jf25htTTjahKWtoEfo2hIZORvEQKfVJc2fvPx9rUTY=;
        b=jWNYdLVcmE/ees7PhRE7Xl5so2IoZ2WXMQqfrL+6+1XPHtHFZ51TIXJBRqnYZ6rC08
         yQ/rMQ/jLzVYvQuUsz8GyC6hN+MXn5n8O+vr2Nc4xHh7jl7F8xT0tB6TB8lUmSx22N0g
         MGYEqG627zWUcU8NXnmyv+uZSMlcwVXAFxIaWlOI7O0dav4igLt45d4PG5uJ48M5eWRf
         ZPU1KYm0kWIVp6NeIISlZoYvso9oGGlaN8Tp5JXZj9DJJiEDbqOwnCAHVjrrmHOifcTj
         x9g9vN5/0wXyMb5zK6gP5Yqtf7WW7t6ihrjE1OQ07DVn/o/Ug0ZcrhHce1Or5OS/vEig
         gnWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxdYH7VCXg0CudbPA3MnRpRpwTkh0Vfz56xiAbmUvLKYHeXgnahm1ubbG7W8A3VbYWm9PYEMQWHq9HuJPW0t/p@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTMPMBxALX36EItzwZ2X4JhwBbjqLHMKWAm8/+5p9CuBLc0ZP
	mwIteZNJkeTc+O8NanrbbAcDCpU9+MG5seeEO1IGVxWluixOIbZ9MebohdOhWZ/Bzmw=
X-Gm-Gg: AR+sD129wvbldA3PPnzPLAYxgxFi0aq8gZLcAUqfruHMjpHSpExgBSz9fzeBl4pGdUd
	8qpK6tIvn3ivA9aJkCqSHvKmON3AmPS9LYRZboT17pV/I2tRqJQPjbhf2BjEZIx5SUR3kBBtkrH
	NprfHCBASngAOc0xSUl5rwMIDRuH+7NoOmClc/vXQVe5UlJ8v9xIi7RZ0z44wnqbRaFGwUwDXW2
	/S7uKUhkjNKQna5sVGPUniGGaVu0/Xs7QwzeTv1xKV1GR4bS0DCzk6Y7SI+R/wwfl7QxVm+Wbgi
	hmCdTvkNOtPf6SKx/U46i+op61GG26pQSO9txVcuN9++tJ6LuLXkAMgpLY/sy92eVf7hIFHpzBj
	hOXQ3WwA6IkjhORJW4ZeufacbvihZCfNCDrcuCrGtWw15vGWwKqBh7fNPTaVH4G7QcnnW9NNzzE
	hA+Q54x7fJO0kxoNBAHXjnw60D9Kt+igzg5Tv8pkoPis1ebtYo+wQB27vpT4aIhvoW
X-Received: by 2002:a05:600c:1550:b0:498:952:e276 with SMTP id 5b1f17b1804b1-499784358eamr51427345e9.8.1786462267978;
        Tue, 11 Aug 2026 08:31:07 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:31:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:15 +0100
Subject: [PATCH 12/14] perf test: Allow infinite named_thread loops
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-12-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The following test will want this to run forever, so add support by
treating 0 loops as infinite.

Convert i and named_threads_work to be unsigned to avoid undefined
signed overflow behavior in infinite loop mode.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt     | 2 +-
 tools/perf/tests/workloads/named_threads.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 859df74e62ef..dca8972fec8d 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -68,7 +68,7 @@ OPTIONS
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

