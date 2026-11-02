Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621766;
	b=cPPbzbHpTAhgLp/AkAe6T9E6WrjrFx4Qji68yC26DiF+9E3gqdgKrpNdJ38Pidv/q3bS
	 Fr3SsLHFs29LKLB3NK311MQ3m6rGyDi10Tc9d8SJxLouYhBVd6mAcbyESXq14G03Ftuw1
	 cUnBuymvqXik8Y6CUm5V/56/tXYekKAvjG/YT8KlwRSQN8rwAkrxMhoDOK00cqC89lKUD
	 7tfJxUXVzWtzk3jpt1reLWJJ+c8DkPewTG3Ux43qmEgzbuU5JnlUALOOH6Rp9KUEbqpSN
	 QUTDARKu9lY56eSZGfk/nw0KmzjVMr+DEflY4RwzffFyH8y/MHkSwH/5LayZ0ueIr1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=a05nv5fincC2k/bvjU+c6gmqxIBRW8o0fYRmcOAk9I0=;
	b=a03Beuj9fcJ9EX1IJlJpy5OaZaIqbONxHnKgTjDv+PoJ/112EwdFj4BvJqPNVnQBHRhp
	 AUHt2niSFly5154oQtLjhthJwiyh+Egt4XY6/xJUSDS9OlJpU2iQQPk6guzHtRb8Nhpgl
	 28OEJg0cZm/w/Gr36WpV9F2d6sPzXwq9N+JbvNqUcevQizv+RaTduurJdBui3R0r61Xyv
	 DQc3euFcZpBxKEOFelUFtyKEtU0K6mngGri4UUrQBjVub6Dc93jMnPCJ1giuCTsHd7CZl
	 Rqa0kb3RARXXo6Wk73eWMh5FudWxTC/eISJX2KpDsKvFG1kxCd8Jc989lzyCqcTNYIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vcm9YzIQ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8753606A87E
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8753606A87E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vcm9YzIQ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so24213045e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621764; x=1794226564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a05nv5fincC2k/bvjU+c6gmqxIBRW8o0fYRmcOAk9I0=;
        b=vcm9YzIQOFVHOXv+tT+vOKl0R2mPxx8MLFjVxWEBW/qSxGg78kivt1ysTRtPc6Z8LF
         jcpQbBE77ezkl54ZlRTHRCvhwv2dsoFOVYfrT3hTypMDAENM3G2vhyxmsGj9t2n6NWUs
         qltuf2tIA+0frHoDJ2UI3nosIEZy3c+xl2IWtYw5OE6ECby0UbCZ7phcvlBq+WMFJuxA
         4Vj5TNwIRJ2uzKiiyruJeGmAWwvHAhrxjIWi53TZaDzE9krITT19127f2Fx5ECyWbZJZ
         7nvUsnFWo111AmPSMYiRw5BI39iONoRWzzN3aGKMjyc5koluLWGAhysnvqzRDS4e5w/3
         xyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621764; x=1794226564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a05nv5fincC2k/bvjU+c6gmqxIBRW8o0fYRmcOAk9I0=;
        b=Gl6UN5EEt+aT/xTJvVTIVIbpTzjbo5RqtkkghVBX4VaXQ8vMgO9UKr1BLwDwp24RPn
         2E0chRqZCfa4od78rkYMN2sHhktTajcIFHXL2Vke5jm8Vytgikhxk1dW43941NkA8lEn
         bSYHTm31EJaA5JdvWkQU8NLKXOXYrYXW8bIo0rdKuzl1RqFy0XqNYIRS73JXYCakuhia
         Yqwl3HxohGo0fUOcXk5CIcK2qHpl6j7QtH0be1HJ+eLjaS6dKkfq11IoihL9S7LpSsSd
         gHs8Is90xFZVdUiwmAFIryAfjxKk8nZQ7cP4U6JM64k1idLxGS8RrlItvNYwSsDauw1N
         2DSg==
X-Forwarded-Encrypted: i=1; AKwUvBwWEtbpCp5fNpgwbe5HHMQaDjrZ/0UZTNRw2Q/xrEwlpHot746URSo9AKOldgtLpI8zGfkIf88xDNrAk0uvOvPQ@vger.kernel.org
X-Gm-Message-State: AFq9FYJWG8jT7iBeTgal93So14t3svQTGzUzgmSHIKZYMD6dB2Wan4O5
	SBtR+OQxsav9gkgZhK+XXRhGVheJ0s+WBQGWXja1eKPFKBAJu1S+1UT4XfgIqPUlBoA=
X-Gm-Gg: AYBFou1+Paqk412AoYsjXn6EAihKY8BLII1wd4siOxvEUm6ugpsUNfZ14e1nHX/nShJ
	+maJFe0yJc4cCO+TguxJM0XPC3AR99N7yBhto4rvAz+owyN6JHQ1j9V60u+feMVRYk3dJyvwpMG
	9HbQsxrSP13m26zXy26K+vEBRDTgyg6A2aeHPFur+t9Ou+8h6Lw8xJ3b9V37oJQR2klvuaKJe/T
	u/WVPGTLKfwJIKt/xXlmDkH9K0XvG7R/B7gtV27ldJJ2kkLexYqfVswLV1u/s6NWRYLaNiQhyHl
	3GtVxeznsawagAV96PAthOKRL7Uas4GkM7RJRfv+QkSOTzyYXMnKbb+pPQCw5dnu1OfyDBqv0Tj
	aMqfjsp27ESZcuMLT+s5eNemQHCUJzE+6tPPoQeokB1neO8kebr7Cw2OaDWjNa1taf7JFSZ5QuD
	NY0F+RI773GDQwld+5u3VoG1eFgMLAEUhuV1pKXpaZ3A7gCFelyk2rigqKyOQ10RiTinZ62C/Ot
	IghTNSdu9owMtPcNcDNw17AzpNJCN68aQUNa2ze0OD2YNsPjnL/G24hV3WdsrpEHEmKK9FTC98I
	sWN9LkpMRX1esmciTrMcuDsSgCSHjtn2DzWzC43aCMLXOlfiUxeEoTE=
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr237933795e9.29.1793621764239;
        Mon, 02 Nov 2026 04:16:04 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:16:03 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:30 +0000
Subject: [PATCH v3 16/18] perf test: Allow infinite named_thread loops
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-16-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
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

