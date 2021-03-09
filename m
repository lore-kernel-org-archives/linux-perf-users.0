Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA9FC433E0
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Mar 2021 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901C164FBD
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Mar 2021 16:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCIQKs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:10:48 -0500
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:47361
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232045AbhCIQK0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Mar 2021 11:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ui1NQiH5i6eJxrttT7zBAxsFl91YM21iFanesnvK/A=;
 b=0Bg3xCCV9oZ/fqSc1m/4zgnTS6/XEj2vavxJJG4fMREUHV/xsufQFIwa/Q2pF3bh7Ld2+vre2Fd9rTVUDKsSV4zkSPbtH0FKWjxntPaxNUdPi4FM1MMCJyN9VqyVsSp9BBBdtR2HFMvzGXB1UPMRT1XxWe7AvcCKsZ0LII0rsms=
Received: from DB6PR0202CA0028.eurprd02.prod.outlook.com (2603:10a6:4:a5::14)
 by AS8PR08MB6870.eurprd08.prod.outlook.com (2603:10a6:20b:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 16:10:22 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::64) by DB6PR0202CA0028.outlook.office365.com
 (2603:10a6:4:a5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 16:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 16:10:22 +0000
Received: ("Tessian outbound 520e67c3dd94:v71"); Tue, 09 Mar 2021 16:10:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: facc64b67d69928f
X-CR-MTA-TID: 64aa7808
Received: from 1791efecf87f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 674DE847-79E6-45FF-BAA6-1E59392D91B4.1;
        Tue, 09 Mar 2021 16:10:09 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1791efecf87f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Mar 2021 16:10:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If9AOVKsBaPyvQ76UmeUOvrT3d3mCj8EI/mnleAblLcPH7TFQeI5DEBeDNRrQc3PVmyKAL2UekbCT6QqVWAHwf53IWmLQS3hzUAmuZk4UF6wKKYOZb3Vf6Uwi71vOvRI3kSCq6LzWUg7JCzRulmYTKoa5UQnFxHTVyqrJu1FOsR1gdvTDJPGSfHQoT/4US+cm/PpvE6vBL+zl+odbZgEX+b24coPFKq8+d6GrUVvzFl/AlmX/8xmlIKWxGLCAfOmElCY4fCYsg2QlzIUXlrvzgoFNwrwWbAXf0LzorBCV6b2Vr7hRFzIqqgyxE73sluY/2mZIPb/gTwKohpKXT/lYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ui1NQiH5i6eJxrttT7zBAxsFl91YM21iFanesnvK/A=;
 b=TtZou7V+0212+ihVECBApsx3iD3daT1C0mSBM7PIYFVeZoPkrSFOQFpci++BuEk7YiQMQNR2pcx1eKHqw8c83EpJ/k+bT2wscJR1rVVWGbd6C0T1XVrCyWlSQR+YttsZB7wxrkyA/7mtm4oTNqqyu04qQab/zqGmS4Avkht096ub7oA1Bevb7gA75A4B9P3kLnb2Yh3avVEMws0zx/XHSasXhnN5zVoE2y2AE3gW1h1k5Rip4W1SXG8ahl+fGizRSNtPSkjbNnBxGTBsudg1PoSDgfIMZLNr40b9QdsQSszW7nO4PToczSxtSlPyjJZEQohQA4SUkghYxrrTxE9/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ui1NQiH5i6eJxrttT7zBAxsFl91YM21iFanesnvK/A=;
 b=0Bg3xCCV9oZ/fqSc1m/4zgnTS6/XEj2vavxJJG4fMREUHV/xsufQFIwa/Q2pF3bh7Ld2+vre2Fd9rTVUDKsSV4zkSPbtH0FKWjxntPaxNUdPi4FM1MMCJyN9VqyVsSp9BBBdtR2HFMvzGXB1UPMRT1XxWe7AvcCKsZ0LII0rsms=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com (2603:10a6:20b:299::13)
 by AS8PR08MB6005.eurprd08.prod.outlook.com (2603:10a6:20b:298::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 16:10:04 +0000
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8]) by AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 16:10:04 +0000
Subject: Re: [PATCH RESEND WITH CCs v3 3/4] perf tools: enable
 dwarf_callchain_users on aarch64
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
 <20210304163255.10363-3-alexandre.truong@arm.com>
 <20210305115120.GA5478@leoy-ThinkPad-X240s>
 <20210305140714.GB5478@leoy-ThinkPad-X240s>
