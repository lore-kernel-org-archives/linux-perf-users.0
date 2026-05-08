Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C72FFDE1
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236432; cv=none; b=hh0fSk97PreVCmWMwWPxNIF4406vCrKOSyYDQ2/PhQUK1by9MqS8uQ4nHhtkK3VlAm409xS95tE0IYAEuP2tp9QZhL8/SbCxs68apJbT0z/8X6pLrJQn14bEHFczV0bN/e/7uru6o0LTDdt3pyx6Et5WTdqb5igkN2Vtdu4aZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236432; c=relaxed/simple;
	bh=Ux+3kgTkIIgPsw6UVLLH50fXpp6ZfvYFKK4jNtQqzaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KjvldGVbG7BNhGyji2LaSt1EZ2ttsPbY7QxpM09YbIi3OXLf539yuo6mDlR75pAJUQRfqLyojKenOZmW8N+BZDHJjKiLbX0upmCufH/yI9Dge4Iq60tuHMdcUZbKWTDpR2LcnAY1b7sGhjsbAPTHi93x74BDgafYBV9QwJJa8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fy49egWv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fy49egWv"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso1620086f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778236429; x=1778841229; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8xHZ9vH0OOXv8/65iQxAO1DN2jmxRH2008U7T+k0WE=;
        b=Fy49egWvS1fJ6URBchClKF3TcR14XvS/tOfYXWThCuKzvXqmUZT+8k8J8L6ZMx4gX5
         zac8U3Kxfla4oY1qr4GvwSVdeaCG0L61vtmO/bMdCVbFO8fhwzSvprBO71HaviIHHMxM
         ylccwlAx0DuRUvSIALwv6pRj2azB/gUqv5DKFTbObLFAHE8vhjDanF2ECp1FN4YtvBUz
         e93w9azrWd2QfcFvx+Z30RAzJYU1WQ9vSEglOOCJLJPWzY7lzDFVf0svMPf/Kjr//7PV
         YcJw3HWakz84Vtrn35TzdjAjCIOI7/kF3RF3r2lKjkugEvdOTEMYDRAr1Yqf9V0FrrDW
         n0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236429; x=1778841229;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8xHZ9vH0OOXv8/65iQxAO1DN2jmxRH2008U7T+k0WE=;
        b=C/57QQjXaW1AzilJmTvYY8oKQo6bqNrRAQZ8B9Ie3e8vPgVBcLUctg8ywfh2+6Gc7Q
         xx3wa14pJlHngq6nzJS56dchtk02tBsSxVD7P3oBtlPI5YXOUwL6xd5BxkPMngnVSc7E
         0jxnD7mUQ/K2EPtfEKD3MljuZBqzxbllEFXSkjCaXIzCdXmWBG+455mrD9uxf+3agpBz
         rtl3JPrEoDDg81sqaAPEJwTYDEOBfZmRpYIMVMexvrvB/5EqwvpW8JI5r2UIhe0VG92c
         zBwtH0EZ8kSURU8axKYyUuUxPb6ufyhJgQHDTSycHSaAOtTaMS9Adg63kez2z6aNrtqc
         2C+w==
X-Gm-Message-State: AOJu0YymZfzVkF4+Z4GIefCTiGcCOiAm+L4uO+8nVKKNM2bzkDKYwgIx
	YxaH7KXoylXOS2PYqbk1A2WVtLWzFJa6qURYmTyUeqnG2uchRL0XScVPQZ2qzRyn0+c=
X-Gm-Gg: Acq92OEBFWKgcmDGuk1tES8ZQn//EXDoFeUwZC8dNRSqrOTXe3ewid5sE5ls56K7d1V
	o3zmXBIFnUB6Uef+YcREuSc8RHh2nAogxWcufTGILd8xftVumHZNU3PWUOjXSPr1iIS02lsiJBc
	Kaxd7A/Wbcb44dmE6zf0lI7GW83hS9Hu2E/bQj0ZkPdHaP7vHUszuqUhZJkdBbYoGW4ODXTSiqp
	rgkgRXiQcUSHhbkZc8mUSzmQ6qKgDfUWJjYWfgE9k0IIRu411T5Qr35ZZV3fpzWWP4XsEA3XXug
	469mjNhVq2fApeyj3bp7X/mJyKRyrmu0z4d5k1f5rOkAuduhTlf35f8Nr/1O48jTnF8DBkdRPS8
	XLk2RKJvoNQQdVavRUbor7KsABwRe7zNwJZ1AtvCCUG2XAbc/BEwUdi5K+XDcR+yeSI0OuYr8ZY
	Du1yQ/ddqewxU+AnOlgDLdz2vuW4192wsM
