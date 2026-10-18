Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5624B0E3F
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333337; cv=none; b=ZWijW/esWQu036fub0zG7woaSTn1LeMP4ii5xYGLLFUZfmiUgqsTJU7AZLTCf9GSdw3ng44ceOTnnlgLerHz93b7gmU2iPg+w4WBhKa5TmEfOs+B93BZx+8Wuy2KWTihBM2xW/YajBtjijlPKbkPDve6YbW+lESRzp6YedTRLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333337; c=relaxed/simple;
	bh=3hBEoYmujIN/lIM+LWmpcdreauHJLGhIJOlga1pFDNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+2UXayBVZjhkfvcPwO/d5yczZKBgIeicADHSQA1dS4tpBwYYJbRt9w/8Mcs551PfSOhQljC6OurPbwVt+s9/vOV7vS8UJ5xmWqn9kFTojHXYggq0/heOlhiOsLEGhH6NJn25UnLa9jUj8BxvWlI2i3bsq2BzBa46x7a712CDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKuopU1I; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKuopU1I"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-87ab6e5f91eso7575137b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792333335; x=1792938135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8OpYwKY4k0JzilSveCfUGKhXNAVuzUj6LeYu6BiAQs=;
        b=eKuopU1IGP03p8Xua8yrk/AbfC5a0W/QZ/fCtFLWnnuF1xJUevvFV+cM8hKK3OA8lN
         h3RFUfY4iuAEG0vko5PVQTddCc8eJhXYs0A3dscENbJ3KOeLg6Z/yYhnjqj/L/1wIKa9
         xfz/B4rFxdbY7ris6EdrrOFFk0oVe0jizVURL39N5M032keW4MfNtOgSuCfPwDHMyOE0
         +99HVF8sta9mgpXE6IP5XlBNykZtMPUi3uPIER7ANf6hicGU431OGh6vhOrK1Sy7/3hf
         oHHjkiwi1ZZQn5eGcU7XmODwNwhxFdvSGezLMs2+UwXQT+NEv6lVrgk132UGzr6GmVLq
         lNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792333335; x=1792938135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8OpYwKY4k0JzilSveCfUGKhXNAVuzUj6LeYu6BiAQs=;
        b=FBdubNeIsHGVcWkXUwMgcxrPN1C48isQxU0rVlvxFjzKOUOK4+iL1jX9HlxTSjRC+G
         0fHOJ69ro5hB5l3vyrvW3alG2spCyS6f6mVu9u+pYrF/oqFVIrp9PqtzjGvxm5+iqiNm
         f7fIWyYXQ6YaaV9d0zWXzY3ZXfKFQ+PkLlCbL851QeYZ2xeA/J22iCpOHiHnYGRZ3EmB
         EHKuKy6v/T8lklSXF8HNj/Aarn5ldVohOAsRYp7FXyDUmnyUY9vuOTsK5nBJSlrXWbMn
         FxsbE5Sg7EoX2zXLc9ya52k031j58PnNoxsbIYn9WfKYe75w5AhXTxqcKYhj9tyNQ5xY
         iSRA==
X-Forwarded-Encrypted: i=1; AKwUvByYXm1dFP3AW5YIEWK9F/ix9meWTrKmM7TBYH2Tkwa4TpIX1nvPpxAHcMxv7g3m0aCJg1NL16Wt4d5eTpngt5Si@vger.kernel.org
X-Gm-Message-State: AFq9FYJmjIEtcbU7OAUFdmbChQsCX4B4CEBI9Dn24A09SIQNQaJiqigb
	WgGB5xS1GAaU6L6ny8mehJWifbdhzkVJphSfzeUL/ainVYGnvM3PLxTiG6TB5Jvl
