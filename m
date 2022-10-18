Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD313C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Oct 2022 12:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJRMOS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJRMOR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2022 08:14:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4717E02F;
        Tue, 18 Oct 2022 05:14:16 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsCPj178cz67Y4H;
        Tue, 18 Oct 2022 20:11:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:14:13 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:14:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-perf-users@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH v3 2/5] cxl: Add function to count regblocks of a given type
Date:   Tue, 18 Oct 2022 13:13:15 +0100
Message-ID: <20221018121318.22385-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221018121318.22385-1-Jonathan.Cameron@huawei.com>
References: <20221018121318.22385-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Until the recently release CXL 3.0 specification, there
was only ever one instance of any given register block pointed
to by the Register Block Locator DVSEC. Now, the specification allows
for multiple CXL PMU instances, each with their own register block.

To enable this add an index parameter to cxl_find_regblock()
and use that to implement cxl_count_regblock().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c  |  2 +-
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/core/regs.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h       |  3 ++-
 drivers/cxl/pci.c       |  2 +-
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..f29cdc9df330 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -49,7 +49,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 				  &lnkcap))
 		return 0;
 
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
 	if (rc)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bffde862de0b..1629c7a4033f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1235,7 +1235,7 @@ static resource_size_t find_component_registers(struct device *dev)
 
 	pdev = to_pci_dev(dev);
 
-	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
 	return cxl_regmap_to_base(pdev, &map);
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 39a129c57d40..2f651211d120 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -262,6 +262,7 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
  * @pdev: The CXL PCI device to enumerate.
  * @type: Register Block Indicator id
  * @map: Enumeration output, clobbered on error
+ * @index: Index into which particular instance of a regblock we want.
  *
  * Return: 0 if register block enumerated, negative error code otherwise
  *
@@ -269,9 +270,10 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
  * by @type.
  */
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map)
+		      struct cxl_register_map *map, int index)
 {
 	u32 regloc_size, regblocks;
+	int instance = 0;
 	int regloc, i;
 
 	map->block_offset = U64_MAX;
@@ -294,11 +296,38 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 
 		cxl_decode_regblock(reg_lo, reg_hi, map);
 
-		if (map->reg_type == type)
-			return 0;
+		if (map->reg_type == type) {
+			if (index == instance)
+				return 0;
+			instance++;
+		}
 	}
 
 	map->block_offset = U64_MAX;
 	return -ENODEV;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
+
+/**
+ * cxl_count_regblock() - Count instances of a given regblock type.
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ *
+ * Some regblocks may be repeated. Count how many instances.
+ *
+ * Return: count of matching regblocks.
+ */
+int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
+{
+	struct cxl_register_map map;
+	int rc, count = 0;
+
+	while (1) {
+		rc = cxl_find_regblock(pdev, type, &map, count);
+		if (rc)
+			return count;
+		count++;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
+
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..5a1bcdbda654 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -216,8 +216,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_register_map *map);
 
 enum cxl_regloc_type;
+int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
+		      struct cxl_register_map *map, int index);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9c3e95ebaa26..ef066e24d3a3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -373,7 +373,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 {
 	int rc;
 
-	rc = cxl_find_regblock(pdev, type, map);
+	rc = cxl_find_regblock(pdev, type, map, 0);
 	if (rc)
 		return rc;
 
-- 
2.37.2

