Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0545328B44
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770532737; cv=none; b=CF0MoQuKxUTjuo2m/nIpl3od3t8Gt7eli0vg5gn97CBL+EppU+4HY/kiZeI2+JpmBFZgi9qAoc8gZsK4BHr7tV+pYUwQRRLxRwd59tO/zXGWr7zAgTT3Fnn43aCLWQqt2SP7+ExIyvqW0+VSSmLUFlG9rI/9Tq5scKDWlbJTP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770532737; c=relaxed/simple;
	bh=lnMMOUMy31nqFoghRVvX8VIe6miKik5AX/BmRvZnkyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RoyP6tSnggUlgkCCU3FRPFJZn5/XH/fUq59DM7z4GCNhS6lm/bxsCQw1SaVuMtKcfbVFp2DxCEdGC+NNkQ3Jgq8y4uQrs8ATsTSAwoSeJ9X86G9UVFt8PQVjtDTwXUFGqz4OHqouEguGFgWgWltjakd5e+/nuKKtbb1qLD3fvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Vkh5bhft; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vkh5bhft"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1248d27f293so8838284c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 22:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770532737; x=1771137537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cj7VDyEmyttJ6U7k+eNuSHRKVocJsp9GVC83IsF+hRI=;
        b=Vkh5bhftUJvnVopn7oj6vXxfx0HiAe6Vs/dTEIjAXN7fmSdnZOBusEER2kzMui2Gv3
         NhlZNrydadmtExa2rrXP1C5kvkBjUQVCd+bMgyr6kU/SBMYP3hhFrjdgg+JquJpyCneF
         Bnx/aUVXQFPC09VVLJvg7bdLf/BgeGn3mHN8oS6SN1Kv77SA8oN4mAZNol9lCEJBy6Bh
         JQuNmfZuA0lQCg0WewS1I4010QwhUstrzG3bCO5pQLcopQVfGDY0rZ8StWxmQMY15UcK
         6CqVXS6jWsNfZ9v2E7r+mAXTfktRSh60oEQyoTaqrwqhClr7blIAIAfkJSYx/nJ9QWwt
         CODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770532737; x=1771137537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj7VDyEmyttJ6U7k+eNuSHRKVocJsp9GVC83IsF+hRI=;
        b=bX4vrrcNRWLgXFFNGf9chisVXn2T5rFlFhpRvPxwuPKchBAeuhqkD9jSVHQ6qFlYPJ
         QXUAKCdSXuC8IYNQBvXT5b/Yns0AaeuiJ5QuB0BzrGGl82A+n73IrMnJBFN0ELrLB1lN
         W1h/ehz+VxDnqZGTttjaP79wO6qJ2/PtgOiugWFQbGEgBNDKGKsjix86NUhWKDqTKYfj
         n+1F59EdcdRI0OEHJw3mPO1Qc21F9fj13BbCj6wu5858hu6Ml6Ux0XRfRNudaLPvYnmI
         K3Hdpx3g2fleq7hgQ8dlnXL4dq6HckMy7/DcvcVOdzA6VDdjy1i2ovPT9wa9IZ0teNMB
         x80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLeKZ6KUH8R88uAVxHi6wbelVbBsbt8IBNzzfs0dsgbhnFb1KVti9qZ97/dV1BBUlLc7odkk8l10GkoOhsG4+X@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KCjtGk401Y9GIk14waOsdH9RCZKBA7Z2unbxttDDV/PZP17p
	+5cuMelqAOonxfrOzl9oCNRLl12gxl/Zle80n8/uWgeMwfUBb5ZoOvIw+1tR9N3rV3E=
