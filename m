Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6A27CB12
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531764; cv=none; b=D5pVueEMbTY92+/jiXyikBNu0TaQoR1b0+mVp4+ulucCS0nftEoWJyei2hUy3NRa69oJCxiH8G2w3Inp57y/1v70ouw19LaHbHn0Z010QpbSX158jS3Tf1o6c2d1rh+BC/6BAsXIO3xlc6HYolcdm+6N1dhG413kBp5JXtZatBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531764; c=relaxed/simple;
	bh=f5noS+6MFnNZ5/918HPeH3J2Z+Rlodkc5p0XHS41WVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wq2ahTbSG52iq/zmbr3lRIWqODvj5WgD1t+Xix63vwFK39JnLA8uyoZBFhtjUbe+NsLK0p1hksFOz8+DhvLVpodedwnqX08BxjKaQwPtiVpN7/9FM6l4RzxBBTeFx+f8P+lPTbXI8C0ELAziinfE/B/Reru3NpprWk9e0sS9q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eprj4Yt/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eprj4Yt/"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so4115544f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 May 2025 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531759; x=1747136559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMCZkyRZidUrNwX5Cx9PhWIRQc02z6irI9+xxc34niE=;
        b=Eprj4Yt/Cfv4Ot7IzxplxAPFDJahdZrUbGk4djJOK9s8tWj/hMD5LeZ3hhQJ8JJEeT
         3lKyx83sjEd45LT/kbQRCUt9wjzph3lpfoyqBZS70Y/eti4lbVYaha3jJQFSjyOWbi2y
         LtNYyDu9tZ9UrLNxm8b1aowiMFDeFNRl6XFndRAqN2rh14h3pHQQ9p+A7DoDzAtqYnd+
         Ak+FJuNr2kqSo6VHsrKdDAIRz3W+/vimLJZHy7+avKaa94+EoIJDKEB8k85F6E4SQT0S
         nflqNwjAgn+G9yy+2WMzoeNTSFGWQOi87oD0iKE1nrfmDnaZY8L3oH20QptjhT8xH9J3
         K5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531759; x=1747136559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMCZkyRZidUrNwX5Cx9PhWIRQc02z6irI9+xxc34niE=;
        b=HS+30awgDKkkThP3umZ9XUCJxHhD5kMIoji0i3sJW15gzXWscItUjILHhZ88ZNoA2I
         r0Jw5KO53Mx0OiAvOj4fh7NwIrDXGoVK5tkcHsSWIqNVHhDZNbrr7yBQZrDAPDhsYpol
         CwaV82+QNoO8TXpTkR00vvu89BO48A/iYintkI88PH1ryN3S5QHZ4+GZDtXpekQPOw13
         lWXI4zzQ5yg7M/HZFUgwbVGeKDeqFvBGcPAqIrq1eHXRc3NuRvTgVhP7EybJkRfofY9P
         +6arnbUZRx8ZMQgvFgoCYbh5V1k2K9EfPifIrAdydwKc34MTOsN6dbUmODS1N3Ru3jvW
         am0g==
X-Forwarded-Encrypted: i=1; AJvYcCVH8h++ftBaTWKYq0OGhl4bCFHzZUuH/Bs98U+jRhcsqxkfRpdTBLpvxfCYBN0PKjuJPKrqeGizz+feTM9MQT4D@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1q3Lvx9Vd1n6UHcqXlTxQeiXEsZjAMFxMyEJbJV3qPHAf2MLD
	cG3UAgE9x1PhlpELnYZJMePHw1ruxc7ZSurVpezZa4Fb5H47Lb5bOYMAiDzlMU4=
X-Gm-Gg: ASbGncs16CNXDTrz8fzOgab67T1ChuFyz2C8XxDNSl9Pg0U7VGqpw+S8Ai0c/AkP1Ml
	oEn61TM2mh+qzeRe3F16R3/tWnkKjWEgJ5owVRNuP6SLCLgMsKYctbHm3CwxgXdtCGyu2Mj1Csr
	SdP7l9SKFKidtYjpdl5hIy+424cV9PHzvabaFiVQEIx+9Borh3RFlsuII9wfmHy4kVRguhYKpaW
	uePXjWZPFs0YwZh/uvRtDc9EN8a5qPW+ujxR/j0BDKZGISnj/f6K/hFMhwz/0/eCxVQUO01PtIw
	hMia2/Rh4aUGwpmjoqbHlPQpHu2kAvUPmOSU3zy1Wfw+pnQ=
X-Google-Smtp-Source: AGHT+IEqsmZ/YIUi8UcU8BFnJER1OGJ/WDZQZct9hbwqvalINWwYx3zLaSDOzEHLPrVfQzLWtlkByQ==
X-Received: by 2002:a05:6000:1787:b0:39e:cbe3:881 with SMTP id ffacd0b85a97d-3a0ac0cb3afmr1864442f8f.12.1746531759068;
        Tue, 06 May 2025 04:42:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae344esm13198473f8f.25.2025.05.06.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:42:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 May 2025 12:41:37 +0100
Subject: [PATCH 05/10] KVM: arm64: Add trap configs for PMSDSFR_EL1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-james-perf-feat_spe_eft-v1-5-dd480e8e4851@linaro.org>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
In-Reply-To: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
X-Mailer: b4 0.14.0

SPE data source filtering (SPE_FEAT_FDS) adds a new register
PMSDSFR_EL1, add the trap configs for it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/kvm/emulate-nested.c | 1 +
 arch/arm64/kvm/sys_regs.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 0fcfcc0478f9..05d3e6b93ae9 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1169,6 +1169,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
+	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
 	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
 	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 005ad28f7306..bda6195d7586 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2950,6 +2950,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
+	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
 	/* PMBIDR_EL1 is not trapped */
 
 	{ PMU_SYS_REG(PMINTENSET_EL1),

-- 
2.34.1

