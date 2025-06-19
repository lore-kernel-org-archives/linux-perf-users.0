Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC32A1BA;
	Thu, 19 Jun 2025 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297650; cv=none; b=Vlvd2VcwpP2PY4rMDI82L1oxXiRdPtQr19yZByyUzmGRaZ+ACJFVqXGP5SIYp7LIU4wiX23/LoG6icCWXORgHFhCEyVmIedvRU4ql09f1S9ZFm/LQio8F8qEShN+fjxuT8ETPKEFUZcBwFY9f0avyEQYh0hBZlnEfu6lJZ1kMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297650; c=relaxed/simple;
	bh=mgfm5mlVtu0RF55CfmQFJ9zrB5wUsUHfhsfoMVk+H74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+aCIPP1qczCvwKZ+mXiiwafrVprJPb4FnZnHgFobf0Drvpax2AbQzZZCCM8Xud9MFnooJDhwKo1ZYrJdcVyB7GLA9uPO2v5c8MXvoHuiUg13yNnDjk1X47HySU2YgGxAeqTFxqgGMGZ43pjklPuJ650tEaGx70GO2cyAO6Y1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXXrYmbFNojvp1Aw--.393S2;
	Thu, 19 Jun 2025 09:47:18 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwD3jCYVbFNohbBXAA--.8864S2;
	Thu, 19 Jun 2025 09:47:02 +0800 (CST)
Date: Thu, 19 Jun 2025 09:47:00 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, tongtiangen@huawei.com,
	Yicong Yang <yangyicong@huawei.com>,
	Niyas Sait <niyas.sait@huawei.com>, ajayjoshi@micron.com,
	Vandana Salve <vsalve@micron.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gregory Price <gourry@gourry.net>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 1/4] cxl: Register devices for CXL Hotness Monitoring
 Units (CHMU)
Message-ID: <aFNsFI5OKrD0CWR3@phytium.com.cn>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
 <20241121101845.1815660-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121101845.1815660-2-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwD3jCYVbFNohbBXAA--.8864S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWhRxgsBrAAjs-
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrWkCFW5KF4kXw47CrWUCFg_yoWxKF4DpF
	W8CFWrGr48JF9F9ry3Xay5ZFn8W3Z29FyUuryIq34avFnxAFyDJF4UJayUAryrC3ykGw47
	WF15Kr10kayYgr7anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Thu, Nov 21, 2024 at 10:18:42AM +0000, Jonathan Cameron wrote:
