Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02059C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB33664EBA
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhCCFGW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:06:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349831AbhCBRgx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:53 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H4RAg108274;
        Tue, 2 Mar 2021 12:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9Khyces1l20ppunsU2xyXsZyy1MOKEeJOAyVl6nvox8=;
 b=daR3Xl1RswXh0/ziRzwuu5vjV0vsdsXPsv/5YtXP2i2E39qR3rX5I+lPO1xLV8NuKh5y
 36De8EtOTncSeekfEder9/JdtzG6e1bXP5PoNdt3+USxpwYXlZxVPIoN3xo6rpNP23oY
 9j477IfIclOyGifD1P6QoPQcA1s9QqOBRGrp54YjOraTZhwDV0MJQ4NordNLCPCrx0lk
 uYE2snQTNCDBvK++p67PIRLRkZR4UPLNUn9k4hjPA5a8K/yJuhhbqmZ2RIj6whsPgS6z
 ypTetgMW+vXHF3vF59SM3pRk/dEUv6MqSNwk2Gr6+2u2NAkB3mvT3hzh8iWgelszydha uA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371s5k8qq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 12:08:17 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 122H7ZnS018180;
        Tue, 2 Mar 2021 17:08:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 371162h38m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 17:08:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 122H8COV54133224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 17:08:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E85F0A4065;
        Tue,  2 Mar 2021 17:08:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9315DA4053;
        Tue,  2 Mar 2021 17:08:11 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.82.126])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Mar 2021 17:08:11 +0000 (GMT)
Subject: Re: [PATCH] perf test: Test case 27 fails on s390 and non-x86
 platforms
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20210302133119.3325530-1-tmricht@linux.ibm.com>
 <abcf63c1-8a15-14af-b449-77a943c94121@linux.intel.com>
 <7a14f6b6-967f-93bf-a030-44e358374502@linux.ibm.com>
 <785fc599-24c5-6eda-2807-2b79a9d89315@linux.intel.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <753a61cb-e331-f91b-a1a9-e2fce2ecba52@linux.ibm.com>
Date:   Tue, 2 Mar 2021 18:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <785fc599-24c5-6eda-2807-2b79a9d89315@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020131
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/2/21 4:23 PM, Liang, Kan wrote:
> 
> 
> On 3/2/2021 9:48 AM, Thomas Richter wrote:
>> On 3/2/21 3:03 PM, Liang, Kan wrote:
>>>
>>> + Athira Rajeev
>>>
>>> On 3/2/2021 8:31 AM, Thomas Richter wrote:
>>>> Executing perf test 27 fails on s390:
>>>>    [root@t35lp46 perf]# ./perf test -Fv 27
>>>>    27: Sample parsing
>>>>    --- start ---
>>>>    ---- end ----
>>>>    Sample parsing: FAILED!
>>>>    [root@t35lp46 perf]#
>>>>
>>>> The root cause is
>>>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
>>>> This commit introduced a test case for PERF_SAMPLE_WEIGHT_STRUCT
>>>> but does not adjust non-x86 weak linkage functions.
>>>>
>>>> The error is in test__sample_parsing() --> do_test()
>>>> Function do_test() defines two structures of type struct perf_sample named
>>>> sample and sample_out. The first sets member sample.ins_lat = 117
>>>>
>>>> Structure sample_out is constructed dynamically using functions
>>>> perf_event__synthesize_sample() and evsel__parse_sample().
>>>> Both functions have an x86 specific function version which sets member
>>>> ins_lat. The weak common functions do not set member ins_lat.
>>>>
>>>
>>> I don't think Power supports the instruction latency. As a request from Athira Rajeev, I moved the PERF_SAMPLE_WEIGHT_STRUCT to the X86 specific codes.
>>> https://lore.kernel.org/lkml/D97FEF4F-DD88-4760-885E-9A6161A9B48B@linux.vnet.ibm.com/
>>> https://lore.kernel.org/lkml/1612540912-6562-1-git-send-email-kan.liang@linux.intel.com/
>>>
>>> I don't think we want to add the ins_lat back in the weak common functions.
>>>
>>> Could you please update the perf test and don't apply the PERF_SAMPLE_WEIGHT_STRUCT for the non-X86 platform?
>>
>> I used offical linux git tree
>>   [root@t35lp46 perf]# git tag | fgrep 5.12
>> v5.12-rc1
>> [root@t35lp46 perf]#
>>
>> So this change is in the pipe. I do not plan to revert individual patches.
> 
> No, we shouldn't revert the patch.
> I mean can you fix the issue in perf test?
> Don't test ins_lat or PERF_SAMPLE_WEIGHT_STRUCT for a non-X86 platform.

