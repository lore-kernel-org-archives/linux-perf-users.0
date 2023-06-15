Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D4AEB64DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 08:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjFOI5t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbjFOI5s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 04:57:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF081720
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 01:57:45 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8gjYO022406;
        Thu, 15 Jun 2023 08:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=pp1; bh=8N8ASufTo0gW93j05g69FbMoVpSFjmJugU0F1Edwh2A=;
 b=FdEbxJo1RaTAF1pQntMmdpM4gZZNmuk/yFXicptkjE9GJw4udezD0v3wQ0I42Pq/iGtA
 AvSHJK2YlmGsYJ1+EEBpYDpvYKxKc4cHL2jlEusCsSD1yT8uirX+rSp5CVOdNvkCTPBj
 V7IYYkk14F/vmqTPWW/RxV0KPt5yMRjZ4dtXhlcxu35S1hQsovEngixHZgk8IrOVFpDk
 QERWfE2qXYbqz0w8FLbjozEoCg7CarBcpo/Xhx3lll5XNqBQiAVokJPbPZwqtqi3xh0j
 Razf+ywO1kq15g5hWa1kJrv6sRGbYhik8e/+mz5yc6rNx32RRmdSV+99x9UkpbS2/rlK Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ycdrcs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:57:37 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F8gwvG023156;
        Thu, 15 Jun 2023 08:57:37 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ycdrcr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:57:36 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8lwov010645;
        Thu, 15 Jun 2023 08:57:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r4gt52hx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:57:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35F8vVGP63373652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 08:57:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF74420043;
        Thu, 15 Jun 2023 08:57:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7187E20040;
        Thu, 15 Jun 2023 08:57:31 +0000 (GMT)
Received: from [9.152.212.165] (unknown [9.152.212.165])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jun 2023 08:57:31 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------Nzv7RGMHKw9UKocnxONFhlu0"
Message-ID: <b33a13cc-a3cc-3e81-1787-0643b3aac623@linux.ibm.com>
Date:   Thu, 15 Jun 2023 10:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: perf test failures in linux-next on s390
To:     Ian Rogers <irogers@google.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
 <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CUNllRH7sUXhJkneIjwY8F8Z_M56VgE-
