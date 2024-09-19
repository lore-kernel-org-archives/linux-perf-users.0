Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD0481B4
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772891; cv=none; b=Hfw+zH3XAlel+vVOGwy8N+5fw+E+Yz1aO454PrFkvJDOHQsq/s2XHUALKcTPUfg0VeOdJk2sv2x1XUmd2JvLxFsP+scqgYBodrJHwymsBV/QPGETvEllxKh3zm6RGBPpty2iKg5vaRpE5vMeFdFrd9lV6qWEDitg0j1bQAte9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772891; c=relaxed/simple;
	bh=Brbx6usZhtXw07DVlXsA/D7+GJR0JaS+a0u4m3RwFBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OMwkYpkRaeAgT0ZmW/ZIZuiqrsEGAK6cs/IP1j2IOcZupG6/nEhyctK4W9cBfeRmeGcoV1nru000JD2oTSI4z9B95it3onyba8SkOnG1vuDtWEG7OImkdSBgvsMlW+wFoG58KZ0TrjjYIROyoViWZOMPz30RxiYzXTg8tSmCa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBCvmmPK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBCvmmPK"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ddcb18b13cso21304487b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726772888; x=1727377688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=os3Yqql37R8r3BEesV69Cp0Wu//D+lGOxICBFWLJF5s=;
        b=XBCvmmPKPtx96AYedI5sfHrKELxQNsU1bwIwmCp+iaODx5X0XDQqHkRI5SkjT0kymJ
         9FdbcJaHkblP6RTFF/EyYO4ATbp+24TKBBKdrkg4go9izmwEl+yLnY9n5+HYOBqVkcW7
         kMyKD4iY9IOeGdeI8E0+fNv6SJDtOV0kC4dbMxwVn7RoFVNIDGMOduhlDS3hPmqQbeW7
         B4lw1faqqIYfsZvGTSJO4rqE2SxO9WuWfIw4aCfRQmkEICpJF7MPbrtXv+/Dr+RqmWCv
         KX79ARan2nSE6QqNS6DzCYFjcbQ0WsZH17sWNu6yAf0IwNv6RMwfw2dXhYqHxB7O8iOh
         FX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726772888; x=1727377688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os3Yqql37R8r3BEesV69Cp0Wu//D+lGOxICBFWLJF5s=;
        b=QZLz8rEzSfwRDsD9iHnqJVg0JNEVd085AGjIezOdRbEtRGnMW6Nu7sNZ0u5UDKcyld
         cpm02i5bPfLGvHCwc1mXgT/YGbt5TyQcFiSADBkfvS9b3erFmmHOpID0lGUxe+IsbHDe
         I1JcO0wstFO8cGh9Qo1hgXYYoA/ObfifQ+00//QCXu0/BnFPceuFVMU2ykkFJXiMgIOe
         AB/dTvEywY3b+rqAVkCrRLtdCv3xgnl1E1SKJGIZK9xHAQ9fcszCDLXKo3vmxIdOEcCI
         8FEr54SjinFF3UcizhAnGAQUNCsEA64AqSmZqnhPaDaKgDUbPt9aTijfZKEAHxD2WOXm
         PEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYA2kMYki0gXMi+R9WebOH5PBdK6r07zEkElUbkKK3IlMmoC9dhZODPiNI50Xv0D/lhK4AyQFCyU+q1McdEdz8@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKeoQLnJh9NreRLOnT4CrKKFqzN+hV+bsAvQlEa3pFWc0pKmx
	nQ93yB7MGUw5MTt46L+zZHL3K8a6lLg6GYaHRLBdJ0Rdjjhlye8XmThhQCHLQ6mEvCYVmYufqXt
	o0I42k1gpEJ0fyQ+mRIFezA==
X-Google-Smtp-Source: AGHT+IEWKocKtUeJyLcIg/Q0/lFfDEFCwNKFuqL4bh0kqfDWnkDMObP8hKFL4orR1R805yrNr96S1GsShGwKfOHrhQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:b20e:0:b0:e20:298c:541 with SMTP
 id 3f1490d57ef6-e2250cd4633mr337276.9.1726772888086; Thu, 19 Sep 2024
 12:08:08 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:07:49 +0000
In-Reply-To: <20240919190750.4163977-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240919190750.4163977-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919190750.4163977-5-coltonlewis@google.com>
Subject: [PATCH v4 4/5] x86: perf: Refactor misc flag assignments
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
index 760ad067527c..d51e5d24802b 100644
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
+	unsigned long flags = common_misc_flags(regs);
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
+	unsigned long misc = common_misc_flags(regs);
 
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
2.46.0.792.g87dc391469-goog

