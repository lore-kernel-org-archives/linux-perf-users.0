Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACF1C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Sep 2021 19:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F1C61158
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Sep 2021 19:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhIHTPM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:15:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4622 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231734AbhIHTPI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Sep 2021 15:15:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188HxjI1001118;
        Wed, 8 Sep 2021 19:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xls928j7NVCGvsk1MD0APqPQtXKfHCyip/hPQEf7l3k=;
 b=PuXkNsTqs75dJ9L+UR7Ea8XnitY8fMqB6rFXSZuvYxICTk+/BzUFqleQONPrr/UOT5fP
 cIgQ1DvIX2AOJVm0Jc4xPDz3YKImmmkO2gBXgw1b8dp3S9IaC19QOWJ3OyFtcXHGRtz8
 6wAlwJUTz+RuURA5IJq7Z1bPIIjH8MAyFk5MeBYYF5vDahagwmp4Jth+gDLMF/6HcUTC
 dtwn4R+j9xf+YcrAhlVgj9NnT3uuFQaVh1FDurLdhIl93qCsdyxEP84v5ViZOCdn9On+
 7P7X1DS32++cq6x/N9uG/tza4AQhbj//kHY3S+XzHU5V21fsJ55UgeY2ywfd1U7hRPnJ MQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Xls928j7NVCGvsk1MD0APqPQtXKfHCyip/hPQEf7l3k=;
 b=RchGhykINCEak/9VNO+mocW1afzqYgY5+EZ1J0lYQj1bM2FDhcHMRx0iaqXgSvjSB8A/
 5nnUttf5KaaM7rVMtMBPsOhKjy8I0iU/6K1Hw+uir7xsyn/21vNJ16/U86qkVGv1jFZw
 vSDh7a3NZytZHlHEVJxP7ZRNpkk+2Si3InvIrzTaYfCZtB7mwzkr6yy4qv9hTB0ff2c9
 FVde2r08JpGNvq2K01KZ6aLVMBASArJSHY5EOQrXVvqqJemNnOoI6j2z+msCR4c1rceO
 CycQmxO3qP5Y/sDx4KOzj5uTsOWtCeuV3gNxPUj9/s0TE8k0mKoePay6WMbshHE5pxoI uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs1brbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 19:13:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188JCDDJ102616;
        Wed, 8 Sep 2021 19:13:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3030.oracle.com with ESMTP id 3axcpp6n3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 19:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqfSs75xlEodvWnRUs6hhlvH2iYazJVHhcXDXXRTYwVa2toilje5dkv2mQTSLySattZv1ZaoRyJnuYQ9yZJ85TXi0rddMKGP99F1TKq64OQNMcMt3/ndr5/3TSr7SIQxInADeD8cEqlBAD0oQfU6dGDYQ3OgVy6wupCZhA5yOci+PS1rIbFh1GXnQtXdYFIhsf4/fSgqaBBwsvidqGp6juzHRTS2GxRQbQ6z5QNiAbp8VYPBUma9Aint/eQU0VPR2eTWfovMRqUGfA8SJq89chRFlp1Wh4uaJcdkw/Tiqlkcvplzb8yG5IbFW1ASzlpUaua/3RoEeaeYeI5ljWyi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Xls928j7NVCGvsk1MD0APqPQtXKfHCyip/hPQEf7l3k=;
 b=grjPI9x5Vzbi4W/+lLvyomuzRUBkyoVxU+ZTezKyPRMMVduWEM9WhfROUyyt/H0HoN4DfWnXkmCIO82sc2Srf2KT4fIVqBejyqIREbQdX+pr6YNHtGiyU7N+GMdPagKHsU/fyWMqfJZ5q7x/D41M1ZX9+MipF11CJZyKnV7hg6Qe7Z2uI3wZoNCAFmYwvj3hJj5cXx+YCWdbLt1a6gUJN5z3MCxk+N5zRW+mLgEsMPG5JuPryrm0JNmX0Dag3HogXr2/UFMpjWfGQiBkCgxJIHKAH+MCkQ4My7bgSs+HTkFbPD0ZxVQjeYNI0uSffpygPFob8YX7tlRam486nC4Zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xls928j7NVCGvsk1MD0APqPQtXKfHCyip/hPQEf7l3k=;
 b=Txe8rFA0JSxcZrpc9GFzXwivzCVQOr30tr4sx4D0ZETnNUOQvvQNB+rdY8XtQpSm3ilGbdg2Baj528AoszempzRiVbAe1b1u83DWyO8Vu7HevyeOf5PoPVx/r1kiSK+l5ytodQKX2Yia7QPeiMQ9ZNPCZMiRffUrG2RtQkq/RlI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4841.namprd10.prod.outlook.com (2603:10b6:610:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 19:13:53 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%8]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 19:13:53 +0000
