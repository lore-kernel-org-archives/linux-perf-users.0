Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81C43E4A7;
	Sat, 28 Feb 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290053; cv=none; b=JaVCN9rA0WMjjvSKcZyGMEnl1cBXAeBLpFofP+8Nhy71N6OLiIxV5jVEqlcL4XHXdA3cahqruFDi8GGZX4IPdbe4YK3yHilu7EG0F59941EtcxcKWZFRuPH5t/+PIU8y1hCMhC56KmDViYOqH7nuxVs15aqtzwhYYdbTuksLv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290053; c=relaxed/simple;
	bh=E8TwrjCSIHHV++I88yp17nnNCbzb2aXg33aD22fPueE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAThFlhFEvlT3DLaAfRHRx28fN+5Z37s9q/CQOMk0Iot7Tgq3ap4A/wI+fLzBO9MuqQTi01ymWOfAi95N6jembQWqMT4RM0G4wXryQ6HAYTarqWIn8TQWBVVkw5+hoozfxSFnP2EfLvJq67QrLHyLGvQyc/LaBTRO5QHB9YG22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=aw9fQC60; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="aw9fQC60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289868;
	bh=ZTc/n5ab9N9UFVgI6hT5/C+s+rP7drTHuNOBqqfhQGM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=aw9fQC60GpN5je38nhl5HmBhaKDqlndi+wsPesNqbh4qDFYeOCii0w2pLDjwv+hkD
	 +CTiONZm7VPiHltv4F6f7JnpEdnQcKW5VHoS9OVF5UjXuPj7z1B0go18WE0f/wTCIw
	 sGz9weuzx6xxa6BCcQP2AL34gLZ/BkYWt2x+yHUc=
X-QQ-mid: zesmtpgz1t1772289863t7d4037ae
X-QQ-Originating-IP: skU+G2wfQkuL5RXnlGkMHnDK79YrWmLshwy4PnZu56k=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:44:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18284969003832345071
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
Subject: [PATCH v5 2/8] iommu/riscv: Add auxiliary bus framework and HPM device support
Date: Sat, 28 Feb 2026 22:44:14 +0800
Message-ID: <BB440D6C2FBCE62A+298a7429e6a3c395d2d2c53449e38a47465e12b0.1772289741.git.lv.zheng@linux.spacemit.com>
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
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OLsBWtCIHsg6VNrwUi8/mc4jmBZisZKwByOferWTD3/GLqwmjD6ZWf2g
	lWkH3WP/Tr6u0g880nUX3nAa2lAZITULXqFbt5oC+z84Dgo1MNvwVZOP7iQCSrDuKf9RReV
	p0MxUbtJ9jhN6GbLx15e0o48CtECxwmqIkcJMeuofP4L/8not03VbpywjAcw1Z7WegO5I5K
	/MDpJgxGhVnc1N3XdX6vJO4yYB+RWgwDYi/0BId8aJMw4vqasVBlC3iBOiXqML8SOhq8jdQ
	TKJ+Ql4sEuGJFMTPGeEyDWAuC3vMiYGNrb0L6OMyb/QuqoFpVLJdvWKVJMASDqaSC/p09Y5
	/X1WQRD3gA85RyFrkSRDQpyuji3D2IEiFVYA6QD/wesADpPAYD6IcFHmLMP84dlzYEbeaSN
	mmN23VqzUcvC1nsU+HiBWoHcslGIzjVRWGns8ZQHN2tt4dhAWOMnK76RnF082EnnoM9J7PH
	RDq7TXPBdMzVOuEamwupO4ailCWlp5CqVcKf6/NEVO0Nl5L226dfj0w6wCC1rLamgOx5rUF
	sUWNVxw1by8y+3CE2TNSQvfVvbt+cEyWZWEQVvZ64cCulPPtY948IzHeX1s2vynMuALInBC
	4CKFt8t+SkbqrRcapyUIDw4eKfpuBqRuZA4AoUL/Xzst/pyhdDAku8XEoZGFqQ3zT0hxgU4
	gKTysewD39QmDufmFcNlB7O8HxeJRJXnxUR0nX6ZM7yvLxqIRSNYG7mcLzoTND+6mYnMgMS
	RYjBsSyZqmsAzWR9VluQDiZZ+eLUrZsHW3v5gr6B7sx3XwkNe386HBfCyd5z9cd/ugVPDCI
	CU6HY2LSXYVq0rxD1wuzPPO1BW/sfdFEED6N/daqDrUbAk+9C/U3S2I7iUU7BwiXPrvsDwy
	j/6zZarrRneGzQj2dQCXj+0l+LgEWXHsxrKQlSCfm1TUovBwfgyQBZpFHnHOBz+FVZIqIWg
	lvNRKUXfZUS3ezIKLH4QAudrbqDmPEhCRvtEggpr8rYSb2Vscscychjf2e9B0ktexu1wj5v
	KvbgNoNt3RTVAxfeqDUOANVKlR58fz2A30Wbzv6Y5RUd5iIm4h5RKSi02DwG+gEaEajpqzc
	g==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Jingyu Li <joey.li@spacemit.com>

