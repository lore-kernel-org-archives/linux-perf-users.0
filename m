Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8DBC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Nov 2022 16:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiKOQZy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiKOQZx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Nov 2022 11:25:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11AF29359
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668529551; x=1700065551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6+ult5QnVacpxQBNhnKZo4EJcHUI/weGBDZpl/pvcDU=;
  b=cKi0UG4R68R8HyBDj6QdYXdC7Abx7jtM18j8eIo3ezGFsqI1MoONOY61
   sxh5h6VFGfmZiL0XoH4tPFcGhOFh/CyX35anoxhQOS/tw+DQHGUkRjoN1
   td6+I8/FZP0Tng3Q0lGxwigt344dGKjUKe4hTziW9s0WxtmEFyLc336g3
   mc+1Up+XnoSG+6CtJqnnIMVdnrWUEVrHRRnfZiTBc12cjm76nUeILSB0C
   3WmhqlBrwI9w78wroftVn6suZlYjllKi6WQ1c3NO5o61hr+j9uezt3jvS
   TbeKsxZwhRanJEaKzuVseCH6TMfbYH/BGpDZ7nmPANpE0QFVFlO+vNKmQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="376561974"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="376561974"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:25:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="884017058"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="884017058"
Received: from aantonov-mobl1.ger.corp.intel.com (HELO [10.252.34.78]) ([10.252.34.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:25:40 -0800
Message-ID: <3383249f-8ce1-e41f-c12d-484b24c8e061@linux.intel.com>
Date:   Tue, 15 Nov 2022 17:25:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] perf/x86/intel/uncore: decrease reference count in error
 path
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        adrian.hunter@intel.com, peterz@infradead.org, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        acme@kernel.org, jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, yangyingliang@huawei.com
References: <20221115112515.53177-1-wangxiongfeng2@huawei.com>
Content-Language: en-US
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
In-Reply-To: <20221115112515.53177-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 11/15/2022 12:25 PM, Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev, and also decrease the reference count for the input parameter
> *from* if it is not NULL.
>
> If we break the loop in sad_cfg_iio_topology() with 'dev' not NULL. We
> need to use pci_dev_put() to decrease the reference count. Let's add it.
>
> Fixes: c1777be3646b ("perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>   arch/x86/events/intel/uncore_snbep.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ed869443efb2..83fe3d80c9a7 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4469,6 +4469,7 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
>   	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, SNR_ICX_MESH2IIO_MMAP_DID, dev))) {
>   		ret = pci_read_config_dword(dev, SNR_ICX_SAD_CONTROL_CFG, &sad_cfg);
>   		if (ret) {
> +			pci_dev_put(dev);
>   			ret = pcibios_err_to_errno(ret);
>   			break;
>   		}
> @@ -4476,6 +4477,7 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
>   		die = uncore_pcibus_to_dieid(dev->bus);
>   		stack_id = SAD_CONTROL_STACK_ID(sad_cfg);
>   		if (die < 0 || stack_id >= type->num_boxes) {
> +			pci_dev_put(dev);
>   			ret = -EPERM;
>   			break;
>   		}
Hi Xiongfeng,

Could you please update snr_uncore_mmio_map() and hswep_has_limit_sbox() 
as well?
pci_dev_put() is missed there also

Thanks,
Alexander
