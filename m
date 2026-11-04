Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818159;
	b=hRy4uXy+PRNUzzPx2fmc3iVPIRKIeZWNYIoSwGb+2J+hK7lLVFu12kwlp2gJ5jZZ+Gaf
	 ltue/a5tWnYpYQX9EjljJUGt8/wvLajQi3T1i2EH/numei3xj3eFN9AgG2sAy0Bbsvcgx
	 Q86/TI8X0lnse4FBkLwdPUwznf4o/tueofUI2ef3RZotjxKsP3O7C1eEm9X3B9K6U8yO9
	 V+3TRw7bB5QJKPKVBPKzhT0Ok0TFCfCWpSa0aL83tQJFyPEHenG1sgE0Rw2z47K6okwEB
	 7CV4c2tn98/cXmnqsXhRf+TsvCZ8hf0VP/agJf+HYdiF9oZ0cfMfzjGwY8gKfJJohqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
	b=LNpQ0jkPOgdFfkGd04wY80OyK2sDUPEFE2CvN6iRZfrr6QIkdu+Gka8+0BZoztjLQKdA
	 0idcCZ3pY5cdQ4SZYlJAbX6SNWOa3c4UXcinzjmDE35zbcfYKFISTFgR2sjBJdGcds0cs
	 Oi0Zf3wriRpMWTsFNMyTfLcNig0clS+UN2KfU/iHXHibJsqPHxPODW7NUEqnsypVacAc4
	 FeLBFrirsdxfDGSETd6Lrdjwm9r2LHTlXz9jsqLnBtFiE8/Mh7jUxAUulEVBbMJPFdHFN
	 7Di2ka6aa0fyym17adWtrgdGmR4V4VfyZePEq93qSTI5URc9wjEpFwaw3YBe0Y4ACrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bhPpiWYE;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D7606D82F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC3D7606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bhPpiWYE
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b2fafe2812so12669747b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818158; x=1794422958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
        b=bhPpiWYEVC0nDETzl/teZ7dUs1c1dgW2dwyyLfcoMuI3ij+wL0bdhUJbJq2VtxJqee
         yyh/05NRv7aPFR68V41dK1j4GImbcgTKo+xlMsc+5lAGLzADoB0BQ9rXLPYtVCuXGMuO
         Cqu1x0CfgIkIcMaOyYV30uZ7LT61qT3DHXYAq8LhW1BHFQj9gnJG/jnU/oGLsO5gqcAt
         iWxaqW00SrjJ8TXeNIhUyb3dVchLZZjef8f2eGuamW7HC/EpX99WDGBtK3oFNmtUdUC/
         TpFFFrkNMNcFW57AYCvOSt0rEBJDWmrzPyuMPcROjjL7jC3oXiwAEcI+Aq9sf+e2vz+Q
         E7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818158; x=1794422958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
        b=YqhQVy/TnjR3VqAKPc+G0kECeivi7ChcwMQIQWvITQWq1QrTcZ5kIJwifRNh00rVNR
         PTUk3EDMGScIBklf8jxg8IMZoT55hx349u1jVCzZkPFeNv0jQp7+TzaUZ/imdBSpeIgJ
         rbV4ZDWMK8HOGIZ2KdShbNQrLRiCNDtq1MtGiWkl3s4wV/EAa6P09/vOFi8aLT7Ce1ID
         IH40DJthWIB64S2woHBKXQDbPGngSX8orDYhJqlWRDfeD4/N0M6ZvcaDBGMB1Np9Gf3X
         0tKHIcl3Lf88HV/GDGHvVOzsy5PlfCPaaKT/mODRHh7dUtHbT6Seq7AGwn4Yp/cwGo1C
         47vw==
X-Forwarded-Encrypted: i=1; AKwUvBytldfFYokwmsmed3x9OZv6YQ7Me5xdEoQzdnc2u8j7lXtZ7Qkr2prl12mq/hVDvQFQb8cAc+DUJ8Ebug24CJGN@vger.kernel.org
X-Gm-Message-State: APuU4Z+rUmI214OuCFMU+fkJFkFsdXAcWPNGFmiLaY5N2yKAO6zq6vls
	ildTd/+aA3s+KZTFDBsPNFvU7vAIn7cdoDIOB11YpaEDTL3b0Y44llC/
X-Gm-Gg: AYBFou2JUpQOTYfH26TOFh8XKgVlokFvyXiQEydV1vIDDzfk9xlxSe3+EwNDggCbEBs
	5wf9Apt4Ixz2L0B+i1ltQnowxifD4CpJfAhgLAQmDwcXi6kJae3sxSq+ADZ5+87gLEI2JSFfcUy
	0g7+HdhiL2xh5r3tzbP0a2UoXaR5zvYnBwT99Szxewap36NspbIx6CuY1tr+D5K0IjquluYUH1P
	KW/6Gwurd4EGT+feLVxVJ7/3pusnAlpooMkOHqs6pOCCfeDB7GOfrGkbUy2RHvPNmjJECfqeLfg
	dmcmrmXQQv2W5FlTXDsUyl5e+NFDfP3oVMDxvtTdEGDc+pEr7XrFDK2+hKaMHyiVjJYF04aR2WY
	4aWDwa7Uf2uPD5ddEft6td2YyKqF/1CSI2O6ZCjcEzeAB5RQuwX4vLvTtaqzgKBLyQfSfSXQHa/
	mJw6xVOXM0awVROuHD2ds3AZB2Zqy64QbRNpbmuSVJBk72RoXwRc8z2TYOhxh+K/+5uPbQKYAiC
	RcOt01ZbJDziZm6VY2bdbIAAenMZLAWr82HhLkVizQKjOIGFY5VIQjw3FLN5BBmIuFJk5CkR7O7
	iIi4GuXKIYB/kMr/xMvvJ4f757PW8YYJqEZ/tNP6zwvn4pM3AZ7lHZg6DbVE12BtyYjwuZ8rZTw
	czDUStt9zzg==
