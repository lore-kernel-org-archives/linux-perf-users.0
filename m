Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FF28CF5F
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421988; cv=none; b=tvXhyp+FBXOPOPquOKt/5quPX2T0I1NK8gF/eu+c6+7DmRaWqgekMvRhgN08uNN7bjrBpkgwRfzJ4UW3qcV2PStrKNDs46hPaIrqQZXQS+UObggCEUUdbTVCo2kw7+jBTdNiSL7Rxeh8ZPA5LYfZLASixCRhbIY+78GawRfGGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421988; c=relaxed/simple;
	bh=KCID54WfrvfnHjveY644uDJph6FoluYlGGkyk45hH30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e562w8/XVBnpcGaLrhTh/0d2T7iNz6BkVAkGKi/25beG5cfC4PEuicg43TrzyZdjZ4gSUWbGT8cAh6DzNmzSsj7RtyLAgZ21grLjABCSMHMjhm6yfypxbKKvzNUgfeJsLAQEIyP1tT6fW6A6AZLs3YfjPH2/TgNOTDhcTp7QGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH7TuOuG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH7TuOuG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a2dcede83so3423422b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 21:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786421987; x=1787026787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrUl6Rt2aPXuIw2jqPUO685GtCJeqmwjEdB3yo7L8dg=;
        b=bH7TuOuGa5yOw9GfdNHyJDD4p85pFWCB5ulDUgeENfsfor6m9xUAFPLnPFI+Mlwaby
         vk/zpcfmdxEyL6yOuGoJslV3s3mDie5fzXdAzEoz7hYCGTLgVQeZqjm0GsHxAIvkkEqy
         3i9tQxiLMiXxfmTRxBmWTi4ENNs09uR6kIKkOvxoKUrYtZYaKVylTgJiRnC6F7UscYCL
         U4Stwc0oiCrqy93SFy3LzY0Idhx70gXhdTgKR5yMGQBx0DmOA3Ls93jRWVM/ne0uWCMF
         PCzAmP8rHpXZfsIkZLI2YhqjKIOpqy3LVR8if+05YoUgtCQHQCuSA6ACxVi8lHmga11/
         phKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786421987; x=1787026787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrUl6Rt2aPXuIw2jqPUO685GtCJeqmwjEdB3yo7L8dg=;
        b=hv/1NfpUVtMueQcl5JaOa20PMfuHVO3ES+eRe+cKdW6JgaFK2hD9o5qJ1ZU3SPFDRX
         gZnUbLbgJOVi8p0GBQGv8tMHslSQM3Wlb5jbE5ZjoAF2i/O2DAWuE6EEwJBlzxwSs2Gg
         vRg4jcHETxFp91o5YY9JuhIqxSHCDjZp9BDQ4FSUzMTSJkweVDK7ReFJeG6WaMb2xWhX
         LW4JlsEy91Z+b+uDKKYF8DwOu0bJ5ktZTVuk0Gts/VpABDvDRWoL2jPk+lVxxRavvHSU
         i+FdpW9LaoSsEC3SNDgPFg2BeMVj71IHZ6S7sjk5txCC2Ft6tzS9Rg5YK27knOFC8l3l
         nIRg==
X-Gm-Message-State: AOJu0Yw3/PbveaKEg1c+0JqaW51Ljn9q1+YH8/JfE+IoHZpTU8H5kx3+
	GuEi1B3vAzRYZFUL373m5SuByw4LcpRNxPkm9WC+I8uHSqDfj+JyL6oq
X-Gm-Gg: AR+sD13dQM+SjBUN+CtfTXJX3tl3It8nWCq7t/t24desm4riFoz98JdwlPCDrqqAOub
	ph9KFZpBdviiyRhJxaIkEBvsddGhRJF4kZKtXK+Hav0ubWFhNTzpOkskcMfUT0gJ56CYjgimXnx
	DANClYZcY24vGryzisH8Xfz7HO19rvIuUvDO9TMmpXvAjaSHTumwIdtGNsjedjrRY8jLDF+79u8
	uUfVcJvLyPOwLkGOHirXezqexT+SPLoBheWPGmvH3CohjxopAZn+GfHClOT4plDqdSyeo4Pg5V3
	7JZ7aPY3ynooztJW1auv7F41tQRhYHEjmab5LgBlcx5UircHZ6LwCm7fwoPJ9FrgdRVF5V2Jpyv
	s8sBbo5zJ/G9Ie105OVK9c3iKe8wBdjnLWICt8wabuMmJdNqAWMCPT1It1rSG5+m/lILZD9xJ/K
	IfLeLY/vbUk5VSwG+GrUttfruOTfgcPudWvEng3E9LLrAMheXwTOFVVuTYEdtChZvGSjpvQwYYf
	lNtKwq1IN3AOXaBR+KtFSxtJjg4OxUtZcsbFY4aB/C8HaAz+p6UnThlVDfbg3Y7Uj433vzFMFOd
	Y3Gyem6WxhpIJH+DmsBZ9n5ZwE4=
X-Received: by 2002:a05:6a00:8d8e:b0:848:788a:e7f9 with SMTP id d2e1a72fcca58-84fa883163emr377386b3a.18.1786421987024;
        Mon, 10 Aug 2026 21:19:47 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9195371sm17687b3a.11.2026.08.10.21.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:19:46 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ lookup
Date: Tue, 11 Aug 2026 11:19:34 +0700
Message-ID: <20260811041934.7609-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available, while other errors should be propagated.

Propagate all error codes returned by platform_get_irq_optional() other
than -ENXIO.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 621f02a7f43b..6c942697e57f 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -893,6 +893,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
 	if (irq > 0)
 		smmu_pmu->irq = irq;
 
-- 
2.43.0

