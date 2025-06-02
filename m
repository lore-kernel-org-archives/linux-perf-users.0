Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062C22686F
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Jun 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892543; cv=none; b=YQhx9NoDNzvczp6SDPYvoZwsVcSkkxf/SRa3frFKsNFk1asiAimkBqJ9ZfIIPODHFGWvbKDNkYo/zQOTosAs/xvokbhSk0HOasXek/OjWTl4gP8DgHzBw0ISx4gg5FvGldpcjXge/anwYdPJU+TWT0dcpTXeTzskklyahFy+oZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892543; c=relaxed/simple;
	bh=EE8lwX3DPSHd479fj6h8oG+WY564CeOYM752jwwfbIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFvq51cMmPDOfzoH82FRTVvHsWUdWM7p+1h1YAHHnNoQIswP+UqTGO382RcZV/cFa2PVlp2A6/Dkf3HRW29w+dn9nAdFwI8T4UgJCq/vX/rHna8QPm9d3eEhWC2MiFppF84s6c02S/+dH/AIa0wCW281FcCaK7c0vEMcJSZQ8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbbImGHM; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbbImGHM"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3dd759fd518so53099705ab.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Jun 2025 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892539; x=1749497339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob4i5lx3NjoopJMkPn2Gu2SflaQcZ8+s5uU/xFdQFYQ=;
        b=XbbImGHMT5YKWxUxFNXKd4+Fc5Z7rljkAz4a2j4ZrW2ZT17Q2jzUOjBMaRGlaH+Vid
         lpbeulD4SNnMJUNkuOPNpZGGSqNcG6rgRwmTlTiOt7msbwV374B048BW1wMhXW3ehjUo
         NpEI9q1tGFpPC9ifMmECKkhDQRgZ/ANpUfZoMaIzHL9NgdTlxGzperO28lLJDdM3mdrA
         7yr9apdzZmPOogxNLPSCEwMW0IZayhfvdE/Fzm+/Us8m/EWwd4sX/sSTCgwtshFGJc5B
         LnxxVUX3XwL6GH00S8FHm5j7azb6kV1hLhvUGvlCUkKo7ZitVhRw98xa/H8kN8UQ2gxl
         VkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892539; x=1749497339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob4i5lx3NjoopJMkPn2Gu2SflaQcZ8+s5uU/xFdQFYQ=;
        b=Lfx2C+u+4fJs1CCqjElwNDOd3AG+oIYwBn5/JRnspwaB118qUiPNgbO866E0fYZIGE
         dns3R6nQ921iZCQWLnBm9e3TDk1CXjhWk2+FK9SCfZPYVn1V3mFXWks8lqEAWFZXV3fY
         L2bhuiCr+cMzVJh0/rpcEVZWSKdukfjWjAOtZczr3gP6Wn8kVxAid3zomuxhcjRXDCSF
         /CisQsTRJHmpkRHMM4jgCisjYiye5JqSWId2hC08JCfXDTD7XZzF5/eIPPj6nqNdl8BS
         Tp+lrOPCwTEFWRjpj9yPlxoDru/OeQh2ZmMq06gr6KxStlw66K2nF21om3JPcznMm+9k
         5MJA==
X-Forwarded-Encrypted: i=1; AJvYcCW55KgiX2Pqvy0HU0EFI2pNJ5UE1nsUeOD7zW3QJzbCDd+j/15kHJvlojkdJKftcMD4DnC/p+P8g9z64hZlgGmu@vger.kernel.org
X-Gm-Message-State: AOJu0YyidExJIa7xW/n778rkoeIS7c0kUrFHbJxsjmXPt7YSmxIn1inL
	v/vgm6tORO4Fb5/03Gy4Ta4QMkLDL9jcN3j6asRTEYPGCVZjUqC8EwAv0TSaDGyOYaCDrTvRCwR
	9t4z96xn+YVHelGUws6x0HSaVLA==
X-Google-Smtp-Source: AGHT+IG9118tOdExJjBuer/f/VBDO3HNWaiwxBHIeaEYz6xcDfDEYQh0uxIwgejlm2yfIrTUPAC6q6L4NmScHLSSog==
X-Received: from ilbbp25.prod.google.com ([2002:a05:6e02:3499:b0:3dc:756a:e520])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1aa6:b0:3dc:8e8b:42a8 with SMTP id e9e14a558f8ab-3dd99c28963mr156701455ab.16.1748892539395;
 Mon, 02 Jun 2025 12:28:59 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:47 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-3-coltonlewis@google.com>
Subject: [PATCH 02/17] arm64: Generate sign macro for sysreg Enums
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

There's no reason Enums shouldn't be equivalent to UnsignedEnums and
explicitly specify they are unsigned. This will avoid the annoyance I
had with HPMN0.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/tools/gen-sysreg.awk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index f2a1732cb1f6..fa21a632d9b7 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" || block_current() == "SysregFields
 	parse_bitdef(reg, field, $2)
 
 	define_field(reg, field, msb, lsb)
+	define_field_sign(reg, field, "false")
 
 	next
 }
-- 
2.49.0.1204.g71687c7c1d-goog

