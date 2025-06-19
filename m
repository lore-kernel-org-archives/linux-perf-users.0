Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9697202F8F;
	Thu, 19 Jun 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327883; cv=none; b=iOeAa0wofpc/ncB4NLmOdUEgd3jxOOuCBodVxmBeD9I0H+vpOR20L6tz2NTXcfIRuGi3+SfO1QY3R/gVydI565/psdv7LDTEyiGtdO2gsSQtMhQUowIs6lldpyu17OQMfsOY2tXUkBr7LLyULOlXzOQ8FcsO/e78OaTBuNKHMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327883; c=relaxed/simple;
	bh=2x1BpjAPOWfj+38xntqzlIqkh3L6BLUM6DnXKQ2e0kw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmYG17tkDIqJ2Qh9oQIBRPKlBLRp4cBEZQvTfmBDvWVWqe/v2jFTtd7hbWTt/UcfaLDLAY9e/LYpDUcFIfXU4c9tnOCBqw2GEgs1F68dcfN64Lxz+s/jmPES7egv3do8UOQ//z8H2buFR+o8Q0gp7I0M2DVuo7biyLS+ysR2JdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNGTw5Ys8z6L5R7;
	Thu, 19 Jun 2025 18:06:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B7F281404C6;
	Thu, 19 Jun 2025 18:11:11 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Jun
 2025 12:11:10 +0200
Date: Thu, 19 Jun 2025 11:11:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <tongtiangen@huawei.com>, Yicong Yang
	<yangyicong@huawei.com>, Niyas Sait <niyas.sait@huawei.com>,
	<ajayjoshi@micron.com>, Vandana Salve <vsalve@micron.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gregory Price <gourry@gourry.net>, Huang
 Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 1/4] cxl: Register devices for CXL Hotness
 Monitoring Units (CHMU)
Message-ID: <20250619111109.0000640e@huawei.com>
In-Reply-To: <aFNsFI5OKrD0CWR3@phytium.com.cn>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
	<20241121101845.1815660-2-Jonathan.Cameron@huawei.com>
	<aFNsFI5OKrD0CWR3@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Jun 2025 09:47:00 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> On Thu, Nov 21, 2024 at 10:18:42AM +0000, Jonathan Cameron wrote:
> > Basic registration using similar approach to how the CPMUs
> > are registered.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/cxl/core/Makefile |  1 +
> >  drivers/cxl/core/hmu.c    | 64 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/regs.c   | 14 +++++++++
> >  drivers/cxl/cxl.h         |  4 +++
> >  drivers/cxl/cxlpci.h      |  1 +
> >  drivers/cxl/hmu.h         | 23 ++++++++++++++
> >  drivers/cxl/pci.c         | 26 +++++++++++++++-
> >  7 files changed, 132 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 9259bcc6773c..d060abb773ae 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -12,6 +12,7 @@ cxl_core-y +=3D memdev.o
> >  cxl_core-y +=3D mbox.o
> >  cxl_core-y +=3D pci.o
> >  cxl_core-y +=3D hdm.o
> > +cxl_core-y +=3D hmu.o
> >  cxl_core-y +=3D pmu.o
> >  cxl_core-y +=3D cdat.o
> >  cxl_core-$(CONFIG_TRACING) +=3D trace.o
> > diff --git a/drivers/cxl/core/hmu.c b/drivers/cxl/core/hmu.c
> > new file mode 100644
> > index 000000000000..3ee938bb6c05
> > --- /dev/null
> > +++ b/drivers/cxl/core/hmu.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2024 Huawei. All rights reserved. */
> > +
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/idr.h>
> > +#include <cxlmem.h>
> > +#include <hmu.h>
> > +#include <cxl.h>
> > +#include "core.h"
> > +
> > +static void cxl_hmu_release(struct device *dev)
> > +{
> > +	struct cxl_hmu *hmu =3D to_cxl_hmu(dev);
> > +
> > +	kfree(hmu);
> > +}
> > +
> > +const struct device_type cxl_hmu_type =3D {
> > +	.name =3D "cxl_hmu",
> > +	.release =3D cxl_hmu_release,
> > +};
> > +
> > +static void remove_dev(void *dev)
> > +{
> > +	device_unregister(dev);
> > +}
> > +
> > +int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
> > +		     int assoc_id, int index)
> > +{
> > +	struct cxl_hmu *hmu;
> > +	struct device *dev;
> > +	int rc;
> > +
> > +	hmu =3D kzalloc(sizeof(*hmu), GFP_KERNEL);
> > +	if (!hmu)
> > +		return -ENOMEM;
> > +
> > +	hmu->assoc_id =3D assoc_id;
> > +	hmu->index =3D index;
> > +	hmu->base =3D regs->hmu;
> > +	dev =3D &hmu->dev;
> > +	device_initialize(dev);
> > +	device_set_pm_not_required(dev);
> > +	dev->parent =3D parent;
> > +	dev->bus =3D &cxl_bus_type;
> > +	dev->type =3D &cxl_hmu_type;
> > +	rc =3D dev_set_name(dev, "hmu_mem%d.%d", assoc_id, index);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc =3D device_add(dev);
> > +	if (rc)
> > +		goto err;
> > +
> > +	return devm_add_action_or_reset(parent, remove_dev, dev);
> > +
> > +err:
> > +	put_device(&hmu->dev);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_cxl_hmu_add, CXL);
> > +
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index e1082e749c69..c12afaa6ef98 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -401,6 +401,20 @@ int cxl_map_pmu_regs(struct cxl_register_map *map,=
 struct cxl_pmu_regs *regs)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
