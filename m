Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829664302F8;
	Thu, 16 Jul 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213815; cv=none; b=cWls0Z9A8rhbjEvCqQBE5+XDzIkEbG+fG4f3fJFO2kCqXKwcwiVUU/OMa9LoIR4IdmwrVVicrY5iNlfj6R+UOBeZdIbp7jJvTiKysm6Wzwd0GufKni9ZXKOLAviVW7OObZRipusXbkcePT8e4E5io2iFFtc4m4CBJDYxf+aG8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213815; c=relaxed/simple;
	bh=Pb+f5I38gSvwwEGMdj5XYd+7gcuHmWuq0P/BWHFGhGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLeeVfIc+5XUass8ic/Ve1gER3e1spLuVxKs1TC0IfdlfNXVreiLGEsInX2PJ10S1TZ6dWwsQucwUg/y/ezgaQP20Vc7iYNrAnVNPkp2J/2ELrQekCoVx05lUFhW8xeJyraHt/6gmU6i1ji/uZQhsBZpDsC0GIaUHUmNpYnHbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AdmolQK6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AdmolQK6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BACB1477;
	Thu, 16 Jul 2026 07:56:49 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3234A3F7B4;
	Thu, 16 Jul 2026 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784213813; bh=Pb+f5I38gSvwwEGMdj5XYd+7gcuHmWuq0P/BWHFGhGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdmolQK6QIRNo6fNFz8nMa5Jv2S3JcWc+yfp3PwlFnWwcMmg37AE/S6ttE0YLTWGm
	 45e2YRimiRj3T51D+HVX3wzAwh3Q1SJQvauOfk5qSrltjOLO5OGYQ/OrxayCIRqk8U
	 EfS0HW3nHdVN30xO6X8s3Bb4gDpr9bO++ZenAook=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 4/4] perf/arm_cspmu: Make IRQ more optional
Date: Thu, 16 Jul 2026 15:56:37 +0100
Message-ID: <a6bb2c54e91712e91f95d21051d2b4b173cebc93.1784213435.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1784213435.git.robin.murphy@arm.com>
References: <cover.1784213435.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we have 64-bit counters, we can reasonably assume we'll never have to
handle an overflow before the end of the universe (since we're a system
PMU with no sampling). Thus even if firmware does specify an IRQ, we can
still continue in the event of being unable to request it. This can help
systems where IRQs cannot be claimed exclusively, or are broken in other
ways.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: No change
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index caad9a36651d..ad82de166dd1 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1256,8 +1256,11 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = arm_cspmu_request_irq(cspmu);
-	if (ret)
-		return ret;
+	if (ret) {
+		if (counter_size(cspmu) < 64)
+			return ret;
+		dev_info(cspmu->dev, "Continuing without IRQ\n");
+	}
 
 	ret = arm_cspmu_get_cpus(cspmu);
 	if (ret)
-- 
2.54.0.dirty

