Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04214C4743D
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB59C61375
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhFHR2L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:28:11 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:40033
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232370AbhFHR2K (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 13:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZIPF8rb7D/Wm3WZF7E3NyAg0n3PTSYcmmib1b26mX0=;
 b=WKh9iJ3DNx/nTpFq8rmyYMdLb2PhVjyYzUFeKQHDwgdRS3T0bkCGGbZbqEfPJyheSTEFVuhFGSvZZJKEQo1orLttbwldVQoW3A8qAaGkub0QoWrXSvy2svT7E3tPYbXky4cnofQgsJyY6w81TqtlibV+v19mBW2ZZTKGd/jMWRI=
Received: from DB9PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:10:1d9::13)
 by AM0PR08MB3155.eurprd08.prod.outlook.com (2603:10a6:208:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 17:26:12 +0000
Received: from DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::9e) by DB9PR02CA0008.outlook.office365.com
 (2603:10a6:10:1d9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 17:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT017.mail.protection.outlook.com (10.152.20.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 17:26:12 +0000
Received: ("Tessian outbound a5ae8c02e74f:v93"); Tue, 08 Jun 2021 17:26:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 981f2c3df9386da8
X-CR-MTA-TID: 64aa7808
Received: from 96067d72eb86.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CB04D09F-03E4-4873-8832-9886E4473DF6.1;
        Tue, 08 Jun 2021 17:26:01 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 96067d72eb86.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Jun 2021 17:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrJTgjQYkmw+TMeaxvIkcbW5iOIjCghHMnbvfmCRnuWAZzzpOcPkyc0STs/bTytiQO6dYCWXQa3OLzFYm2ndpvSLnnTBPmzobXTinq8uKOB9caAGnOzoZHAb8G1t6NAfcPcck5rPgyBiuV/dbXoUuqWix0lFKyjsBo3eZID6JCijK9BaCsmw0BGM9O//J+ksK4HyRIPvom1QWjSAnMAoeoo9FLmPvXwf4TX5oNihuYPKXy6niyMAC6RmIo9aOKcvyaTJQTeTOcFFXcqiMai2LgXnfiNNWKCL3B0sy2cvrBKkAQ9wM682DINbxteso9J4ZAVbNPPC+BNBATRKL3bUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZIPF8rb7D/Wm3WZF7E3NyAg0n3PTSYcmmib1b26mX0=;
 b=OqX0QolY7jhkQrjKkc0J1Sgs66OC1SalrGAqwFCV2HQau3vnl8P0ZwkeOszv34LZ2JtNzsyaPxdKUVsHpVYpZ1nRFdNXm53DMFZIuxYfc9vvp91i3Sgh1kVmrQDV0LvZil0H9PH+oQQe3UB+3k+fZEilKETM+sJ21N9mqLNGDxGRv/g4pT/fgov+JEQtJaI41quK3MtGFnRe/FYi+CyCO3ycbfcbDiXiKdyzHfXL5S+lC0oDG208EOmkU/WE84nFVGg5wF3pXOY5xtq4O6jAKaT4upN2EwXT9jbwABOvT9zFiLKV9my/746Fd34jnNyiHE8x4aVK1+kIrFgqXS3pgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZIPF8rb7D/Wm3WZF7E3NyAg0n3PTSYcmmib1b26mX0=;
 b=WKh9iJ3DNx/nTpFq8rmyYMdLb2PhVjyYzUFeKQHDwgdRS3T0bkCGGbZbqEfPJyheSTEFVuhFGSvZZJKEQo1orLttbwldVQoW3A8qAaGkub0QoWrXSvy2svT7E3tPYbXky4cnofQgsJyY6w81TqtlibV+v19mBW2ZZTKGd/jMWRI=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com (2603:10a6:20b:29c::13)
 by AS8PR08MB6808.eurprd08.prod.outlook.com (2603:10a6:20b:39c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 17:25:58 +0000
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::c84d:9ace:170a:8754]) by AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::c84d:9ace:170a:8754%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 17:25:58 +0000
Subject: Re: [RFC PATCH v4 1/1] perf cs-etm: Split Coresight decode by aux
 records
To:     James Clark <james.clark@arm.com>, acme@kernel.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        leo.yan@linaro.org
Cc:     al.grant@arm.com, denik@chromium.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd@arm.com
References: <20210601130751.25750-1-james.clark@arm.com>
 <20210601130751.25750-2-james.clark@arm.com>
From:   Branislav Rankov <branislav.rankov@arm.com>
Message-ID: <c450449c-e805-cf69-5b67-12201c3561f2@arm.com>
Date:   Tue, 8 Jun 2021 18:25:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20210601130751.25750-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.99.251]
X-ClientProxiedBy: LO4P123CA0325.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::6) To AS8PR08MB6069.eurprd08.prod.outlook.com
 (2603:10a6:20b:29c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.47.24] (217.140.99.251) by LO4P123CA0325.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 17:25:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8780d5-a81b-40d0-c6dc-08d92aa2832c
