Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A83BE155
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282046; cv=none; b=I7yKElbziJ7Fg7qyvAWzeulnNNWqIziXR0NjxZbLOgNGpvGnWFa9hCU+yOmvZ3/flBXUqxk8oFmSMC4rMprZFqeppi/keM/7tpEflN4uTjK0axZUe9UNVYsDjG2FF9I9yFeEydYVzQ3kCyS1q5EHoQekZPvILeL1CKbrqU8CYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282046; c=relaxed/simple;
	bh=Jr9GHQcf3RdzwwtRnCItKo4sCUWRHjF+O7j7BWlNpGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3cOzKKfHmZusmokYP9YtKHEvmqF3/42eAVtulzm5zECmnWjGVKbr4H4UM8rNIRlYw1mrsKbhhRp4K99HBnokBqOnb/t6w82VasRAq/KxBB6w1A9BuunfTjwxSa6RT/CUCyBCftHxCCP3AOo919V4wmgYX5+2yBTbk+v6GDpCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sON+IBCw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sON+IBCw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c823549b1fcso3167035a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282044; x=1778886844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ESlcbjSp3UYDyPbVz7XSSV6N6GJseh6UMdqjjv4ba1M=;
        b=sON+IBCwcvnbU450MAwPaIOM6GWgEGV6mN6Apzsw8aoqjTFCc47TwyMCnEDkmNA5PK
         GCjIvk/gdJyxRlO+a+nP1aHvNO34WqNtSiCav8M7yYN1VvjZcJbhyaWTYr3iAOLUzVBe
         427k9vzXa9I8YPrhUjY4HNTcR6fDthO7w960JazhlOJbqD8SPDE5FND9hafcypGg7dhQ
         5qvspLJiHLLViNGnPRuIUKCBGKIBdlcKNzYhQdbNKaQPLS/ml/mskJQSuWigHN0t3l7b
         znhxvTNKlAFjBJea8GR2fqWj5+/QFNU2XvWsxg1jNy4vscXAt3XNRCX/nlaQBnegDBDb
         P3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282044; x=1778886844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESlcbjSp3UYDyPbVz7XSSV6N6GJseh6UMdqjjv4ba1M=;
        b=RQVXW57+36vGvsWDt3E2bYSV0LspwIT/knTkIMFVV/omOWcjXhHo8SXw/sL5JEpe5t
         lvLpPjwd01cDyVBEqs/ZlPsfJCpOxMxfod7UgDz5lqMbK9R1PXYWXw4mxqUNh4wweBYh
         UcCXtZV+8X+7LRbxoS5VBy6c2gick6x/j6AlT9o0EHd9MZ2cjENyvoCx9bkDeVfks5P8
         lnuZSQRTKrVe0y3rrqTv8aw7yvpTfqWaffRO7Kwl2TsMMsxbqF7tFgqMoZwN5tg3/o4I
         2VdmiACDrHvbOZA9AQzd3qOdfxzC35cDXuuMWQfYrf4LwJ8s1Ge+gKjC32mnOkJfoFAm
         M95A==
X-Forwarded-Encrypted: i=1; AFNElJ87railITOYogr6ww/6BoUCrj4e4GF5ByO2bw+AtvHJaZZZ9qq3vwXhM+aJBdQx/ulmdmZRlOtY1uuBIO6hK7+0@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCqbGsBbgylAH8ioBFeZ4fxTKOokwuW0YRvA/kKyUF7Gclmlw
	YoV4Rk9nDmjd5XLGQJPIOLgwDR1fM8rYTvjqzUfnP8qhqyYYpFvRlbeTQPx1xT/Wr885gyY04Zr
	h3MFVDg==
X-Received: from pgbq24.prod.google.com ([2002:a63:5c18:0:b0:c79:8315:4734])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3941:b0:3a2:9c28:9c3c
 with SMTP id adf61e73a8af0-3aa5a831d73mr16499680637.11.1778282044263; Fri, 08
 May 2026 16:14:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:52 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-9-seanjc@google.com>
Subject: [PATCH v3 8/9] KVM: VMX: Drop a redundant pmu->global_ctrl check when
 processing pebs_enable
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop a redundant check that a PMC is globally enabled when looking for
PEBS counters that are cross-mapped between the guest and the host.  The
for-loop explicitly iterates over pmu->global_ctrl, and since PEBS requires
PMU v2+, kvm_pmu_has_perf_global_ctrl() must be true, and thus
pmc_is_globally_enabled() is simply checking that the bit is set in
pmu->global_ctrl.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index e65adb3dc066..659fe097b904 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -752,8 +752,7 @@ u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu)
 	host_cross_mapped_mask = 0;
 
 	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
-		if (!pmc_is_locally_enabled(pmc) ||
-		    !pmc_is_globally_enabled(pmc) || !pmc->perf_event)
+		if (!pmc_is_locally_enabled(pmc) || !pmc->perf_event)
 			continue;
 
 		/*
-- 
2.54.0.563.g4f69b47b94-goog

