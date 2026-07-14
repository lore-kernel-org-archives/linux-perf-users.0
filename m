Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D2448D19;
	Tue, 14 Jul 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033487; cv=none; b=KdajYQWjeWqVbJy4JNSB7Q1Igrp6LUHglt2Hj6SlaaFz4cISP3PE5lxJiEGxN/xmnFxrrcS0/ww5fuZPlWMKgM6n/YGoKPzHUxAloPBdqXcdpw4rade7ytdxZS+VIkG3cuy6hqkHd5Ioh82VfwT+Qa5ui6AdFw/yT2KJYVWrVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033487; c=relaxed/simple;
	bh=/lpDdtNSPY0POuS74Ecigk0Qtq7wKCr3iLNFGRcTMxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0NIAPYaGbH/8RTKTXyQTdX67bgmR368p7ETn0zlBRKfpSDFram7QqSt1SAkSX88JUVkV7EROf69SABUKpwzLJ0a83b506Hv1Fbf2GVlwh97maxF1eWcCnd4sHe9Gi2SS6CV77v4vxSg4qwhAP61LE25QJZ1IZ1DELi5l6Eyjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jcX9gOBW; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jcX9gOBW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784033475; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PlXcFe9PGrAD8oJJaTsvKAGmMOdAO7oL5qurnCWKNFY=;
	b=jcX9gOBWTDZ7yhi/2ujl7XFBo7h396aTXBPQpITuzOpo3DLBROudjI+gTy+LBSOUUdJGKDtzRzLP4EDnb6LtyRTueq4g8tX0itns38Xyu+Ar5du/vpxb/PTd1BLOjdsapAblTiXJCjKuLFKN0UFr171acj5vKKcQg6PaoczUz0s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X74eRpR_1784033455;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X74eRpR_1784033455 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 20:51:14 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Zong Li <zong.li@sifive.com>
Cc: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 0/2] RISC-V IOMMU HPM support
Date: Tue, 14 Jul 2026 20:50:47 +0800
Message-ID: <20260714125055.1974-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714083625.1083606-1-zong.li@sifive.com>
References: <20260714083625.1083606-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 01:36:20AM -0700, Zong Li wrote:=0D
> This series implements support for the RISC-V IOMMU hardware performance=
=0D
> monitor.=0D
>=0D
> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver=
=0D
> created by the parent RISC-V IOMMU driver. Therefore, the child driver=0D
> can obtain resources and information from the parent device, such as=0D
> the MMIO base address and IRQ number.=0D
=0D
I tested this series on QEMU and it works as expected.=0D
=0D
Test setup:=0D
 - Base: v7.2-rc2, both patches applied cleanly.=0D
 - Kernel: rv64 defconfig with CONFIG_RISCV_IOMMU=3Dy, CONFIG_RISCV_IOMMU_P=
CI=3Dy,=0D
   CONFIG_RISCV_IOMMU_PMU=3Dy and CONFIG_PERF_EVENTS=3Dy.=0D
 - QEMU 10.2.0: -M virt,aia=3Daplic-imsic -device riscv-iommu-pci=0D
   (hpm-counters=3D31).=0D
=0D
Results:=0D
 - The RISC-V IOMMU probes, the auxiliary device is created and the PMU=0D
   driver registers successfully:=0D
     riscv_iommu_pmu ...: Registered with 32 counters=0D
 - The PMU shows up under=0D
   /sys/bus/event_source/devices/riscv_iommu_pmu_<BDF> with the expected=0D
   9 events (cycle, untranslated_req, translated_req, ats_trans_req,=0D
   tlb_miss, dd_walk, pd_walk, s_vs_pt_walks, g_pt_walks) and 7 format=0D
   attributes; "perf list" enumerates all of them.=0D
 - No oops/WARN/KASAN splat during boot or driver bring-up.=0D
=0D
Tested-by: Chen Pei <cp0613@linux.alibaba.com>=0D
=0D
Thanks,=0D
Pei=0D
=0D
