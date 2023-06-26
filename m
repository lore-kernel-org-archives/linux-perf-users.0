Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C79EB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 17:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFZRt7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjFZRtu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 13:49:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93061B0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 10:49:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QHNAwJ022155;
        Mon, 26 Jun 2023 17:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=R7JCMXsvJSLj+jTwUT8LDLMJjDlW5NZR1Y72qp/+nBo=;
 b=uMitMsk4Jna8bSO15N9n5DF9ZkbkJzerRaeovjiLz/qniqSmgGiWnNxbcB567vf9D7Yq
 pYqZ87ShCA449BsepOriCMUR/iXH/OrMwThyV7vCTiFUme3udlet5p5fhBgxvLy7D4On
 xdYbZRwJoWZc+Zgm3ZD3BVYNAU3mxGZkttcCIpHS7Xp0DLLwW5xPutiD6BF1M0CQuqO9
 06PUjTYBPWVokL6T98K5xovSvAK2rMUwZKpTv1jmyyRNrLJIqZtku4WToNY0mSY4YIuH
 Cb/+1oZRcuXyq6CcKGb3jxI7MAu7ZtGXTxy2V3poUUNA4jOQS0UNtGTcpusvxTuoLJ3u BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca34hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 17:49:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QHhRie028396;
        Mon, 26 Jun 2023 17:49:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx3dtkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 17:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXa1WPtowGAyfPZlc6Y/wMci5YGOA+fIAWVe5mUpr3gmCgYBGlWLNbNpEQ6M9v9QIZwHkVFxRTvt78Pn5zTPFxfeV8hubjVeaz6iOm+Zw/Yus3Utpvwrd9WIa+GmWchRTtkz4TB3qDdahIG8kKCmkYSZ5Qnjf9qdO5gfeWVnO8mmmR1IQeq1T/F3Kp0d9m0EpoXmzX21hW+EWQv4+zf+p90+MqEJEh731dcBxhC63lIxazOnFYiLqivz/qejxv4ZVI54lGUC5YJ8aLVEIBDIVxvZNNekIatljSo5dpk69vzm2HcbJ9NIHS9UJlbVRFGs2joxr5u3sd1SYqRuHjpv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7JCMXsvJSLj+jTwUT8LDLMJjDlW5NZR1Y72qp/+nBo=;
 b=FMHC0/jPsbYn2veMfRnPMyZAH+dzv8tdcZNFYh0z5HF0zdLy5XQTibbaEr0M+ER5vJwtoaEirNt4azMsGfZCB2qPftJID0KWu1VBWyiqsLPLfvYyF3LQuGeI70D/0u2ThEzg5fxaoIKWbr0KpD5XhfE5ks9qxCq8tSfUDXiW7ab67HoFoDc6QpTSe87JXjcCyYeVqb6+MM2VCL5/XRJesa3wcJOTJiMc4cfM+8KqU2KW9DJ3cyl9h+FCWepK65msTmf4Jv171YuUyHF/UdpWxdOxbpy8EUcA0NjBfNiICevBfkXRRMOybLYjwPnehWanBvr0RoW4vDbyoZnjn9B2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7JCMXsvJSLj+jTwUT8LDLMJjDlW5NZR1Y72qp/+nBo=;
 b=n1T2wnVFWcXHfToBGrN0secUTwRatWYYbZzoW82J6TOBQOwY7E8/2G6XOpSAcoT7HPVMWzNgWaGGjCXzUKLXWWyzWLM87cp5EcjkZnD0BD62zGvXemXPFkHkraIeB8qFmosMVfJz60nxI8GBCcSW4Fz7ti3pkSZg7A8p9eCKJ4U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 17:49:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 17:49:40 +0000
