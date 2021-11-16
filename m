Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC7C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 04:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ECF61C12
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 04:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhKPEmj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 23:42:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20098 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235880AbhKPEmH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 23:42:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AG2suH0023615;
        Tue, 16 Nov 2021 04:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=q9sUr7G2rBWpU8w+hqptAigK8+jX1EV0M9i1KQ1Tf1w=;
 b=VHg/BCHhbhcERdbv70kzUPMt9pE2x+rXXkIvw13UEifoPMHpciB0xJjI99ouPavPaqgh
 ax4V9WVhZZHKM+N1poFqc1n74Fvufo7IY6UgVefqBXfhfRQh78r0RFkUcYQC50J0Mgxc
 CeU/J57cm1jCa9gCmw1fSY67+0zKf1FAPsKB4OCWL3W5/SCoxZixGtVbmhZuC93TapTU
 +u59nvyQBCh4gNQLV68/4pfbkB8mrMiq0g9BmInG2+HYjiDShsmrY6Ypbg6VG3nDxPwk
 JI0PcB9cCQtXRmoTWM44wQBk/WddXgmrxTWpbKqlzS6v2J/ExvLitI1FtIC1SVzZn1K9 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cc0ntn4ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 04:38:58 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AG4XkK3006200;
        Tue, 16 Nov 2021 04:38:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cc0ntn4g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 04:38:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AG4c1CK009368;
        Tue, 16 Nov 2021 04:38:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50au6qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 04:38:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AG4W1O525887004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 04:32:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3016652054;
        Tue, 16 Nov 2021 04:38:53 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.127.103])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 373DD5204F;
        Tue, 16 Nov 2021 04:38:50 +0000 (GMT)
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
To:     Sandipan Das <sandipan.das@amd.com>, Jiri Olsa <jolsa@redhat.com>,
        acme@kernel.org
Cc:     ravi.bangoria@amd.com, ananth.narayan@amd.com,
        kim.phillips@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
References: <20211111125646.581021-1-sandipan.das@amd.com>
 <YZE8SDkzq0OMcmhS@krava> <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <bdbd0a4b-6221-ed90-0882-47248112ed3d@linux.ibm.com>
Date:   Tue, 16 Nov 2021 10:08:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9dc5cb10-2faf-a17b-ad4b-a22dbe688209@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pl3gTgEmETFt6pSZQogTilUsKIFp9rB2
X-Proofpoint-GUID: ChutZb40oo9R1oEBMOjcq9vVKVx8uQTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_16,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160023
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/15/21 3:28 PM, Sandipan Das wrote:
> 
> On 11/14/2021 10:11 PM, Jiri Olsa wrote:
>> On Thu, Nov 11, 2021 at 06:26:46PM +0530, Sandipan Das wrote:
>>
>> SNIP
>>
>>> Before:
>>>
>>>   $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
>>>   ------------------------------------------------------------
>>>   perf_event_attr:
>>>     type                             4
>>>     size                             128
>>>     config                           0x100001f8e
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>>     exclude_guest                    1
>>>   ------------------------------------------------------------
>>>   [...]
>>>
>>>   $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
>>>   ------------------------------------------------------------
>>>   perf_event_attr:
>>>     type                             4
>>>     size                             128
>>>     config                           0x1f18e
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>>     exclude_guest                    1
>>>   ------------------------------------------------------------
>>>   [...]
>>>
>>>   $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
>>>   ------------------------------------------------------------
>>>   perf_event_attr:
>>>     type                             4
>>>     size                             128
>>>     config                           0x100001f8e
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>>     exclude_guest                    1
>>>   ------------------------------------------------------------
>>>   [...]
>>>
>>> After:
>>>
>>>   $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
>>>   ------------------------------------------------------------
>>>   perf_event_attr:
>>>     type                             4
>>>     size                             128
>>>     config                           0x100001f8e
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>>     exclude_guest                    1
>>>   ------------------------------------------------------------
>>>   [...]
>>>
>>>   $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
>>>   ------------------------------------------------------------
>>>   perf_event_attr:
>>>     type                             4
>>>     size                             128
>>>     config                           0x100001f8e
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>>     exclude_guest                    1
>>>   ------------------------------------------------------------
>>>   [...]
>>>
>>>   $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
>>>   ------------------------------------------------------------
>>>   perf_event_attr:
>>>     type                             4
>>>     size                             128
>>>     config                           0x100001f8e
>>>     sample_type                      IDENTIFIER
>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>     disabled                         1
>>>     inherit                          1
>>>     enable_on_exec                   1
>>>     exclude_guest                    1
>>>   ------------------------------------------------------------
>>>   [...]
>>>
>>> It is understandable that raw events must follow the native
>>> PERF_CTL register format but it is worthwhile to pursue such
>>> alternative formats for usability?
>>
>> good question.. I see raw events as a way to put to config whatever
>> the user wants and IMO adding changes/quirks that silently changes
>> config could create confusion and angry users ;-)
>>

I agree, making quirks in config will only going to confuse users as
It's against the encodings we had in
/sys/bus/event_source/devices/<pmu>/format/*

>> I'd think that if user is composing/using raw events then using
>> directly r100001f8e is not such a big deal?
>>
> 
> Sure. Some of the confusion may be due to the fact that the man pages
> for perf-{stat,record,top} state that raw events are "eventsel+umask".
> While that is technically true, it does not describe the encoding
> scheme (/sys/bus/event_source/devices/<pmu>/format/*)
> 
> Would another option be to update the man pages with a reference to
> these sysfs files when describing raw events?
> 
> Something like:
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 2d7df8703cf2..5dfdfeba594b 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -30,8 +30,10 @@ OPTIONS
> 
>          - a symbolic event name        (use 'perf list' to list all events)
> 
> -        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
> -         hexadecimal event descriptor.
> +        - a raw PMU event (eventsel+umask) in the form of rN..NN where N..NN
> +          is a hexadecimal value representing the raw encoding with the layout
> +          of the corresponding event control register as defined by entries in
> +          /sys/bus/event_sources/devices/<pmu>/format/*

Do we need to specify (eventsel+umask) in the raw event description? As
the format/fields totally depend on PMU and umask name convention is
specific to one arch.

Can we just update it to:

- a raw PMU event in the form of rNNN where NNN is a hexadecimal value
representing the raw encoding, with the layout of the corresponding
event control register as defined by entries in
/sys/bus/event_sources/devices/<pmu>/format/*

Thanks,
Kajol Jain

> 
>          - a symbolic or raw PMU event followed by an optional colon
>           and a list of event modifiers, e.g., cpu-cycles:p.  See the
> 
> 
>> perhaps there was some some discussion about this that I missed?
>>
> 
> I am not aware of one but may be Arnaldo has come across something
> similar before?
> 
> 
> - Sandipan
> 
