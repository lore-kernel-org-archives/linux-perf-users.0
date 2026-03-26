Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4A22FE11;
	Thu, 26 Mar 2026 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491575; cv=none; b=PVTEOENFE5EM5MzERmdolPK4ZaPlmUygkm/YLEPr2dKNGlJfefVd19SzZiwh2lTw5s25FItyWNtJfrUIZ/ZEMewiO+cKqAAeuP+wW7oBo6hmzT8wYsTmUZcbJdpmbTXygQ3zIYYUBTRo26a5wPdThIN4sLSQewLl+BynTT95aAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491575; c=relaxed/simple;
	bh=wdQ5OAKNDtYk+nI8mmrz94DUBWcTxmQRzCeugry/HTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qYBttsHj8o/kxJmMKCkrw0bhfXyYoF4XPQRGd1+3n9+o8w/qO4knbNUsYK4yL3XeU4FR8u+X/sslWg9E9vo+AdXuFMT8ap1nUkkFZX9/9UaAfF/Rhobo5tKn25BOxPVW0SxEUen9AAHXTb1x0kqJowxbo7p9dhDnBtlaKuurxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trNh3E+M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trNh3E+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63037C4CEF7;
	Thu, 26 Mar 2026 02:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774491575;
	bh=wdQ5OAKNDtYk+nI8mmrz94DUBWcTxmQRzCeugry/HTw=;
	h=From:Date:Subject:To:Cc:From;
	b=trNh3E+M3EZEDmKFspTPGDVZOD5GffWvEVPc0yZwY+cwzWBDy1jNxDZNrVZVHSqXX
	 G8ddTG57cPANTd6PoBfR5iW4r4rpHChT8hy9DEwFzIKMmkAe4Kwqwd/KFkDJoQb1d7
	 JKuT+hoScC11I58vVIEEZpWBpv/oNiG3GS+ahkMksN054zYHSC2DXSgzDxNj6knniG
	 UONkU5Ya2865vpNVFEh8+S1KRTjIHhm4UKwqqr3A+FOmtlr+vzKqpb2SIyFAjrFqyI
	 q7zFYI9rUBaMqgDjAF7D+7bzquetqMA1ERAfuzHC+jqQMYBrzf/XTr6AHOSVuATj6e
	 WNqR16vd/HsmQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 25 Mar 2026 19:19:26 -0700
Subject: [PATCH] perf/arm-cmn: Fix resource_size_t printk specifier in
 arm_cmn_init_dtc()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-perf-arm-cmn-fix-resource_size_t-format-v1-1-e84d52ee3e81@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN0QrCMAyF4VcZuTbQbayiryIyuppqhLYj6YY49
 u5Wvfzg8J8NlIRJ4dxsILSyck4V7aEB/3DpTsi3auhMZ03fDTiTBHQS0ceEgV8opHkRT6Pym8a
 CIUt0BSfTHk8D9ZasgVqbher693S5/q3L9CRfvnnY9w/Y7uijiwAAAA==
X-Change-ID: 20260325-perf-arm-cmn-fix-resource_size_t-format-b01795e36e60
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=nathan@kernel.org;
 h=from:subject:message-id; bh=wdQ5OAKNDtYk+nI8mmrz94DUBWcTxmQRzCeugry/HTw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlHpm+dYHRTaMfKAys51LrvbbF/u8Xw2cVD1u1ywfvrd
 v7Xv/jpb0cpC4MYF4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYyOv7DP/D9udPLzm89XL6
 w+frswLD1rPHGd3f/j838pKL/YdugYePGf6KPkhVuz9p6orPvds8ep6INLIoyp9iPqe9ry1//sE
 JXSGsAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building for 32-bit ARM, there is a warning when using the %llx
specifier to print a resource_size_t variable:

  drivers/perf/arm-cmn.c: In function 'arm_cmn_init_dtc':
  drivers/perf/arm-cmn.c:2149:73: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Werror=format=]
   2149 |                                      "Failed to request DTC region 0x%llx\n", base);
        |                                                                      ~~~^     ~~~~
        |                                                                         |     |
        |                                                                         |     resource_size_t {aka unsigned int}
        |                                                                         long long unsigned int
        |                                                                      %x

Use the %pa specifier to handle the possible sizes of phys_addr_t
properly. This requires passing the variable by reference.

Fixes: 5394396ff548 ("perf/arm-cmn: Stop claiming entire iomem region")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 1ac91cda6780..5c727c2abaf0 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2146,7 +2146,7 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
 	size = cmn->part == PART_CMN600 ? SZ_16K : SZ_64K;
 	if (!devm_request_mem_region(cmn->dev, base, size, dev_name(cmn->dev)))
 		return dev_err_probe(cmn->dev, -EBUSY,
-				     "Failed to request DTC region 0x%llx\n", base);
+				     "Failed to request DTC region 0x%pa\n", &base);
 
 	writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
 	writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN, CMN_DT_PMCR(dtc));

---
base-commit: 2f89b7f78c50ca973ca035ceb30426f78d9e0996
change-id: 20260325-perf-arm-cmn-fix-resource_size_t-format-b01795e36e60

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>

