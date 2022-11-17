Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6B4C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 13:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbiKQNXd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiKQNXc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 08:23:32 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C5FDFDC
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668691409; x=1700227409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5GkD8TfweDKYuSOBnnpRX0NGzNohW8TZlHLdlGebHNA=;
  b=QmEYBPx+VnJwJNxtP/0OHeOdaa7UWBmSrjqV6xkv1wufSU1OCn+oEUxa
   O6E5qiIj1000xiPnZauaItj/9Z7o2Ig1wKguCran4BjM320GFDJ+5PXyN
   qJM8CBrGlB+YgBI4zpYOT+Opyb9BeB0VvA4VYZoDdSa5Vsx324fYM1Qe4
   LbknjyCu/kR2kGzMETDSEMki7iSOxVvqvkueJNZwVtmJ4qGc1aOnKBkv9
   2Cajl8mSkbp5FGVJg8Z+iA52HY9G7vFRiGC949A4To6sSfIYMC0mTUF0H
   PQLB1s3mnALO3S66a7Ed35vQUryHThK/UNH0RwroPVC3LveHRgPyo2Bf7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="374979520"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="374979520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:23:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617608691"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="617608691"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2022 05:23:28 -0800
Received: from [10.252.215.146] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 94804580DFD;
        Thu, 17 Nov 2022 05:23:27 -0800 (PST)
Message-ID: <e2dabe13-d5f2-e1d8-f846-964e5cd3fa51@linux.intel.com>
Date:   Thu, 17 Nov 2022 08:23:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/4] perf/x86/intel/uncore: Fix reference count leak in
 hswep_has_limit_sbox()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        adrian.hunter@intel.com, peterz@infradead.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        alexander.antonov@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, yangyingliang@huawei.com
References: <20221117094336.10846-1-wangxiongfeng2@huawei.com>
 <20221117094336.10846-3-wangxiongfeng2@huawei.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221117094336.10846-3-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022-11-17 4:43 a.m., Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev. We need to call pci_dev_put() to decrease the reference count
> before exiting from hswep_has_limit_sbox(). Add pci_dev_put() for both
> normal and error path.
> 
> Fixes: 9d480158ee86 ("perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 76fedc8e12dd..3fc484045ed6 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -2891,8 +2891,12 @@ static bool hswep_has_limit_sbox(unsigned int device)
>  		return false;
>  
>  	pci_read_config_dword(dev, HSWEP_PCU_CAPID4_OFFET, &capid4);

I think we can move the pci_dev_put here to avoid patching it twice.

Thanks,
Kan

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
