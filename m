Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA38142634
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488360; cv=none; b=RY8dZhC1rrSt75R++SLRUfN092URBQrM+jq2MYkT06O5GS4Rq2nYpvVI472BzLphJbpkvW4JWT4iO11PTB6XxfnPwt2Lj+h4Vm1YkvGPYNpov29hlHzY4Q4wDQyTvAbiDqPsP+BmuL98fDJX/KtX1SYrCiFjQc2EEj3goGmKYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488360; c=relaxed/simple;
	bh=mt1xxk37hsP4lZImODdUkAOy4mNop3xM6GrJ9LrVXt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XOy5QXxCXCo/OVHgEzPWpE/1K9VV1GyZGl81hJ5fuqCw1e+xCSHgkiV02TPWSDhcu2ySPvKftRUY4yjgXjTmSEGmRCZi8nx3Nolv9vnuLgN9GWDQIF0H4dphrQPR9DH1TpdAuTmzhoyYq2IqgvWoRBchKIxHeGKKUu0ACsr3FdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fmklishm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmklishm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6507e2f0615so5716620a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488359; x=1723093159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf4Zqa1drSnZS3LbbOppIMykS9maFMjN3nXFpX7jW/0=;
        b=fmklishmz+Dp7A6kpt4im0xAmBkIORJlaEA3KUlz1RSZytUcgTRgoykdtSbOicOcnk
         W5aCJtiGkinkV+nk83zSgocYARYDFETGdW2TuGzNEK1ChpkoVOhmgVJRPLbJ22YRkSGk
         sT5fPSkOAAt9W946dvBjEjvpoHvH5sZm/Z6Wq4q0h4QyYuJcxIhwQEY0/MEQFKVEiyGH
         2W2T6Iptgl3uT8BxCmk/Dlsn7AqwiOSermQ1jDF2gMM9Rdv1xxgGq9+IoNkmWrYwpKvl
         vNc+yaGXA8m0WT3+lS3YQKvLMGTOBwJkkutOIKIPA+T7erQMBiQC2CwW15mwiO6pvd0p
         CXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488359; x=1723093159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf4Zqa1drSnZS3LbbOppIMykS9maFMjN3nXFpX7jW/0=;
        b=poossrmXvj8YBmnOgsIUEhlAYfityJcBYmdcj1ygyZYg3t1u6oyPRwolewCVYraWF6
         X8x68unoJj285FckNCo5Y6vDuJMgE18fyfJQko4OJl+LpvhiB5Kz/ZlWUR7rvHdrhvgf
         ZGYSXTICMKrF5eoTdPg5PyNCnUvoM5IXM3+jXVUtrowOZb5SCicVv227VgoApBLL3Xrt
         EJ+yDEBDKpNucGylpdRGqqfzHW/kk+vR8+AotCDX6w7YSr5/dsUO6HqS8gAcJy8Omtoz
         tB3y1VXBjYhPzTLll3BMefhpWJ4a5WUTESTGIba29AWMSMjJyQh5gpTRElu+FzNjTZ9b
         A5DA==
X-Forwarded-Encrypted: i=1; AJvYcCX/H0GIIV7hX8g+xrMHxBjKq+pTKvE6MHdouQdjMLErgj4tNpOr4mUk4sxaxhSXjbckWryhiLnB71Q1teECRDLhnSJCwLu3GLQEp8W+HRr0CA==
X-Gm-Message-State: AOJu0YwJKiPTU6KHGpmm5Ug+Py+wV4JhtGCETuBsHPZo+tsO7FErl9V+
	beBzrS6wnn/oyGfQzlW41n2PLeT3WFP+GZbLR3Fx6/AwwxUfJkYu7MTRBWHM/S3P+ymAmZQwrHw
	oRLnt3A==
X-Google-Smtp-Source: AGHT+IHd1t8tqucILDMxWLj0bOtRq4jrrKgUdFhTNJwu0HLBwioN5wYluPjRYKP+sUeTOOIZp+AQ7DDVOA5r
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:902:ce81:b0:1fb:984c:5531 with SMTP id
 d9443c01a7336-1ff4ce4d58amr1346895ad.2.1722488358790; Wed, 31 Jul 2024
 21:59:18 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:13 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-5-mizhang@google.com>
Subject: [RFC PATCH v3 04/58] x86/msr: Define PerfCntrGlobalStatusSet register
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

Define PerfCntrGlobalStatusSet (MSR 0xc0000303) as it is required by
passthrough PMU to set the overflow bits of PerfCntrGlobalStatus
(MSR 0xc0000300).

When using passthrough PMU, it is necessary to restore the guest state
of the overflow bits. Since PerfCntrGlobalStatus is read-only, this is
done by writing to PerfCntrGlobalStatusSet instead.

The register is available on AMD processors where the PerfMonV2 feature
bit of CPUID leaf 0x80000022 EAX is set.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..b9f8744b47e5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -681,6 +681,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
-- 
2.46.0.rc1.232.g9752f9e123-goog

