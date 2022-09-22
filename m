Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EDEECAAD8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 20:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIVUTr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIVUTq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 16:19:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E272C664;
        Thu, 22 Sep 2022 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877983; x=1695413983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b5ft8ILgepn/D+6bT0FCILWY6PPvdiWRmx8NwceK6oA=;
  b=ik0YXKglKJRpRIM3MOONi/Qhq8XMkiRLIFofWVnNdIUDtek+8V3E/9G3
   Rz9dOUQL25kzfPKOWOL3WR783Q+0VKrDsk4GuPKpACskxHliurCqKaXv8
   faD/Vjet42L8Mt+yT+EtSRb0+/ZKzN+zIvvGV4ysR7ELiNph05dkktT9v
   ErKYBaS3/NSxMMFrjYPilqUYhSL6cvdbeUNZTyTy0Ap+wpBPofYw3NeO+
   1QLigQrAh6ScItQQXQZT+niB9fhgOG5J4VXIaboshk4shesNAzSXc/zr0
   NQ+2PqGERytJRz55y4TvV0FZWLgohskJ0qnxW6tDAG6nzijTn/PVMRPFU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301298511"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301298511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:19:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="745530022"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.80.137]) ([10.212.80.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:19:42 -0700
Message-ID: <590441ff-df5c-b52a-2da3-4aa42f5ea3e9@intel.com>
Date:   Thu, 22 Sep 2022 13:19:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 1/4] cxl: Add function to count regblocks of a
 given type.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linuxarm@huawei.com
References: <20220824103617.21781-1-Jonathan.Cameron@huawei.com>
 <20220824103617.21781-2-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220824103617.21781-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 8/24/2022 3:36 AM, Jonathan Cameron wrote:
> Until the recently release CXL 3.0 specification, there
> was only ever one instance of any given register block pointed
> to by the Register Block Locator DVSEC. Now, the specification allows
> for multiple CXL PMU instances, each with their own register block.
>
> To enable this add an index parameter to cxl_find_regblock()
> and use that to implement cxl_count_regblock().
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/pci.c  |  2 +-
>   drivers/cxl/core/port.c |  2 +-
>   drivers/cxl/core/regs.c | 35 ++++++++++++++++++++++++++++++++---
>   drivers/cxl/cxl.h       |  3 ++-
>   drivers/cxl/pci.c       |  2 +-
>   5 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9240df53ed87..f29cdc9df330 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -49,7 +49,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>   				  &lnkcap))
>   		return 0;
>   
> -	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
>   	if (rc)
>   		dev_dbg(&port->dev, "failed to find component registers\n");
>   
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bffde862de0b..1629c7a4033f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1235,7 +1235,7 @@ static resource_size_t find_component_registers(struct device *dev)
>   
>   	pdev = to_pci_dev(dev);
>   
> -	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
>   	return cxl_regmap_to_base(pdev, &map);
>   }
>   
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 39a129c57d40..2f651211d120 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -262,6 +262,7 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
>    * @pdev: The CXL PCI device to enumerate.
>    * @type: Register Block Indicator id
>    * @map: Enumeration output, clobbered on error
> + * @index: Index into which particular instance of a regblock we want.
>    *
>    * Return: 0 if register block enumerated, negative error code otherwise
>    *
> @@ -269,9 +270,10 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
>    * by @type.
>    */
>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map)
> +		      struct cxl_register_map *map, int index)
>   {
>   	u32 regloc_size, regblocks;
> +	int instance = 0;
>   	int regloc, i;
>   
>   	map->block_offset = U64_MAX;
> @@ -294,11 +296,38 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   
>   		cxl_decode_regblock(reg_lo, reg_hi, map);
>   
> -		if (map->reg_type == type)
> -			return 0;
> +		if (map->reg_type == type) {
> +			if (index == instance)
> +				return 0;
> +			instance++;
> +		}
>   	}
>   
>   	map->block_offset = U64_MAX;
>   	return -ENODEV;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> +
> +/**
> + * cxl_count_regblock() - Count instances of a given regblock type.
> + * @pdev: The CXL PCI device to enumerate.
> + * @type: Register Block Indicator id
> + *
> + * Some regblocks may be repeated. Count how many instances.
> + *
> + * Return: count of matching regblocks.
> + */
> +int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
> +{
> +	struct cxl_register_map map;
> +	int rc, count = 0;
> +
> +	while (1) {
> +		rc = cxl_find_regblock(pdev, type, &map, count);
> +		if (rc)
> +			return count;
> +		count++;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
> +
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..5a1bcdbda654 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -216,8 +216,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>   			struct cxl_register_map *map);
>   
>   enum cxl_regloc_type;
> +int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map);
> +		      struct cxl_register_map *map, int index);
>   void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   				   resource_size_t length);
>   
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..1758380247ec 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -373,7 +373,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>   {
>   	int rc;
>   
> -	rc = cxl_find_regblock(pdev, type, map);
> +	rc = cxl_find_regblock(pdev, type, map, 0);
>   	if (rc)
>   		return rc;
>   
