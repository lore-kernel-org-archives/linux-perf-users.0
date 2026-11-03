Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674928;
	b=LjxxueYblt5WbDcJcXFZ5HwjxDEu+Qqz3JJ51iougELBsMRf85l4LH1fIiJ3iDBlihDY
	 Yw+vGeNS21tLwT6atmDmnphVMVUHeaw5sNTQPmk+zXjB6nXOzl4DzdnwqO1Gmyd2aEY4M
	 zqgjcI5ygY3Gv/z7iST5herbkfvzPYQYHtlBISHp4HqwMoLo6NBAp5VucmL1sMBPwCSY6
	 p6m2onTOxHbZcf29iUMGPVwc+pRXs78APFPFihpcsiHCWr/Ve6RqDJqVwAOunbuqfolq1
	 txInQROyt0txUxhJ/Qt4aCLnuyYVcxexCaXTw+C/KKrAfgot54tvHwB80I03xwz5keQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=OGPOS8a/gMzDgkVkZsvuazR6ZsFinnPxcukENTgqxQA=;
	b=ixpEIG+zolFAYFE6d0a9fLzlhGIVTXkEDwCcaikbJf8EkQvO8S8gQWUsBt1ZJH+NbBME
	 XsgYumNPb5/wridq/qXYvAmv2hy0UX0AyTcq2pf10UKUHGDimmNNg4l3S9RkpMVdTPuff
	 WXsmGhbH33k/4gcnsghgpWZJYpqqpDKqLyI4/h9hY9SISeitYp+ZyUS0cPiYyqOiW4bKi
	 brpek6sUeChAA72iTXZbcjTLQ/r1wRXZChPhA2xSYAhFJjdXP9OsKBkkJlGFxq1yYxvu/
	 QKyWUDSyv33W4RLJ4Tiw+AzN0wXKJeCm44bD+DBdtLkVsQ4VwTPbc4bJzx/jmDOmt5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxOEOGKq;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2E606A333
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB2E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxOEOGKq
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b2d149693fso16197317b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 19:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674926; x=1794279726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGPOS8a/gMzDgkVkZsvuazR6ZsFinnPxcukENTgqxQA=;
        b=yxOEOGKq28VdK0l2tjpfm7Hd7ddXHnV6YxClbgjmwT5KIp1bVgeqbPwcMsKOtKB20R
         lUJIjBcj9cblkJ696K+V8nWdrE9Kxx+lljVVofqappvyII8OE3UGg/WeBAr5ouwho0+B
         cxYM65Vt6ewORuqmt2nn8X7Iuw4nBCQTpbhS9I6esTlWFi4Iq74xD1YaZtwXP4LIOEVa
         Y7o61M/8WnkIaKulVc+q49IkHda3sK9u1fVV3ybBq3kX1fyepWl7bCnYPBKy/QtghUPj
         vwmvh7RdOwEjX1D0YxLq+CZ+CRwhqDG82thVruxaJlKVXf+aN8dW+gUanprly0aggbBy
         JbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674926; x=1794279726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGPOS8a/gMzDgkVkZsvuazR6ZsFinnPxcukENTgqxQA=;
        b=UUxyVC9w7jYQ/RnE+GII9MUBV05qJaT6NrfU2yQZZ1D02jWGhNqhQrb8GE5x/hKGjA
         Or4rf9jbrKBcSdlvLlg8++/RmcgfiDwa0bwaRiKGrVfArJi8X90bvqVHxd8xhs23hMKL
         PpNLy+bAhW9p9DfMOcnqdty511bA9drI5qYJp5QV1tnDlxrgNS/18b3wBvHSfqBsnmU2
         O6sbYZbSd4SuYU/6kWiBe7234AH84VgQEp1nkKasr9guRdQR3mdb9OBiqKON7afCM1Qo
         Z0+N+jujEGr5IYTXgfWf1cGYtyVQItsxIChrUN1NyxEHnqbNDpqnc8dAU3NNoOaDnwZH
         vwqQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3RqBRrE7ZPYrwm5OGvBvfb5793XsREtNgwu62jjARDKc75aF/TT7nMR9s+dsGM57MXmVQ9JnHENNo/K/+03ML@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zxe5Ptj3pPi+qrhjp1309z8N+TnvNsou/lrX1ic6mTzPCbDpg
	6IqAURfVv3Tst/Tbrc1VLkA5SaL0Bh8tVVPO7XyeK78sSdD8S8wBJTGgOxPrvTg3
X-Gm-Gg: AYBFou3B0x9yh8zNDAi4FSqXdAw93cPxDSNfEqZVpuiKAtzPBbsN7O4Oixh/PGoyfBw
	jPTDcoGDxpg4arwGElRiauKGLAFC2qZ1fRgtpgDdCYc+hafizVzvgstkta6A1Q97tDu20AnztiG
	qnhHq7BVy6skxSWcU5x6Q6jzCbzRo7o390VOWOIHMb35SaP+iuzzMzO4e8n+3fa8uHNGyS1J72W
	2gh0UDkHHGfZYGZAW4KPbtNmdB9oRo4yPhFWw8Z5KwRyzSYazoqt0zGbpaIjFZhsLawbpUN8Aec
	4UXWvLOqjjVpQ/SZi8Eeq96tNCeNzvk3MKkbrKZ6DTrOqPsvznp32UNr2d7aB3yjKrgXZ9JI+WT
	lMt61Sq3kVzju/FTbjCstzGtdoB1MpwPJRDmoInKLU5O8MrDu9ewXYZ5YYR36LVf24Gybls/vRc
	D1xc9pSmomQ2f0LRaXrfpQMcp7YFGOfS9yRNjqHAVAP2paBBk9p0nvh+AX+e7s5RMkJhBN8AlQf
	/U0qnOvg5TIlCDR2Q42mRF5gn0+2Ylnzn3orBk6BYPfdqOoU4tvz45zHkK6/1uYQJJpdR48YtrR
	Qy6NpAiPhYBpS/x1yvUZ75QU1vXYAEgYAyf0FUm4dPqW36JM2NmH6qAVblbQl1zKx67qhnp5KcY
	n81lGaCINtg==
X-Received: by 2002:a05:690c:c105:b0:8b2:91eb:c0e7 with SMTP id 00721157ae682-8b2b6728887mr62857767b3.42.1793674926384;
        Mon, 02 Nov 2026 19:02:06 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf26e646sm6225067d50.7.2026.11.02.19.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:02:05 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 02 Nov 2026 22:01:59 -0500
Subject: [PATCH v4 4/7] alpha/perf: do not report user registers from the
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
Message-Id: <20261102-alpha-profileme-v4-4-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3780; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=jNR7O2OOmkFHrngjpChvruYJ31B4frktZDdtlTtO574=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe+i3e/Svy+ouGljXCs+rez9/JKtqYLjwlWc1IULqo+
 t48D83Yjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmKQvD//Drx8QKvt
 x1L/j95UlAT3aRWxdfQ4bQ9spz6U324esjFzMy3JetqZvZu7NkvdvxxlR39YQ9jPJ/Mgpsq1l4y
 5/nH2dkBgA=
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

