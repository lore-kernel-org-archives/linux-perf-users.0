Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20514C07E9B
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C9B61C97
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhGFNb2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:31:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:44110 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhGFNb2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 09:31:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="188794012"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="188794012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 06:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="457067082"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2021 06:28:48 -0700
Received: from [10.209.95.225] (kliang2-MOBL.ccr.corp.intel.com [10.209.95.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F1CA4580801;
        Tue,  6 Jul 2021 06:28:46 -0700 (PDT)
Subject: Re: [PATCH][next] perf/x86/intel/uncore: Fix integer overflow on 23
 bit left shift of a u32
To:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210706114553.28249-1-colin.king@canonical.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <010289fa-beea-857a-a42f-8a85b0d34dc8@linux.intel.com>
Date:   Tue, 6 Jul 2021 09:28:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706114553.28249-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 7/6/2021 7:45 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The u32 variable pci_dword is being masked with 0x1fffffff and then left
> shifted 23 places. The shift is a u32 operation,so a value of 0x200 or
> more in pci_dword will overflow the u32 and only the bottow 32 bits
> are assigned to addr. I don't believe this was the original intent.
> Fix this by casting pci_dword to a resource_size_t to ensure no
> overflow occurs.
> 
> Note that the mask and 12 bit left shift operation does not need this
> because the mask SNR_IMC_MMIO_MEM0_MASK and shift is always a 32 bit
> value.
> 
> Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
> Addresses-Coverity: ("Unintentional integer overflow")

Thanks for the fix.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   arch/x86/events/intel/uncore_snbep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 48419dad3b17..7518143850df 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4827,7 +4827,7 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
>   		return -ENODEV;
>   
>   	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
> -	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
> +	addr = ((resource_size_t)pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
>   
>   	pci_read_config_dword(pdev, mem_offset, &pci_dword);
>   	addr |= (pci_dword & SNR_IMC_MMIO_MEM0_MASK) << 12;
> 
