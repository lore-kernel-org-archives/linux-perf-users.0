Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F691B4134
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899790; cv=none; b=dF44OSnNC4bQkmWMkU0PmR50uAwyTfDRO0tyqqO0+8KjtaOQmmx2NBHs2dsFFN+4gJO+ZPXMK63Lreu5gwTgfjDc55ddVFeZoFnIMxKUTUf3P+qi64G4LcqEQY06Bd4X0cGVFsTuMUq1DtazAlISOsFaLrJfym6MLY7042KxwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899790; c=relaxed/simple;
	bh=iVD4Lx+4w6bl3EXKy7NzC8GfJ5W+VUTQap+ImglCWaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=gkb5Vt7USHwxTuhTf1p74eoLJ4Mm62MQfk1a8IgWG1ioyWW0/GAWjm0A8ZN/KDoxjW4C6z+bEacp1P8wbMRuJLmxjQlqvptQ+W5c0SHxsmYcC38f2c1nNh/oQy8YGMH26jh2OZ3Yr2viaicOnGO9E5rczO3kFEUPdF22GujMO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fxDJoO1E; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fxDJoO1E"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250103102303epoutp03a861219d2d16f7f52896f3d56ad03bf2~XJ6gA8aAy2177121771epoutp03L
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 10:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250103102303epoutp03a861219d2d16f7f52896f3d56ad03bf2~XJ6gA8aAy2177121771epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735899783;
	bh=fvfyvrq9q8Jl++vQ8mfg9WZLMuBwSaGVi6gxxo7zJkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxDJoO1E+IjdldLk4yqT6egfIbG32vWG3ce56tfebKYMdEUCsvrOzwdkWKud6EWTc
	 YE+WHJhAiXRZkW8GZOYyqyOMB5r5+txx7gR/9s6s1+Wdjfttx0K24YceJdbTejFmgD
	 IpCnXxQ4xbZB7cvu1l+xKGe14Pt5uWapVUwYNVp0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250103102302epcas5p1619095d7c201ac05ab3e8868e941550a~XJ6ewQRfw2727827278epcas5p18;
	Fri,  3 Jan 2025 10:23:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YPfm63jVDz4x9Pw; Fri,  3 Jan
	2025 10:23:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250103052421epcas5p4a1a917ba5d367dfccec91d4522666ca0~XF1sc0qA81042010420epcas5p4n;
	Fri,  3 Jan 2025 05:24:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250103052421epsmtrp17a16a66d997a1377e9a54ef10eddacf3~XF1sbldH10733907339epsmtrp1z;
	Fri,  3 Jan 2025 05:24:21 +0000 (GMT)
X-AuditID: b6c32a2a-38bf570000004a05-47-67777485a9d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.17.18949.58477776; Fri,  3 Jan 2025 14:24:21 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250103052417epsmtip25f1a08f8a90e6acc0095d700090023d9~XF1owHm1N1327113271epsmtip2h;
	Fri,  3 Jan 2025 05:24:17 +0000 (GMT)
Date: Fri, 3 Jan 2025 10:46:17 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, tongtiangen@huawei.com, Yicong Yang
	<yangyicong@huawei.com>, Niyas Sait <niyas.sait@huawei.com>,
	ajayjoshi@micron.com, Vandana Salve <vsalve@micron.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gregory Price <gourry@gourry.net>,
	Huang Ying <ying.huang@intel.com>, Vishak G <vishak.g@samsung.com>, Krishna
	Kanth Reddy <krish.reddy@samsung.com>, Alok Rathore
	<alok.rathore@samsung.com>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 1/4] cxl: Register devices for CXL Hotness
 Monitoring Units (CHMU)
