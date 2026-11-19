Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114358;
	b=rgncgdSPcIuacXvWzsNCe8Z8sci9DyAWKQOoSeFErwqB3L3pO6TnAG2/9FEr8ROEz3hC
	 H90Fc0Nki5/ycvWlazBfVVi19LIE/sSziTpBdTmq98eUatmSEf/93gpovtgfrVjWVJJze
	 huQJ73cVIkuX3P6VeATeMPsIocqtzVxDJjxuQO3kVj0wPCbI2H85DzOVgmsBVFWxr23Lc
	 8udM5OozMcZ6jnMU1T07OdWiDxPILwkUkog1jBHJmtZ+3Kuav3e8ic5P7feRPpPiuIgvr
	 E/LV58AjJ/4zN4Fen9gKigTxA+Q4J0fpIhozJHzxh9kue9OiNHD/Ke/8AGI4O5JzDZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZrQiJeW1/ZGAZNj9EqpY+oYKcoF1CcN9MBzVSNJZPxc=;
	b=u7OmX2PAsGL1y2y29YD3LLvMscVppZ1h/LgIWTRGrlUB5xqffsRSYcTdY+bq9UQ8drxz
	 sbwOTUNNS+G2/6FHyqwIygQ0AdBZxAoAIZCI0aBIBjGRIfm6uHqMoOcly3nEMxAEMHCzG
	 DqI72bFir9XTogoRfo1G/VJC751Y6y6L6pG6jloBREZ8y5FBKlge5RD6r3QCr2A6bq0hd
	 Lizr1f2jsGakV098IlEWRwsBah4h7Zv92a6V35FAi4Lru1lOr3o3a26U/2kE4rQY8LN6s
	 GAC5Rim3y9ozVgOI5b+AAQB22YaJeFb4IMJXMEDt+HU3MC82A1CdBax+xnfLRm+7LEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=djTQwvGo;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0657606E8CB
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0657606E8CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=djTQwvGo
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5727b04b81eso94002b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114357; x=1795719157; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrQiJeW1/ZGAZNj9EqpY+oYKcoF1CcN9MBzVSNJZPxc=;
        b=djTQwvGouuLjxkWqR3c9bPKwN/fycxEJsz46gazrcL55seCy00j+IlwKtjdnHf423Q
         nDqhlPtjai7dC7ZgHo5qWbK5qUAefvDOdgQ63QdA4Yngef/ylXyu9KPSipd6OdWGf6oN
         6qdA2OSrq2S5LuamR8CrJ4IgvL3krCF9KruFSWJed3J5qHLxH15nreaOEc2auIvqb4+w
         R8mav+ERdQ2k2IcsqRDdXiicDyPX0bz0Nn56HIhrS5jMhVxVjzFcOuFB8maAUzMBjDwR
         /3w0OAvtg6Ey+mYrIIB7CtSMGY6zwpkOXXemuz3r1IWrr7q90Sbkye6vss/SyHrSO7Lr
         EWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114357; x=1795719157;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrQiJeW1/ZGAZNj9EqpY+oYKcoF1CcN9MBzVSNJZPxc=;
        b=F6QM11ks62+35jTOfEkOcP1WtsYVdElYH4ul5gpOjqzI2x9lDZSbv981SBTfM9MOYm
         JpG/XM2DKFGRu5uC48PJzBlNBFOHeCWRVgcEpmeL3goHhn4YJeLxhu4RwcsaupI58lk3
         wkeyCl4WgjZtauLUKW4gSy3weTAl87h2n1IPIi2Mp1/WeDYyxpscsQa5uVekxGH3TaJm
         pQpYnTNAqlAy7GOpsMSHRWm47t/T4cf8b3zpk0DAqnVm30c1keI/m4pAw0Z1iJV+rU9n
         bWoEqb5Va3jga1UcAf25rTNmxJbe5mFjZgNNCaprbVV/OBKO7qJXpgPOQWoahoGFicV4
         WOCg==
X-Forwarded-Encrypted: i=1; AL+hErH4q1usw7AK7ViQUpxhjT4AXLg8UWkACn98C0n8EehazGPnBBgLsrf5yR4KGW6mQY2f8mZKbs/07LVh62y8TK1Q@vger.kernel.org
X-Gm-Message-State: APuU4Z+eVgh1msIXwFVU7nWWTKYoGoX+Aer0oJ2ebm4z0dDleT8CxG4l
	l0FPQfQp/7Tre4c6Fd6XR4/JPV+UESvAd47WM4laEWPQvzWoPs8NwQjCHRWnFV0TqZ+7ua0R2Ao
	ChTm9Mdt1JFTTiRiXPYEYl9zdkA==
X-Received: from iof12.prod.google.com ([2002:a5d:9c4c:0:b0:9c4:b80b:7605])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1384:b0:4ce:a4fc:a848 with SMTP id 5614622812f47-57a06a0da3amr989109b6e.6.1795114356571;
 Thu, 19 Nov 2026 10:52:36 -0800 (PST)
Date: Thu, 19 Nov 2026 18:52:03 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-22-coltonlewis@google.com>
Subject: [PATCH v10 21/33] KVM: arm64: Allow kvm_vcpu_pmu_resync_el0() to
 resync filters in process context
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, kvm_vcpu_pmu_resync_el0() only scheduled
KVM_REQ_RESYNC_PMU_EL0 when called from interrupt context (such as an
IPI reprogramming host perf events). When perf_pmu_resched_update() is
invoked synchronously from process context during vCPU load/put to
reschedule host events around guest-reserved counters,
armv8pmu_enable_event() calls kvm_set_pmu_events() and
kvm_vcpu_pmu_resync_el0() in process context.

Update kvm_vcpu_pmu_resync_el0() to call kvm_vcpu_pmu_restore_guest()
directly when not in interrupt context so that newly rescheduled host
perf events have their EL0 exclusion filters applied immediately.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index dbbe219ac874f..d3fd438a57b09 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -213,14 +213,17 @@ void kvm_vcpu_pmu_resync_el0(void)
 {
 	struct kvm_vcpu *vcpu;
 
-	if (!has_vhe() || !in_interrupt())
+	if (!has_vhe())
 		return;
 
 	vcpu = kvm_get_running_vcpu();
 	if (!vcpu)
 		return;
 
-	kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	if (in_interrupt())
+		kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	else
+		kvm_vcpu_pmu_restore_guest(vcpu);
 }
 
 void kvm_host_pmu_init(struct arm_pmu *pmu)
-- 
2.56.1.708.g77570a6a1d-goog

