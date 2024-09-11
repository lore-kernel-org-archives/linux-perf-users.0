Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65821BB6A0
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093515; cv=none; b=U3nMBehoF9KF4eS48tr55+mOx+KW/F4FRdctU+85YaXVTU0cbrXQPx/GuxV5aDkRs3jicl9UCzZIC6lAnOaiHdWjT4K7/JDsLmgdSwUBMXE/TqB6ruS89R0HPFHlTKtMge4DRwOSR+y0Z6d4SCGJAys6Gb8DSf3kI4wXyNZxZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093515; c=relaxed/simple;
	bh=Qe6ZURpmPiYgTTi7nxbvffzfT5qXIMw8HIC3oO1Vo3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srb7Yyu19AZ56hyMWPHdEv+tXS53xXKl19jM0cgw5X4GGYj4FV0qxigfPLdbnLfEUS/EUsSqw6AK0c3tRuG1qmgVcRyBCyrMr/DNqrvYsMZmtcQUXS4grxW91U4N79YpTmDic0oBWqR9Ucxh6Qe8PY4nAyfXD3frHvofmtPTmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lN07+KR0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lN07+KR0"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4bd76f5a8so17942007b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 15:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726093513; x=1726698313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4XmBjdboaUqTeMgRqbSdf4DSeJIVFEq/lNcpwN1ftE=;
        b=lN07+KR076rJbAvNKbHXlC+K9jYGDh/m0feLEKennZiE7o/4IMwdIfJpXLgi8ga3fc
         7HG+6DHe+N20ufjbGFaJCGo4ZhHvQUvApUUQZMgOVlTtfDYh2yL+U+QzjE1ihb6YID7f
         3249cpFumZ40IBNEjertayqY9aCkRVVUUJu8aawI3ZNtZqGxHul60PWWHbXu3NcWfiqx
         HKWcTyjOlLDjx+w52vlECO3oRs+nUjOVi4f5YNKb97pEw65Duv13Jzg/dWYojxgoqpfj
         sPTdlpFyCaCPVtryq+GT2FFi10HcazjGsIjDsjPlyDsTQSocaIk+eAHvfiy0c+Tv26JP
         0EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726093513; x=1726698313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4XmBjdboaUqTeMgRqbSdf4DSeJIVFEq/lNcpwN1ftE=;
        b=I6vR0p0ksCcWyKI2noQnJKJfugv1E5/t003zVdayogprp+jyIuuCN27/JP6XIMqS5+
         h18x1Xcc61F+O43ZvPYATSQ4H/Y786z0EsHSLkHfhqB7eqMD1W/mgwV2mghOg5eZ8ioT
         gq6vq/YcksnyHJ07hrBkmNSyprEfsUU9fb75Q/vtAMkmtIstQe3U6NsY71cQqxluSkDL
         AeGPSbcjo29RcC3Tn1NcFcABOkmQ2s7fzZElPdIqV9yTSc+O2K0GqEBoZn0giq/GJCiB
         T1za5x9b7ke02XclenyhzpLwsBry1iOvZlpHBNxHYJuquXpjWI74jPKNpPZbQfhPIGQu
         ReQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMkcXibv2T2cctn6pMPG8YnJQUILVBsRjjuuqgBwVuHNKO3R/TrPH2f6pDIgElZiB/zL7mGyh1q3deC7iOvg+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyGId04f4rkCkGd7/vujlt5ajH+vVG3stTN8mQ6qGIhei6WpUYr
	xX9kFuYVAarPt1glkBl+Sd2hdy7ddX753yb8/UJQl12Nd+hv71Ly1FgRVd0YXI15kPOnzH/aGVd
	92JHr3Z/cpNc1GdqFYW+UXg==
X-Google-Smtp-Source: AGHT+IHahPlfxq0OnDlBxbNh4kFfba2/NbBP9j+SjDxLZau6fx+NZ8cgucf9q6YqSrrkRp98eVZcQ/vy+HEi7ntE2A==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:6083:b0:6c3:e9e5:e6a with
 SMTP id 00721157ae682-6dbb6ba1041mr322647b3.8.1726093512763; Wed, 11 Sep 2024
 15:25:12 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:24:30 +0000
In-Reply-To: <20240911222433.3415301-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911222433.3415301-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911222433.3415301-4-coltonlewis@google.com>
Subject: [PATCH v2 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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
2.46.0.598.g6f2099f65c-goog

