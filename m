Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE3C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 13:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiKQN2A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiKQN17 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 08:27:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EAD5A6C1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668691676; x=1700227676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wc3U9KLFAtf2/OGX95AllefU2cUf9I1rAojfHsbkOHs=;
  b=khAwndOwhvRd05f0Mq8Q4ay9rWRyLJ0ETClzPFkMLpky5f+9hydcJvXo
   /ylP9mrAuA1laZTx2MlEoJEBdH1dOkqfc4Z3zLzIkVR5O0uAIssFVOmfY
   ej5TMmgmkBgi1AJSQe6n3D2tlJvdTMgksSbjX1nxmfZJqoqlVIq1zM1XI
   o1jV/pP0dGngRSK23NCagGx9d23T3EaVIBPkgjGrU64n/WMgcX9pWMNdx
   8O2I/xMuskOZXG6dt0Qronm5wcGQUtJbmarxXWW6Bg+HxS8jea8IGn3O0
   P1Ri6lNDaipY72Tun22HNnpwlJDxUBwLRfdrctWPnV/tA95zCBAgPy470
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="377114238"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="377114238"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884866057"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="884866057"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2022 05:27:39 -0800
Received: from [10.252.215.146] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A3DF0580DFD;
        Thu, 17 Nov 2022 05:27:38 -0800 (PST)
Message-ID: <1ca7d49a-c3c7-32b2-29ea-7e086c514b97@linux.intel.com>
Date:   Thu, 17 Nov 2022 08:27:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/4] perf/x86/intel/uncore: Fix reference count leak in
 snr_uncore_mmio_map()
Content-Language: en-US
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        adrian.hunter@intel.com, peterz@infradead.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        alexander.antonov@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, yangyingliang@huawei.com
References: <20221117094336.10846-1-wangxiongfeng2@huawei.com>
 <20221117094336.10846-4-wangxiongfeng2@huawei.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221117094336.10846-4-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022-11-17 4:43 a.m., Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev, so snr_uncore_get_mc_dev() will return a pci_dev with its
> reference count increased. We need to call pci_dev_put() to decrease the
> reference count before exiting from snr_uncore_mmio_map(). Add
> pci_dev_put() for both normal and error path.
> 
> Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 3fc484045ed6..0481f5135cb1 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4866,9 +4866,12 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,

Similar to the previous comments.
I think we can release the dev immediately once when we do not use it
anymore. So we don't need to patch it everywhere later.

Thanks,
Kan
>  	box->io_addr = ioremap(addr, type->mmio_map_size);
>  	if (!box->io_addr) {
>  		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
> +		pci_dev_put(pdev);
>  		return -EINVAL;
>  	}
>  
> +	pci_dev_put(pdev);
> +
>  	return 0;
>  }
>  
