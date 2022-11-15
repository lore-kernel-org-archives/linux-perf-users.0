Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61946C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Nov 2022 14:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiKOOD2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 09:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiKOOD1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Nov 2022 09:03:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACBDE6
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 06:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668521006; x=1700057006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RPbu3swbHFaUQZLSOODaEifCJwE1F70V+CzD0G+sBo4=;
  b=Ayxj2LVdejF0kFGVA/rOLUeo7eHEPAtVTWii0ljm2uYLO4wpbdOtBBpL
   891H95yRCUG/wMrOqxcwTUEsUMPyHQpL22tlVyJE00ACxnIPdp1HNJa3F
   f00hcL8gwFbO4HbAwZLGC+ux27qEIDRJACQ+3/H3oF03Nee4+IcJ0SJiy
   iMFUOtLBqKOQ/pn7NkW5ycBNHJ0Xiahl9kOFjhdmT/EmA/fKnAJ04qPn4
   QyGrWlL0iWFsgxordowTEHgfQKCy0FgIaKP/YqMVzZtMEGwPZUF9oPI4X
   p9XnE5FuhSSmPpc3/3wklLTtoWZmZE+pym1ygPeAEot4th/ykg28VdgDF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="376523237"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="376523237"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 06:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="589797164"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="589797164"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2022 06:03:20 -0800
Received: from [10.252.215.14] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 54F895805BF;
        Tue, 15 Nov 2022 06:03:19 -0800 (PST)
Message-ID: <3b41a36b-30f4-5d6a-bb59-5e694a8feed0@linux.intel.com>
Date:   Tue, 15 Nov 2022 09:03:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] perf/x86/intel/uncore: decrease reference count in error
 path
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        adrian.hunter@intel.com, peterz@infradead.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        alexander.antonov@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, yangyingliang@huawei.com
References: <20221115112515.53177-1-wangxiongfeng2@huawei.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221115112515.53177-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022-11-15 6:25 a.m., Xiongfeng Wang wrote:
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
>  arch/x86/events/intel/uncore_snbep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ed869443efb2..83fe3d80c9a7 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4469,6 +4469,7 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, SNR_ICX_MESH2IIO_MMAP_DID, dev))) {
>  		ret = pci_read_config_dword(dev, SNR_ICX_SAD_CONTROL_CFG, &sad_cfg);
>  		if (ret) {
> +			pci_dev_put(dev);
>  			ret = pcibios_err_to_errno(ret);
>  			break;
>  		}
> @@ -4476,6 +4477,7 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
>  		die = uncore_pcibus_to_dieid(dev->bus);
>  		stack_id = SAD_CONTROL_STACK_ID(sad_cfg);
>  		if (die < 0 || stack_id >= type->num_boxes) {
> +			pci_dev_put(dev);
>  			ret = -EPERM;
>  			break;
>  		}

I think the pci_dev_put() itself checks the NULL. So we may just need to
add one pci_dev_put() right before return ret;.

Thanks,
Kan