> > =20
> > +int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs=
 *regs)
> > +{
> > +	struct device *dev =3D map->host;
> > +	resource_size_t phys_addr;
> > +
> > +	phys_addr =3D map->resource;
> > +	regs->hmu =3D devm_cxl_iomap_block(dev, phys_addr, map->max_size); =20
> I applied CHMU patch on 6.15.0 kernel and I tried to boot the virt with
> one cxl root port and one device (jic23/cxl-2025-06-10), then the dmesg s=
hows
> "Failed to request region 0x10210000-0x1023ffff". I guess it is caused by=
 the
> 'map->max_size'(0x30000) is large and the resource has been allocated by =
CPMU regs.
> I tried to change it to 0x10000, the hmu_mem0.0 could be created as norma=
l.

Ah. I was meaning to post an updated version of this series just to fix the
bug you've hit here but forgot to do so! Sorry about that.

I need to figure out if there is a more elegant way to do this but in meant=
ime
here is what I'm carrying on top of these posted series. It's a fairly horr=
ible
bit of layering as we need the generic code to know to poke around inside a=
 temporary
mapping just to get the size that it should iomap.

=46rom fadffb32ed302dfb6dec4497214e1d3b39450f8b Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 17 Apr 2025 11:02:07 +0100
Subject: [PATCH] Fix up sizing of CHMU issue

---
 drivers/cxl/core/regs.c | 16 ++++++++++++++--
 drivers/cxl/cxlpci.h    |  7 +++++++
 drivers/cxl/hmu.c       |  6 ------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 925870c4e494..5ae31696bf8b 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -416,10 +416,22 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, "CXL");
 int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs *re=
