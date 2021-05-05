Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F158C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 May 2021 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5A361222
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 May 2021 10:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhEEKZi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 May 2021 06:25:38 -0400
Received: from mail-db8eur05olkn2097.outbound.protection.outlook.com ([40.92.89.97]:21217
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhEEKZg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 May 2021 06:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRrnTleIikd159Vps3ignAGDoxvyb/KhJm/DE4FnQBNwfkkjh13tgZFAHHAHWlZhKZA8C3+x9/802Rlb8KCL0SlTCaYtk37aTm/Zll4MvYh6odfhu3WICTqjsSLDYLcnB/unA1jSZ8SGrZK+jXHyAtkHfUUt8aH2VM6VSmKK7hjGRTUh+KGXLBxmjuXMSkhACTE3Xm6THVr+Nswv0DGsORYrjLQ+mx9PS4hYf5DCdiLbe2DAuthbRX9Rd9SZVTMPKktU9KI3/doN8O2LIe0zBI6hKGomLurejaMANx+1D9/UbsCup5eEhXyXuA7Dtl+2t8I9v7aQzP5x3MLsBeYkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJxal/I82YEHUsPiZ4N/zcBXcIDnH8o7zxeY+I4EIv8=;
 b=XqZ6p3yJAxw9/5GA239oX5xdk/08RVWDqCIORb9yRBkCKXkJaD9XUBGpdrTYTcpPe43rcWZ3S8ggds38Iw2+khUWGG5em/yy1RKfKfp3OO1qUmr16W2FjyEmIPN0mmId4rpa41gWNljnOJJYBnxgtAmCMrds3yfG5NFFymAdA6gtzMXhtd6/FCPgdOQA+2cOMJ+tanc73zN3XnJlYM/YVBikuHQM4ef/RjKD1DyshH0KF7LyavU/IGkH0QZeoieAn1xlIQFYTRHiMHOcPEugUR4xKH9mw1vLOjSYQARHnIPNfn1mCCz3tbUsNJwUJRf/lvW95kvwQ/2Xqs5ppadRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR05FT026.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::51) by
 VI1EUR05HT102.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::100)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27; Wed, 5 May
 2021 10:24:38 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:fc12::43) by VI1EUR05FT026.mail.protection.outlook.com
 (2a01:111:e400:fc12::175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 10:24:38 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:BAB6BFFCAAE460C1EE0FD966D77287A495829F440E411E8C645E032C861A5CB4;UpperCasedChecksum:94CC6709E6C45DA1520E427D8938459DA01BEC556173663949FE737565F3EAB4;SizeAsReceived:8933;Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 10:24:38 +0000
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     peterz@infradead.org, mingo@redhat.com, joro@8bytes.org,
        Jon.Grimm@amd.com, amonakov@ispras.ru
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
From:   David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB2638BB0FCE2E312B3471BC7FC7599@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date:   Wed, 5 May 2021 11:24:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-TMN:  [1iV9f5vNuyVtcVzve2HaL8LVwxHRlOOc]
X-ClientProxiedBy: LO4P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::23) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <ed3237f2-e682-5f08-8c94-3c14a462c42e@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by LO4P123CA0072.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:153::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 10:24:37 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e2625db7-4d68-41ba-9abc-08d90faffc74
X-MS-TrafficTypeDiagnostic: VI1EUR05HT102:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAaOuzW05Ck8IUJoBfmldTL3PFAOiwEt8MO1Bm+vMTmanCuvde7hRabnCmH8qF/l1t1641OnU3rfhReckwsftQgJgU+fCogiTzyTqI8xPHSxQ1OMIAmOZzHUwErxgfaHDdrgkUJ1hAa9alHmp7xVJszKRZXHBiQxXmizk4aB+9/Xsjp0e05BDB+uanrBP+IyRbDWIDuPTEiITvKgcfptxfRo7zWe8XZ+S0ZdlmSnIXkg9pmzwaaPFhLhPE4pWucmAz8MKJrD9XEH2Jve28A4kp+ingxkBqo6HMDgJq3NrE00TZA8kTYr/gCfeOV2t4E+W3tCQah9gT208p7XTQBd1OIYO4W1Q4N9u1/A0Kt51ZjReQt5IUK3iwgkJn/dFpBEOHWO1fnBK2YHnDUa4csgcQ==
X-MS-Exchange-AntiSpam-MessageData: h3ASWrdWl/LKUIJAHEj1d+v2LH+1iICfyXK8a/ZcdGeTDmFSAgK4XsEucNZtKZ9zbx7Cs9cfWYmihPMBE+5BbzMtXF1WcJlktDqkh4zumqtqK5VCDc45G6MKTTH5Qb5ORfoaz1iSWFaHQOHRhneraQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2625db7-4d68-41ba-9abc-08d90faffc74
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 10:24:38.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT026.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT102
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, once more!

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
> 

Just as a final, sanity check I've loaded the same patched kernel 
5.11.0-16 on to an old AMD Athlon FX8350. So far, all seems in order: it 
loads IOMMUv1 and runs Ubuntu 21.04 without incident!

Much appreciate all your efforts, Suravee, Alex et al. Best regards.

-- 
David
