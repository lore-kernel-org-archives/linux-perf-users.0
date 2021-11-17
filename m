Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F8C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B64613A1
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhKQORN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:17:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238267AbhKQORM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 09:17:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHDhIRU037079;
        Wed, 17 Nov 2021 14:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sSfh5PpsGWL/97Cuu6z42jEvbDR4urwa/sdJ8TZI4FU=;
 b=GURVPcdI42xYsDnl4Nf3+VZOtd6jMSH85ZLAAZegywsyNpo/b5l3W8Tm42kGBtQ4z+lX
 Nu52++7CxsPlme2K/BSF79ayGAKPs1sFqlqU0+ubaS9myQBKRBa83dQMQj3HvpnelIzl
 Y5AhdmDsG/md/QwgKBo4j7voGoQCtvLXdsjA5OwG3pA0FB7JPiwu5ezK31u36axNgAeL
 o13sV86imfTCy0bzIhuRpKMzRNRbJZ5mR05rZ9jb9Y+JIlRMyxhAf8wUyM74cuWd4C4B
 v3zDafrZwxNx/wqf0Ah0qF1fiXLQKxXnwzE5rHSA8RiuuzH+1TH2HaP0mIP5Q1FgkUe9 Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd2varn55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:14:08 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHDhBpe036872;
        Wed, 17 Nov 2021 14:14:07 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd2varn4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:14:07 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHE2KIp001655;
        Wed, 17 Nov 2021 14:14:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3ca50a1ck4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:14:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHEE3E463177152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 14:14:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E601C42047;
        Wed, 17 Nov 2021 14:14:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D0C342054;
        Wed, 17 Nov 2021 14:13:59 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.2.55])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 14:13:59 +0000 (GMT)
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
To:     Kim Phillips <kim.phillips@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc:     ravi.bangoria@amd.com, ananth.narayan@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
References: <20211111125646.581021-1-sandipan.das@amd.com>
 <YZE8SDkzq0OMcmhS@krava> <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
 <bdbd0a4b-6221-ed90-0882-47248112ed3d@linux.ibm.com>
 <301c0693-f982-1769-6e3f-8b77a4201a69@amd.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <0fd4cf27-87a7-2beb-fa02-6a810462829e@linux.ibm.com>
Date:   Wed, 17 Nov 2021 19:43:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <301c0693-f982-1769-6e3f-8b77a4201a69@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nVJD6vKT3me_6XoxH9pGZb-hyH-YC5gm
X-Proofpoint-GUID: 3QAppF-dY5sXvB92nBDES2kwYd9ybxyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170072
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/16/21 9:31 PM, Kim Phillips wrote:
> On 11/15/21 10:38 PM, kajoljain wrote:
>> On 11/15/21 3:28 PM, Sandipan Das wrote:
>>>
>>> On 11/14/2021 10:11 PM, Jiri Olsa wrote:
>>>> good question.. I see raw events as a way to put to config whatever
>>>> the user wants and IMO adding changes/quirks that silently changes
>>>> config could create confusion and angry users ;-)
>>>>
>>
>> I agree, making quirks in config will only going to confuse users as
>> It's against the encodings we had in
>> /sys/bus/event_source/devices/<pmu>/format/*
>>
>>>> I'd think that if user is composing/using raw events then using
>>>> directly r100001f8e is not such a big deal?
>>>>
>>>
>>> Sure. Some of the confusion may be due to the fact that the man pages
>>> for perf-{stat,record,top} state that raw events are "eventsel+umask".
>>> While that is technically true, it does not describe the encoding
>>> scheme (/sys/bus/event_source/devices/<pmu>/format/*)
>>>
>>> Would another option be to update the man pages with a reference to
>>> these sysfs files when describing raw events?
>>>
>>> Something like:
>>>
>>> diff --git a/tools/perf/Documentation/perf-record.txt
>>> b/tools/perf/Documentation/perf-record.txt
>>> index 2d7df8703cf2..5dfdfeba594b 100644
>>> --- a/tools/perf/Documentation/perf-record.txt
>>> +++ b/tools/perf/Documentation/perf-record.txt
>>> @@ -30,8 +30,10 @@ OPTIONS
>>>
>>>           - a symbolic event name        (use 'perf list' to list all
>>> events)
>>>
>>> -        - a raw PMU event (eventsel+umask) in the form of rNNN where
>>> NNN is a
>>> -         hexadecimal event descriptor.
>>> +        - a raw PMU event (eventsel+umask) in the form of rN..NN
>>> where N..NN
>>> +          is a hexadecimal value representing the raw encoding with
>>> the layout
>>> +          of the corresponding event control register as defined by
>>> entries in
>>> +          /sys/bus/event_sources/devices/<pmu>/format/*
>>
>> Do we need to specify (eventsel+umask) in the raw event description? As
>> the format/fields totally depend on PMU and umask name convention is
>> specific to one arch.
>>
>> Can we just update it to:
>>
>> - a raw PMU event in the form of rNNN where NNN is a hexadecimal value
>> representing the raw encoding, with the layout of the corresponding
>> event control register as defined by entries in
>> /sys/bus/event_sources/devices/<pmu>/format/*
> 
> The r notation is for the cpu pmu only.
> 
> The triple-digit 'NNN' is what's most misleading for 12-bit
> event implementation users, such as AMD's core PMUs.  It
> tells users 'see your processor's documentation's triple-
> hex-digit PMCx18e event?  All you need to do is make that
> "-e r18e" on the perf stat/record command line.
> 
> So all notions of what size of parameter 'r' takes, esp. 'NNN'
> should be removed IMO.  Perhaps an AMD/12-bit-specific
> example can be provided.

I agree. Maybe we can remove specification of digits with r
and separately specify for  different scenario like AMD/12-bit-specific.
Can we use something like r<hex-digit> ?

Thanks,
Kajol Jain

> 
> I had thought that the shorthand command line r spec alone
> could be modified to be smarter and more accommodating
> for conventional rUUEE users migrating to AMD/12-bit,
> which AFAICT is not what this patch does.  I think it
> modifies even the  cpu/config=0xNNNNN/ specification,
> which, granted, is bad.
> 
> Thanks,
> 
> Kim
