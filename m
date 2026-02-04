Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2F263F34;
	Wed,  4 Feb 2026 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196190; cv=none; b=bGXXoo5YsLj7IRVhBV5oblEpfsNy86FMtdLJdQLgdP32+P5XZnlNiCnHZ2pyVAkle0EplgmRfA+UBkWJv6nlNy/eMrnR3pajbHFQvc54XOy9EFEoKTw4X5QwJKCiGFso6o+KQYVfXgz7cJ4jy7niAFgOG0nC6zAG7r8tohw8BU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196190; c=relaxed/simple;
	bh=pIk2X89F4crzsJrXqP6CAX+UtHyMm0jFHdU40TXN5/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql+kpVkQ9Qg4/bfgui8hvmglvpnInj9CVA/3Z7eQliBsOGuH0pkG2UZQnAZifTG7EypZhgA9CyOOtm0wpKFerW9gPYSdXtUNb3uCUwemqtEv+jcL1WMZci2lf6xlEGssjLdVw9F4cDZTZyGF4M8strBUnLGXBQUMjQl5ImxJrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vgn8Mq0S; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vgn8Mq0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770196131;
	bh=vniV4R9laYPbty6apvE3yD0+y8jeoSXd7UsyQ/isW1s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=vgn8Mq0S/+43I/DeQkKG5jBED3gHMrthiqqHB4s5mBKNZdAK+FylLhBc9A2Gba7gP
	 o1LCWC4ZX/yQCJIaJpQ9J/TpYk8rfBT0QL29BMT7+oYbY2vboQqZdvpfnOd7zxqDvh
	 OJc1QkeJZGX2BraLeSv75mmj3fqMD2ZRgn8McXDQ=
X-QQ-mid: esmtpsz20t1770196129tdadbc722
X-QQ-Originating-IP: cyLLraxODx+BbmUBgtRGsM+KjpbyMTBBc9WyBjGdDL0=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 17:08:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2120045114708979725
EX-QQ-RecipientCnt: 19
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/8] iommu/riscv: Enable IOMMU DMA mapping support
Date: Wed,  4 Feb 2026 17:08:39 +0800
Message-ID: <4AA614655D11897F+a7061670f43ddedffb83b88fab0dbeb9123f2940.1770195980.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770195980.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Np0qb5kW85KCr42LSI0RAZZl4p1jeyLFinSdkUjfQ+fqz2h1oEj6u5JU
	8bXGoM0wjkt89uxvM6JKPWRRRHNv2QFSj9Iy656DfQgyVfPRyZ400oHYGHBqViX7JXkirJg
	HLF9b87m1cZnWwXPSPiOczDIkP7mzZ86VYBoO2Uo0nTv6H/4MAsgclccLAorl619WAGq1vd
	0BtPOwnT52MvTGpxa5PnzW+fCnYYulKY/Dchoc9lwwZobZAkBKNJqcSM4l9cqsU5G4PZFYy
	BdljN4TAOnaTgzKdpytRi2ZG0q62WqAyZKpeVxqVahWyPOwLnkrpDn843FO2xjwAZQ1sOvg
	NRo5ZQP5qZrANYBXn/c3bm47tmy82hHzlRy2a5DroFPSJ4ZGXabPNiFzOKMrzZ/RrUCKuzf
	drBE61bDZGQ6qKfoJ5Q/T1chR4tVcAMWVz3zvU5jOFDXELW3JvcwatIm/prbWsTy3Av7Fmc
	8nxTbktvsp66BGgpqq+8Ua8sG/oZT7bjOg+IsuhekMEcCZHf1kVIr6gkrGBOe80kSbvWfjI
	dtv9f/19Ysxsj2K/VMv1L4RRV3gWaruYYJu3zbIzCSipG3UVGFpwXLnZrsInGpW8dli0vX6
	83JaTCyxgs56NLfwYjx0IeEh5tU8VCgecsiFSIZpwfFmO1RVf8Xr++4aB5+eSGu82A4L385
	wEKug80AZKQ+XBvY7cbNU5m1jQ4xEuBlhcvhgWFwfdptJTpqVq4ZjUoof3PpRcWJrpRgV9L
	NXrRuilN5N9QPTAs0u33oM/aa9D96V3j1ZfvHZHEit7yXOTOm2EZL2ojJAVTIiKZ8MeVEtI
	BaP5nRbBpxLb7ifyNIZb89VTsH88RT60foEzp7wEF65JpvnTkOv+YWM40Blj0o3UF/ccMx6
	s2vU8PaA90NWMDoAdAlDOBa3PJ4PNnMMGMENe99xludGqRp9DSsIESeL8fkPkTbAiG1ziJu
	bP4OHS9Eg8EsAocnR0TVo/eoZ9QtdCyySoIz93OG5r2OuuYyIQR/zKAlw/M8SNl0qmZIerm
	ujFqS2Syaef6Go6Ufi
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Jingyu Li <joey.li@spacemit.com>

Enables IOMMU DMA mapping support for RISC-V, so that DMACs can be tested
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

