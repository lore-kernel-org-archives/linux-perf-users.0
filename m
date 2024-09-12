Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7F1C2327
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174302; cv=none; b=koal3q98QUJlZusI6dTH++OcC7TJ8cIl6cIVWIlaiBzH8tfGnoXSAfKzFtf3VgiAFZQvdrvaSiJSXSjKNrCVZvcaOxi3uhPURhr6zh4PASAam5RMhXiZTeqNvpPco5yBH8K07URnAe8cOBnzhF1VGEUh5Bz26x48gq52TJQfqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174302; c=relaxed/simple;
	bh=i95QDLsU5GaO2Xej2TBOmg9Wex/kOoppvJv8vIvwjAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QbNBtotawd5Q7bNNrC2M3INBBiz7MuPj3DuOJZ65t05xp4u0mMEKZScoAkTDtGHzeIgP+youtOCgtt7vjPUzKoCiuf1rTpk5lrBtfntoKsubeVZuc+VL11H2ZNrIrzVeg9fcTwyqkjn7REn9LugHkReuNr0I0znC+SR+nyKTr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCXewt1C; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCXewt1C"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82ce11bc50eso174604939f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174300; x=1726779100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HOlQ/b1Vqnby1HRrJAa+4JPh1tcBF4UxpW0vveqy4M=;
        b=VCXewt1CC9UaN5dOanDSbbVO3yQwrg2Vn2SGqCNZ27+DR4GNcap4uwBDbtyGUNeQBv
         kIcP3Wb0nJ8AoeNWHVUl/eJ6q4c4n4FXg68SnFACIfCy7hLvMAWmeIwx9Tb4Eeft4wF/
         5OC8/YjI+xdGf/4hTE986GVf6criVXw3YYZPB/wVSVODdODfj0C8hwHLSlWROcneRjnm
         Ch/wImqL67EQefOyfc4f7tuajtv7KPacrzdLl2t8XEQc4uFBIw2ePHzXwUavjF1MIz08
         A8Q3hVk/Zuiigmk2xqmwhOev9pB7slONM/vWcpdp+2LJxoem/gU4WCqPGdoJbmliYTsW
         bg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174300; x=1726779100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HOlQ/b1Vqnby1HRrJAa+4JPh1tcBF4UxpW0vveqy4M=;
        b=pQ1QNS+k33uNGmyMlr/7bjcMAPYVGW+iho+vmBmaypXLW0hQ/iFNwNu0D3qLRxaGhU
         VKEYy4MkDHg0Cgg+j7Om7U+V9gLXR1cYtEhpgtqiGVHTtdwP8JXDiaIzunIUig47kJyK
         JLRWhKL5lJezoJN4vrLO5zVUdMBeiw2hjGPmr2btCSF9iNML+E7jNb5JJGfNzztQJsWo
         d9mGayEqF3lBqIqNVtos2YOIye8DH+nNSDeUYRRq2glncqb5CUSRhzr+HDLOoSJbL/oo
         o1Qm2l64hTden9lsg4ZryxoQbn5xNA8ePeud50zYYfagcQ6VIygD8iI1sJzp3jTtaf9r
         zAQw==
X-Forwarded-Encrypted: i=1; AJvYcCWGQlNAQcD5fLrIH5ist39dUhe2GtOJws3O9Bhhzwr3EHtQOWv5Z7orGP2pehJt4pdAj7nOFKH2P+MTKT/3FkiN@vger.kernel.org
X-Gm-Message-State: AOJu0YznaHn6f+p3yaFdm5E4bfqj1jKcLuf7olXnIXbnh89FzTzA9djI
	lLGPXX5eJBR/QETo/wcA3UEcIBFzeeMK92HzDDKN1XP7lk6cB5lJJISOJrIk4YjvkXIUCDnBNID
	Rv1mipISXa9E8sVKzrILF8w==
X-Google-Smtp-Source: AGHT+IH+tyLe1qQliN4X6ik9ZMj1aIgWQ7X0DXUSN8bntx8eM08UGo31hDfdaqtl4MXbxod/0+xFT0h7PePUGuXbpA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6602:2d86:b0:82c:eb15:1aae with
 SMTP id ca18e2360f4ac-82d1f8b0c0amr3300039f.1.1726174300197; Thu, 12 Sep 2024
 13:51:40 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:51:32 +0000
In-Reply-To: <20240912205133.4171576-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912205133.4171576-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912205133.4171576-5-coltonlewis@google.com>
Subject: [PATCH v3 4/5] x86: perf: Refactor misc flag assignments
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
2.46.0.662.g92d0881bb0-goog

