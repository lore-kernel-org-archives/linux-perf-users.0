Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114350;
	b=PmbsIzfDCKdr/I0Rmk5Ike621aLif2PEMBbPJDfDY0bqu/nEGee8Wj1M0hsuU6XtzLqG
	 YQ/p8TLkWm4+1107UbcmehP8opjoffyxm+SUZXPtBO8U8/hXnZlS3MggWJhoj7HuTvK7R
	 DmoVEOn27MR8+Nbl+FWPPBWuHrPHS2FBZmFs44nbkS/PRMzM5bfCrlz9nFyfE4giABzGX
	 fnrTCIfS1Le44uwlILcVBOoavY6kEChOIdggNfzDt90KN3y0yBkCJQ1mU7KaZTnhFJCXi
	 yx3HJS5AxWhQ4td0jTF5B/YCEDG+2Jbw9nwQ0FinSsSur0EMCmhephIp0hU3s96Gldg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Dri93dGf86JD2a4x55noboCN1Q6q179kTQsK767li90=;
	b=uSGuuNIDRnRavkNw3YuMg1DkUP2CNejl8xa9kwu3975pWCUA57WbmR5m7uI1Cy7AJnMD
	 xRN8fdqsz3ecoEeZ6HZWeVOFwvmwhuuK68KI8TmqqWcsoFnSE7rZzLn2ic/WMiGg9/ecu
	 KKW6jsuoYV0nABdHeMc7TwYuC2gKRzqDtagSeRv30z4AW9OAKtj37Nq7SUYUrPDCuSyKJ
	 P0fdF2DXkvQn8cQnEm0R6YOtGdVgcKkEXg24TAJRk/JWSIDhp4aTsoCaWxpfk7jMSnmHo
	 04b7Y5HuU5HSFcVfiV7HX0/Eb5JUXhPO6K9MugG3R3EAt6h5lf0KDUfoZGP7H5J4iqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=istjwH1u;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8486606B524
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8486606B524
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=istjwH1u
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4b6c84feb67so184213fac.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114349; x=1795719149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dri93dGf86JD2a4x55noboCN1Q6q179kTQsK767li90=;
        b=istjwH1uDtIuP/hVh9STL+elAXD+Md4rxfVCQ5xDwA4uMSRilEvwlspwj8AzFZeLdl
         G978XmYe0mQRFfhlnOesU+fCAzp+QZ3FO9/PewFgKIz1u1WKgYh7WPG8Vjf0gOttzYoD
         NBOF9g4VbnMqKLPK7GeFgLN9SJowLI+oCYGaW9vZGYsamZJH0tvKRhELL20EhHTTZ6Pc
         h4jrX5sBM74Elcyi9TsU3tNcTnpEsGxL0RYYJW0Lipzyyr4LJQWztXNR3ezqYZ96degl
         Ylt/s++522lJwdrDmW3ytIGAfl8gqmzBVNsp+CoIDdQCovlZBn3Pd/BEmvcOEk+j0M3E
         6TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114349; x=1795719149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dri93dGf86JD2a4x55noboCN1Q6q179kTQsK767li90=;
        b=fhe8tGEDWInYEB3YEkVujoRdbzNNyUdIQRqjxPxejaJZiM6OxOs8MW1ICBv9kLPsA2
         sFFsoslFuVyWqYa9E3qsWs+68i8wuwBBxVefBIa9jYREnfumkONMc8AzyCwHewL72b8a
         CPTGwcV16ckV8te5uDhFygildOefGbIfAqNtcTA2Ep7pmrJbO32fKixfwbrQyyaEbhmH
         l3A7t4u1+QcROmHIQfS8KtKNXxaGofSA9qST5CXf7h9NCYKLHpB/AmtaYNnfMjZFjMbW
         gZxliTjoUbAwowDQMiEJGzoTXoHme1kHAcOG8KmWdovq8NouHU4En5yqOqtp4zOf1KkA
         GIRQ==
X-Forwarded-Encrypted: i=1; AL+hErGCULuvd98rwUY9AleM8seKEmlLmlonQV/84MnrSW7xWkzAm1qFar/i2yFx7AmqIDuepupn7zUcckexj3E1J5o/@vger.kernel.org
X-Gm-Message-State: APuU4Z8scyxBXyBTzmKfKjfJ3oiWWYtpKKrdchZRAR/3Lh925tZy6BQI
	qyw2pYEplzHJt1qfeRsfOhwWKQl1y5pg9eBoQVJ6hb08taGbwPz1SPE3jDjhf6DaGwSz7qtxhQj
	BeJwSdM52RXObbvKDVxYl5s/2aQ==
X-Received: from iok4-n1.prod.google.com ([2002:a05:6602:c604:10b0:9cb:3bd8:aa36])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1805:b0:549:572c:fd42 with SMTP id 5614622812f47-57a0bb85010mr976405b6e.47.1795114348499;
 Thu, 19 Nov 2026 10:52:28 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:55 +0000
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
Message-ID: <20261119185215.632334-14-coltonlewis@google.com>
Subject: [PATCH v10 13/33] KVM: arm64: Make __vcpu_rmw_sys_reg() atomic
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

Use try_cmpxchg_local() in __vcpu_rmw_sys_reg() so read-modify-write
updates to vCPU system registers are atomic with respect to local
interrupts and GICv3 pseudo-NMIs. This prevents lost updates when a PMU
overflow handler (which may run as a pseudo-NMI that is not masked by
local_irq_save()) updates PMOVSSET_EL0 concurrently with vCPU register
accesses.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 89683a690828e..103c25001c0d2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1313,12 +1313,14 @@ u64 kvm_vcpu_apply_reg_masks(const struct kvm_vcpu *, enum vcpu_sysreg, u64);
 #define __vcpu_rmw_sys_reg(v, r, op, val)				\
 	do {								\
 		const struct kvm_cpu_context *ctxt = &(v)->arch.ctxt;	\
-		u64 __v = ctxt_sys_reg(ctxt, (r));			\
-		__v op (val);						\
-		if (vcpu_has_nv((v)) && (r) >= __SANITISED_REG_START__)	\
-			__v = kvm_vcpu_apply_reg_masks((v), (r), __v);	\
-									\
-		ctxt_sys_reg(ctxt, (r)) = __v;				\
+		u64 __old = READ_ONCE(ctxt_sys_reg(ctxt, (r)));		\
+		u64 __new;						\
+		do {							\
+			__new = __old;					\
+			__new op (val);					\
+			if (vcpu_has_nv((v)) && (r) >= __SANITISED_REG_START__)	\
+				__new = kvm_vcpu_apply_reg_masks((v), (r), __new); \
+		} while (!try_cmpxchg_local(__ctxt_sys_reg(ctxt, (r)), &__old, __new)); \
 	} while (0)
 
 #define __vcpu_sys_reg(v,r)						\
-- 
2.56.1.708.g77570a6a1d-goog