Message-ID: <918d0318-59de-6423-3ead-5172c9870ca0@oracle.com>
Date:   Mon, 26 Jun 2023 18:49:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: perf test pmu-events question
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org
References: <151a8677-3259-0586-03f3-fb751782daa9@oracle.com>
 <CAP-5=fXDVUToBbS6z8YY9K0vh5Z=PHh83RZXX3=NugTEqFeXzQ@mail.gmail.com>
 <5bebf78f-15ce-7aaa-eaed-41cd49f53d68@oracle.com>
 <CAP-5=fUjPAmisSkfPJUzorrev2FwWMeMHBBXF1Sh2WfAg8KHzA@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fUjPAmisSkfPJUzorrev2FwWMeMHBBXF1Sh2WfAg8KHzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0011.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: a46a99eb-c05a-4d3d-7b89-08db766db74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aY0cVepovpTUMeQe8FRWcszNF9HdHXi1Z6TforVkYbRM/WRTZ4Gy30RCYVnuMACrpDa1gpRLbHhS/vh+yt+OpOByvKOc/DgfkDhAzRUcyCHNHDNUEfGn8KLOXxx93KxQ+0zLScdXS20gXYGQBdoqSqIoTZ4eERFX7/dIHUUbBGen50k7gdqXVKjm+64d0GxMNvQWutC3M9w4GDtPHRyUuNk73A5u0boNTHm9FBD9zW9m7qiBrf6vBW+zPC+ewM2pcljls/GAev3qoy4/b9pOFg+iJ79X4I4ip/oOmLgiEG8sDV5ga37r4sXDWKg43vuMJtf7PPuMabJP1y+lBN2fapYQ5OBsWENTmkcksA1fdy/ZjKqyh2TYzxJCgZr6mWYYFqrVwi7OJpcfabhdRG+qbuVLpNKUBQJMiXuXZ4sbtg8CM59KydT9UjQVDulKF81Ly72d/TQR28Clhw/hqOpHFDRXn+TPm1bQQUhO+LErqegKCtX4vAD53zz9y6BIcnb6hEyjuwdSzYo5izihGLFdYhaCTv+WcO0Oo/JDFj5lt0ZKsogda8McuUSpZi1qy5OcImity/+ikKZsswH7q276sty+zJp1wPOtyaZkKyR5MWnbS1KzqGTR2CN0MH5BylZ/225NlTYCDmZdOZN9d//nUA9Anxb3grMtFgqQCukk8JD/KE9wm/zTATPrV1pzC8l8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(38100700002)(31696002)(86362001)(6506007)(5660300002)(66946007)(66556008)(66476007)(2616005)(26005)(6512007)(186003)(6916009)(478600001)(2906002)(4326008)(8676002)(316002)(966005)(36916002)(6666004)(6486002)(8936002)(41300700001)(83380400001)(3480700007)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUF3MS95TnlqUFNYMU9Fa01hajBCMnF6S04zVUJiRDNxZktVbzlGTm04UVBD?=
 =?utf-8?B?UHJkTmszRU9ic0d6eWlOaXpjTzAxZzRPUWZ5NVNoUFExVjFHWW5JVG1qQTU3?=
 =?utf-8?B?eEd1M3hDTkRmL2RXeUJkdWhHWnQwUW9mOUlDaUxhMEJzdi9BM2RjaDFtQjR6?=
 =?utf-8?B?aTRxdk1DMGRodmxzODZXbkdjT0gvNDR1NDNLbVpPOUVqaG8zRlpVMW4weVRF?=
 =?utf-8?B?RUFEcTVyemRsM1FVMGZyNDFGNFQ0T2hHWXZ3ZjUxNTBpNWo2MU0ySDdCZ1cr?=
 =?utf-8?B?MUdwaGYyRWE5MTdCTkhiUkZ4NWRvU0pVM1VNazN1eHhZTVo5YlEya0NYTEFO?=
 =?utf-8?B?K2JUT2d4VlFNcDRINzlCVDNxUncwTWZqVkdqLzJ1YTRabHZycmdLZ3J2NU5p?=
 =?utf-8?B?SXRBZWU0WEFaV1FiSExPZEtWcE5SU1o4LzcvV0ZIOGFIMTVlelB3M1NkcC90?=
 =?utf-8?B?KzlRVXdIT0tpZStXaVJLS2VyOUtFbE9JTnY0UEpWTE1jMmR2TU1HRWc4Mlhx?=
 =?utf-8?B?MEhmcWFqVjY2YndDM2QwWGl3andQZG5ERGVucld3TTFvMktzNkVSUXJiRFZC?=
 =?utf-8?B?V1JkQ21BYkoxMDNxaWlpZGVNNjlWaWxuZ1pIMDlXL2FTa3k5c1FkUXdJRGVi?=
 =?utf-8?B?MzZxdHh0VHJoQUlVaS9FMHBqazNVMGR1UFRVOTlDMHZydGRta1U3Q25FV2Fk?=
 =?utf-8?B?dWpJQ0djK3hYdGxJeDIyY0dKL1lTNUVyVWlUbXNjYktUME5XQ2UwQ2Y1QStp?=
 =?utf-8?B?bWgzZ21ldkdjR0E0dG1GWWlqeVQvWFpZQU1SSnN4Z0hmcC8xNlBiSWorajFB?=
 =?utf-8?B?U2l3YmY4RGFSWUk4UElFVzZpOUxhRUVXcFFxSys2ZlVOVDhPUFJsa3lkaHRz?=
 =?utf-8?B?MnNPUldQekJDMnlpT0pDeCs5YmtOeXJwSUJjSVlzZXlXMzl6UStIVUk3TVRt?=
 =?utf-8?B?eGZPWlhPWXJuWG5UYzFPQ3c2WG9MM09JakxyQUppNndhbDNLZFF5eVBDV3k1?=
 =?utf-8?B?eTNsVitreGZHTVZxa2xjYlRVc0t5MXpyaGsyNXROMlZEeUFMaHJpUTlWZWcv?=
 =?utf-8?B?U05udy9WN2tkUVd3V24yL2R0dXU2WjZCYlFPcG84cDJRVDNJcWphb1J1eTFk?=
 =?utf-8?B?a1FFbks0TnVhL2JEVWVSRlVTU2wzU1VUeHFDeTQreXpMOUtRNGxQM0pGOUJk?=
 =?utf-8?B?VnQ4Nkg4SUgwLzhNbkJ2L292RlZ2NXdKYnNCWXo2OGFUbTQvQkRoZUk2cVlK?=
 =?utf-8?B?QVR1ZW9oSElzamdtb1AwYnFpeFdmWHlQWmUwbjVtOCtxNktEY0VYdTA3Z1ZI?=
 =?utf-8?B?TGhYU1NXOHVXajJvME8yandCYklvUlJBVWppbGpFYWxOUTFqTDNvQnp6enNI?=
 =?utf-8?B?TVN0UmNQeGVmS010L1poanVKUjFHZUJnV2ZXKzJyaHhNMmJHUm9TSENqQm01?=
 =?utf-8?B?MUcxYllJOHVkU0pSSWEyZFJ4SFlwa2FodGRiaHBKTjl5OXgrQjNmeDJDbFNH?=
 =?utf-8?B?OXNNWmlmMkZDcXZIWmVaeFRSZ1dzdW5PbDZqSCtZOWUyWmFTYUQzeVd3YSs2?=
 =?utf-8?B?Qm1XYUl0K3pNSjZ1WXhCRmdMTXo2NWw0QmJtZHFkcVUvazVXK0FvOE9TNU1o?=
 =?utf-8?B?M281WnFOTDJ4ak1mY2t2OURvLzhxUWFMdHE5alZOQTZtVk5QNk94NTlKRUhU?=
 =?utf-8?B?dmxqazdxRmcrMWdNWEsyQzF2UW96T1lsUSthUzVyd2E1T0hJZzNuRTQxNHZt?=
 =?utf-8?B?QTF5ZFQxWHpma2NrVXoybUxBSmgvcEdWbDhPQ0EvaHNhMmJPMGpVRnR0TWdQ?=
 =?utf-8?B?N1pEUy82MFQ2YUkwYXVhZlR0cVgxY0M4VXRJZWdRU2dKdzIxY0hUTUVuSTlM?=
 =?utf-8?B?V1JjSUFxeWpCeFlTb09lSU92OERKdUNHSGZWUmhrcHBPZFZqZXlIdi9ldGM3?=
 =?utf-8?B?dTNKSXFTUDNQVUcrL2hYblZ6VzQwaHhOcmlVbVR4QzlxMDkxWnVEYXd6Q1Zm?=
 =?utf-8?B?ZlplNm9renR6TktwZ0ZtZzJBV1VqWjdIRmNQcHJnUUcrcjIvTWNjS0IzWnY3?=
 =?utf-8?B?K0hxOHAyQkJOWG1lSlVBRjRHUmRoR1U4anQ2eFpvUDZaT3J3UE5zZTFpNi8w?=
 =?utf-8?Q?oeyPw2wH0l+qCOuS1W9XwDDDe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2ZHv2IhfbjzqdlJ9X+5ra2wprxVwCQljuWm8kOK0taNiIU+tXrzAEF/JydeKDewU7j7I6b2Okij8D83MxgP5Bl1R4etkT9+iKw1jnN40uhLtPN9M/HNZlx/bqyhzdWMjreDRpzSHTgQXjE6eDbsI/uNz1CO+muWXnVPaQFYcebQvDaRs0paImyvBmeJRhLEFXJMdvTJ+4oO+uWdsYFQHDhmnZdj51toOh4kFGJ1c/7ibFj81OU88M2XQys9rxLp2aqxx2q42Fnvd8bW1s3IiWM9yxD90LwJtg3mG4jEcrZBJ2su0gVYUPjQE7Eflc/XZk8+tN4pg3lVFI1IBw85kysf0PDLa3nCpM4SWJ4CfdwLE8oO0pg1W7AO6iGLl+u3T2e+1j03YSsqYDEJTKJeLyplOlKVcdWWjwKOP4pxv0o1z1JVyBwi9ILozuDVqGPsJC6gDlviXfvDs4PPVpm+1zDetxOShReMYfXoFbeEZSHcPC5ot7BJI25h9DIiJ9UcEE9dChQV0nAqveElBicHdzPUudRB+ZmbUp54kU2g9tU6OzxoJRm2JfLJGNq3bZkLtBZipRkB9tq57Zdx4OvKMxcYfnzm59zH+SIcPpSvhI9QIRQDVwgl+HYqRT9orpfURR4ylWlcENR53LIWR4hGTXxWmmy74gwQrZgZUcEEZT8xIxAY+RnHnhnVimlJNRcYej77G/2w2Wsb3oLrylvMAGTbu/fqteQaMcpVTl8nNFKi5dRVutI9rTl8oZLBhGCa+VLgeIItdHiwgooWIhE0Nh4GNNlyTlEirRbaRNXcuv6tG0NGbgn/ayHC7tsnmpyob
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46a99eb-c05a-4d3d-7b89-08db766db74d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:49:40.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZJpLOk67RXxuqzx0EkZKgE0tRJLFxXdKOt0CJtXakZ7calQN4Ib8WeNM758dRcniO06szjur0t7S71BmiEBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_15,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260163
X-Proofpoint-ORIG-GUID: pGA2At9w1cUUcuEGPYIOCkF7GN2ybJlA
X-Proofpoint-GUID: pGA2At9w1cUUcuEGPYIOCkF7GN2ybJlA
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> 
>>> But still things get messed up, such as PMU names being mismatched -
>>> when this happens the JSON events just don't appear at runtime. We
>>> could try to replicate the event matching logic at creation time in
>>> jevents.py and that should do what you mention and be
>>> multi-architecture.
>>
>> OK, that could work. It is limited to testing just aliases, which I
>> suppose has some value.
> 
> Note, I'm going to try avoid using the name aliases as it is
> overloaded in the tool whereas we tend to just mean event. It is
> likely the code/comments in the tool will slowly migrate to my
> preference :-)
> 
>> However I am not sure how well this would suit testing sys event metric
>> support, where I want to ensure that a specific event alias is chosen
>> for a metric in the same pmu_sys_events struct.
> 
> Are you specifying the PMU?

