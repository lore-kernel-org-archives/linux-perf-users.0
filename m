Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02437D118;
	Tue, 14 Jul 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034801; cv=none; b=JpEEm+KD4o/0fbBVBU6kLOJCuyTRBi2Ifmga8q0t8/Vu9CzSiJFuM7upLSGDkSGRgytSb/LYxBX/sgPwCcWN0ON9P/mgJLOVnjy1CFYZ8yeiRNaT7m7jzHA21LBs5dBovmIsMtMYFpFWuy6HSDxm8tDr9cp7Ct+KKzQ4tpaDdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034801; c=relaxed/simple;
	bh=G3SSAw80odoM0r4ZEpN6fbrsjq24Zpeio3GEsV6yD0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3UQ6F3s8Zj2fv7Yvw2CPzruPP27vjYHvlaK70Lrg2nh8IjPxwf4ZXcV0CFGWH0y+0Y2FdDIRh8mtnv/jZW0vBhVrR1WlLW6EkmdTW1fwG+8As/UyFGwTUwuE7cfUfLckRkQAynCAwcdfLhroQaTeJIJA4zj/TwG8XOUpqQexrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oN/Rf+/4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oN/Rf+/4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784034791; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Cvw+yLgfc5nxnZnw4xOzJ2gkqA3uMTGlyfIEWyjk02o=;
	b=oN/Rf+/4Z1Bjp7AwH+uRXmcF/5TmPZL3nRANuWzOHbMnreef7sKV0IcF1nhr8mA+6nB5Ha51B4NZ1SsRnzr7esV27PyRP5IWGOwt9Iy8/cRFa38Bzzg5IAdZVSCo15Gj7vkfnjfq3EHqvuPyRNk01IxpcHJp19bEDbPmB9hyrPA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X74q15Y_1784034788;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X74q15Y_1784034788 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 21:13:09 +0800
From: fangyu.yu@linux.alibaba.com
To: zong.li@sifive.com
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	david.laight.linux@gmail.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mark.rutland@arm.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	will@kernel.org,
	zhangzhanpeng.jasper@bytedance.com,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/2] RISC-V IOMMU HPM support
Date: Tue, 14 Jul 2026 21:13:05 +0800
Message-Id: <20260714131305.55950-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260714083625.1083606-1-zong.li@sifive.com>
References: <20260714083625.1083606-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>This series implements support for the RISC-V IOMMU hardware performance
>monitor.
>
>The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
>created by the parent RISC-V IOMMU driver. Therefore, the child driver
>can obtain resources and information from the parent device, such as
>the MMIO base address and IRQ number.
>

Hi Zong,

I tested this series on a riscv64 QEMU with a QEMU NVMe device.
The NVMe device was enumerated correctly, and the RISC-V IOMMU PMU
events could be counted successfully while running I/O to the NVMe disk.

The following command completed successfully:

  perf stat -a \
    -e riscv_iommu_pmu_3010000.iommu/tlb_miss/ \
    -e riscv_iommu_pmu_3010000.iommu/cycle/ \
    -e riscv_iommu_pmu_3010000.iommu/untranslated_req/ \
    -e riscv_iommu_pmu_3010000.iommu/s_vs_pt_walks/ \
    dd if=/dev/nvme0n1 of=/dev/null bs=1M count=100

100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 1.43612 s, 73.0 MB/s

 Performance counter stats for 'system wide':

             26449      riscv_iommu_pmu_3010000.iommu/tlb_miss/                                      
            256659      riscv_iommu_pmu_3010000.iommu/cycle/                                      
             32063      riscv_iommu_pmu_3010000.iommu/untranslated_req/                                      
            132245      riscv_iommu_pmu_3010000.iommu/s_vs_pt_walks/                                      

       1.464510700 seconds time elapsed

Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

