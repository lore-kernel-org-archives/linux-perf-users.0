Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E7165F0E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482553; cv=none; b=m2NFlVgsBl3ckA5oobEYBKyg4lqj3I9Tzcl4vcPCcpLVilQ5Tugw7bHUu4uTBrXM8glGe+F1pF02/Uu8zLwHlY6GG1Mh3DeBfCyZvRfMIL5+0NPJH32FELRb4+f+qhs9yC+jSEtIyWRUoIKOy/2vr8ChymOmLtg2dMStdE3LQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482553; c=relaxed/simple;
	bh=DY32o9P9BJrjFnl8SkC7+4pBAbM3HVwNyOI1WxXRIXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3jIm6STtuEF9R47iX/2sk8YrMByk0lUaEUtVQXG1bcJmKDEoKvIeuJp0bew5nImI+VgtGNrhg5cHHiObqXbxuxxlrAcjq9kIm5NUNvfyPWmr48wxLsjUh1osXr+3w3g+/6WqUJEXvijxLrXfZ4W+shLjVExemAkPVVMeMO5jmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxcEjTfE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxcEjTfE"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1ab008280aso209217276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Sep 2024 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482549; x=1726087349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yF63B/qB2C2mWkkN7Sev/IpM9OI4DaouC6axCITdljM=;
        b=JxcEjTfEmXL8LDwcso9FeTdZP2ku2SAaS7K9LjcmXdn604RHtDpfRrM4vFW5VD3bWY
         Wq4wzjEDdc/loHpKYqY2cpnnGVp+kfH+w0bW5aOchxLBvrZ4XGRwtHcy2kfQhYRIrUtI
         pWIt1D+HngAwOdwkIGhyGDma+2eGLgFCrUj+PPy2Gqdpn156axWG8pb5RIZl5MgFpGGd
         4A+SYWn7LF+evLt0X0CMWaJ2vbQi58nxTgsvg06sbbQ+hw9uyK4QI2VvJ7vntkFP+JDJ
         UvEoEl+516NJYwldsgV1HhV1mVxmX1lYmv0Dd4uK8PXHzBPYEIxr475r1aFAg6rVeywX
         ezRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482549; x=1726087349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF63B/qB2C2mWkkN7Sev/IpM9OI4DaouC6axCITdljM=;
        b=OKb8I5l++Nti4DvG0cIYR8at4it0IM/caPOwvpeBeQ5bdVde1Wjsy8WiNZ/vIlPl/f
         +4qXibLuX9AB5UmuvSH/iU8ivJZksUvqKcHxmtQKWsF0BOHJAPilW5jD5ONWFh/UtJeX
         OyiC6obC3IpwLi+bYFm2Jb2sUs0sBC5w8zQQB46fcClnq6bs9xuIREQr4dQXtW6Q4Wmt
         SLKkZph0UizqWO0hkZysh0XZVpyriIWaDqwYnI1B7ZzwcmqhEqK23T6HOQBvaavjQ4c1
         8lxroX5ngR3bBWuvekg2ueCrRRm46PL0eG3XmABi2k9HvhM8ueCdYa4OcqG2CdHSPLJx
         /mAg==
X-Forwarded-Encrypted: i=1; AJvYcCWnyTWwW7Ki5w3x/rP6mLJQOEjgxZCmHkiYfI5SKwuqz9idHclFAjPuA+NwqmFfrgKct3iqXWTCDvB/oUjy+UT8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqpq5POawxEmTACym7XN7ge1OtT0ueoGZVQqumGvBiSwOLM3RR
	YqunVv6SO/ub6d/AvjGcNb7ME55Rh5P8ua704a94DDqiR6czOk3410J872XbqW2bP5WWmaumxE3
	dBqUWOn7RJxBfZBwIlXJGNA==
X-Google-Smtp-Source: AGHT+IHnCAVHhUCP2jsg9QIrX/diUprCN0SQ2aen+GiK4qTsvqjsoiEZxfc39AEm13a4QPmtILTk2j9/pAbTWP98xg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a25:b612:0:b0:e0e:499f:3d9b with SMTP
 id 3f1490d57ef6-e1a79fb4d7bmr28585276.1.1725482549203; Wed, 04 Sep 2024
 13:42:29 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:41:31 +0000
In-Reply-To: <20240904204133.1442132-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904204133.1442132-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904204133.1442132-4-coltonlewis@google.com>
Subject: [PATCH 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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

Make sure powerpc uses the arch-specific function now that those have
been reorganized.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/powerpc/perf/callchain.c    | 2 +-
 arch/powerpc/perf/callchain_32.c | 2 +-
 arch/powerpc/perf/callchain_64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 6b4434dd0ff3..26aa26482c9a 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -51,7 +51,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 
 	lr = regs->link;
 	sp = regs->gpr[1];
-	perf_callchain_store(entry, perf_instruction_pointer(regs));
+	perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
 
 	if (!validate_sp(sp, current))
 		return;
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index ea8cfe3806dc..ddcc2d8aa64a 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -139,7 +139,7 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 	long level = 0;
 	unsigned int __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 488e8a21a11e..115d1c105e8a 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -74,7 +74,7 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 	struct signal_frame_64 __user *sigframe;
 	unsigned long __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
-- 
2.46.0.469.g59c65b2a67-goog