We specify the event, which obviously includes the PMU "unit" and 
"compat", which we can match against. When all the events match in the 
metric expr, then we know the metric is supported in the system.

I may send this series as an RFC and maybe you can kindly suggest what 
testcases to add ...

> If not there is a danger the event will
> match >1 PMU.

Do you mean match 1> homogeneous PMU? Or events for heterogeneous PMUs 
may clash?

If the former, then this is ok. If the latter, then this is always a 
problem.

> 
>>> The metric test tests every metric produces an
>>> output, and this fails when event parsing fails, so this has
>>> traditionally been the way to find bad metrics.
>>> We do have build time
>>> tests like:
>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next*n30__;Iw!!ACWV5N9M2RV99hQ!OKyD56aIReczgaPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd882X6fEUE$
>>
>> This just tests invalid metric format, right?
> 
> So this specific test is checking the metric code passes some unit
> tests. When we parse metrics from json, in jevents.py, we use this
> code and it will throw exceptions if the json metric is badly formed.
> You probably remember seeing patches fixes parentheses.

yes...

> 
>>>
>>> Intel don't have JSON encodings for the TSX events and so they use
>>> sysfs events and this is what motivated the has_event test:
>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/20230623151016.4193660-1-irogers@google.com/__;!!ACWV5N9M2RV99hQ!OKyD56aIReczgaPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd88rRd1z5c$
>>>
>>> Some other thoughts in this area:
>>> 1) I'd like to get sysfs snapshots so that we can get things like
>>> parse-events coverage of heterogeneous PMUs without needing such a
>>> system.
>>
>> That idea would seem good to testing other sort of uncore PMUs - for
>> example, since I don't have access to a system which supports sys
>> events, I need to bodge the kernel to support some fake PMU kernel
>> driver for things like smmu pmcg.
> 
> My thoughts too. I lack a lot of heterogeneous systems for testing.
> 
>>> 2) The largest part of the perf binary is the json data.
>>
>> oh
>>
>>> I'd like to
>>> convert the json data to a sysfs style, then compress it in a way
>>> where we benefit from duplication between files (zip can't do this,
>>> but tgz or 7zip can). libarchive can load these formats from memory.
>>> The current json data on x86 converts to about 7MB of read-only data,
>>> but the same json files compress down to about 1.5MB. The perf binary
>>> is about 3MB of code, so doing the compression should hopefully make
>>> the file size about half what it currently is and do something to stem
>>> the problem of the binary slowly growing over time with new
>>> architecture releases.
>>
>> ok, sounds reasonable if slow binary loading is really a problem.
> 
> The time for perf to parse events I will probably regress with
> compression, because of the need to decompress. The file size is an
> issue that comes up when the binary is installed at the scale Google
> does (both devices and data centers). We're over 10MB and edging
> slowly toward 11MB as Intel add models.

ok

> 
>>> 3) I'm hoping we can do something like a unionfs with the in memory
>>> sysfs, on disk sysfs tar balls and the like, and the machine's actual
>>> sysfs so that we can just have one consistent view in the tool.
>>> 4) I want to make PMUs lazier so that we don't need to eagerly load
>>> all the events. The cycles event doesn't need json or sysfs data, but
>>> it is all still loaded due to wanting the PMU. This faults in a lot of
>>> JSON data on x86 that is then never used.
>>>
>> That should be pretty easy to do by only needing to setup event aliases
>> et al when we have events which are not from known config terms, right?
> 
> Yeah, it feels low hanging. The code turns every json event and sysfs
> event into a perf_pmu_alias when the PMU is created, the events are
> sorted and then we search them at parse time. We can avoid doing this
> and search the jevents.py created tables instead. This should turn
> loading n events into log2(n) for the sake of the search. This will
> change with the compressed version, and the behavior will depend on
> the compression format. This is why I like the idea of punting the
> problem to libarchive.
> 

ok

Thanks,
John

