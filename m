Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC71FC7CE
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Feb 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300703; cv=none; b=nbcInk+PP758NDhOWQuXXTRFiWBtotkVnkqekQ/MdBImb9q7rAXZbu5yJ+WWyf7jWBCRJOudCxRjpjSI5f9FJo2UbaKzpIhHPwhOtINiZmir+UvtHtIWrAf5w2UYH2rKhOK0EIiSD2g22c/vxvJJDoL2rbWaYXaKLASk0HlhwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300703; c=relaxed/simple;
	bh=umVkSvUGkkxTauK/pxEwPN78xMIveH6ByF2IWcrD6as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrtlycgPHEz4lg8Mr91aZruFGszClRkksBT/o9cCmkRV4VuhMOCGTmJpRfMheCN6Zu9AWdpz5FeJgPyC0IadSAQ1Ea+5bYa2X9khygkUnP22bJCblrCSqdJl5TjYYhFRk+1KGVqQ6tqzkexcYm67uGW6oDN/iEGBT+rOSAvaMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YH0bVki6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YH0bVki6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso72157615ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Feb 2025 00:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740300700; x=1740905500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XIm5BB1LEcTt9ZhK89dRkHFeWOjSTT1fKFwAkUk/sFk=;
        b=YH0bVki6sB3oXLTVnlvirAtTc2FaflK2q5vujrNrs3mgBElXdLzbjM7aG+H+2w8YPD
         1iaxphDkIe5oUyNoFmZiyNgCth4Wbef/wciDSsRIRu/vCMZLsKip0khCNl7ggDN1F0Sk
         C7GfKutjWzwbjE10MCjskl5JIVv2DuNdLpOXKIBWb2hUeWjrbFWNIbrzp1JwStRGFvv1
         bI7gvyPp5RosF+1co4yFaLPO9eREPiqw9sMWtU7Lz067zYy1biv4raKZINo7plbFhNRS
         Cnh54vSTkfjKuPCk+KXXFnVYyPxkZb1ok+JZ+SsvyJFnu86g2MGKVdaHcKgxPbgxHRUV
         K2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740300700; x=1740905500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIm5BB1LEcTt9ZhK89dRkHFeWOjSTT1fKFwAkUk/sFk=;
        b=KEys2k5hg2LMXI2XwbOKsHeAATKLxtNyAfvFlIl/XfZ9Cu9T6HZ/zNkepPDIeG3Kiz
         8hkNroLJ52aY65iv4t7o8Y4E8Utbo6GlDPYe/LWRCk0NWZEZLMFuNKqju6nC69bxHVD8
         kUksrX2EbkoEDXq2cxAS50OL8ZT+7F41CkV1EzMurvjdn0OobTR78p+TcGsI1VuQNVTe
         DH+ua/ip+3TWdGHsOyjMORH7wjlV5AZGIgrS+KFE4heAzzI16kzRTlLHkdYuT5HzcxVi
         7wxe2DK0euxRedf7mc6QJ5BAjAo51Y3ikvaKCYF3MRIppBloIPgAUjgEnayCdpcf5H2m
         l5uw==
X-Forwarded-Encrypted: i=1; AJvYcCXgQsGAq0BA48qnZs9zzMnSXokL6GvGqqq0lYMw16d0gp4K7Al0+ZRlukf/XzfhYnkeYPX1J9pqLKwmWczTaCSV@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVfFgc/w3WUIvpVyTaGPJCAxRWb66Kbb0MoG8uLodXx2aCL7N
	v2SREEKfeO78zoJSqrDOORb3tOKPcozFW5ZwOPJQDSAdKg1QpKgT4ZbWMVDw7w==
X-Gm-Gg: ASbGnctXmKjrolHN5Hm/gwDnHrG/4rH/6jQQFO86IWq7Hr3+lDYorhEgYBv2R/sfThS
	R9pRMwUC2amb1/oTwF/wE4Ch0nUHjgo/V0ldEPFhvhq94Rpt5bnBiHw+oBIcJhiRSAmteKr7WVl
	4igU9pzxuQaaF2m0/I9+7a8sYZslT3UENs8yIj5wfunk9/z9l6gfSQ3NgKl0+LBxOAaxHmRmO1M
	hkyL/oFbMN+Sk60+NM/Ofihz9K/ABNM7qL2zOrPeqHXLFZ59vR8RYmehbpGx6MSN3MSfVwOEnt2
	FZPszyA0P3qptrHdLxSIsHJ5HbfxNvJSKgefJZ8=