Introduces auxiliary bus support for RISC-V IOMMU to enable modular
extension of IOMMU capabilities. The framework allows creating auxiliary
devices that can be bound to separate drivers.

The IOMMU HPM featured PMU device ("iommu.riscv_iommu_hpm.0") is created
and registered as RISC-V IOMMU auxiliary device.

Signed-off-by: Jingyu Li <joey.li@spacemit.com>
Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Link: https://github.com/riscv-non-isa/riscv-iommu
Cc: Zong Li <zong.li@sifive.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
 drivers/iommu/riscv/Kconfig          |   1 +
 drivers/iommu/riscv/iommu-pci.c      |   8 +-
 drivers/iommu/riscv/iommu-platform.c |   3 +
 drivers/iommu/riscv/iommu.c          | 169 +++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h          |  21 ++++
 include/linux/riscv_iommu.h          |  75 ++++++++++++
 6 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/riscv_iommu.h

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index c071816f59a6..26122a3a73d2 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -6,6 +6,7 @@ config RISCV_IOMMU
 	depends on RISCV && 64BIT
 	default y
 	select IOMMU_API
+	select AUXILIARY_BUS
 	help
 	  Support for implementations of the RISC-V IOMMU architecture that
 	  complements the RISC-V MMU capabilities, providing similar address
diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
index d82d2b00904c..478e72e9a285 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -34,6 +34,8 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 {
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu;
+	phys_addr_t reg_phys;
+	resource_size_t reg_size;
 	int rc, vec;
 
 	rc = pcim_enable_device(pdev);
@@ -43,7 +45,9 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
 		return -ENODEV;
 
-	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
+	reg_phys = pci_resource_start(pdev, 0);
+	reg_size = pci_resource_len(pdev, 0);
+	if (reg_size < RISCV_IOMMU_REG_SIZE)
 		return -ENODEV;
 
 	rc = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
@@ -56,6 +60,8 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_i
 
 	iommu->dev = dev;
 	iommu->reg = pcim_iomap_table(pdev)[0];
+	iommu->reg_phys = reg_phys;
+	iommu->reg_size = reg_size;
 
 	pci_set_master(pdev);
 	dev_set_drvdata(dev, iommu);
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 83a28c83f991..e8e52bca8856 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -62,6 +62,9 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(iommu->reg),
 				     "could not map register region\n");
 
+	iommu->reg_phys = res->start;
+	iommu->reg_size = resource_size(res);
+
 	dev_set_drvdata(dev, iommu);
 
 	/* Check device reported capabilities / features. */
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..1aa942486e3a 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
@@ -47,11 +48,28 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+static DEFINE_IDA(riscv_iommu_subdev_ida);
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
 };
 
+bool riscv_iommu_pmip_status(struct riscv_iommu_subdev *subdev)
+{
+	u32 ipsr = riscv_iommu_readl(subdev->iommu, RISCV_IOMMU_REG_IPSR);
+
+	return !!(ipsr & RISCV_IOMMU_IPSR_PMIP);
+}
+EXPORT_SYMBOL_GPL(riscv_iommu_pmip_status);
+
+void riscv_iommu_clear_pmip(struct riscv_iommu_subdev *subdev)
+{
+	riscv_iommu_writel(subdev->iommu, RISCV_IOMMU_REG_IPSR,
+			   RISCV_IOMMU_IPSR_PMIP);
+}
+EXPORT_SYMBOL_GPL(riscv_iommu_clear_pmip);
+
 static void riscv_iommu_devres_pages_release(struct device *dev, void *res)
 {
 	struct riscv_iommu_devres *devres = res;
@@ -1602,10 +1620,154 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 	return 0;
 }
 
