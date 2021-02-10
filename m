Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D77C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Feb 2021 12:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD02464E0D
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Feb 2021 12:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBJMIU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 07:08:20 -0500
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:56388
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230260AbhBJMGe (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Feb 2021 07:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZeofFwylZ5xdKCzQx+H7r2jk620ULdh/EfYIBkGHts=;
 b=hXzez1/0P4B9N1rDQ9B6Z6dkJyIh2RbFaR6Er4GtXTuCto0Dq9iexipyzxUqPuqn0cwHUm+vIIiJKSbOJPdMRBb2h7d5DiuoofaDi1V2QScBTY/I9MYdoIAQFWdLzCtSx3UkQOHC7doGUrzapEFhAxHx9QyDJaP/CwG/vbI7pkk=
Received: from AM6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::36)
 by DB7PR08MB3035.eurprd08.prod.outlook.com (2603:10a6:5:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Wed, 10 Feb
 2021 12:05:41 +0000
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8b:cafe::18) by AM6P191CA0023.outlook.office365.com
 (2603:10a6:209:8b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Wed, 10 Feb 2021 12:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 12:05:40 +0000
Received: ("Tessian outbound 2b57fdd78668:v71"); Wed, 10 Feb 2021 12:05:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 90e7e0a89e567587
X-CR-MTA-TID: 64aa7808
Received: from e4cff2d38ed9.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 20BDE09E-1138-4E45-B69E-8524AE1A1D7C.1;
        Wed, 10 Feb 2021 12:05:28 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e4cff2d38ed9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 10 Feb 2021 12:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flzByQlQkstRzHDBMyh6Tx02cOPdRNKWcTGdJmxSw6VpDDgB03TZBPG4jCKUa7eYz7bef/cr+o5JerkY+rDMTW9ZNWQ5fCNhz51CUYBL7pgSunl8mio9yMTDXu/BIAmOiwHO38Z/WE3w/4QxOIdNPOy8/mq6MueQaMDAIQEsR+hoYDccwvkyH93h71xbLlvcnwoyul6zLpgXDaovT6YMiSEUJmj3QSxNEJCDplX0QsGhn+D+xfd5svz3OFmXk+jCKBWYtGI+EvX0vtBB0v8nxhGT1y2/DASsQLXpDFSYqxrgwhZ0/TAhu3fqm+8Rc4icUE48yyrxMcnbGDC2HyrabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZeofFwylZ5xdKCzQx+H7r2jk620ULdh/EfYIBkGHts=;
 b=lqJFueaeEPYai2kDUiVysyTaGKpur6vxiP+kegg88g7rJLMQwgGfrTxMCYHMOysgOYznnr0ja3g5QWeBZQcGodR4UJZRJl+Am0s49+977ow5rN5AJsvM+perqi4xx408YTYRuU36B+1h93H+BXvqyuiWAYsKo3rBy1C6HP+PiV0Y9r5s23+33ibAmZSOejMjOARfH0X42RZyHDF84+2d/q+hGvt1ZSyK6exyWA/fe78eGd2tH5hXXYqkiMeRR5fpKGSmr2HpEiN8OSUPeo5L58x9LZM7IldoS2Ihg5OkhQEf0qkWi6GI6y1K6PCt8/epGulRFogVaQAz3kJusZBquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZeofFwylZ5xdKCzQx+H7r2jk620ULdh/EfYIBkGHts=;
 b=hXzez1/0P4B9N1rDQ9B6Z6dkJyIh2RbFaR6Er4GtXTuCto0Dq9iexipyzxUqPuqn0cwHUm+vIIiJKSbOJPdMRBb2h7d5DiuoofaDi1V2QScBTY/I9MYdoIAQFWdLzCtSx3UkQOHC7doGUrzapEFhAxHx9QyDJaP/CwG/vbI7pkk=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com (2603:10a6:20b:299::13)
 by AM6PR08MB4102.eurprd08.prod.outlook.com (2603:10a6:20b:ab::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Wed, 10 Feb
 2021 12:05:26 +0000
Received: from AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8]) by AS8PR08MB6120.eurprd08.prod.outlook.com
 ([fe80::3c1e:d3bd:de58:dee8%7]) with mapi id 15.20.3825.020; Wed, 10 Feb 2021
 12:05:26 +0000
Subject: Re: [PATCH 4/4] perf tools: determine if LR is the return address
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
        Al Grant <al.grant@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
References: <20210122161854.5289-1-alexandre.truong@arm.com>
 <20210122161854.5289-4-alexandre.truong@arm.com>
 <3184a838-9784-eb86-09ad-ceadabcd3381@arm.com>
