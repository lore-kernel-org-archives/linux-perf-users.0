Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A444CAEF
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036117; cv=none; b=JcK5u0kSdJXdnVEz5aMfhs1DfRd4EFV1/JlaE575Mab/VLj9vLGr2e0OortxffLHnPTylJsl4f8oDtgzJnuBRXjCyNAMXy7iWWIUYMVv2hGgBa8vcEfno/UxprG5lTQs/05YN6MGvVqukvuedwmOB/zwm7XMghGKSxOzyfO1aIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036117; c=relaxed/simple;
	bh=HT9+y8mKylFSQlO/MmyV5jBusINMym2xe/5Knog9zvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TjR5aF4gM9GdK2hV3HCG9JMeq2vtqmW8cXsC+40g/YdijHHJwQhkOADp/OzW4exbC1EILVPE1VCb5LXpnyHasLbKY/o4tDm7pcneuSBxWAx4P8sN4EckGRD3pET0h+vNOx9uO8ghTgPZcuUyJ/OEJKTNnBxlhk6uQ+/WZhzRjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yy7bZ3Km; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yy7bZ3Km"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so296950a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769036111; x=1769640911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtdAHoCCv8MCt5Cr87qxdzWERLXvpLO0KrAAEyK/DWI=;
        b=Yy7bZ3KmDt6CU+V7lC4vawxDm8eZhhsR6NHwC13pltaD2IVbzDqf5WIp3gCR7RIL+p
         pXL5vF7WrH4z0pP8FPpJ6kMQ+PRAajrOof/weWsRvkbc8MLKpo7giPon+6U3wmuKgN7W
         1dCk+51IMdg5S+n74vsbO4HmXQnSUXYVQCzV/SH/HqyeyzrjpD1S9OLGVyS6DW/M4WX6
         B+JKTwh5gvzgmNOofWLpR8is0frizuinV0Obr+ksjCe42kUG1rN9X3yQsolZkywhvLYc
         f3XIN8moUu5Wi8onTZE5ZtbOLX97Nf27Nyzm6IUkYf0MstMaSDlXyt66ru1Lm9N/qWhL
         dNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036111; x=1769640911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtdAHoCCv8MCt5Cr87qxdzWERLXvpLO0KrAAEyK/DWI=;
        b=nK8g3qyPwwgr2bWymR+JMH14DF6n1TZmm5bpbF0lQFBTig2OIcMloB59f5Q4kftBHK
         DRKEF9lcfr3kvSZvzRGGw6Mo58/mcJTHsVFcuu8fKe9mOBXvd8TYDpakSzEacTI61XWn
         K1i1McM7mPKewaYEvhm2utsybRqlCMYm9CgqyhwQ4KxWr/YRxnxmIwjEFM3Q0K29tDk0
         7o6nkZt77KMRvC9pIqwRscEeSlzeTBsn7RTsr5cMb1hte6QSl6ZyUB/bDPRK8Lx1ywc1
         c8pTOHcJUYYI1f5eybbyUiQJzGh9+Zj9rqtegoFKdyeVZj8cUsEkCNF76aBtcNVr1Lhn
         X/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb/cy9rrRrZxkmwR+x1vMzF725phUlrp80Rn4Sur2YTjOrZPe6mms+rsXDj+pQRZd4YrGeeoXu74yOWJS0Oeuv@vger.kernel.org
X-Gm-Message-State: AOJu0YytHMb1wMt/T2422BBmu9D5pSqUGTyhqQWkP7+QWE0GKO3mtEt3
	jGVadG61us9xMBUjwtFytdQ21V9+Wtjl5u5unEVZCTzUloz86xRJKsJytVUtUgU0rjGY/+ZwgyX
	yIAxGYaRSKtqH6Q==
X-Received: from pjug11.prod.google.com ([2002:a17:90a:ce8b:b0:34c:c510:f186])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:58c4:b0:32d:f352:f764 with SMTP id 98e67ed59e1d1-35272ee0f99mr15487736a91.2.1769036111123;
 Wed, 21 Jan 2026 14:55:11 -0800 (PST)
Date: Wed, 21 Jan 2026 14:54:03 -0800
In-Reply-To: <20260121225438.3908422-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121225438.3908422-6-jmattson@google.com>
Subject: [PATCH 5/6] KVM: x86/pmu: Allow HG_ONLY bits with nSVM and mediated PMU
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vCPU advertises SVM and uses the mediated PMU, allow the guest to
set the Host-Only and Guest-Only bits in the event selector MSRs.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 85155d65fa38..a1eeb7b38219 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -262,8 +262,13 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
 	}
 
-	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) &&
+	    kvm_vcpu_has_mediated_pmu(vcpu))
+		/* Allow Host-Only and Guest-Only bits */
+		pmu->reserved_bits &= ~AMD64_EVENTSEL_HG_ONLY;
+
+	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-- 
2.52.0.457.g6b5491de43-goog