X-Received: by 2002:a05:690c:a012:b0:8b0:cd32:b8dd with SMTP id 00721157ae682-8b328e174b8mr1891967b3.17.1793818157715;
        Wed, 04 Nov 2026 10:49:17 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3098c3174sm24622517b3.12.2026.11.04.10.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:49:16 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:49:11 -0500
Subject: [PATCH v6 04/13] alpha/perf: do not report user registers from the
 entry code
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
Message-Id: <20261104-alpha-profileme-v6-4-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3878; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=LiN+Yv+pum+ZIoYCbCmWoIHtlAzTvYQXPQL0PlKXs7o=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe16kIO6+MYYzv/yrI8i6s8upfOWOjyEubr61ZI+Q7v
 TgovlGu4yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK6JamFk+Bweu9Rmmd
 6Z7Ewduz+3pLiFvq7/vyJfTOmTgtAae5Uv/Az/rB1Vf96VKNC1K62oWrPg+80HXp6Cy+QT/Vadl
 /DaV/iVEQA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf_get_regs_user() returns task_pt_regs() whenever a sample of a user
task lands in the kernel. But exception entry runs with interrupts
enabled, so the sample can land before the entry code has saved the user
registers. Only the part PALcode pushed is valid then. An interrupt
taken on the first instruction of entUna, say, pushes its own frame on
top of PALcode's, which overlaps the rest of the user frame, so r7 and r8
read as the interrupt's r23 and r24.

Report no user registers while the interrupted PC is in the entry code.
Such a sample also gets no user stack dump. The range is all of the entry
code from entInt to the end of the save in entSys, so it also drops the
registers of samples that land after they were saved there.

An interrupt that nests on one taken in the entry code still reads the
incomplete frame, as its own PC has left the entry code.

Fixes: 9280e99d87dd ("alpha: add HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP support")
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/ptrace.h | 12 ++++++++++++
 arch/alpha/kernel/entry.S       |  9 +++++++++
 arch/alpha/kernel/perf_regs.c   | 13 +++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index 45d1229344b6..1400ba3e7d43 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -14,6 +14,18 @@
 #define task_pt_regs(task) \
   ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)
 
+/*
+ * Whether pc is in entry code that may not have completed the frame at
+ * task_pt_regs(). See entry.S.
+ */
+static inline bool in_entry_save_code(unsigned long pc)
+{
+	extern char __entry_save_start[], __entry_save_end[];
+
+	return pc >= (unsigned long)__entry_save_start &&
+	       pc < (unsigned long)__entry_save_end;
+}
+
 #define current_pt_regs() \
   ((struct pt_regs *) ((char *)current_thread_info() + 2*PAGE_SIZE) - 1)
 
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index 790389a15c3c..b8d7804e5aa3 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -186,8 +186,14 @@
 
 /*
  * Non-syscall kernel entry points.
+ *
+ * Between __entry_save_start and __entry_save_end the frame at task_pt_regs()
+ * may not be complete. perf uses these to avoid reading it.
  */
 
+	.globl	__entry_save_start
+__entry_save_start:
+
 CFI_START_OSF_FRAME entInt
 	SAVE_ALL
 	lda	$8, 0x3fff
@@ -479,9 +485,12 @@ entSys:
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
 
+	/* PAL_callsys does not save these, unlike the other entries. */
 	stq	$16, SP_OFF+24($sp)
 	stq	$17, SP_OFF+32($sp)
 	stq	$18, SP_OFF+40($sp)
+	.globl	__entry_save_end
+__entry_save_end:
 
 	mov	$0, $1
 	lda	$16, 7
diff --git a/arch/alpha/kernel/perf_regs.c b/arch/alpha/kernel/perf_regs.c
index 33ea2e831ba0..894683851b30 100644
--- a/arch/alpha/kernel/perf_regs.c
+++ b/arch/alpha/kernel/perf_regs.c
@@ -59,6 +59,19 @@ u64 perf_reg_abi(struct task_struct *task)
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs)
 {
+	/*
+	 * Exception entry runs with interrupts enabled, so a sample can land
+	 * before the entry code has saved the user registers. PALcode has
+	 * pushed only its part of the frame, and the rest may hold an
+	 * interrupt's frame. An interrupt that nests on top of one taken here
+	 * is not caught, as its PC has left the entry code.
+	 */
+	if (in_entry_save_code(regs->pc)) {
+		regs_user->regs = NULL;
+		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
+		return;
+	}
+
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
 }

-- 
2.55.0