Subject: Re: A list of visual Profiler UIs for linux perf
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Mark Hansen <mark@markhansen.co.nz>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
References: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
 <CAE40pdf7n-YzZb71CvFmNFtCh3eTiBfAtiWxdJQLQRxs-hVUmA@mail.gmail.com>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Message-ID: <9e717abe-d923-d88c-90b6-ca589831d157@oracle.com>
Date:   Wed, 8 Sep 2021 12:13:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAE40pdf7n-YzZb71CvFmNFtCh3eTiBfAtiWxdJQLQRxs-hVUmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from stepbren-lnx.us.oracle.com (137.254.7.171) by SJ0PR13CA0063.namprd13.prod.outlook.com (2603:10b6:a03:2c4::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7 via Frontend Transport; Wed, 8 Sep 2021 19:13:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a5098b-776a-4ecc-db60-08d972fccc45
X-MS-TrafficTypeDiagnostic: CH0PR10MB4841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4841E525023CB860F09995D9DBD49@CH0PR10MB4841.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9Ic33MsO6yI8WbXkGwRkLXVJov1e38/4+nZD3uDXB71uXoz3vhnQyDcuq2TFOs2IN5txfUlrrsJstytvjtynLoM+5yacxOabI2mGsxhr5Wr5MA7HLZ0xrwIz6MlbgqqsROWRTPMY/4qa4Ild0W1m/Eid648YciFrPGtCFSG4dwHCNr0WaJiFGLFdZSQCZOARzCD7bahIq/KLLqFIJ28Xw9yMNSFD3a0WyEFf740SFml/p48kL8KTrmSoLmxJlEagVf2Bjdbif2ySqgiYPIEKvYeftgHq0UcUjjqoq51tJur2K7oetexxpUaSYhqJRzYixZnMPVEivMiZdbh3Yc2+P11J22rG6xb6rKOWdV5h9Jo3kgrA/bDhKSkxdQxJEYgMRiNV545O5JF8kzMVEJ/BgjMwxgvZPCp0hV0Smy3UnOZix3Z4Lrw1TsBCAmaUN/58C/sSPOCW6W06tdInaft5+AXnG/vuwLRg0JfOvA95n8BriQT42qAZKiIYRQTX6T/PDXCpWHmZGUmZj1RJDIStOiG7bEyjoJhwemWm8PU196MgykbNgYI5Oy8IwhGe0wNjM8zeiydRKN9de0gedltKgWYHnhhGWh6VJwxFHBp9nQeZcHFVaFyYHGR42JcnxqePZHXpiNbEFglxprcq2QSmGaykr+z6IWNLJsPS0E7Cu4GTvK9AZajX6Jcse+nnjk7gme+fgYRhuA5fr1DV5lF0cBHIY6qJ1Jf63A6aIj7AzLnveEpht/0ur8piFFmQS6BbuzI2pXOmZV6uDekDlJbNmoddVKUhTM3qtzBNeXtQvVEj7tF+zDakfVjVmY8koBH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(38100700002)(86362001)(8676002)(2906002)(36756003)(31686004)(8936002)(6486002)(956004)(2616005)(31696002)(5660300002)(316002)(110136005)(4326008)(66946007)(66556008)(53546011)(66476007)(186003)(966005)(7696005)(478600001)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZYY2FFRnRWRXFJYjE3N3R0c1lJREVqTm1xekcxcCtka3NxQkRMVFJsTTRF?=
 =?utf-8?B?SnJNdU5RaDZiUVdRaTBRejUzUi90L1NBNTYxeXo5VHh1L2ZXTzYrUXBqVWR0?=
 =?utf-8?B?cXI4amZwelNLTEVMZXd3d251RzlIeGJ1Y01PTk1IbFFxU1IzdURxL3ErYjlK?=
 =?utf-8?B?SnV6MjV5Y1M4UWd2LzlrNElUeHJnR0RHdnV5RTJJcm5CNk1TWTlHaFlaR2lY?=
 =?utf-8?B?NTZyWWl4dUN4bG1CV0pUTXNlUVg0Smx5ZVhVelpmcVVDRmJDTDRzMWVHb2E0?=
 =?utf-8?B?UlJsZHJjRloxcFlibS9kRVBZSThmd3BQb20yUklabGFlNnYyQ0toZ00wbDIw?=
 =?utf-8?B?eGxsb2dzZ05BZUl1RFFHeG9KZEFpMlFoK0wyaGpUT2c5cmZ3a0tYcjRVZU5W?=
 =?utf-8?B?MUoyM09sOFZRRk5zSWhuaGQ4ejZTUUphSVpGb2xua01GblJsc1BweERwTEdL?=
 =?utf-8?B?ZE5oUnZMQ3N6Y3JZN3kxYTJyb24vakZxOWZITC9GSUVJTjJaSGN1MnI4R1Rp?=
 =?utf-8?B?NzlSR0ZOek1sTlF6TythQWpBY3RxditpUmgxTzYxMGRMcGp1NnlESEkweWdr?=
 =?utf-8?B?QVl1cXRrWlYwK0dOaGMybXV2Z1pMZ0JFWGVuUnpRaXhrYVRJWU85cTl6VExB?=
 =?utf-8?B?eDJUUmNxQ1JOSW1YUXpaSE1mam4rMFZzdGg3Vk5jVGNWVmVrRGFrUFVKOEk4?=
 =?utf-8?B?YWwvYWxwT3NKWU1DZmZadldkMnFCL3hJd2lnVTV0YllxalVmb05YN3VTYmw0?=
 =?utf-8?B?WUErclM2RnlETXl1anQzYzJMeVQ2bzVqK29SdXZ2aDBFNkQ0ZEh4YzllSEx4?=
 =?utf-8?B?RGllR0tSSm4yb0J3NExLTmE2RXExRlVLTTdPbndZbWJ3QW82M1ZEcUV2Wkcr?=
 =?utf-8?B?Zko0VkNnZTJVclJIUDdWMVBaV1NvdjI5QlgwbG9BUW5ZSzJLa3dHbGhHRmYw?=
 =?utf-8?B?UzVaVXM4MHdyN0h1WXZxNHpRU2NHN2dPN2RRbFl6YVVwSFVTeEFGcXRjdFBn?=
 =?utf-8?B?eWovWEtpNnFjWlVNUmlDNmpCQXdpVE5WbllaV0VTL3ZTMTc1dktibUQ0dElW?=
 =?utf-8?B?eEh4aUwxSm45cmNWN3p2SU0yaEhDWFlINWlyTlF5M1BybmFxaDN6S3hSNk9T?=
 =?utf-8?B?ZkRVSlN2M3ZJc09RODBZSklRaUI5MzhoRWRibHpNeEtydUovUW5VYTRIUFI0?=
 =?utf-8?B?SWFvZFM4RVZmeHRQby9keUlETk5QMzMyZ0xHdE00STdDY3ZRTmRsemxLZVFs?=
 =?utf-8?B?YUovc0g1b2VQeE5zaTIvNkxFbnZtd2pOWW5uRjVRaXdhbzdTazBXZFNCQUxa?=
 =?utf-8?B?TkVBeTF5QnJlL3Y0TG8raWl2UGRUd2h4cE1uYU1QM0szMFczU2ljQ2QrZTl1?=
 =?utf-8?B?VGNSTHg4KzA3bjkyd0tDMkZMZmJjL2JYVW02WG5GUElXVmg0U2NydStmY2Er?=
 =?utf-8?B?SG5hUHhIZ0gvUURHWi9ZQXA2WmtDSEpVMnhreURHTDREWmV1SkM5OUpBaFpv?=
 =?utf-8?B?YVd5QVJmcnlYak5lSWhDZWFtbzhVb05mMExLREx4UUhlVU9jSi9paFNiQmRG?=
 =?utf-8?B?NzRINndxOUJZa0FKUmUvZTlvaDZjSmJiZmZrUkZLbkpoSnRmbUlNWXc4V2dv?=
 =?utf-8?B?eVZDbXc3akNRRlBBbjY1MCsvK0srWGkzN2hZL3JVeTNkWEhQc2ZOTW9QalRV?=
 =?utf-8?B?c3g5UGZ0TWY2bGZ0RG1XTm9vWU5RSVNEK2U3QzFYcmw5b2xGNXVaWC8yQzI1?=
 =?utf-8?Q?VLKt7GHb1bqhHNtjEfwWbU5aIYWTYKVaEdIHj6Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a5098b-776a-4ecc-db60-08d972fccc45
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 19:13:53.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP/LVQ4a7rSmZ05eIO7kNjjRk2B7bWAF1zAIKDeoe0GurPPLwzAu8UZ9r/fEX3qkGRy1rTJ+kxHj4ijIunF76Hhg7WLjmEHgYjsKHYv8tnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4841
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080121
X-Proofpoint-ORIG-GUID: WbNsHRJo3miINV8KOjrhD-O9hdTMFMWL
X-Proofpoint-GUID: WbNsHRJo3miINV8KOjrhD-O9hdTMFMWL
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mark & Brendan,

Thanks for this thread - it's very useful.

Firefox Profiler is news to me and looks exciting. However, I can't see 
any clear documentation on their part that the tool is client-side only. 
I can't always put internal flamegraphs into a web form on the 
assumption that they won't be uploaded somewhere. Do you know if there's 
anything explicit that says data won't be shared? (unless I explicitly 
upload it to create a link)

