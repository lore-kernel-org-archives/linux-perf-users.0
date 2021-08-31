Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4744EC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1455E60200
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 21:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhHaVtM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:49:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8500 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhHaVtM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 17:49:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VIiRs6002293;
        Tue, 31 Aug 2021 21:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yNBxDGrMPLT0M9Ukkso4piTWIOWYtPKDhn8YSPrC8Vk=;
 b=IYtSP9SKsUsMW+udgBdsP+vjGEDILNKZOqHusMexf3IxMM4vI1bTqBiq47NQo3fw3WWd
 HERSUnfBkwaPlyT2H8k+/Ip4qzJQJvGdjaIMxj+/gUHS7qiXjLzGj9jKxxW5d59pZzsj
 olXozOWbbWzsCK0EQhX9SL5uY9jS+87Qf7JmVxNzYEfP4ZeAbzICbhBNXLEjRmQgo+Ql
 +cnY/AyRaaNdgo593qmsQatNvZbVv6HBBMTYmWVW9GuZmUQKKtDVW12egm1uZysCkLmJ
 z1UdcOEecSKzNokU6BVxiBPHDHd8cmm/2rgCV/DyuDPdfoqmXIkOFa/mbnc8ZVgEHx2Y Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yNBxDGrMPLT0M9Ukkso4piTWIOWYtPKDhn8YSPrC8Vk=;
 b=qMEL6VAQ8OQRWRigwpablHOs9svLNtpBcJKf2+hNMOD+cJQ+WAlnB5G7Pzc870Xw/qJ5
 a5ckAVMhltOE8LN8aTpBpp2d8Wo6vkCgs/Xr2hMeN423nNGtf5+KYn+l3MdwdFhQeTtL
 lniqoQPa2EflfjQzWZY/NH4pTjF6M/lLuiF4V17k8v8p7knJNnC87pZ1Kfb7qy7UdoEf
 Rg/M5bYbZjKC0BwoqGlzR01M3Up9P5pVxSdvfx4YFHAVDUBhwVx4vCDtf7oFSKpCnV+D
 jH0dOHwl3/6cdQ9zev46aowIzIERFUeIfRQXEG1y9rVo+CWib1uUPWs0c9EBDXFeIG+A Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mje9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 21:47:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VLZnFh055493;
        Tue, 31 Aug 2021 21:47:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3aqb6emja1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 21:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b20E50yJodevI0K0QwNy0VWpEd9o9AceXMtF6wRhhPz3PpTthWe6lxBqh/qifJIfx1ulJ3Gm9I5UCLT/+tyX1ok21V2VisyI0Bzux2i1gamUP/rXe8y4GfNbykp08WeM3Nq8hQ2zJ/8h1hi1uUBiw7wrjJb9WFE2pDO1/6h1MagTLonNJykhbm27+13AUSRXqouCHMj6TcqpdqUVMSyyQ+iLH1kK7RTI0CdD7aFMi59fK/hqHhAWO/xGx6BYwrFV+XCnSkwz76CZK6afna3x29/9kjLe0xJrkSs6KyYACCfQ9EkJjx75gM0jjxenShlAcCzo2NCK78BA4fUzPfhigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNBxDGrMPLT0M9Ukkso4piTWIOWYtPKDhn8YSPrC8Vk=;
 b=V2l1QdpPZWpH0cZNfQB2EGU5RlF2VsbjqqqeUjWXzWWKzlxzWB7++8XE75STB1LyqaWAoxtyI7MGoO+4pDZQ92+SVmz6YtvEpFZ6LZotKsgn9RhUjeZiG3ejclhahRBGbQQPspJ7CyY9/IerEzxm5treWYOtmKJImE50U46PcY6F7UvmMKqE9LKQOhPJeZT6SWlE/dZBlVE4pyEBSKcuONQyD9XG1G7L1csJLxhaTBNXoAE+O7d9UVZeoRuet9y6FrpTDB7gJOhVO/GFmCQMfLrfIfgXITu3QoHLHQle/Nk5qAe+sy9YQVZXkQxxj8Pb+yCmHjjwT7VqJ3oOXiHwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNBxDGrMPLT0M9Ukkso4piTWIOWYtPKDhn8YSPrC8Vk=;
 b=UFYmFrXefXy9I3AmdNCyZiQ5bsw66OYFgmQIxTE7BLg66PcN30VneXZwOfesYNVmwSGk3yZWA3R2vR4anOvgEH8lTNa/v/ogw9kLpjJP57JfcvVM58uVWgkW6C+MKFh/FCQ18V8/MGd3p6Gj4P6fHdAKeCSLDB3QEnqBXhnbQxw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 31 Aug
 2021 21:47:56 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 21:47:56 +0000
