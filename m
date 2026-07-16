Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65687429017;
	Thu, 16 Jul 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213811; cv=none; b=Q/bJ9im+LsqGUeEHnqysZpN57k4AstqJNmu6kpDAloR6kEl/4drcL5CHnw3c+ZU85vq61wsW0fVBY0g5ruuZJv8j2ivr7TmW+tCxW1L2lrPM05I0xwtCnHUes0vsHEn+c1ps95+Lp+vYB+vuD1hD6NyBTz08z7gYX2ntVfWzsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213811; c=relaxed/simple;
	bh=+tWSPMNl++zmEGYUXZGGH56Zm7suUculQiOYKCm7jOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3n4nNBTvTF0SfzsYceA7mzHJFSumZzbsJ+CTkGDu81QJ359B0wwKZSzrdv42F6utlcpDOx3KTaZR6MkwExHGz82065cNruLfuhIV41PSUdsZoS3hOqv6HThPl7rIpK4sUcYLWZ9OmSylrRrRATLloJn5p8P81H7SEzxeiIOe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KPbYxsUV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KPbYxsUV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB591477;
	Thu, 16 Jul 2026 07:56:44 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD62F3F7B4;
	Thu, 16 Jul 2026 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784213808; bh=+tWSPMNl++zmEGYUXZGGH56Zm7suUculQiOYKCm7jOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPbYxsUV+ED5imRMD3J7hhcXdyfSb/P1NnGY1JqS5gQsm3ANpWUyaM3LpIbA38sVB
	 FGk4uP9QXRNcvm3ealVMuhiI8wayx3kGiCve4+xgQmhz6+xwCCO7FOEoxxNm4uTj7Y
	 dgj+GRItxYNR1IZY0r6qnfhDNrEvpU2HE9+2t5XM=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com,
	bwicaksono@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/4] perf/arm_cspmu: Improve APMT-based PMU naming
Date: Thu, 16 Jul 2026 15:56:35 +0100
Message-ID: <8f260d150da4fd8acbe0a070033c9b9e045fced2.1784213435.git.robin.murphy@arm.com>
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

On ACPI systems, it has not actually been possible for userspace to
reliably tell which PMU corresponds to which APMT entry for types
other than "ACPI device" - the evidence trail only leads from the
arbitrarily-numbered PMU device to its arbitrarily-numbered parent
platform device that has no distinguishing features either.

While we've now improved the platform device creation to associate the
actual APMT unique ID, we may as well also tweak the PMU devices to
substitute the arbitrary number with a different arbitrary number that
might be more directly meaningful based on the APMT definitions.

We don't have an equivalent for Devicetree, but in that case the
platform devices are at least identifiable via their sysfs-visible
of_node.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: Actually use the instance-based ID where different from node->id
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 80fb314d5135..8c2dda17d73e 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -250,38 +250,43 @@ static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu)
 	struct device *dev;
 	struct acpi_apmt_node *apmt_node;
 	u8 pmu_type;
-	char *name;
 	char acpi_hid_string[ACPI_ID_LEN] = { 0 };
-	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
+	static atomic_t pmu_idx;
+	u32 id;
 
 	dev = cspmu->dev;
 	apmt_node = arm_cspmu_apmt_node(dev);
 	if (!apmt_node)
 		return devm_kasprintf(dev, GFP_KERNEL, PMUNAME "_%u",
-				      atomic_fetch_inc(&pmu_idx[0]));
+				      atomic_fetch_inc(&pmu_idx));
 
 	pmu_type = apmt_node->type;
-
-	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
+	switch (pmu_type) {
+	default:
 		dev_err(dev, "unsupported PMU type-%u\n", pmu_type);
 		return NULL;
-	}
-
-	if (pmu_type == ACPI_APMT_NODE_TYPE_ACPI) {
+	case ACPI_APMT_NODE_TYPE_ACPI:
 		memcpy(acpi_hid_string,
 			&apmt_node->inst_primary,
 			sizeof(apmt_node->inst_primary));
-		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
+		return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
 				      arm_cspmu_type_str[pmu_type],
 				      acpi_hid_string,
 				      apmt_node->inst_secondary);
-	} else {
-		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%d", PMUNAME,
-				      arm_cspmu_type_str[pmu_type],
-				      atomic_fetch_inc(&pmu_idx[pmu_type]));
-	}
+	case ACPI_APMT_NODE_TYPE_MC:
+		id = apmt_node->id;
+		break;
+	case ACPI_APMT_NODE_TYPE_SMMU:
+	case ACPI_APMT_NODE_TYPE_PCIE_ROOT:
+		id = apmt_node->inst_primary;
+		break;
+	case ACPI_APMT_NODE_TYPE_CACHE:
+		id = apmt_node->inst_secondary;
+		break;
+	};
 
-	return name;
+	return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%u", PMUNAME,
+			      arm_cspmu_type_str[pmu_type], id);
 }
 
 static ssize_t arm_cspmu_cpumask_show(struct device *dev,
-- 
2.54.0.dirty

