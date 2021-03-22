Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67DCC433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Mar 2021 11:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB156619A2
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Mar 2021 11:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCVL6F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:58:05 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:48295
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230293AbhCVL5j (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Mar 2021 07:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R11O9cbTc4IuFUwF7UQ1Q8DCMACvWj5uOTC3mQgYdao=;
 b=L7LFIujr/cO6d15ZzBNvjXluuHque0ckbE8ewf3Yb8MGqoYF03ZT/NNJ2wJGERQ9A28VzNVUsrH6bahsboJCsfd0STV3zuFZijv9Gf5BAAuPZ+qNW9qYPCeNJ6uurqQD6lWQwBaGUIN0RGRfBZAat3EsNrS5CZe0vtwlDIB0G7M=
Received: from AM6PR10CA0038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::15)
 by HE1PR0801MB1897.eurprd08.prod.outlook.com (2603:10a6:3:4a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 11:57:34 +0000
Received: from VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::a7) by AM6PR10CA0038.outlook.office365.com
 (2603:10a6:209:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 11:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT035.mail.protection.outlook.com (10.152.18.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 11:57:34 +0000
Received: ("Tessian outbound 04b74cf98e3c:v87"); Mon, 22 Mar 2021 11:57:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c3c7125cb6313bea
X-CR-MTA-TID: 64aa7808
Received: from a3fcc302cfcf.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9367A101-AA0D-420C-9F4B-3FDA988E18FF.1;
        Mon, 22 Mar 2021 11:57:27 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a3fcc302cfcf.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 Mar 2021 11:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWDrAN2iiduoZJvtZZ5pqfeiPGTZMd+AO2FA6DTacy2kANPeXvbzqGwsdfi8BTCRuD0dNE8NHsvzHa3DFxUI5mu4uvLbOFw0/bYweFMWNzc4UglCbFzEGVcbt+pkH1ABW6PUHFlPwRNl8ZMhKKyA6xsJ9tF/fZndmkwEjY6g26cNYX3BphV7YmhEHtNvECqHQCVjk/qCPjFgybUmXGXXkEiya2z9H4TwgBXpsLIoJ9GrcMqdAe7dtQHha97km6l6EVh1LpBZdYGbXi0wcyMWzGT/bzlbKe63nDAI7axyLjjr8PQXMmqwRfMpd9yE2kDsdtAo/tLHuYechQP/wAwAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R11O9cbTc4IuFUwF7UQ1Q8DCMACvWj5uOTC3mQgYdao=;
 b=eFbrNO/cIIiJx0p4afujoFW05cukXILfkEEwllXZD4y4rn7Usd9XN/T9vGn3vEMBtHNO2WQxp24nW7RUU+d2fSHPu30GejqwXp4eSA7d7cLZSCSiGaQHvpiCpEvtchppxdYVwzmeOzk5Aoar0jHlhcfWr73fF2tkLmCP+cX8zSaKLk8IjqTo4bdYRfp06T3s63DIC+CadD2NKUDqWkKRlOa47GPhc6vIsy0/gxjrb0erWQxvGmZJzLhiCbgP4u6DuusJAJf1AL09LP7+ooRo6L4g6ByVhaRiOVhoBJOrHphSDY6D/Ow8HqjAGXyk6efNbQOv8UuFVX9Huq88EF1W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R11O9cbTc4IuFUwF7UQ1Q8DCMACvWj5uOTC3mQgYdao=;
 b=L7LFIujr/cO6d15ZzBNvjXluuHque0ckbE8ewf3Yb8MGqoYF03ZT/NNJ2wJGERQ9A28VzNVUsrH6bahsboJCsfd0STV3zuFZijv9Gf5BAAuPZ+qNW9qYPCeNJ6uurqQD6lWQwBaGUIN0RGRfBZAat3EsNrS5CZe0vtwlDIB0G7M=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com (2603:10a6:20b:299::13)
 by AS8PR08MB6663.eurprd08.prod.outlook.com (2603:10a6:20b:39b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 11:57:26 +0000
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8]) by AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 11:57:26 +0000
Subject: Re: [PATCH RESEND WITH CCs v3 4/4] perf tools: determine if LR is the
 return address
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Al Grant <al.grant@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
 <20210304163255.10363-4-alexandre.truong@arm.com>
 <57fdc0c9-ea72-5cd0-405a-c7bff0daf9d6@arm.com> <YEN7xFjj7n66A9Xr@kernel.org>
 <YEPTnwXLfwhJN5eT@kernel.org>
From:   Alexandre Truong <alexandre.truong@arm.com>
Message-ID: <9bf59035-1a2e-1593-0f0c-7cf06160ee34@arm.com>
Date:   Mon, 22 Mar 2021 11:57:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YEPTnwXLfwhJN5eT@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.99.251]
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To AS8PR08MB6120.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.24.23] (217.140.99.251) by SN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:805:ca::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 11:57:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc8f8f48-b7c1-4605-0f9c-08d8ed29ae17
X-MS-TrafficTypeDiagnostic: AS8PR08MB6663:|HE1PR0801MB1897:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB18977BAD5E30F60B5463C8FE9C659@HE1PR0801MB1897.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5j2Gbq7T3Dj3n9mIsVONUHtBVWQWnTCV54UjGTRCrE6/b6Y89onupLo0f/XIezET177tzu0oQLg0/GMzNtOlf1t1TuEsFaHSe7EHGybIAMY+72MIByIA3RUX7gey9nJnqKDo8ZtsgcKnVOcAfWdagF4iy+xC8jDKOJk5qWiTo3pZTRb4sWCh4TUJ7FdK+4lgEhqe/MDyZW5HvPywLOTHX1BEuEGqaU9BvZqEleES0F/SVVjLu/HBU8lrKzQC+gazqyFhAUFWpK5Fe6XQV0Fd5oXInUA26WpjqkUwaxNlpCE1aIvWEKqYUfUAb7IZSHV+1+jRU8XjrXPQ9Umwp+mKBfwE7GDg9SBpqGYVc1xxyAVXkLYDmVIfa2yQhohkru4BGDeA26neaZJ0UH1Q9+22F7SyUTXbqDbwUPHZs3gxfvpFdaOzkmYAK22HOLH1am8VNNdqgsdEFuin6tbwRehBJgJui7kWFZA6eY51i3L9MG65EPLBIPbctM8c0nna/GEUc5olIt0hZ+qqBwDqHQxY2isXT72wbgNFap10aWBqqFQ5cKChbg8JF6QYdNmaRpPtttJWC/FibPOc11RKRX5LF1WjQDhTWLM4gsnDKMYHUI+y4X/jFBmlXBMlEbh2KheJIKHS5sU4lIkzcE+gjLIGF+FBlDl6AU0k+hIA64oejysG4BnqGPuFB/3PZLOiBSixIK3Pevq57i2UesCFZrASKBiMo36LbhBE21LBS0CxQzPr3UFnYRnTnE3JjItWUCr+VjRGoaAvg8zUYLL4t0SJLyIvEwQQbw+sAxIKTETtWFezp/DclhknSKluq40UJGM/8I929ue6/au/exn93zPACA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(6019001)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(269900001)(52116002)(478600001)(66556008)(36756003)(86362001)(66946007)(83380400001)(38100700001)(66476007)(16526019)(30864003)(5660300002)(4326008)(6666004)(2616005)(8676002)(956004)(6486002)(53546011)(31696002)(316002)(110136005)(44832011)(186003)(16576012)(2906002)(7416002)(8936002)(31686004)(26005)(6636002)(54906003)(43740500002)(45980500001)(10721665004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUkzemJUMU94UWZjVk9uQ2cwdVowSmUrUjZyMHZVMlNHWGZjVWsxanJuZWNS?=
 =?utf-8?B?UTRKbWx5ancwczhsLzZWOE00MFJORVJuRVVCb3pvSzVWVjAzRzRoVkJ1SnB1?=
 =?utf-8?B?RFVIZ1FHUE1idmxlRTJJbGU0VmNqTUhKb3ZTK0MwcmRISVN5ZXo3Sm9Iampv?=
 =?utf-8?B?NzFDQjJRSUtLeUl3Zkc0NE1KejhBWDhVV054Q1BMV0h0WEJpSUZKL2FvMnpa?=
 =?utf-8?B?amsrSmVBeDROeG0zMEJwREZHdW51Sm9ncXVnc1JMWXdRaVZZT0pxOURyV2Ry?=
 =?utf-8?B?dDlzU2FSVUh0WE5SUENoblhhRmw0WHl4WnpVWkJLOVlERWJ6bWFJcGxPZTNl?=
 =?utf-8?B?RmF3Zll4TE5JMWJHL3drcTNmU3ZqY3drWUNOTHRsNkU2d0xEcTBvSG1VR3l2?=
 =?utf-8?B?Wm8xK1hjZnpzaXB0eWJaRXFoZTJrd2NvOUdWRStzb0xTZkpWY25wMjB2VmZ6?=
 =?utf-8?B?b1k2RFJrOXNDTkJPVjNPaTBEYWQ2WTlvaXFUMGxCZHhCblV4dUc0OFZHbXhp?=
 =?utf-8?B?S3pTYy9ZSjNvRnZaQkM0YTdzb3hpWEc2SStFaG5OcXNwQ085bVJxWWpxdW9T?=
 =?utf-8?B?M1FBWlg0cUpDU0hNeEFCck1CVmpMQnRKeUx0NUo3OTY1aHJLV2lYSGp4Y1ll?=
 =?utf-8?B?b1kvd01CcEs4WDQvYWlydFlPOVJieVJDUU9iN2hUOTVVcUM5b3Vodi80cXNt?=
 =?utf-8?B?MXRadlV0MVZjQVYxc3lERVhoNUdLaWFzSXRQMzVXL2M0M1BYTWxXeHN4VTBB?=
 =?utf-8?B?Q3RCbjJkQUU4K2NTQ1NYVmU1aXQ2MXA2OUFhQ3cxd1h5UUJCSTJsWGV3R0tI?=
 =?utf-8?B?NHdMelNxTkc5bCtJQ2FGWk96Q2MvY244N0tIRzM1aHZSSmxJVFpaUHFDcXNu?=
 =?utf-8?B?eElyMTg0OE9wQ0g0Qyt3SHVHVUVlbHVJQU9SU3k0RThyQi92VmMrVTM3dUVz?=
 =?utf-8?B?Nk02RVZRTURiSTYyWmptY1R3VWlydEN5MWlPSnVmMkhiaG00eEViN0ZrNXhY?=
 =?utf-8?B?M0tVY2lRZGplTlprcjVUMDhKWldsSjREMWhBT09pYjZMYUs1OWh4VVhIcGdx?=
 =?utf-8?B?VkgrcTdRZ2dJRXlIekZOcHhqeVVoVW0zM29YSUxSblBVQXNDZ05Wa0F6WjhE?=
 =?utf-8?B?NE9MckpscU9nc0oya1RicjJwMlNNOS9ha2lGTllmQ3JXK3JXVEF3U1ZrOXpP?=
 =?utf-8?B?T0ZTTWhjTlNzc004Q2UzRmwvRkc5UGlFSS9WaEZIVEpFREhEdHBUQ1dYUnRu?=
 =?utf-8?B?VUF2elplR1dSaVRhUktlamRxUitpOW9FQ3RLTXlyVHhUVE1kend5ZFZMdmQ1?=
 =?utf-8?B?eFF2RjlHOTN3dWROVmdNU2lyM2VtM3hrKzFHUzd5WnNrRXRPM1RXM1JXaHVz?=
 =?utf-8?B?ZlU1UjAyUjhSZG44UENPZDdLeXZGUmUrL24zUTgvcVlNRUxBSFBMTDJXUVlz?=
 =?utf-8?B?Wk1veERZcU9rdU44dWYrelRNZllOT1dtODluOGRjVzF2WnowdXJVOFEvN0tP?=
 =?utf-8?B?VHNVZWNISE15TVc4OGlHYVBkNDRobGxOS05BdWRFZkU5SnN6dHlIeFo3TGc3?=
 =?utf-8?B?cC9NeFN4TjJPeDZDMnliVWUyR2Z3MnR3cTdNbEpaUVNPV0ZlYy9YOUtYaHB3?=
 =?utf-8?B?WkdXQ3k2R3lmVm01TzVFTEcxdmtJQzNuaGQ4SVBDZWpKemtFeEdRcmVZRXFK?=
 =?utf-8?B?RXNERkl1eWdyYjJIRHBCcnJZZ2lDUU1MWUVBVm1OMlY3Qkl2WDNJRlBsajhn?=
 =?utf-8?Q?S994h7+D3lnyiNAIcop1Z2M3koGEDUbkZ0oGnX8?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6663
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: dbbda42d-0893-4ae7-23d0-08d8ed29a8fe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPuFAxMDbJjs1djXsxjSstyhV9GWWYBuawCwRc8R+cKcWSjW7HSU176+NRKgGZnOovKsiDoVl/oTwQ0UUgHMHfR7ShoPoyEIcoOECAvIiOPtcTUpPH2ujGpU8Ul6hFRx3xF71PiKsZ01VrJkUaQA7L709OqHn3yeUKTP6I4GOlS5HTDDX5/scrwbTsIcvoZ17LQZd2lbzldof3R2/OpGA4fCM6VhSBFKDmkIYZ4df26SXasqw8g8o2lgySFSOv/t8iRs/v30zjUCzYuFCjUPaFHIL3zVOwcc3pKA8AgSeFA4NbjoUSQBhNgLVfKWwDbi9g4LSEEzzFSR4aqrEjbVBDcc3mcs5qNaHhnu+PMrvE8lL8zrWeVv2pkyWBN3rnTejgLDRDml/+OubBrdE+kMERit0jHmZ2n8ap0fmnyTtq4FhmfZIpKPXedBW37aXwQzZZ456k1JXCo+UpGcmCE/fL8qbunkNP6mZLePccBGrxnXTZ2Ya5apIguSCnXpXeYVeBJrUqVaaPR5b0xHuC2C5dXDnTCpyD2rM/ZR3pJB8nbScf4GjqCMjXKr6W55ENTFq5ubd5ypPSEyAUhSK+7wQvcSzLUvIWohvgrmCAah252yphg/ZaXjJCiMlXJX3P+GNvc6wC51WD6uT7kS30xCyEsX5BpZdflP6azmVmOwT5HXdqtZTJlP8MlGibGjATWtt/nj//hhm0IL8VKRM9Twd6MBreKCBaUcMN02i54kZ1TAQMU1fuxFdao+7bI1Qu6+P2gRQ8O5EPGloi7h2mFvuXEMjmoBFJ8EmIQo0I4ibfE=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(6019001)(4636009)(39860400002)(396003)(136003)(376002)(346002)(269900001)(36840700001)(46966006)(16576012)(44832011)(4326008)(82310400003)(316002)(8676002)(82740400003)(36860700001)(450100002)(53546011)(30864003)(54906003)(47076005)(81166007)(110136005)(83380400001)(36756003)(6486002)(31686004)(356005)(16526019)(336012)(5660300002)(70586007)(6666004)(31696002)(186003)(6636002)(26005)(86362001)(478600001)(8936002)(70206006)(2906002)(2616005)(956004)(43740500002)(10721665004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 11:57:34.0723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8f8f48-b7c1-4605-0f9c-08d8ed29ae17
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1897
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

Thanks for your reply.

I profiled a few applications and here are the results.

---------------------------------------------------------------------------=
------------------------------------
             |                       |                                |    =
                                    |
     App     |   Before the patch    | With the patch (% of increase) | if =
only LR is recorded (% of increase) |
             |                       |                                |    =
                                    |
---------------------------------------------------------------------------=
------------------------------------
             |                       |                                |    =
                                    |
   firefox   | nb of samples: 834k   |   nb of samples: 685k (+70%)   |    =
   nb of samples: 671k (+10%)       |
             | size:          101 MB |   size:          141 MB        |    =
   size:          90 MB             |
---------------------------------------------------------------------------=
------------------------------------
             |                       |                                |    =
                                    |
     htop    | nb of samples: 500k   |   nb of samples: 443k (+71%)   |    =
   nb of samples: 504k (+7%)        |
             | size:          69 MB  |   size:          105 MB        |    =
   size:          75 MB             |
---------------------------------------------------------------------------=
------------------------------------
             |                       |                                |    =
                                    |
     top     | nb of samples: 500k   |   nb of samples: 521k (+70%)   |    =
   nb of samples: 481k (+7%)        |
             | size:          69 MB  |   size:          122 MB        |    =
   size:          71 MB             |
---------------------------------------------------------------------------=
------------------------------------
             |                       |                                |    =
                                    |
thunderbird | nb of samples: 266k   |   nb of samples: 271k (+43%)   |     =
  nb of samples: 269k (+5%)        |
             | size:          31 MB  |   size:          45 MB         |    =
   size:          33 MB             |
---------------------------------------------------------------------------=
------------------------------------

What do you think of these results ?
Should there be a selectable mode specified in .perfconfig ?
I will investigate in reducing the size of the file as well. As, we only ne=
ed the link register in theory.

Also for the compilation on different platforms
What do you think of this fix ?

diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm=
64/include/uapi/asm/perf_regs.h
index d54daafa89e3..15b6805202c1 100644
--- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
+++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
@@ -2,7 +2,7 @@
  #ifndef _ASM_ARM64_PERF_REGS_H
  #define _ASM_ARM64_PERF_REGS_H

-enum perf_event_arm_regs {
+enum perf_event_arm64_regs {
         PERF_REG_ARM64_X0,
         PERF_REG_ARM64_X1,
         PERF_REG_ARM64_X2,
diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.c b/tools/per=
f/util/arm-frame-pointer-unwind-support.c
index 964efd08e72e..0104477a762a 100644
--- a/tools/perf/util/arm-frame-pointer-unwind-support.c
+++ b/tools/perf/util/arm-frame-pointer-unwind-support.c
@@ -1,6 +1,5 @@
  // SPDX-License-Identifier: GPL-2.0
  #include "../arch/arm64/include/uapi/asm/perf_regs.h"
-#include "arch/arm64/include/perf_regs.h"
  #include "event.h"
  #include "arm-frame-pointer-unwind-support.h"
  #include "callchain.h"
@@ -13,8 +12,9 @@ struct entries {

  static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
  {
+       unsigned long long arm64_regs_mask =3D ((1ULL << PERF_REG_ARM64_MAX=
) - 1);
         return callchain_param.record_mode =3D=3D CALLCHAIN_FP && sample->=
user_regs.regs
-               && sample->user_regs.mask =3D=3D PERF_REGS_MASK;
+               && sample->user_regs.mask =3D=3D arm64_regs_mask;
  }

Regards,

Alexandre

On 3/6/21 7:10 PM, Arnaldo Carvalho de Melo wrote:
> Em Sat, Mar 06, 2021 at 09:55:32AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Fri, Mar 05, 2021 at 10:54:03AM +0200, James Clark escreveu:
>>> I've tested this patchset on a few different applications and have seen=
 it significantly improve
>>> quality of frame pointer stacks on aarch64. For example with GDB 10 and=
 default build options,
>>> 'bfd_calc_gnu_debuglink_crc32' is a leaf function, and its caller 'gdb_=
bfd_crc' is ommitted,
>>> but with the patchset it is included. I've also confirmed that this is =
correct from looking at
>>> the source code.
>>>
>>> Before:
>>>
>>>          # Children      Self  Command          Shared Object          =
     Symbol
>>>          # ........  ........  ...............  .......................=
...  ...........
>>>          #
>>>              34.55%     0.00%  gdb-100          gdb-100                =
     [.] _start
>>>                     0.78%
>>>                          _start
>>>                          __libc_start_main
>>>                          main
>>>                          gdb_main
>>>                          captured_command_loop
>>>                          gdb_do_one_event
>>>                          check_async_event_handlers
>>>                          fetch_inferior_event
>>>                          inferior_event_handler
>>>                          do_all_inferior_continuations
>>>                          attach_post_wait
>>>                          post_create_inferior
>>>                          svr4_solib_create_inferior_hook
>>>                          solib_add
>>>                          solib_read_symbols
>>>                          symbol_file_add_with_addrs
>>>                          read_symbols
>>>                          elf_symfile_read
>>>                          find_separate_debug_file_by_debuglink[abi:cxx1=
1]
>>>                          find_separate_debug_file
>>>                          separate_debug_file_exists
>>>                          gdb_bfd_crc
>>>                          bfd_calc_gnu_debuglink_crc32
>>>
>>> After:
>>>
>>>          # Children      Self  Command          Shared Object          =
     Symbol
>>>          # ........  ........  ...............  .......................=
...  ...........
>>>          #
>>>              34.55%     0.00%  gdb-100          gdb-100                =
     [.] _start
>>>                     0.78%
>>>                          _start
>>>                          __libc_start_main
>>>                          main
>>>                          gdb_main
>>>                          captured_command_loop
>>>                          gdb_do_one_event
>>>                          check_async_event_handlers
>>>                          fetch_inferior_event
>>>                          inferior_event_handler
>>>                          do_all_inferior_continuations
>>>                          attach_post_wait
>>>                          post_create_inferior
>>>                          svr4_solib_create_inferior_hook
>>>                          solib_add
>>>                          solib_read_symbols
>>>                          symbol_file_add_with_addrs
>>>                          read_symbols
>>>                          elf_symfile_read
>>>                          find_separate_debug_file_by_debuglink[abi:cxx1=
1]
>>>                          find_separate_debug_file
>>>                          separate_debug_file_exists
>>>                          get_file_crc   <--------------------- leaf fra=
me caller added
>>>                          bfd_calc_gnu_debuglink_crc32
>>>
>>> There is a question about whether the overhead of recording all the reg=
isters is acceptable, for
>>> filesize and time. We could make it a manual step, at the cost of not s=
howing better frame pointer
>>> stacks by default.
>>
>> Can someone quantify this, i.e. how much space per perf.data for a
>> typical scenario? But anyway, I'm applying it as is now, we can change
>> it if needed, its not like files with the extra registers won't be
>> valid if/when we decide not to collect it by default in the future.
>>
>> If we decide to make this selectable, we should have it as a .perfconfig
>> knob as well, so that one can set it and change the default, etc.
>
>>> Tested-by: James Clark <james.clark@arm.com>
>
>
> This is unconditionally asking for asm/perf_regs.h and it is not availabl=
e
> everywhere, so I think this has to be abstracted away, maybe using a weak
> function that arm provides a replacement for?
>
> A:Humm
>
> +++ b/tools/perf/util/Build
> @@ -1,3 +1,4 @@
> +perf-y +=3D arm-frame-pointer-unwind-support.o
>
> Is this for doing cross-platform analysis? I.e. record a perf.data file
> on arm64 and then do a perf-report on it on a x86_64 machine? Yeah, that
> is expected to work, but then:
>
> +++ b/tools/perf/util/arm-frame-pointer-unwind-support.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> +#include "arch/arm64/include/perf_regs.h"
>
>
> [acme@five perf]$ head -25 tools/perf/arch/arm64/include/perf_regs.h
> /* SPDX-License-Identifier: GPL-2.0 */
> #ifndef ARCH_PERF_REGS_H
> #define ARCH_PERF_REGS_H
>
> #include <stdlib.h>
> #include <linux/types.h>
> #include <asm/perf_regs.h>
>
> void perf_regs_load(u64 *regs);
>
> #define PERF_REGS_MASK        ((1ULL << PERF_REG_ARM64_MAX) - 1)
> #define PERF_REGS_MAX PERF_REG_ARM64_MAX
> #define PERF_SAMPLE_REGS_ABI  PERF_SAMPLE_REGS_ABI_64
>
> #define PERF_REG_IP   PERF_REG_ARM64_PC
> #define PERF_REG_SP   PERF_REG_ARM64_SP
>
> static inline const char *__perf_reg_name(int id)
> {
>       switch (id) {
>       case PERF_REG_ARM64_X0:
>               return "x0";
>       case PERF_REG_ARM64_X1:
>               return "x1";
>       case PERF_REG_ARM64_X2:
> [acme@five perf]$
>
> Won't this get the wrong file when cross-building? See below.
>
> - Arnaldo
>
> [perfbuilder@five ~]$ time dm
> Sat Mar  6 12:02:01 PM -03 2021
> # export PERF_TARBALL=3Dhttp://192.168.86.5/perf/perf-5.11.0.tar.xz
> # dm
>     1    78.76 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.=
3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
>     2    79.07 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.=
2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
>     3    82.68 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.=
3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
>     4    88.57 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.=
4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.=
0.0)
>     5    89.47 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.=
4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.=
0.1)
>     6    93.63 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.=
3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.=
0.1)
>     7   125.41 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.=
3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.=
0.0)
>     8   142.89 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.=
3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2=
c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>     9   126.52 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.=
3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/ap=
orts.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>    10   135.80 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pr=
e1) 10.2.1 20201203 , Alpine clang version 10.0.1
>    11   134.19 alpine:edge                   : Ok   gcc (Alpine 10.2.1_pr=
e1) 10.2.1 20201203 , Alpine clang version 10.0.1
>    12    78.12 alt:p8                        : Ok   x86_64-alt-linux-gcc =
(GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags=
/RELEASE_380/final)
>    13    92.57 alt:p9                        : Ok   x86_64-alt-linux-gcc =
(GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
>    14    93.72 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc =
(GCC) 10.2.1 20201125 (ALT Sisyphus 10.2.1-alt2) , clang version 10.0.1
>    15    75.10 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170=
915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
>    16   116.14 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180=
712 (Red Hat 7.3.1-12) , clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.=
0.2)
>    17    10.26 android-ndk:r12b-arm          : FAIL gcc version 4.9.x 201=
50123 (prerelease) (GCC)
>                       from util/arm-frame-pointer-unwind-support.c:3:
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: n=
ested redefinition of 'enum perf_event_arm_regs'
>       enum perf_event_arm_regs {
>            ^
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: r=
edeclaration of 'enum perf_event_arm_regs'
>      In file included from util/arm-frame-pointer-unwind-support.c:2:0:
>      /git/linux/tools/include/../arch/arm64/include/uapi/asm/perf_regs.h:=
5:6: note: originally defined here
>       enum perf_event_arm_regs {
>            ^
>      make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error=
 2
>    18    10.71 android-ndk:r15c-arm          : FAIL gcc version 4.9.x 201=
50123 (prerelease) (GCC)
>                       from util/arm-frame-pointer-unwind-support.c:3:
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: n=
ested redefinition of 'enum perf_event_arm_regs'
>       enum perf_event_arm_regs {
>            ^
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: r=
edeclaration of 'enum perf_event_arm_regs'
>      In file included from util/arm-frame-pointer-unwind-support.c:2:0:
>      /git/linux/tools/include/../arch/arm64/include/uapi/asm/perf_regs.h:=
5:6: note: originally defined here
>       enum perf_event_arm_regs {
>            ^
>    19    28.97 centos:6                      : Ok   gcc (GCC) 4.4.7 20120=
313 (Red Hat 4.4.7-23)
>    20    34.56 centos:7                      : Ok   gcc (GCC) 4.8.5 20150=
623 (Red Hat 4.8.5-44)
>    21   110.26 centos:8                      : Ok   gcc (GCC) 8.3.1 20191=
121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3=
.0+467+cb298d5b)
>    22    67.12 clearlinux:latest             : Ok   gcc (Clear Linux OS f=
or Intel Architecture) 10.2.1 20201217 releases/gcc-10.2.0-643-g7cbb07d2fc =
, clang version 10.0.1
>    23    87.08 debian:8                      : Ok   gcc (Debian 4.9.2-10+=
deb8u2) 4.9.2 , Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (bas=
ed on LLVM 3.5.0)
>    24    92.73 debian:9                      : Ok   gcc (Debian 6.3.0-18+=
deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
>    25    86.91 debian:10                     : Ok   gcc (Debian 8.3.0-6) =
8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
>    26    86.13 debian:experimental           : Ok   gcc (Debian 10.2.1-6)=
 10.2.1 20210110 , Debian clang version 11.0.1-2
>    27    36.91 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc=
 (Debian 10.2.1-6) 10.2.1 20210110
>    28     9.08 debian:experimental-x-mips    : FAIL gcc version 10.2.1 20=
201224 (Debian 10.2.1-3)
>                       from builtin-diff.c:12:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>    29    33.76 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64=
-gcc (Debian 10.2.1-3) 10.2.1 20201224
>    30    12.74 debian:experimental-x-mipsel  : FAIL gcc version 10.2.1 20=
201224 (Debian 10.2.1-3)
>                       from builtin-diff.c:12:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from util/branch.h:15,
>                       from util/callchain.h:8,
>                       from builtin-record.c:16:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from util/session.h:6,
>                       from builtin-buildid-list.c:17:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from util/thread.h:16,
>                       from builtin-sched.c:11:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from builtin-top.c:31:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from util/session.h:6,
>                       from builtin-evlist.c:16:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from util/session.h:6,
>                       from builtin-buildid-cache.c:24:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from builtin-stat.c:49:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from util/branch.h:15,
>                       from builtin-report.c:24:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from builtin-annotate.c:24:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      In file included from util/perf_regs.h:30,
>                       from util/event.h:15,
>                       from util/thread.h:16,
>                       from builtin-timechart.c:24:
>      /git/linux/tools/perf/arch/mips/include/perf_regs.h:7:10: fatal erro=
r: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>    31    32.64 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140=
911 (Red Hat 4.8.3-7)
>    32    35.41 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160=
406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
>    33    77.83 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160=
406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
>    34    96.28 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161=
221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
>    35    10.80 fedora:24-x-ARC-uClibc        : FAIL gcc version 7.1.1 201=
70710 (ARCompact ISA Linux uClibc toolchain 2017.09-rc2)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:0:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>       #include <asm/perf_regs.h>
>                ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      /git/linux/tools/build/Makefile.build:139: recipe for target 'util' =
failed
>      make[3]: *** [util] Error 2
>    36    98.38 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170=
727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
>    37   111.11 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180=
130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
>    38   111.55 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180=
712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
>    39   127.99 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190=
223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
>    40   136.36 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190=
223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
>    41   139.67 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200=
408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
>    42    10.57 fedora:30-x-ARC-uClibc        : FAIL gcc version 8.3.1 201=
90225 (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>       #include <asm/perf_regs.h>
>                ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error=
 2
>    43   136.09 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200=
408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
>    44   112.14 fedora:32                     : Ok   gcc (GCC) 10.2.1 2020=
1125 (Red Hat 10.2.1-9) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>    45   111.28 fedora:33                     : Ok   gcc (GCC) 10.2.1 2020=
1125 (Red Hat 10.2.1-9) , clang version 11.0.0 (Fedora 11.0.0-2.fc33)
>    46   116.62 fedora:34                     : Ok   gcc (GCC) 11.0.0 2021=
0225 (Red Hat 11.0.0-0) , clang version 12.0.0 (Fedora 12.0.0-0.1.rc1.fc34)
>    47   117.53 fedora:rawhide                : Ok   gcc (GCC) 11.0.0 2021=
0210 (Red Hat 11.0.0-0) , clang version 12.0.0 (Fedora 12.0.0-0.1.rc1.fc35)
>    48    38.03 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.3.0-r1 =
p3) 9.3.0
>    49    78.35 mageia:5                      : Ok   gcc (GCC) 4.9.2 , cla=
ng version 3.5.2 (tags/RELEASE_352/final)
>    50    97.37 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.m=
ga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
>    51   116.36 manjaro:latest                : Ok   gcc (GCC) 10.2.0 , cl=
ang version 10.0.1
>    52   246.83 openmandriva:cooker           : Ok   gcc (GCC) 10.2.0 2020=
0723 (OpenMandriva) , OpenMandriva 11.0.0-1 clang version 11.0.0 (/builddir=
/build/BUILD/llvm-project-llvmorg-11.0.0/clang 63e22714ac938c6b537bd958f706=
80d3331a2030)
>    53   134.08 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.=
1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEA=
SE_501/final 312548)
>    54   142.32 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.=
0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
>    55   133.68 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.=
0 , clang version 9.0.1
>    56   146.85 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.=
0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
>    57   136.96 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.=
5 , clang version 3.8.0 (tags/RELEASE_380/final 262553)
>    58   122.69 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 10.2=
.1 20200825 [revision c0746a1beb1ba073c7981eb09f55b3d993b32e5c] , clang ver=
sion 10.0.1
>    59    28.36 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120=
313 (Red Hat 4.4.7-23.0.1)
>    60    35.22 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150=
623 (Red Hat 4.8.5-44.0.3)
>    61   109.60 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191=
121 (Red Hat 8.3.1-5.0.1) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.modu=
le+el8.3.0+7827+89335dbf)
>    62    29.20 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.=
6.3-1ubuntu5) 4.6.3 , Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/fi=
nal) (based on LLVM 3.0)
>    63    33.46 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ub=
untu1~14.04.4) 4.8.4
>    64    93.53 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ub=
untu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE=
_380/final)
>    65    11.70 ubuntu:16.04-x-arm            : FAIL gcc version 5.4.0 201=
60609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)
>                       from util/arm-frame-pointer-unwind-support.c:3:
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: n=
ested redefinition of 'enum perf_event_arm_regs'
>       enum perf_event_arm_regs {
>            ^
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: r=
edeclaration of 'enum perf_event_arm_regs'
>      In file included from util/arm-frame-pointer-unwind-support.c:2:0:
>      /git/linux/tools/include/../arch/arm64/include/uapi/asm/perf_regs.h:=
5:6: note: originally defined here
>       enum perf_event_arm_regs {
>            ^
>      /git/linux/tools/build/Makefile.build:139: recipe for target 'util' =
failed
>      make[3]: *** [util] Error 2
>    66    28.74 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc=
 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    67    27.61 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc=
 (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    68    28.82 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-g=
cc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    69    28.16 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu=
-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    70    27.96 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (=
Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>    71   101.40 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ub=
untu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>    72    11.69 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ub=
untu/Linaro 7.5.0-3ubuntu1~18.04)
>                       from util/arm-frame-pointer-unwind-support.c:3:
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: n=
ested redefinition of 'enum perf_event_arm_regs'
>       enum perf_event_arm_regs {
>            ^~~~~~~~~~~~~~~~~~~
>      /git/linux/tools/arch/arm/include/uapi/asm/perf_regs.h:5:6: error: r=
edeclaration of 'enum perf_event_arm_regs'
>      In file included from util/arm-frame-pointer-unwind-support.c:2:0:
>      /git/linux/tools/include/../arch/arm64/include/uapi/asm/perf_regs.h:=
5:6: note: originally defined here
>       enum perf_event_arm_regs {
>            ^~~~~~~~~~~~~~~~~~~
>      /git/linux/tools/build/Makefile.build:139: recipe for target 'util' =
failed
>      make[3]: *** [util] Error 2
>    73    29.62 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc=
 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
>    74    10.74 ubuntu:18.04-x-m68k           : FAIL gcc version 7.5.0 (Ub=
untu 7.5.0-3ubuntu1~18.04)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:0:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>       #include <asm/perf_regs.h>
>                ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      /git/linux/tools/build/Makefile.build:139: recipe for target 'util' =
failed
>      make[3]: *** [util] Error 2
>    75    29.37 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc=
 (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    76    32.06 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-g=
cc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    77    31.37 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu=
-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    78    11.66 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ub=
untu 7.5.0-3ubuntu1~18.04)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:0:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>       #include <asm/perf_regs.h>
>                ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      /git/linux/tools/build/Makefile.build:139: recipe for target 'util' =
failed
>      make[3]: *** [util] Error 2
>    79    26.84 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (=
Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>    80    11.50 ubuntu:18.04-x-sh4            : FAIL gcc version 7.5.0 (Ub=
untu 7.5.0-3ubuntu1~18.04)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:0:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>       #include <asm/perf_regs.h>
>                ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      /git/linux/tools/build/Makefile.build:139: recipe for target 'util' =
failed
>      make[3]: *** [util] Error 2
>    81    10.62 ubuntu:18.04-x-sparc64        : FAIL gcc version 7.5.0 (Ub=
untu 7.5.0-3ubuntu1~18.04)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:0:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>       #include <asm/perf_regs.h>
>                ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      /git/linux/tools/build/Makefile.build:139: recipe for target 'util' =
failed
>      make[3]: *** [util] Error 2
>    82    80.18 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-9ub=
untu2) 9.2.1 20191008 , clang version 8.0.1-3build1 (tags/RELEASE_801/final=
)
>    83    11.44 ubuntu:19.10-x-alpha          : FAIL gcc version 9.2.1 201=
91008 (Ubuntu 9.2.1-9ubuntu1)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error=
 2
>    84    11.67 ubuntu:19.10-x-hppa           : FAIL gcc version 9.2.1 201=
91008 (Ubuntu 9.2.1-9ubuntu1)
>      In file included from util/arm-frame-pointer-unwind-support.c:3:
>      /git/linux/tools/perf/arch/arm64/include/perf_regs.h:7:10: fatal err=
or: asm/perf_regs.h: No such file or directory
>          7 | #include <asm/perf_regs.h>
>            |          ^~~~~~~~~~~~~~~~~
>      compilation terminated.
>      make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error=
 2
>    85    83.72 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17u=
buntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1
>    86    34.23 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu=
-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0
>    87    83.44 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13=
ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
>    88    79.47 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.2.1-6u=
buntu1) 10.2.1 20210110 , Ubuntu clang version 11.0.1-2
> 89 6489
>
> real  109m25.234s
> user  1m34.076s
> sys   0m55.476s
> [perfbuilder@five ~]$
>
>
>
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
