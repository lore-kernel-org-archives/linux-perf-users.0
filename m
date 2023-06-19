Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9FDEB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jun 2023 10:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFSKEh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jun 2023 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFSKEd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jun 2023 06:04:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5AEE42
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jun 2023 03:04:14 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9eeIQ012705;
        Mon, 19 Jun 2023 10:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nLGgKrW1UCIUVTFB+Wc/L9vrHcHk78D1LGYYUjDqe7s=;
 b=P82LQiZ7FxEoupEUIO1Q/jUlhMA2PXeiLWoBWhLMLcuysmg6+qVb53h6nfyXY14vn6rk
 MOZEq7F1f5avAP640xoPmzXb7mUxNxeG6Uwixw8dthE60IexeEGrb7TayLfVsrhgy7L4
 ebvHCl1CEq/u6q4+ap1Xq0S+0pdBdGWpB80cDb+Ofha5iDtVawuc9t26ODkEl8wb2/n3
 53CzJNBqAoNL3JeHolbBH7Uvh09VPtVn2HfVSch3UwTaC6F7iEvRKG/ZbAhC1GRVRPsJ
 TBrRKJuR86Q7xgnAOd0kIE5IYYOt2PQj/dI+GyXjSHpAtO4kkbKImSl1GCsOs+LoiS1M 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ramb611qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 10:04:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35J9NX87032484;
        Mon, 19 Jun 2023 10:04:06 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ramb611pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 10:04:06 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J66JPc010170;
        Mon, 19 Jun 2023 10:04:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r94f58ygx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 10:04:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35JA41QK41943638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 10:04:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5D2920040;
        Mon, 19 Jun 2023 10:04:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26B0B2004D;
        Mon, 19 Jun 2023 10:04:01 +0000 (GMT)
Received: from [9.171.51.54] (unknown [9.171.51.54])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 10:04:01 +0000 (GMT)
Message-ID: <cacce572-cab1-7938-a3e5-304b397861c9@linux.ibm.com>
Date:   Mon, 19 Jun 2023 12:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Hybrid PMU issues on aarch64. was: Re: perf test failures in
 linux-next on s390
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
 <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
 <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com>
 <ZIshkbmQR7oOFiHu@kernel.org>
 <CAP-5=fVYy6jMd9Nw7iqqsm_G-qW__Lo8kFeCocJ0W2no4XTbpg@mail.gmail.com>
 <ZIxza13x+AwApbQb@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZIxza13x+AwApbQb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -eUUNBhSPoL98PxBzkLx91nA_3xuCdET
X-Proofpoint-GUID: aaUbBZaqYppaqlRO132QCS9XuYBHEUNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190091
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 6/16/23 16:36, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 16, 2023 at 07:23:30AM -0700, Ian Rogers escreveu:
>> On Thu, Jun 15, 2023 at 7:35 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>> Ccing the ARM people too:
>>> Em Thu, Jun 15, 2023 at 11:39:16AM +0200, Thomas Richter escreveu:
>>>> On 6/14/23 16:57, Ian Rogers wrote:
>>>>> On Wed, Jun 14, 2023 at 1:32 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>>> bool is_pmu_core(const char *name)
>>>>> {
>>>>> return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
>>>>> }
> 
>>>> Maybe we should scan the directory
> 
>>>> [linux-next]# ll /sys/bus/event_source/devices
>>>> total 0
>>>> lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf -> ../../../devices/cpum_cf
>>>> lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf_diag -> ../../../devices/cpum_cf_diag
>>>> lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_sf -> ../../../devices/cpum_sf
>>>> lrwxrwxrwx 1 root root 0 Jun  2 15:11 kprobe -> ../../../devices/kprobe
>>>> lrwxrwxrwx 1 root root 0 Jun  2 15:11 software -> ../../../devices/software
>>>> lrwxrwxrwx 1 root root 0 Jun  2 15:11 tracepoint -> ../../../devices/tracepoint
>>>> lrwxrwxrwx 1 root root 0 Jun  2 15:11 uprobe -> ../../../devices/uprobe
>>>> [linux-next]#
> 
>>>> This directory lists the PMUs available on s390, maybe this is true for
>>>> other platform...
> 
>>> I noticed this on an arm64 board:
> 
>>> acme@roc-rk3399-pc:~/git/perf-tools-next$ perf stat -e cycles:u,instructions:u ls
>>> COPYING  CREDITS  Documentation  Kbuild  Kconfig  LICENSES  MAINTAINERS  Makefile  README  arch  block  certs  crypto  drivers  fs  include  init  io_uring  ipc  kernel  lib  mm  net  perf.data  rust  samples  scripts  security  sound  tools  usr  virt
> 
>>>  Performance counter stats for 'ls':
> 
>>>    <not supported>      armv8_cortex_a72/cycles:u/
>>>    <not supported>      armv8_cortex_a53/cycles:u/
>>>    <not supported>      armv8_cortex_a72/instructions:u/
>>>    <not supported>      armv8_cortex_a53/instructions:u/
> 
>> I tested on a raspberry pi and perf-tools-next is working there. I
>> suspect the issue here is the heterogeneous PMU. The cycles event is
>> converted into a perf_event_attr with type 0 and config 0. When there
>> are heterogeneous PMUs then we try to use the extended type to say we
>> want armv8_cortex_a72 and armv8_cortex_a53 cycles events. Let's say
>> the type number of armv8_cortex_a72 and armv8_cortex_a53 PMUs are 9
>> and 10 respectively. With heterogeneous encodings the type in the
> 
> The numbers are 8 and 7, PERF_TYPE_HW (thus zero, thus not printed):
> 
> root@roc-rk3399-pc:~# perf stat -vv -e cycles sleep 1
> Using CPUID 0x00000000410fd080
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   size                             136
>   config                           0x800000000
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 13885  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> Warning:

On s390 with above patch applied and latest git pull of linux-next this morning
I get this result:

# ./perf test -F 6
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : Ok
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : Ok
  6.6: Parsing of terms (event modifiers)                            : Ok
#

However the config member in perf_event_attr::config member does not change
as can be seen in this trace:
# ./perf stat -e cycles -vv true
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  size                             136
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 6510  cpu -1  group_fd -1  flags 0x8 = 3
cycles: -1: 2646065 510719 510719
cycles: 2646065 510719 510719

 Performance counter stats for 'true':

         2,646,065      cycles                                                                

       0.002084266 seconds time elapsed

       0.000052000 seconds user
       0.002107000 seconds sys


#

Thanks for fixing this...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