X-MS-TrafficTypeDiagnostic: AS8PR08MB6808:|AM0PR08MB3155:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB31553CA6D261EC159D18DA7694379@AM0PR08MB3155.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:530;OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ey3Pa9B4A6R7XbDLzswTLEItfzO+oPpCNAL4tXiRFbRcyK4Fvu9IqKgD5DbFkoqgFJH3aE3rid5eOtyYvD8W2eTdzcNa7JhfQ+v8gsqYJilbKG1swTaagZWVH53xm/tRpT1fj5a7e88bd0CcsQ+XpJO9MYJetg+GQnbEunUMrFOp23zwofwBizfP/V4/rpDLe/x9Cf230NqGNLYAlOqiOyMt0Ot3YX3Te4Juk7ItwdaOtvTlupAGtHy76HWwNnfPgQpOUFCofuiDjm6nakTCdQ4Z1rV4Pd+Nlr4gUNoqozZsGG3PxVjpbmBk/IfDK199OnPUV+7KrgSAODPwuaLejjZu/PRQkjMkZ2PQUxqlRcqTpHOfEXCN4o2btAFOCu1CQiuu70LZHOmX7c5qmv+yrympdPWN4UalLt3RDlzAospDWt9t60zTrXOKiBwL39BBqwOCGYSbjt9YrYbhw+3VIs/X9jAllnfUZvOQ2Kut9nbwfj+zu+fgs7PoJxFyHGdK6aoIo5js20FS5f+fpFOY/HwwTZdjhtsFuLpNP4UI0rrCBKHPoQBd7XrWmV5t3njTaq75KUtJGrFN/XbJMuxtEuoVq10L54/k2J6Bkg3wXISZi1Oj285vLBMFyXqQw7SXWI6wBMa1FaMvg+XdyFeNxxoFPtLYXEvBlgI8sgpa2qdcdsOiUWp6fMLgtWTMS6qS2YNJoRCFEj6j5/hdP9DKJANKQS7mWkj1ctrCSlc1lx0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(4326008)(52116002)(31686004)(31696002)(7416002)(316002)(66476007)(86362001)(16576012)(36756003)(26005)(956004)(38100700002)(5660300002)(53546011)(66946007)(54906003)(186003)(2906002)(478600001)(30864003)(44832011)(8936002)(8676002)(38350700002)(6486002)(83380400001)(66556008)(16526019)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUorRG4zQmtDS2tGelFXdzl0U0RNcUFNVkZ4VGRONGRKcysrWVZXNnpUaGw2?=
 =?utf-8?B?a3FTblBXUjltK1FhL240Yk1Ld3prREVkcy93Nm9VY29GS3FmV1hNcWp3Rlpl?=
 =?utf-8?B?dVJJU296NHNEQldyMTM4MWhwcHBDUnA4RXBwNUVGNUg0L09FQUpwZlJpVjNu?=
 =?utf-8?B?NFE4U0ZoeHZ1YzBoNTkvbGdRTjNVckR4TWVROE80dUMrWmx3bWI0ZWZoanA2?=
 =?utf-8?B?WlJEQWx1RXlIWmhtYXBYZnJzOWhhYUFHVTRIa0lyMVdnTGh0eXZQb3kvSkF1?=
 =?utf-8?B?cU1QbFNUMlIrVng2azFxVGN4U3RlRnUreW5wdWlUK0hBYUZTRGg4UUx2SUxO?=
 =?utf-8?B?VUhUdEZrcUlka2h6eUNyZkdOd3NLT0luQUMzcDlwNWJkTk9EbzNreWFWd25h?=
 =?utf-8?B?OEs1UDRYZGZNTFdtSW50SHZyN0pWMUxzUUFmRGtrUGdsSG51ajRHVkpoaHZB?=
 =?utf-8?B?VVFIclRiYk1GSW9sYkF4NER0RWJCSS9nWXVoK29neFBBV1BrSnlvZXpQeUNK?=
 =?utf-8?B?R3hPb0RPY2hCcEZPRTdMUnluV3JzT0FwUkxsM0ZKdGJvbDFnREpjNXdkYlgx?=
 =?utf-8?B?eHZ4U3FERHBjRHpQRXliWVJZOVcxQy94ZmNvbExSSVVxeWM1RG4yRDd2RlNR?=
 =?utf-8?B?T1JaSXcvbUpOY0p5K1h1YVExbWdLNG1CVEhNRGk4WDViWFFhMjRGMXJYTGxB?=
 =?utf-8?B?N2FuTlRhamw4Snp3cTFuWXBYd1hMT0RROXFQWUMzY3JpRTlhQW1MWmNSZm1D?=
 =?utf-8?B?VmtFc2x1SVF4Q1loMFE2QnRFSmR4RnpLM2NJSXRQQzRTSnliYTJYRU1OTmdC?=
 =?utf-8?B?cUZRZi9JdzFzNTY2WmEvc1JIRkhzRFRta1hpbXZkTmcxYWhLZkJpMzVoRjdo?=
 =?utf-8?B?VzV0TVJyNXBnVmZ5M2xacmdwSzdtOVR1Y3p0emJiT1k1TFg2MWszSDBFSEs3?=
 =?utf-8?B?SEdJVThPZHlNbFdtVVk2VmxwZDg3c2lxUGdvUlluRnBycm1kK0gwWmc4azV1?=
 =?utf-8?B?Zk8rdWF6ZVdwL1o0dWlKS2RqMnl2NGhpUUhVVzR5M3JvTXovM2pQUklLWHF1?=
 =?utf-8?B?MUdkT3N2VnZOWWFFUnhnYytrNkxDM3BEenZpc1Jab3dFczM1enVqdlUzajEw?=
 =?utf-8?B?Z0lBMWFMRTlaVDdtQ2lJNUwwb2VZMmpTb3orRzVrVURpbm8zWEJkbUV5YzVE?=
 =?utf-8?B?ZVlCSjdXRkJaeU0yQTN2Y0xHMDRvVlFScnZGQlptREpvdUpUWlo2T09MYkJJ?=
 =?utf-8?B?VE1hb3Q1a2pkQjZpOHNibHlSVmRPNGtJaGk2V2w5aDAzMUxydEtHOU5qRy9n?=
 =?utf-8?B?MTBQRENVOEw4TDF6Sk9ldEJjYng1bDdQWWNXb0g0RHdvN29BQW9xNjZLSFdj?=
 =?utf-8?B?Nm1PcEZLVUEzdzhOOWtRa3VVUmlZOEkwQ0IzSWxZeDNKZ3JyMUpZT2hZc2E3?=
 =?utf-8?B?NnhDN3NCZGM0OVZzK1cxTnFLRmwvRkRJYTZDQitmYjZLVzBoS0gzOWlWK1ht?=
 =?utf-8?B?aXhVUU9FK3BJNUN3cldYV1RPaCtZSTY2a0t2dnY1Q2xiOEF4dzBrRElQVWdV?=
 =?utf-8?B?ZVVyM0hHM2JkRU16OGJnTGRmSFhKTEtoS0ptdGsyMDVYQ2Y1VEdBR0lIbXc2?=
 =?utf-8?B?UHZFb1lSVStZT2hJQUgvbVdCOEZRM0J5Ym81Q1ZuOTB0TC9CU0pvdHd6UWhP?=
 =?utf-8?B?QjdINjR2KzJVVkJQbi9GendnT294YlR6dk9zWFhtQk1FdTFCV1RlSXRsU0po?=
 =?utf-8?Q?NjxxIZ4mUBFUjMBH5y5B/2j0G5+zsDLLZHNJrrP?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6808
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 30d8e22d-b526-471e-6177-08d92aa279f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qhDmLjLoGVDE7j4i79ZhNUfqLEIjfcYNx+oaSbO8BDYz3+fV3CStBuvnQx6Y1FAroev7GrypfN45ZGqXw8s9jZbEVnkOZ/xEiGAldWm3vzicreuajWsffiL6PB2NV22/ND5YMnyaYD118pKUt/wtCjAcBgzh1o+2roaD1nb4gCT4SCc8B94YfqG2gGEKMzYwi2snMZvLpUD51S/Jr5TgZBR1FvsPU1Ik1XZJ0hZ329ZmAxkd/RVfIweuQfIGnn00YKEIdisSBOqykTFkZ59EnuJS1eTls0IES9IGZoXdVc+fztJfqGwZLaD3Z2AG1rR8huAelxTeNWRZDMejz/9gqzOQ/cNTo4GP3n/9uHgq6ETr27Xdp9p3nrUwAPqCLgSlC+C4axSPGMCp0XtUh6ppQUhfYhqggwFvTU0CPpGh8knXBb3s2/LbFPZgXhQF/Rky4VOAYI9fOXm8fJiG21SaFzUHmtKDDUjDhjIvJEAbgJalp+J1g7iBIF+JoGqCD8m42Wu1WQvqQm6Rah1q7H35Pd8fIxNUD1nrtEllU1ZweAwDLXHK7qkcaLh8T37e6760aSpFN9deUDkj1fqpRWopJcELQAGNgyCjXK5IvemOOyHEzctIYwRhKN9q/29CkHM4K0tz6o4B9IDJFQrgzLSeKh7z7DANbCRbPy4kbi0xKOGVeIbhizqfGsmrZF8Z+wU
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(16576012)(82310400003)(956004)(2616005)(336012)(8676002)(186003)(356005)(8936002)(31686004)(26005)(450100002)(478600001)(54906003)(47076005)(86362001)(36860700001)(31696002)(82740400003)(44832011)(5660300002)(36756003)(2906002)(16526019)(81166007)(30864003)(6486002)(70586007)(70206006)(83380400001)(4326008)(316002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 17:26:12.3324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8780d5-a81b-40d0-c6dc-08d92aa2832c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3155
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 6/1/21 2:07 PM, James Clark wrote:
> Populate the auxtrace queues using AUX records rather than whole
> auxtrace buffers.
> 
> This is similar to the auxtrace_queues__process_index() ->
> auxtrace_queues__add_indexed_event() flow where
> perf_session__peek_event() is used to read AUXTRACE events out of random
> positions in the file based on the auxtrace index.
> 
> Now there is a second pass using perf_session__peek_events() which loops
> over all PERF_RECORD_AUX events, finds the corresponding auxtrace
> buffer, and adds a fragment of that buffer to the auxtrace queues,
> rather than the whole buffer.
> 
> This is a completely new implementation compared to v1 and v2 of the
> patchset where significant modifications were made to the decoding flow,
> including saving all of the AUX records, and changing the point where
> decoding started. These changes had effects on the outcome of decoding,
> but with this implementation, the output of decoding is identical to
> perf/core, except in the case where decoding failed due to the issue
> that this change addresses. No changes to decoding were made, apart
> from populating the auxtrace queues.
> 
> Because the decoder is already reset between each auxtrace buffer,
> populating the queues with fragments of whole buffers based on AUX
> records has the same affect as resetting the decoder on the AUX record
> bounds during decode. But this approach only requires a change to one
> part of the whole flow, rather than many parts.
> 
> There is still one TODO about how buffers are found. Currently there is
> a plain loop as a search, but this could be improved with a binary
> search or keeping a record of which buffers have already been added and
> starting the search from the last used place. AUX records and buffers
> will come in similar orders in the file so the latter would be simpler
> and probably be good enough. But I'm looking for feedback about the
> approach as a whole before ironing out all of the details.
> 
> Other issues that were fixed by the previous patchsets such as fixing
> the case where the first aux record comes before the first MMAP record
> can now be fixed as completely independent issues.
> 
> Testing
> =======
> 
> Testing was done with the following script, to diff the decoding results
> between the patched and un-patched versions of perf:
> 
> 	#!/bin/bash
> 	set -ex
> 
> 	$1 script -i $3 $4 > split.script
> 	$2 script -i $3 $4 > default.script
> 
> 	diff split.script default.script | head -n 20
> 
> And it was run like this, with various itrace options depending on the
> quantity of synthesised events:
> 
> 	compare.sh ./perf-patched ./perf-default perf-per-cpu-2-threads.data --itrace=i100000ns
> 
> No changes in output were observed in the following scenarios:
> 
> * Simple per-cpu
> 	perf record -e cs_etm/@tmc_etr0/u top
> 
> * Per-thread, single thread
> 	perf record -e cs_etm/@tmc_etr0/u --per-thread ./threads_C
> 
> * Per-thread multiple threads (but only one thread collected data):
> 	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597
> 
> * Per-thread multiple threads (both threads collected data):
> 	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597
> 
> * Per-cpu explicit threads:
> 	perf record -e cs_etm/@tmc_etr0/u --pid 853,854
> 
> * System-wide (per-cpu):
>      perf record -e cs_etm/@tmc_etr0/u -a
> 
> * No data collected (no aux buffers)
> 	Can happen with any command when run for a short period
> 
> * Containing truncated records
> 	Can happen with any command
> 
> * Containing aux records with 0 size
> 	Can happen with any command
> 
> * Snapshot mode
> 	perf record -e cs_etm/@tmc_etr0/u -a --snapshot

I have tested this patchset with traces recorded with ETM strobing and ETR polling patches.
The traces have multiple records and have issues that this patch solves.
Without this patch, there would be decoding errors reported, while with this patch,
there are no decoding errors reported.
Configurations tested: system wide, cpu wide, per thread.
Actions tested: "perf inject -b"

> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 159 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 156 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 64536a6ed10a..053aad4b28cf 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2679,6 +2679,161 @@ static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
>   	return metadata;
>   }
>   
> +/**
> + * Puts a fragment of an auxtrace buffer into the auxtrace queues based
> + * on the bounds of aux_event, if it matches with the buffer that's at
> + * file_offset.
> + *
> + * Normally, whole auxtrace buffers would be added to the queue. But we
> + * want to reset the decoder for every PERF_RECORD_AUX event, and the decoder
> + * is reset across each buffer, so splitting the buffers up in advance has
> + * the same effect.
> + */
> +static int cs_etm__queue_aux_fragment(struct perf_session *session,
> +						off_t file_offset, size_t sz,
> +						struct perf_record_aux *aux_event,
> +						struct perf_sample *sample)
> +{
> +	int err;
> +	char buf[PERF_SAMPLE_MAX_SIZE];
> +	union perf_event *auxtrace_event_union;
> +	struct perf_record_auxtrace *auxtrace_event;
> +	union perf_event auxtrace_fragment;
> +	bool matchesCpuPid;
> +	__u64 aux_offset;
> +	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
> +						   struct cs_etm_auxtrace,
> +						   auxtrace);
> +
> +	/*
> +	 * There should be a PERF_RECORD_AUXTRACE event at the file_offset that we got
> +	 * from looping through the auxtrace index.
> +	 */
> +	err = perf_session__peek_event(session, file_offset, buf,
> +				       PERF_SAMPLE_MAX_SIZE, &auxtrace_event_union, NULL);
> +	if (err)
> +		return err;
> +	auxtrace_event = &auxtrace_event_union->auxtrace;
> +	if (auxtrace_event->header.type != PERF_RECORD_AUXTRACE)
> +		return -EINVAL;
> +
> +	if (auxtrace_event->header.size < sizeof(struct perf_record_auxtrace) ||
> +		auxtrace_event->header.size != sz) {
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * In per-thread mode, CPU is set to -1, but TID will be set instead.
> +	 * See auxtrace_mmap_params__set_idx()
> +	 */
> +	if (auxtrace_event->cpu == (__u32) -1)
> +		matchesCpuPid = auxtrace_event->tid == sample->tid;
> +	else
> +		matchesCpuPid = auxtrace_event->cpu == sample->cpu;
> +
> +	/*
> +	 * In snapshot/overwrite mode, the head points to the end of the buffer so aux_offset needs
> +	 * to have the size subtracted so it points to the beginning as in normal mode.
> +	 */
> +	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE)
> +		aux_offset = aux_event->aux_offset - aux_event->aux_size;
> +	else
> +		aux_offset = aux_event->aux_offset;
> +
> +	if (matchesCpuPid &&
> +	    aux_offset >= auxtrace_event->offset &&
> +	    aux_offset + aux_event->aux_size <= auxtrace_event->offset + auxtrace_event->size) {
> +		/*
> +		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
> +		 * based on the sizes of the aux event, and queue that fragment.
> +		 */
> +		auxtrace_fragment.auxtrace = *auxtrace_event;
> +		auxtrace_fragment.auxtrace.size = aux_event->aux_size;
> +		auxtrace_fragment.auxtrace.offset = aux_offset;
> +		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
> +		return auxtrace_queues__add_event(&etm->queues,
> +					       session,
> +					       &auxtrace_fragment,
> +					       file_offset,
> +					       NULL);
> +	}
> +
> +	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> +	return 1;
> +}
> +
> +static int cs_etm__queue_aux_records_cb(struct perf_session *session,
> +			     union perf_event *event, u64 offset __maybe_unused,
> +			     void *data __maybe_unused)
> +{
> +	struct perf_sample sample;
> +	int ret;
> +	struct auxtrace_index_entry *ent;
> +	struct auxtrace_index *auxtrace_index;
> +	struct evsel *evsel;
> +	size_t i;
> +	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
> +						   struct cs_etm_auxtrace,
> +						   auxtrace);
> +
> +	/* Don't care about any other events, we're only queuing buffers for AUX events */
> +	if (event->header.type != PERF_RECORD_AUX)
> +		return 0;
> +
> +	if (event->header.size < sizeof(struct perf_record_aux))
> +		return -EINVAL;
> +
> +	/* Truncated Aux records can have 0 size and shouldn't result in anything being queued. */
> +	if (!event->aux.aux_size)
> +		return 0;
> +
> +	/*
> +	 * Parse the sample, we need the sample_id_all data that comes after the event so that the
> +	 * CPU or PID can be matched to an AUXTRACE buffer's CPU or PID.
> +	 */
> +	evsel = evlist__event2evsel(session->evlist, event);
> +	evsel__parse_sample(evsel, event, &sample);
> +
> +	/*
> +	 * Loop throuch the auxtrace index to find the buffer that matches up with this
> +	 * aux event.
> +	 * TODO: binary search?
> +	 */
> +	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
> +		for (i = 0; i < auxtrace_index->nr; i++) {
> +			ent = &auxtrace_index->entries[i];
> +			ret = cs_etm__queue_aux_fragment(session, ent->file_offset,
> +							 ent->sz, &event->aux, &sample);
> +			if (!ret) {
> +				etm->data_queued = true;
> +				return 0;
> +			} else if (ret < 0) {
> +				/*
> +				 * Anything other than 1 is an error. Positive values are 'not
> +				 * found' we just want to go onto the next one in that case.
> +				 */
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * We would get here if there are no entries in the index (either no auxtrace buffers or
> +	 * no index). Fail silently as there is the possibility of queueing them in
> +	 * cs_etm__process_auxtrace_event() if etm->data_queued is still false;
> +	 *
> +	 * In that scenario, buffers will not be split by AUX records.
> +	 */
> +	return 0;
> +}
> +
> +static int cs_etm__queue_aux_records(struct perf_session *session)
> +{
> +	return perf_session__peek_events(session, session->header.data_offset,
> +					 session->header.data_size,
> +					 cs_etm__queue_aux_records_cb, NULL);
> +}
> +
>   int cs_etm__process_auxtrace_info(union perf_event *event,
>   				  struct perf_session *session)
>   {
> @@ -2879,12 +3034,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>   	if (err)
>   		goto err_delete_thread;
>   
> -	err = auxtrace_queues__process_index(&etm->queues, session);
> +	err = cs_etm__queue_aux_records(session);
>   	if (err)
>   		goto err_delete_thread;
>   
> -	etm->data_queued = etm->queues.populated;
> -
>   	return 0;
>   
>   err_delete_thread:
> 