Message-ID: <1983025922.01735899782509.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241121101845.1815660-2-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMYRjGfeecPXtasxzF7BfJWMYlrGpMPsYo08hhmsEYd8Vqj21HW2s3
	oURSKFNjQstWO+5lW9FGRVutjbJCFykZYilpKl0okeupMfz3zPP8fu9fL4U7thHjKUVoOKsO
	lYaISQGRXyaeNCc+fI/cPbbSCSU2FZIoqziej46ZzvLQq3fVJPpcaSZRm3Um0p6uBuhB4yES
	ZTcaAWq03MbQ11cVfFTa0kogw/l6Ep3PvYKhKt1DAj29k06iJuMvHqq7lUOgstxHGLrcUIOh
	Wss5DMVrnwBUkWTBUGlpJWek81FJ/k0cGTMbMWTTnSR8XBij3giY40ee8pm4e508Ji/Ljblo
	bsMYkyGBZEy9KXxGb1vNfLl+jGS6Sp6RTPJNA2BOpx1kPplcVwk3CRbJ2BBFBKueu3ibILil
	3UaovnntNdsFMcA6JxE4UJCeB29kPyQTgYBypIsALKutJIcHCL9+/wyGsxO8+rOVPww1A9jR
	dBjnBoKeCvtr7Hwuk/RM2FATx+PyWNoTfnyeAjgBp6/xYVfvDYwbnOgtcKDq4pAgpL1gbXox
	kQioP1ejYJo2bLgeA21nmwku438QfZ4d5xCcngAzf1Jc7UD7wrc9R4eQcbQLPHO5Dz8Bxuj+
	s3X/2bp/9jmAG4Azq9Io5UqNh8ozlN0j0UiVmt2hcklQmNIEhr7Bza0QmA3dEivAKGAFkMLF
	Y4Ub1ofLHYUy6b5IVh22Vb07hNVYwQSKEIuE/e1JMkdaLg1nd7KsilX/XTHKYXwMRvhPGfWd
	moe/ifFN7iyf3vyxbYfnciScvOS13XbhniVM0PRh/2Bfw7dFcn3vrYzNS+0Hyi/lXcKdlNEh
	hQOixb5JXVUixck1VWbVdnfXMm9eEulf4ro9MDX6Q0fsNMm0yXrvGJNH1LKIWWY4mLrtvsK1
	pydnr3mLX0XAL+eS6tXOwiuR6RnRQY/FBwRRP2Qrps/I9CgQBnq1L+mI67szOKW+ddBCd3/Z
	WLdOqw3yXhuRtnCuF3l/kjVHdDdyQYdsdLfffPcEvd/LAPuZxxNjy83OdfWHTaLglk6FJGWN
	bNeAT6BLYcEq9fX+jOSE98UrRxedGiFA7bOPp/hEuBetfTGSEBOaYKmHG67WSH8D6Pvi83wD
	AAA=
X-CMS-MailID: 20250103052421epcas5p4a1a917ba5d367dfccec91d4522666ca0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_d503c_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250103052421epcas5p4a1a917ba5d367dfccec91d4522666ca0
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
	<20241121101845.1815660-2-Jonathan.Cameron@huawei.com>
	<CGME20250103052421epcas5p4a1a917ba5d367dfccec91d4522666ca0@epcas5p4.samsung.com>

