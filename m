Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DA3B27D0
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491197; cv=none; b=jvR0VMBSKJERBUKFWF94R6CAdhMvFW0yMovqd5n1pt6UrCRrdi6MCEw8Y0sKbwkmZXIznU9NqTm8jqTg/lmviLagi9gypUw0u3Sys5D4di2xWIW9a2QrpPkyQHss5qXk8pyBeibXLtZSVLnxCBjtowV52GtQGIJ+xCr9Qj72b94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491197; c=relaxed/simple;
	bh=CrbWv/+o15mvy9673dGVtso71ofEsxWnWpMd4FvQ1eA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KQBdLnLqZtAbR/OI+v+1FWL6w05ZEv0/H3w4A680AdRu+42vN7nm9ZJDZFMc+yomfQXwyUbgTqoslFYJeBaAyS1gHZn4p1N4B3kpZ/9sz0G2wtlQKvL6kXSpAFxCGrGlz459F9AfFRh19oFDuIDwZVTNNEyQV7//pm24xrJ6RWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I1tK/1aw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1tK/1aw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d73422431so3140218f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778491194; x=1779095994; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M2qwjeFR+f82S2J46kJab8g15mwoOiMqUIGcgspw2vs=;
        b=I1tK/1aw6pSqVBrghLFy2ok5i331/PTnRU2STRZ0Zk40dumrukrxO4VXzdxYRYsJXE
         EwqXDk63aPoFic5fqhosk6j17wMzRy7KGI38dYeX+HYURbUxfMTUCOzYOj42kxBMLOFh
         PlPWkY2qcvnokilVMAYZtlxNNMpvXf1Hkbp0HWOF13kkRuknu97pmZW7ZVHZsaB6STEs
         k6TENuoumEa+pj3gDOalu60ULXiEq5ltUbzuLr+G8SUl59g6cwWgnHOQnOy/uDbwHWyh
         qCaVgk+92gXgb8I6i27vdSoPPkk/FO4ZeMyFxQs0YmDpprQrjhmh718mQu/tl4zh6trL
         +Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491194; x=1779095994;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2qwjeFR+f82S2J46kJab8g15mwoOiMqUIGcgspw2vs=;
        b=UbDfAR6Obv2xYWu/Nznr/3Sx/39QphflvHaWHLE+cKPL9Tuv+ju1+lCCJWW/3iuNal
         Xq23VGkKbdS/f6rPkjm0pFYZd9xr6pT5YuxbaZcpf3Wev0MFOLoYtfKfefsjSMEMJ3k/
         Zx6YHjJ40WeVxfOpFqjZq3c89WxWfiXdr672ds/iUJV28Eauuvmf33xx7TIs3FLH878h
         iInZ9Kziiv/WyVCnCRf2Sgkep5M4biBB98lZTYxC3Xr5kACX6qeRCYDDgFaj7Lbsf2ke
         Qe1syEAk/HQ2VJhSnnbVzuQ0YTDiprhYZCWFu/AIUvZSnpXak6p9TC4lLN4BCelVYR56
         gGhA==
X-Gm-Message-State: AOJu0YycadMPCF0o5DCiRfpsK9x0hn9qYc6BSNTr6iQGiZt285GtpHU7
	cgb4WDvq1sE+wjOSJpNENl3bXHW7x2d8CQuJy2PALkgXcKn+w5H7aKf6ffOKBepibzM=
X-Gm-Gg: Acq92OG/0sR7W4/9p5R0ZtlRSB0mp8wtUJRmQOaE5WE4pz4YieXO25x2LbjaZT6oXZx
	0QtYjcbmq5Ld8rZOYWWB9kX+JIyjqNC3JrAETkj49POSdbxqLI+D95FLsxh8aROh5/FhL1zq+pt
	n/w6NHConsbmThQHcT6sUogDO+o06Fh2fsGuee0YJFgEigtw0YFVdQOyqcOcw1TluzmZmQubGQg
	mDb/i+Qj/1jRYPgMwh8yT0Dql+HlkQNbS8rNCiYJj+FC253WhAD0R4jKeiS12n34N0o4a7Lj2uM
	JmOvxWPnDHO2OAqct4EtTX3ckOzpsEXRcdzRVe6JdvMJysbbBCDUTi8Jaw/VysYU5n/lkDTzvpj
	xyPK5Ew9P58i4j4+iSvnWZsz1nqrf57dt8bqVuoud6R74NQQpM9oCWIr1YG9Mon13Dqpjn+0lrX
	zpFzhuORYJJdqXw6ra57e/+066gxopsaFW
X-Received: by 2002:adf:e604:0:b0:452:c246:ab69 with SMTP id ffacd0b85a97d-452c246ac50mr22531878f8f.13.1778491194013;
        Mon, 11 May 2026 02:19:54 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm24679319f8f.26.2026.05.11.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:19:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 11 May 2026 10:19:35 +0100
Subject: [PATCH v2] perf test: Make leafloop workload immune to compiler
 options
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-james-perf-leafloop-stack-v2-1-79f7383f545e@linaro.org>
X-B4-Tracking: v=1; b=H4sIACafAWoC/42NQQ6CMBBFr2Jm7Zh2jEhceQ/DorZTGEVKpoRoC
 He3cgKX7+f/9xfIrMIZLrsFlGfJkoYCtN+B79zQMkooDGSoMidT48O9OOPIGrFnF/uURsyT80/
 0RLYyhkOIBGU/Kkd5b+5bU7iTPCX9bFez/aX/WGeLFqvj2ZfmnYKrr70MTtMhaQvNuq5fJqmVn
 8MAAAA=
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
Changes in v2:
- Push and pop asm sections - (Sashiko)
- Add .size directive - (Sashiko)
- Add asm label for done and test with LTO enabled - (Sashiko)
- Link to v1: https://lore.kernel.org/r/20260508-james-perf-leafloop-stack-v1-1-637c260b2da8@linaro.org
---
 tools/perf/tests/workloads/leafloop.c | 40 +++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
index f7561767e32c..c20c75f7ba49 100644
--- a/tools/perf/tests/workloads/leafloop.c
+++ b/tools/perf/tests/workloads/leafloop.c
@@ -6,26 +6,48 @@
 #include "../tests.h"
 
 /* We want to check these symbols in perf script */
-noinline void leaf(volatile int b);
-noinline void parent(volatile int b);
+noinline void leaf(void);
+noinline void parent(void);
 
-static volatile int a;
-static volatile sig_atomic_t done;
+static volatile sig_atomic_t done asm("leafloop_done");
 
 static void sighandler(int sig __maybe_unused)
 {
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
+	".pushsection .text,\"ax\",%progbits\n"
+	".global leaf\n"
+	".type leaf, %function\n"
+	"leaf:\n"
+	"	adrp	x1, leafloop_done\n"
+	"	ldr	w2, [x1, #:lo12:leafloop_done]\n"
+	"	cbz	w2, leaf\n"
+	"	ret\n"
+	".size leaf, .-leaf\n"
+	".popsection\n"
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
@@ -39,7 +61,7 @@ static int leafloop(int argc, const char **argv)
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