> Basic registration using similar approach to how the CPMUs
> are registered.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/hmu.c    | 64 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c   | 14 +++++++++
>  drivers/cxl/cxl.h         |  4 +++
>  drivers/cxl/cxlpci.h      |  1 +
>  drivers/cxl/hmu.h         | 23 ++++++++++++++
>  drivers/cxl/pci.c         | 26 +++++++++++++++-
>  7 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..d060abb773ae 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -12,6 +12,7 @@ cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
> +cxl_core-y += hmu.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
> diff --git a/drivers/cxl/core/hmu.c b/drivers/cxl/core/hmu.c
> new file mode 100644
> index 000000000000..3ee938bb6c05
> --- /dev/null
> +++ b/drivers/cxl/core/hmu.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Huawei. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include <cxlmem.h>
> +#include <hmu.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_hmu_release(struct device *dev)
> +{
> +	struct cxl_hmu *hmu = to_cxl_hmu(dev);
> +
> +	kfree(hmu);
> +}
> +
> +const struct device_type cxl_hmu_type = {
> +	.name = "cxl_hmu",
> +	.release = cxl_hmu_release,
> +};
> +
> +static void remove_dev(void *dev)
> +{
> +	device_unregister(dev);
> +}
> +
> +int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
> +		     int assoc_id, int index)
> +{
> +	struct cxl_hmu *hmu;
> +	struct device *dev;
> +	int rc;
> +
> +	hmu = kzalloc(sizeof(*hmu), GFP_KERNEL);
> +	if (!hmu)
> +		return -ENOMEM;
> +
> +	hmu->assoc_id = assoc_id;
> +	hmu->index = index;
> +	hmu->base = regs->hmu;
> +	dev = &hmu->dev;
> +	device_initialize(dev);
> +	device_set_pm_not_required(dev);
> +	dev->parent = parent;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_hmu_type;
> +	rc = dev_set_name(dev, "hmu_mem%d.%d", assoc_id, index);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	return devm_add_action_or_reset(parent, remove_dev, dev);
> +
> +err:
> +	put_device(&hmu->dev);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_hmu_add, CXL);
> +
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e1082e749c69..c12afaa6ef98 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -401,6 +401,20 @@ int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
>  
> +int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs *regs)
> +{
> +	struct device *dev = map->host;
> +	resource_size_t phys_addr;
> +
> +	phys_addr = map->resource;
> +	regs->hmu = devm_cxl_iomap_block(dev, phys_addr, map->max_size);
I applied CHMU patch on 6.15.0 kernel and I tried to boot the virt with
one cxl root port and one device (jic23/cxl-2025-06-10), then the dmesg shows
"Failed to request region 0x10210000-0x1023ffff". I guess it is caused by the
'map->max_size'(0x30000) is large and the resource has been allocated by CPMU regs.
I tried to change it to 0x10000, the hmu_mem0.0 could be created as normal.
> +	if (!regs->hmu)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_map_hmu_regs, CXL);
> +
>  static int cxl_map_regblock(struct cxl_register_map *map)
>  {
>  	struct device *host = map->host;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..8172bc1f7a8d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -227,6 +227,9 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_pmu_regs, pmu_regs,
>  		void __iomem *pmu;
>  	);
> +	struct_group_tagged(cxl_hmu_regs, hmu_regs,
> +		void __iomem *hmu;
> +	);
>  
>  	/*
>  	 * RCH downstream port specific RAS register
> @@ -292,6 +295,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   unsigned long map_mask);
>  int cxl_map_device_regs(const struct cxl_register_map *map,
>  			struct cxl_device_regs *regs);
> +int cxl_map_hmu_regs(struct cxl_register_map *map, struct cxl_hmu_regs *regs);
>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
>  
>  enum cxl_regloc_type;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..71f5e9620137 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -67,6 +67,7 @@ enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_VIRT,
>  	CXL_REGLOC_RBI_MEMDEV,
>  	CXL_REGLOC_RBI_PMU,
> +	CXL_REGLOC_RBI_HMU,
>  	CXL_REGLOC_RBI_TYPES
>  };
>  
> diff --git a/drivers/cxl/hmu.h b/drivers/cxl/hmu.h
> new file mode 100644
> index 000000000000..c4798ed9764b
> --- /dev/null
> +++ b/drivers/cxl/hmu.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright(c) 2024 Huawei
> + * CXL Specification rev 3.2 Setion 8.2.8 (CHMU Register Interface)
> + */
> +#ifndef CXL_HMU_H
> +#define CXL_HMU_H
> +#include <linux/device.h>
> +
> +#define CXL_HMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */
> +struct cxl_hmu {
> +	struct device dev;
> +	void __iomem *base;
> +	int assoc_id;
> +	int index;
> +};
> +
> +#define to_cxl_hmu(dev) container_of(dev, struct cxl_hmu, dev)
> +struct cxl_hmu_regs;
> +int devm_cxl_hmu_add(struct device *parent, struct cxl_hmu_regs *regs,
> +		     int assoc_id, int idx);
> +
> +#endif
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..e89ea9d3f007 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -15,6 +15,7 @@
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> +#include "hmu.h"
>  #include "pmu.h"
>  
>  /**
> @@ -814,7 +815,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
> -	int i, rc, pmu_count;
> +	int i, rc, hmu_count, pmu_count;
>  	bool irq_avail;
>  
>  	/*
> @@ -938,6 +939,29 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		}
>  	}
>  
> +	hmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_HMU);
> +	for (i = 0; i < hmu_count; i++) {
> +		struct cxl_hmu_regs hmu_regs;
> +
> +		rc = cxl_find_regblock_instance(pdev, CXL_REGLOC_RBI_HMU, &map, i);
> +		if (rc) {
> +			dev_dbg(&pdev->dev, "Could not find HMU regblock\n");
> +			break;
> +		}
> +
> +		rc = cxl_map_hmu_regs(&map, &hmu_regs);
> +		if (rc) {
> +			dev_dbg(&pdev->dev, "Could not map HMU regs\n");
> +			break;
> +		}
> +
> +		rc = devm_cxl_hmu_add(cxlds->dev, &hmu_regs, cxlmd->id, i);
> +		if (rc) {
> +			dev_dbg(&pdev->dev, "Could not add HMU instance\n");
> +			break;
> +		}
> +	}
> +
>  	rc = cxl_event_config(host_bridge, mds, irq_avail);
>  	if (rc)
>  		return rc;
> -- 
> 2.43.0
> 

