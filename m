Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773FBC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jan 2022 13:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577378AbiAYNfN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:35:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:39167 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577394AbiAYNct (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jan 2022 08:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643117568; x=1674653568;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0OSQToNve8AbQwoEdsmgYoWhYAgTEagaBrN3UqMQWRo=;
  b=J54Hn0KtEuu3YAYvXtDThnk0OUchTNpwUNekojK8rSSaxYtEEjNNBTIu
   8zy6w47aFGYeLEy0ncUmUOhPldIzp3s+nrxzxZhxcpxMm9UPwNpP+5tTd
   t+dQNEpHtAphe0QiA0pznjXxKlkV9lPc8gaJGoLBn6bc7lfDucClIW4cV
   t5h1/QN5/EZTBPspcTob7xgXERXelCfYB4HW8J+ouxSzb5ikTPq5jipus
   gJJolFe6FYhErmmS+C2qzVd0zv3iChT09LyUtjJsV038/QNwUoTI6CtLH
   hiPsApXeJHYucjPxdWoV38zPJ7JWu5O/whCq18OHeC/uvcOJlZeRo8F3K
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246515339"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246515339"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 05:32:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="673989420"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2022 05:32:23 -0800
Received: from [10.209.56.163] (bdobabaa-mobl.amr.corp.intel.com [10.209.56.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 81816580921;
        Tue, 25 Jan 2022 05:32:23 -0800 (PST)
Message-ID: <5cd63492-db7f-2938-d290-b133a8cde411@linux.intel.com>
Date:   Tue, 25 Jan 2022 08:32:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] perf/x86: Add Intel Tiger Lake uncore support
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-perf-users@vger.kernel.org
References: <20220125074319.GA3211@kili>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220125074319.GA3211@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Dan

On 1/25/2022 2:43 AM, Dan Carpenter wrote:
> Hello Kan Liang,
> 
> The patch fdb64822443e: "perf/x86: Add Intel Tiger Lake uncore
> support" from Feb 6, 2020, leads to the following Smatch static
> checker warning:
> 
> 	arch/x86/events/intel/uncore_snb.c:1486 __uncore_imc_init_box()
> 	warn: cast after binop
> 
> arch/x86/events/intel/uncore_snb.c
>      1465 static void __uncore_imc_init_box(struct intel_uncore_box *box,
>      1466                                   unsigned int base_offset)
>      1467 {
>      1468         struct pci_dev *pdev = tgl_uncore_get_mc_dev();
>      1469         struct intel_uncore_pmu *pmu = box->pmu;
>      1470         struct intel_uncore_type *type = pmu->type;
>      1471         resource_size_t addr;
>      1472         u32 mch_bar;
>      1473
>      1474         if (!pdev) {
>      1475                 pr_warn("perf uncore: Cannot find matched IMC device.\n");
>      1476                 return;
>      1477         }
>      1478
>      1479         pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET, &mch_bar);
>      1480         /* MCHBAR is disabled */
>      1481         if (!(mch_bar & BIT(0))) {
>      1482                 pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
>      1483                 return;
>      1484         }
>      1485         mch_bar &= ~BIT(0);
> --> 1486         addr = (resource_size_t)(mch_bar + TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> All of these are 32 bit values.  If we really need a 64bit type, these
> will overflow before the cast to resource_size_t.  This code is 2 years
> old, so I suspect the cast is only required on line 1490 and that one is
> correct.
> 

Thanks for the report.

For 32bit system, I'm not sure whether it's OK to remove the 
resource_size_t for 1486?
Shouldn't we explicitly cast to resource_size_t for the possible 
overflow part for a 32bit system as below?

diff --git a/arch/x86/events/intel/uncore_snb.c 
b/arch/x86/events/intel/uncore_snb.c
index 36b6c20..fc6cfcb 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1720,7 +1720,7 @@ static void __uncore_imc_init_box(struct 
intel_uncore_box *box,
                 return;
         }
         mch_bar &= ~BIT(0);
-       addr = (resource_size_t)(mch_bar + 
TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);
+       addr = mch_bar + 
(resource_size_t)(TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);

  #ifdef CONFIG_PHYS_ADDR_T_64BIT
         pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, 
&mch_bar);

Thanks,
Kan

>      1487
>      1488 #ifdef CONFIG_PHYS_ADDR_T_64BIT
>      1489         pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, &mch_bar);
>      1490         addr |= ((resource_size_t)mch_bar << 32);
>      1491 #endif
>      1492
>      1493         addr += base_offset;
>      1494         box->io_addr = ioremap(addr, type->mmio_map_size);
>      1495         if (!box->io_addr)
>      1496                 pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
>      1497 }
> 
> regards,
> dan carpenter