X-Proofpoint-GUID: IFN_n-YVwbcw5z9X8SkVD858XCigrj6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150072
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------Nzv7RGMHKw9UKocnxONFhlu0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/14/23 16:57, Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 1:32 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> On 6/13/23 16:32, Ian Rogers wrote:
>>> On Tue, Jun 13, 2023 at 5:54 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> I have run the perf test suite on the current 6.4rc6 kernel and see just one error:
>>>> # ./perf test 2>&1 | fgrep FAILED
>>>> fgrep: warning: fgrep is obsolescent; using grep -F
>>>>  42.3: BPF prologue generation                                       : FAILED!
>>>> #
>>>>
>>>> However when I download the linux-next tree and build kernel and perf
>>>> tool with the same kernel config file, I get a bunch of failing test cases,
>>>> many with perf tool dumping core:
>>>>
>>>> # perf test 2>&1 | fgrep FAILED
>>>> fgrep: warning: fgrep is obsolescent; using grep -F
>>>>   6.1: Test event parsing                                            : FAILED!
>>>>  10.3: Parsing of PMU event table metrics                            : FAILED!
>>>>  10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>>>  17: Setup struct perf_event_attr                                    : FAILED!
>>>>  24: Number of exit events of a simple workload                      : FAILED! core-dump
>>>>  28: Use a dummy software event to keep tracking                     : FAILED!
>>>>  35: Track with sched_switch                                         : FAILED!
>>>>  42.3: BPF prologue generation                                       : FAILED!
>>>>  66: Parse and process metrics                                       : FAILED!
>>>>  68: Event expansion for cgroups                                     : FAILED!
>>>>  69.2: Perf time to TSC                                              : FAILED! core-dump
>>>>  74: build id cache operations                                       : FAILED! core-dump
>>>>  81: kernel lock contention analysis test                            : FAILED!
>>>>  86: Zstd perf.data compression/decompression                        : FAILED! core-dump
>>>>  87: perf record tests                                               : FAILED! core-dump
>>>>  94: perf all metricgroups test                                      : FAILED!
>>>>  95: perf all metrics test                                           : FAILED!
>>>> 106: Test java symbol                                                : FAILED! core-dump
>>>> #
>>>>
>>>> I am afraid this will show up pretty soon in the linux tree.
>>>> I am going to look into each failure in the next few days.
>>>>
>>>> What I already found out is that many test cases now fail due to the
>>>> event/PMU rework, here is one example:
>>>>
>>>> # perf test -Fvvvv 95
>>>> 95: perf all metrics test
>>>> --- start ---
>>>> Testing cpi
>>>> ....
>>>> Metric 'transaction' not printed in:
>>>> Error:
>>>> The TX_NC_TABORT event is not supported.
>>>> ---- end ----
>>>> perf all metrics test: FAILED!
>>>> # ls -l /sys/devices/cpum_cf/events/TX_NC_TABORT
>>>> -r--r--r--. 1 root root 4096 Jun 13 13:49 /sys/devices/cpum_cf/events/TX_NC_TABORT
>>>> #
>>>>
>>>> As can be seen, the event is definitely there and supported.
>>>> This same test case succeeds in the linux tree!
>>>>
>>>> Hopefully I can sort out some of the failures before this code show up
>>>> in the linux tree.
>>>
>>> Thanks Thomas, to be clear this is what is in
>>> perf-tools-next/linux-next and not 6.4?
>>
>> Ian,
>>
>> thanks for your help.
>> Correct, I am talking about the linux-next repo. The linux repo is fine.
>>
>>>
>>> Rather than try to do more complicated cases like the metrics tests,
>>> it makes sense to dig into why event parsing is failing. Test 6 first
>>> of all, could you give output?
>>>
>>> Thanks,
>>> Ian
>>>
>> We discussed some aspects of this about two weeks ago, but last week
>> I was on vacation and now I resumed my work on linux-next.
>> We run the linux-next perf test suite every night and I am concerned
>> and would like to get this sorted out before it hits Linux 6.5.
>>
>> Here is the output on my linux-next tree built yesterday:
>> # uname -a
>> Linux a35lp67.lnxne.boe 6.4.0-rc6-next-20230613d-perf #2 \
>>               SMP Tue Jun 13 15:18:43 CEST 2023 s390x GNU/Linux
>> # ./perf test -F 6
>>   6: Parse event definition strings  :
>>   6.1: Test event parsing            :Segmentation fault (core dumped)
>> #
>> # gdb perf
>>   ....
>>   (gdb) r test -F 6
>>    6: Parse event definition strings                                  :
>>   6.1: Test event parsing                                            :
>> Program received signal SIGSEGV, Segmentation fault.
>> __GI_strcmp () at ../sysdeps/s390/strcmp-vx.S:47
>> (gdb) where
>> #0  __GI_strcmp () at ../sysdeps/s390/strcmp-vx.S:47
>> #1  0x000000000110a18c in test__term_equal_term (evlist=0x152ea80) at tests/parse-events.c:1580
>> #2  0x000000000110a96a in test_event (e=0x14dc758 <test.events+1416>) at tests/parse-events.c:2209
>> #3  0x000000000110ac58 in test_events (events=0x14dc1d0 <test.events>, cnt=61) at tests/parse-events.c:2260
>> #4  0x000000000110ad52 in test__events2 (test=0x1500758 <suite.parse_events>, subtest=0)
>>     at tests/parse-events.c:2272
>> #5  0x00000000010f6fac in run_test (test=0x1500758 <suite.parse_events>, subtest=0) at tests/builtin-test.c:236
>> #6  0x00000000010f7142 in test_and_print (t=0x1500758 <suite.parse_events>, subtest=0) at tests/builtin-test.c:265
>> #7  0x00000000010f7b1e in __cmd_test (argc=1, argv=0x3ffffffa320, skiplist=0x0) at tests/builtin-test.c:436
>> #8  0x00000000010f8404 in cmd_test (argc=1, argv=0x3ffffffa320) at tests/builtin-test.c:559
>> #9  0x00000000011473fc in run_builtin (p=0x14f60e8 <commands+600>, argc=3, argv=0x3ffffffa320) at perf.c:323
>> #10 0x000000000114776e in handle_internal_command (argc=3, argv=0x3ffffffa320) at perf.c:377
>> #11 0x0000000001147980 in run_argv (argcp=0x3ffffff9f94, argv=0x3ffffff9f88) at perf.c:421
>> #12 0x0000000001147d48 in main (argc=3, argv=0x3ffffffa320) at perf.c:537
>> (gdb)
>>
>> To be honest, I am no expert on the yacc/bison/flex tool chain.
>> I understand a little bit about them, but that is it.
>>
>> When I look at the output of perf test -Fvvvv 6 on linux-next, some things seem odd,
>> I marked them with 3 question masks ???:
>>
>> # ./perf test -Fvvv 6
>>   6: Parse event definition strings     :
>>   6.1: Test event parsing               :
>> --- start ---
>> running test 0 'syscalls:sys_enter_openat'
>> Using CPUID IBM,3931,704,A01,3.7,002f
>> running test 1 'syscalls:*'
>> running test 2 'r1a'
>> running test 3 '1:1'
>> running test 4 'instructions'
>> No PMU found for 'instructions'FAILED tests/parse-events.c:143 wrong number of entries
>> Event test failure: test 4 'instructions'running test 5 'cycles/period=100000,config2/'
>> ??? What is wrong here?
>> ??? Output on linux 6.4.0rc3:
>> ??? # ./perf stat -e instructions -- true
>> ???
>> ??? Performance counter stats for 'true':
>> ???
>> ???         2,965,720      instructions
>> ???
>> ???        0.002026832 seconds time elapsed
>> ???
>> ???        0.000056000 seconds user
>> ???        0.002048000 seconds sys
>> ??? #
>> ??? This is fine and works as expected. The s390 PMU for counters
>> ??? has a direct mapping for this. So we end up in the s390 PMU
>> ??? to retrieve the value.
>> ???
>> ??? Output on linux-next
>> ???# ./perf stat -e instructions -- true
>> ???
>> ??? Performance counter stats for 'true':
>> ???
>> ???              0.65 msec task-clock                       #    0.250 CPUs utilized
>> ???                 0      context-switches                 #    0.000 /sec
>> ???                 0      cpu-migrations                   #    0.000 /sec
>> ???                49      page-faults                      #   75.375 K/sec
>> ???         3,367,228      cycles                           #    5.180 GHz
>> ???         2,880,270      instructions                     #    0.86  insn per cycle
>> ???   <not supported>      branches
>> ???   <not supported>      branch-misses
>> ???
>> ???       0.002599176 seconds time elapsed
>> ???
>> ???       0.000053000 seconds user
>> ???       0.002650000 seconds sys
>> ???
>> ???#
>> ??? Somehow we end up in a different PMU. The output is the same as if
>> ??? I do not specify an event at all. To reach the s390 specific PMU
>> ??? I have to add it explicitly as in:
>> ???# ./perf stat -e cpum_cf/instructions/ -- true
>> ???
>> ??? Performance counter stats for 'true':
>> ???
>> ???         2,814,522      cpum_cf/instructions/
>> ???
>> ???       0.001899881 seconds time elapsed
>> ???
>> ???       0.000050000 seconds user
>> ???       0.001928000 seconds sys
>> ???
>> ???]#
>> No PMU found for 'cycles/period=100000,config2/'FAILED tests/parse-events.c:157 wrong number of entries
>> Event test failure: test 5 'cycles/period=100000,config2/'running test 6 'faults'
>> ...
>> ??? Similar output for basicly all events.
>>
>> No PMU found for 'cycles'running test 59 'cycles/name=name/'
>> No PMU found for 'name'Segmentation fault (core dumped)
>>
>> Hope this helps.
>>
>> PS: Should we keep the linux-perf-use mailing list as addressee? Not sure
>> if everybody else is interested in this?
> 
> Smaller list is okay. Could you send me a zip of the sysfs
> (/sys/devices) ? At least one issue is that the code didn't find a
> core PMU. On non-hybrid x86 this would be /sys/devices/cpu, I think we
> spoke about this before for s390 and there are >1. The issue here is
> that the test found 0, and we're trying to use PMUs in the code now as
> a way to sort events. There's code/comment in util/pmu.c:
> 
> '''
> /**
>  * is_sysfs_pmu_core() - PMU CORE devices have different name other than cpu in
>  *         sysfs on some platforms like ARM or Intel hybrid. Looking for
>  *         possible the cpus file in sysfs files to identify whether this is a
>  *         core device.
>  * @name: The PMU name such as "cpu_atom".
>  */
> static int is_sysfs_pmu_core(const char *name)
> {
> char path[PATH_MAX];
> 
> if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpus"))
> return 0;
> return file_available(path);
> }
> ...
> bool is_pmu_core(const char *name)
> {
> return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> }
> '''
> 
> Thanks,
> Ian
> 

