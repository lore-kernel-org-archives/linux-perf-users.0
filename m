Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEF2076A3
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524528; cv=none; b=FeKRKUOy9u6+aQ/2sHTy5KcENvBQz/9EVuCrGQPL+rxPZHOT/tBaI2q4qc1NNv/7YK/UQQuEZwt0Lr0pxQ7KgSiGpLE2vi7BG++O7wJH3C1t8Xd0qw7W7iMvs0ChX6zXTAO0sZPm/F6Q2hsNJtfE7TRq26ROIKI/VheNONYTqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524528; c=relaxed/simple;
	bh=OMb3jG971jmx2YJYYmtMd1jdhDZJTQd5uT/KvMEr7uE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gais3XCeyv+qmcKSDkw2fU3IBR7WHJ7bQuecwvw8NdJHgGmaKfr6TnOGDnRMLcAPdfrG7dcHS6hYnQowIYacMWg5EJM7mPyx6zt1ooCAN62/8i7HIORY6H0si7WsJvvbXh3ZIotxcfUE7mdtQmDUz5VyBs78Dznq6KVCdLzmjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vimj57Zg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vimj57Zg"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eae6aba72fso93178037b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731524525; x=1732129325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQFdXgHR/yBinKM9akC7F2JFw2+gnKw6F8HpNI5yy4Y=;
        b=vimj57Zg+4IsIh5ujxBbiF0Lv8ztyCCCO4dxWbLMKAqutI49nS4pMM3mvKHdNSuJTc
         1YwFavZj9xr6uWR6yGrraiMRaTJ8F6poPfBO2O0gXykTlGoIZ2j/WaC8amva+zaHzWQz
         hF8Go48gvYHMZKkIEeOBKbb4wXXs75PUz/WWAzogYjeyVKt69a4JwyOdsq+Y52ZxKDju
         cRh3Y/TElUbLgtA1maSZPlKl+zPp9USHCsdewiycps+QBgZBxJZdxRTOGIKy/UEbwYcK
         VffPv3ponYDxPgHR6cdWbjnOW7SpYe8vRGxI8pZOsEuHe0IWvrOXqrnoCsUeYDSG6hwu
         puAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524525; x=1732129325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQFdXgHR/yBinKM9akC7F2JFw2+gnKw6F8HpNI5yy4Y=;
        b=PLMN3j4DumVyy10eMkwVnoMKSJI2BIRlMsGFAU5ozZzODnpCcHoerrKt/U5KswL0WE
         VIpGf27IPM2cPRtzMiI4BW28n7F6Egf8b8iV77qHW64VjMJfQcRVmuQejabYxXuPJR7M
         aNvBWN66fRsnwZogqkoQ7VDqpPHNBLln2LhEHZ8uqjg7RDZ3GSMUsAyBKMNwyREady1C
         5pQxzmAifU9A+RUkVyibYiKgPyuK4NzUQppi5jN4Lr9Z5FGDsFjc4319xpnt8BEUT8RM
         3z/l3dNpYsbY27uvvk3jyVom9bqCHlrLA/PMwdMEEXH5AuJyacaD2yY+tWM7k1u2aV01
         B5hA==
X-Forwarded-Encrypted: i=1; AJvYcCVPY///98pi4kE8tjlgwo9/4mrKFaSdNRPqf99p8zvHW+/hFnTFgAl4qJW2mVVu/knAO6otgtWq6chGwIO9vwSM@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxqeYU6xi2spKiB4ax/bl2XoSqlAemn7lVPHWap6QPqXYAwWe
	e6VaPkX0Pjv5nFOJg6Z2yEVSlqelx19pRP1wLbjIRoxMVe0TwRU4FVFxLBoQtmmUGkGcW4UUCGY
	WA1X/cSdz0RLlsfz00ByDnQ==
X-Google-Smtp-Source: AGHT+IFhulDvoY0sGq7EYnbunXmF/EqPCQ3tEG2uX7XcBCI6dgYlk8NlhbbJtWap3voWbgrqyi9w6iV13kRImFawvA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a81:8a44:0:b0:6ea:e011:f122 with SMTP
 id 00721157ae682-6eae011fd7cmr1805147b3.5.1731524525438; Wed, 13 Nov 2024
 11:02:05 -0800 (PST)
Date: Wed, 13 Nov 2024 19:01:54 +0000
In-Reply-To: <20241113190156.2145593-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113190156.2145593-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241113190156.2145593-5-coltonlewis@google.com>
Subject: [PATCH v8 4/5] x86: perf: Refactor misc flag assignments
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
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/x86/events/core.c            | 59 ++++++++++++++++++++++---------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d19e939f39983..bfc0a35fe3993 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3011,27 +3011,52 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
-unsigned long perf_arch_misc_flags(struct pt_regs *regs)
+static unsigned long common_misc_flags(struct pt_regs *regs)
 {
-	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
+	if (regs->flags & PERF_EFLAGS_EXACT)
+		return PERF_RECORD_MISC_EXACT_IP;
 
-	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
+	return 0;
+}
 
-	if (regs->flags & PERF_EFLAGS_EXACT)
-		misc |= PERF_RECORD_MISC_EXACT_IP;
+static unsigned long guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+
+	if (!(guest_state & PERF_GUEST_ACTIVE))
+		return 0;
+
+	if (guest_state & PERF_GUEST_USER)
+		return PERF_RECORD_MISC_GUEST_USER;
+	else
+		return PERF_RECORD_MISC_GUEST_KERNEL;
+
+}
+
+static unsigned long host_misc_flags(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return PERF_RECORD_MISC_USER;
+	else
+		return PERF_RECORD_MISC_KERNEL;
+}
+
+unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long flags = common_misc_flags(regs);
+
+	flags |= guest_misc_flags(regs);
+
+	return flags;
+}
+
+unsigned long perf_arch_misc_flags(struct pt_regs *regs)
+{
+	unsigned long flags = common_misc_flags(regs);
+
+	flags |= host_misc_flags(regs);
 
-	return misc;
+	return flags;
 }
 
 void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index feb87bf3d2e9c..d95f902acc521 100644
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
2.47.0.338.g60cca15819-goog

