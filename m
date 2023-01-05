Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D6C3DA7D
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 13:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAENds (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 08:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjAENdk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 08:33:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBEF30568
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 05:33:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l01KpFQZlhdFZxQ84mfSnOfCZj5dzlXnl98NvuQHtQNcQmljn34aoPMf1r9Dp8LrVhpbXcoo6Zbay/T7+QZmVo1PB7RNKbZIG6ARzlnW8TEY6ZXGxK+xA6eVMdQXaNpOa18ZRBsjDf+P47Vhs4Y18fcN2ekwKNwigiN7M3yvTO4w8UovKsqCa2/ie3/fZCCIwSrpX8CNZl5agQPUniHbX8bdLMmWxDQtIfldMLqgo0V7bSWF1qR1yDYl03jehbzaDEiU4lTZ43mvUXFGWn/EWa79W5VT2YavZUH2DwfWwiumbmMFp+jLQGQn10SQ6+qUeIgl6649fISwPwa4mMi0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubfun0aZrAgfhkKXE9VyW9OFcX7Ks36wcX11dmoKwgY=;
 b=PmV/WlxBQZQoX/IcK2feu81LyKX1IKrOLtxJWYSVXoS0yQ+D/HETse2KrbhCT5uPD73blSqFQ/PDU+Tl0uM9esW+E3WI5B6LK5GmkB1/Dp+3FdC5wmAcvfYzo+s2cgrDpTp2Rm/8w3gqayBVsvvsEKV0P27axWGI6uN4MVLUXKU8A8p3qZwJVM/VikCWtdTVsob9AD9lSsDIZ19Zc+a/CtFruERHP8ZGPc7sJur53lzPMSaB8EJq0yzspaskzsO8mIzqBgIG3q5s39PjZTLSFzhHyWgTKjS8RCzF13pc1mTDj2TngCWOuI7sfFN13BKo3i/qbtS9v9eGWKFsXEdUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubfun0aZrAgfhkKXE9VyW9OFcX7Ks36wcX11dmoKwgY=;
 b=AWr9H7tEmsMcQeJhlL32LG65fVSvgOggTJ9h/HP78TH53mlEuN5UYh1xOKZvV8CFBcezQmlerJJEmppyeO9GTJguAv0T7n08gqE62bUdghgShAyUST0w2i/19INV1c8Dhuv4tu7wgwMzJC3G7tz5gNb5nC9tiZdqQS2u/N9HGxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 13:33:36 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 13:33:36 +0000
Message-ID: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
Date:   Thu, 5 Jan 2023 19:03:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [BUG] perf kmem: Broken because of missing tracepoints
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae5d7ba-9c82-4779-5583-08daef21725f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ccuDehvaM9jkBC7lmIarBQFrzTwOBCnfjhd0hyjaJ2Afk47KVf9c5ePTFqpZE1jv0W4XT5a6XmNksm12gwR+eUUO2NCIp84WtsXVWclnxgUS9r1vehIZp6d0ZZzmKdkZG7dHLKrmd9eSbJPNsrguThXOjjNfl0qW0QOq8fooD5aiiJuyr9DhwxAfUEOS+HN+d3O270ZR0NpL/2E5W0jkD640O4mnt/4lNB2l+4GMGzTou+vnhjbBxnVo2F9Zj0b5lkf9P/V/d054BCp9Xn1bB3wakiwx5nIn+AmNXjzfY6XvlPZKWETea/oDPPGWu1acgeGhyk7+csjUyI/9YZ8Om/UyIdjHHGQHVUx9/nNzYl2uK3jm7z6xbKaYjxdD6J+GdsCvmC4l+3gPtf9kaHbvlo48t5lMaeJy+WJAU8cnFPZBWktW+qWyCmhpqT4vT/XwJxJUsPpiwpu7HvvAJA2QjUfVQKoi5YQsiNHgwQktci5FptPwrT+qaNFimCjDi1UYI/ST5lgxY66AQp43mVumU5rED45vCfsU/Fx0PgX3KZ2AeMwwilfq439uPkTCJL7tQHi1Cqb1kCPOoet6GVoOKXdV8s4GQkPt3+Ld3SqB2YeMOZOMh4gpAyTdTIwXnCnph2bOuJr62VmnHiHf+icM0unwlp2+q3mE8kPSlgpheutl8DGarU3pL+MvfMrGPcfgaDCCmOAwIe5GmvR0eVkl6Bl++mFxh/FPC4kMtKXg6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(2616005)(31696002)(86362001)(4744005)(38100700002)(36756003)(4326008)(2906002)(110136005)(316002)(66556008)(41300700001)(8936002)(66946007)(5660300002)(8676002)(66476007)(186003)(6486002)(478600001)(26005)(6512007)(6666004)(44832011)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHB2a0JxQklVK1NiU1VJQ3YvdVkrWUZoUXpPS2VhdVZIRjh2Sy8xa05qL0cy?=
 =?utf-8?B?OUlBUmtPUEVJUisvYnBrN2NhQnFnajNjNjNtcTFIcXN2UWxCQlZyVVljVjAr?=
 =?utf-8?B?elVPSzJRVDBrZkZDeDU2eGdzanJLczkyeXVkSXRMNm94Tm9EejRWZGJwbXJq?=
 =?utf-8?B?SFRDQ2h4TnNOZHNtS2hGR2lqZTZLUUFjczNJbUhHcHdCWmNIYmdlSVc4YkJR?=
 =?utf-8?B?N3BUL3hMVnVVbmtLc1FhdzhZa2lZNXBZMWlFcVgxYTJoT05valJNajVDM3BH?=
 =?utf-8?B?eTlMejQzRVRaNjBXWnByYlA1aGNJLytyaGNwZ0M5NjZTcGJ0WS9VcVhEbnZu?=
 =?utf-8?B?eExpRHNnenRiR0lISDJYeFJlNzNoaytjZ21Mb3ZWVUtjWWhKVysrUGl4bmo4?=
 =?utf-8?B?dVVNTml6RTJLT2ZIYm14UFM3YlBqTzNRUFNZUmw2QkRiZG1jZXFCd3BDTUcy?=
 =?utf-8?B?UFlNdy9IWmRXM2xVTVVkWWhTMW56UTJOWkJWOTdZVzFXWnNEdlZaUnFTSjB0?=
 =?utf-8?B?MlJSMk1XYWtLZUlYdXYwQnZOREo0SExDOWVuM01HcWo4S1dqd3RHVUlIUXlZ?=
 =?utf-8?B?akV6SDRsQVJkLzBRU3RJVDBmcEQ3ZHNWMi9nTTZMb3l1ZnJRd2k1aTFCYnE2?=
 =?utf-8?B?czk0QTlxVG01ZUE5M01MbENNUTNuN29rOEMrWmNvL0xYcnlWWGQ5aW85VlRN?=
 =?utf-8?B?NjJkaG5ldVI1NEdoaGxjNmhSbWRzaCtzbFVndnVPU01iNFJxVW5RTmI4TVhq?=
 =?utf-8?B?NkJpMEViV1JYeXBXdTh3N01aSk9MYXVEOGdQMWVwZFlZc1NCamtETkNnajdM?=
 =?utf-8?B?L2JDQmxEUHVjV0dJNkduaFNkdlNrR25ZS2hEbTNQTC9BY1k1MmhDYi9mYUJG?=
 =?utf-8?B?MkxmWHdMNUNkZFZZRjJZMUg2a0VLNkljLytwWEZlakVNOE93TWFLZWZEdmN4?=
 =?utf-8?B?U0t1R2E5a3B0Qzl5bStSYkorUHJDVHdiNVZmcXZiak1XWGdpTlRQNkRnOHND?=
 =?utf-8?B?UVUrSGMyY21xQmhDelQvMVh3WmtsQ2Nkc01oclBtUHhuVkFyWDBmZ3c4V0RP?=
 =?utf-8?B?M0JRUS94cFNmWEQxc0k0VHFwQ2Y1RmhYYi9QcUJKV1JEUCtzOTk4a204MWFU?=
 =?utf-8?B?R2ZmRVE4RW5nQm9EWWpiQm4zYkg2TWFBanlGclRnVkF0eHZUM1J5c1d0VUNP?=
 =?utf-8?B?ZUQ4YXNnRDNVZWM2QXR4QUM4SDJ2clVnN0FodWlKRXJadUplZFFZNmwrVm1J?=
 =?utf-8?B?bXNSZDhhdVo0WGQzOFVNTEFMb1pjWWVNdG83MFE0TFRMbmNTZ3J1QkdFbUhD?=
 =?utf-8?B?YzRScEsxeDllQjdQRHNlNnNqSGRPS3pFZThOSGwwc3FiSmpDS3BIcXNCQ0g3?=
 =?utf-8?B?THZhMW1nMkIzUjFrRDQxM0srdXNHL1p4ZGJPdE5CbmlBMTlFMVkzUTFJTW1w?=
 =?utf-8?B?TkFCWHkvK0w1SWs3eFNlVkM4eWptNnlTTkdIcGdyTmluUEpYOWNXUWJYaFd6?=
 =?utf-8?B?cU81MUNFejNzWCtqWlYzelJWcnc2RkNvR1l1RlIzOENra3QrK2JYTUVIZnBw?=
 =?utf-8?B?RkhHcTd3TkdRMXlzTEtKWWJYOU1CYjdpY1F6LzJLZ3pqTnZyRGt1MEZvRWpO?=
 =?utf-8?B?ckt1a3V6KzhUNzdxb0w1Q3VFcC9aV3ViRTF6TW84ZElVQnlTU0s5aExDSXk3?=
 =?utf-8?B?NjhZK2lCRHZuZHBsTElrc085aDJVaTh4eC8wTStVTXpTampQNVowQUtvWC9M?=
 =?utf-8?B?UDJaRVVjaVA5K080TnNad2tQNTBoUVZnUCtodHRhNVlwLzVCdEFiU2dWbEtY?=
 =?utf-8?B?bVNCS2pZMXZjTlhFM2JXVmhKaGdSNFNqVlB4VXQrSkY1c2lwejdXdStPQTJ4?=
 =?utf-8?B?V25yVmc4dmVuNUhnM28xSHRldSt0N2I1cUNRb25oS1laL3dnT2t0ZW9pSHBo?=
 =?utf-8?B?V0NLYjZweHo5OEJNNE9Hdlp2R3Z6S0RrZ2tUdnJsVkVRdDZjSzhQWDR5ekwv?=
 =?utf-8?B?cmxFNmxEcmRJSWJaanYxUklJRGk1Rnl4OU5XWDdYQ1VPbXVqNjl4YlRmS2hp?=
 =?utf-8?B?Qlc3UENyL3pEMm5ic3VtbkpiM2VrQVdGNXlvVit2V2dibmRZbzVoWmFiMUlZ?=
 =?utf-8?Q?zpz1TttsKVV2K6PAXBiw6TvmR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae5d7ba-9c82-4779-5583-08daef21725f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 13:33:36.2061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d9gkgIn60sFgMJ72C3qJkalZ6M0XqDN54eFGiXLU6kwxC/G2uvfAc4nGXPerluksIlsvKO/EglNLORQ01FtKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

Two tracepoints, kmem:kmalloc_node and kmem:kmem_cache_alloc_node used by perf-
kmem tool were removed from kernel by commit 11e9734bcb6a7 ("mm/slab_common:
unify NUMA and UMA version of tracepoints"). This causes issue while running
perf kmem on latest kernel:

  $ sudo ./perf kmem record
  event syntax error: 'kmem:kmalloc_node'
                       \___ unknown tracepoint

  $ sudo ./perf kmem record
  event syntax error: 'kmem:kmem_cache_alloc_node'
                       \___ unknown tracepoint

Haven't got a chance to debug further. Anyone aware of this?

Thanks,
Ravi
