Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE2F15E5D3
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482554; cv=none; b=noUXh641A/eqY1Tox8K70bJ1r6zSE7USDiMiON5syx4aKi4IkK90e6sq3xbyKH5oU8x719E78fuSyhMpWl3I1YapgyGhCWg+kMie12RaPUzk07rngh7DMkZc2EZNQ6ryxDd50uib7OoyQfjyGlcInoFUjA+DWtkbPUY2byJuB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482554; c=relaxed/simple;
	bh=03a6lGwIb8EWUW/4KBYQo75tG5sBT5AYfr3dT9mgeS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=reIiPZbBvdBkL8Wv3Jt2vfdiYb0LlCX33ldrHCOj8gfh/0yqm5f2OnSfkgMHHxduFYFxDPssI/+65oQ08FaIpikFgremBNQ2d3uvK5XgXsrmprf7YQJ2gxYtL78IGRUiowfH75OvMUffniJUkRtin8wZsCIWQzI6KNLcS6eAJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UMIRO1R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UMIRO1R"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1ce191f74fso162857276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Sep 2024 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482550; x=1726087350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i72PSOIXWhCeY4HgM9YgFlmZggdii21Cl4McUfu+68c=;
        b=0UMIRO1RHKYuT4Dp3PVwJXHcefZXwUBh7fK7+/lU+5DSvgwEjyuJHIGuihb0l4oTSe
         c71pJ1VvgLysFXjTHjuqgB/Oa3oEVlBu+kUfrKNtwY35oA7xlqyufR3s/mgTAdlF0GtG
         QCFCR5461OPCBYBksZLnNTmmEZvTWJBM7/cMFXjV/LJ6+7lzp6GR1VG09tv9qk7+9emT
         Zxic+qlDswZEjVQ2883MCwrQRA3Xy6FDfE6+n8GZ1BqXG4aKLnqx53gDhDUiN9+DaVYR
         EsIeKKQFnKlp32V1ADbwjmYoQRpyz+8V6w64agEmAW2qoIvosrvT7cdMPLrOqSSOtR17
         H+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482550; x=1726087350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i72PSOIXWhCeY4HgM9YgFlmZggdii21Cl4McUfu+68c=;
        b=fe0kiEQCdXAr67F+u+gtk42u0dlfX7IYAWD8jYU3VTLztpXCwduex/K/Kiraw+Tt6H
         Y5GrS/hweeaJkZXRqsOT43Vfbgsjm+pRgPlVnHnjujOcevNt2Gxm6PzOuraD8sMEVgFT
         wJ4HFxSKjdmDYM9C5T2De+Jvc5+SB3k0McOv3//fjjNVZSefngPcRYNoVeWZFQbgEkj9
         p3PGXKNAt5MZ3H2Y/eXJ6M/azEe7BvdPJfydWbAFCbImDHIvHFMQiTbwXVmq0NLkEUJq
         9mMPywgBNSjKCwHs0S1un0E0HMFhBGZidSQFkHBERrRXFzzelWJKzkh23WAF1v1EC/qH
         lg7w==
X-Forwarded-Encrypted: i=1; AJvYcCVYb3+ZG3gR9Q/FVb3zmSXcpY4YZ/bL6E1/QTpc0iHAaJCNpoI4Ut8dpJhLhb4xOnH2sXP9CY0Yw0a4CUwlHxTn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dRvWqoxCEzytNsojoCZMxOmgie+946FbF7a0R3Z7FckgleB3
	tdPhJ5tWfTT12/S5L8E5VBHINAsOC3jnb8gaJYph1k/KQju40qr2DoGvv/EMLkpcVXxtb0HinZ4
	W0scs4TpKkZDLh1Nmw6lYYQ==
X-Google-Smtp-Source: AGHT+IFmR24uVrOJthtOJz6K2WVb+jtHXjG+hacdDNR8Ql4EFrmp0GPrZ3zw2M5BxgYPY6TLAf+W8lj+BLe1iw09KQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a25:361a:0:b0:e0e:445b:606 with SMTP
 id 3f1490d57ef6-e1d0e58575emr4988276.0.1725482550264; Wed, 04 Sep 2024
 13:42:30 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:41:32 +0000
In-Reply-To: <20240904204133.1442132-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904204133.1442132-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904204133.1442132-5-coltonlewis@google.com>
Subject: [PATCH 4/5] x86: perf: Refactor misc flag assignments
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

Break the assignment logic for misc flags into their own respective
functions to reduce the complexity of the nested logic.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/x86/events/core.c            | 31 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 760ad067527c..87457e5d7f65 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2948,16 +2948,34 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
+static unsigned long common_misc_flags(struct pt_regs *regs)
+{
+	if (regs->flags & PERF_EFLAGS_EXACT)
+		return PERF_RECORD_MISC_EXACT_IP;
+
+	return 0;
+}
+
+unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+	unsigned long flags = common_misc_flags();
+
+	if (guest_state & PERF_GUEST_USER)
+		flags |= PERF_RECORD_MISC_GUEST_USER;
+	else if (guest_state & PERF_GUEST_ACTIVE)
+		flags |= PERF_RECORD_MISC_GUEST_KERNEL;
+
+	return flags;
+}
+
 unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
+	unsigned long misc = common_misc_flags();
 
 	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+		misc |= perf_arch_guest_misc_flags(regs);
 	} else {
 		if (user_mode(regs))
 			misc |= PERF_RECORD_MISC_USER;
@@ -2965,9 +2983,6 @@ unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 			misc |= PERF_RECORD_MISC_KERNEL;
 	}
 
-	if (regs->flags & PERF_EFLAGS_EXACT)
-		misc |= PERF_RECORD_MISC_EXACT_IP;
-
 	return misc;
 }
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index feb87bf3d2e9..d95f902acc52 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -538,7 +538,9 @@ struct x86_perf_regs {
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+extern unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs);
 #define perf_arch_misc_flags(regs)	perf_arch_misc_flags(regs)
+#define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
 
 #include <asm/stacktrace.h>
 
-- 
2.46.0.469.g59c65b2a67-goog

