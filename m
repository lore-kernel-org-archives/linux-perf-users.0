Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED951487DD
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482549; cv=none; b=BT3ODYrvupDMvo/W0jR8d1XQT1HFYFR16aHvfRH4RSa3XN4UUqzw5BWR/UECUvM9WUyYFg6k5G3/oJj5QqLBs5a1L03gap9qhELPJvdPaZBLNRXHofRWfSdUX9f1Z/pWWzj37FZn2otpxUXMoD7gSnsqtpKhpV1Qs8iuc8Fk4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482549; c=relaxed/simple;
	bh=Bc+G/ABmIxicp+Ktu0Km0LfXC9Azpt75Q+13cZSyLUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IivZy/fmnMrWWt+IeXwH3C561xySkteXyuAZgYu+JKx5sW0l1MdU7jaWFn6K4D3sK9gOl5kAh5suw5wsUt57VDdgURtcHKHZ5sFGmzSOEU+3EpexdziaCH2iWV4L5KE3/VR4gfKH2L9yE/zl6t250dBDLdDrRDoUnZ7uU4OkIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRVjl29G; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRVjl29G"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82a338f090eso764708239f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Sep 2024 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482547; x=1726087347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=da1VGWoVEM0srL8pak+5iYqVi4U1+WdMmmo+Uby7jLQ=;
        b=fRVjl29Gbc5EuZdxjwe6FzYonommB2vGrzHkHMwvG0ziX4Sk1vvXALNeZf6ivORasQ
         ox7wzpm46qKqTIc7W8zvBWgV2as80ZtZ9Gzggr05PWUOv9Zo35Ld1C6W1njrJtyKftC2
         5pX6lz7IlIDxRx95LpZ1s2q5mJ0b1kVN7JJB1Q3HxWa6a7m0aYi4E3jKct7dj8vo/+dg
         VPRdLp6dH3MQFeR/Fn7cyAmKeMnPevOpnZsA6rf3sBcOznaZmOf0ZJEwvsU2XA1CEspS
         vN/Y3dGFlkzU8+pnBrq1G6INbnSEJGHqw4/bPeK/XpFtdU/pCGSQkos2istE+DnJGoOM
         uHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482547; x=1726087347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da1VGWoVEM0srL8pak+5iYqVi4U1+WdMmmo+Uby7jLQ=;
        b=OTm8K7CxJa58Fhr95t9s05LgZl7Mv9hsxlN9wLe3Hd5hjqVEPkuq8IO+Tw4dlikRhB
         221tqTw3ExVTqBWaM+6RFpjYRXBlN/nmbMkjG1/T5VdgzgrfpcGg32FzzdszkjnyrhMA
         RG+nS5Z1Fed/WsCnXhupUtaMr5tpIGje44xe/8Fi0LMxYxRhsrnnBvTNBrklPFHI7LDZ
         HYbMvfzsl5psGQJ+4WC6kVmJ3Rpo8wM0IjNDTxA1EHlpRW13rFjuNWhYul/QiEChEmtr
         mkkm6ix1OZ/dGxLIQ1cFXzzPw9kyCBz7+hcJJwKpd5FeP16+/FsXB5hA5avkH9SOgXAL
         IXGg==
X-Forwarded-Encrypted: i=1; AJvYcCWDVSADm80Fj5FqT49DPgMexNXvaVTWXEpv9zYS0m0k1Ptw5zzC8oK9TwLCZiYaIPKvO9ukjmzXMcoUi03ba4dD@vger.kernel.org
X-Gm-Message-State: AOJu0YzML7Ajdzmm6iVtyEphZaVrKFhO/Y8xLefr6GfgUEf51hKTzfRC
	+Vm52Ner3JZXnlCHPP5fZo4ncaSLtmw8GCKQAhcIQRG2Z2oaUhbYem/7gNrEsCdCTZuYImzaH4k
	sLLn8zSVeOq01hn6l/FLH2A==
X-Google-Smtp-Source: AGHT+IF5VwhfDwFkkz0RNP4hdicHfuNY6pJqQwTSSeUmfbLEP1/IRR0I2ApAClPpKugjZhskT8IDcbh94c8otLZ8KA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:2396:b0:4c0:9a05:44d0 with
 SMTP id 8926c6da1cb9f-4d017d7b001mr570237173.1.1725482547230; Wed, 04 Sep
 2024 13:42:27 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:41:29 +0000
In-Reply-To: <20240904204133.1442132-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904204133.1442132-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904204133.1442132-2-coltonlewis@google.com>
Subject: [PATCH 1/5] arm: perf: Drop unused functions
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

perf_instruction_pointer() and perf_misc_flags() aren't used anywhere
in this particular perf implementation. Drop them.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
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
2.46.0.469.g59c65b2a67-goog

