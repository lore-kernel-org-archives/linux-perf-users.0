Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738265;
	b=Dzod+LrFMeltaV85BV8IVj0E9fMETY4zFfv5rYUSgxuiOtBWWQyUYLn7V+/vUIyQmwvT
	 Uz+faHaR7a2RhWyLH9bslhgMFganBLGs/bnI223q3gsSEJMdUROeda20pOi0Y55uDJPdH
	 0EC87D0TMlM9rJDk5px2TtBqv5g3tDFxLujvst1YhdgmxPzxnunFYoTeGiRTpQHWPZEvj
	 SRkxFtR9ScHzAmP+c53Pp5ngiDhOwhbo4Vki50O9KqcBWSCTj0EFa3oiGo09qcY72J7pk
	 IZ54PwJTJXyASvgySDoXpu2D1iC4TJyYbH9nBmzOElyJjRba/6SXs0rCQjBuGLaEDbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
	b=eSBnqBe6ms0PwwaGPK46jiyX25SGSYPueYRSGlrRiw3Mn6jvKORvB91ikFV6rNsJK9Zx
	 TaO62Ai98rW1uUp9C/XHUFQwrmgUFdvnciyiQasTiQfXbxuX7OI9vwuGLMJIC4ZYdqjZX
	 HmFasvFbYiPjZV3lHE5sgKVA1RFH9XJ9waU/SrP0qDs47/Zv2claJB2w5qo75jVi7rEw9
	 V3cGRcK8XbfsF0oG8vbZh3mMEJ7G08GJ0IEiDXRFS9t5SNS7N+nQ3NyCarDVHPjOvK8vf
	 iFfx0aiPQTYTpVxOFbrL5Ec/sn7cIRNhMZiIof1lkqlQU5/BsIrs90XBOJCpEt+EKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b2H3uHIE;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB80606D813
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB80606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b2H3uHIE
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b056d58f2aso12327b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738264; x=1794343064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
        b=b2H3uHIE6MH5SCNXmTqyQmQw9x60pFn5rWYqpuCa2D5eetD8N0iFCXIIZY1kJC4omS
         e2rJlxWBymAFAnIQDoDpq39Y0ZbORYn9SnCIuDKOv/Vosa+P8gSV2GH7hVvH1wDmI+vD
         8ifAyXQ5QtO8+yvJE9ldJjvqy4u97CQFrOmzv7w5jtArrOFVfyxAuwJJa/08JAof9hqJ
         cbG2DtIqnVF5VAOAczYP0fDP9Fdgv0xFpisISqWEWmVMZHf7mGKAjBzVe4hIDfL9Zoeq
         +hgyHpWG+hWW9QQiEuc1fpsYSJ7/CB+dj94AbOayvC22CyFsccCyWTcvG6D2YoynBEGu
         MP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738264; x=1794343064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
        b=WYtbPMblcMDMhkJ5Ruu5YpXbMdBz309/IJZ7jjvfNHGvaX0YlBRytU+AxtXw2S+s5H
         sfGDy5QVnVgTRD4gcog5iwytrExkKZ89chmjx06/DJCHC4SsWb/yAo+2w34Utx+OgALl
         236pYCEnncnw1y1lNKF1CaOysn38ov23q5tenEvIU+o4TqMrK/ydG9GsHR9Fd9grq4nD
         W9bSoOul7/Idwr8jYZP12dy7vy+3KVuTn+6d3XzRliQi1bIsATFC2xyQMhnGU2uDyAV2
         rQwJpj9JtR1CeqJMDQ/7TWB2I66nihSkYQzbwkh0VhefaNTzwd6UR4oWq1GEhPLx+kid
         GzVA==
X-Forwarded-Encrypted: i=1; AKwUvBwD9D2rI/GSB+LDSZ5tBJFI+nKmun6ui5DFl4/iELSESOF10bC1eKRijNIjIAwX7THb+oj/m2QFhf4G4HBQOxi+@vger.kernel.org
X-Gm-Message-State: APuU4Z/aJ75JaQDp7KimMNCNlARFbbBoIZNZPZnDeJqBsYAWB1QDBFKc
	FwuZJXWU+8ml4k27zFv9WGUhqFttMMBsR41nQ+ynvNOKX9cH0IemnX8Z
X-Gm-Gg: AYBFou3H4MpXuUZNqYWFAaavG2/FXzZm11EQ7mA/pFpt67jGU/CiUwM5xZnNtFjsOGn
	50l2QKI7uGp/YMSQaf7haMgAsyLbhln7S/mlcj9Ki3c6TQC0NCOxmv8SErTxltaTdlasD11Dzlg
	NAo/KgeA8GiooolIyN6XX4kB0EMw/qp+mw/8xiDARbKoIwDkFMUkB26zy8nh3Hwfnd3K03B4Xzh
	xffFBErY6gPC1kpJKRy8mSOV7dV5ahIxrQtIEDyeQAGIhotHAyGh29kzQ/c2b0a9j3Ba765h3ic
	/VWDTnh40nWwy6YOgHP0FFb/EkFYroxDQpLjxipEFPHdiZFR8GzO8jN19LQ9RemJjZusz5FK+zU
	ye6ljQC8yCU07aWDB+lwlStwhvN6DPTv6Hl6RGDrwjMrc9uRbx7faYZwQw5m4Ytz2psIAyXFjfn
	9u59/hxPBamX7v2gZz2FZQfaKIsdodRzA5/9xlHLr+vRnT+jSgpoTEXB/TGsZxVVRKWSyqsXh71
	LO6HGwhakZ/aAYzuKIN4FT21KSO1bllUHpSbaZqhF9Z+yAhGUr0bQ1WOoXhl5a0RHNim5LlzoAK
	QSa9yA3o2mnl62cvlNAYWXbnDu7wBE8d3z/Cllhtll5DwauElxcLTrlIFs6cRKED9otPkLKkHoq
	mE/gy4GrlsQ==
X-Received: by 2002:a05:690c:60c1:b0:8a8:9149:e4da with SMTP id 00721157ae682-8b2b67fe3aemr79052567b3.108.1793738264234;
        Tue, 03 Nov 2026 12:37:44 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bd1672sm4541337b3.43.2026.11.03.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:37:43 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 03 Nov 2026 15:37:37 -0500
Subject: [PATCH v5 04/11] alpha/perf: do not report user registers from the
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
Message-Id: <20261103-alpha-profileme-v5-4-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
In-Reply-To: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
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
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeufHZGzuv7D1wpD8wuLhnzfXzv/yZze9U/tj9weH6g
 uzWY6ZPOj6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaUD+G/04lnSYKDt
 uapLXuFxrMdDi4YnIX376kg+9P7f7L3CK5RomRoW+Gi3d8WoBETHjHvZz2IwuDYv9WVIpvyjVws
 +ZZnfaNFQA=
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

