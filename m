Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561297;
	b=fsAy3SN8HeYpv9xW1ZGJMx3+kXyoLDSimoIamYYufKh4o4oLt7/ArdP3SJFMZemWu2+u
	 s+ILiCRctaRGJRqIbG41mvxaU7E9uJ5qebu45eDOdd/jZvNS3F0RuVhiRpaCzwTUPNQCy
	 rZkTAXiY1g7eug6lno7q8sZBDnOAjmtEzNJiNDwQorZWZoMQTZfKGOpsOkp1gCrAxViaW
	 zZfsfTPOSclfMOuOVNIm222nSEodgt7CoSf5wZP0kR6KT4gSs2hSlJkIvR2Wl6X5LMpsg
	 b7nL5cx7D/02HZh1t1vdm0rm3hCBkMCEtrIrFlPBuGPTSxOGT35x2txNqrLxJaiEGTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=oSjaN8gq+uvyeQwJlExslk3+33soV5Wz90d5smnAJWo=;
	b=y0Ma/kf2S55J43xlrNDxENJIt0WEEcOHMxWen/23f/bUK2lvUbUo9IQRUGgoutZiTVmg
	 /utWhQL9ILvCpg1BDy2Mw6UsQc+oP9Lzh1xOQUfL1Ik07yQU89eWosE5rAY1lYWuWuEVO
	 tPBm0Jc6zXY0jSfurHfPXyEnARJRzdZLG3lrmeuEc6qA9mjajE6tn+2+OQ9MYS45T8gb0
	 yp2t8/2vAr98Q5Dv9W9rwIuzF+djp2KoxPOijaXTUEtTibyk3pqFk27l6mdmHWoXFHy32
	 SA8XpT4nx8bvo7d3/1A1kNs6GdlnXXwqzYtfUAHHVjUu+RD5kbHUWDav7JivS7Mm4uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FphcP7ut;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AE60A2603
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3AE60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FphcP7ut
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67b9bd530b7so1538137d50.0
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Nov 2026 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561295; x=1794166095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSjaN8gq+uvyeQwJlExslk3+33soV5Wz90d5smnAJWo=;
        b=FphcP7utCPD+/CiHyl6RbV+MwLmrVwhNJCw5PYbZMe+An9k6KQv9iq1c1l3OTNtg/j
         gV+kb0Jb5HYkKeusXj6hfurRhT3rq/nIm0U8erqK62ypB8cFi5b2nBbJ4ju0T+0DCmyM
         EVxplqQbRGAnAN8KDCTxa4gWrBzVtov+gVL1TXGjAfbDgccTuCuu0qhQ7X0PgqODrMsb
         4AZZ5Wm+AKLA4LOzsEE763WxgqZrXD0b8TTbBAM6BiMccm19b5wIIXjXzpnVqAbZp1YV
         vuL6nrqXTtcAvVBKdqhVQiMuzGcCOcZZhbo5wWHxSMEag4WyGnS0oGBueRNOSX+Ph5Yr
         zpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561295; x=1794166095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSjaN8gq+uvyeQwJlExslk3+33soV5Wz90d5smnAJWo=;
        b=Wc1o/DOh0r4WqdzK+hfRVeRIXpLjbHc94yrKhv2XLgqMSHkFwIh1KlQwuJHKtwJNaV
         ZbSlzb/7ou+p9aiHnwx8Wrwtc7FMcUunuW1OIP74E69fy7CBI0upLTYiVcFcyOSzU38p
         OhEzFXHL57KwFrZ2SMZF4kIDHRxaAXWLYVwoS84dH0cwR4kWF0woVhHEyF+1ZCcA8dyz
         wqaYZLVSM2YQ4F6AsZ/52vGvlaCNBJ2myXvIvFi3Ud6wgcs8eh35XZwkCY2KZRbJK4Nq
         LlS8H1kQ2wTHVTzqpkDcgy5CvsdBiiak9e0L952rq/iyfKl0TBOphD13kohKsgcoIGr6
         sq0w==