Flamescope is quite exciting as well! I can see how the time dimension 
can be incredibly useful. Brendan, I had a couple questions regarding it:
1) Is the box color scale in terms of "number of samples in that time 
interval"? If so, it would only really be useful for cpu-cycles or 
instructions, correct? Something like the cpu-clock which tries to 
regularly sample at a set frequency would just look monochrome?

2) I'm curious if you've considered directly using perf.data in 
Flamescope, rather than perf.script? I've recently discovered the
"--symfs" and "--kallsyms" options for perf. By using perf buildid-list, 
you can identify all DSOs, capture their symbol tables, and create a 
minimal bundle of files to allow the perf.data to be read with useful 
symbols on any system. Since perf.data contains more information, 
usually with less disk space, I've started taking this approach to make 
capturing, transferring, and analyzing larger recordings (especially 
from customers) easier as well as more flexible and efficient. All the 
same analysis can be done via the Python engine in perf-script, without 
need to worry about text parsing.

Thanks,
Stephen

On 9/4/21 11:50 PM, Brendan Gregg wrote:
> Thanks Mark,
> 
> Nice to see the adoption of flame graphs everywhere.
> 
> I'd encourage people not to overlook Flame Scope. I created this
> visualization to address problems with flame graphs: how they can hide
> variation, perturbations, and interval patterns. These are all
> illustrated by the flame scope subsecond offset heat map, and then you
> highlight detail and get the flame graph for those samples.
> 
> Or put it this way: If I wasn't a Netflix engineer, flame scope might
> be my commercial startup and you'd be paying $30/instance/month to use
> it. :-) Instead it's free: https://github.com/Netflix/flamescope
> 
> Brendan
> 
> 
> On Sun, Sep 5, 2021 at 4:20 PM Mark Hansen <mark@markhansen.co.nz> wrote:
>>
>> Hi perf-toolers,
>>
>> I wrote a quick literature-review of profiler user interfaces
>> available for analysing the output of Linux perf:
>> https://www.markhansen.co.nz/profiler-uis/
>>
>> I couldn't find a similar list of profiler UIs online. Hopefully this
>> can help people find the profiler UI that's right for them.
>>
>> I'd appreciate any feedback; in particular: did I miss any great perf UIs?
>>
>> Thank you for all your work on perf,
>> Mark

