Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9926EEB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 16:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjGJQ5L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjGJQ5I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 12:57:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD59E49
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 09:56:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ACRDlZ004918;
        Mon, 10 Jul 2023 16:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AdXWr/MG+dM5AlQ9+A5Ky5ls6nIUCYxETpZrZcjOLOY=;
 b=H0RonZ2HNlIpykeq1RRpcsZ9g3mramRBPlbNL1eLgNg8M0Ec69rWzrQqCqr9nCU1aeSz
 XrIlSl7RCpuD6J3vky7rx3MK8ACLlbfCdUlwtmkAUq5v3SwN1vZEMwNvAUx1vZHJS9XU
 BNN4GlD6E5TbtQfFxOFabXp+EHRpjemvkog6bNVQh6NyEi6t/mSiHecY2W7ZF2neEUfV
 4kdRXvSzvawNV0zpB+Cn1siooeHCWePhgiTBKAgDMA7TsjapfTWHZ4PaLMywgu/5+G4m
 PsR4LpMZ82jy9rvw6ALlKZP1QpRNs4wN2wMnMTHBZexqBVzW8Xm0BVz5/nYfagDbfSF+ 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr5h11kp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 16:56:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AFlpij035620;
        Mon, 10 Jul 2023 16:56:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx83qu1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 16:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9L+Sxc3p6eponQScWITYW68UbwsZ8qMwlKfopLcgIxmBOd736mk98lws/SOzpGCrM19FrBrd7HzoIhkf6h9mMtI7YYDq5fFtQnf1LM8Y4W/wqPORgFL4x+ADgAKeLOgvUFtiDBo3OvE05Zbszsvo/3jBlN/SW2emblQBLVvBl7m0geEvW5wJtmaNt7nV/Qf9N6OPlk2JA5M1LPxZk/jlxzM+/xrTrPDfW0YKsB68ex1oehrzEdMHtFzSPoQzBW2o5cjZPGLNdr5wvM3CFkV1LeTAQ92q61zJxmrQ+AHFOKRWKRnsVHTYoLEEii2vk3xQ9KibjirM/qjYfLKfrUXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdXWr/MG+dM5AlQ9+A5Ky5ls6nIUCYxETpZrZcjOLOY=;
 b=ZrJctep8nhZKLDID/NLVU/FI60sVk2UWGWJjagfW9/gkWVErUGbIgnWd3gZnH9cT+MepBeOaJiiXfIMgUW9LRy6xN/hK/0ZTTBa67NP4vhy5aDKzsoE69W4mI3mEV28qMQa5Ft7wu61RPx9I1jR3mHxEt8ubhJeIWk7yRQtk2fN+CJwiQ4gjmoeYqsc18WXz1UGiYiGvXh4Hov3YG4Dy0wJ1BehOFDCTmtFA6U/c/gGcarCyqxm6AWFIk3IJefgKL77Q5FFvGPFerrG/7DaxUZl5wqwzoNbmtOxwUZE3sIb7uUF0rhOWpIRUoBDH3PYxgGj3FYULBbPHd4uXGe6qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdXWr/MG+dM5AlQ9+A5Ky5ls6nIUCYxETpZrZcjOLOY=;
 b=drzL/qvM6mFjPaw7zF0VG/qJ47Z9GVKFrUe3gQ+Y9/SQ/VF1UOXJuUNjlTLMByiC4q3lbIVGerD+dwJxBejt8asK0WOkBHqD9FNTZAjJWUomZ5+/A31w0sSKlqFhIYa0QOwMRXgub8l48s2YDEraxEnomxMKRlaVspnSLkuGc10=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 16:56:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:56:22 +0000