------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_d503c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 21/11/24 10:18AM, Jonathan Cameron wrote:
>Basic registration using similar approach to how the CPMUs
>are registered.
>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>---
> drivers/cxl/core/Makefile |  1 +
> drivers/cxl/core/hmu.c    | 64 +++++++++++++++++++++++++++++++++++++++
> drivers/cxl/core/regs.c   | 14 +++++++++
> drivers/cxl/cxl.h         |  4 +++
> drivers/cxl/cxlpci.h      |  1 +
> drivers/cxl/hmu.h         | 23 ++++++++++++++
> drivers/cxl/pci.c         | 26 +++++++++++++++-
> 7 files changed, 132 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>index 9259bcc6773c..d060abb773ae 100644
>--- a/drivers/cxl/core/Makefile
>+++ b/drivers/cxl/core/Makefile
>@@ -12,6 +12,7 @@ cxl_core-y += memdev.o
> cxl_core-y += mbox.o
> cxl_core-y += pci.o
> cxl_core-y += hdm.o
>+cxl_core-y += hmu.o
> cxl_core-y += pmu.o
> cxl_core-y += cdat.o
> cxl_core-$(CONFIG_TRACING) += trace.o
>diff --git a/drivers/cxl/core/hmu.c b/drivers/cxl/core/hmu.c
>new file mode 100644
>index 000000000000..3ee938bb6c05
>--- /dev/null
>+++ b/drivers/cxl/core/hmu.c
>@@ -0,0 +1,64 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/* Copyright(c) 2024 Huawei. All rights reserved. */
>+
>+#include <linux/device.h>
>+#include <linux/slab.h>
>+#include <linux/idr.h>
>+#include <cxlmem.h>
>+#include <hmu.h>
>+#include <cxl.h>
>+#include "core.h"
>+
>+static void cxl_hmu_release(struct device *dev)
>+{
>+	struct cxl_hmu *hmu = to_cxl_hmu(dev);
>+
>+	kfree(hmu);
>+}
>+
>+const struct device_type cxl_hmu_type = {
>+	.name = "cxl_hmu",
>+	.release = cxl_hmu_release,
>+};
>+
>+static void remove_dev(void *dev)
>+{
>+	device_unregister(dev);
>+}
>+
>+int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
>+		     int assoc_id, int index)
>+{
>+	struct cxl_hmu *hmu;
>+	struct device *dev;
>+	int rc;
>+
>+	hmu = kzalloc(sizeof(*hmu), GFP_KERNEL);
>+	if (!hmu)
>+		return -ENOMEM;
>+
>+	hmu->assoc_id = assoc_id;
>+	hmu->index = index;
>+	hmu->base = regs->hmu;
>+	dev = &hmu->dev;
>+	device_initialize(dev);
>+	device_set_pm_not_required(dev);
>+	dev->parent = parent;
>+	dev->bus = &cxl_bus_type;
>+	dev->type = &cxl_hmu_type;
>+	rc = dev_set_name(dev, "hmu_mem%d.%d", assoc_id, index);
>+	if (rc)
>+		goto err;
>+
>+	rc = device_add(dev);
>+	if (rc)
>+		goto err;
>+
>+	return devm_add_action_or_reset(parent, remove_dev, dev);
>+
>+err:
>+	put_device(&hmu->dev);
>+	return rc;
>+}
>+EXPORT_SYMBOL_NS_GPL(devm_cxl_hmu_add, CXL);
>+
>diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>index e1082e749c69..c12afaa6ef98 100644
>--- a/drivers/cxl/core/regs.c
>+++ b/drivers/cxl/core/regs.c
>@@ -401,6 +401,20 @@ int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
> }
> EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
>
>+int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs *regs)
>+{
>+	struct device *dev = map->host;
>+	resource_size_t phys_addr;
>+
>+	phys_addr = map->resource;
>+	regs->hmu = devm_cxl_iomap_block(dev, phys_addr, map->max_size);
>+	if (!regs->hmu)
>+		return -ENOMEM;
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_map_hmu_regs, CXL);
>+
> static int cxl_map_regblock(struct cxl_register_map *map)
> {
> 	struct device *host = map->host;
>diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>index 5406e3ab3d4a..8172bc1f7a8d 100644
>--- a/drivers/cxl/cxl.h
>+++ b/drivers/cxl/cxl.h
>@@ -227,6 +227,9 @@ struct cxl_regs {
> 	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> 		void __iomem *pmu;
> 	);
>+	struct_group_tagged(cxl_hmu_regs, hmu_regs,
>+		void __iomem *hmu;
>+	);
>
> 	/*
> 	 * RCH downstream port specific RAS register
>@@ -292,6 +295,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
> 			   unsigned long map_mask);
> int cxl_map_device_regs(const struct cxl_register_map *map,
> 			struct cxl_device_regs *regs);
>+int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs *regs);
> int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
>
> enum cxl_regloc_type;
>diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>index 4da07727ab9c..71f5e9620137 100644
>--- a/drivers/cxl/cxlpci.h
>+++ b/drivers/cxl/cxlpci.h
>@@ -67,6 +67,7 @@ enum cxl_regloc_type {
> 	CXL_REGLOC_RBI_VIRT,
> 	CXL_REGLOC_RBI_MEMDEV,
> 	CXL_REGLOC_RBI_PMU,
>+	CXL_REGLOC_RBI_HMU,
> 	CXL_REGLOC_RBI_TYPES
> };
>
>diff --git a/drivers/cxl/hmu.h b/drivers/cxl/hmu.h
>new file mode 100644
>index 000000000000..c4798ed9764b
>--- /dev/null
>+++ b/drivers/cxl/hmu.h
>@@ -0,0 +1,23 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/*
>+ * Copyright(c) 2024 Huawei
>+ * CXL Specification rev 3.2 Setion 8.2.8 (CHMU Register Interface)
>+ */
>+#ifndef CXL_HMU_H
>+#define CXL_HMU_H
>+#include <linux/device.h>

No compilation errors even by removing this header.
I think this inclusion is not required.
Also found similar include at drivers/cxl/pmu.h

>+
>+#define CXL_HMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */

Above Macro CXL_HMU_REGMAP_SIZE is not used, So we should remove it.
Its comment is also not appropriate

>+struct cxl_hmu {
>+	struct device dev;
>+	void __iomem *base;
>+	int assoc_id;
>+	int index;
>+};
>+
>+#define to_cxl_hmu(dev) container_of(dev, struct cxl_hmu, dev)
>+struct cxl_hmu_regs;
>+int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
>+		     int assoc_id, int idx);
>+
>+#endif
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index 188412d45e0d..e89ea9d3f007 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -15,6 +15,7 @@
> #include "cxlmem.h"
> #include "cxlpci.h"
> #include "cxl.h"
>+#include "hmu.h"
> #include "pmu.h"
>
> /**
>@@ -814,7 +815,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	struct cxl_dev_state *cxlds;
> 	struct cxl_register_map map;
> 	struct cxl_memdev *cxlmd;
>-	int i, rc, pmu_count;
>+	int i, rc, hmu_count, pmu_count;
> 	bool irq_avail;
>
> 	/*
>@@ -938,6 +939,29 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 		}
> 	}
>
>+	hmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_HMU);
>+	for (i = 0; i < hmu_count; i++) {
>+		struct cxl_hmu_regs hmu_regs;
>+
>+		rc = cxl_find_regblock_instance(pdev, CXL_REGLOC_RBI_HMU, &map, i);
>+		if (rc) {
>+			dev_dbg(&pdev->dev, "Could not find HMU regblock\n");
>+			break;
>+		}
>+
>+		rc = cxl_map_hmu_regs(&map, &hmu_regs);
>+		if (rc) {
>+			dev_dbg(&pdev->dev, "Could not map HMU regs\n");
>+			break;
>+		}
>+
>+		rc = devm_cxl_hmu_add(cxlds->dev, &hmu_regs, cxlmd->id, i);
>+		if (rc) {
>+			dev_dbg(&pdev->dev, "Could not add HMU instance\n");
>+			break;
>+		}
>+	}
>+
> 	rc = cxl_event_config(host_bridge, mds, irq_avail);
> 	if (rc)
> 		return rc;
>-- 
>2.43.0
>

------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_d503c_
Content-Type: text/plain; charset="utf-8"


------YdMQOF_WoWeg2u_t4KSKhNTuhss8l_igc36-I4U5-7l0BmvH=_d503c_--