Subject: Re: [RFC PATCH] perf script python: Allow reporting [un]throttle
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210817002133.48097-1-stephen.s.brennan@oracle.com>
 <YS55BApYslmJuqPh@krava>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Message-ID: <3035e557-9752-9277-6a84-f6d65a6a119e@oracle.com>
Date:   Tue, 31 Aug 2021 14:47:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YS55BApYslmJuqPh@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0084.prod.exchangelabs.com (2603:10b6:800::52) To
 CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stepbren-lnx.us.oracle.com (137.254.7.179) by SN2PR01CA0084.prod.exchangelabs.com (2603:10b6:800::52) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Tue, 31 Aug 2021 21:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 973c1f0c-f428-4834-552b-08d96cc8fe27
X-MS-TrafficTypeDiagnostic: CH2PR10MB4294:
X-Microsoft-Antispam-PRVS: <CH2PR10MB42948017B2E958650A60EC93DBCC9@CH2PR10MB4294.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6u2jrFaUFIl/qWNp7hqPaJRZvlSGqmsORUF12ljS32XPmfX/gRcWurGKF0v7ruQ4JYi7ARpUOJQ5iN5eNiCdjBPAMBVLpRRCYR73pP94lG27e8MHNqeLbup1Ksdbl9nmLMNx1+rOoZoJhps6fdBTfF+BUj+Esyz9vmRy0UTOT3VnZdXqx5KVgMLYrlPWhuH4WqId3cN9uL+d9lymfwiaTzqfZfU/C0F01OSA5IMw3oMyyAkCKP0mRLqjh1aObaOmRSwuwaXrieSlQKxKlI/NcL+5Fhr9Oboyf37+E/jIuEHhg98taW+cZhScbQgfwIeBxynOa2j8FVrLOuWs5l0BKB1+MiSxQFkMfx3pqf7EoEtpRLptGsmk9g9AB+HoTLtMex9L8U3zE5I/FnHMV3IT7Vpi/YiEQoQ/StnqYBlATiXHItCeGgtAdP2CCmruo+Qgr8YSpieTTLqBxRzMzH13XeqFOHdKO3CNgsbt8ojWg57mnxGdxqxcisuIDCucuTUYD8Hha/5djDhgri/IIEKWqRyHd2VTaGIURB5l15ZikmdKRfdS0zDGxEh/gtuhgMwGaFUkOUNUBLf9oSttcaUaPvYApsT4b7qE5Df8qGEXOzLi38MJVIsXxfQMHh5ZCLUZnvTIditJDPUnQND//myfDWqR3pzRIxWfFDBvEz1lDtC/657b2fPKmgpmg2hJJnN7dNuFeHNyftdpd/O2RpEyrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(396003)(376002)(26005)(4326008)(8936002)(36756003)(54906003)(38100700002)(31696002)(5660300002)(2616005)(6666004)(31686004)(53546011)(66476007)(7696005)(6486002)(8676002)(86362001)(186003)(6916009)(83380400001)(66946007)(316002)(478600001)(2906002)(956004)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0cxR3Z5OUpEN0wyU0l2QmlobG5ua1lSbkxZZ0poQ0ZFa1MzUUdBS1ZEdjBr?=
 =?utf-8?B?RUhNQVpsQlVXSUw5RjExMjJiY1Z6dU9kYXd6ZVNLVWNIYlAyR0hwUXJ0WE9M?=
 =?utf-8?B?cjloNk1jQzdjRDJ2aisyYTR4bTBhYmY2NGQrTGM0dVNQYkFjcXpZNGNxV0xs?=
 =?utf-8?B?cDlMSDR6aHV5YmhuOXF5ejFUQ0hGRDBRdjQ5QlB2MFRhc2ljUkFUWmNNSUI3?=
 =?utf-8?B?dCttSkpqSm1ML2lPTkxGaVhFZmxvR0RNM3BsTi9nNnhpSFFwbzR2WGhKTnNX?=
 =?utf-8?B?THdFanFiSUdiYStRdG9lVzNFdmpZNGwvUDBJSG1QaHRUWEE3aHBmcWVoYzI0?=
 =?utf-8?B?Q0pMWCs4b2pFb1B3SVY2UVVEWDl2bmZ5Y0RMaTBUY0VaYjhlZlVtNTdTK082?=
 =?utf-8?B?andDNUJwZG00OG9WVlZEWTVaNzR2Qm5wZURGdEw0akhXQUlCdFpLZEpiYTNS?=
 =?utf-8?B?UVVSZmVwekp5eU1DY2ZvMWs0aWxidjBsR3ZGdlpjZlVhaUsrU1NRQmxjNlht?=
 =?utf-8?B?QXkyRzcwTW5oQ0tuZHhSWmlVSFVIZnpkbDNtWWp4K3JVQTlCcHpFa2E4SUty?=
 =?utf-8?B?TUNJT05EUm9VRk44eTFRQ1V4emlhV2l2WUZxK1M5NEl5VXA2NXJaWTd3c1pH?=
 =?utf-8?B?TEpiVC81dG95bEs3VjU5eFByOHZDUmZZc3dVSjVjelJka1NyU1JVWmM1NXVQ?=
 =?utf-8?B?Z05FMUhIRUJxN3dlL0QrUUQyOThnZlZlbm1oWGVQYkVSNEJrTXFURVRWVDk1?=
 =?utf-8?B?MFphTENEZ0NCZjNtdlk2dkJuNnh4L1FTUENNaWtETmpTbStFTFNOYjdCSkI2?=
 =?utf-8?B?cmQ1ZUpnTHhxYkJEaTZ0N1QxVk0rT3RuVDU3dlNtZkR3TGJVVklsSjFIWC8z?=
 =?utf-8?B?RmpjRGdtWVljMitkbUYzVjNQQjI2ZTBMOU9pSEQ3MzhJamZFRjRMbDhTYWlv?=
 =?utf-8?B?R1BzRXlWNFdveDI5ZWVtWDF2RTN6YkFHYlRBWWlSQzE4UUlKRVBFWE9vYW5I?=
 =?utf-8?B?OFcvTGpIWjkrRkV5RDd2MHRsNExXNG1nbFg2OEU1VG0xU3VZaEQvN3BIUExr?=
 =?utf-8?B?aDlSSnJ5SS9lMUovd2tyK09xKzhnQ1JLT2x3TDRQM0hMNE9jVGdpYTVYdG9h?=
 =?utf-8?B?aDc0SHlXSll1eUhhRUlNT2k4dXhBeDA0TGpoZ2JFQ1VKR3ZPMFo2d3RVQlpT?=
 =?utf-8?B?Ri9MaGI1TkwrQlpyemFZRmYxR1lJZERpWnZBVm1NVzR1Zk5IVjdicU5JY2JX?=
 =?utf-8?B?Y1RCZjZOWHVNa1dkV0FIcmVjdTluVk01WFMxcXZrSXZ5Uk1ZNHhaT3VNR3R0?=
 =?utf-8?B?ZUtobHRMcmJzS1JmYjQ5V1FHTXpUK0tHZWp4Z0dLbWphZzd0QVRuTkdnTUY5?=
 =?utf-8?B?SVdxallISkFVcUpGSFhrSzBYT2JoUDd3aEsyVk5DRUJmQTFrZ2FTV0pML0ZK?=
 =?utf-8?B?UDZBYWF0RWRtZDhWMGFZV2JNRmZoSmIyTkZKVnZ2SndVRDNXRGxaOFNXdXlO?=
 =?utf-8?B?VGlkUnFOWmxJcHM3NmtWVmxvVkh4c25YQkp2M0ZSbEFQd3BRUjJlQURBWTRC?=
 =?utf-8?B?WFFJV3lHbktzRVE1UE0wdzkwS3FpTzN3ZUVvb2V6c3VWMWNQUFpPUVJjR2VF?=
 =?utf-8?B?bnhUQXo0RWpGbjhRRWRXRTc1K0o1Y0FyYjlWd1g3REIvTFB4bzRpOXI1U29t?=
 =?utf-8?B?cTZoUHRUdjVPMmYzK2tVa2ErOGhkL2lxSTJ5SnUrMFZIdS82R0xVVkYvYzFz?=
 =?utf-8?Q?jPyC8uoMh4bTT7WLp9RL7DOjw4azySHLQjCu/32?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973c1f0c-f428-4834-552b-08d96cc8fe27
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 21:47:56.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP9bkaDwKDIGZvW4dFeDxwemQxoPPvXCocYNkOHmyZ6JX6ZjS6GF9lSRUG2qgmmgk1ZMNdycGuQiZahg62kHcKt/6ZyoIJv29qC4mLTr1oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310118
X-Proofpoint-GUID: wnpwK6iZBtpMz4OPk9eA-f-64A3x7qWB
X-Proofpoint-ORIG-GUID: wnpwK6iZBtpMz4OPk9eA-f-64A3x7qWB
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jiri,

