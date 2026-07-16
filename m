Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEEC3D9542;
	Thu, 16 Jul 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213809; cv=none; b=KVD5vWlDnxgxgUdrTn7sLMkjdL3El/RuH+8nJnIeFrdHX1+eT8QmS2eOwgZ5YSa6cKDmGye/2loqnaj82h2Hov07ppi0uGc2RuMuNBdCzbDk3XyZRayB8TYhSwUkotNQnaNjSjCf4f+vkM7Vhv/jBhjVZcFdk+aCWf9yxneRZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213809; c=relaxed/simple;
	bh=C2NrelLAf7T0hDmpoK1ldrpKNiVV7avpeh8FEhGRPdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqbd3keB2AutD9+yU6AJmaq+Q7lWHogB8m08k30oXp9+WIowFzOpeepS02d2LBF1bjlBpRqIqdPe2jnxERSKgBsrPkdjmi8tqVQlPZIPjKw57sYy/wypd7V1WoKN23qzs9D+7vwrQ1U0q7Is+zVlqdLO8Kbk0nF3LLeg8g3ZREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MEvstiCp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MEvstiCp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4215C1476;
	Thu, 16 Jul 2026 07:56:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2493D3F7B4;
	Thu, 16 Jul 2026 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784213807; bh=C2NrelLAf7T0hDmpoK1ldrpKNiVV7avpeh8FEhGRPdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEvstiCppWCM1GVxxnI8f1FPJa0cfbbVzjTbX7AS+vnAat4BLCnsog6st1/6QQNkI
	 y+Om5xhnkD9A/d0/MsEWJcRckV0KLm/5Q5f2i7f18plOiwUW3SPf6XwKMGVc+MXmT0
	 +XE6enJ0QxsmoucAm6M3mgttxCx+rei7nVBQ1+gA=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: [PATCH v2 1/4] ACPI/APMT: Use stable device ID
Date: Thu, 16 Jul 2026 15:56:34 +0100
Message-ID: <f7eb9a4cfea4cd6f8d87f3c2501438d484807d27.1784213435.git.robin.murphy@arm.com>
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

The APMT node format includes a unique identifier, so we can use this as
the platform device ID to give userspace stable and identifiable device
names, rather than auto numbering dependent on how the table is parsed.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: Handle and warn about unexpected signed overflow
---
 drivers/acpi/arm64/apmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
index bb010f6164e5..91fcdd289e63 100644
--- a/drivers/acpi/arm64/apmt.c
+++ b/drivers/acpi/arm64/apmt.c
@@ -76,10 +76,12 @@ static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
 					   struct fwnode_handle *fwnode)
 {
 	struct platform_device *pdev;
-	int ret, count;
+	int ret, count, uid = node->id & INT_MAX;
 	struct resource res[DEV_MAX_RESOURCE_COUNT];
 
-	pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
+	if (uid != node->id)
+		pr_warn("Unexpectedly large UID 0x%x, truncated to 0x%x\n", node->id, uid);
+	pdev = platform_device_alloc(DEV_NAME, uid);
 	if (!pdev)
 		return -ENOMEM;
 
-- 
2.54.0.dirty

