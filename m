Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E1204001
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524523; cv=none; b=elniPrVKc51Dud0ZBtmtDuH0kVFcma0E2LaHDzUW2pbeNzGLx0Xl+5Bstt6BptTR2pp/YLZgOjbx4wLYyqEQ4VOhsWBmE5SGfFzV1Xmnbw3UGA3NDrDqza1oS4Ma1ZLJvtN4zXCbynYZGq1PX9G1ZK5A1zKxW1BZBU3uuylUfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524523; c=relaxed/simple;
	bh=NbcQuU5q+usE1Vfx+epUjEaR55c3/0PQVXgf9pjjXZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rP8EUZavljGCosXmle+HXIKJAIPIIDHeUXU5zpvwd0ImLDI1UpOfsVc8yVF0sF/CHvAFOPZfYBxHuYMNojWvV7qQo2MlQLy/Yv5ChN8BdialRFx4rcrZhCTnJphgedkn8UjY/dOHsGrtWM9lZk7DrjRQbsIb4BbnQXzNjNVq0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBoq/cw8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBoq/cw8"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e86e9so126224017b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 11:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731524520; x=1732129320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps8myr2QRGzBkspMaTCSz6a/NGAbW5KYOWNi6Q8v63A=;
        b=wBoq/cw8c5N7q6THVrOltmzTzT/NDa7QGf7kh1ZsVka0e2woecpKrWoixnJSdNSiJE
         yuwf7jXVLylgRbbSE9yclBnIqtvjZC/L+0Qa/+x1ZHhHYITF1zgimscvw8wg2yBr1ZBp
         4HrkuyzvEIUsX65kFlSLDpKYSlmti8XWaHwlXA8L/bUHBO7BW1d9rKT+7ZzTuvPdu/B6
         9fkO2S7lSZ/QaormNIVeE1TTHLHnrS8Igqc6z8XJxNnaHXK6X49IpwgtlauY4KGiz+a8
         KosuUkeF5VSRkcUmDG+//oP2bt32Bod1/h/LpHYWm1bOotIY5pWWdn29liwYVvVTMUxu
         PhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524520; x=1732129320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps8myr2QRGzBkspMaTCSz6a/NGAbW5KYOWNi6Q8v63A=;
        b=PI/kqLyz3aA/NPdUgGYG8PNgQTr2Q9mFXkbYgxPC5/LUfuecdcnMRXWgaViTPFJlIS
         8U/tnJehlmMLeb30cqojOy4YhTkSIh2y6Ph/VKzXesD9CgZo5OQe1ZaHYWVXhWN+TELR
         mng62HrOainsY9a+MBHHejKSe5jD89eGHqKl3hUHQSeVpDIDit0CZ8ReqSLPeAoJQSWO
         ZxRWzjSiVbA3t5bpYqL64lgspsk8vUI++x9TpUJV9Or0vYSL4EhHC60+BG0dyeVgqe02
         3BIbMw1d+6dY7yY8Uyu6+qwQmdP/ZjbyAmMAReqJfzggiQjoBH5hQd4YUNQDzafMJVhC
         TxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpXvNkAufqmSBclrhUOfFl63a8oc6248hHDh45nkHyfLEbt73LHDQE/8CSPF2XVMBEqtStkDi8e4jf5mzukcfS@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnHKCtXWyaPi+2TzvlefKx+gGoDhfSzBHjTk5QtY6RW3VjWAe
	9x5r4/W/5/g8gc/brqO4mFp/NvCfZT1fD7eBXzGy3+H88io1keIBVrPlL9GpjKEehzaOb5XdSO9
	R8ySGirq6E5f1sbu9q3KahA==
X-Google-Smtp-Source: AGHT+IGMwJxojcrbV2XaWtAxjGZhIMKLD/TWp2TYO47jqONg2YGViPdlhPH/gu+8jwib2jMpO8Gmgpa+P/L1ZLf8OA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:3349:b0:6e3:d670:f62a with
 SMTP id 00721157ae682-6ecb343d0b9mr2033797b3.3.1731524520358; Wed, 13 Nov
 2024 11:02:00 -0800 (PST)
Date: Wed, 13 Nov 2024 19:01:51 +0000
In-Reply-To: <20241113190156.2145593-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113190156.2145593-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241113190156.2145593-2-coltonlewis@google.com>
Subject: [PATCH v8 1/5] arm: perf: Drop unused functions
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
index bdbc1e590891e..c08f16f2e2435 100644
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
index 1d230ac9d0eb5..a2601b1ef3182 100644
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
2.47.0.338.g60cca15819-goog

