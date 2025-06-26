Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8C2F0E59
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968356; cv=none; b=rGuEKoElTz0uJeUtFhabGZlOYlg9LVtOQHemuGGQPmVMi54jUmclCOl8vJUpQeOgN4ZUQAUmcokbP+hSilsPyNWFD6fiTPK+KMXGH92bLm9hzQW77V+hGogKrouUt4mdS3NNVavZo1J4qUZSmYElKAOOrASIyVio4YZH1q7sG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968356; c=relaxed/simple;
	bh=T2AAAwNCvFAm9YUhWYISU/OAnWzXdQk+10RnZrJqatc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3Kc6KSIoVfxuOWd7GZSOZWNrFWIIaSiGRZyLmFE9cjskRXtbt/5a+Q8LFysQLmojQjK3IoBThxvLvNXEj4n3aeiJG88HSzHBrq95+2WPuBjArlYR/18Qmy7DgX7YIk6TsYXFZ/j9YcilirH3Xn0FcKy2ZarHKoaCdQ5MdRN1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIRE3E7c; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIRE3E7c"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-40ab5c5028bso1513383b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968353; x=1751573153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHt9BrBIYqZp5kZ5sjlL9mrhswYvvwFRhl772iB1+XY=;
        b=oIRE3E7c3Net0Zrc38DGPcJR5uot6iNbrChMN9jOLEjSbQ7+lPcoLwaGiEHlieHL5q
         GI6t+qbp22yc02kprAzzTLCeCnL0NDN5l7cErzEHnSecjLMsRRMg7qDQ4kdceU/0aLwD
         d9gAos2CxaYeYiCNAUZw4/uL5GIqPBOFlYJKrQQP6Haiw8PJQS1u4b/rT60E93vRMfHL
         8IjF2PAX05JSzfvbVyf3TDst/7ir1SJg/mD9QxvDcqVG4FpzTIlf7LTUmRdKeviWdcE9
         EmWjeAAmvXedHn44R2MEvZXGeTNK49eN3J8nG5P8c9G/+lyviSi2EZCHJznjuMeggbUa
         9bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968353; x=1751573153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHt9BrBIYqZp5kZ5sjlL9mrhswYvvwFRhl772iB1+XY=;
        b=tPAULIJZuQMwOASDYl4ItaZE1W3Z21H/AQvVPcdr3DFaT7UFScu6xxqVQY3wa5cwJV
         bhCN/rqNREDHHO9sYx3aepzSj4EWa0j7eZxheSHCEmJV7xlDn1sTJz3F2t6rDaDXrGDU
         2pBZI7l0T32v/IkobTlFQeT3bHWZcfYdpd7NJgJ03ENU2mKltKLYjHjLqawitRtsd8bz
         fkj98c5yCxUhd3xRBce3Je/enEXBHxT8J87pvMtiu/hYMceNFuSPLs2ezFWZmYZOIFY+
         HKHyBbwNrKUMHjoA8Wu0gOvA1TZKutUgCSuXAw7ai3onImGxVnfUL00gjFMPPU6xN45C
         caXw==
X-Forwarded-Encrypted: i=1; AJvYcCVLCcoSfUq/zfVzN46kmlB1qGLAHnzvHTArps65zqrFAzWaCfGv+dpBWraEkHKpgGD1r8fuCbjYfHxa5+EtK3Do@vger.kernel.org
X-Gm-Message-State: AOJu0YxDo/tlnhQBY2xy8CkMGQxcaT2wkPFpQxtESogqEyX5t0Wg/lE+
	wQOBhTKhr3YBmIKQ6kt3LioHMBIRVWxoaclqrVylX6nnZMVvvZzxFi9qmPnBWc2AAaFbziGDqem
	gRX2vEvSzd9/dI7q3NYob68tQ5g==
X-Google-Smtp-Source: AGHT+IFlRtE1eWK/FMjUnULxroCH+ZQKYqxRY5qaFdZ+f+SoiV9KEwtPmc0HwZMn2/GT2thgfmq4kS9LjJKIm6e5aQ==
X-Received: from oibcj14.prod.google.com ([2002:a05:6808:1b8e:b0:40a:c2da:1f99])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6a87:b0:409:59d:2fb with SMTP id 5614622812f47-40b33c77bfdmr516313b6e.11.1750968353579;
 Thu, 26 Jun 2025 13:05:53 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:38 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-3-coltonlewis@google.com>
Subject: [PATCH v3 02/22] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
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
2.50.0.727.gbf7dc18ff4-goog