From:   Alexandre Truong <alexandre.truong@arm.com>
Message-ID: <fef4739e-ccdf-7a60-3f4d-e8583ec27e9e@arm.com>
Date:   Wed, 10 Feb 2021 12:05:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3184a838-9784-eb86-09ad-ceadabcd3381@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.99.251]
X-ClientProxiedBy: LO4P123CA0159.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::20) To AS8PR08MB6120.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.16.51] (217.140.99.251) by LO4P123CA0159.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:188::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Wed, 10 Feb 2021 12:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecda558e-f0bf-4720-5627-08d8cdbc2f6a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4102:|DB7PR08MB3035:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB303559F5E550FCAAF6EF674B9C8D9@DB7PR08MB3035.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7HaPteX11pd9pLSTqsyWgZW5buDw+JVC/6n/nkMwBKiU/O35nXFlpNQ8lyHE+ZDVR7pWri9rEFpYhvb0l8t4REozAhGZmUEN357rjFWpKP51FxaY9xDDlXyfOCjRFszgOvqqypapj7oqnsThie+DTtqUwnekI3HqDJ8ZHDTSMIAexkQ6lFHLvJfAw3CtcrCOvZ35R3TDH+we1nt7jyHqGmzvus+bGdcOsBX+4eXkpVwqlY/2/pOJ5M5/YFUhs20YX/f42hI0LZkxXlS2XeCzjB4Udmgcc1MpUr63gLrGaEgzwnxjn1XNBuidiDRHcK7wGCQDlKDoatNqQ5XFKyXD9rR64TOWM2oa91Td1sTe9faakJ58tixBW0qtL6VKD1Mh+akoj2w4Fqe+EVctoRk8szxHA8+ysOOCT/3HkUdUSJ38two/nFTAW2ae8RiotSPhMZSoQWesP5Z9K45o/NS54rq7VQHZnfS8YD78nQiuRG+ZsbAJF+F6F84tKNp2xpVpVyMX62HiO0k8ZaiCwUxf7cvayWNGYv9pYg4lMdo+XA4/o4rSczt0OKVIjUdoPympmRhS8gZqCtg69IXE4l/7y0oeic9R5pFeeU2NGobUizM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(54906003)(2906002)(86362001)(44832011)(8676002)(7416002)(2616005)(31686004)(52116002)(53546011)(186003)(316002)(4326008)(956004)(16526019)(6486002)(5660300002)(16576012)(83380400001)(26005)(66946007)(66556008)(66476007)(8936002)(31696002)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0Q2UTNJUm92VHRHSWJnV1dZVjBpWmRacUZQZmtKVEtOdjB4eE9CRkZHNlo2?=
 =?utf-8?B?dkpQRmRoQ0VQTzZvM0NqZ3pLZkdiUFl6b3Q4clg3TDZ6SE9VbFNsRklHNXBU?=
 =?utf-8?B?OWdIOC9MRHpqWmFDSmg1bFEvTDFSWUZBQVdObTdIOTdiMzNldnEwYnZrVmxF?=
 =?utf-8?B?a21oeGZoZFNXRGVWS2xQTEIzVmgyeVJNbWJkQnNoMGRIRjJKN2ZQT3Y4Mi9H?=
 =?utf-8?B?TWVROW5kQ0wzeW9vWmVmR3MvKzh1bkFzeE1zRlJsSmdHbEtKdFgyc3pYdjRT?=
 =?utf-8?B?RE9WTDlCM1BxNG53VHBya3hjenZNUWhnTXpIcm41L2NqM1M4ZXlyU2hZa2w3?=
 =?utf-8?B?TmFJRGhvS0R0b28zK2tYZFlFYit0aFlYd3pJUEhnZUtOTXNHMGl0ei83RXUr?=
 =?utf-8?B?bmE3eUR2dmNHekVjWStDcGxzdVN3V1RDVmFJVjl2a1JyQ2pZWndkRHN3bkI1?=
 =?utf-8?B?K1JuMzZyMkdwV2toRThCVENxSVZVWUZqY3F3RDUrVGFFVjlKUjUvYXdhOVpP?=
 =?utf-8?B?WnkvcldQRDBjOFFWSGplM2xybk9KSnBEN1E4dDlEeFJPVEdhUURZSGpLQUph?=
 =?utf-8?B?WHF1UXRtSXFqR3pGVVhrSEhnczNpVE1heG5WT0ZNcS9wbmFzOUJMWnhnaVR2?=
 =?utf-8?B?RE9vNnBsOTUrNTRIRDFucUZiWUN0dWhKbHlVVHIxNUVhZ20zR3Bvb2UxZm11?=
 =?utf-8?B?eGNVYzc0UE5rQVk0RmxjQ1dQeVl5MUovc05MMzhzdFZkS2hZenYvT2VneFJR?=
 =?utf-8?B?dk55azVPWE50eW1QMlEwbmxZYzV1aVFheGRVSU9qWlhwVzl6RlpTOUJhVkZp?=
 =?utf-8?B?UGx2WmJuZnc1K3FiL0hpTi9GSHVING5YR0ZOY2FUVzlaaDJVcm5TU09vdW1Q?=
 =?utf-8?B?aU90NmlJVGM2VVZVVlZHM0hnVGhIbmFIOFczb2NoUGFRZ1ZQd2lrREQxdU5y?=
 =?utf-8?B?dGcvcUZaSEpuUUxwMFN1azg3dzl6cnhwS0hoc01iOXVWRXZYWThLR3VzQm4r?=
 =?utf-8?B?L2xTQ1dEWWN2OXJFTzBCcjhjblJ0Zk1oeklzZXBhZS8yVDFrTWR1RHg4U3h5?=
 =?utf-8?B?VDYxc2ozcVJ6UUVGOE9FS1gyem9kRHlQU2J0Q1plamRwOGpFemppUjV5Z3VY?=
 =?utf-8?B?SHRHeFhZa0labW9aM1NMSkt3Nmhvb0VhUUM3QnE3SzNzQzBmaDFwSFpZSVJI?=
 =?utf-8?B?bDRhby9udlZwa05obVBWenl0VmYyUWZoQnZmUXdaUWFMRmtHaHJ5a0xxaUVO?=
 =?utf-8?B?Y2xEOXQzSE1TRlF3b0s0a2g0akNEcE9LbGJDVHE2SXV1UEkybURlbm9pQjNj?=
 =?utf-8?B?dzVJVmtteFMveTM5MTBuMjEreGNNUGxJbzl4YzdvemlLandEdWpTRFEyeENn?=
 =?utf-8?B?bnYwNWtlR2daVzJHVFhrYk42N214dFFhWldlL2tqSkc5SFhOemV5aFdITnNy?=
 =?utf-8?B?dksvSWM1ck03RHE4WDBJR3dlZGswS21LSHJlUDZLSVZTTERheDhpYjR5WmNR?=
 =?utf-8?B?UEF6dnNiOExjaXFGajhlZ2RtSWJobEIrVXYxbXNCSi9mWVlFOWtOQTVvSUF2?=
 =?utf-8?B?SHFnYk84RFJyR1pQV1FremIzVGRnWnZTRnc2MUhualptY1dkdnBRNzdqNDNo?=
 =?utf-8?B?eGsvRlhEWEswSG5COUc3MnJOTWluRUVKTW5vUGNCMHBGNERhZS8ydWo3Q1oy?=
 =?utf-8?B?Z3FJeFk4ZnNGVDEwNFpCWHlScEQ3WWs2Um50cVpPcVFEUEZSY3NMTGRydXVC?=
 =?utf-8?Q?Wjf1J6UC3NVvi7G7s3NM0GUzF9p3IUbCj+XKo+D?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4102
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 50e77702-7cdb-47e9-c022-08d8cdbc26b2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD6Vkf5lw0Neds/sKV8xmbaSVXC4wUhDS0VYHDR3O6NzV8uryOHJZpDuZsl3O7KbybC55Z8KzBiRjbhuTxEXSf/37kLzMLf/rIrPtjO4h/xnbri4GZ8FJ9cUG5wezfi6nveYb0wyQoKUiIRbVp/8jqM5NhN/6rJZIZAa41Hvbu6JPIgZ9fyvmjqD+fYlntmsrfdjcQFGVF5e0F0BWJrqg0BC9dlqzq9teNl9+7WYUltWtwSXfA3qvrtVc3+ZdAkCWC0hA8S61MvBt6Uu1ZnunZDr209EtkrHhbKr8k0NEJoJ+EWxstouVOPk5/hPvwDyclfkW2oJ5SFGjqyTX5U7wm52fOJAL6SS62ROJDdsbidsOnGIDEPtOv2nCvcXA7U7bpfc+2Uhc4jmUWBWbpBp4creNhjlhflkCtwbV7+TZgtug15hR6+9O2EcUJFaQWINVN3T+mIYyBTyMddrANL5aGy4EQNudLri7LjH/hiZwM04OemaJ8oEVZcP/40Z0y5lQ/5c8x3FXkZpJ46fW5iqYbutA2ZB3F2FBiYu+i3azw4ZhFyieHLtGUK/8biXoTsvAlHFZc9UDx+yOPij3/RyFnKCoQMkUT4CruFwJEJvGZCR5MTBAVMLdQj/LkSodO7oEGJVtznoMRwiUGaWFkvdTfYt1B2haHvtwRMfmZKkAWkasr61PS0egabMzDZW8jhv
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(346002)(36840700001)(46966006)(4326008)(956004)(70206006)(356005)(31686004)(2616005)(36860700001)(478600001)(70586007)(450100002)(86362001)(336012)(82740400003)(53546011)(82310400003)(81166007)(8936002)(44832011)(6486002)(8676002)(16526019)(316002)(16576012)(36756003)(186003)(47076005)(5660300002)(83380400001)(54906003)(2906002)(31696002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 12:05:40.5029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecda558e-f0bf-4720-5627-08d8cdbc2f6a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3035
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2/8/21 3:39 PM, James Clark wrote:
>
>
> On 22/01/2021 18:18, Alexandre Truong wrote:
>
>> +}
>> +
>> +static int add_entry(struct unwind_entry *entry, void *arg)
>> +{
>> +    struct entries *entries =3D arg;
>> +
>> +    entries->stack[entries->i++] =3D entry->ip;
>> +    return 0;
>> +}
>> +
>> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct th=
read *thread)
>> +{
>> +    u64 leaf_frame;
>> +    struct entries entries =3D {{0, 0}, 0};
>> +
>> +    if (get_leaf_frame_caller_enabled(sample))
>> +            return 0;
>> +
>> +    unwind__get_entries(add_entry, &entries, thread, sample, 2);
>> +    leaf_frame =3D callchain_param.order =3D=3D ORDER_CALLER ?
>> +            entries.stack[0] : entries.stack[1];
>> +
>> +    if (leaf_frame + 1 =3D=3D sample->user_regs.regs[PERF_REG_ARM64_LR]=
)
>> +            return sample->user_regs.regs[PERF_REG_ARM64_LR];
>
> Hi Alex,
>
>  From your other reply about your investigation it looks like the check a=
gainst PERF_REG_ARM64_LR isn't
> required because libunwind won't return a value if it's not correct. Whet=
her it's equal to the LR or not.
>
> And PERF_REG_ARM64_LR points to the instruction _after_ the call site. i.=
e. where to return to,
> not where the call was made from. So just leaf_frame rather than leaf_fra=
me+1 would be more accurate.
>
> I was also looking at unwind_entry in machine.c which is similar to your =
add_entry function and saw that it
> does some extra bits like this:
>
>       if (symbol_conf.hide_unresolved && entry->ms.sym =3D=3D NULL)
>               return 0;
>
>       if (append_inlines(cursor, &entry->ms, entry->ip) =3D=3D 0)
>               return 0;
>
>       /*
>        * Convert entry->ip from a virtual address to an offset in
>        * its corresponding binary.
>        */
>       if (entry->ms.map)
>               addr =3D map__map_ip(entry->ms.map, entry->ip);
>
> I have a feeling you will also need to do those on your values returned f=
rom libunwind to make it 100%
> equivalent.
>
> James
>

Hi James,

Thanks for your reply.

The check against PERF_REG_ARM64_LR is indeed not required and I can
check if libunwind goes successfully.

I am going to follow up with a v2 of the patch applying these changes.

I think the bits you mentioned don't need to be added because this check
is already done in add_callchain_ip() called afterwards in machine.c :

     if (symbol_conf.hide_unresolved && entry->ms.sym =3D=3D NULL)
         return 0;

For the second one, I don't think it needs to be added either because
append_inlines() appends ip on the cursor which is also already done by
add_callchain_ip().

For the last one, the conversion from a virtual address to a binary one
isn't required.


Also for the expansion to all platforms, it doesn't work on x86 so I'll
leave it just for arm for now.

Regards,

Alexandre

>> +    return 0;
>> +}
>> diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.h b/tools/=
perf/util/arm-frame-pointer-unwind-support.h
>> new file mode 100644
>> index 000000000000..16dc03fa9abe
>> --- /dev/null
>> +++ b/tools/perf/util/arm-frame-pointer-unwind-support.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
>> +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
>> +
>> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct th=
read *thread);
>> +
>> +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index 40082d70eec1..bc6147e46c89 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -34,6 +34,7 @@
>>   #include "bpf-event.h"
>>   #include <internal/lib.h> // page_size
>>   #include "cgroup.h"
>> +#include "arm-frame-pointer-unwind-support.h"
>>
>>   #include <linux/ctype.h>
>>   #include <symbol/kallsyms.h>
>> @@ -2671,10 +2672,12 @@ static int find_prev_cpumode(struct ip_callchain=
 *chain, struct thread *thread,
>>      return err;
>>   }
>>
>> -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unu=
sed,
>> -            struct thread *thread __maybe_unused)
>> +static u64 get_leaf_frame_caller(struct perf_sample *sample, struct thr=
ead *thread)
>>   {
>> -    return 0;
>> +    if (strncmp(thread->maps->machine->env->arch, "aarch64", 7) =3D=3D =
0)
>> +            return get_leaf_frame_caller_aarch64(sample, thread);
>> +    else
>> +            return 0;
>>   }
>>
>>   static int thread__resolve_callchain_sample(struct thread *thread,
>>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
