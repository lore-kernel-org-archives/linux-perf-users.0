Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3BC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 09:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiKQJPo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 04:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbiKQJPl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 04:15:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316F5DB89
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 01:15:40 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCZ4q2KJ3zHvqK;
        Thu, 17 Nov 2022 17:15:07 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 17:15:38 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 17:15:38 +0800
Subject: Re: [PATCH v3 0/4] perf/x86/intel/uncore: Fix PCI device reference
 count leak
To:     <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <ak@linux.intel.com>, <kan.liang@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>,
        <alexander.antonov@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20221117084327.192058-1-wangxiongfeng2@huawei.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <047bbef4-b7b7-fce7-6242-07bc0cb016ae@huawei.com>
Date:   Thu, 17 Nov 2022 17:15:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221117084327.192058-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sorry, I find a problem in this patchset. The modification of the first patch
should be
   pci_dev_put(dev);
rather than
  pci_dev_put(pdev);

Please ignore this patchset. I will send another version.

Thanks,
Xiongfeng

On 2022/11/17 16:43, Xiongfeng Wang wrote:
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
>   
> 
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
>  arch/x86/events/intel/uncore_snb.c   |  3 +++
>  arch/x86/events/intel/uncore_snbep.c | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