That would be very ugly code. We would end up in conditional compiles like
#ifdef __s390x__
#endif
and other architectes like ARM/POWER etc come along. This is something I want to avoid.

And this fix only touches perf, not the kernel.

>>>
>>>
>>>> Later in function samples_same() both data in variable sample and sample_out
>>>> are compared. The comparison fails because sample.ins_lat is 117
>>>> and samples_out.ins_lat is 0, the weak functions never set member ins_lat.
>>>>
>>>> Output after:
>>>>    [root@t35lp46 perf]# ./perf test -Fv 27
>>>>    27: Sample parsing
>>>>    --- start ---
>>>>    ---- end ----
>>>>    Sample parsing: Ok
>>>> [root@t35lp46 perf]#
>>>>
>>>> Fixes:
>>>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
>>>
>>> I think the regression should start from
>>> commit fbefe9c2f87f ("perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing")
>>>
>>>
>>> Thanks,
>>> Kan
>>
>> Kan,
>>
>> I do not follow you. Your commit c7444297fd3769d10c7ffb52c81d71503b3e268f
>> adds this line
>>
>> @@ -242,6 +245,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>>                  .cgroup         = 114,
>>                  .data_page_size = 115,
>>                  .code_page_size = 116,
>> +               .ins_lat        = 117,
>>
>> And this assignment 117 breaks the test. As mentioned before, member ins_lat is never touched
>> by the weak functions.
>>
> 
> Here is the timeline for the patches.
> 
> 1. The commit c7444297fd3769 and other SPR patches are merged at 2021-02-08. At that time, I don't think we have this issue. perf test should work well.

Nope, that line above 'ins_lat = 117.' breaks the test. Comment it out and it works well!!!
That function do_test() is common code executed on all architectures. Take it out and
it is tested nowhere.

The whole purpose of this test test__sample_parsing() --> do_test() is to convert
a perf_sample structure into the perf_event structure and back again. The test
checks if this convertion works in both directions. See perf_event__synthesize_sample()
which flattens an perf_sample structure named sample into an byte stream. Function
evsel__parse_sample() takes that byte stream and creates a struct perf_sample named
sample_out.
perf_event__synthesize_sample() has as input sample.ins_lat with value 117.
And evsel__parse_sample() creates samples_out with  sample_out.ins_lat value 0.
So the test breaks. Thats why we need to set ins_lat in both functions.

> 2. Athira Rajeev told me that Power doesn't support instruction latency. So I submitted a patch which create weak functions and move the ins_lat into X86 specific.
> 3. The patch (commit fbefe9c2f87f) was finally merged at 2021-02-18. We should observe the perf test at this time.
> 
I just looked at this patch.
As far I as understand the code, the weak functions just set sample member weight and
do not touch member ins_lat. Sample member weight is a 64 bit value. 
It is used when sample_type has bit PERF_SAMPLE_WEIGHT set.

What we need is sample member ins_lat being set. This is the case when sample_type
has bit PERF_SAMPLE_WEIGHT_STRUCT set. On x86 the sample member weight
is split into a lower 32bit value containing weight value and an upper 32 bit
value containing ins_lat value. x86 hardware obviously does not provide larger values.

We need to do the same for non_x86 platforms. Otherwise member ins_lat is never set
and the test fails. Since the weak functions are only called when architecture specific
functions are not available, that hardware is not there to support this. 
So why don't we use this
procedure when we run into the weak functions where is is no hardware support anyway???

> As my understanding, "Fixes" should log the commit where an issue starts to be observed. If someone tries to backport the fix later, they have an idea where to put it.
> 
> Thanks,
> Kan
> 

Thanks Thomas

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
