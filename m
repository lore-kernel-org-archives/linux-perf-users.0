Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F1C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 14:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiKPOW6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiKPOW5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 09:22:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E11F633
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 06:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668608576; x=1700144576;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g0Ng1Nz5C14f+QrpEDEgc3oC6CrygnRSGqw/WQvXgcQ=;
  b=jQEdfj42g+r30nlhlE2/KbItvtROPG0GV8tpWgI3jicpDYwFLwVkh40u
   paIswSpDaRcwoPBzAEpIUVBetX1OXBfYNhhlhl+Hvo2nTuA5EGPqk9VVj
   92spO75qaQGapTyJ8p854PX0wlJOddq5FI6VxNLojrDZaSFxfNSsTAcF0
   H9nUojnxCBv2yQ6xI1T3wK0hD6QGOSmte2lZsFC7LxGdU6EO2dAdjM9/E
   b+DKP9x2rbuNR8NXBMcANV5N9s4MogEvTxPOnrjsN67mB9hBmQSmrkn6T
   JBv6+vTiAdpcJl0EqceB9Aaf/ZNnROfou8lt+dDQA0awxjs/hKRhVyLaU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312560166"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312560166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="728387510"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="728387510"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 06:22:41 -0800
Received: from [10.252.208.247] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4FCB4580A5F;
        Wed, 16 Nov 2022 06:22:40 -0800 (PST)
Message-ID: <131e3878-6d48-d080-3d82-61dab10bc7cc@linux.intel.com>
Date:   Wed, 16 Nov 2022 09:22:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] perf/x86/intel/uncore: Fix reference count issues
Content-Language: en-US
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        adrian.hunter@intel.com, peterz@infradead.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        alexander.antonov@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, yangyingliang@huawei.com
References: <20221116111853.168539-1-wangxiongfeng2@huawei.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221116111853.168539-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022-11-16 6:18 a.m., Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev, and also decrease the reference count for the input parameter
> *from* if it is not NULL.
> 
> This commit fix the reference count issues in the following four
> functions:
>   sad_cfg_iio_topology()
>   snr_uncore_mmio_map()
>   hswep_has_limit_sbox()
>   __uncore_imc_init_box()
> 
> For sad_cfg_iio_topology(), if we break the loop with 'dev' not NULL, we
> need to use pci_dev_put() to decrease the reference count. Since
> pci_dev_put() can handle the NULL input parameter, we can add it just
> before 'return ret'.
> 
> For the other three functions, we add pci_dev_put() for both the normal
> case and the error case.
> 
> Fixes: c1777be3646b ("perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR")
> Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
> Fixes: 9d480158ee86 ("perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3")
> Fixes: fdb64822443e ("perf/x86: Add Intel Tiger Lake uncore support")

Can you please split the patch into several patches?
One patch for one fix.

Thanks,
Kan

> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
> Changelog:
> v1->v2:
>   1. move pci_dev_put() to the last of function sad_cfg_iio_topology()
>   2. add fixes for snr_uncore_mmio_map(), hswep_has_limit_sbox() and
>      __uncore_imc_init_box()
> 
>   *Note that* we also add pci_dev_put() for the normal case not only
>   error case for the above three functions.
> ---
>  arch/x86/events/intel/uncore_snb.c   |  3 +++
>  arch/x86/events/intel/uncore_snbep.c | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index 1ef4f7861e2e..1f4869227efb 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -1338,6 +1338,7 @@ static void __uncore_imc_init_box(struct intel_uncore_box *box,
>  	/* MCHBAR is disabled */
>  	if (!(mch_bar & BIT(0))) {
>  		pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
> +		pci_dev_put(pdev);
>  		return;
>  	}
>  	mch_bar &= ~BIT(0);
> @@ -1352,6 +1353,8 @@ static void __uncore_imc_init_box(struct intel_uncore_box *box,
>  	box->io_addr = ioremap(addr, type->mmio_map_size);
>  	if (!box->io_addr)
>  		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
> +
> +	pci_dev_put(pdev);
>  }
>  
>  static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ed869443efb2..0481f5135cb1 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -2891,8 +2891,12 @@ static bool hswep_has_limit_sbox(unsigned int device)
>  		return false;
>  
>  	pci_read_config_dword(dev, HSWEP_PCU_CAPID4_OFFET, &capid4);
> -	if (!hswep_get_chop(capid4))
> +	if (!hswep_get_chop(capid4)) {
> +		pci_dev_put(dev);
>  		return true;
> +	}
> +
> +	pci_dev_put(dev);
>  
>  	return false;
>  }
> @@ -4492,6 +4496,8 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
>  		type->topology = NULL;
>  	}
>  
> +	pci_dev_put(dev);
> +
>  	return ret;
>  }
>  
> @@ -4860,9 +4866,12 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
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