X-Forwarded-Encrypted: i=1; AKwUvBwDu8ew7gxFxR8kQiRLR175ZyoOJWTl6XZjtAveXnlGbVW313uEK875UK/BhmnvhAzbDNoQYmqOmGhDA+qW1xG3@vger.kernel.org
X-Gm-Message-State: APuU4Z+gEMuKtYlleuhcnhfJ9EinsfWeO1fmSjHmEFpPj0J8G0u1EUI6
	Rboq+WQ2DhRR0LDf0n+9adzf5q3nas6ggozWRpS+hJeCETHPle1XE4zj
X-Gm-Gg: AYBFou0aRyuM+hzifRs04wu/i35eP2qKnp9epQcRfYAhOqYJMd8CUqGjnrYCVuDyd2S
	axhFXp6fnap/5UiLPt2Ntsj6ua3SS9z5VgndTCjH166OYE5iZHTCvaGAZPfD3oFTQFTjP5wuC8o
	HcmQLFkM7tXBO2JvEmgEYwOSKtThlgLLKJC1Lg5U5XO3JfijyeSmu8aX4jK1hvqwV/CG0emHm71
	463vZYLSAFAvi8U6eseteaOaKPuViWNjOcZ8vodQppdwOTzVQ8IXxbM5hVq0QxezJVuIcBDg60Y
	w846G7MTcTub4ptOmfmUbCX+KtsCpAZSFJThGjiMI5wKcfplvTxfz+XAYkuSHYCPfWWKv/Bjqo9
	Ljr0Nv6KSi7TpfbbpRSJh4hD+7h+S2JRLp6vW+D/24XcOVVKJ6DC0v+lYxtLycov5OFNVegPl8O
	4DE+CQWNsj///foNfEEQCVRaYLAZ9j/JE0Z26RRu1cRgODMh53ycbnzfmf6ABcV16egFbmWOMmK
	J6m7O7tdriQmshlqPYj58Xx1g/vh+CsDN7+TTpLGU2on9YYwlsH+54pO4SUOZF4LSmchVIvFVM4
	yRGxFQcg9/90i51rAXatS21db4IWuBtSmD6PbTQr8dp/QWukktHlpBuZIoDV1sYIfW61BH6ZO28
	HXFO2aMhGsw==
X-Received: by 2002:a05:690e:43c3:b0:677:d87c:4277 with SMTP id 956f58d0204a3-67ba50f3afcmr3810702d50.97.1793561295090;
        Sun, 01 Nov 2026 11:28:15 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf147246sm3725582d50.1.2026.11.01.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:28:13 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 01 Nov 2026 14:28:07 -0500
Subject: [PATCH v3 4/7] alpha/perf: do not report user registers from the
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
Message-Id: <20261101-alpha-profileme-v3-4-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
In-Reply-To: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3729; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=j745NTzeMTR18QqhA7qldpQHNflfi9v6N9g1RNlRzvQ=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeTzq6Sl6wf26HPOuy6bzXHd/tkyo+EHgquN/4dgbXx
 etrG5qOd3xkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1H/gYGd7PV7JjWs
 H7R3lnVdoMNTZlm/DZc8vvn/8x377pzI+F/bGMDCs2y6y8+d59Wvelf+ufMVVo/J6XLLKPVfHsk
 rnr5Y71ybEAAA==
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
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/ptrace.h | 12 ++++++++++++
 arch/alpha/kernel/entry.S       |  8 ++++++++
 arch/alpha/kernel/perf_regs.c   | 13 +++++++++++++
 3 files changed, 33 insertions(+)

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
index 790389a15c3c..2de7cdd3a872 100644
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
@@ -473,6 +479,8 @@ CFI_END_OSF_FRAME entDbg
 	.cfi_rel_offset	$gp, 16
 entSys:
 	SAVE_ALL
+	.globl	__entry_save_end
+__entry_save_end:
 	ldq	$1, 0($sp)	/* syscall nr from saved r0 */
 	stq	$1, 8($sp)	/* regs->r1 = shadow syscall nr */
 
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

