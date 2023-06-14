Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58FDEB64D9
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 08:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjFNIcO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 04:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbjFNIcK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 04:32:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082C1BF7
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 01:32:05 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E8OtiB027468;
        Wed, 14 Jun 2023 08:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iN3YFg9+lhOC9hGjR1YjSUu/Gs1s76JxC0AqOx6WOyg=;
 b=CcjTQj6BcTZaW0yM1qCLK+J+WYt7BbVqFwsq8v6s+JZNYxqkL6F91MFUuxM38Q6wTGTi
 wdbyKIh7W7+jXIvJbET6uHZwTktANmGoHjeHwA1EIFFvnSGY7fbMPE4a+v0ss/E4In3z
 8b2sDJFoku78v3Vdm+9jFRtr8dNknJzIi0HYG0U2QTM+g2FtmbiGYz1dM99zCyPDFUW9
 wGDlXk9eyt8D0fwLJrgFHrUCn0bjBCj2myhRS4wn2fKA9iAQ+zlY+voRc8bRA97A4Wgb
 pNlnbIiX/xP0NbllAR17SfZz7ICTG5iK1N890PynS3G9ypczmM2G3RjX83F3RebR27jW wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7a150473-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:32:01 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35E8Vd5O015673;
        Wed, 14 Jun 2023 08:32:00 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7a15045y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:32:00 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35E5ruB1011846;
        Wed, 14 Jun 2023 08:31:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3r4gt4t1at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:31:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35E8Vt3w15270562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 08:31:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A609120049;
        Wed, 14 Jun 2023 08:31:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7556F20040;
        Wed, 14 Jun 2023 08:31:55 +0000 (GMT)
Received: from [9.152.212.165] (unknown [9.152.212.165])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jun 2023 08:31:55 +0000 (GMT)
Message-ID: <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
Date:   Wed, 14 Jun 2023 10:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: perf test failures in linux-next on s390
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mpYZ1Im6o66cbMhNxfl4O7x8_15XzzT1
X-Proofpoint-ORIG-GUID: xXHEm6TRhBs-Hwi3aVvrklsdSfCLKxH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140073
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 6/13/23 16:32, Ian Rogers wrote:
> On Tue, Jun 13, 2023 at 5:54 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> Hi all,
>>
>> I have run the perf test suite on the current 6.4rc6 kernel and see just one error:
>> # ./perf test 2>&1 | fgrep FAILED
>> fgrep: warning: fgrep is obsolescent; using grep -F
>>  42.3: BPF prologue generation                                       : FAILED!
>> #
>>
>> However when I download the linux-next tree and build kernel and perf
>> tool with the same kernel config file, I get a bunch of failing test cases,
>> many with perf tool dumping core:
>>
>> # perf test 2>&1 | fgrep FAILED
>> fgrep: warning: fgrep is obsolescent; using grep -F
>>   6.1: Test event parsing                                            : FAILED!
>>  10.3: Parsing of PMU event table metrics                            : FAILED!
>>  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>  17: Setup struct perf_event_attr                                    : FAILED!
>>  24: Number of exit events of a simple workload                      : FAILED! core-dump
>>  28: Use a dummy software event to keep tracking                     : FAILED!
>>  35: Track with sched_switch                                         : FAILED!
>>  42.3: BPF prologue generation                                       : FAILED!
>>  66: Parse and process metrics                                       : FAILED!
>>  68: Event expansion for cgroups                                     : FAILED!
>>  69.2: Perf time to TSC                                              : FAILED! core-dump
>>  74: build id cache operations                                       : FAILED! core-dump
>>  81: kernel lock contention analysis test                            : FAILED!
>>  86: Zstd perf.data compression/decompression                        : FAILED! core-dump
>>  87: perf record tests                                               : FAILED! core-dump
>>  94: perf all metricgroups test                                      : FAILED!
>>  95: perf all metrics test                                           : FAILED!
>> 106: Test java symbol                                                : FAILED! core-dump
>> #
>>
>> I am afraid this will show up pretty soon in the linux tree.
>> I am going to look into each failure in the next few days.
>>
>> What I already found out is that many test cases now fail due to the
>> event/PMU rework, here is one example:
>>
>> # perf test -Fvvvv 95
>> 95: perf all metrics test
>> --- start ---
>> Testing cpi
>> ....
>> Metric 'transaction' not printed in:
>> Error:
>> The TX_NC_TABORT event is not supported.
>> ---- end ----
>> perf all metrics test: FAILED!
>> # ls -l /sys/devices/cpum_cf/events/TX_NC_TABORT
>> -r--r--r--. 1 root root 4096 Jun 13 13:49 /sys/devices/cpum_cf/events/TX_NC_TABORT
>> #
>>
>> As can be seen, the event is definitely there and supported.
>> This same test case succeeds in the linux tree!
>>
>> Hopefully I can sort out some of the failures before this code show up
>> in the linux tree.
> 
> Thanks Thomas, to be clear this is what is in
> perf-tools-next/linux-next and not 6.4?

Ian,

thanks for your help.
Correct, I am talking about the linux-next repo. The linux repo is fine.

> 
> Rather than try to do more complicated cases like the metrics tests,
> it makes sense to dig into why event parsing is failing. Test 6 first
> of all, could you give output?
> 
> Thanks,
> Ian
> 
We discussed some aspects of this about two weeks ago, but last week
I was on vacation and now I resumed my work on linux-next.
We run the linux-next perf test suite every night and I am concerned
and would like to get this sorted out before it hits Linux 6.5.

