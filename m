Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90646C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5439364E42
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhCCFFp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:05:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1575719AbhCBPfK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 10:35:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122EithD037184;
        Tue, 2 Mar 2021 09:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RyXQ0YOdKDKWImHbiOYlbyjVggy7D3qEGh0Behjax+E=;
 b=l9fs4po1SWYMBBocZVeXeGJpoXGhzep6ZdYBZHkIuTuWiwOWT3VcZC1zYB0T3P0MBZB6
 YzlSVeHdD5e28418ZucY4ZY04qUX79yE2ItoPoxK0rDwMMpXF/krCU0VlXC5DYYhL7rp
 585o6EaKxdiZcXLHz/8np81Zv5SxntjBbN7FnLOcPqfBqQahYT2eKeLXhKCjS7XcJHHh
 MtXq8TbI9sDpmSPFWWhsUfjTH/XnxmOw1mv2abRhOf2HcawMsOjLByaGfVnx64hbmWUs
 pEZhQPcESQ4HAruWgoSLQfMWm8Vzw3m5mYYdh++QlptMvxXiZZ8ig3SHs3qXg24JgYhE SA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 371qd604fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 09:48:59 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 122EgKh4030811;
        Tue, 2 Mar 2021 14:48:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3712v50g7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 14:48:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 122EmsSN64553428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 14:48:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DBBEA4059;
        Tue,  2 Mar 2021 14:48:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3414DA4057;
        Tue,  2 Mar 2021 14:48:54 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.82.126])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Mar 2021 14:48:54 +0000 (GMT)
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
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <7a14f6b6-967f-93bf-a030-44e358374502@linux.ibm.com>
Date:   Tue, 2 Mar 2021 15:48:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <abcf63c1-8a15-14af-b449-77a943c94121@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_06:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020120
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/2/21 3:03 PM, Liang, Kan wrote:
> 
> + Athira Rajeev
> 
> On 3/2/2021 8:31 AM, Thomas Richter wrote:
>> Executing perf test 27 fails on s390:
>>   [root@t35lp46 perf]# ./perf test -Fv 27
>>   27: Sample parsing
>>   --- start ---
>>   ---- end ----
>>   Sample parsing: FAILED!
>>   [root@t35lp46 perf]#
>>
>> The root cause is
>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
>> This commit introduced a test case for PERF_SAMPLE_WEIGHT_STRUCT
>> but does not adjust non-x86 weak linkage functions.
>>
>> The error is in test__sample_parsing() --> do_test()
>> Function do_test() defines two structures of type struct perf_sample named
>> sample and sample_out. The first sets member sample.ins_lat = 117
>>
>> Structure sample_out is constructed dynamically using functions
>> perf_event__synthesize_sample() and evsel__parse_sample().
>> Both functions have an x86 specific function version which sets member
>> ins_lat. The weak common functions do not set member ins_lat.
>>
> 
> I don't think Power supports the instruction latency. As a request from Athira Rajeev, I moved the PERF_SAMPLE_WEIGHT_STRUCT to the X86 specific codes.
> https://lore.kernel.org/lkml/D97FEF4F-DD88-4760-885E-9A6161A9B48B@linux.vnet.ibm.com/
> https://lore.kernel.org/lkml/1612540912-6562-1-git-send-email-kan.liang@linux.intel.com/
> 
> I don't think we want to add the ins_lat back in the weak common functions.
> 
> Could you please update the perf test and don't apply the PERF_SAMPLE_WEIGHT_STRUCT for the non-X86 platform?

I used offical linux git tree
 [root@t35lp46 perf]# git tag | fgrep 5.12
v5.12-rc1
[root@t35lp46 perf]# 

So this change is in the pipe. I do not plan to revert individual patches.
> 
> 
>> Later in function samples_same() both data in variable sample and sample_out
>> are compared. The comparison fails because sample.ins_lat is 117
>> and samples_out.ins_lat is 0, the weak functions never set member ins_lat.
>>
>> Output after:
>>   [root@t35lp46 perf]# ./perf test -Fv 27
>>   27: Sample parsing
>>   --- start ---
>>   ---- end ----
>>   Sample parsing: Ok
>> [root@t35lp46 perf]#
>>
>> Fixes:
>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
> 
> I think the regression should start from
> commit fbefe9c2f87f ("perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing")
> 
> 
> Thanks,
> Kan

Kan, 

I do not follow you. Your commit c7444297fd3769d10c7ffb52c81d71503b3e268f
adds this line

@@ -242,6 +245,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
                .cgroup         = 114,
                .data_page_size = 115,
                .code_page_size = 116,
+               .ins_lat        = 117,

And this assignment 117 breaks the test. As mentioned before, member ins_lat is never touched
by the weak functions. 

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
