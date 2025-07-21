Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E12D8793
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103114; cv=none; b=jFeN/TunDDDe5OQCcPVnGl1MTvlIjfiG/fjbZ+vBxHqisd0PYGwcIXl8vFV6gLrJhltO9ZfY34ccqPRJQkFKp0689M+MlH6yUwAufxyEexAVJnyBzHBvmyC5PddA+BdnDkWt6HbBjg2fxQNXE1rcdk4jPtVyvCo+MRee5xsPVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103114; c=relaxed/simple;
	bh=ajsH4sm5qIk98uVqstoVul55QamJ8yj95QFZdJtL4io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFlN5k/J0xEhf1GuI/Awn2XD90RSqpB+ACDOHLau5x3pKdZjUWA7xeIJUjBd/45Ll6OEGNuY7IcEx+UlAZqEmCUG44Ufxq+Iy/4+jB9TjS9n7uZh9ZqULbcOUGOk849yczaHSe8HtLtE9G/Qyn2VOD0o73BIEokZFSFApn6fuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Btk3rW9a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Btk3rW9a"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so29872435e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103110; x=1753707910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgBaXSS6eoL+tzDWl4vbvLMipClDtwiPdRYN3wg5eT8=;
        b=Btk3rW9aWAfCrwcaormqPLZRNf7IPkm8nNVxe7f/iDXNQkO3zjgd14W/Dn0KxScFBt
         T5Wc1drdZDdPTrk2pmiIM19klMSm3KQY44ZcJTVXiPyoYJ4JN6YshoBxgDy5AyhX7kp3
         B+4ZkBl6n+K/Qwh2JaW5YAQUEn76Vvaa+9kXLcn2IZJX+YpU4VwuoRAEF7NvbwE//XOI
         TmYmbN3gTfSaFKk9fC1e08wExe8+9YN1bSBJpqIQ/aXO8AS676J7XTKYbjWi68bdg01a
         MXzJYkZZUIDOc1wXKpjW4QiDmZWhdA/OnY1zb+zyyyXq4K5FDN5iiCPTnqY5Bc64+s8t
         mLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103110; x=1753707910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgBaXSS6eoL+tzDWl4vbvLMipClDtwiPdRYN3wg5eT8=;
        b=AbkVRlg8h4SRXLM4GXDKsuH1QwlM2w0ppWTImpUCbEeExJkxBKU3xl/LT2cNVTCy0H
         6NiqoDyeCVtpzP1w3uGeJB2qNXLZ7KLVE/vTbrM8b/5Y744BA9nviyxh3m8J1hGsO6Vj
         M1tC62664CAxXqzA+xHhdNdO9QXVi1XX6lLivZ74UTnJZlEbBGkGlgdeWG2eJpz1MOzD
         P5oT4ws0fJqtb5bLSNIjrSyWLqg0CG5U2xYMNeCILT+8jLKvam1wv3hA9Zb85u4RzTKl
         4AUyW1CXj6Qws7SaZ+nYFqyuJ1iX2XQ1R5fp1j27KiJpmeNIlFz2u9LeytFGq0Gqpw/e
         dqEA==
X-Forwarded-Encrypted: i=1; AJvYcCWU1gV+LtcHNPDC0Yd0EGQwAf9Rjd0cHNnx9ufHsAMJ7Re8DUfhmkFY1lGuqkgWR6WFfIsBraXKHnt+yl5Pnnev@vger.kernel.org
X-Gm-Message-State: AOJu0YzBahSADgoiIM3tzJIF4OzznbPrLviR8PKmpBeD5UtJNyM6piSv
	AbTE+NQthmeuFLT/f3E2uVXrZmJakAwYgB8KogOZu3+Q9wlzKxv+hB9Up+7MB7xSwI4=
X-Gm-Gg: ASbGncuD9VmFKP5oK3YjTdWjqVsHsFSNxit9kt92147ja3EyfF1vTI+SSDqGGfAX7uF
	4hsfnsIsiOMjTzc05+INAjUuJXHcXsdu8kT/fQnSNQrFf3CyI6wnM18G8H6UlR7yjw9uMnHsnIL
	KLuPxMjNZUuEC/OB6vnRE1jgzxH3z4vYfSvluehqZYJGOJzoxMYdp8WEQ1Gb7OWNKhLkEjrtDw7
	FLQe6R05uJ7u2dnJtV+tAMTev4lQZeQxrJydgds1d3So0xhk1DUl91+Gq3ZY5l4w74UPv7nu0ed
	KhrOSE/wCNZeLzC0tYbg/fPMAxajFb7cSgpHDtA2BlcWuQjijMhZLziDzGD0lmX7RF/WfzawNfC
	09m5b6GQysqd5ehBZnwv7/9VdgYDHJuQ=
X-Google-Smtp-Source: AGHT+IHW55CRAG6BTroVDQBsZVUrLOllfWSe7q6H/nJVZXgEqWqhx0CeR+WIH7uAuxzefIuhCImklQ==
X-Received: by 2002:a05:6000:4704:b0:3a6:cfca:efee with SMTP id ffacd0b85a97d-3b60dd6aa5amr15956756f8f.17.1753103110115;
        Mon, 21 Jul 2025 06:05:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:04:55 +0100
Subject: [PATCH v5 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-1-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Add new fields and register that are introduced for the features
FEAT_SPE_EFT (extended filtering) and FEAT_SPE_FDS (data source
filtering).

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/tools/sysreg | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8a8cf6874298..2e897d8a4040 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2859,11 +2859,20 @@ Field	0	RND
 EndSysreg
 
 Sysreg	PMSFCR_EL1	3	0	9	9	4
-Res0	63:19
+Res0	63:53
+Field	52	SIMDm
+Field	51	FPm
+Field	50	STm
+Field	49	LDm
+Field	48	Bm
+Res0	47:21
+Field	20	SIMD
+Field	19	FP
 Field	18	ST
 Field	17	LD
 Field	16	B
-Res0	15:4
+Res0	15:5
+Field	4	FDS
 Field	3	FnE
 Field	2	FL
 Field	1	FT

-- 
2.34.1