Message-ID: <a35179ad-bb62-113d-3a7e-da4d2ec3c0b0@oracle.com>
Date:   Mon, 10 Jul 2023 17:56:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/5] perf jevents: Match on highest version of Arm json
 file available
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Cc:     namhyung@kernel.org, acme@kernel.org
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-3-james.clark@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230710141903.1595312-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0081.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 555ce6fe-f326-4295-1032-08db816696f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoQywBIIdzay2hdaTe83QLHdnORm8Lga7ACJp46UCCCeKCp6R1H22DNQiOegukX4K9uNQlWwZoD6qLmL3N7MhOy2BHAPe/lA5zD+pNkQSc/+cEmcVRBoxG3N7DnfCa/Bh40DdI+MQLhZngQbMxTu91pBJqMDacMoekmNUaHjLxm8aOpxb05uhJ/lo5xPJzW8WhgDM4kr1o73cDe2iYtRH3+ulaC2TA9MPGXPX4v4oqN98m8WEzCORdIU7See7nynfYYfB0N+97oMz3C5eTF8l0gDYFNSyt7BcsC06nZvDuVbR1aJiTJDlPxAWozAqE05sndWSCyfBtHrFQGfA5ftP8Ujyr/48iIh5fmpkicts+XTELvfiqUvnqNNsSI7cSLM/NcDt6qAgbfehRDR2cNTyRsOJAMtdfDpWU6SjCurfnVLUJ/kbNJG4s4Y9BHmTBFeDLSkrt2aIRDBtxyoFKVVtSoqRnvErPSKNg2err/24C86/C1SVSpBjd3DANZ/V/TlyeqUJ+Lu3MmK/sQhtLqbrJRw3jxbBlD6sEo66nx0qTWQxGftdjPTtQhsW5yWY1uuulsLjpzilKhAEYwQrlRybRUXR4camtXebiE+CxnjooPz0JbisK2JLUUKN5/NVrXJuKuvwMjDrYCGIKlrQbEXLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(5660300002)(8936002)(8676002)(83380400001)(2906002)(2616005)(36756003)(38100700002)(31696002)(86362001)(53546011)(26005)(6506007)(186003)(316002)(66946007)(66476007)(66556008)(6666004)(4326008)(6486002)(36916002)(41300700001)(6512007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2MyL2xYMlZLL25mc0puRmp6ZXkyYjBvaWJiYTZwVnk2bFZKeHp2NVZ5YWdv?=
 =?utf-8?B?VDI0VUEzZ0xiS1pqS0pOTjI4dVRiM1Y0WTViK1ZJOEtQV01kMjVoVGNlbVNv?=
 =?utf-8?B?QWpIOXlIdXphTzhOZ2hiUGJKVnRrWEZmTXNiNDYxYzFKZU9MQ3B5WTQxVnVx?=
 =?utf-8?B?bGFFSUpaVXE4Y1N1MWlJN3k1SmN0Y2RtZ0FFamFNdEdILzg1WFNxb0k3bE5z?=
 =?utf-8?B?N01YQ1JRa3FzRTlDS09lSS9Pd0hYcjdLVGx3MWoxM3hDR3pZQ1JXc1c4OHdy?=
 =?utf-8?B?aFlnZFlxS01LUkhLbGJKdVJhTHM0OHJEWEZlN0RNd0g2MnhhbXhmS1FjWllr?=
 =?utf-8?B?SmRuRnk3cFFzZ2ZrV29OT3ZtMkVzN1RnUXg2SXNZYmM4dURlLzVnVmRYa0hi?=
 =?utf-8?B?SmRIZ0JOMW1BSVhKb05WU2xVaTVJWkErbEV3VFVuOXhHcjN0Tk1kYzI1M0lv?=
 =?utf-8?B?N24veFhvRkxKRjdRQ2kxZ01qdm04U0RXNEVJK3BqRC9OR3l1RDJuTncwU3JS?=
 =?utf-8?B?d1g1aHlMQVFLQlNSUHdCM1lVckpvdmJkaHBmellGellnOVpRR2JXWlhCQTBy?=
 =?utf-8?B?NUc3UDgvdnAvb2s3bkM5MnA5a3V6MHpNYStsbi9waGM4NjBsN2JNSXZzREhM?=
 =?utf-8?B?b0wxUlBjQ0dIVnl3RDU4MjdHYi9JOERqNXFvL1NiYzQ3djlwVnd4WjNidnZE?=
 =?utf-8?B?UXRKM3NkNk1CRTlPRzFUdXg4N0FHYUpZVFlXcndBT1lSOU51Q3huczV0cElp?=
 =?utf-8?B?SDZsV0MvbTBnYThFTENqd1Z5MnJNblhQUjB6M3hXQnVFWVBxbWVsNnlvL0dr?=
 =?utf-8?B?eWF0ZU1pc2hhV3RxWEMzbUhyOVNiclUrdVlCVUFaenI4ZENkTTZjYzh6bGNz?=
 =?utf-8?B?RFhXdTFaSlEwYjZ5Q0JIMlQ3Q0Nqd2tTUmcrams3UzJwTEFCSjFZZkM2cHhK?=
 =?utf-8?B?MUhTak9mOE10Sm53NVF2bWhKb2M3cHd0OG5TMVNOZDROaW01ZHpuYVI1VGVD?=
 =?utf-8?B?RTdKNTVtcWdmZVhSdjhnaVpYdGFrbGFaTU5oT25uZUNFS3g0WVYrekpzNGlY?=
 =?utf-8?B?V3NrdFpEUGxDMlF4NE1MREVzcmhETTM4R2U0dDRzMUJxOWNhZmYrcTFxYnhy?=
 =?utf-8?B?NVBkNnZHbXNocFFuZ05hYmZGWkxqcXg5MnVnZ3dweDZiTU1qa3B1TjFMM2Zs?=
 =?utf-8?B?dHJTdXpBUVkxTEIvMXFYR2JmOElVVEhrOVpPNmh4QmVhOFlVakdzZXNRWHlD?=
 =?utf-8?B?c1puNEJRUzZDOWlIMUprU2syNjFBV1JyNk9EZGYvV3ZIQUlYbW50VThvSVY3?=
 =?utf-8?B?dmt6eDVjRlRjT2EveEMrbENxRTFJZFVON1dmbU1jZVAwSTU2VE8vWmJRbWFo?=
 =?utf-8?B?RVlDaVU3WDFEc2dpaHNtOTVDcURxalFRRnkxTFk5RTltbmtlZVpWN1dlRU5p?=
 =?utf-8?B?bUdiTkhMdUVLSm5yYlpaWG1sVzdwL3FlN2NJK3B5eElDMkZXMjd3MW5STGdB?=
 =?utf-8?B?UVBVTFRuWHpvTTQ5ZHZ2dUJpWDBFZWZzOFdjUXZjMjBHOGZ6dkI4NS9nc3Rj?=
 =?utf-8?B?by8xbXMyTVBzQlI4UE1sQ3FlaUJwMkJuZUp6aHBHbm1BWjdFZkxzRTU5Q1Y3?=
 =?utf-8?B?YUlKbm9Jbm1xOGROZDJEQVNYMm1DakhqRUtqc3Q3R3dZbis5Mk96Uy9MRzhE?=
 =?utf-8?B?Z0dvcWZZNzJRWkErZDBVbGhySlhwTU1TMEZRZVlFTU5HQVlwSnFGand0ZkQx?=
 =?utf-8?B?TjRzb2NRaTJxa1BFMUx4bnNjeUhhTlJSWWF0aDlPRjB0YkVaRlNmbWZCeHJQ?=
 =?utf-8?B?ZFNBM25DRlEzbnNkQ0dYczMwc3ZxbysrNmJ2TEFaNjVSVllrV0pET25pdlNV?=
 =?utf-8?B?YVdsWFFYZldHZFI5ZlNKTTR2YVNxeWpJK0FiL1NEQkloS0RQMVoyS3RjcFpi?=
 =?utf-8?B?b1Nkc3V4VVZaWGkzWjg5bUU1OXNUbTJvOHl6UElaZkJudWZEdlpTbWhCNDJB?=
 =?utf-8?B?MGtDbDUvOWtTamNDbi9GRVpDZXhrb2h3bGJhYVNqbGV0TFhaeE5ub1VpUmlJ?=
 =?utf-8?B?dW45M3NoVVRGYTZEYjc4b3NNUjRDNlBJa2YyZ0xoekRYWEhTUEtvTW5ETi9J?=
 =?utf-8?Q?MNJsa6qeau1SfwL3kdPo+GW2R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Mmd2RWlZQndGVW55Zi9lK3RRdjdKZ2VPYUU4QmVIQ0hqZnN4S0tzMWRwV0FM?=
 =?utf-8?B?UEtUNDJaTWZMMkswNTJndFhGY2U2d3AvMVZkQUxhdlFzbVJ0VXhPSWZzc2li?=
 =?utf-8?B?MWhUcUxJM2dGL3h6V2xqTkRBUCtSWnIwNGUxa1VkUm1vOWxibmdLYVJjMHVn?=
 =?utf-8?B?RGJYQk1PQkNHZUsxSG8zMGpoeWJtbEZDTGYrRWl5RzBLNEFCbEYzeFIzamhE?=
 =?utf-8?B?NjFoMFZYMUtRNTJUbU1iVXExQlJvcnJjYit1VXhBeDlZN0hrNDBaeUZzekVo?=
 =?utf-8?B?azhSVC9KVCt4SHIvb2FjOUpiUGZRNXV6OWF5UFN0UGJMMlFmV0V0YVNRT0Vo?=
 =?utf-8?B?bVBralJ1ZXhpTDFGajFoZ01KQ0tlaTJCS0lhcjRlNmpEQWFCL2oxa1k3TmpR?=
 =?utf-8?B?RTRiZlYzWGhKN0pxSWJQMW01bCtkZ3J2N0l0N3orRGdZTklmSE8yTjd2NXN6?=
 =?utf-8?B?TFR5R0FLb2wwd2N6TjNMaHVaUHJ5bjFrYW5JSFppZzdJWnBqRmlXOGZSckdL?=
 =?utf-8?B?UnBpWnlKeU1ObWdMTVFjeC9Fa2cyZUJRL1lZVlBuelpUVFdtd0JPZEczbUVq?=
 =?utf-8?B?dEE4OEtBb0QxNWtSMDJsUUNuSkxnKzNhN2ZCSk5XM0F6RDcvOUI4cE1lV2xv?=
 =?utf-8?B?cEFJc2NTcnZWdlRkN01QcjBLNW40ZWxpcmZEYWZPR1FzeWdHeXQ5S00vdnNT?=
 =?utf-8?B?N0haR1JBRVNuSmRHMS9pV3dIYUVyaDkxTjVRQ0hrMGdnY0dYb093ekg2SEta?=
 =?utf-8?B?YmZEWmJKZURQZmlkWVl2NjR6TmVNMmNBQmtrUkxKby90YXVKYzdqSHlJZGRy?=
 =?utf-8?B?V3BZU1dnaFJtVGcyRy9Fc0d3WHMwb3NSTkJFU0pXM1VxamlPZGhRa3Z1aWhv?=
 =?utf-8?B?dWV0bUZZSTRqN1hSQzNZb0gxNmZMaE55eUJpQkRwbk83aHVmbXI5Y1RsNkdu?=
 =?utf-8?B?OVYzTVJoaFVhc3FoSkxGejArMGxzdHU4V1d0dzIrTGVlL2djcEE2S0VSUFpM?=
 =?utf-8?B?WmppWmtrOTZBbUI5Wll5emJDRzMwUHhyekhsSHBmVzNpWm1sWGluMmR4VTFG?=
 =?utf-8?B?RU13ek5aSkF4NzFGYlJCSEpNN2lUYjR6SjFiNHZraGYzRzZ2OU9MbjdJMVZv?=
 =?utf-8?B?d1R5cFB0dnBCVTIvSVViS3ZnM0p0enhWUmhpanBKZXdQaXVwazVRaUFjZWpG?=
 =?utf-8?B?MTdra2pmWktlb0RCMnZuaWk4TnFzOEw1K2lsdnlZVGxoTnFBa0toUFIvYzQy?=
 =?utf-8?Q?qY2olUIGu4LG5zq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555ce6fe-f326-4295-1032-08db816696f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:56:22.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/gmeZeTbr7NfnsDwqxR5E7AkQPxU7Dwl+r/szlXNVp9EpofAu7do2Y5iB//3mhW+RPjEiA85S9eI6iAMC5Ysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100153
X-Proofpoint-ORIG-GUID: kvCBYMNo0JKQyV_HmTmStY8FWPutzEqX
X-Proofpoint-GUID: kvCBYMNo0JKQyV_HmTmStY8FWPutzEqX
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/07/2023 15:19, James Clark wrote:

+


Hi James,

It would be good to cc some additional people and lists.

> Currently version and revision fields are masked out of the MIDR so

Do you mean variant and revision?

> there can only be one set of jsons per CPU. In a later commit multiple
> revisions of Neoverse N2 json files will be provided.
> 


> The highest valid version of json files should be used,

What exactly does that mean?

So it seems that you have CPUs with matching MIDR except variant and 
revision, but have different events, right?

Then to solve that are you saying that the highest version of the JSONs 
should used, upto and including the same CPU version (???) - correct?

The cover letter doesn't mention anything relevant :(

> but to make this
> work the mapfile has to be reverse sorted on the CPUID field so that the
> highest is found first.
> It's possible, but error prone, to do this
> manually so instead add an explicit sort into jevents.py. If the CPUID
> is a string then the rows are string sorted rather than numerically.
> 

Thanks,
John

