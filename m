Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76C1C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 May 2021 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08616143D
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 May 2021 10:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhENKt3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 May 2021 06:49:29 -0400
Received: from mail-db8eur05olkn2021.outbound.protection.outlook.com ([40.92.89.21]:21171
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230252AbhENKt3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 May 2021 06:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEmwRkiuMY41rVAqE0Bc0nGXxHtLUd0uPxUItshm1kdBShV52LXZ3kQwQQ+CaFH4CIxIpzfSVv4yUBgEi7UeyeUVguLEVcv0ig/Zt/4qmjutdXH+t7RKvSTpsmAe2KOJ3cqE7gjaVFA2XgOIJwAfMlljShhwojGm3DJUhRBt2qnHhAXrnWLoch6k+DUWl2WxCriQRk+6WuZEFuS99smxLWHmdTMXzERV8Fsc75HQrFLSWF9yuaiYstd9gKQVNNiCMrHteNcBScNiUYRgTlZRY1/W75zT+Ky99HGftmrBFLYLj/3AEAwjrPnZ+Pef4dw+gyjHXGiCRxd5Ys1BOnWa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlWdtlo+FypS2Zk3mFhldbDdvnXg4Gfk8Qj71P6PhYQ=;
 b=E+BAKza30AS8PJogWVX+UnzyoTRL6Yyh41YHB97UgIe4mlSyXhcJ895h+m5m0ojzUc3FmPdeQeU2WXzuvbrNwN2AHQbITnGRBe5GeAPXnA7Rs+sM3WWavw+m5F0Z8GgFvCXOnOOxNLsbU2goIAAAk/q/W4MrLWazcIvpUNyhEv4+HOOCkXf5y+FQaX+r5TRAx7O56LAjJ8zQAYEjxdLbPjbHqoSi8e0gfe6SokqGeubcOH7AzVX+w0FBe5rV5scw9oCiMNJxwZhlgxm/AK5dQD0KfVNmcIRkHqX3+lykOKW+gvJooXZGRJTYOVlMi6MKOL22K0Q/5wDhmIAIyhiT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR05FT065.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::44) by
 DB8EUR05HT102.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::265)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 10:48:16 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:fc0f::52) by DB8EUR05FT065.mail.protection.outlook.com
 (2a01:111:e400:fc0f::306) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Fri, 14 May 2021 10:48:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:494C4CC1E45581E557C21C24BDAC31F0F01F678E1799F01FA66B6D87C3BDA475;UpperCasedChecksum:D7D6768C642716367C287FE8ED0771030FB51B6062058DDF7D047167705A672B;SizeAsReceived:8888;Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 10:48:16 +0000
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     peterz@infradead.org, mingo@redhat.com, joro@8bytes.org,
        Jon.Grimm@amd.com, amonakov@ispras.ru
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
From:   David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB2638EBA2A3A3DD752B9EAA9AC7509@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date:   Fri, 14 May 2021 11:48:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-TMN:  [JKNGssuhcnD8PkGRU3ruuFWnUl/BQ7S4]
X-ClientProxiedBy: LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::26) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <ef17bed3-cb62-ca0f-5ada-aa253909bc93@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 10:48:15 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 0b8950f9-03ba-476d-26b0-08d916c5c777
X-MS-TrafficTypeDiagnostic: DB8EUR05HT102:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnA/fh5bJpCbIuK+2Z0S3kcXZvqM72uMRZGzdlpofj2Ipsq8VUC02F7UpOOPe+8eY17Ork1HQwPvuqEHIINyX2ogTLZAAMo/fLdXJk1FF65JhmCT79gnJKN5VBfkX8NPQ5FhTFNwANT2ctXyYvSpz+6paFu8PQTk/zLuxR8U5CZ9LsM3G1c8xBxnkVBpSl6rnDGXz+opYP64s4OD3W5IMeu8/ouHNNgG6m/WiMS5jlnam9aQaWY5ZzXxOaUeF9Ax+B6vkCOoMVvGa5XZHLAvfam6VjjX3Eg+SncTgws035X0r+cTMXLSKpItp+cNcoeF1x7raR05y4+ZdrMnnO/o1p754DN6Y+Om82YHCWcTY5+jnlDpck4BtIzEccFh1eLHzpTH1TMiL1HWIKr2ZxmYAw==
X-MS-Exchange-AntiSpam-MessageData: Hd7XtJDGorWj6j7f3ADaER/cNMiOeqxryTqdhptzVQocfJ0clsDqjKl+KnW2DWkXsynRrxHp3OoCO1U2P1pQJAQcJSw7/4hMkhXaAZ/xNTOSeK/+BMeUKikqjvVuNZFIUES9CJEK5VPPryrMUvRTwQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8950f9-03ba-476d-26b0-08d916c5c777
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 10:48:16.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT065.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT102
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all!

