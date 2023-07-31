Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCD8C001DE
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Jul 2023 09:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGaJmq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGaJmp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jul 2023 05:42:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE42E5
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 02:42:44 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9g6BD020847;
        Mon, 31 Jul 2023 09:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=B2FmKwD0izATIMOcQ4J8DjiYAdrCeooLSYJ5t5Flfrk=;
 b=Hx7xTQV2fHamxQ2mvC1+O8/vyyCNUuAhJZ2IgEfzMb1p3H/BKM1YFAwH7g8beeHal3Aq
 1GTTo7+sFDm22As51QpHez6KXUjrAXuT+pnzdrKpJLS2BW342/RTJkQSl/kQmxB6e/TW
 tgFvppbW88UieJ/ysUwgS5LWXAN4JXE2oInN5fXaauYzgLEwhL8cUg/yiz+gOkTk6x8+
 qRvrsHA2vFW5X8Cg/eeZnWht3mq20phjAurbz0OkrXho/SyniOWI3xXY2ejNCV6kZy6P
 8MO5qrPrCfaPImj2KsnNR26YZ6BGdiGQZKCSP3PUaZTfw1G9IhJnHDWQLlHHhmYyMiC0 Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6a508nwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:42:35 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36V9gEn5021144;
        Mon, 31 Jul 2023 09:42:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6a508nwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:42:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36V7cjgY017157;
        Mon, 31 Jul 2023 09:42:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5faj9h9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:42:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36V9gW0G41288244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 09:42:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AC832004B;
        Mon, 31 Jul 2023 09:42:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 218BE20040;
        Mon, 31 Jul 2023 09:42:32 +0000 (GMT)
Received: from [9.171.38.6] (unknown [9.171.38.6])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jul 2023 09:42:32 +0000 (GMT)
Message-ID: <128916c0-23f1-9e34-3488-906d6df6116f@linux.ibm.com>
Date:   Mon, 31 Jul 2023 11:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: perf test case 6 dumps core on s390 without PMU
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
References: <f0508123-780b-3370-e64a-c78a350d76fa@linux.ibm.com>
 <CAP-5=fVKbHc5K4LmmD0aCsB5xt_JAFBNKx7COvoSUEKQx2OzYQ@mail.gmail.com>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fVKbHc5K4LmmD0aCsB5xt_JAFBNKx7COvoSUEKQx2OzYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JeH5HGZN_KOHjuYbxrCtaZs4cFwWeodK
X-Proofpoint-GUID: ne-02yDnPlsbvNGNccWn12fOLUkUdegZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_03,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310086
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 7/28/23 17:32, Ian Rogers wrote:
> On Fri, Jul 28, 2023 at 7:30 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> Using Linux 6.5.0rc3 perf test case 6 dumps core on an s390 without
>> configured PMU (this can happen depending on customer machine configuration).
>>
>> In this configuration several perf test cases fail:
>>  # ./perf test 2>&1 | grep FAIL
>>   6.1: Test event parsing                                : FAILED!
>>  10.3: Parsing of PMU event table metrics                : FAILED!
>>  10.4: Parsing of PMU event table metrics with fake PMUs : FAILED!
>>  28: Use a dummy software event to keep tracking         : FAILED!
>>  35: Track with sched_switch                             : FAILED!
>>  66: Parse and process metrics                           : FAILED!
>>  #
>>
>> Even worse the test case 6 dumps core:
>>
>>  # ./perf test -F 6
>>   6: Parse event definition strings                      :
>>   6.1: Test event parsing                                :
>>  Segmentation fault (core dumped)
>>  #
> 
> Thanks for reporting this!
> 
>> The root cause for these failures and core dump is a missing
>> PMU, as can be seen by the debug output:
>>    ...
>>    Event test failure: test 57 'instructions:uep'
>>    running test 58 '{cycles,cache-misses,branch-misses}:e'
>>    No PMU found for 'cycles' <-- Here no PMU is found, because there is none!
>>    FAILED tests/parse-events.c:1516 wrong number of entries
>>    Event test failure: test 58 '{cycles,cache-misses,branch-misses}:e'
>> Here no PMU is found, because there is none!
>>
>>    ....
>>    running test 59 'cycles/name=name/'
>>    No PMU found for 'name'
>>    Segmentation fault (core dumped)
>>
>> Here the root cause in in function test__term_equal_term() variable
>> evsel->name is NULL:
>>
>>  # gdb ./perf
>> ....
>> Breakpoint 1, test__term_equal_term (evlist=0x1542c00) at\
>>                        tests/parse-events.c:1688
>> (gdb) p evsel->name
>> $3 = 0x3fff7fe3dc0 ""
>> (gdb) n
>>  691 TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
>> (gdb) n
>> 1692 TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
>> (gdb) n
>> 1693 TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
>> (gdb) n
>>
>> Program received signal SIGSEGV, Segmentation fault.
>>
>> I could fix this by checking for NULL pointer, but I have the
>> feeling that there is more to it. However I do not fully understand
>> the latest rework on the event handling.
>>
>> The other test cases listed above fail due to the same root cause,
>> no PMU found.
>>
>> Please advise. What should all these test return when a system does
>> not have any PMU defined at all?
> 
> So I was writing a response then figured out I've already fixed this
> but it looks like the patch hasn't been taken yet:
> https://lore.kernel.org/lkml/20230706183705.601412-1-irogers@google.com/
> 
> Arnaldo, could you take a look?
> 
> Thanks,
> Ian
> 

Ian, 

thanks a lot. I applied both patches you mentioned above and the
test cases work fine.
You have my 
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

>>
>> --
>> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
>> --
>> Vorsitzender des Aufsichtsrats: Gregor Pillen
>> Geschäftsführung: David Faller
>> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

