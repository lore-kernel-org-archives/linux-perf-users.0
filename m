Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83936CE03;
	Thu,  9 Jul 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608015; cv=none; b=pr3Q5vwhzv3zaAltS+Q86eciiTVY+B6eFtq7DC7PO960oq0Gy5rwDcWfSYrit3ruwse5e7Sl29a30PKgE928uQfcf7Q2KP+EOOPIIdSr/TWLc04qzw0PbY/K45WX+WZ8TpKZl5B2a9DZCbseQ5eLY1xuXAMW6GS2IFRBrX4Xn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608015; c=relaxed/simple;
	bh=2mFo3OE2eaYUGoIdVv0wuVIiddazCtiGJ1VldpM6fWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRgODnjpuesvMfdsTE0LS29HqWH057DAUjxjs8wNsgqKXLuukKQvYRmhPmRTzS3md2mJyTIUj0LCeDKvLww8MsRGynMFVtdXdzYZCjn+KlFGCWr7HniEM4okojItAfOhpkAnCYQEBzaze5iWc11UWhdof6oiLUg7Bf+VyKshq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VnBr708x; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VnBr708x"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A0DC3594;
	Thu,  9 Jul 2026 07:40:09 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 60CBA3F66F;
	Thu,  9 Jul 2026 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783608013; bh=2mFo3OE2eaYUGoIdVv0wuVIiddazCtiGJ1VldpM6fWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnBr708xZMN2uPoV5cQtPu5NX3MIy7JgCBJGeQvfz57Nmf+Zy1bD9k5OXOH5GCQDY
	 F1QkI4RK3OMz5IX4MVI0lEkqcZv95NKi2z0i4RCQA+uA/RJ71DC9fNqBHa+dJj1thW
	 DVQ9lDXNOqm3gcJwi7zq1Jv20DPLsC2XPF9dKJpw=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf/arm_cspmu: Make IRQ more optional
Date: Thu,  9 Jul 2026 15:39:56 +0100
Message-ID: <fb2cab05c714f24f703b242c8f8b8e9e4df938f8.1783605641.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1783605641.git.robin.murphy@arm.com>
References: <cover.1783605641.git.robin.murphy@arm.com>
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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 0b26a1588eba..4ba47bccc99c 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1257,8 +1257,11 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
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

