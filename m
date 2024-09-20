Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97518594C
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Sep 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854471; cv=none; b=PWDhd8fla0dALeJhN9iqQkYXzE67t70iFo8Tg2uhMpnXp7Ucr3mPxBgsPTtAs06wp5T6IJmpCVeESu3fVtLZ3TpIJ8KIam6q7aos/3X52cAu3bA/c9JiMKyOmPUMleSgUrkWtPipsH/+8r+oMo3G0b2dg8Ii48BWOKwzo+zuuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854471; c=relaxed/simple;
	bh=Brbx6usZhtXw07DVlXsA/D7+GJR0JaS+a0u4m3RwFBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/XzeFPiYJQp7xDA6V362Y3HzRFB8f+RlxPwBdp5xCCc2vYMxQ6dasNGxKUxqsVk27cTf2w1HVB0IRBR3EdqhKVDVvE5MzRkmnvJE/GXmbw7/Tm42zmW6OEOVdlvJ9JBM2Q+acK9zgxrp0wID3S+HRBk09Znq1Ec9VFkGAkMrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipQy1Kxf; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipQy1Kxf"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3a0987c35f2so27743025ab.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Sep 2024 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726854468; x=1727459268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=os3Yqql37R8r3BEesV69Cp0Wu//D+lGOxICBFWLJF5s=;
        b=ipQy1KxfzyhHo92khu1H03fstrWWMZ4ouI+syfRyBMtVKiWVDBBVUwz34ofH25eQGB
         3j4KnZe/+1Jgz9xAXL2EWgTRX+rfs+Z16pxMo9nlXHBthew7yfougVOI3bYZbF6AXI6+
         XPt2edwsH/WRzVhAOtFGU6GFQG0LUquVzLs3d/8BMaFd/kEWlu2+L9NWzBmysgMB10ZR
         nPkF0zpWUniskIOC5d9EJVXiHiJuIs2LFx0mKwRSS8+XVABHC8S1QEWJWyHNCBpP+RgO
         qSmO+ULMR1mn7JqwWKNsa0rngtiT28/yFMnhtQ9Du2e4pYhqMWJOpqsqrC13uTaaWdBj
         0Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726854468; x=1727459268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os3Yqql37R8r3BEesV69Cp0Wu//D+lGOxICBFWLJF5s=;
        b=u0ot3zIXk0h5QWoiS+ysmKHZJ67GCcP1UCosIg9z0Am7xT6yPS/9eJTcuFqJp5Dy9q
         Fir0iC8/jETc91NOe6m3Kp70I8zgwyIHVDVT+7bALT5KfE/Zo079eVGFW/Y4dslITkSs
         cdGoq2GQaPKsFmIJqiJPfkzO8aOnSFXMGSskyEhIo+yR847/wPMG/x9Os0FT73ZNKdzZ
         gzQ4PwJJdePnAMnktuQ0cF+S8pw0bOQNUoITgtc191OGWxy9zLPPqT0NISy3eLTFP4n/
         Fw2CIr3INH18k+O9axgGiYny9aZzDh85uCBH1s/R7jXWMw4Bu3JZVrdqmI+Esum3Sxlk
         Q3cw==
X-Forwarded-Encrypted: i=1; AJvYcCVhMgt6il1CSrRqH3nlGlze0DBvVKemtrQLw9XQKwifId3GIgyv2GiGth6E6JkPK04FcbzII9XoYwCD/3bEwB9L@vger.kernel.org
X-Gm-Message-State: AOJu0Ywew+vA48PrChQv2HDHfPgGsoryd5xyMz3VORH4Xw6NC3fsgPww
	PCDvQSrJRU+UIOBiQ48650HSUIaI1EcOMaPaXMg1GLxuDL/cCZWRjDknOiQv6KsdRpY/bu/Tlxa
	LR9qAqPscEE4UuWS/Yio4Zg==
X-Google-Smtp-Source: AGHT+IFnhhl9BCVqz7UHoFG7yjq72HDbwzVFbb4MeEheIBAhExRul8dePWOtmi+TJc2JiJ2AJgNwLAkuPyQFmMIgfQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a92:c268:0:b0:3a0:9cbe:d246 with SMTP
 id e9e14a558f8ab-3a0c8c9d4cfmr286865ab.2.1726854468526; Fri, 20 Sep 2024
 10:47:48 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:47:39 +0000
In-Reply-To: <20240920174740.781614-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240920174740.781614-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240920174740.781614-5-coltonlewis@google.com>
Subject: [PATCH v5 4/5] x86: perf: Refactor misc flag assignments
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

