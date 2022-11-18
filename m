Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501E4C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Nov 2022 12:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiKRMdz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiKRMdX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Nov 2022 07:33:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC1658A
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Nov 2022 04:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668774803; x=1700310803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=em8EYkj92uzaVM3J15vdZI09LN74a4rS7bAq6gGwuNE=;
  b=UV5baLzPtyoWZHR8y6MJZWLH9Cy4SWpNKilpWJIX0F6kX7BPbXzl9v9c
   ajYg5pN4Jlp17zyPz8YSZJ3xA1tVp0oFpUUYaBsxVJnTZEK+sDrZF/TWA
   1aG2/TlD0H6DTWvFx+BQisVhCW3j/RM8AG7LkO/l2TUFHupknuEGJZej3
   R5HYT5IYbs6/nryxY02Zv64YNiJdkliNZjdHU40W51cIrYo+Nzo7UAaiG
   qAYU1pSUWY/dzkZI+Ex3jV9oAllkytzb2PEqxpNIq0l10Bnhq2sRT/Umq
   KCEplCoUvKHa0vNEUCLbd+BWb3D7BsaC7iGglAQ/p2b60hWVBk8bF8nZ0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292826478"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="292826478"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 04:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="709019263"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="709019263"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2022 04:33:22 -0800
Received: from [10.252.215.84] (yinlu1-MOBL1.ccr.corp.intel.com [10.252.215.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5BAC0580A6C;
        Fri, 18 Nov 2022 04:33:21 -0800 (PST)
Message-ID: <9c74afc2-e349-881a-7326-31ddf00bf00c@linux.intel.com>
Date:   Fri, 18 Nov 2022 07:33:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 0/4] perf/x86/intel/uncore: Fix PCI device reference
 count leak
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        adrian.hunter@intel.com, peterz@infradead.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        alexander.antonov@linux.intel.com, acme@kernel.org,
        jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, yangyingliang@huawei.com
References: <20221118063137.121512-1-wangxiongfeng2@huawei.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20221118063137.121512-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022-11-18 1:31 a.m., Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev, and also decrease the reference count for the input parameter
> *from* if it is not NULL. We add missing pci_dev_put() to decrease the
> reference count.
> 
> 
> ChangeLog:
> v1->v2:
>   move pci_dev_put() to the last of function sad_cfg_iio_topology()
>   add fixes for snr_uncore_mmio_map(), hswep_has_limit_sbox() and __uncore_imc_init_box()
> v2->v3:
>   split one patch into several patches, one patch for one fix
> v3->v4:
>   change 'pci_dev_put(pdev)' to 'pci_dev_put(dev)' in the first patch
> v4->v5:
>   move the pci_dev_put() to avoid patching it twice

Thanks Xiongfeng. The series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> Xiongfeng Wang (4):
>   perf/x86/intel/uncore: Fix reference count leak in
>     sad_cfg_iio_topology()
>   perf/x86/intel/uncore: Fix reference count leak in
>     hswep_has_limit_sbox()
>   perf/x86/intel/uncore: Fix reference count leak in
>     snr_uncore_mmio_map()
>   perf/x86/intel/uncore: Fix reference count leak in
>     __uncore_imc_init_box()
> 
>  arch/x86/events/intel/uncore_snb.c   | 3 +++
>  arch/x86/events/intel/uncore_snbep.c | 5 +++++
>  2 files changed, 8 insertions(+)
> 
