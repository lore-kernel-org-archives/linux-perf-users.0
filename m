Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025B242913
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469920; cv=none; b=sSf6skZo5+vplWDYyK7eGapYctTrRj7oJ0/TbphuIBtQODGlDSedihz3vUNZUjnVcP1tH3C56x/OBClSwW96LKMKn2p9WxuQSsMvfdn5RcAJWxwlilvWTeM1BuLeLQbY8IXPLO6UAWXjRkxfQF51INNy5MeAZJ44+ShYAXIGpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469920; c=relaxed/simple;
	bh=v+3HOVLmAnq3kkRj1HHToRzS1R/S8QWxsxkOXOcO6PE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VKHCuas6nUB28heEDv/d/1AeiCNoBzVWJkacYp61OdZ8J8pQIgG51HASkY2IFzXJHjtxBM3Lxipd7PeQPMGoat1u9lzPpcNsxUvBnlU/E9p4LUVPwhdHlsEMwE3aveqD5QEZxIu4vH9j+SczoQaMDg9+wFvILiaOeO1hkwZ2ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itLNdZrF; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itLNdZrF"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3d0225c44e8so19113925ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 10:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739469917; x=1740074717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azo+14HeAmGjnMr0Vdj3xinAaL5HZge2DDBa/K8+Coo=;
        b=itLNdZrFRZ+o45oQarEuOUR54TwMnwnd5oEllcoJW7A7sZDJgw3W+VaWMNHqscm7wX
         iJ67qveCoqlZ9kXPB6vFDEyfUPBAIyYFVhLmE8jZoCvhQ6BhVohtc/OojUxUvYpTUO3x
         JSCKG4/AN62jqloBXWdOCSIuHBGl/TMmkwepW0sQvrwBQuq07VElkg0QTs+U95iBq4VH
         nZfvzMlv5rabch+mQ91e0ChsmiVYCI5H426gb+3cJmedinhJTKlu7sjVigzAQxFjXsnh
         JuErhFObT5fpQD1opgPfr6dhN9OJrGGYqXVI17rDycbf4q/6bHpX6cTPF1lAIeSW1tbZ
         H8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469917; x=1740074717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azo+14HeAmGjnMr0Vdj3xinAaL5HZge2DDBa/K8+Coo=;
        b=Rbs9d41kRqv2YFCJGodsxRS4J2Rr22nE2KB+XjIo/LnBx7kdaQkNN2O0iJDxrPSxD8
         AQw35HoVCkzjHvZRlfapfMK79Yn50yUhgoRNLVTigbWvKAjbEBjkAEiipI+yu5gkJTZt
         y+mHRgR7okLrRgX/XRY88AHeqg70yxlMTta18mqbtLJzk1IGZVtsM4ZJY0wEwS8wIuo2
         /3WyWkRRA3arMOl1HwL/Z43RQvXeYgpV8MTqqfBrqtEA/C0PfwroDjU4LdKx+TYrBbM9
         CpriYtwNT/ZYfqXorhNWfpBZav9gDxDnfTYfk8BT2vaK5rISAziJURJfcVzqRTgaPfu4
         JJhA==
X-Forwarded-Encrypted: i=1; AJvYcCX47EfxU/uvSmV2a1GirkHieSaDd8Hylmj9AQviUNAPQ1cKohIWAaj011xRwLg96xh70ppOhq+mLmB90TfVf1C6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6agCLvkscEHLkPDGpcl9Za63no1Dr6dIRex6AqcHsGqYRWOZJ
	sChg2MzvSWe7CyhsHo9DreDRIt35UmtHBWnIxTyakMggoMdYBrL8ypzqUaU2QWrfPDMTIxhVHey
	qBRfzjYsJRj03Y6O9gOtNcw==
X-Google-Smtp-Source: AGHT+IEy5YVI3p9y9PPdbxxSL3+aY42Gx+CIGhUYeoIGQ50w7BVgP/zMrF/otp0RuXTOXMV66ObFIzCa2Ha7BSoLtA==
X-Received: from ilbbs3.prod.google.com ([2002:a05:6e02:2403:b0:3d1:3f2e:4bce])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:170e:b0:3d0:4a82:3f4b with SMTP id e9e14a558f8ab-3d18c2d55d4mr31564925ab.14.1739469916921;
 Thu, 13 Feb 2025 10:05:16 -0800 (PST)
Date: Thu, 13 Feb 2025 18:03:11 +0000
In-Reply-To: <20250213180317.3205285-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213180317.3205285-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213180317.3205285-3-coltonlewis@google.com>
Subject: [RFC PATCH v3 2/8] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

There's no reason Enums shouldn't be equivalent to UnsignedEnums and
explicitly specify they are unsigned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/tools/gen-sysreg.awk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index 1a2afc9fdd42..a227f73cd31e 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -306,6 +306,7 @@ END {
 	parse_bitdef(reg, field, $2)
 
 	define_field(reg, field, msb, lsb)
+	define_field_sign(reg, field, "false")
 
 	next
 }
-- 
2.48.1.601.g30ceb7b040-goog

