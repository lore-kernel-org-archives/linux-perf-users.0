Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE523C8C9
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457922; cv=none; b=pbebpS+nj8OIEAI0OGMNGBOt8sjWcOyCNE9tCiOJCo4ZaKK0op+jjs2auKID35JT4ApTpT58rViTKanYuIs5eNzA3EOC+iwGYh7rOeOfMWUCHbXlw0j+SO7P8D9ZiXJA84TpvPfmMTArGtNPXOlrS7puWWL5oJZxHCrwfqGLbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457922; c=relaxed/simple;
	bh=hEI+Ws5Ed4T0XYMyDeyGmT0ZhHqtHUDKeUxZmkH++E0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AY/YFlDzIqOBhd+l/DYG9wVLJ/ANCL3IOLCbIvZxOmPyuz07UQxrYeOfljvjhWNRHSfJzpXta5P99UfvGA+4y+feT8MpE3CifPAKOZggeUwiyOVOF057cLHIVgE2rd71p1+Xmwe2eh2glbUXcoFgmnum15+BhS0fWdK8N4iEdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJpAyO/B; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJpAyO/B"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddd97c04f4so31195695ab.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457919; x=1751062719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzpL3Ld7f3Wg7N4Mr5qllGNQ06XKr05fHXYYgZEl88s=;
        b=BJpAyO/BtidrS4k3gtcxF0or8fzizr8Vz9hZeEeiJYHA55yAh419X4bhab/XKH/5mB
         nUB83IBqajn29noD1PY/k3oLa2fORyHziD2wlBBQjAM8ob9lrGdGjIYoSUQlI23gDJj1
         wDY16PKaPpH7PQYTUikCzVi8Wl6JcqON+9frJ6AOtNZMkDbg4Ll30xG1kelIWdOWwXiK
         +dNDtVVuWJaf3vPQkPKv7bwLEmB+TxlPew538h06TuxYXDZo8BdFI8YFOenanmnGbZJB
         1NGElBTA2caOAkGifvt/qQQFeR5NIL+pa6FlXBLLTwKuz1iOXN2PNGRufnKY8SuB88jy
         pFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457919; x=1751062719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzpL3Ld7f3Wg7N4Mr5qllGNQ06XKr05fHXYYgZEl88s=;
        b=m5KI4ku2t+Pve3raW+FfFwiTCNN67la6uJ0gchGMKu5S7N+tUuOuCoy4NHB/Lx5izh
         N/ckq9T+0EpyX09L63fdJJoY1i9uOcD/2707EvT20giBomYfNdjLJWpIFDrZuCmE+y39
         EAhAO+UfF2tVUcgOTkHb3wS69wtngKpsCZObU9x3Kx/868yrojD0BWuJlp/mLhBp/VMX
         dDRD53gW2+e1B1bQOewQqkEfoGc22/Zm9Xqtu6jj8Mdh5pDbvzTUM14exOPbwE0yQrSj
         jYni0tQ9gRZ++tXaMQRgW+VM4Q9eGhzj57dswy25ipeBC7cF01kHUarZyhxVFLjEzg5c
         o7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEOGvM/7XGgxmEW1D3L4rDCeexefuv2fNVgOrVgUFeRsUQLWRJDxo2KEjmWcqw4rxInIUxeFLnCoyGo6pT6Dkr@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXNm7AFUeglQbZoJwbuG8VC5h/YbsW3j9gxVguQADiKfsHhvc
	zs1MyEYBON3IzYEf/U8pDmbsICkMf9x8Po7uJkoe9mzp3+cY9bF5x+3aTBWV8U3AhYK20lY4Y5p
	qNHFLfWVt36DdMblDB+31o8S81Q==
X-Google-Smtp-Source: AGHT+IGe+i459NmOZi236cX8Bur8HwnWegO6n5YG8V2oQ3pdTXQJfj8y4MrKY8v3FuSI+vF/XixyV2nwOspzfQufmQ==
X-Received: from ilbea3.prod.google.com ([2002:a05:6e02:4503:b0:3dd:d24f:26bc])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a92:cd83:0:b0:3dd:cdea:8f85 with SMTP id e9e14a558f8ab-3de38cc7adbmr52345645ab.20.1750457919574;
 Fri, 20 Jun 2025 15:18:39 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:04 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-5-coltonlewis@google.com>
Subject: [PATCH v2 04/23] arm64: Define PMI{CNTR,FILTR}_EL0 as undef_access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Because KVM isn't fully prepared to support these yet even though the
host PMUv3 driver does, define them as undef_access for now.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 76c2f0da821f..99fdbe174202 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3092,6 +3092,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
 	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
 
+	{ SYS_DESC(SYS_PMICNTR_EL0), undef_access },
+	{ SYS_DESC(SYS_PMICFILTR_EL0), undef_access },
+
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
 	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },
 	{ PMU_SYS_REG(PMCNTENSET_EL0),
-- 
2.50.0.714.g196bf9f422-goog