X-Google-Smtp-Source: AGHT+IHq0sGn3xeyBwz3ek21iZZA/kc/HnQSGVkeM0v6QVIzQYojTaCIpKnZZd6PCRI/Uu53/9SdKw==
X-Received: by 2002:a17:903:41c7:b0:220:f40c:71e9 with SMTP id d9443c01a7336-2219ff8288amr144157375ad.9.1740300700070;
        Sun, 23 Feb 2025 00:51:40 -0800 (PST)
Received: from thinkpad ([220.158.156.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325b03f169sm16417131b3a.63.2025.02.23.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 00:51:39 -0800 (PST)
Date: Sun, 23 Feb 2025 14:21:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@Huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250223085133.kjjx3ee4qe7m6z43@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221131548.59616-4-shradha.t@samsung.com>

On Fri, Feb 21, 2025 at 06:45:46PM +0530, Shradha Todi wrote:
> Add support to provide silicon debug interface to userspace. This set
> of debug registers are part of the RASDES feature present in DesignWare
> PCIe controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  13 ++
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 176 ++++++++++++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
>  .../pci/controller/dwc/pcie-designware-host.c |   6 +
>  drivers/pci/controller/dwc/pcie-designware.c  |   6 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  21 +++
>  include/linux/pcie-dwc.h                      |   2 +
>  9 files changed, 240 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> new file mode 100644
> index 000000000000..e8ed34e988ef
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -0,0 +1,13 @@
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
> +Date:		Feburary 2025
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Write the lane number to be checked for detection.	Read
> +		will return whether PHY indicates receiver detection on the
> +		selected lane. The default selected lane is Lane0.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
> +Date:		Feburary 2025
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Write the lane number to be checked as valid or invalid. Read
> +		will return the status of PIPE RXVALID signal of the selected lane.
> +		The default selected lane is Lane0.
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..48a10428a492 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -6,6 +6,16 @@ menu "DesignWare-based PCIe controllers"
>  config PCIE_DW
>  	bool
>  
> +config PCIE_DW_DEBUGFS
> +	default y
> +	depends on DEBUG_FS
> +	depends on PCIE_DW_HOST || PCIE_DW_EP
> +	bool "DWC PCIe debugfs entries"
> +	help
> +	  Enables debugfs entries for the DW PCIe Controller. These entries
> +	  provide all debug features related to DW controller including the RAS
> +	  DES features to help in debug, error injection and statistical counters.
> +
>  config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a8308d9ea986..54565eedc52c 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> +obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> new file mode 100644
> index 000000000000..3887a6996706
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2025 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "pcie-designware.h"
> +
> +#define SD_STATUS_L1LANE_REG		0xb0
> +#define PIPE_RXVALID			BIT(18)
> +#define PIPE_DETECT_LANE		BIT(17)
> +#define LANE_SELECT			GENMASK(3, 0)
> +
> +#define DWC_DEBUGFS_BUF_MAX		128
> +
> +/**
> + * struct dwc_pcie_rasdes_info - Stores controller common information
> + * @ras_cap_offset: RAS DES vendor specific extended capability offset
> + * @reg_event_lock: Mutex used for RASDES shadow event registers
> + *
> + * Any parameter constant to all files of the debugfs hierarchy for a single controller
> + * will be stored in this struct. It is allocated and assigned to controller specific
> + * struct dw_pcie during initialization.
> + */
> +struct dwc_pcie_rasdes_info {
> +	u32 ras_cap_offset;
> +	struct mutex reg_event_lock;
> +};
> +
> +static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t pos;
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> +	val = FIELD_GET(PIPE_DETECT_LANE, val);
> +	if (val)
> +		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane Detected\n");
> +	else
> +		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane Undetected\n");
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> +}
> +
> +static ssize_t lane_detect_write(struct file *file, const char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	u32 lane, val;
> +
> +	val = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (val)
> +		return val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> +	val &= ~(LANE_SELECT);
> +	val |= FIELD_PREP(LANE_SELECT, lane);
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
> +
> +	return count;
> +}
> +
> +static ssize_t rx_valid_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t pos;
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> +	val = FIELD_GET(PIPE_RXVALID, val);
> +	if (val)
> +		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "RX Valid\n");
> +	else
> +		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "RX Invalid\n");
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> +}
> +
> +static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	return lane_detect_write(file, buf, count, ppos);
> +}
> +
> +#define dwc_debugfs_create(name)			\
> +debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
> +			&dbg_ ## name ## _fops)
> +
> +#define DWC_DEBUGFS_FOPS(name)					\
> +static const struct file_operations dbg_ ## name ## _fops = {	\
> +	.open = simple_open,				\
> +	.read = name ## _read,				\
> +	.write = name ## _write				\
> +}
> +
> +DWC_DEBUGFS_FOPS(lane_detect);
> +DWC_DEBUGFS_FOPS(rx_valid);
> +
> +static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +
> +	mutex_destroy(&rinfo->reg_event_lock);
> +}
> +
> +static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> +{
> +	struct dentry *rasdes_debug;
> +	struct dwc_pcie_rasdes_info *rasdes_info;
> +	struct device *dev = pci->dev;
> +	int ras_cap;
> +
> +	ras_cap = dw_pcie_find_rasdes_capability(pci);
> +	if (!ras_cap) {
> +		dev_dbg(dev, "no RASDES capability available\n");
> +		return -ENODEV;
> +	}
> +
> +	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
> +	if (!rasdes_info)
> +		return -ENOMEM;
> +
> +	/* Create subdirectories for Debug, Error injection, Statistics */
> +	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
> +
> +	mutex_init(&rasdes_info->reg_event_lock);
> +	rasdes_info->ras_cap_offset = ras_cap;
> +	pci->debugfs->rasdes_info = rasdes_info;
> +
> +	/* Create debugfs files for Debug subdirectory */
> +	dwc_debugfs_create(lane_detect);
> +	dwc_debugfs_create(rx_valid);
> +
> +	return 0;
> +}
> +
> +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	debugfs_remove_recursive(pci->debugfs->debug_dir);
> +}
> +
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +{
> +	char dirname[DWC_DEBUGFS_BUF_MAX];
> +	struct device *dev = pci->dev;
> +	struct debugfs_info *debugfs;
> +	struct dentry *dir;
> +	int ret;
> +
> +	/* Create main directory for each platform driver */
> +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> +	dir = debugfs_create_dir(dirname, NULL);
> +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> +	if (!debugfs)
> +		return -ENOMEM;
> +
> +	debugfs->debug_dir = dir;
> +	pci->debugfs = debugfs;
> +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> +	if (ret)
> +		dev_dbg(dev, "RASDES debugfs init failed\n");
> +
> +	return 0;
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 72418160e658..f9d7f3f989ad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -814,6 +814,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> +	dwc_pcie_debugfs_deinit(pci);
>  	dw_pcie_edma_remove(pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
> @@ -989,6 +990,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  
>  	dw_pcie_ep_init_non_sticky_registers(pci);
>  
> +	ret = dwc_pcie_debugfs_init(pci);
> +	if (ret)
> +		goto err_remove_edma;
> +
>  	return 0;
>  
>  err_remove_edma:
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7..2081e8c72d12 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -548,6 +548,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pp->ops->post_init)
>  		pp->ops->post_init(pp);
>  
> +	ret = dwc_pcie_debugfs_init(pci);
> +	if (ret)
> +		goto err_stop_link;
> +
>  	return 0;
>  
>  err_stop_link:
> @@ -572,6 +576,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
> +	dwc_pcie_debugfs_deinit(pci);
> +
>  	pci_stop_root_bus(pp->bridge->bus);
>  	pci_remove_root_bus(pp->bridge->bus);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index a7c0671c6715..3d1d95d9e380 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -323,6 +323,12 @@ static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
>  	return 0;
>  }
>  
> +u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci)
> +{
> +	return dw_pcie_find_vsec_capability(pci, dwc_pcie_rasdes_vsec_ids);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_rasdes_capability);
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 501d9ddfea16..7f9807d4e5de 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -437,6 +437,11 @@ struct dw_pcie_ops {
>  	void	(*stop_link)(struct dw_pcie *pcie);
>  };
>  
> +struct debugfs_info {
> +	struct dentry		*debug_dir;
> +	void			*rasdes_info;
> +};
> +
>  struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
> @@ -465,6 +470,7 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	struct debugfs_info	*debugfs;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> @@ -478,6 +484,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> @@ -806,4 +813,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
>  	return NULL;
>  }
>  #endif
> +
> +#ifdef CONFIG_PCIE_DW_DEBUGFS
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci);
> +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
> +#else
> +static inline int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +{
> +	return 0;
> +}
> +static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
> +{
> +}
> +#endif
> +
>  #endif /* _PCIE_DESIGNWARE_H */
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 40f3545731c8..6436e7fadc75 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h
> @@ -28,6 +28,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{ .vendor_id = PCI_VENDOR_ID_QCOM,
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{} /* terminator */
>  };
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