On 8/31/21 11:46 AM, Jiri Olsa wrote:
> On Mon, Aug 16, 2021 at 05:21:33PM -0700, Stephen Brennan wrote:
>> perf_events may sometimes throttle an event due to creating too many
>> samples during a given timer tick. As of now, the perf tool will not
>> report on throttling, which means this is a silent error. Implement a
>> callback for the throttle and unthrottle events within the Python
>> scripting engine, which can allow scripts to detect and report when
>> events may have been lost due to throttling.
>>
>> A python script could simply define throttle() and unthrottle()
>> functions to begin receiving them, e.g.:
>>
>> ```
>> from __future__ import print_function
>>
>> def process_event(param_dict):
>>      print("event cpu={} time={}".format(
>>          param_dict["sample"]["cpu"], param_dict["sample"]["time"]))
>>
>> def throttle(*args):
>>      print("throttle(time={}, cpu={}, pid={}, tid={})".format(*args))
>>
>> def unthrottle(*args):
>>      print("unthrottle(time={}, cpu={}, pid={}, tid={})".format(*args))
>> ```
> 
> throttle event has also 'id' and 'stream_id' I guess you don't
> need it, but maybe we should add it to be complete

I tried adding these from struct perf_sample.id and struct 
perf_sample.sample_id respectively. I then tested these on a perf.data 
which contains a throttle event. The values which my python script 
reported were 0xFFFFFFFFFFFFFFFF -- is this expected? If so, I'll send 
my revised patch.

