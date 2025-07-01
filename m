Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621B1D5CC6
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383981; cv=none; b=MeTUQ/VFzBOsv1Y+p/A/KFnaB0GJpXe0rizR+WXlkO8wUJjy8x7cRs5qbwFKjifnd6WWIJ40YCEICxmf1LTPUplHL3I6+9B1T/YSU6FK9bgpjYK2BkR1vcgwRZCbIKxK5B5ZmiuBYTflRjmgKbjCekQh6hPE6b/6VL5QZ7fY9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383981; c=relaxed/simple;
	bh=PjPyvNgy9hm7ONMITzr0T6sHroPPo9twpkI/M+XTD8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W1osVQVNftsRN/LmODzhEq2tZHGpLsKuVW18yTZyF6j1ehJa6TmzCKMpvruzpA/IMEYHt2xBlP90BRj08XZRb/bciHeGvXpEEOiIS7DdYA1zCQ/csF2WSr2xcA5ZMg02VWjPyKHYEet4VMzgndNQwivCNudQdL7eJ0ZvXWc9db4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlJtrpnG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlJtrpnG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so17977345e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jul 2025 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751383978; x=1751988778; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wjl7TqtpfpT/cVhyOMYZ+YoZwvVH3I5MuberAw7nso=;
        b=vlJtrpnGprK+8FqwiyMFA3wNglLVTPh71rhca3xouR7RStj+Wofo/fTVgO6wdkri7D
         nkFIcAgacqC38vbzFgYqX6823OdYWznW1C4ST0FH4eoRNTZkIMOB1q85Zo746mPJFyOZ
         QLBTPxgTuQ3/WzMIbKkc9f/DijcDJTAbdTTH8JnG7lzGLpG7idGRQYwYfPpQXzkMk+vg
         RG8Uz2sW6EUVYxmlIG+Ju/YeCqRQYVtaaEYUoSNxDR4KW7Qwf+5JauCtomM9BCXoXdKl
         unxu1+X803L4AOyUpJj6b91fLEkxm/Mg0aijCbkLbfJ8VZdw4FyDVY1waWvdYhzSSqhW
         RGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383978; x=1751988778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Wjl7TqtpfpT/cVhyOMYZ+YoZwvVH3I5MuberAw7nso=;
        b=OSwHGkTbfa+Dtfc1oWYjT/kO9j+6RiRl/ucZV3hQOfrlYX8z2se3q2/1wvcZD4KmLn
         Oy5hSwzDyIySvj4VPDiOIf8wj4bo59DBM6XKSP0HT3rlKBBVlkd4X18DIguaebg8u3bc
         hTc605pfh0Xlcb8XnJucVg5Rxy48ySPtC8oCTsoD29ljZ1/9ZAizkx38jpu/i50XzjCD
         bvHO8H4NPt+Idb/AszMU9jKsquqzc+o4zjdtolOuzxLqblLgK8amWrl8iY2nChM9uwml
         doVIEp4KGAGv2q1Na2VMKpiuxnoNRCDmvk/q3o4tgYwoXI7+N171xu6hU/rPdO0XS4BU
         pd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxTDH7HCOhHvL6CyZ5/WnWPgXlsZxVGH7qW2/OOa9gWWbHxE6pVptBHiHhDLtk8fec82QvFqfw3YQJrmXqsbVM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8d4f0MCHiWzhV2564hfrjPCxq3zYEeJ3kbgxWVf5tSCg2H5l
	/HzKzsG7D2MkpY8GH0TeadiAMlIsuWhP6tUnjCldWijCzmsQ+gQWVfnjJuonHPASEjs=
X-Gm-Gg: ASbGncsdWB94C6x1pb14v9WReHB13RUzSTOGS9YWCQtiPj6kA15Qcas6+83Tv9GzOZG
	8L/2MR2FOgayMl24g/Rw1d4liJcsDMZ2dlQd5frvVAYT/4HOpZB4FqNLZ6VJEwbR3VlZHZ0Z8Ib
	Sk8Knrlj7MG/DWmQqgZOLrfa1gwH2hiREZ8FopK3JPGW5A9h8+J8ilKsfK9vt0Zo8I1LvBwngi+
	q7FZHA1KLO6HVuhtw1/v77v5zk6q25IACRyW9v9qE7D8w1SGRjLd/7GHwLsOgb94SsntAnpwuZl
	onyJjbnNor9Q8BPpAUnuxFb8BBmA1vDbDFWGqe1v6KeU/X8Kx5hMZZNj4x5LqAckyPqjePffvrK
	KVzdq6g==
X-Google-Smtp-Source: AGHT+IFfPvs67/UJpu/9kyB3q+XqucTe78Apo5J0t9CmwCnnIvnAeglojVve+6TRV6p2yD+cqIsekg==
X-Received: by 2002:a05:600c:5250:b0:448:e8c0:c778 with SMTP id 5b1f17b1804b1-4538ee61eedmr160326185e9.22.1751383978328;
        Tue, 01 Jul 2025 08:32:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5a3sm13435002f8f.40.2025.07.01.08.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:32:57 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf: arm_spe: Add support for SPE VM interface
Date: Tue, 01 Jul 2025 16:31:56 +0100
Message-Id: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGz/Y2gC/x3MQQqDQAxG4atI1g2MsVrtVcTFqL82gqNMRAri3
 Tt0+S3eu8gQFUbv7KKIU023kJA/Mho+PsxgHZNJnJSucg0vfoWx7eBzZQ0H4uQHsPT9M4cUtXs
 JpXiPmPT7H7fdff8ADND5UmgAAAA=
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Alexandru Elisei <Alexandru.Elisei@arm.com>, 
 Anshuman Khandual <Anshuman.Khandual@arm.com>, 
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Robin Murphy <Robin.Murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE can be used from within a guest as long as the driver adheres to the
new VM interface spec [1]. Because the driver should behave correctly
whether it's running in a guest or not, the first patches are marked as
a fix. Furthermore, in future versions of the architecture the PE will
be allowed to behave in the same way.

The last patch adds new behavior to make it easier for guests to be
able to reserve large buffers. It's not strictly necessary, so it's not
marked as a fix.

[1]: https://developer.arm.com/documentation/den0154/latest/

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (3):
      perf: arm_spe: Add barrier before enabling profiling buffer
      perf: arm_spe: Disable buffer before writing to PMBPTR_EL1 or PMBSR_EL1
      perf: arm_spe: Add support for SPE VM interface

 arch/arm64/include/asm/sysreg.h |  1 +
 arch/arm64/tools/sysreg         |  6 ++++-
 drivers/perf/arm_spe_pmu.c      | 60 ++++++++++++++++++++++++++++++++---------
 3 files changed, 54 insertions(+), 13 deletions(-)
---
base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
change-id: 20250609-james-spe-vm-interface-2bb41e238072

Best regards,
-- 
James Clark <james.clark@linaro.org>