Here is the output on my linux-next tree built yesterday:
# uname -a
Linux a35lp67.lnxne.boe 6.4.0-rc6-next-20230613d-perf #2 \
              SMP Tue Jun 13 15:18:43 CEST 2023 s390x GNU/Linux
# ./perf test -F 6
  6: Parse event definition strings  :
  6.1: Test event parsing            :Segmentation fault (core dumped)
#
# gdb perf
  ....
  (gdb) r test -F 6
   6: Parse event definition strings                                  :
  6.1: Test event parsing                                            :
Program received signal SIGSEGV, Segmentation fault.
__GI_strcmp () at ../sysdeps/s390/strcmp-vx.S:47
(gdb) where
#0  __GI_strcmp () at ../sysdeps/s390/strcmp-vx.S:47
#1  0x000000000110a18c in test__term_equal_term (evlist=0x152ea80) at tests/parse-events.c:1580
#2  0x000000000110a96a in test_event (e=0x14dc758 <test.events+1416>) at tests/parse-events.c:2209
#3  0x000000000110ac58 in test_events (events=0x14dc1d0 <test.events>, cnt=61) at tests/parse-events.c:2260
#4  0x000000000110ad52 in test__events2 (test=0x1500758 <suite.parse_events>, subtest=0)
    at tests/parse-events.c:2272
#5  0x00000000010f6fac in run_test (test=0x1500758 <suite.parse_events>, subtest=0) at tests/builtin-test.c:236
#6  0x00000000010f7142 in test_and_print (t=0x1500758 <suite.parse_events>, subtest=0) at tests/builtin-test.c:265
#7  0x00000000010f7b1e in __cmd_test (argc=1, argv=0x3ffffffa320, skiplist=0x0) at tests/builtin-test.c:436
#8  0x00000000010f8404 in cmd_test (argc=1, argv=0x3ffffffa320) at tests/builtin-test.c:559
#9  0x00000000011473fc in run_builtin (p=0x14f60e8 <commands+600>, argc=3, argv=0x3ffffffa320) at perf.c:323
#10 0x000000000114776e in handle_internal_command (argc=3, argv=0x3ffffffa320) at perf.c:377
#11 0x0000000001147980 in run_argv (argcp=0x3ffffff9f94, argv=0x3ffffff9f88) at perf.c:421
#12 0x0000000001147d48 in main (argc=3, argv=0x3ffffffa320) at perf.c:537
(gdb)

To be honest, I am no expert on the yacc/bison/flex tool chain.
I understand a little bit about them, but that is it.

When I look at the output of perf test -Fvvvv 6 on linux-next, some things seem odd,
I marked them with 3 question masks ???:

# ./perf test -Fvvv 6
  6: Parse event definition strings     :
  6.1: Test event parsing               :
--- start ---
running test 0 'syscalls:sys_enter_openat'
Using CPUID IBM,3931,704,A01,3.7,002f
running test 1 'syscalls:*'
running test 2 'r1a'
running test 3 '1:1'
running test 4 'instructions'
No PMU found for 'instructions'FAILED tests/parse-events.c:143 wrong number of entries
Event test failure: test 4 'instructions'running test 5 'cycles/period=100000,config2/'
??? What is wrong here?
??? Output on linux 6.4.0rc3:
??? # ./perf stat -e instructions -- true
???
??? Performance counter stats for 'true':
???
???         2,965,720      instructions
???
???        0.002026832 seconds time elapsed
???
???        0.000056000 seconds user
???        0.002048000 seconds sys
??? #
??? This is fine and works as expected. The s390 PMU for counters
??? has a direct mapping for this. So we end up in the s390 PMU
??? to retrieve the value.
???
??? Output on linux-next
???# ./perf stat -e instructions -- true
???
??? Performance counter stats for 'true':
???
???              0.65 msec task-clock                       #    0.250 CPUs utilized
???                 0      context-switches                 #    0.000 /sec
???                 0      cpu-migrations                   #    0.000 /sec
???                49      page-faults                      #   75.375 K/sec
???         3,367,228      cycles                           #    5.180 GHz
???         2,880,270      instructions                     #    0.86  insn per cycle
???   <not supported>      branches
???   <not supported>      branch-misses
???
???       0.002599176 seconds time elapsed
???
???       0.000053000 seconds user
???       0.002650000 seconds sys
???
???#
??? Somehow we end up in a different PMU. The output is the same as if
??? I do not specify an event at all. To reach the s390 specific PMU
??? I have to add it explicitly as in:
???# ./perf stat -e cpum_cf/instructions/ -- true
???
??? Performance counter stats for 'true':
???
???         2,814,522      cpum_cf/instructions/
???
???       0.001899881 seconds time elapsed
???
???       0.000050000 seconds user
???       0.001928000 seconds sys
???
???]#
No PMU found for 'cycles/period=100000,config2/'FAILED tests/parse-events.c:157 wrong number of entries
Event test failure: test 5 'cycles/period=100000,config2/'running test 6 'faults'
...
??? Similar output for basicly all events.

No PMU found for 'cycles'running test 59 'cycles/name=name/'
No PMU found for 'name'Segmentation fault (core dumped)

Hope this helps.

PS: Should we keep the linux-perf-use mailing list as addressee? Not sure
if everybody else is interested in this?
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

