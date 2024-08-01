Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFA1534F8
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488454; cv=none; b=USKY8xd4sjfopvA2ykU28p9n58S7V0XAvQb33Xdtd9am8klLq5Z/T3AoywFUdKhuiq4s7CV+Iia6N1kiAOfyie59J0GIMtyzrm2fsXyyZnNEroJIa/FUEF2aU5UwOaNRsrv/7d4CyzqCNcEnrKANUQ65rOHFoa2C7zJYiEZh4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488454; c=relaxed/simple;
	bh=AQu9CJlpiD7JOUVngaIJhBzSsl0Ca9lu4IgWe3SQ/fk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTU5IxoYleU9kNkpBFDv1DqkD9LyeqXMRZAR5iaDyXasTKzeoT9nXtENmGbxNF+MEbtYVa3fLgCjY1+qc9dRMeE68SBkQNzfPMFHJoOLlbXlDUYB/lmUnqvGTSDwzOHZeuG5g4I4bt8y0ikMf67cSWoPWCyl7A1f4AUce8Xzr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcxmruUm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcxmruUm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fee7c9e4a4so50478075ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488452; x=1723093252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8hg3GW7u9rE2O+00AHYjQL6l0Apz+A7KMtHXAzzNMVY=;
        b=wcxmruUmAcp5EaTl8kfoLrWLUbgE1DCjQ3ILXHltZEB1NW42VupKcNWkR9axCpllCW
         5ch3OSfGPTivGpb4KJC6t4ML5LtEpLoumyheByikGDRYueDyoDt+ZbYa1e5lQP8rtAUj
         3ZQwd2iSvRSEbaNADG5xPmEj2xtMyLdGleX6X5kdgxEI6uP/c7poGQ+lxMxQYOA2sgDj
         fX+GqglAOE5vDGPBAaAu2kOpMnbxDhIGV3/ufd2dO5sKHVvHORDmMcPHAxanTg+vbrdj
         XdyBZxI+QRFFGjAJem3TacSf7asDRZDTNqhPuqhoik6iDEqkwluIWv8Hu/HIZOwj/F3J
         4ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488452; x=1723093252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hg3GW7u9rE2O+00AHYjQL6l0Apz+A7KMtHXAzzNMVY=;
        b=aC7sWevyl2SgFABrY9EwOy9YFTv89zac4P2XSjS3LgEfEhFYqMZ3Ro/SNnk9oU4GcM
         1ITlxh1mbXHDm0Ly2VGZK5sNxP8JAvymvA5E97ex49VH84X9axTIPVGmzRvwp/GTgWyq
         OZLdLARbwu0iLUfV3al6ed9IHfP+a6v+cGGwYPFMZh0wIEgwvlpx+KaRcpjhXk8ZcgyU
         0wvjAYs7Nk2IUX8+6pY1ozb572sPFW2eUKywEMsYmrjk4UZ0pF5Xp6hRP33cGIgNft+h
         3wHwoI8KWdNtN5cp8BV4nU4zjgX/8EJq5euHTG+LA/aIIzfZuRLfmV8LyMbwGKs98kOQ
         HRLw==
X-Forwarded-Encrypted: i=1; AJvYcCVS+FZBJdNubG0XWK2+jU7p2K21uts22Rk8g2TQln1sHm8zsPowOJMzNBfHFjGLDCUEDJQaEn8xPs0dfySLVWTGOKGKjTENdSfcwOrgA4aSMg==
X-Gm-Message-State: AOJu0Yz/LtrUimsGToVNTl/CAeWPLK6Bq1J8JXxdkH3qC4Q1lrlMdzj5
	vqZwHn2xeUIOKjPnlzL6eSWr5gr+sVu04FKWm9U83+ndXn6JnLRhmWeAGSp5uimPGHpgvIWjSV8
	0c2CI7w==
X-Google-Smtp-Source: AGHT+IEyzaQ1LIq/msoDOdJZ/0w7NMmQUez/LxB6xhMj0/9BAUy0e4hdyO+JVmr21/iEnITcymNYQ6Uqf8KT
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:902:eb84:b0:1fb:325d:2b62 with SMTP id
 d9443c01a7336-1ff4d224c09mr430825ad.10.1722488451817; Wed, 31 Jul 2024
 22:00:51 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:59:03 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-55-mizhang@google.com>
Subject: [RFC PATCH v3 54/58] KVM: x86/pmu/svm: Add registers to direct access list
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

Add all PMU-related MSRs (including legacy K7 MSRs) to the list of
possible direct access MSRs.  Most of them will not be intercepted when
using passthrough PMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/svm.c | 24 ++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fc78f34832ca..ff07f6ee867a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -141,6 +141,30 @@ static const struct svm_direct_access_msrs {
 	{ .index = X2APIC_MSR(APIC_TMICT),		.always = false },
 	{ .index = X2APIC_MSR(APIC_TMCCT),		.always = false },
 	{ .index = X2APIC_MSR(APIC_TDCR),		.always = false },
+	{ .index = MSR_K7_EVNTSEL0,			.always = false },
+	{ .index = MSR_K7_PERFCTR0,			.always = false },
+	{ .index = MSR_K7_EVNTSEL1,			.always = false },
+	{ .index = MSR_K7_PERFCTR1,			.always = false },
+	{ .index = MSR_K7_EVNTSEL2,			.always = false },
+	{ .index = MSR_K7_PERFCTR2,			.always = false },
+	{ .index = MSR_K7_EVNTSEL3,			.always = false },
+	{ .index = MSR_K7_PERFCTR3,			.always = false },
+	{ .index = MSR_F15H_PERF_CTL0,			.always = false },
+	{ .index = MSR_F15H_PERF_CTR0,			.always = false },
+	{ .index = MSR_F15H_PERF_CTL1,			.always = false },
+	{ .index = MSR_F15H_PERF_CTR1,			.always = false },
+	{ .index = MSR_F15H_PERF_CTL2,			.always = false },
+	{ .index = MSR_F15H_PERF_CTR2,			.always = false },
+	{ .index = MSR_F15H_PERF_CTL3,			.always = false },
+	{ .index = MSR_F15H_PERF_CTR3,			.always = false },
+	{ .index = MSR_F15H_PERF_CTL4,			.always = false },
+	{ .index = MSR_F15H_PERF_CTR4,			.always = false },
+	{ .index = MSR_F15H_PERF_CTL5,			.always = false },
+	{ .index = MSR_F15H_PERF_CTR5,			.always = false },
+	{ .index = MSR_AMD64_PERF_CNTR_GLOBAL_CTL,	.always = false },
+	{ .index = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,	.always = false },
+	{ .index = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,	.always = false },
+	{ .index = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,	.always = false },
 	{ .index = MSR_INVALID,				.always = false },
 };
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0f1472690b59..d096b405c9f3 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -30,7 +30,7 @@
 #define	IOPM_SIZE PAGE_SIZE * 3
 #define	MSRPM_SIZE PAGE_SIZE * 2
 
-#define MAX_DIRECT_ACCESS_MSRS	48
+#define MAX_DIRECT_ACCESS_MSRS	72
 #define MSRPM_OFFSETS	32
 extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
 extern bool npt_enabled;
-- 
2.46.0.rc1.232.g9752f9e123-goog

