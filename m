Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25211EDEC49
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Sep 2023 12:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbjIMMQl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMQk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 08:16:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AF19A8
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 05:16:37 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DC8c1u000645;
        Wed, 13 Sep 2023 12:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UWuwnJ4WnTLqnnFOt/ZSTVZdnAPYxM2aE4NwpSvCUL8=;
 b=iPaDIiPgviaVW6upZiFoSkUDUmu57fgd1FFZyXmD3Tlru8itkdGMZt8UhJeKcY7HSH0V
 kqVMsKTV8zNbLc3Pi9G+cJiJ7vxHaegaFrJWZi/S73hiH2LheR2rDbRMoeWI4LmQqJi/
 S/h1OyVRQQOaxSr35MNWNboaafgr41C/nARTK/mzapLDRy4k6cgeW85XKXsqavNbofJL
 FgdokbyiEKHUSTvZxOA957zpgtPK/QtLd+THQ64VWIp5PiPirZQ16RmZN3HhPQb7ti/H
 LTd8oj6yAwB9GzHz9PAzfHMC8x9lKp4FRiaqj0Safnn8cYgJKGkuCOJ4OYLi0e4hwb7T Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3cebs0yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 12:16:32 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DC8pgJ001988;
        Wed, 13 Sep 2023 12:16:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3cebs0y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 12:16:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38DAvUNd002932;
        Wed, 13 Sep 2023 12:16:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hm2t0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 12:16:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38DCGRlk21824076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 12:16:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F94720043;
        Wed, 13 Sep 2023 12:16:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 047B020040;
        Wed, 13 Sep 2023 12:16:27 +0000 (GMT)
Received: from [9.152.212.95] (unknown [9.152.212.95])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Sep 2023 12:16:26 +0000 (GMT)
Message-ID: <589cb8dc-fc2b-9461-be23-f2e57f1ee46f@linux.ibm.com>
Date:   Wed, 13 Sep 2023 14:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: perf record dumps core all the time on s390 (6.6.0rc1) part2
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     ian Rogers <irogers@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <07625379-ca42-f899-40fc-58a8fc32cb5e@linux.ibm.com>
Organization: IBM
In-Reply-To: <07625379-ca42-f899-40fc-58a8fc32cb5e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C1hU5DYwrnP1_0F1D54rawABf-KaeLNJ
X-Proofpoint-ORIG-GUID: HD3MLkTN-7w2TOk0qKoOGJG-qCLDzOZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130097
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 9/13/23 11:17, Thomas Richter wrote:
> Using Linux kernel version 6.6.0rc1, the command
> 
>   # perf record -e cycles
> 
> dumps core immediately on s390 running on a z/VM virtual machine.
> It works on an s390 LPAR (same kernel).
> 
> This issue showed up during my vacation on 25-Aug-2023 in linux-next
> and since Monday 11-Sep-2023 it shows up in linux 6.6.0rc1.
> 
> The event cycles is treated as a software event and it fails in:
> 
>  (gdb) n
>  1014           pmu->events_table = perf_pmu__find_events_table(pmu);
>  (gdb) p *pmu
>   $4 = {name = 0x152a150 "software", alias_name = 0x0, id = 0x0, type = 1,
>           selectable = false, is_core = false,
>   is_uncore = false, auxtrace = false, formats_checked = false,
>   config_masks_present = false,
>   config_masks_computed = false, max_precise = -1, default_config = 0x0, cpus = 0x0,
>   format = {next = 0x152a0c8, prev = 0x152a0c8},
>   aliases = {next = 0x152a0d8, prev = 0x152a0d8}, events_table = 0x0, sysfs_aliases = 0,
>   loaded_json_aliases = 0, sysfs_aliases_loaded = false,
>   cpu_aliases_added = false, caps_initialized = false,
>   nr_caps = 0, caps = {next = 0x152a100, prev = 0x152a100},
>   list = {next = 0x0, prev = 0x0}, config_masks = {0, 0, 0, 0},
>   missing_features = {exclude_guest = false}}
>  (gdb) n
> 
>  Program received signal SIGSEGV, Segmentation fault.
>  0x0000000001344558 in perf_pmu__find_events_table (pmu=0x152a090) at pmu-events/pmu-events.c:1970
>  1970           for (i = 0; i < table->num_pmus; i++) {
>  (gdb) p table
>  $5 = (const struct pmu_events_table *) 0x0
>  (gdb)
> 
> (gdb) where
>  #0  perf_pmu__find_events_table (pmu=pmu@entry=0x2aa003d48d0)
>         at pmu-events/pmu-events.c:1970
>  #1  0x000002aa00180cee in perf_pmu__lookup (pmus=0x2aa0039baf8 <other_pmus>,
>         dirfd=dirfd@entry=3, lookup_name=lookup_name@entry=0x2aa003dca83 "software")
>         at util/pmu.c:1014
>  #2  0x000002aa0018151e in perf_pmu__find2 (name=0x2aa003dca83 "software",
>         dirfd=<optimized out>) at util/pmus.c:150
>  #3  pmu_read_sysfs (core_only=false) at util/pmus.c:198
>  #4  0x000002aa00181e04 in pmu_read_sysfs (core_only=false) at util/pmus.c:179
>  #5  perf_pmus__find_by_type (type=0) at util/pmus.c:238
>  #6  perf_pmus__find_by_type (type=type@entry=0) at util/pmus.c:231
>  #7  0x000002aa0012ee4a in parse_events_add_numeric (parse_state=0x3ffffff7718,
>         parse_state@entry=0x100000000,
>         list=0x2aa003d47b0, list@entry=<error reading variable:
>                 value has been optimized out>, type=type@entry=0,
>     config=<optimized out>, head_config=<optimized out>, head_config@entry=0x0, wildcard=true)
>     at util/parse-events.c:1347
>  #8  0x000002aa0017b7c2 in parse_events_parse (_parse_state=0x100000000,
>         _parse_state@entry=0x3ffffff7718, scanner=<optimized out>) at util/parse-events.y:418
>  #9  0x000002aa0012ca6e in parse_events__scanner (parse_state=0x3ffffff7718, input=0x0,
>         str=0x3ffffffa58a "cycles") at util/parse-events.c:1822
>  #10 __parse_events (evlist=0x3ffffff7830, str=str@entry=0x3ffffffa58a "cycles",
>         pmu_filter=<optimized out>, err=err@entry=0x3ffffff7830, fake_pmu=fake_pmu@entry=0x0,
>         warn_if_reordered=true) at util/parse-events.c:2094
>  ....rest omitted.....
> 
> 
> Variable table is not assigned any value and remains a NULL pointer.
> This happens because on a z/VM vertual machines (on s390) there
> is not CPU measurement facility and the directories
>    /sys/devices/cpum_cf
>    /sys/devices/cpum_sf
> do not exist. Therefore the event cycles as treated as software event
> and this default does work with the latest pmu-events rework.
> 
> Note: This core-dump will also happen on an LPAR when the CPU Measurement
> facility is not configured. Then above PMU directory do not exist on
> an LPAR.
> 
> The other PMU for s390 are
>    /sys/devices/pai_crypto
>    /sys/devices/pai_ext
> do exist on z/VM and LPAR on s390 (when configured).
> 
> Do you have an idea how to fix this?
> Since the pmu-event subtree was completely redesigned, I would
> like some guidance on how to proceed.
> 
> Thanks a lot for your help.
> 


