Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3521731F
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006267; cv=none; b=XAPi8JhoOyZDo0AROu4FrJllisUj2clQe6Hou+XesSntS8xDxd2sXcueWTtf1gb8wIRzPiqSsjRa2q4baqIMhlnYuctclzvAIuySygUneIbWzylvoBxcqstxmtY/gc/4zXin+Q76saMk4Iq3Crc/Xs+JgmG3wzHs5mST/Hxusls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006267; c=relaxed/simple;
	bh=sUUhEaXz7qouFXp6V7qub26m2FKUcZRL+G3QZnBOnUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OTvbzT460krHzYHkoMljNAO/xaDLYz6nnCuMKBXuyEIIFsFitnuze2AMQcaZeeeVAX7E+NZ10eupI2uwhBBTRKc9J6NKqwsd0gbrjPFg77U9xcFMCNcKqqGipwivFOX/EsqFQrTCgiHz9j+n+6IBTCZO0d2ue1AuEYtkIKUhh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qst45lFF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qst45lFF"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso2114902276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 11:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731006265; x=1731611065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wi9gi3l/lEEfoRFVijXJDElnYTy8kzLmpCkQO/xthe0=;
        b=Qst45lFF6+KTG8ySrvS2CAe1U7J/smagjGni3hNVrMlQdgk6hIW8pEzdZ6jx7eDjgk
         yxCaCX4vZEfNJrY7FQYUCmsp5jw0uEJlAezRTfmhEVBUF804lA/YkWWKE+P+UP6uXZ3w
         XexlLJkjXVGgZBtxBVcg2QCCfBePD6KsUj7cjRIubZlZ0CNZAhMeENzE9y7NJcAERlA5
         nb7zqJszy8U3mD2+O5doUqd69MV7gNLdg93+2MzSGWZUi/P8iJndkIkdXiYxNDGBZ4kt
         ARiabd6xqVRy7RjL4qObTLsQbRSl8+QPS6wyh+ufUUWprQUe2zn4o9m98Kik7Ann/VHn
         dEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731006265; x=1731611065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wi9gi3l/lEEfoRFVijXJDElnYTy8kzLmpCkQO/xthe0=;
        b=TxL2Ou6pnV8XuP4QYcv8Mq9QfDHr7JsHlrqeqmPmu0yjL4JKc7CfyXUxA4YeNLRwtL
         1GOVZyW5OW9FwjmjDI3k1ExGEghEMkKwAkVxO5G5O1da1ojzCqeNELvTEe/u8mugSFxp
         ApjIt00BWpQv7Xd4XnoNmlaGWURooXotCFYCviNom2L8iVhsFp+dMRopOXSBVVbfiZ38
         TmsOxD3HvbYV/4bx1RKmEMxHhseQDUYeajzot65lr80DlNJVryIT3vWnmq92WHG2x/IE
         5QrZRT1/HuLlmFwkkOUxY+eH+LRP7A/OrBO8/3X7RfCGhG9xLxwbTvN2haVncxrOegcj
         fbrg==
X-Forwarded-Encrypted: i=1; AJvYcCXwSPhQnyign0lMdzqi3JH92oc2j4lIdTBtaq3SHxN8ninkTCPzRvAZhiqMx1BQjMHm1Lk55QBVnbjA26jPvQNB@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmkDfH3wK8/6TqkZmhNx+nw71YWQFU9GLnZ2TpTunwKOSc2wd
	rNIjhMRE2AT+oNFyJY9+R69dLO1yUEBySkBgChK4lcMaGqNYMYku2c7DjtrCYr/EBr0nmelFZdP
	+CDokHYNDWzCPdj91l8zfeQ==
X-Google-Smtp-Source: AGHT+IEKv6NpZXqhvRfRHQ47kqAQcfmWLHCmkCefMOP8XuPLyyw7HdRAVBxL41mFzSkxgn/PcAHTCxi3L5lNVg+5sw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:2905:0:b0:e28:e97f:538d with SMTP
 id 3f1490d57ef6-e337f8ca9famr44276.6.1731006264559; Thu, 07 Nov 2024 11:04:24
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:03:32 +0000
In-Reply-To: <20241107190336.2963882-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107190336.2963882-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107190336.2963882-2-coltonlewis@google.com>
Subject: [PATCH v7 1/5] arm: perf: Drop unused functions
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

For arm's implementation, perf_instruction_pointer() and
perf_misc_flags() are equivalent to the generic versions in
include/linux/perf_event.h so arch/arm doesn't need to provide its
own versions. Drop them here.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm/include/asm/perf_event.h |  7 -------
 arch/arm/kernel/perf_callchain.c  | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index bdbc1e590891..c08f16f2e243 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -8,13 +8,6 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-#ifdef CONFIG_PERF_EVENTS
-struct pt_regs;
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
-#endif
-
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->ARM_pc = (__ip); \
 	frame_pointer((regs)) = (unsigned long) __builtin_frame_address(0); \
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 1d230ac9d0eb..a2601b1ef318 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -96,20 +96,3 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	arm_get_current_stackframe(regs, &fr);
 	walk_stackframe(&fr, callchain_trace, entry);
 }
-
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	int misc = 0;
-
-	if (user_mode(regs))
-		misc |= PERF_RECORD_MISC_USER;
-	else
-		misc |= PERF_RECORD_MISC_KERNEL;
-
-	return misc;
-}
-- 
2.47.0.277.g8800431eea-goog

