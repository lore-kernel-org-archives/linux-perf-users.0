Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9C14037D
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973521; cv=none; b=FsNzR2+fSop4AvojAfrDhWc7kjewYSN38G5tPSliL5s1nG6/DUptgmwDcyf5i5onyzzv0E3wi4Us69YWnRKN9jpBDgC+x0CKcMhWfyxKPJTnF97IHI2bBmRv3InhzAqEAD793koPhhVr6a5H3lllAkHGE6T1WIE/2efo2ZSX9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973521; c=relaxed/simple;
	bh=QF+v61SYA0tiMBVZASZ2/CIUZzH++OnPDdUUGnHA1b8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uAwGDajw5qsx7ycdsb90GT47o6QgfQCY4jQ8rI6U8JOIHeR5PqkBLWnanpxQ8/c7x5nBKazVFjR8NfbEkoUbDH2rWO6mrrbhdiD0WdX/xg6RjPH4zcqizKnfQKv1uuD5IHVeHWmy1ZdfokYYraCmfEFcww5EN7iwurdZjzM+z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwrqZAmm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwrqZAmm"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2235677276.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973519; x=1715578319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xC8Yhy5wXH+JcVLMtYFngypE7RNedM7hWNLqbtK2pmU=;
        b=QwrqZAmmRE8BuRuO0IsQ8GdB3USDF6TEEzPRvVHEOF2KLfX76DxXtXQxUs0zM+y+wJ
         gRBOwBFDG6PtiewrrERoihUNTvJ7qDH0wKDhjr0AVvHhSBMOVNOpqNWwqwKfn9obS9//
         NRd0SuXjR0qDqm/F38Ux+Ec6M0faQFtfUXYIfjyMOV7f7jpqFO6CNumhCyIT++p6ds0K
         hi5w7irYkJaWT6g0E4NbHQw1+Uai0b8cobr2F8Gt4b70Z6UpbJTHGa7XMMHgdwLHFjeE
         kUPo6uumUrSFJAdssyOme0I+axkA1YPvo5AMJw7BzjfcuOjFv2KL0HDdZKSs8NHr9P3M
         crUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973519; x=1715578319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC8Yhy5wXH+JcVLMtYFngypE7RNedM7hWNLqbtK2pmU=;
        b=nl4j9md+xQiRE8fzYDz4ZX5M7grdjwOilaqHHUgG+awC/WITLAzEhkkWwzv+BEn9F9
         Km9t68akbXo2NF4uw0NPtVQMr6a4jxICs6WcBx0alXpPLhZH8N7oPoRZ8FwLU7nwMY2b
         V6L5FwuFBUlWWmoNLyltUMt5rgNFTxsbScgLBS78KUpC2/slO/BvF+c6KaI+5Z/GmJUJ
         zqwuNpeqHbCL6a2I3L5KvUAGBTRptdyFmtXCR1I6mKdHYqxR5kURmzNXnxrzFWpF388o
         J4eK6d0ajdRHZH7pGdy2nzvbCpDVNZekPKS6oun/u45uvmUL2swK7r1IheFli9J2aySw
         +EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuyr9auRnIDCaYv+vSdhmT+gVkjshZV+00VDeq3WxZlO1hrZcrJggQ7u8rz5oXJQD9PlfyCpflbEWo3t31jIDmIi5tZae7l7dpEK527JO3vA==
X-Gm-Message-State: AOJu0YxCi5BU3RpHH0aZCagY8rxgqco4K9jVE747SHYkYnQ7QEll8ziL
	F1yWkSOQkopuWP/B2tcL6IrFZLe7HNUMi+IdHfWrW1XVmbyt7Vif9H9gRERV4MNuXx/3X8lO9Dm
	0saO27g==
X-Google-Smtp-Source: AGHT+IFh+FQTXDgXNiSIyc72L9qtGz8UCIoda1/4tSCwsynhsNrDwY4pvWScwBbgp1oI2TXwQQ4z0m2wjbA6
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:2b07:b0:de5:319b:a226 with SMTP id
 fi7-20020a0569022b0700b00de5319ba226mr3196960ybb.1.1714973519282; Sun, 05 May
 2024 22:31:59 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:14 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-50-mizhang@google.com>
Subject: [PATCH v2 49/54] KVM: x86/pmu/svm: Allow RDPMC pass through when all
 counters exposed to guest
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

If passthrough PMU is enabled and all counters exposed to guest, clear the
RDPMC interception bit in the VMCB Control Area (byte offset 0xc bit 15) to
let RDPMC instructions proceed without VM-Exits. This improves the guest
PMU performance in passthrough mode. If either condition is not satisfied,
then intercept RDPMC and prevent guest accessing unexposed counters.

Note that On AMD platforms, passing through RDPMC will only allow guests to
read the general-purpose counters. Details about the RDPMC interception bit
can be found in Appendix B the "Layout of VMCB" from the AMD64 Architecture
Programmer's Manual Volume 2.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/svm/svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 88648b3a9cdd..84dd1f560d0a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1223,6 +1223,11 @@ static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
 		/* No need to intercept these MSRs */
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 1, 1);
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 1, 1);
+
+		if (kvm_pmu_check_rdpmc_passthrough(vcpu))
+			svm_clr_intercept(svm, INTERCEPT_RDPMC);
+		else
+			svm_set_intercept(svm, INTERCEPT_RDPMC);
 	}
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

