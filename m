Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16014C43219
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0582361100
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhIISrC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:47:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9874 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237208AbhIISrB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 14:47:01 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189HiA1e024948;
        Thu, 9 Sep 2021 18:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=nmZmg9oH8cDkTfvd1P2hHAuD9fVu9bqbwGrm5b0mehI=;
 b=Fjb2VZqPtjfM476Zy0jCD74diwsDK/n63veIhKo6B0gb1jfv5QiFvT/ZQ9eanO8FQqWb
 I0MyYWfQdpuHPQy62vIWDUFgA8Z7etWfD81l2RayQyowfivTbF1+dQWeA6Bq+XRxT58b
 wiQ3A49Oa3jnAShHmMtBFdW+8nNty6873N76nMxsg1z40IDfw+pG9rF5UHolwCuSJQKG
 Z5HvEcT2HAeDlXIXxJNJTgnyFmHd1vsoh5ETwAB4LriRD/LY8q1c8D6CQFlyvG5B99hS
 o0C2egK6BRIzpWGELfy2QoIRIIuhxWHhAaiF+wp1RC0F8h4fvND5WxOp+bsYquswCtwJ Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=nmZmg9oH8cDkTfvd1P2hHAuD9fVu9bqbwGrm5b0mehI=;
 b=oK9ZJNYVnSUGrPHT0cLQkmz/w6uN1I7n1rCqEtipRG3mq0vPtq/q+isTXIgjLNxGPR49
 SW2IyjMqr3bpPhduLXjb1QZ1BtXo5Kg8KQpgCNTDNBI9A6PHWXHOMGCLHJDQ73qs+e6w
 n/GsgWBnwTRqiAglia4xucjlfUC36u1YYfxLNzOJ1Iit32eDfTjPEet9Jc5FFrmmLcv3
 HBlXc2d4ycCDG3zaQntOZapU4UFdcwbfInRcz+PVFoo2w/6Lkw8pWUY79NkMdCtbj65v
 d9t3Qs/WxQrR+wWFraq4kGLELkSaXBDAy1Rs0JN48U3f0WBPTVs16cvla/LmGVseQfUd Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayfrpsjrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 18:45:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189IbAZ6130917;
        Thu, 9 Sep 2021 18:45:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3axcq3d2cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 18:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCMxTGJXCtFK6MjNTcqOkJf+v9fb2CdjBq1Zm/Zjdmu7HteBo2ynztWjiBuZarIgDfZnBLgXr4CRPQXM07PgJ3y5xUOkBy1G8e9WOgjI+iSPub5RU5IORBAgk1lrkjJZTC3DtGeX8pyvc/V6gcYCso2HC2RrmZ7jsXFcUXV2WkWOr0jLKKpAWGDm6oYclmvzSdfyH2HC4pkJHNo0yBUJmSrS9ELqdXBLkkcbGI1QyzPS5kBb71YtZxXDU1jZHQsTQk1tX+d3592lqQhZKJiIvesYyzhpjSLEIOm5NRa9hyYf2tihZ2ISQpisZ4wTVZjeVyB6WIktI6/vtg3tX6QpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nmZmg9oH8cDkTfvd1P2hHAuD9fVu9bqbwGrm5b0mehI=;
 b=OdHJQpmxfK0ZpauGLNV1px+ROR7gfBvOvbHLTMxdGYfsTSV5wRUTEwy+A430hjgt7MAxGnXBDX+szYY94F/g2dpAbsT3Yqu+dVsZ8PSo6jqb/msp0CmbWjiCdYlSRf0ltMA5uh++1sk9KZSxXycRlkchVHmRjAC42KICbmJQ8SUyGdJHikXymeb2G9rjY+KazOgytmlY62HwjPdvtvJNsLsBPCwjDgxdMyfODNUJu9cDAp+BGbn+zPlxwJnhNbibUvy4r6Tx+GMINYdral6tPbIzcbSbTpTeiO5nTB6jO4aiFMMQjmE/8eYI5VAl3k/RkWKSdbWpVk3XIuIuzq9Ssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmZmg9oH8cDkTfvd1P2hHAuD9fVu9bqbwGrm5b0mehI=;
 b=kSI2cZowAabXRF3pT1cPsQKwm/M0dxcOSi3y9aGP8X/dQ3/rTG87VZfaosFNrjKTImPtdTrKXGEds6GetHwwJmwZBAm3kx68cI/3fbqrKt4TM/3qfyjIkF1Wc3GzWhp93SC4How3kndyOd7F/nrntZKqC5ndsEpogee0KR94QuQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19)
 by BLAPR10MB4900.namprd10.prod.outlook.com (2603:10b6:208:30c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 18:45:45 +0000
Received: from MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::1d4e:d515:fff5:9062]) by MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::1d4e:d515:fff5:9062%7]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 18:45:45 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>
Cc:     Mark Hansen <mark@markhansen.co.nz>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: A list of visual Profiler UIs for linux perf
In-Reply-To: <CAE40pdewTBdv5eUXks4ZTf5K6UjrVjYVv62kyqN7dZydnYjX9g@mail.gmail.com>
References: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
 <CAE40pdf7n-YzZb71CvFmNFtCh3eTiBfAtiWxdJQLQRxs-hVUmA@mail.gmail.com>
 <9e717abe-d923-d88c-90b6-ca589831d157@oracle.com>
 <CAE40pdewTBdv5eUXks4ZTf5K6UjrVjYVv62kyqN7dZydnYjX9g@mail.gmail.com>
