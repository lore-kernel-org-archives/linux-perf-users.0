Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7445FFA5
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305802; cv=none; b=SbFgtvaz9K6Usws7ANaOphk4NKuR7fip4uk3ZckEAhGiiKw4IJLBflyhTRF3/dSuzQYttExpn7aGGfg6mdm2x2plrLndCw/lf548vYsr6o3l8GlZjX+nKzcvqZxbtCf5uR2T5XBTT9sbnVSHeNaV/q+Y9X/ZydmW4STT5HHj/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305802; c=relaxed/simple;
	bh=rTMPj/k3Q/u75BzRf3kKvE+NUom8emDrF383KCKzh/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eh5Dh2AvldafwR3U4hfN26YQMrLAsJfHjUq2lX4FA9qsYORL3o8YjQh+QH6XZ2T+ZOQaY3kELvhHkNG5HaYJpGDuRl8BpY9SWsf64GWxvzIo9lWyMmfJhX/1qK5Zu+ScdTpXsWqnwg9F0ujbXZyC2pg2ujDX1KnEmUOpE4ZhV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPBBt1HV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPBBt1HV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so742046f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305782; x=1787910582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Jf25htTTjahKWtoEfo2hIZORvEQKfVJc2fvPx9rUTY=;
        b=xPBBt1HVtSCicig+auSHVMXi1J8mXZZWwff8aEJ660lfuZBAPxM9RXgPA1dzd7PZTz
         ByE2Qo6pEGk1zMCio/8zEJfVpxG9WT+VPPbhIqXICcs2iWF+fz7vvORgymjkULYtMkpy
         r+J0r03K0f5sY8OHd2uZcQCWNbeBsV5vdIvXZWQ79OOZrew10CuvmoYlwYUjXVmdK1nz
         ocKl0pBglFrOTNZaIbS6tEKKdXMDRcKIrq7A/Lp+uH2Jykue/uJUlcv9YSwAewyuFUVj
         /UhOrZgn1zhoXejPoq9cf+6ZYRbaMQyxCNL8O+PV5zE1YY3398/GZcqhheqDCu+K82NX
         dyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305782; x=1787910582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Jf25htTTjahKWtoEfo2hIZORvEQKfVJc2fvPx9rUTY=;
        b=nYGYhehHNLA2qoT0QlVeLq4ukICxHFZs/Z827BqH6D/+rWRDL2gxrJ7KQgbuKHlvBK
         fMc2GumpPSjlc1HJa2YsXnRjQpFPnNUYtGZR2O6zD0JOEJHjaUbaMGi7HmdiuEyaxjWr
         SNnyQo8q1UcOffox2SeR/xz6oO5OySyKTwb58NI422XKPCh8RSfEP9I/ewFlbwesjnfc
         Txa8wydPfW/yzjePL7i7anKVSPsi5xIk9015GHhSd582oarQOwV9ZHsdGRevHm/97Qcz
         rIW1Y2dYmBjHD1vy1dU4tCF1u5JFpqVvRQX6BfeH/dc7MDVo+ZNSrqp6jfwbxoXOkeHu
         qeVg==
X-Forwarded-Encrypted: i=1; AHgh+Rqq+nwXHANseH9gqVL7shY725sWtsk34PSzVFXTFclJd5or+6Xx4/5aiqChCGtbqyTZGWxxwkCL1GVGp4CMTASA@vger.kernel.org
X-Gm-Message-State: AFuF++kqXIB3ehkic6rngfsPZF8Mm0WnVtV15H0rlKMFn/0gMue6DiGk
	+bLk6g0OrpdapduqW/YBCinp1MrTw7jVGdaT3fNSL298Q/uEfJw7f+ICHai85J7ZExw=
X-Gm-Gg: AR+sD13eSYkbHGt5sZmcvC33m3T+lGvrJ44LHOx5dOd1Wmd9VW1Z1p8N3ZzT5TV3MuA
	B8E5sx1xGptXxIf7O6/LiiOSYgMMvhLI25QTIVaNwx7gM/56FyylPibKPddF/swW3BVtmzikb6W
	HoFGSCH2DGzLMXTDR3md4dsRJ64AbCqUEKwqtgq85gfgGEIM/Tppqa3uG6EU86Q8xOJM+4SPPQt
	7A5tTcNLelbUDKME9hvEaFPQADqTjrOCBphwt4auqRHQhCI/viymMNIrb66UxMn5+eK86EHfr3T
	5AKxBAFO6Io/Qt2bH7vhmO8y7mNow4aJ79xoFNg4KHKy5EjkNt+ecT4+EXMEMU9cXtYFr6jWSls
	QIpVVv/2i6PBeDt6vHOjtO1kzGnHg4pDLeT5IPYDKloXiPn+lRvKjiZ21kcvJXoO1bvtClVKbyX
	h/WC6Ch92MCYVBX4P0lGPyz0x8vcDlXbqQyM/h8WF/+qb96skGCyjgtfJLU2SoTi+E
X-Received: by 2002:a05:6000:2589:b0:482:bf17:e685 with SMTP id ffacd0b85a97d-482c0b88f19mr8390069f8f.11.1787305782104;
        Fri, 21 Aug 2026 02:49:42 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:10 +0100
Subject: [PATCH v2 12/14] perf test: Allow infinite named_thread loops
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-12-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
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
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
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