From:   Alexandre Truong <alexandre.truong@arm.com>
Message-ID: <0ef6a6b0-dc0b-5ef4-778f-c93645c44d9f@arm.com>
Date:   Tue, 9 Mar 2021 16:10:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210305140714.GB5478@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.99.251]
X-ClientProxiedBy: LO2P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::17) To AS8PR08MB6120.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.54.143] (217.140.99.251) by LO2P123CA0005.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 16:10:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 874de2a0-2a19-4de6-e494-08d8e315d7b1
X-MS-TrafficTypeDiagnostic: AS8PR08MB6005:|AS8PR08MB6870:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB687051281E20BE6533886D939C929@AS8PR08MB6870.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9ftMnIYU5S0soVeyumydHutfo7wkm8GmwX8e8S9ran75xBg2+BrKtXlK+vjr4ZjUlwsE7im7qiW6B7gKNzNqf0K/ffHLgXIkUcPZ0VTzTqm6d23Ac4mXi0V8ZlgrVk+XfIbTwzczq92g2qfl1I8v3IXYPuzynRdabPN5Ez6PccKJt+t9PShdzJbm8aU75VZSXEd8a+vtPcfjoqQZM8JJ6LZl8RJbHjxtur5jU1pgebAXPtLcGhUjvhrp0PCYRZ/1z7f0omc0LmMYbY407hD+GeGCdP8/3TeJygIWCqv6cvmixSLsaGsxhVmyIiGDfh9q8zMdxMBRI8P+0nx4zorkGYuMrLPMDUNezU2wr53YQi6O6DIZ3KISkceDgDsNakfVk4YQj0tfksG4Q7pyuknUb597ZrqIme8dcM/SflRAiC4bypxwhTqrUOL0G0iWcQtkWDMNdS7ol7nZjG7jYwOADh6wejhn9F8DK8FM/n5m1n/7wWgCARNgLV2UjskERqQ2F2KoLyRlZmCsaL4GECOePp4eyOlXk3k/53bB4s98qyTOtiHtmyv16d3wPfMQEqTemUtNuzM/A9v11PB2my+XoVnxho+5SB96oAhpbNV8FgI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(66476007)(66556008)(16576012)(8936002)(2906002)(6916009)(31686004)(44832011)(31696002)(36756003)(53546011)(26005)(86362001)(5660300002)(83380400001)(52116002)(66946007)(4326008)(478600001)(956004)(2616005)(7416002)(316002)(54906003)(6486002)(8676002)(186003)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OFRHN2tFVUJDb3c5dk55R0s0T2VDTmRsRnBhc05iUEdicm5MWWg0Mi9tZ3l5?=
 =?utf-8?B?RlY1OEpWS1QwT1NFNXlYRHdMN0pwM2ZYOFlleDc3a2NhQ0xSNDZXN2c2SGxz?=
 =?utf-8?B?YW01eE1iQW1lMm1oU1JCMmtZd1IzcXhZQ3B2cWNrNVFETXpOVGJKYTVCdkx5?=
 =?utf-8?B?TUVoQkRhdXM4bVNzenI0d2hUK1o0Nm5tZTJhMUw1UCtVblYwQ29QNksydU5p?=
 =?utf-8?B?Ui9sMjZVN04wcmNTbmlFSnczclZ5dDdhWTRCRlpoVEx3ME83SmxFb2NXSmtm?=
 =?utf-8?B?VkZ1Q1BuanRZcTQwK294VWhGRkhiMElweGRFMkRqbHRBOWZ2SVdHaUhoVjRl?=
 =?utf-8?B?dnVZZHhoc2lFV2tKZjN4anlVUUZLdW1hS0RzajdEWHAxSnlLTVFJSS9OSXdt?=
 =?utf-8?B?Um4rL2FnWC9FSXQ5RklOWFZrcVR6TGc0WHBTTmNlTlkrcDdjb0E3QkJ3UkpW?=
 =?utf-8?B?YmJNWnRUZW9yUGUyTVRWeVc4bDBhVUVJd2E4WjZtZUU0MitMenU0U25qOEJj?=
 =?utf-8?B?Qm1naEcrelZQeFNWNW9yWm1mMUtIalUrS0o3TlhkUDRYWlNLeG5KUWdyc3dK?=
 =?utf-8?B?OGZHVG1hTHRScFg4ODJ3cHZ6MWlJVDNnZHk4MWdDd05SUlBUSXoxcC9ZbTFr?=
 =?utf-8?B?ZTJTOFJpWnE3ai9BM25YQTg0aFZ6T0wwenBINGFGam42a1JBb2JQWjFZdzY5?=
 =?utf-8?B?MFc4SlRKU0xWTVFnbnZaeEpPUllSdmZvU0RDbjR4cTRzbWxUVklqK3BHbnlK?=
 =?utf-8?B?M2lOZmY2QWdKYW9ENWtUbDlCWGRQajVmK0RKak9KY1RmR0dLMWVGQ1JQeTRV?=
 =?utf-8?B?WWNEd3FoZkwzNWtOcUJLNjNOZ1k0Z3BFVVpCTDFBNU9tR2VGck5haHk1Rmg3?=
 =?utf-8?B?dU5hKytkZC9raXVGbUVEenJYcnRWeGt3WkZzUEJJQ0JSaWtXbE1OTEkzRCt0?=
 =?utf-8?B?UDhPT2tnTVlnRG1HM1R1bWY5d0xvMW1ubUY3UUFpLzVnbFFnUG1BelJsbE4y?=
 =?utf-8?B?aDhoYnR6NjBrQmpIaTFjSVZubjVtbmxLMy9WSk5nai9hN3FqYXl1dC9mbHNT?=
 =?utf-8?B?bzBGMVBPWmxINFpRS21FZExtajJ4MVZ4R3hrbWZITDlBdE5Id0EzTWxmUFlC?=
 =?utf-8?B?aDE4aFF2d1FQVk55L0ZUZ1Bib1NxdVkycmszNzB2WXhGQWg3dWxYY3NISU8z?=
 =?utf-8?B?MjVscU0wMyt2QW9zbTRHaEFYN1IvcHlvbTVrc3pvV3hnUy9Ub0E2cy9wbEZl?=
 =?utf-8?B?a2ZqdnZIbm1URHpqOWl2YTVuUDA5VjV2R2luSlJuQWhGMG9ZbzAxK01mUU9S?=
 =?utf-8?B?Q3V0N09Ba3NZOG5NTG9KRzc5UzBWZ3hMZ1hQL1pEUUEyVW9KWmtWK3lhOHN4?=
 =?utf-8?B?SXJnNjRuWkEwTlR5WXhLVnllVWZCUUhRUEtYZEZSbWxPUW5qOVJLUmRyTU9C?=
 =?utf-8?B?UzRSRzUyYyt3RWxTMHZxSXFnYmt1TkJDT2QxWFQ3NFU5UVE4cXhjVnFBbWdY?=
 =?utf-8?B?ZlYxd1RjWU5tNFlXRDNJYjBxdGFEOWdHb09NaUk2S002dnB6QXNiNi9xS3NI?=
 =?utf-8?B?eG1rL0tqK2JtenlIRFZhb0tuYnJmUGtYakpvK1lrVFcyRjRKakNiNTdnLzd3?=
 =?utf-8?B?ZC9WWWNyWTJwR09MZlhnem9ObEt6VGhjenB0VGJSUjBiSUIvbnN4THpEaGI5?=
 =?utf-8?B?RVBZVDhGNUN0WlNzcW5HTWtBQnhjK1NnbXgvTUJreDJyOUJjWjBlNXRObmFs?=
 =?utf-8?Q?Vh4aLTxBIzSZNEOkMIPQtTyR00KYAzIufkBZYcm?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6005
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7ef1893f-d643-43bf-4cfa-08d8e315cc9c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuxheiCH2CgKZt6O0tDB9I27QdOAgfOIWBgVbafHJHIRG+UH69H/t27d3ATOVB3ew9rkUO6MChX1VlMK+9l4xcMbKwQQB0Mo20KH1BHxB2/LZk0F6yOQI0vVVbotWha6jTfpsJpSxO/OL4dElbHrnSaokcIYwoO+QUk3jyBr1ypmGezzZyvD9nBUj9X9otyXSnYA0ziBo9l+H7dDS3+LY1FD+szNrPFk8Gs4ZmrKZ5WftcKsAX/eWhuDbHlqouEak7i2y+0sdCZ/PFWHhAU6pEnmSUsKdz5WCd+g6c1dxrjr3Ap87nxX2tSf0aYMFJZo3n9nFaNFubYc0xE3IdgIw+mO36q2LDfrgqbIT40GjMbh6jxrq+osj8zV53SHGS8bJiBSdU4s75qsZNfukGpKb230CdMqtjc1HVPNkaa0Ul/dZyMpnx2fvcZB4RyvG5D6u+UPlWirMdR4JttwfOBN2ossz/KDH7w8tOK/fkGiaVFdSodfHTzkzyVSy3zc4ZbnRKiHDxaBwM80Qe36EK7a8bUK50nxsKIZxXXMyetuElgzXWgExcosEh7R/TnUO8yQxohTlAlsBUbw2rMC5VBo2C81Je9zwZLScdJ+ol9tQrn+uw5Rj5Vt9Pc+WWpMPKS4RJ2IRqlbVspmXGJl3atwPafs49DD+YqA85CT9o7kGbHcg1kXjEAPnjAjzIgHLAlc
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(81166007)(336012)(44832011)(31696002)(4326008)(82310400003)(36860700001)(83380400001)(82740400003)(316002)(186003)(16526019)(36756003)(450100002)(16576012)(6862004)(26005)(6486002)(54906003)(5660300002)(86362001)(47076005)(356005)(53546011)(478600001)(70586007)(8676002)(31686004)(2906002)(2616005)(8936002)(70206006)(956004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 16:10:22.5383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874de2a0-2a19-4de6-e494-08d8e315d7b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6870
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

Thanks for your message, I'll apply your suggestion for the v4 of the patch=
.

Regards,

Alexandre

On 3/5/21 2:07 PM, Leo Yan wrote:
> On Fri, Mar 05, 2021 at 07:51:20PM +0800, Leo Yan wrote:
>
> [...]
>
>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>>> index 2a845d6cac09..93661a3eaeb1 100644
>>> --- a/tools/perf/builtin-report.c
>>> +++ b/tools/perf/builtin-report.c
>>> @@ -405,6 +405,10 @@ static int report__setup_sample_type(struct report=
 *rep)
>>>
>>>     callchain_param_setup(sample_type);
>>>
>>> +   if (callchain_param.record_mode =3D=3D CALLCHAIN_FP &&
>>> +                   strncmp(rep->session->header.env.arch, "aarch64", 7=
) =3D=3D 0)
>>> +           dwarf_callchain_users =3D true;
>>> +
>>
>> I don't have knowledge for dwarf or FP.
>>
>> This patch is suspicious for me that since it only fixes the issue for
>> "perf report" command, but it cannot support "perf script".
>>
>> I did a quick testing for "perf script" command with the test code from
>> patch 04, seems to me it cannot fix the fp omitting issue for
>> "perf script" command:
>>
>>    arm64_fp_test 11211  2282.355095:     176307 cycles:
>>                aaaac2e40740 f2+0x10 (/root/arm64_fp_test)
>>                aaaac2e4061c main+0xc (/root/arm64_fp_test)
>>                ffff961fbd24 __libc_start_main+0xe4 (/usr/lib/aarch64-lin=
ux-gnu/libc-2.28.so)
>>                aaaac2e4065c _start+0x34 (/root/arm64_fp_test)
>>
>> Could you check for this?  Thanks!
>
> Maybe we can consolidate the setting for the global variable
> "dwarf_callchain_users" with below change; this can help us to cover
> the tools for most cases.  I used the below change to replact patch
> 03, "perf report" and "perf script" both can work well with it.
>
> Please note, if you want to move forward with this way, it's better to
> use a saperate patch for firstly refactoring the function
> script__setup_sample_type() by using the general API
> callchain_param_setup() to replace the duplicate code pieces for
> callchain parameter setting up.
>
> After that, you could apply the reset change for adding new parameter
> "arch" for the function script__setup_sample_type().
>
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..ca2e8c9096ea 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1090,7 +1090,8 @@ static int process_attr(struct perf_tool *tool __ma=
ybe_unused,
>        * on events sample_type.
>        */
>       sample_type =3D evlist__combined_sample_type(*pevlist);
> -     callchain_param_setup(sample_type);
> +     callchain_param_setup(sample_type,
> +                           perf_env__arch((*pevlist)->env));
>       return 0;
>   }
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 5915f19cee55..c49212c135b2 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2250,7 +2250,8 @@ static int process_attr(struct perf_tool *tool, uni=
on perf_event *event,
>        * on events sample_type.
>        */
>       sample_type =3D evlist__combined_sample_type(evlist);
> -     callchain_param_setup(sample_type);
> +     callchain_param_setup(sample_type,
> +                           perf_env__arch((*pevlist)->env));
>
>       /* Enable fields for callchain entries */
>       if (symbol_conf.use_callchain &&
> @@ -3309,16 +3310,8 @@ static void script__setup_sample_type(struct perf_=
script *script)
>       struct perf_session *session =3D script->session;
>       u64 sample_type =3D evlist__combined_sample_type(session->evlist);
>
> -     if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
> -             if ((sample_type & PERF_SAMPLE_REGS_USER) &&
> -                 (sample_type & PERF_SAMPLE_STACK_USER)) {
> -                     callchain_param.record_mode =3D CALLCHAIN_DWARF;
> -                     dwarf_callchain_users =3D true;
> -             } else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
> -                     callchain_param.record_mode =3D CALLCHAIN_LBR;
> -             else
> -                     callchain_param.record_mode =3D CALLCHAIN_FP;
> -     }
> +     callchain_param_setup(sample_type,
> +                           perf_env__arch(session->machines.host.env));
>
>       if (script->stitch_lbr && (callchain_param.record_mode !=3D CALLCHA=
IN_LBR)) {
>               pr_warning("Can't find LBR callchain. Switch off --stitch-l=
br.\n"
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1b60985690bb..d9766b54cd1a 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1600,7 +1600,7 @@ void callchain_cursor_reset(struct callchain_cursor=
 *cursor)
>               map__zput(node->ms.map);
>   }
>
> -void callchain_param_setup(u64 sample_type)
> +void callchain_param_setup(u64 sample_type, const char *arch)
>   {
>       if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
>               if ((sample_type & PERF_SAMPLE_REGS_USER) &&
> @@ -1612,6 +1612,14 @@ void callchain_param_setup(u64 sample_type)
>               else
>                       callchain_param.record_mode =3D CALLCHAIN_FP;
>       }
> +
> +     /*
> +      * Fixup for arm64 due to the frame pointer was omitted for the
> +      * caller of the leaf frame.
> +      */
> +     if (callchain_param.record_mode =3D=3D CALLCHAIN_FP &&
> +         strncmp(arch, "arm64", 6) =3D=3D 0)
> +             dwarf_callchain_users =3D true;
>   }
>
>   static bool chain_match(struct callchain_list *base_chain,
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 77fba053c677..d95615daed73 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -300,7 +300,7 @@ int callchain_branch_counts(struct callchain_root *ro=
ot,
>                           u64 *branch_count, u64 *predicted_count,
>                           u64 *abort_count, u64 *cycles_count);
>
> -void callchain_param_setup(u64 sample_type);
> +void callchain_param_setup(u64 sample_type, const char *arch);
>
>   bool callchain_cnode_matched(struct callchain_node *base_cnode,
>                            struct callchain_node *pair_cnode);
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
