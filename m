Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FFC43DA44;
	Sat, 28 Feb 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290072; cv=none; b=H1eyjmaiOk3b9KPnvuaRiWCSYleXLViBPxnThx1IL70FGV9NEsOJozU65L4V5SPhiCVfwtT7bjYxYe3UNYCZ0E3CxNpz29lrG/rPUYyIwV3YXFZbQFXhdY2Zpkg4INLu2EapyHcuwemc6SM5sMKdU7Hsc2F7tfCszJ7/++eAqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290072; c=relaxed/simple;
	bh=0nr0pHQWMbIuE2BiXQR/hsB13X+fh7xvfQdqBI9nXiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyYu9VqYxN/81aVdb2IfFp5yL9CAQbhx5rDQb1f2JD3uuJTyInWsZbhAqazrE5evhXP/WKDPjCtQrHRW1HQpHNnOA540jFvM6AwYU+WA3w5nuPmf6W2wlT/CkkQT06sOcjkBxAXMuPxzS4+fybTd7fgU9vCC43O3c/gEzKLQGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=IC39vTs9; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="IC39vTs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289853;
	bh=aWVIrsuLvk2GkMfu5I78c9249QHltnZ4xIbTjZja464=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IC39vTs9N14pC3ITptAfkqCVSXInWHHGkz5TZ/tG9dxCQcoDt7EmhbhXy7MVlbM6I
	 xvQHCsKI3SulKzLq/D3lN6RYpkGl+k1D8kP7FvxhrWgFCyIW+qMAvKxWW5Yb6ruYBw
	 WjHHpHcl64ubOPvhe96q1b/lB/05m+TTdV7WHuko=
X-QQ-mid: esmtpgz15t1772289852t755e0db7
X-QQ-Originating-IP: mtwxv59GTJhoJTNZyvzkPGG2xK0JwZNNXJ/hqEKVw8s=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:44:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18186805224987557749
EX-QQ-RecipientCnt: 33
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] iommu/riscv: Enable IOMMU DMA mapping support
Date: Sat, 28 Feb 2026 22:44:04 +0800
Message-ID: <52E07C3A9B398459+126b1f464ae2a8bfcca6f504c64346541ae4db6f.1772289741.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N+/GyfuFbcLi40FxMycKg5IWcjO/haExdwvTm/QTgrx7vqzp/PCccLdb
	n2piAStxnixZPAcp2AlSHc0XMXhbTZmBCVDlOY8KaSQB+h5qrZQwgCB7JUqpRUGnrmQ6Za7
	0S/ysWjEg+i5JYSuo8ZCBn7LjRNozQkFt2SYcWgym07JnMQcH9j4zThD4ESdSNvm1B7khLk
	CLDGosmz8JJpg8uDoBXksFb6J9I+5AC19G63WSqjDRjDgwla30m4yX+5DLoBe4x/ihaLSll
	n74+MHlO5/pPKeNcjoXsu9ky9NZepCU3bQGSJQiCJtbcqtzBzOi/+Q5LB3PFKF+hncmFLmd
	p+wcoWYURO8oJ4RYsl4k7RdHO3qlfXPH8+aD3iBiOvBUtOIlIyLfjcLvpYTXs1TzwlnNBr+
	acu42tl6vTeEhIPWc5I2WUXmICzxcQrtJo0iFHI0eVfRYHpejf5p9CndXppLlaaZ1cwad7m
	5wTwIhGb8FCtciWxoae1poRMJBXM5LKcZuqQyJnE+dmydHV+kG1ZI5cze+vNpq1Dfh7QMfp
	2mM8669MnvWeRE3zUNsyRDQayKiYkTHeBBov7seP2EMYFB2YKBZtoPx5MCcttdA4HDQUO7w
	iMg/7PkvcPkITQuP94kV0UUbhEKtJ6NCSDs54TGQZbGV1cpSwGMEDrOu6B6c7X6z1pd2gI4
	QRK4jRsbeq8HHQwniIGOuXGB/oDiCV4r8qK9X/MrPjRZqXUEewzmRtFaPDzB40m3FT/GB7p
	MTqhJ3nEhsCRYZ6S2TTWTg2pFi3Wkz1jLZ/HUpz8LWLoi4Z0cPKK+PHx42aoitx/9Rum1zy
	3XJXCVEmu0skzf9WH5Cdn5QZmusDtR2aTMOjrBlzUpqNsLxRgCO+0ENJEu95hTyl2cPvlkL
	PEa9Kih4MXOcQh3kXarWOOajHJRFVEvu6gUeMQ5Ff+pCCpppHY9pDVtw/LhZjKL7HVZLGyL
	vV8+mgnWhxxalZVs7Mq+oYEGAWjWCoIGE2d614AMipIOaUkD38E80Bww6r+jDmRs4XCDwYz
	i+Ha41iDMwzvkIJ/LhQJMyDKzvbfw+1S2pC3Yckw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Jingyu Li <joey.li@spacemit.com>

Enable IOMMU DMA mapping support for RISC-V, so that DMACs can be tested
with translation enabled.

Known Possible Issue:
1. When CONFIG_IOMMU_DMA is enabled, on the tested Linux, RISC-V IOMMU is
   lack of PCIe support, causing riscv_iommu_fault:522 in dealing with
   NVMe PCIe devices.

Signed-off-by: Jingyu Li <joey.li@spacemit.com>
Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11416..34d8a792339f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -151,7 +151,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || RISCV
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.43.0