X-Gm-Gg: AZuq6aKg+cdhXveY9MUQa3zrAA+nNN3P+qOVULCU9Q1e7xhqSJq9S+xdjQYGkpIwvgL
	JlzYtn/yEoJX8I3QEfgW/9m4QWUsqGLSO98DrrroZHmEuYnLAreOeqyd1DvjbKgsPlSwFv+NJTy
	GCiMrjpqvVUL/gWwknZvi25rbRgKMM5kqD8nwlN7y1vi8HIVDDwf8WwF5ZPxtqqltKEfz5MLvzq
	HqV6ylySv0I5k3KGiLbVB97USsI8X8vqE8tlv8D9HVuPRu3meVHSve02M4OYOLmNehjm/AD97w7
	A4m4zpcCzcOLOHlwoYe4ZSo1AIJ4DGrqyyEG3WhHhKSFP58BspTSii7L5VKdUQMVe+ePlaeO79Q
	4I60KapYVoPfSSv0CSCeW4mJOGT/J/+A29myaj9vp3umHlh0AePzlMuCN00e1IEJHCG9F75IIXg
	pjAS6x+aPx+VLRprj7OL7C/Y4=
X-Received: by 2002:a05:7022:6894:b0:122:153:d161 with SMTP id a92af1059eb24-12704001972mr4399912c88.17.1770532736689;
        Sat, 07 Feb 2026 22:38:56 -0800 (PST)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270c9ff2bcsm5114647c88.1.2026.02.07.22.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:38:54 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	conor+dt@kernel.org,
	krzk@kernel.org,
	guoyaxing@bosc.ac.cn,
	luxu.kernel@bytedance.com,
	lv.zheng@linux.spacemit.com,
	andrew.jones@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/2] RISC-V IOMMU HPM support
Date: Sat,  7 Feb 2026 22:38:34 -0800
Message-ID: <20260208063848.3547817-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series implements support for the RISC-V IOMMU hardware performance
monitor.

The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
created by the parent RISC-V IOMMU driver. The child driver can obtain
resources and information from the parent device, such as the MMIO base
address and IRQ number.

Custom event support is not included in this series and will be submitted
as a separate series. The idea is that custom events will be defined
through the driver data of the auxiliary driver. When the parent IOMMU
driver creates the auxiliary device, it should pass a vendor-specific
name as the device name in order to match the corresponding auxiliary
device ID.

After my initial RFC and the v1 patch series were posted, similar patch
series also appeared on the mailing list.

One was from Yaxing Guo:
https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/

and another from Lv Zheng:
https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631-ac1c352a469f@linux.spacemit.com/

Yaxing has agreed to pause his series, as discussed here:
https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@bosc.ac.cn/

The motivation for sending this v2 version is not only to address the
feedback and suggestions from the previous round, but also to introduce
a major structural change: the PMU driver has been moved under
drivers/perf/, which has been mentioned repeatedly by several people.
This results in a different driver structure compared to my earlier
version and the other two series, and I'd like to gather feedback and
suggestions from the community on this approach. If the community would
prefer to go with Lv Zheng’s version instead, I am perfectly fine with
that as well.

Since I did not follow up closely on the patches from Lv Zheng, Jingyu
Li, or Yaxing, it is possible that this v2 series may miss some important
features or fixes from their work. Therefore, I would really appreciate
it if everyone could help review this v2 series and point out any
additional fixes or feature support that I may have missed.

Changed in v1:
- Rebased onto v6.19-rc8
- Pick all suggestions and feedbacks from v1 series
- Add cpu hotplug implementation to avoid race enablement
- Move PMU-related definition from header to c file
- Change PMU driver to auxiliary device driver

Changed in RFC:
- Rebase onto v6.13-rc7
- Clear interrupt pending before handling interrupt
- Fix the counter value issue caused by OF bit in the cycle counter.
- Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
  in riscv_iommu_remove()

Zong Li (2):
  drivers/perf: riscv-iommu: add risc-v iommu pmu driver
  iommu/riscv: create a auxiliary device for HPM

 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/iommu/riscv/iommu.c      |  20 +
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 661 +++++++++++++++++++++++++++++++
 5 files changed, 694 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