On 04/05/2021 07:52, Suravee Suthikulpanit wrote:
> On certain AMD platforms, when the IOMMU performance counter source
> (csource) field is zero, power-gating for the counter is enabled, which
> prevents write access and returns zero for read access.
> 
> This can cause invalid perf result especially when event multiplexing
> is needed (i.e. more number of events than available counters) since
> the current logic keeps track of the previously read counter value,
> and subsequently re-program the counter to continue counting the event.
> With power-gating enabled, we cannot gurantee successful re-programming
> of the counter.
> 
> Workaround this issue by :
> 
> 1. Modifying the ordering of setting/reading counters and enabing/
>     disabling csources to only access the counter when the csource
>     is set to non-zero.
> 
> 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
>     can be simplified to always start counting with value zero,
>     and accumulate the counter value when stopping without the need
>     to keep track and reprogram the counter with the previously read
>     counter value.
> 
> This has been tested on systems with and without power-gating.

I've just noticed kernel-5.13-rc1 includes your full iommu enchilada. A 
quick test with Ubuntu's mainline ppa debs (and a home-spun perf)gives 
on a Ryzen 2400G what seem very satisfactory results. Bravo!

  Performance counter stats for 'system wide':

                  0       amd_iommu_0/cmd_processed/           (33.32%)
                  0       amd_iommu_0/cmd_processed_inv/       (33.34%)
                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/    (33.38%)
                615       amd_iommu_0/int_dte_hit/             (33.44%)
                  5       amd_iommu_0/int_dte_mis/             (33.44%)
              1,347       amd_iommu_0/mem_dte_hit/             (33.46%)
             19,127       amd_iommu_0/mem_dte_mis/             (33.44%)
                 71       amd_iommu_0/mem_iommu_tlb_pde_hit/   (33.43%)
                754       amd_iommu_0/mem_iommu_tlb_pde_mis/   (33.41%)
              1,777       amd_iommu_0/mem_iommu_tlb_pte_hit/   (33.36%)
             20,163       amd_iommu_0/mem_iommu_tlb_pte_mis/   (33.32%)
                  0       amd_iommu_0/mem_pass_excl/           (33.25%)
                  0       amd_iommu_0/mem_pass_pretrans/       (33.28%)
             27,283       amd_iommu_0/mem_pass_untrans/        (33.27%)
                  0       amd_iommu_0/mem_target_abort/        (33.29%)
                645       amd_iommu_0/mem_trans_total/         (33.32%)
                  0       amd_iommu_0/page_tbl_read_gst/       (33.28%)
                183       amd_iommu_0/page_tbl_read_nst/       (33.30%)
                 45       amd_iommu_0/page_tbl_read_tot/       (33.30%)
                  0       amd_iommu_0/smi_blk/                 (33.32%)
                  0       amd_iommu_0/smi_recv/                (33.28%)
                  0       amd_iommu_0/tlb_inv/                 (33.27%)
                  0       amd_iommu_0/vapic_int_guest/         (33.28%)
                613       amd_iommu_0/vapic_int_non_guest/     (33.26%)

        9.998673791 seconds time elapsed

Running Windows 10 & etc under QEMU/KVM produces nothing untoward. 
Again, congratulations and many thanks.

-- 
David
