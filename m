Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE34AEF5
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973435; cv=none; b=dlZRf1pvd1u2/vPzvurYeUBt/fIA6iev/4XGLPze7a3XGSmNb6lBci2zHsQCS9YUfHwG8I9mwSiU7G5xS390nej12S1xVY6+troCeO15bWX9ObDI5iqGQfiYlIBUI8SGSF12tVQpVBhpIk09UHtpJFTfEPD91g1MYuQd9WgUJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973435; c=relaxed/simple;
	bh=hpGFwuEXoFmBtlDS2Xsv0cI2mMBEbvBdKxaSTdCthok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hrVppwk5SdGJfaCopSr7ci9Bkk5ZxKs/Dx6/ftGZIU3Hl5wqKABxynTegs8TnJKA35gvrjFK011l+6d2X1CP8jIwOcxiUlFsCfsLtV7U0QDKNYtx6mgLYiHXIBsFa8SaBOBbVbutPcyAbWBprjR2+i+8VgYUnCkdSRo3MZxa7e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4e4TJifF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4e4TJifF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bef0accddso44164487b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973432; x=1715578232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=X9eceQ0IPQgvcClpLg9adRP7wmQKiFwD/5KRHzUimqY=;
        b=4e4TJifF75pNZWSGZp8lXq0dpsqa9g6BWGpqSUjct1NwYzdF1Hn4ijczsDA2GEow4d
         k9j8/nBJbBdjzrf2xMmJnqClpsYGG2t4Lf1dfNFO4Y45v5Cre1HHLkvCr8RekFGYN6EO
         vCRxsObt0hQxMUzp9fQHm8MTOeLYcz+DzggKnhxvwEyLboQIvKbzIlUy+KJtZDsP9peL
         S7DqCscLjhmcvpeEBTagEE6pWO4E5paUl4VyelxuzPRtnO3HCcIN7iYpEpUDMs1ptu8Q
         hMQ5ZKza0Hf5sTuXCAc1VFbfz9rNNAA0OpeDsHRquBv5TqJv4No9yVi3Qopq/DLyiMJa
         QxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973432; x=1715578232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9eceQ0IPQgvcClpLg9adRP7wmQKiFwD/5KRHzUimqY=;
        b=CRXX2295d2wuSJxasQl5d2Njwf73ZpFu3pTSjrheadwP+um6E075n7S7ZSDieS/X7F
         8g/vM7H1FpTjeovx0X0loCCidtRXEZoDGdRjfuLmuK9kPyDvVvhYRYNPde919zfJN7Xz
         0Lg/HYG6LboJpBfb5ZORGa6Xq7Z3bMnHCh5XDjVkpVT2rVi5jBlI3YUNsN6SSAjrWx1W
         fA4Z7a1jCw8C7AjYVNCeVl24qbjN5cT72tfRRe+FNPmz5bUMRrt8tSCYCOzJXdLQK1Wf
         sHm2dsf+duaxBban2CMn0zvYBVRgKYhzvUW4ObHOpcx1mRB+e4eh4oFsoUx+2FO1uYl/
         QEhA==
X-Forwarded-Encrypted: i=1; AJvYcCW9t38lVXvP9mYLAWJY/9TQqAZSl6G+6gywbFSj3prqDOZsPS/S0ajxS/P3qPj0lug76jeVIZAwvBuJB9JOemznaCXQZLxr478kVj5Pr6E6ig==
X-Gm-Message-State: AOJu0YxwPUEh0wco+WXMGAZvOL2yXFprs+RIvdiA9oDYG11fd3Ea/gZL
	L42qj7w+jBZirlF9RaAAEPwDrE1SJ4DZt2uBFZo8A8KYPlpOMIEoKwWMdmukKAk/CTi4dRN0juR
	yXoj/dQ==
X-Google-Smtp-Source: AGHT+IEhOZv1p1zs3TnUGO6lf+4CykGiPpB1mkJ4IsXZPJGzL/4mqaPmD0EEMS34GHaQzHMnj1shCFO74F8d
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a0d:d90d:0:b0:61b:14af:df5 with SMTP id
 b13-20020a0dd90d000000b0061b14af0df5mr2514160ywe.10.1714973432656; Sun, 05
 May 2024 22:30:32 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:28 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-4-mizhang@google.com>
Subject: [PATCH v2 03/54] KVM: x86/pmu: Do not mask LVTPC when handling a PMI
 on AMD platforms
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

On AMD and Hygon platforms, the local APIC does not automatically set
the mask bit of the LVTPC register when handling a PMI and there is
no need to clear it in the kernel's PMI handler.

For guests, the mask bit is currently set by kvm_apic_local_deliver()
and unless it is cleared by the guest kernel's PMI handler, PMIs stop
arriving and break use-cases like sampling with perf record.

This does not affect non-PerfMonV2 guests because PMIs are handled in
the guest kernel by x86_pmu_handle_irq() which always clears the LVTPC
mask bit irrespective of the vendor.

Before:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (1 samples) ]

After:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (19 samples) ]

Fixes: a16eb25b09c0 ("KVM: x86: Mask LVTPC when handling a PMI")
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
[sean: use is_intel_compatible instead of !is_amd_or_hygon()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20240405235603.1173076-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/lapic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index cf37586f0466..ebf41023be38 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2776,7 +2776,8 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
 
 		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
-		if (r && lvt_type == APIC_LVTPC)
+		if (r && lvt_type == APIC_LVTPC &&
+		    guest_cpuid_is_intel_compatible(apic->vcpu))
 			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
 		return r;
 	}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