Thanks for refreshing my memory. With s390 core PMU named as
/sys/devices/cpum_cf, this fix was missing:

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fe64ad292d36..6142e4710a2f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1419,7 +1419,7 @@ void perf_pmu__del_formats(struct list_head *formats)
 
 bool is_pmu_core(const char *name)
 {
-       return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
+       return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
 }
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)

With that fix applied, the test succeeds:

# ./perf test -F 6
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : Ok
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : Ok
  6.6: Parsing of terms (event modifiers)                            : Ok
#

I have tried to send my /sys/devices tree before as zip or tgz but that
mail got deleted by your mailer because it contained compressed data.

So I send you an ls -lR from our 5 PMUs on s390 as text attachment and
here are the type values:
# for i in  /sys/devices/cpum_[sc]f* /sys/devices/pai_*; do echo PMU $i PMU_TYPE $(cat $i/type); done
PMU /sys/devices/cpum_cf PMU_TYPE 8
PMU /sys/devices/cpum_cf_diag PMU_TYPE 9
PMU /sys/devices/cpum_sf PMU_TYPE 4
PMU /sys/devices/pai_crypto PMU_TYPE 10
PMU /sys/devices/pai_ext PMU_TYPE 11
# 

For the /sys/devices/PMU tree see attachment sysfs-s390.txt

Thanks a lot for you help.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

--------------Nzv7RGMHKw9UKocnxONFhlu0
Content-Type: text/plain; charset=UTF-8; name="sysfs-s390.txt"
Content-Disposition: attachment; filename="sysfs-s390.txt"
Content-Transfer-Encoding: base64