Thanks,
Stephen

`perf report --header-only` from my testing perf.data:

# ========
# captured on    : Wed Aug 11 11:55:44 2021
# header version : 1
# data offset    : 264
# data size      : 18240
# feat offset    : 18504
# hostname : stepbren-ol7-2
# os release : 5.4.17-2102.203.6.el7uek.x86_64
# perf version : 5.4.17-2102.203.6.el7uek.x86_64
# arch : x86_64
# nrcpus online : 4
# nrcpus avail : 4
# cpudesc : Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
# cpuid : GenuineIntel,6,85,4
# total memory : 30522624 kB
# cmdline : /usr/libexec/perf.5.4.17-2102.203.6.el7uek.x86_64 record -c 
100000 -e cycles -- sh -c echo 2000 > /proc/irqoff_sleep_millis
# event : name = cycles, , id = { 5, 6, 7, 8 }, size = 112, { 
sample_period, sample_freq } = 100000, sample_type = IP|TID|TIME, 
read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, 
enable_on_exec = 1, task = 1, sample_id_all = 1, exclude_guest = 1, 
mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: software = 1, uprobe = 7, cpu = 4, breakpoint = 5, 
tracepoint = 2, kprobe = 6, msr = 8
# CACHE info available, use -I to display
# time of first sample : 228.321751
# time of last sample : 230.362698
# sample duration :   2040.947 ms
# MEM_TOPOLOGY info available, use -I to display
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT 
CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY 
HYBRID_CPU_PMU_CAPS
# ========
#



