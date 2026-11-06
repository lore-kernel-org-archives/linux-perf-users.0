Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939436;
	b=s+MIGvGRSTOO6oCHZk0ebJrnqDa44jD1rbaDL2UDx3uUNv0IJ0k1yjO6Hi8rDiyVcJYu
	 WpfKPcbb2HXDwHQ4pLAYULmK6jbGFzAk18dVa+fGWsG58P9GH7UfID/7hYK4Nawc7x1du
	 QIv7zldnWKQNah9r+JVFUOZARAFu5x+WW/nfDZJMjFKWpJeovpTp8KBYZvpC/JWfrwAce
	 Os9/ViTDSWcQ5wSMG/dmzlTWERqgUeFMNU9XPy7khJeILtZHuSnONGvayZETECBnhVQwW
	 GCrwRCHhkCyF+04WBv5UeTuSdxrR1A/g4UCzR9ireq5ov5FkoQxSVZSJnUP2y8OO6DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
	b=Sk4YhUwsC+oriWQ6S85L3dzSXDEJU51Go9VvvwyvrHeHDeXzFLk/vdF5qXUnBjtmnNyT
	 yMiPXxGxu655WilXZC6DumdsAT0LcYC0HRJRW68cwXGxntJkH8wTfgNDs4L9ZB1/B5Naz
	 vrR4ecBjAOVHmAQryotDYv2jxj6u9z5bh2eVwjaVgnZxKSDySnKtq5Vr5d7u1i88YwfBh
	 dAMPuCC9fDcCfavJuBwXwNx8+lyxAjffT1dIh13WtBxkAfqDGfyxMfO/6wO03qimyDnDV
	 vF9f7pixbTw4xJjBkyw1S6g1BsKGTFaTaWfD7I4KnvDXo6NQju/LATctiZZIUXhy3yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dksUbeah;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DE606A330
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 209DE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dksUbeah
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b33de9d2b1so1119797b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939435; x=1794544235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
        b=dksUbeahZ8reFu9wOwXHAIUKkSljyGXtB7Sne/QUYMi6K2eeS+eI0O+2atL2v+wz5P
         nLpw3dDQ257aN+8bZ61k9Ol5Cu5ljugc8G5M2a0mI1fRcmTmgtOEax8D2fPVViXhESwc
         fYre8Da/L3y8B4sshYo5QS9P+y1NEWh2on7aAJov31U29k/SdGrMVwfYcK5NsdAlWpES
         hsKu1cXYZSPmsQe9LyTpal5Fb7xMtRq34SpZBtupHqnavHjiVY8U9nLxCeS1b6IV7//N
         NBXgAwgw28ZeliHf2RBVrPj2jfIDiVR+qAexgCExLqzgcuRHMARe4az6BNLoxdRr1oCk
         ltLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939435; x=1794544235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yhfMQyhA4yeVo/bZMJr9JjklAVTmBlY2c8c0GfiXoB0=;
        b=CqQRy5DazqkASFOoEufbgSqsb0K5fuqNzQu8Lll5P+TYV8XMSyXUkHSx/7As96O5UP
         kfQTCnl/harGDLXAlIcrTdxZ5lSmqttikYMplkwiKCdb+OjHsqCeN40K5Wj1C85ggXNV
         y4952fbvNsyGAaoiDkZ4j4pSX3sN80BcoGN0L+84ot/+ZszHlJSzb/bknkjIEFtj75Jz
         IOXnIZD891i5hcXfn5EvSm8NfR+BX/uQwy+2d3t7FJVkAkle/EZTSQFNk0oRYJg53GJo
         4CVXgcX0KGz1KPdDG8l/MDSjZCPDOdqtDSKawBYoGnGm/QTdBbiOs+rNMWaCxO/LLzB5
         BobA==
X-Forwarded-Encrypted: i=1; AL+hErGRWdy9sVnA1mfCQeV7BbYijEKj6uHRqOR+ZaLiwYu/L/7hd05HqRcNBlPG8OD2xarWY0uOTcjDKI4spyL+L51O@vger.kernel.org
X-Gm-Message-State: APuU4Z/hKaiCuvf8ZM0cTt0CfhLiheTAUbL2on3olRL30rxXInv3n9B+
	nvmXjJepm7fXOVWUsz5ZfdN0HfB9OqoeU36pZU/GBBlKwbgCAbunecVi
X-Gm-Gg: AYBFou2I5+0/RY/KrUSZA71FBk0gWqM4+nHABxFH5yCh2U9x8CKksmzTmIeMnSIyLL9
	bKb46MDNpuc6AedNWvYcPlfgnw6yz3hUP0hYr9LiLuLiIsfyifK/kEf5hyUa+MafofB/lwrHrMH
	TEm+hdt3q8A3iA5WPSjE5SUBDCnGg3vaTVJLX0nO1qozuLJy6MfcCD+2yCOMXnSpPySQ5NaQWcm
	KrT822Xm4uvgexJgQggf/LTCJGriLR3zK3T+FHSsQRWZMa6QQ+q3V97EX7l3G1VkvDrMYax0osS
	EVDrdB3ZEvhWRfHKAN1c+4jWbX+R37CYxzQhQkPTtYWb/XiuPjFpzCKLIegdvdD0N9W6D8uS8By
	CTKUpqlMSTJYNZcUaDkRspL2E0V6gvd97tdHxDVaEHBGXYrO/MxHrYgR/iVVaWQAFWWxRDpRPRZ
	GFZXJuw9uLQXW+NH9YNDYnmKReSGvZV8GKfKrLRMpKvzFwKsZoOvKTd5x2lLbuZHjnkJycNGSUA
	tmD0uex18u1lGi6m2LfVK2dNwrQJw+TdgQR9tMsavk/K2YGp1ksShCjOPdU0fV2s5a7olQNniqi
	Yyh0OMTg77dOT47SO3i8DQo9N0SSLk5E7PMvy4asuF3hXJC2CN847cmgUyfOlOQxzCqTCQ6ey8R
	cAbqeornuxQ==
X-Received: by 2002:a05:690c:39d:b0:8b0:875d:d4d8 with SMTP id 00721157ae682-8b3419c293amr6075207b3.88.1793939435188;
        Thu, 05 Nov 2026 20:30:35 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f3161sm11430927b3.6.2026.11.05.20.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:33 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:24 -0500
Subject: [PATCH v7 05/14] alpha/perf: do not report user registers from the
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
Message-Id: <20261105-alpha-profileme-v7-5-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3878; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=LiN+Yv+pum+ZIoYCbCmWoIHtlAzTvYQXPQL0PlKXs7o=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht/lmpUzR87t/S379Zd8fDzqVynPmTu/Ie1Yaf9e3
 cfZnY1MHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHONfgPD//BZhwKP7v
 0Zkbu61uewyqNFy7XXiUW7TLgSOmU2h/DtDa2MDMuseM42BPuGGEneCa//eHFXpMyua+wSpdmye
 alND7gi+AA=
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