X-Received: by 2002:a5d:64e3:0:b0:449:cfea:ca91 with SMTP id ffacd0b85a97d-4515da96254mr17777880f8f.37.1778236429088;
        Fri, 08 May 2026 03:33:49 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm3225842f8f.34.2026.05.08.03.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:33:48 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 May 2026 11:33:36 +0100
Subject: [PATCH] perf test: Make leafloop workload immune to compiler
 options
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-james-perf-leafloop-stack-v1-1-637c260b2da8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAP+7/WkC/x3MQQrCMBBG4auUWTswHbCIVxEXIflTR2sTMiJC6
 d0NXX6L9zZyNIPTddio4WtuZe0YTwPFR1hnsKVuUtFJznLhZ3jDuaJlXhDyUkpl/4T44qg6TiJ
 IKSv1vjZk+x3v233f//i7qyVrAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Since the leafloop test program was moved into the main Perf binary as a
workload, it inherited the same compiler options as Perf. In this case
the -fstack-protector option broke the assumption that simple leaf
frames don't have a stack frame on Arm. This causes
test_arm_callgraph_fp.sh to pass even if the stack isn't augmented with
the link register, making the test useless.

Fix it by rewriting the leaf function in assembly seeing as it's so
simple. Adding -fno-stack-protector would also work, but wouldn't be
robust against other future compiler option additions.

The local variables and 'a' variable were never needed so remove them to
simplify.

Assisted-by: GitHub-Copilot:GPT-5.5
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/workloads/leafloop.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
index f7561767e32c..58367fd1daec 100644
--- a/tools/perf/tests/workloads/leafloop.c
+++ b/tools/perf/tests/workloads/leafloop.c
@@ -6,10 +6,9 @@
 #include "../tests.h"
 
 /* We want to check these symbols in perf script */
-noinline void leaf(volatile int b);
-noinline void parent(volatile int b);
+noinline void leaf(void);
+noinline void parent(void);
 
-static volatile int a;
 static volatile sig_atomic_t done;
 
 static void sighandler(int sig __maybe_unused)
@@ -17,15 +16,36 @@ static void sighandler(int sig __maybe_unused)
 	done = 1;
 }
 
-noinline void leaf(volatile int b)
+#if defined(__aarch64__)
+/*
+ * Write leaf() in assembly so it stays as a minimal leaf function with no
+ * stack frame and won't get silently broken in the future by any Perf wide
+ * compilation options like -fstack-protector-all.
+ */
+asm(
+	".text\n"
+	".global leaf\n"
+	".type leaf, %function\n"
+	"leaf:\n"
+	"	adrp	x1, done\n"
+	"	ldr	w2, [x1, #:lo12:done]\n"
+	"	cbz	w2, leaf\n"
+	"	ret\n"
+);
+
+#else
+
+noinline void leaf(void)
 {
 	while (!done)
-		a += b;
+		;
 }
 
-noinline void parent(volatile int b)
+#endif
+
+noinline void parent(void)
 {
-	leaf(b);
+	leaf();
 }
 
 static int leafloop(int argc, const char **argv)
@@ -39,7 +59,7 @@ static int leafloop(int argc, const char **argv)
 	signal(SIGALRM, sighandler);
 	alarm(sec);
 
-	parent(sec);
+	parent();
 	return 0;
 }
 

---
base-commit: 8c8f2093614373ea8179b562320212a25cf937c0
change-id: 20260508-james-perf-leafloop-stack-c221600eddf2

Best regards,
-- 
James Clark <james.clark@linaro.org>