When I use software events like cpu-clock or cs, the commands

 # ./perf stat -e cs -- true
 Segmentation fault (core dumped)
 # ./perf stat -e cpu-clock-- true
 Segmentation fault (core dumped)
 #

also dump core. This should not happen as these events are defined
even when no hardware PMU is available.
Debugging this reveals this call chain:

  perf_pmus__find_by_type(type=1)
  +--> pmu_read_sysfs(core_only=false)
       +--> perf_pmu__find2(dirfd=3, name=0x152a113 "software")
            +--> perf_pmu__lookup(pmus=0x14f0568 <other_pmus>, dirfd=3,
                                  lookup_name=0x152a113 "software")
                 +--> perf_pmu__find_events_table (pmu=0x1532130)

Now the pmu is "software" and it tries to find a proper table
generated by the pmu-event generation process for s390:

 # cd pmu-events/
 # ./jevents.py  s390 all /root/linux/tools/perf/pmu-events/arch |\
        grep -E '^const struct pmu_table_entry'
 const struct pmu_table_entry pmu_events__cf_z10[] = {
 const struct pmu_table_entry pmu_events__cf_z13[] = {
 const struct pmu_table_entry pmu_metrics__cf_z13[] = {
 const struct pmu_table_entry pmu_events__cf_z14[] = {
 const struct pmu_table_entry pmu_metrics__cf_z14[] = {
 const struct pmu_table_entry pmu_events__cf_z15[] = {
 const struct pmu_table_entry pmu_metrics__cf_z15[] = {
 const struct pmu_table_entry pmu_events__cf_z16[] = {
 const struct pmu_table_entry pmu_metrics__cf_z16[] = {
 const struct pmu_table_entry pmu_events__cf_z196[] = {
 const struct pmu_table_entry pmu_events__cf_zec12[] = {
 const struct pmu_table_entry pmu_metrics__cf_zec12[] = {
 const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
 const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
 const struct pmu_table_entry pmu_events__test_soc_sys[] = {
 #

However event "software" is not listed, as can be seen in the
generated const struct pmu_events_map pmu_events_map[].

So in function perf_pmu__find_events_table(), there variable
table is initialized to NULL, but never set to a proper
value. The function scans all generated &pmu_events_map[]
tables, but no table matches, because the tables are
s390 CPU Measurement unit specific:


        i = 0;
        for (;;) {
                const struct pmu_events_map *map = &pmu_events_map[i++];
                if (!map->arch)
                        break;

        --> the maps are there because the build generated them

                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
                        table = &map->event_table;
                        break;
                }
        --> Since no matching CPU string the table var remains 0x0
        }
        free(cpuid);
        if (!pmu)
                return table;

        --> The pmu is "software" so it exists and no return

        for (i = 0; i < table->num_pmus; i++) {
                const struct pmu_table_entry *table_pmu = &table->pmus[i];
        --> and here perf dies because table is 0x0

To me something is missing, either generate a pmu_events_map[] for software
events or return and handle these events somewhere else.

The events cpu-clock or cs are completely software driven and do not
need any CPU measurement hardware at all.
Something is very strange and I am confused.
Does this work on other platforms?

Thanks 

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