L3N5cy9kZXZpY2VzL2NwdW1fY2Y6CnRvdGFsIDAKZHJ3eHIteHIteCAyIHJvb3Qgcm9vdCAg
ICAwIEp1biAxNCAxMzowMyBldmVudHMKZHJ3eHIteHIteCAyIHJvb3Qgcm9vdCAgICAwIEp1
biAxNCAxMzowMyBmb3JtYXQKLXJ3LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAx
MDo0OCBwZXJmX2V2ZW50X211eF9pbnRlcnZhbF9tcwpscnd4cnd4cnd4IDEgcm9vdCByb290
ICAgIDAgSnVuIDE1IDEwOjQ4IHN1YnN5c3RlbSAtPiAuLi8uLi9idXMvZXZlbnRfc291cmNl
Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgdHlwZQotcnctci0t
ci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjQ4IHVldmVudAoKL3N5cy9kZXZpY2Vz
L2NwdW1fY2YvZXZlbnRzOgp0b3RhbCAwCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBK
dW4gMTQgMTM6MDMgQUVTX0JMT0NLRURfQ1lDTEVTCi1yLS1yLS1yLS0gMSByb290IHJvb3Qg
NDA5NiBKdW4gMTQgMTM6MDMgQUVTX0JMT0NLRURfRlVOQ1RJT05TCi1yLS1yLS1yLS0gMSBy
b290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgQUVTX0NZQ0xFUwotci0tci0tci0tIDEgcm9v
dCByb290IDQwOTYgSnVuIDE0IDEzOjAzIEFFU19GVU5DVElPTlMKLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBCQ0RfREZQX0VYRUNVVElPTl9TTE9UUwotci0t
ci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIENQVV9DWUNMRVMKLXItLXIt
LXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBDUlNURV8xTUJfV1JJVEVTCi1y
LS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgRENXX09GRl9EUkFXRVIK
LXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBEQ1dfT0ZGX0RSQVdF
Ul9NRU1PUlkKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBEQ1df
T05fQ0hJUAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIERDV19P
Tl9DSElQX0NISVBfSElUCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6
MDMgRENXX09OX0NISVBfRFJBV0VSX0hJVAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYg
SnVuIDE0IDEzOjAzIERDV19PTl9DSElQX0lWCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5
NiBKdW4gMTQgMTM6MDMgRENXX09OX0NISVBfTUVNT1JZCi1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBKdW4gMTQgMTM6MDMgRENXX09OX0RSQVdFUgotci0tci0tci0tIDEgcm9vdCBy
b290IDQwOTYgSnVuIDE0IDEzOjAzIERDV19PTl9EUkFXRVJfTUVNT1JZCi1yLS1yLS1yLS0g
MSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgRENXX09OX01PRFVMRQotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIERDV19PTl9NT0RVTEVfTUVNT1JZCi1y
LS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgRENXX1JFUQotci0tci0t
ci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIERDV19SRVFfQ0hJUF9ISVQKLXIt
LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBEQ1dfUkVRX0RSQVdFUl9I
SVQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBEQ1dfUkVRX0lW
Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgREVBX0JMT0NLRURf
Q1lDTEVTCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgREVBX0JM
T0NLRURfRlVOQ1RJT05TCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6
MDMgREVBX0NZQ0xFUwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAz
IERFQV9GVU5DVElPTlMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzow
MyBERUNJTUFMX0lOU1RSVUNUSU9OUwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE0IDEzOjAzIERGTFRfQUNDRVNTCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4g
MTQgMTM6MDMgREZMVF9DQwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEz
OjAzIERGTFRfQ0NGSU5JU0gKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAx
MzowMyBERkxUX0NZQ0xFUwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEz
OjAzIERUTEIyX0dQQUdFX1dSSVRFUwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE0IDEzOjAzIERUTEIyX01JU1NFUwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE0IDEzOjAzIERUTEIyX1dSSVRFUwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE0IDEzOjAzIEVDQ19CTE9DS0VEX0NZQ0xFU19DT1VOVAotci0tci0tci0tIDEgcm9vdCBy
b290IDQwOTYgSnVuIDE0IDEzOjAzIEVDQ19CTE9DS0VEX0ZVTkNUSU9OX0NPVU5UCi1yLS1y
LS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgRUNDX0NZQ0xFU19DT1VOVAot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIEVDQ19GVU5DVElPTl9D
T1VOVAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElDV19PRkZf
RFJBV0VSCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgSUNXX09G
Rl9EUkFXRVJfTUVNT1JZCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6
MDMgSUNXX09OX0NISVAKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzow
MyBJQ1dfT05fQ0hJUF9DSElQX0hJVAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE0IDEzOjAzIElDV19PTl9DSElQX0RSQVdFUl9ISVQKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNCAxMzowMyBJQ1dfT05fQ0hJUF9JVgotci0tci0tci0tIDEgcm9vdCBy
b290IDQwOTYgSnVuIDE0IDEzOjAzIElDV19PTl9DSElQX01FTU9SWQotci0tci0tci0tIDEg
cm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElDV19PTl9EUkFXRVIKLXItLXItLXItLSAx
IHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBJQ1dfT05fRFJBV0VSX01FTU9SWQotci0t
ci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElDV19PTl9NT0RVTEUKLXIt
LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBJQ1dfT05fTU9EVUxFX01F
TU9SWQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElDV19SRVEK
LXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBJQ1dfUkVRX0NISVBf
SElUCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgSUNXX1JFUV9E
UkFXRVJfSElUCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgSUNX
X1JFUV9JVgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElEQ1df
T0ZGX0RSQVdFUl9DSElQX0hJVAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0
IDEzOjAzIElEQ1dfT0ZGX0RSQVdFUl9EUkFXRVJfSElUCi1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBKdW4gMTQgMTM6MDMgSURDV19PRkZfRFJBV0VSX0lWCi1yLS1yLS1yLS0gMSBy
b290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgSURDV19PTl9EUkFXRVJfQ0hJUF9ISVQKLXIt
LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBJRENXX09OX0RSQVdFUl9E
UkFXRVJfSElUCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgSURD
V19PTl9EUkFXRVJfSVYKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzow
MyBJRENXX09OX01PRFVMRV9DSElQX0hJVAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYg
SnVuIDE0IDEzOjAzIElEQ1dfT05fTU9EVUxFX0RSQVdFUl9ISVQKLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBJRENXX09OX01PRFVMRV9JVgotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElOU1RSVUNUSU9OUwotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElUTEIyX01JU1NFUwotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIElUTEIyX1dSSVRFUwotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIEwxQ19UTEIyX01JU1NFUwotci0tci0t
ci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIEwxRF9ESVJfV1JJVEVTCi1yLS1y
LS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTDFEX1BFTkFMVFlfQ1lDTEVT
Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTDFEX1JPX0VYQ0xf
V1JJVEVTCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTDFJX0RJ
Ul9XUklURVMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBMMUlf
UEVOQUxUWV9DWUNMRVMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzow
MyBMQVNUX0hPU1RfVFJBTlNMQVRJT05TCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBK
dW4gMTQgMTM6MDMgTVRfRElBR19DWUNMRVNfT05FX1RIUl9BQ1RJVkUKLXItLXItLXItLSAx
IHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBNVF9ESUFHX0NZQ0xFU19UV09fVEhSX0FD
VElWRQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIE5OUEFfQ09N
UExFVElPTlMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBB
X0hPTERfTE9DSwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIE5O
UEFfSU5WT0NBVElPTlMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzow
MyBOTlBBX1dBSVRfTE9DSwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEz
OjAzIFBSTkdfQkxPQ0tFRF9DWUNMRVMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1
biAxNCAxMzowMyBQUk5HX0JMT0NLRURfRlVOQ1RJT05TCi1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBKdW4gMTQgMTM6MDMgUFJOR19DWUNMRVMKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNCAxMzowMyBQUk5HX0ZVTkNUSU9OUwotci0tci0tci0tIDEgcm9vdCBy
b290IDQwOTYgSnVuIDE0IDEzOjAzIFBST0JMRU1fU1RBVEVfQ1BVX0NZQ0xFUwotci0tci0t
ci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIFBST0JMRU1fU1RBVEVfSU5TVFJV
Q1RJT05TCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgU0hBX0JM
T0NLRURfQ1lDTEVTCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMg
U0hBX0JMT0NLRURfRlVOQ1RJT05TCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4g
MTQgMTM6MDMgU0hBX0NZQ0xFUwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0
IDEzOjAzIFNIQV9GVU5DVElPTlMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAx
NCAxMzowMyBTT1JUTAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAz
IFRMQjJfQ1JTVEVfV1JJVEVTCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQg
MTM6MDMgVExCMl9FTkdJTkVTX0JVU1kKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1
biAxNCAxMzowMyBUTEIyX1BURV9XUklURVMKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2
IEp1biAxNCAxMzowMyBUWF9DX1RBQk9SVF9OT19TUEVDSUFMCi1yLS1yLS1yLS0gMSByb290
IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgVFhfQ19UQUJPUlRfU1BFQ0lBTAotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIFRYX0NfVEVORAotci0tci0tci0tIDEg
cm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIFRYX05DX1RBQk9SVAotci0tci0tci0tIDEg
cm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIFRYX05DX1RFTkQKLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBWWF9CQ0RfRVhFQ1VUSU9OX1NMT1RTCgovc3lz
L2RldmljZXMvY3B1bV9jZi9mb3JtYXQ6CnRvdGFsIDAKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNCAxMzowMyBldmVudAoKL3N5cy9kZXZpY2VzL2NwdW1fY2ZfZGlhZzoK
dG90YWwgMApkcnd4ci14ci14IDIgcm9vdCByb290ICAgIDAgSnVuIDE0IDE1OjQzIGV2ZW50
cwpkcnd4ci14ci14IDIgcm9vdCByb290ICAgIDAgSnVuIDE0IDE1OjQzIGZvcm1hdAotcnct
ci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjUzIHBlcmZfZXZlbnRfbXV4X2lu
dGVydmFsX21zCmxyd3hyd3hyd3ggMSByb290IHJvb3QgICAgMCBKdW4gMTUgMTA6NTMgc3Vi
c3lzdGVtIC0+IC4uLy4uL2J1cy9ldmVudF9zb3VyY2UKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNCAxNTo0MyB0eXBlCi1ydy1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBK
dW4gMTUgMTA6NTMgdWV2ZW50Cgovc3lzL2RldmljZXMvY3B1bV9jZl9kaWFnL2V2ZW50czoK
dG90YWwgMAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDE1OjQzIENGX0RJ
QUcKCi9zeXMvZGV2aWNlcy9jcHVtX2NmX2RpYWcvZm9ybWF0Ogp0b3RhbCAwCi1yLS1yLS1y
LS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTU6NDMgZXZlbnQKCi9zeXMvZGV2aWNlcy9j
cHVtX3NmOgp0b3RhbCAwCmRyd3hyLXhyLXggMiByb290IHJvb3QgICAgMCBKdW4gMTQgMTM6
MDMgZXZlbnRzCmRyd3hyLXhyLXggMiByb290IHJvb3QgICAgMCBKdW4gMTQgMTM6MDMgZm9y
bWF0Ci1ydy1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6NDggcGVyZl9ldmVu
dF9tdXhfaW50ZXJ2YWxfbXMKbHJ3eHJ3eHJ3eCAxIHJvb3Qgcm9vdCAgICAwIEp1biAxNSAx
MDo0OCBzdWJzeXN0ZW0gLT4gLi4vLi4vYnVzL2V2ZW50X3NvdXJjZQotci0tci0tci0tIDEg
cm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIHR5cGUKLXJ3LXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDo0OCB1ZXZlbnQKCi9zeXMvZGV2aWNlcy9jcHVtX3NmL2V2ZW50
czoKdG90YWwgMAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIFNG
X0NZQ0xFU19CQVNJQwotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAz
IFNGX0NZQ0xFU19CQVNJQ19ESUFHCgovc3lzL2RldmljZXMvY3B1bV9zZi9mb3JtYXQ6CnRv
dGFsIDAKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBldmVudAoK
L3N5cy9kZXZpY2VzL3BhaV9jcnlwdG86CnRvdGFsIDAKZHJ3eHIteHIteCAyIHJvb3Qgcm9v
dCAgICAwIEp1biAxNCAxMjoxMiBldmVudHMKZHJ3eHIteHIteCAyIHJvb3Qgcm9vdCAgICAw
IEp1biAxNCAxMzowMyBmb3JtYXQKLXJ3LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAx
NSAxMDo0OSBwZXJmX2V2ZW50X211eF9pbnRlcnZhbF9tcwpscnd4cnd4cnd4IDEgcm9vdCBy
b290ICAgIDAgSnVuIDE1IDEwOjQ5IHN1YnN5c3RlbSAtPiAuLi8uLi9idXMvZXZlbnRfc291
cmNlCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgdHlwZQotcnct
ci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjQ5IHVldmVudAoKL3N5cy9kZXZp
Y2VzL3BhaV9jcnlwdG8vZXZlbnRzOgp0b3RhbCAwCi1yLS1yLS1yLS0gMSByb290IHJvb3Qg
NDA5NiBKdW4gMTQgMTU6NDMgQ1JZUFRPX0FMTAotci0tci0tci0tIDEgcm9vdCByb290IDQw
OTYgSnVuIDE1IDEwOjMzIElCTV9SRVNFUlZFRF8xNTUKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDozMyBJQk1fUkVTRVJWRURfMTU2Ci1yLS1yLS1yLS0gMSByb290
IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS0RTQV9FQ0RTQV9TSUdOX1AyNTYKLXItLXItLXIt
LSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLRFNBX0VDRFNBX1NJR05fUDM4NAot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtEU0FfRUNEU0FfU0lH
Tl9QNTIxCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS0RTQV9F
Q0RTQV9WRVJJRllfUDI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEw
OjMzIEtEU0FfRUNEU0FfVkVSSUZZX1AzODQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2
IEp1biAxNSAxMDozMyBLRFNBX0VDRFNBX1ZFUklGWV9QNTIxCi1yLS1yLS1yLS0gMSByb290
IHJvb3QgNDA5NiBKdW4gMTQgMTU6NDMgS0RTQV9FRERTQV9TSUdOX0VEMjU1MTkKLXItLXIt
LXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLRFNBX0VERFNBX1NJR05fRUQ0
NDgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLRFNBX0VERFNB
X1ZFUklGWV9FRDI1NTE5Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6
MzMgS0RTQV9FRERTQV9WRVJJRllfRUQ0NDgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2
IEp1biAxNCAxNTo0MyBLRFNBX0VOQ1JZUFRFRF9FQ0RTQV9TSUdOX1AyNTYKLXItLXItLXIt
LSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLRFNBX0VOQ1JZUFRFRF9FQ0RTQV9T
SUdOX1AzODQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxNTo0MyBLRFNB
X0VOQ1JZUFRFRF9FQ0RTQV9TSUdOX1A1MjEKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2
IEp1biAxNSAxMDozMyBLRFNBX0VOQ1JZUFRFRF9FRERTQV9TSUdOX0VEMjU1MTkKLXItLXIt
LXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLRFNBX0VOQ1JZUFRFRF9FRERT
QV9TSUdOX0VENDQ4Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMg
S0lNRF9HSEFTSAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtJ
TURfU0hBXzEKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLSU1E
X1NIQV8yNTYKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLSU1E
X1NIQTNfMjI0Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS0lN
RF9TSEEzXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDE1OjQzIEtJ
TURfU0hBM18zODQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBL
SU1EX1NIQTNfNTEyCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMg
S0lNRF9TSEFfNTEyCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMg
S0lNRF9TSEFLRV8xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDoz
MyBLSU1EX1NIQUtFXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEz
OjAzIEtMTURfU0hBXzEKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDoz
MyBLTE1EX1NIQV8yNTYKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDoz
MyBLTE1EX1NIQTNfMjI0Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6
MzMgS0xNRF9TSEEzXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEw
OjMzIEtMTURfU0hBM18zODQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAx
NTo0MyBLTE1EX1NIQTNfNTEyCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUg
MTA6MzMgS0xNRF9TSEFfNTEyCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQg
MTU6NDMgS0xNRF9TSEFLRV8xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAx
NSAxMDozMyBLTE1EX1NIQUtFXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNQUNfQUVTXzEyOAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNQUNfQUVTXzE5Mgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNQUNfQUVTXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNQUNfREVBCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUg
MTA6MzMgS01BQ19FTkNSWVBURURfQUVTXzEyOAotci0tci0tci0tIDEgcm9vdCByb290IDQw
OTYgSnVuIDE1IDEwOjMzIEtNQUNfRU5DUllQVEVEX0FFU18xOTIKLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0MDk2IEp1biAxNCAxNTo0MyBLTUFDX0VOQ1JZUFRFRF9BRVNfMjU2Ci1yLS1y
LS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01BQ19FTkNSWVBURURfREVB
Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTU6NDMgS01BQ19FTkNSWVBU
RURfVERFQV8xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxNTo0MyBL
TUFDX0VOQ1JZUFRFRF9UREVBXzE5Mgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNQUNfVERFQV8xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1
biAxNSAxMDozMyBLTUFDX1RERUFfMTkyCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBK
dW4gMTUgMTA6MzMgS01fQUVTXzEyOAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNX0FFU18xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAx
NSAxMDozMyBLTV9BRVNfMjU2Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQg
MTU6NDMgS01BX0dDTV9BRVNfMTI4Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4g
MTUgMTA6MzMgS01BX0dDTV9BRVNfMTkyCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBK
dW4gMTUgMTA6MzMgS01BX0dDTV9BRVNfMjU2Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5
NiBKdW4gMTUgMTA6MzMgS01BX0dDTV9FTkNSWVBURURfQUVTXzEyOAotci0tci0tci0tIDEg
cm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNQV9HQ01fRU5DUllQVEVEX0FFU18xOTIK
LXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTUFfR0NNX0VOQ1JZ
UFRFRF9BRVNfMjU2Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMg
S01DX0FFU18xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBL
TUNfQUVTXzE5Mgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtN
Q19BRVNfMjU2Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01D
X0RFQQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNQ19FTkNS
WVBURURfQUVTXzEyOAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDE1OjQz
IEtNQ19FTkNSWVBURURfQUVTXzE5Mgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNQ19FTkNSWVBURURfQUVTXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290
IDQwOTYgSnVuIDE1IDEwOjMzIEtNQ19FTkNSWVBURURfREVBCi1yLS1yLS1yLS0gMSByb290
IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01DX0VOQ1JZUFRFRF9UREVBXzEyOAotci0tci0t
ci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNQ19FTkNSWVBURURfVERFQV8x
OTIKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTUNfUFJORwot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNQ19UREVBXzEyOAot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDE1OjQzIEtNQ19UREVBXzE5Mgot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNQ1RSX0FFU18xMjgK
LXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTUNUUl9BRVNfMTky
Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01DVFJfQUVTXzI1
Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNQ1RSX0RFQQot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDE1OjQzIEtNQ1RSX0VOQ1JZUFRF
RF9BRVNfMTI4Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01D
VFJfRU5DUllQVEVEX0FFU18xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAx
NSAxMDozMyBLTUNUUl9FTkNSWVBURURfQUVTXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290
IDQwOTYgSnVuIDE0IDE1OjQzIEtNQ1RSX0VOQ1JZUFRFRF9ERUEKLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTUNUUl9FTkNSWVBURURfVERFQV8xMjgKLXIt
LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTUNUUl9FTkNSWVBURURf
VERFQV8xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTUNU
Ul9UREVBXzEyOAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtN
Q1RSX1RERUFfMTkyCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMg
S01fREVBCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01fRU5D
UllQVEVEX0FFU18xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDoz
MyBLTV9FTkNSWVBURURfQUVTXzE5Mgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNX0VOQ1JZUFRFRF9BRVNfMjU2Ci1yLS1yLS1yLS0gMSByb290IHJvb3Qg
NDA5NiBKdW4gMTUgMTA6MzMgS01fRU5DUllQVEVEX0RFQQotci0tci0tci0tIDEgcm9vdCBy
b290IDQwOTYgSnVuIDE1IDEwOjMzIEtNX0VOQ1JZUFRFRF9UREVBXzEyOAotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNX0VOQ1JZUFRFRF9UREVBXzE5Mgot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNRl9BRVNfMTI4Ci1y
LS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01GX0FFU18xOTIKLXIt
LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxNTo0MyBLTUZfQUVTXzI1Ngotci0t
ci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNRl9ERUEKLXItLXItLXIt
LSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxNTo0MyBLTUZfRU5DUllQVEVEX0FFU18xMjgK
LXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxNTo0MyBLTUZfRU5DUllQVEVE
X0FFU18xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTUZf
RU5DUllQVEVEX0FFU18yNTYKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAx
MDozMyBLTUZfRU5DUllQVEVEX0RFQQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNRl9FTkNSWVBURURfVERFQV8xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDozMyBLTUZfRU5DUllQVEVEX1RERUFfMTkyCi1yLS1yLS1yLS0g
MSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01GX1RERUFfMTI4Ci1yLS1yLS1yLS0g
MSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01GX1RERUFfMTkyCi1yLS1yLS1yLS0g
MSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01PX0FFU18xMjgKLXItLXItLXItLSAx
IHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBLTU9fQUVTXzE5Mgotci0tci0tci0tIDEg
cm9vdCByb290IDQwOTYgSnVuIDE0IDE1OjQzIEtNT19BRVNfMjU2Ci1yLS1yLS1yLS0gMSBy
b290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgS01PX0RFQQotci0tci0tci0tIDEgcm9vdCBy
b290IDQwOTYgSnVuIDE0IDE1OjQzIEtNT19FTkNSWVBURURfQUVTXzEyOAotci0tci0tci0t
IDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNT19FTkNSWVBURURfQUVTXzE5Mgot
ci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNT19FTkNSWVBURURf
QUVTXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNT19F
TkNSWVBURURfREVBCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMg
S01PX0VOQ1JZUFRFRF9UREVBXzEyOAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVu
IDE1IDEwOjMzIEtNT19FTkNSWVBURURfVERFQV8xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDozMyBLTU9fVERFQV8xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDozMyBLTU9fVERFQV8xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDozMyBLTV9UREVBXzEyOAotci0tci0tci0tIDEgcm9vdCByb290
IDQwOTYgSnVuIDE1IDEwOjMzIEtNX1RERUFfMTkyCi1yLS1yLS1yLS0gMSByb290IHJvb3Qg
NDA5NiBKdW4gMTQgMTU6NDMgS01fWFRTX0FFU18xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDozMyBLTV9YVFNfQUVTXzI1Ngotci0tci0tci0tIDEgcm9vdCBy
b290IDQwOTYgSnVuIDE1IDEwOjMzIEtNX1hUU19FTkNSWVBURURfQUVTXzEyOAotci0tci0t
ci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIEtNX1hUU19FTkNSWVBURURfQUVT
XzI1Ngotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19DT01Q
VVRFX0xBU1RfQkxPQ0tfQ01BQ19VU0lOR19BRVNfMTI4Ci1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBKdW4gMTUgMTA6MzMgUENDX0NPTVBVVEVfTEFTVF9CTE9DS19DTUFDX1VTSU5H
X0FFU18xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBQQ0Nf
Q09NUFVURV9MQVNUX0JMT0NLX0NNQUNfVVNJTkdfQUVTXzI1Ngotci0tci0tci0tIDEgcm9v
dCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19DT01QVVRFX0xBU1RfQkxPQ0tfQ01BQ19V
U0lOR19ERUEKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBQQ0Nf
Q09NUFVURV9MQVNUX0JMT0NLX0NNQUNfVVNJTkdfRU5DUllQVEVEX0FFU18xMjgKLXItLXIt
LXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBQQ0NfQ09NUFVURV9MQVNUX0JM
T0NLX0NNQUNfVVNJTkdfRU5DUllQVEVEX0FFU18xOTIKLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0MDk2IEp1biAxNSAxMDozMyBQQ0NfQ09NUFVURV9MQVNUX0JMT0NLX0NNQUNfVVNJTkdf
RU5DUllQVEVEX0FFU18yNTZBCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUg
MTA6MzMgUENDX0NPTVBVVEVfTEFTVF9CTE9DS19DTUFDX1VTSU5HX0VOQ1JZUFRFRF9ERUEK
LXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxNTo0MyBQQ0NfQ09NUFVURV9M
QVNUX0JMT0NLX0NNQUNfVVNJTkdfRU5DUllQVEVEX1RERUFfMTI4Ci1yLS1yLS1yLS0gMSBy
b290IHJvb3QgNDA5NiBKdW4gMTUgMTA6MzMgUENDX0NPTVBVVEVfTEFTVF9CTE9DS19DTUFD
X1VTSU5HX0VOQ1JZUFRFRF9UREVBXzE5Mgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYg
SnVuIDE1IDEwOjMzIFBDQ19DT01QVVRFX0xBU1RfQkxPQ0tfQ01BQ19VU0lOR19UREVBXzEy
OAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19DT01QVVRF
X0xBU1RfQkxPQ0tfQ01BQ19VU0lOR19UREVBXzE5Mgotci0tci0tci0tIDEgcm9vdCByb290
IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19DT01QVVRFX1hUU19QQVJBTUVURVJfVVNJTkdfQUVT
XzEyOAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19DT01Q
VVRFX1hUU19QQVJBTUVURVJfVVNJTkdfQUVTXzI1Ngotci0tci0tci0tIDEgcm9vdCByb290
IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19DT01QVVRFX1hUU19QQVJBTUVURVJfVVNJTkdfRU5D
UllQVEVEX0FFU18xMjgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDoz
MyBQQ0NfQ09NUFVURV9YVFNfUEFSQU1FVEVSX1VTSU5HX0VOQ1JZUFRFRF9BRVNfMjU2Ci1y
LS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTU6NDMgUENDX1NDQUxBUl9NVUxU
SVBMWV9FRDI1NTE5Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTU6NDMg
UENDX1NDQUxBUl9NVUxUSVBMWV9FRDQ0OAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYg
SnVuIDE1IDEwOjMzIFBDQ19TQ0FMQVJfTVVMVElQTFlfUDI1Ngotci0tci0tci0tIDEgcm9v
dCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19TQ0FMQVJfTVVMVElQTFlfUDM4NAotci0t
ci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19TQ0FMQVJfTVVMVElQ
TFlfUDUyMQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDQ19T
Q0FMQVJfTVVMVElQTFlfWDI1NTE5Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4g
MTUgMTA6MzMgUENDX1NDQUxBUl9NVUxUSVBMWV9YNDQ4Ci1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBKdW4gMTUgMTA6MzMgUENLTU9fRU5DUllQVF9BRVNfMTI4X0tFWQotci0tci0t
ci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1IDEwOjMzIFBDS01PX0VOQ1JZUFRfQUVTXzE5
Ml9LRVkKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBQQ0tNT19F
TkNSWVBUX0FFU18yNTZfS0VZCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTUg
MTA6MzMgUENLTU9fRU5DUllQVF9ERUFfS0VZCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5
NiBKdW4gMTUgMTA6MzMgUENLTU9fRU5DUllQVF9FQ0NfRUQyNTUxOV9LRVkKLXItLXItLXIt
LSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBQQ0tNT19FTkNSWVBUX0VDQ19FRDQ0
OF9LRVkKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBQQ0tNT19F
TkNSWVBUX0VDQ19QMjU2X0tFWQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE1
IDEwOjMzIFBDS01PX0VOQ1JZUFRfRUNDX1AzODRfS0VZCi1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBKdW4gMTUgMTA6MzMgUENLTU9fRU5DUllQVF9FQ0NfUDUyMV9LRVkKLXItLXIt
LXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDozMyBQQ0tNT19FTkNSWVBUX1RERUFf
MTI4X0tFWQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDE1OjQzIFBDS01P
X0VOQ1JZUFRfVERFQV8xOTJfS0VZCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4g
MTUgMTA6MzMgUFJOT19TSEFfNTEyX0RSTkcKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2
IEp1biAxNSAxMDozMyBQUk5PX1RSTkcKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1
biAxNSAxMDozMyBQUk5PX1RSTkdfUVVFUllfUkFXX1RPX0NPTkRJVElPTkVEX1JBVElPCgov
c3lzL2RldmljZXMvcGFpX2NyeXB0by9mb3JtYXQ6CnRvdGFsIDAKLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBldmVudAoKL3N5cy9kZXZpY2VzL3BhaV9leHQ6
CnRvdGFsIDAKZHJ3eHIteHIteCAyIHJvb3Qgcm9vdCAgICAwIEp1biAxNCAxMzowMyBldmVu
dHMKZHJ3eHIteHIteCAyIHJvb3Qgcm9vdCAgICAwIEp1biAxNCAxMzowMyBmb3JtYXQKLXJ3
LXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNSAxMDo0OSBwZXJmX2V2ZW50X211eF9p
bnRlcnZhbF9tcwpscnd4cnd4cnd4IDEgcm9vdCByb290ICAgIDAgSnVuIDE1IDEwOjQ5IHN1
YnN5c3RlbSAtPiAuLi8uLi9idXMvZXZlbnRfc291cmNlCi1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBKdW4gMTQgMTM6MDMgdHlwZQotcnctci0tci0tIDEgcm9vdCByb290IDQwOTYg
SnVuIDE1IDEwOjQ5IHVldmVudAoKL3N5cy9kZXZpY2VzL3BhaV9leHQvZXZlbnRzOgp0b3Rh
bCAwCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV8xTUZS
QU1FCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV8yR0ZS
QU1FCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV9BQ0NF
U1NFWENFUFQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBB
X0FERAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIE5OUEFfQUxM
Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV9BVkdQT09M
MkQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX0JBVENI
Tk9STQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIE5OUEFfQ09O
Vk9MVVRJT04KLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBB
X0RJVgotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIE5OUEFfRVhQ
Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV9HUlVBQ1QK
LXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX0lCTV9SRVNF
UlZFRF85Ci1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV9M
QVJHRURJTQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIE5OUEFf
TE9HCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV9MU1RN
QUNUCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5QQV9NQVRN
VUxfT1AKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX01B
VE1VTF9PUF9CQ0FTVDIzCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6
MDMgTk5QQV9NQVgKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBO
TlBBX01BWFBPT0wyRAotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAz
IE5OUEFfTUlOCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5Q
QV9NVUwKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX1JF
TFUKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX1NJR01P
SUQKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX1NNQUxM
QkFUQ0gKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX1NN
QUxMVEVOU09SCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5Q
QV9TT0ZUTUFYCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBKdW4gMTQgMTM6MDMgTk5Q
QV9TVUIKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0MDk2IEp1biAxNCAxMzowMyBOTlBBX1RB
TkgKCi9zeXMvZGV2aWNlcy9wYWlfZXh0L2Zvcm1hdDoKdG90YWwgMAotci0tci0tci0tIDEg
cm9vdCByb290IDQwOTYgSnVuIDE0IDEzOjAzIGV2ZW50Cg==

--------------Nzv7RGMHKw9UKocnxONFhlu0--