gs)
 {
 	struct device *dev =3D map->host;
-	resource_size_t phys_addr;
+	u64 __iomem *poke;
+	u64 common_cap[2];
+	resource_size_t phys_addr, phys_size;
=20
 	phys_addr =3D map->resource;
-	regs->hmu =3D devm_cxl_iomap_block(dev, phys_addr, map->max_size);
+	/* Finding out the size of a CHMU means poking around inside */
+	poke =3D ioremap(phys_addr, sizeof(common_cap));
+	if (!poke) {
+		return -ENOMEM;
+	}
+	common_cap[0] =3D le64_to_cpu(readq(poke));
+	common_cap[1] =3D le64_to_cpu(readq(poke + 1));
+	iounmap(poke);
+	phys_size =3D FIELD_GET(CHMU_COMMON_CAP0_NUMINST_MSK, common_cap[0]) *
+		FIELD_GET(CHMU_COMMON_CAP1_INSTLEN_MSK, common_cap[1]) + 0x10;
+	regs->hmu =3D devm_cxl_iomap_block(dev, phys_addr, phys_size);
 	if (!regs->hmu)
 		return -ENOMEM;
=20
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index f7b902eab288..a91407292aea 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -77,6 +77,13 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
=20
+/* A few CHMU registers are needed to establish size */
+#define CHMU_COMMON_CAP0_REG				0x00
+#define   CHMU_COMMON_CAP0_VER_MSK			GENMASK(3, 0)
+#define   CHMU_COMMON_CAP0_NUMINST_MSK			GENMASK(15, 8)
+#define CHMU_COMMON_CAP1_REG				0x08
+#define   CHMU_COMMON_CAP1_INSTLEN_MSK			GENMASK(15, 0)
+
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
diff --git a/drivers/cxl/hmu.c b/drivers/cxl/hmu.c
index 1a7a0f60a6ad..a1953e8750c8 100644
--- a/drivers/cxl/hmu.c
+++ b/drivers/cxl/hmu.c
@@ -27,12 +27,6 @@
 #include "cxl.h"
 #include "hmu.h"
=20
-#define CHMU_COMMON_CAP0_REG				0x00
-#define   CHMU_COMMON_CAP0_VER_MSK			GENMASK(3, 0)
-#define   CHMU_COMMON_CAP0_NUMINST_MSK			GENMASK(15, 8)
-#define CHMU_COMMON_CAP1_REG				0x08
-#define   CHMU_COMMON_CAP1_INSTLEN_MSK			GENMASK(15, 0)
-
 /* Register offsets within instance */
 #define CHMU_INST0_CAP0_REG				0x00
 #define   CHMU_INST0_CAP0_MSI_N_MSK			GENMASK(3, 0)
--=20
2.48.1



> > +	if (!regs->hmu)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_map_hmu_regs, CXL);
> > +
> >  static int cxl_map_regblock(struct cxl_register_map *map)
> >  {
> >  	struct device *host =3D map->host;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 5406e3ab3d4a..8172bc1f7a8d 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -227,6 +227,9 @@ struct cxl_regs {
> >  	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> >  		void __iomem *pmu;
> >  	);
> > +	struct_group_tagged(cxl_hmu_regs, hmu_regs,
> > +		void __iomem *hmu;
> > +	);
> > =20
> >  	/*
> >  	 * RCH downstream port specific RAS register
> > @@ -292,6 +295,7 @@ int cxl_map_component_regs(const struct cxl_registe=
r_map *map,
> >  			   unsigned long map_mask);
> >  int cxl_map_device_regs(const struct cxl_register_map *map,
> >  			struct cxl_device_regs *regs);
> > +int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs=
 *regs);
> >  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs=
 *regs);
> > =20
> >  enum cxl_regloc_type;
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 4da07727ab9c..71f5e9620137 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -67,6 +67,7 @@ enum cxl_regloc_type {
> >  	CXL_REGLOC_RBI_VIRT,
> >  	CXL_REGLOC_RBI_MEMDEV,
> >  	CXL_REGLOC_RBI_PMU,
> > +	CXL_REGLOC_RBI_HMU,
> >  	CXL_REGLOC_RBI_TYPES
> >  };
> > =20
> > diff --git a/drivers/cxl/hmu.h b/drivers/cxl/hmu.h
> > new file mode 100644
> > index 000000000000..c4798ed9764b
> > --- /dev/null
> > +++ b/drivers/cxl/hmu.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright(c) 2024 Huawei
> > + * CXL Specification rev 3.2 Setion 8.2.8 (CHMU Register Interface)
> > + */
> > +#ifndef CXL_HMU_H
> > +#define CXL_HMU_H
> > +#include <linux/device.h>
> > +
> > +#define CXL_HMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification =
*/
> > +struct cxl_hmu {
> > +	struct device dev;
> > +	void __iomem *base;
> > +	int assoc_id;
> > +	int index;
> > +};
> > +
> > +#define to_cxl_hmu(dev) container_of(dev, struct cxl_hmu, dev)
> > +struct cxl_hmu_regs;
> > +int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
> > +		     int assoc_id, int idx);
> > +
> > +#endif
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 188412d45e0d..e89ea9d3f007 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -15,6 +15,7 @@
> >  #include "cxlmem.h"
> >  #include "cxlpci.h"
> >  #include "cxl.h"
> > +#include "hmu.h"
> >  #include "pmu.h"
> > =20
> >  /**
> > @@ -814,7 +815,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
> >  	struct cxl_dev_state *cxlds;
> >  	struct cxl_register_map map;
> >  	struct cxl_memdev *cxlmd;
> > -	int i, rc, pmu_count;
> > +	int i, rc, hmu_count, pmu_count;
> >  	bool irq_avail;
> > =20
> >  	/*
> > @@ -938,6 +939,29 @@ static int cxl_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
> >  		}
> >  	}
> > =20
> > +	hmu_count =3D cxl_count_regblock(pdev, CXL_REGLOC_RBI_HMU);
> > +	for (i =3D 0; i < hmu_count; i++) {
> > +		struct cxl_hmu_regs hmu_regs;
> > +
> > +		rc =3D cxl_find_regblock_instance(pdev, CXL_REGLOC_RBI_HMU, &map, i);
> > +		if (rc) {
> > +			dev_dbg(&pdev->dev, "Could not find HMU regblock\n");
> > +			break;
> > +		}
> > +
> > +		rc =3D cxl_map_hmu_regs(&map, &hmu_regs);
> > +		if (rc) {
> > +			dev_dbg(&pdev->dev, "Could not map HMU regs\n");
> > +			break;
> > +		}
> > +
> > +		rc =3D devm_cxl_hmu_add(cxlds->dev, &hmu_regs, cxlmd->id, i);
> > +		if (rc) {
> > +			dev_dbg(&pdev->dev, "Could not add HMU instance\n");
> > +			break;
> > +		}
> > +	}
> > +
> >  	rc =3D cxl_event_config(host_bridge, mds, irq_avail);
> >  	if (rc)
> >  		return rc;
> > --=20
> > 2.43.0
> >  =20
>=20
>=20

