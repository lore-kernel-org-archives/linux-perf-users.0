Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650843A1A4D;
	Wed,  4 Feb 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196182; cv=none; b=mVqF+i/+yEwsZ+lpo4t7LHMtXSpsgBir0iNZjsnNh7YSVnkK3R/Qg8vn7J+V1n09Tbwkr/9EarR67FTMKDbklxJJBRdpHN7rm/Lqy60Cw/96bZ7ZlbCd+3ImqMCCfNtF5rJ8EcU4DWAlzfAVzt0+goaqGgRjiyFO8RHeC1qeHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196182; c=relaxed/simple;
	bh=dg3qRyrwSI/dA02M74Z+js04cmsveNId12M70qwtCks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G05UBU15MoqxRZAMgzxPzmX5UJs41nk9HOCwGbp0ZPuP+3yER5EG/PZtDteDYpZAdvrpU3wLMfDrUdwUjUBQy/fZ0HYa5JK7RwgIOgjXLngdljCOOfD0j99CUJpIfMmP8Y9qS3USNU2g2v0z9oBJdcRLAUTqejWsWoLh2eGwxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SFgSWVaG; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SFgSWVaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770196139;
	bh=FnxspfB6IoUfKXakCwL/8H5wQ8u2PrShJd6O1e3tAhA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SFgSWVaGc4keGOeP0F14rH7eOm2bDWRwrXbg87QoYCe9VoFoexdxbRdSqELz8ljUp
	 07qyN+wOjbHN+OiJYA0CIZ/nfZhdW8CZB1G0Z7dH7VCVTIVXW/w/rwIXfdvvWEzynb
	 AOb9uVPe6Pn/7X//nYch1YPQ8ACuYK1JpKf5OwuI=
X-QQ-mid: esmtpsz16t1770196138t11af2221
X-QQ-Originating-IP: cIZbjwSz2bt1AZxsF9Fs7umXGHhXAU+RtBpA8bh4RmI=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 17:08:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4010158773422615349
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
Subject: [PATCH v3 2/8] iommu/riscv: Fix WSI mode IRQ number handling
Date: Wed,  4 Feb 2026 17:08:52 +0800
Message-ID: <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
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
X-QQ-XMAILINFO: M3uTjkO5QXGxCPOzuCiEUHeAtnKQkdTME4gDy1ksCop1kKsDbdSahqkG
	oZjGqNptruElkOP4O5zxmQ9Okakc6UAUMmB7cfgQcjF0IxNaxeS/9g6TaLF3vd7Y0EsAiE8
	yxyNBjY27wzBeMwXSA3SeEUoAaUzgqYhwYeYsNbqAjcD5UTX8MIdSi/IXZM43pISdANv6fx
	0wkgwEJbyqkwbiqFDa0Wn+ZVVXXEJYWMUotV/hSskqlx9fif6KThFaErhRIhey247y333ad
	WXzXonj5Nfd/SLRU/NC9rLwJ+U86eB/tvElgA+FSAqRvG5CtCB+5TkuceIv2DF6B8E8Ynyz
	skCAMI+Yycoa7Udx5GaPl36Ug/zNw4YETySHxFfoBMCRPrsLWhrfuyl9YQPvil7DRVTR8EP
	I5dLKbxcPGPu442uV3bG1BI6J2TpjYK9rXo5s9Dbvg6z34zn403/Ul78yh/cVK8/KYVPioO
	qKyiqnL1N9PNcYQhHKfVaYj/lB0HmaCQMZp1g1P7S0ci+R6yEzHtRJhIQocNPjum36D6Rhz
	duHd/Pgxb+W05UyBKngrZpvZrXWwJ6MbpkfU8Bo+ufVMuJuQyVRZ9/+Sgaw/LdoKowDJest
	g5SJ8qky25zmp3JR1p7lK+G5H1pJY6WDOlkIXY9ncQq+21XFPSpkMMykAsboRjd3OQ8ecqB
	NEvNuzS9WAB5K+vhEVoqpVg0bRA/8eHYDDc2qfqQp4bCCTphO8mSpcbuUBnnvbWRsPerSIY
	Wx+rYZa/bfwX6GTOCXWPNR+rV+vTKPbt7WGQWm4mZq/ODeovsc9U854757WHIoe9h/QvaWk
	WiAPBdQFFSbKkzvc2Fderd4TLph6LrfTV2VfKKqnV4k/NnAWhgDv8QMAW4T4v3ytsOcGmoy
	PcLmnRZMVRIUnZKzeLiDdx0EewXPRLnBgFC5wpdpJd+bKQLWO87HRv4rNiQcs+wXdyw8QTz
	RA/7KViy8wQdT6EVooLcsihSIKBu7/iXyStYdxbQKvhCmW/Awh+/gX4NYEa/4bgNtB5Pt+K
	ul1ang/82r8SKkVTXtOufDOev5+XfKAnPoN7jE9g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Jingyu Li <joey.li@spacemit.com>

In WSI mode, ICVEC doesn't exist, thus reading it returns 0, which
causes IOMMU driver to fail to find IRQ numbers from device tree
IRQ arrary. The issue is fixed by applying icvec indexes of WSI IRQs.

Signed-off-by: Jingyu Li <joey.li@spacemit.com>
Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
---
 drivers/iommu/riscv/iommu.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..26630979473b 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1593,11 +1593,26 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
 	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
 	iommu->icvec = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
-	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
-		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
-		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
-		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
-		return -EINVAL;
+	/*
+	 * In WSI mode, ICVEC may read as zero. Only validate if using MSI.
+	 * Check if FCTL.WSI is set to determine interrupt mode.
+	 */
+	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
+		if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
+			    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
+			max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
+			    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
+			return -EINVAL;
+	} else {
+		/*
+		 * WSI mode: ICVEC is not used. Set to identity mapping for
+		 * riscv_iommu_queue_vec() to work correctly.
+		 */
+		iommu->icvec = FIELD_PREP(RISCV_IOMMU_ICVEC_CIV, 0) |
+			       FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1) |
+			       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2) |
+			       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3);
+	}
 
 	return 0;
 }
-- 
2.43.0

