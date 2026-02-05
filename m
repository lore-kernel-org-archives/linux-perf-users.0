Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F032BF5D;
	Thu,  5 Feb 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282686; cv=none; b=nGndrS5R2C3ARrxSgT1ikILMzdR43xE4Xty8r21uuQnhapBgfgQsegoxqf8XmbWA8B/qVv8rOaKuif+JibCujMrJrwbsykeEhfs8EM9AOrwkO4tytGy1/rYAZEIsEBjnfn2TGIR5pB5sb6vr/9fdsikxvon7phlbbvVMLMOG3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282686; c=relaxed/simple;
	bh=pIk2X89F4crzsJrXqP6CAX+UtHyMm0jFHdU40TXN5/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQUDFqCmQAyzkLs0lOYMNvupcy4R+EW6PVMdm/e42MkBbNxoUXifXl2qNc48nKV5dr2teV9M7+8ZYbP5neOOzzi0c2c9UAX2TYK7Sb9qroxBNXEj99PDy4O0Yh2ap/jxC28ZrY/9ra0tnLeCwsLwZqPSW4JguoEWDO79AHkkIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=qB4iHXAc; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="qB4iHXAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770282630;
	bh=vniV4R9laYPbty6apvE3yD0+y8jeoSXd7UsyQ/isW1s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qB4iHXAcLRHqGpSVy2pcnkNcTZ7l4vat0LrgwOXOh+TvOH2BonDsQP8+ifMtnOmxe
	 Wrt3kGk5xGiLV7BeXL8N6W1PC3l8iIWw2duqFUrWXRpOUZiB3YY8WPngNUb8Kpp+5s
	 QrAxD3jidtXAtCm8vMbqLYa9l9ImYzxCrCheQ3pg=
X-QQ-mid: zesmtpgz1t1770282629t83d3aca8
X-QQ-Originating-IP: 7TYxyNEsAJsJ+hmTN8eItU64xdUiHKZ8ogiEM2n3g4Y=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 17:10:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16664678030210134894
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
Subject: [PATCH v4 1/7] iommu/riscv: Enable IOMMU DMA mapping support
Date: Thu,  5 Feb 2026 17:10:24 +0800
Message-ID: <F59F70CFAEDA41DE+ae78dbc5590f872a36eb4359bd451b99fc8553ff.1770281596.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770281596.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770281596.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Mko2o32K24t8CiIMJ7u8eHzxs3hYHuHzb+tBM7zd/NHCFylz5qMvvRIL
	bMHRhO9qIf8CIfOq8/xzmslogvRrvFTjST8L/i7pc2Isxiq2CvY2bciSj2sIRWYIbhpTmQs
	pJTd8rbrlMFCwC+zwAYC0n2P+KqN8C2w3VH9rQU2yPNjgO8nybUyNzDbZDI3SPQCC8qYklX
	IjWHnHdsDiuvFa4Qk2eBJknNaIg3G4Q9PdOnZy52zrIJAPXpkmiyGcWcUYGSSMQCbJ3t8/U
	ICC5NjJbIhqAniajExB5y5usHFuSCQvMS+JKCX9lTXMx+ASxdVNcAqp5OKGEPo2Z8e2kUT5
	zL863MOYmjvK20m62V8Jul6n+Z3FuxSrtzw61lMdbG4ke9WwoU7fPmTgozpRiS275wgK6P0
	pRo4n579Bz52dMP3TKXf/EMDAaN3Dg6TVxuP+H0uHKGLvd7BSRt0bsM9l423OMiP6mBAjEH
	UkbsaECBKCDidkRIalxj3pL5CTHUfq2v6i/fRtbwOI1ZdpL9Jhfi9sdeVNqAiPHGQti0Ntg
	tl5TvaoIDBAG9YtHkkADbfwhmuIRgCrqddj25E5qgEP4Mq7aovYEjS7n5xL/VM2PpMJaxKo
	NYsdNFyhT/XY+OSOCHjssRIgm8ke1g7hAn5XOoBS0yDheVZ6klo8UkgSVY2Gsi8KP0fOD6L
	6JPY7ZMQPitzsFNqrVQocvKEMrj97yPTSGb7ZKyb4QedCb6hD+9zb5w4vvjlr5NZTMQUik7
	Ujh3WjXf7cjLCgH15kULM+zwml1MzBuRNF87ioAEak/TeU+KIZc1qUn1NKdqJQuwJIC4rtD
	8M3f9bopFJrtLw+MQjTN5m6lQYeA+QnXTEinaK1J8XEI4DQj5nLgWsXOgl1YPcldVSSyu6A
	Z92przYSpk7ZS2KAG8/kF59PzBj1JhDMSUJFSOt0WOebzgiPBatwFHZFwux4TiF5hSVp7rW
	sICo5lDxrDreR0DsKSTHu+MKU+K+ht2xaZ7+lNoGmrlB5RhsVN6Sy5oGukMZR3gMwirQnRW
	3/0X11YRfat6L7vvvFHma6OT4OCHf+Q7/9aczBmw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

