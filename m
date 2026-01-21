Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2563D3490
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036110; cv=none; b=DpuqiveeGAxREW3WsWC+FhjRNnRcazFkY4CeTB/lY5A2ph8pvDkS1h3FdAlhqVULvIVRuRxYYBBfgaLtBowz1JIJQnFVdKPA3p7UXdQZBTy5Bp4tLykTQ6L33iPUUUl2f3EVVId/RoAH9O1L6GxW2I2Y/3MO6+JVuUKpul9vloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036110; c=relaxed/simple;
	bh=tr63TBX3kw3rhNLR4KkCTKohb2Q3vQr3rghbN731DHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPOM9AUqoDwBXOSfPscoodN39TTQO3ij1RnjOohA27nhDgg+StLLEuOUXRQrjOtIoOkPwXNBI2waKK4Guq50HInPzpJ2YwH8sA1DDDQGsA2xrgrdYXrnQokKVOvNin81ACRKT0xxN+8jwqvjmQ1hLLTYqPeQtFyFDs331ru6KdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLlXm7Gh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLlXm7Gh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so348395a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769036105; x=1769640905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXlvlmMGjx+7txGDPivw+jyaPXiVrEUwOPpV1iC4Qw0=;
        b=YLlXm7GhBJImVFMKSkMbyFKW/777Amb4LuCYph2aadlPnPuxq4qnvJYie8/hmtlV/L
         ccxOATpxh0M0sKf7nESKhgsMSfydkFhyD6Oxie3RDZ+FFuKs+4xlk0WeHc6PgFYQQrVt
         WoNpBW6murp5L7+W7heZGeOzEx5BxjemmltKLS9rFfrdX9fe51k6S3KRkx7vY/pYExFr
         ZmJ/iEKUDZ3ydf+FgkyKes9Ia+09bU1f0tFxue9x38S7Coc8t1MuVseB/XSydmfHUhlL
         Enr50Uj2rwIFMgniqXN2YXlXFYUhWrESnBFaiRUxJzELwAbeRCnLsS31b+AzmLoDOtwT
         Pz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036105; x=1769640905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXlvlmMGjx+7txGDPivw+jyaPXiVrEUwOPpV1iC4Qw0=;
        b=s+otHiQpGQP/J3lhgvNTXf7KXhprp8IcbZQXZqLuJ8ZxoBb5jtYLj6nWAs9EwggyTS
         EY/6q0s3vfb6POcw0Tg6LhOi/2cGlR32FAvyRWkFaYjer55G/toAbiDeDkiSSLm38X/K
         jSsqlIeRbSydxlstariWIpebAsLzvN1/KnnpquvYHdnSp8aoS+dK3GcflTzXBSanVYE2
         j7No1Ad4+FwMYdHyg5nZB378fyyqWjSG7EQsy6KEtxlnHifk035U4yX2WNnIrMKRRORw
         znhAuDysQy7v010tmHtmpXYjqa8CVH4eGtnqn8MnrMK29XaDsqB4tbWXQ6DzKWS0+w5m
         B1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXjhFtq2GsKVccY6r8gP/CFG2CHF/Xxc0ZL1JEOA8V/ay5H5/2egLZKgCga/F+Q4pQg1Bdzz/bp3V1W1hITyXSa@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGZLaIpZvrS7JU7VsZF0ZbxX7il1ZV0jTU4juAoDY7/WSiopc
	CwcOMIj5N2UZndGFe7RZ5D39Gz/VVo9Na0ktf/4mI3t+QyuV9kYn/RbUcr8KUiKFDyADAb1eyMK
	g+R1iOQZa6EC36A==
X-Received: from pjbpx10.prod.google.com ([2002:a17:90b:270a:b0:34c:3c14:d369])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3fd0:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-352c403aademr5934916a91.26.1769036104764;
 Wed, 21 Jan 2026 14:55:04 -0800 (PST)
Date: Wed, 21 Jan 2026 14:53:59 -0800
In-Reply-To: <20260121225438.3908422-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121225438.3908422-2-jmattson@google.com>
Subject: [PATCH 1/6] KVM: x86/pmu: Introduce amd_pmu_set_eventsel_hw()
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

Extract the computation of eventsel_hw from amd_pmu_set_msr() into a
separate helper function, amd_pmu_set_eventsel_hw().

No functional change intended.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/pmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7aa298eeb072..33c139b23a9e 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -147,6 +147,12 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
+static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
+{
+	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
+		AMD64_EVENTSEL_GUESTONLY;
+}
+
 static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -166,8 +172,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
-					   AMD64_EVENTSEL_GUESTONLY;
+			amd_pmu_set_eventsel_hw(pmc);
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
-- 
2.52.0.457.g6b5491de43-goog