Date:   Thu, 09 Sep 2021 11:45:44 -0700
Message-ID: <87h7etsi3r.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To MN2PR10MB4173.namprd10.prod.outlook.com
 (2603:10b6:208:1d1::19)
MIME-Version: 1.0
Received: from localhost (137.254.7.170) by SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Thu, 9 Sep 2021 18:45:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7872f3-68d6-4c8a-619c-08d973c20889
X-MS-TrafficTypeDiagnostic: BLAPR10MB4900:
X-Microsoft-Antispam-PRVS: <BLAPR10MB490023356004DA05A16235C2DBD59@BLAPR10MB4900.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNpO0F2A+3eQB1rWcKIS80nct7MsKur/3hV4k1zX+Hzy7n+CstmJZwHUelMGa7FIVsSRbyqnaocZwwtKSDIcNS1bScNSJKL6SEh0hKZov8bR8d3Y6Bz9933cFgsd7pEv3n8/YsUvzIZ2/eNUXwWYQWSqRL82rWoJVBWmDWx7JGPk7/rKCLElMdfmLHiYrM2E9gFgABbMrcWkJEwhOdWEgfpvnPc5AXa2fidPZQyYh/ozJbArBjwTnhqL3hrrGvPl/4donEINdmtkVP1fdYjw5qhADvejvy0THo89MEsDljNQG0PY/HwFvMaEZOwp2ykYAfutcJVqDu6IZE2S5aNwNiJMUKXBQ3Teqq3qBC/3jwUTTlLLlLvljYVTpxlxVTvS6xbr6ztJ6Pn8LpAa/Id6vNUqvUm5bi+dt9d/1CE9pVCjq5oHTGnaRO7X8ZzpDXpH8coSxz4iiVaiNOcQBif8RpO4yRyU6TkV4noL+g4+XRsL+gbKMVvnRKdPu9orILs3HVEQZ/ayw25idTzS8j+57TKP6T/hvacfaRr0f3P5hNTf4EyadVy6fbJ/BbK0YyPigkIEZOXBbRKiiWxPp+c9wBL1JFsQ34r/U+56bauyKLZ23fKGZWuXAGb9pLaTtlT/qY+JAg97k8sggDidx2sognqm5isWYx6KeiiH9XGESLQ8j1seo8dLkwY+zuAjiLpYfmXonhSTGSiGyBVXAUJt2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4173.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(316002)(52116002)(66476007)(478600001)(66556008)(86362001)(53546011)(6496006)(54906003)(6486002)(8936002)(6916009)(8676002)(4326008)(38350700002)(2906002)(66946007)(38100700002)(83380400001)(186003)(5660300002)(956004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ubx5EBx13j9eerN+VNHjeX7gVQktRqtXtlBDpVf8bnYjE6F6/EF05NHqnOpw?=
 =?us-ascii?Q?SAuCRVWXmVgnUuJGXxFzYFiti0w5nld/ifQf6YVu3bPcmefDFkImoaGaMHWK?=
 =?us-ascii?Q?9KqxsRNr556kzRvSfzORfOIXZxX8WYbcZdYZmx7uU0GuUE/tJdxPyoYnlv0T?=
 =?us-ascii?Q?lshRgZVA2lISjOcwkUVYLbCF7Y2GUcZFNP5rl7kmF4S/SQHg/GSzpJYDmVkm?=
 =?us-ascii?Q?v1e5aGpEFdYjp2g6gugwtsAuNmC9oShYxPZIdZPcDaRj2jnXgEtS744PmKeF?=
 =?us-ascii?Q?sWMh1dJElSqgF8Bl9sKYCROGf/Hj1Ojyd+o1btD2Nev/aGsF2IZLPxKzvaWV?=
 =?us-ascii?Q?k6VmCpS1xdaqoIHuG5Kkn8iQGhYrBrz5nl+loRmqF96LqLQvORp7ULleAh3O?=
 =?us-ascii?Q?GpKZ1KDV6vhsp5Kem9XaUhuGvC3b/5iPpvaiVoF9OhWoO0yNTiiTpDKkNwGx?=
 =?us-ascii?Q?xdJPnqfojcmh0+vm2YO+P2RaTiAUxiRz8jcAA/C0CFUZZ+BBlBrUycA0/Gej?=
 =?us-ascii?Q?04T6qxQCZ17bRW8N9b5pQNLNDYWlSlkn+TOaBtrnmtHXqLTytEWq+sfMrkJA?=
 =?us-ascii?Q?JyHGs3fpiBAXaq01xysu+kMJU5Q+uco5Uc1f/znjv0PY1qn1LZ6vOX4i/M77?=
 =?us-ascii?Q?YJilfOOkgrkuNGB+Oqjx/TlrhiQgpTuKMX2dGAOPTnMdiE5/yJFX5FTurHZu?=
 =?us-ascii?Q?gW3Gm8SoJNTjQGajspyhZ1wYNWn1wz9fefi/WlC7bn2ps98kVrC4UOYWAJ7P?=
 =?us-ascii?Q?FhUirxtRDobtg7nLiTXv3MA+6xmeDVJLq7Qztzch54DSWvzOv4jhsmjv99u0?=
 =?us-ascii?Q?uzMHoOVakdd8Ek/3TPP5+5GXOGmuUkIEvRxU4za8sm2xYYVTHn9Rth4s78HF?=
 =?us-ascii?Q?NEpJnY/zQoRWlWcWznLkqk+eVEcoQ1xmXFx9MA3F2kK+BHXF1IpkX6BDzxe5?=
 =?us-ascii?Q?k5GXmX6tR946yazLt+ni1ipw9Dx8Ne5lb68bOUR287sY8av1yxPQXIwLSsKV?=
 =?us-ascii?Q?8mtjDP/KFmSOw09B4PRyvdC4lfpWFpCuhe0w2L/xfOuVEg1ABBsNgBKqkO1f?=
 =?us-ascii?Q?jOfwmAQanBEOcMyvnk+lD4aDLegcsln4t0wZWxky8wuS0cxJfr+YxHqbLal3?=
 =?us-ascii?Q?H+kqmzxAvoaqVayuw5VepMJbXvzm/VV+ZafhvMOYvQ9SS0tAJAIRZk9vjAyX?=
 =?us-ascii?Q?aBI2H7q5oXQXOvem25jomQY5VJ4H4FQ8oRJqEYY7SjXJ0cAVpsYSQzdlTefY?=
 =?us-ascii?Q?BilmWms4pQvDyVyeQctSMp9D9K3ZGfyMkItbY17H8YMh38W0VWSVtGE4PoIC?=
 =?us-ascii?Q?rl9LbdmQ9Csv/nLwq+yzTbxz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7872f3-68d6-4c8a-619c-08d973c20889
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4173.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 18:45:45.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSJTtSCVWkaQSe8zLeBVnEZxTBVk+xE87GPAgqiVRwCYAQ7o4xNomo+WMjUCMifOzrHpDjALL8WfOUnnX/W+T84DaV1S+Khc3CGTesF+zUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4900
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090113
X-Proofpoint-GUID: juFZO216264hWat9tmCweXtK3Ct0brLy
X-Proofpoint-ORIG-GUID: juFZO216264hWat9tmCweXtK3Ct0brLy
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Brendan Gregg <brendan.d.gregg@gmail.com> writes:
> G'Day Stephen,
>
> On Thu, Sep 9, 2021 at 5:13 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Hi Mark & Brendan,
>>
>> Thanks for this thread - it's very useful.
>>
>> Firefox Profiler is news to me and looks exciting. However, I can't see
>> any clear documentation on their part that the tool is client-side only.
>> I can't always put internal flamegraphs into a web form on the
>> assumption that they won't be uploaded somewhere. Do you know if there's
>> anything explicit that says data won't be shared? (unless I explicitly
>> upload it to create a link)
>>
>> Flamescope is quite exciting as well! I can see how the time dimension
>> can be incredibly useful. Brendan, I had a couple questions regarding it:
>> 1) Is the box color scale in terms of "number of samples in that time
>> interval"? If so, it would only really be useful for cpu-cycles or
>> instructions, correct? Something like the cpu-clock which tries to
>> regularly sample at a set frequency would just look monochrome?
>
> Exclude idle stacks then cpu-cycles works. Most of our samples are
> cpu-cycles based (only thing available in most of EC2). FlameScope
> should already filter it:
>
> app/perf/regexp.py:idle_stack =
> re.compile("(cpuidle|cpu_idle|cpu_bringup_and_idle|native_safe_halt|xen_hypercall_sched_op|xen_hypercall_vcpu_op)")