+static void riscv_iommu_subdev_release(struct device *dev)
+{
+	struct riscv_iommu_subdev *subdev = riscv_iommu_get_subdev(dev);
+
+	ida_free(&riscv_iommu_subdev_ida, subdev->auxdev.id);
+	kfree(subdev->info);
+	kfree(subdev);
+}
+
+static int riscv_iommu_subdev_add(struct riscv_iommu_device *iommu,
+				  const struct riscv_iommu_subdev_params *params)
+{
+	struct riscv_iommu_subdev *subdev;
+	struct auxiliary_device *auxdev;
+	int id, ret;
+
+	if (!params->info)
+		return -EINVAL;
+
+	id = ida_alloc(&riscv_iommu_subdev_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	subdev = kzalloc(sizeof(*subdev), GFP_KERNEL);
+	if (!subdev) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	subdev->base = params->base;
+	subdev->iommu = iommu;
+	subdev->info = params->info;
+
+	auxdev = &subdev->auxdev;
+	auxdev->name = params->name;
+	auxdev->id = id;
+	auxdev->dev.parent = iommu->dev;
+	auxdev->dev.release = riscv_iommu_subdev_release;
+
+	ret = auxiliary_device_init(auxdev);
+	if (ret) {
+		dev_err(iommu->dev, "Failed to init %s auxiliary device: %d\n",
+			params->name, ret);
+		goto err_free;
+	}
+
+	ret = auxiliary_device_add(auxdev);
+	if (ret) {
+		dev_err(iommu->dev, "Failed to add %s auxiliary device: %d\n",
+			params->name, ret);
+		goto err_uninit;
+	}
+
+	spin_lock(&iommu->subdev_lock);
+	list_add_tail(&subdev->link, &iommu->subdev_list);
+	spin_unlock(&iommu->subdev_lock);
+	dev_info(iommu->dev, "%s auxiliary device created\n", params->name);
+	return 0;
+
+err_uninit:
+	auxiliary_device_uninit(auxdev);
+	return ret;
+
+err_free:
+	kfree(subdev);
+	ida_free(&riscv_iommu_subdev_ida, id);
+	return ret;
+}
+
+static void riscv_iommu_enumerate_hpm(struct riscv_iommu_device *iommu)
+{
+	struct riscv_iommu_hpm_info *hpm_info;
+	struct riscv_iommu_subdev_params params;
+	int irq;
+	int ret;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
+		return;
+
+	irq = iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_INTR_PM)];
+	if (irq <= 0) {
+		dev_err(iommu->dev, "HPM: No IRQ available\n");
+		return;
+	}
+
+	hpm_info = kzalloc(sizeof(*hpm_info), GFP_KERNEL);
+	if (!hpm_info)
+		return;
+
+	hpm_info->irq = irq;
+
+	params = (struct riscv_iommu_subdev_params) {
+		.name = "riscv_iommu_hpm",
+		.info = hpm_info,
+		.base = iommu->reg + RISCV_IOMMU_REG_IOCOUNTOVF,
+	};
+
+	ret = riscv_iommu_subdev_add(iommu, &params);
+	if (ret) {
+		kfree(hpm_info);
+		dev_warn(iommu->dev,
+			 "Failed to enumerate HPM auxiliary device: %d\n",
+			 ret);
+	}
+}
+
+/**
+ * riscv_iommu_subdev_setup - Enumerate auxiliary bus subdevices
+ *
+ * @iommu: RISC-V IOMMU device
+ *
+ * Enumerates HPM, or other extended subdevices via the auxiliary bus. To
+ * add new extended device types, implement an enumerate function and call
+ * it from here.
+ */
+void riscv_iommu_subdev_setup(struct riscv_iommu_device *iommu)
+{
+	riscv_iommu_enumerate_hpm(iommu);
+}
+
+/**
+ * riscv_iommu_subdev_cleanup - Remove all auxiliary bus subdevices
+ *
+ * @iommu: RISC-V IOMMU device
+ *
+ * Iterates over the subdev_list in reverse order, deletes each auxiliary
+ * device from the bus and uninitializes it.
+ */
+void riscv_iommu_subdev_cleanup(struct riscv_iommu_device *iommu)
+{
+	struct riscv_iommu_subdev *subdev, *next;
+
+	spin_lock(&iommu->subdev_lock);
+	list_for_each_entry_safe_reverse(subdev, next, &iommu->subdev_list, link) {
+		list_del_init(&subdev->link);
+		spin_unlock(&iommu->subdev_lock);
+		auxiliary_device_delete(&subdev->auxdev);
+		auxiliary_device_uninit(&subdev->auxdev);
+		spin_lock(&iommu->subdev_lock);
+	}
+	spin_unlock(&iommu->subdev_lock);
+}
+
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
+	riscv_iommu_subdev_cleanup(iommu);
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
@@ -1615,6 +1777,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 {
 	int rc;
 
+	spin_lock_init(&iommu->subdev_lock);
+	INIT_LIST_HEAD(&iommu->subdev_list);
 	RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
 	RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
 
@@ -1669,6 +1833,11 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	/* Initialize auxiliary devices for extended features. These are not
+	 * critical to IOMMU operation, so failures are non-fatal.
+	 */
+	riscv_iommu_subdev_setup(iommu);
+
 	return 0;
 
 err_remove_sysfs:
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..1296625488ef 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/riscv_iommu.h>
 
 #include "iommu-bits.h"
 
@@ -42,6 +43,8 @@ struct riscv_iommu_device {
 
 	/* hardware control register space */
 	void __iomem *reg;
+	phys_addr_t reg_phys;
+	resource_size_t reg_size;
 
 	/* supported and enabled hardware capabilities */
 	u64 caps;
@@ -60,11 +63,29 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+	/* auxiliary subdevices */
+	spinlock_t subdev_lock;
+	struct list_head subdev_list;
+};
+
+/**
+ * struct riscv_iommu_subdev_params - params for adding auxiliary subdevice
+ * @name: auxiliary device name
+ * @info: device-specific info, freed in release
+ * @base: PMU register base
+ */
+struct riscv_iommu_subdev_params {
+	const char *name;
+	void *info;
+	void __iomem *base;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
+void riscv_iommu_subdev_setup(struct riscv_iommu_device *iommu);
+void riscv_iommu_subdev_cleanup(struct riscv_iommu_device *iommu);
 
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
diff --git a/include/linux/riscv_iommu.h b/include/linux/riscv_iommu.h
new file mode 100644
index 000000000000..0447bc4d1fab
--- /dev/null
+++ b/include/linux/riscv_iommu.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * RISC-V IOMMU Common Interface
+ *
+ * This header provides a common interface for sharing resources between
+ * the RISC-V IOMMU driver and its auxiliary bus child drivers.
+ *
+ * Copyright (C) 2026 SpacemiT Technologies Inc.
+ *   Author: 2026 Jingyu Li <joey.li@spacemit.com>
+ *                Lv Zheng <lv.zheng@spacemit.com>
+ */
+
+#ifndef _LINUX_RISCV_IOMMU_H_
+#define _LINUX_RISCV_IOMMU_H_
+
+#include <linux/auxiliary_bus.h>
+
+struct riscv_iommu_device;
+
+/**
+ * struct riscv_iommu_subdev - RISC-V IOMMU auxiliary bus subdevice
+ * @link: list node for iommu->subdev_list
+ * @auxdev: auxiliary bus device ((use auxdev.id for unique id)
+ * @base: PMU register base
+ * @iommu: parent IOMMU (opaque)
+ * @info: subdevice-specific info, freed in release
+ */
+struct riscv_iommu_subdev {
+	struct list_head link;
+	struct auxiliary_device auxdev;
+	void __iomem *base;
+	struct riscv_iommu_device *iommu;
+	void *info;
+};
+
+/**
+ * struct riscv_iommu_hpm_info - HPM info for IOATS (main IOMMU HPM)
+ * @irq: interrupt number
+ */
+struct riscv_iommu_hpm_info {
+	unsigned int irq;
+};
+
+/**
+ * riscv_iommu_get_subdev - get riscv_iommu_subdev from device
+ *
+ * @dev: &device of the auxiliary device (auxdev->dev)
+ *
+ * Returns the riscv_iommu_subdev pointer, or NULL if @dev is NULL.
+ */
+static inline struct riscv_iommu_subdev *riscv_iommu_get_subdev(struct device *dev)
+{
+	if (!dev)
+		return NULL;
+	return container_of(container_of(dev, struct auxiliary_device, dev),
+			    struct riscv_iommu_subdev, auxdev);
+}
+
+/**
+ * riscv_iommu_pmip_status - test if PM interrupt is pending
+ *
+ * @subdev: subdevice with iommu
+ *
+ * Returns true if PM interrupt pending, false otherwise.
+ */
+bool riscv_iommu_pmip_status(struct riscv_iommu_subdev *subdev);
+
+/**
+ * riscv_iommu_clear_pmip - clear PMIP bit in IPSR to ack PMU interrupt
+ *
+ * @subdev: subdevice with iommu
+ */
+void riscv_iommu_clear_pmip(struct riscv_iommu_subdev *subdev);
+
+#endif /* _LINUX_RISCV_IOMMU_H_ */
-- 
2.43.0