X-Gm-Gg: AYBFou16+sWZEHcKcpNPGSUAGbP3f3b9QlnqyNuyS+LI2KW5lKwND1jsFqTsw3lXibo
	UCevNppRZt3kIKo/r/7VOrUTk6vgGFackM4SrXGNTbgYt36TvQpIQHoG1QIcvFkobO2ut1U4pKU
	04v4E28zOf1OpFZctaZkQGOEJsZRM36lUma6Ba1ZDChNDvaeIRH8AdFK6sOfMiFozhxAZ6CQ9a4
	19koKjsuWjTNGwqxUHrCNfeNOcaEe1ySz1ssL00NzstOrs4TyuB9ZgqddRjVzDxfLZ2EK5Y3GSt
	bYKS1V5Vof5hiT3ajQ/8iXzpdvNItai7inuDBqfOmR46iHYlB7bB8DJkzIGpg5+aC44kQjarxfV
	oO9Pe9sADZI5sljyGl0qEhgLxYN/27wC9MPzqGWmIyeiVgoDrY8WBlB/C5BTE1DKsJ9LKzY+XX4
	uLOCgZ8yXV0HlVpAK/TnUVi5ODxMOg43V3YN9/TBXmBUFO7Z2shFz5qX2jhGf4OQO6+RTy/wwYZ
	BiOagX/EoO2OWA13IRRyeJoNl0bliWf96ktNBmAHx9AKD/XNgajW9WWxcc++1eIqHGlnh5sK7Zb
	Q6e/I1G+zYk3jqSEL1PRi6eiEIKB
X-Received: by 2002:a05:690c:4d84:b0:8b0:8a9c:fac9 with SMTP id 00721157ae682-8b0f2170e34mr16917187b3.28.1792333335205;
        Sun, 18 Oct 2026 07:22:15 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58e0258sm30708737b3.26.2026.10.18.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:22:13 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 18 Oct 2026 10:22:01 -0400
Subject: [PATCH v3 1/5] alpha: fix stale user_stack_pointer()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-alpha-perf-regs-v3-v3-1-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=3hBEoYmujIN/lIM+LWmpcdreauHJLGhIJOlga1pFDNU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKuXON8d2G9rfORfxuXS0juvBia8u+1Q8d3Z6/TOn739
 V5ZBOQEdXxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1278y/A+SvtLl9z
 F0zv32tf4NTo3/Db/wLqhsyA2X8tJQbu71qGL4XzA53prLtT2LN3Wpq+erVVfOa2ZNzfDySl38K
 Hd+p84nLgA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

PALcode keeps the user stack pointer in the PCB, not the trap frame, so
pt_regs->usp is only valid where entry code stores it: entSys,
do_entArith() and do_entIF(). Interrupts, page faults and unaligned
traps leave it stale, and ptrace and /proc/<pid>/syscall read it
through user_stack_pointer().

A user-mode pt_regs is at the top of its task's stack, so find the
thread_info from it and use rdusp() for current or pcb.usp otherwise,
as KSTK_ESP() and the regset code already do.

Fixes: 8a2857bc2b30 ("alpha: enable regset-based ptrace and core dumps")
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/ptrace.h |  7 +------
 arch/alpha/kernel/ptrace.c      | 12 ++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index 430e8dc27ff7..45d1229344b6 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -26,12 +26,7 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->r0;
 }
 
-/* Helpers for working with the user stack pointer */
-static inline unsigned long user_stack_pointer(struct pt_regs *regs)
-{
-	/* Valid for user-mode regs */
-	return regs->usp;
-}
+unsigned long user_stack_pointer(struct pt_regs *regs);
 
 static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index e1d8c2f69688..dba7e9905cfa 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -440,6 +440,18 @@ ptrace_cancel_bpt(struct task_struct * child)
 	return (nsaved != 0);
 }
 
+/*
+ * PALcode keeps the user stack pointer in the PCB, not the trap frame.
+ * A user-mode pt_regs sits at the top of its task's stack, so the
+ * thread_info is at the base.
+ */
+unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	struct thread_info *ti = (void *)((unsigned long)regs & -THREAD_SIZE);
+
+	return ti == current_thread_info() ? rdusp() : ti->pcb.usp;
+}
+
 void user_enable_single_step(struct task_struct *child)
 {
 	/* Mark single stepping.  */

-- 
2.55.0

