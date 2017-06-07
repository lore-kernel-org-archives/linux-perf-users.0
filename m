From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] perf fix test case 14
Date: Wed, 7 Jun 2017 16:36:31 +0200
Message-ID: <4a30a064-2e9a-768a-d63c-cafdc4dfaa2f@linux.vnet.ibm.com>
References: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
 <20170607111758.GB6356@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750831AbdFGOgj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2017 10:36:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v57EZAda115974
        for <linux-perf-users@vger.kernel.org>; Wed, 7 Jun 2017 10:36:38 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2axf6tn680-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2017 10:36:38 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 7 Jun 2017 15:36:36 +0100
In-Reply-To: <20170607111758.GB6356@krava>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.co>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org

On 06/07/2017 01:17 PM, Jiri Olsa wrote:
> On Tue, Jun 06, 2017 at 04:31:53PM +0200, Thomas Richter wrote:
>> I have taken the following commits from Jiri Olsa's
>> branch perf/attr_test to work on a fix.
>>
>> Commit-id
>> 070b9644981e perf tests attr: Do not store failed events
>> c9666c26ead0 perf tests attr: Make compare_data global
>> 10eb9496d1c3 perf tests attr: Fix compare logic
>> 4ba31b633fab perf tests attr: Add 1s for exclude_kernel ..
>> ede0b0a2e007 perf tests attr: Fix no-delay test
>>
>> I have then added 3 new fixes
>>
>> Thomas Richter (3):
>>   perf: fix incorrect sample_type value for perf stat tests
>>   perf: fix exit code check in test case execution
>>   perf: fix perf test case 14
> 
> those looks fine.. any chance you could take over
> those other 5 from me and post all together?

I would prefer that you post your 5 patches yourself.
I have tested them as well, so you can add me
as Tested-by.

Then I post my 3 patches on top and Arnaldo can
collect them and bundle them together.

> 
>>
>> I can test these changes only on s390.
>> With these changes some test-stat-xxx tests run fine.
>>
>> How to handle test cases currently unsupported on a platform?
>> For example  test-stat-default issues a setup for 
>> PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
>> which is not supported on s390. The perf_event_open()
>> system call fails and no event-00-07--1 file is created.
>>
>> The compare of the test result then fails because attr.py
>> has nothing to check against.
>> We could test if an event file exists and if not report an
>> unsupported test. Is this a good idea?
>> Any other proposals?
> 
> or maybe add list of supported or not supported archs
> to test's [config] section?

Good idea, I will think of something and come back to you.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