Ah that makes sense, I always visually ignored the idle stacks, to the
point that I forgot they existed in most of these profiles.

Looking at idle stacks actually always gives me grief, because when I
see them, I feel compelled to compare them to the %idle time accounted
by the kernel. I used to have this naive hope/belief that a `perf record
-e cycles -F 1000` would give me exactly 1000 samples each second, and
so I could compare the percentage of idle stacks with the %idle time.
But due to frequency scaling during idle, that's usually not the case.
I've tried looking at cpu-clock (which has its own downsides, like
firing in an IRQ context rather than NMI) to get a consistent frequency.
This works but isn't great, since I like the benefits of an NMI event.

Flamescope seems to make this frustration (why aren't my samples at an
exact rate???) less of an issue, since you can see the sample count over
time. You can see the idle periods and the times of heavy utilization,
so it matters less whether the sample frequency is clock-like in
precision.

>
> I've also used it for other non-CPU events including off-CPU spans by
> adapting it to sample equivalents.
>
>>
>> 2) I'm curious if you've considered directly using perf.data in
>> Flamescope, rather than perf.script? I've recently discovered the
>> "--symfs" and "--kallsyms" options for perf. By using perf buildid-list,
>> you can identify all DSOs, capture their symbol tables, and create a
>> minimal bundle of files to allow the perf.data to be read with useful
>> symbols on any system. Since perf.data contains more information,
>> usually with less disk space, I've started taking this approach to make
>> capturing, transferring, and analyzing larger recordings (especially
>> from customers) easier as well as more flexible and efficient. All the
>> same analysis can be done via the Python engine in perf-script, without
>> need to worry about text parsing.
>
> We do gzip the perf script outputs. Just checking the README, I should
> probably change 'perf script --header' to use -F to specify the
> fields, to make it more future proof.
>
> I haven't explored the buildid-list path since we have Java apps with
> massive symbol tables that can be 100s of Mbytes of text, and other
> binaries that use a mix of ELF symbol tables and DWARF debuginfo. I've
> assumed this will be too big to include, but haven't tried yet. Maybe
> it's better suited for some apps with smaller symbol tables?

Got it! My main use case is debugging kernel bugs from external
customers, who wouldn't want to share their application symbols anyway.
We frequently make do with just the kernel symbols and application
names, but adding in symbols from a few system utilities and libraries
can be very useful and only takes a few MiBs usually.

I've wanted a perf.data format which includes all symbols resolved for a
while now, and maybe some day I'll know enough perf innards to implement
it. The perf.data + symbol tables in a tarball has worked alright. But
my ideal would be a way to have perf (1) do dwarf stack walking and
symbol table lookups, and (2) store that data back into the perf.data
file. Then analysis could be reliably done on another machine, and it
would include all the data from the original recording. (For example,
I've had missing events due to a PERF_RECORD_THROTTLE event coming in,
which perf.script files show me.)

Anyhow, I'm probably over-optimizing at this point. Thanks for sharing
your motivation and use case!

Stephen

> Brendan
