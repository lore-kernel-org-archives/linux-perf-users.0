Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB7CA5512
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Sep 2023 09:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjIMJRt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIMJRs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 05:17:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C0173E
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 02:17:44 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D97O42021490;
        Wed, 13 Sep 2023 09:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=8Z+vW5OVL1FIHuu4leXhXLHkZUKoT1olvafoHOVVHFE=;
 b=JssUzd96iWhEcwaHzt8cgCyrtoSUXqJcK+AVSWfqrm7UTxwEBgcLExIsWKJoji7R5S/C
 oN1ExrwQQ2ySq5wgeT6Dr4zU9rTKeG0ZmaErD65O20janBfud6UmeRaQ8oPLXiTXxChE
 dL5lFytm/cICNbiG5Xn3BCilGhB2ogNbbk+v80tAq1oct5xZ9ynBKPlVdEZVsA3kToGn
 Zm9p0TZ6NVA8JuiFKVhG1C45Z/T+yHZIGnngyzRsXCED97R0WfdVFdOpiGI3083PpvO2
 n4naphE3FXff1kZQq9KCVS9FT8WZ5s0UPM+QjT9Ix86SbfXN95ZzPWyliPErltW06PkY rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t39t58x7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:17:34 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38D97jRX024800;
        Wed, 13 Sep 2023 09:17:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t39t58x77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:17:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38D8pTmx002401;
        Wed, 13 Sep 2023 09:17:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k9kpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:17:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38D9HUeV19727016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 09:17:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6802420043;
        Wed, 13 Sep 2023 09:17:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4474F20040;
        Wed, 13 Sep 2023 09:17:30 +0000 (GMT)
Received: from [9.152.212.95] (unknown [9.152.212.95])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Sep 2023 09:17:30 +0000 (GMT)
Message-ID: <07625379-ca42-f899-40fc-58a8fc32cb5e@linux.ibm.com>
Date:   Wed, 13 Sep 2023 11:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     ian Rogers <irogers@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf record dumps core all the time on s390 (6.6.0rc1)
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ycUHfNklQ_P3xkPj5OPoj2AKR4yWVq9i
X-Proofpoint-ORIG-GUID: QwoYwepb8-1Xe1a65gfMaQJvZxaHrfHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130071
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Using Linux kernel version 6.6.0rc1, the command

  # perf record -e cycles

dumps core immediately on s390 running on a z/VM virtual machine.
It works on an s390 LPAR (same kernel).

This issue showed up during my vacation on 25-Aug-2023 in linux-next
and since Monday 11-Sep-2023 it shows up in linux 6.6.0rc1.

The event cycles is treated as a software event and it fails in:

 (gdb) n
 1014           pmu->events_table = perf_pmu__find_events_table(pmu);
 (gdb) p *pmu
  $4 = {name = 0x152a150 "software", alias_name = 0x0, id = 0x0, type = 1,
          selectable = false, is_core = false,
  is_uncore = false, auxtrace = false, formats_checked = false,
  config_masks_present = false,
  config_masks_computed = false, max_precise = -1, default_config = 0x0, cpus = 0x0,
  format = {next = 0x152a0c8, prev = 0x152a0c8},
  aliases = {next = 0x152a0d8, prev = 0x152a0d8}, events_table = 0x0, sysfs_aliases = 0,
  loaded_json_aliases = 0, sysfs_aliases_loaded = false,
  cpu_aliases_added = false, caps_initialized = false,
  nr_caps = 0, caps = {next = 0x152a100, prev = 0x152a100},
  list = {next = 0x0, prev = 0x0}, config_masks = {0, 0, 0, 0},
  missing_features = {exclude_guest = false}}
 (gdb) n

 Program received signal SIGSEGV, Segmentation fault.
 0x0000000001344558 in perf_pmu__find_events_table (pmu=0x152a090) at pmu-events/pmu-events.c:1970
 1970           for (i = 0; i < table->num_pmus; i++) {
 (gdb) p table
 $5 = (const struct pmu_events_table *) 0x0
 (gdb)

(gdb) where
 #0  perf_pmu__find_events_table (pmu=pmu@entry=0x2aa003d48d0)
        at pmu-events/pmu-events.c:1970
 #1  0x000002aa00180cee in perf_pmu__lookup (pmus=0x2aa0039baf8 <other_pmus>,
        dirfd=dirfd@entry=3, lookup_name=lookup_name@entry=0x2aa003dca83 "software")
        at util/pmu.c:1014
 #2  0x000002aa0018151e in perf_pmu__find2 (name=0x2aa003dca83 "software",
        dirfd=<optimized out>) at util/pmus.c:150
 #3  pmu_read_sysfs (core_only=false) at util/pmus.c:198
 #4  0x000002aa00181e04 in pmu_read_sysfs (core_only=false) at util/pmus.c:179
 #5  perf_pmus__find_by_type (type=0) at util/pmus.c:238
 #6  perf_pmus__find_by_type (type=type@entry=0) at util/pmus.c:231
 #7  0x000002aa0012ee4a in parse_events_add_numeric (parse_state=0x3ffffff7718,
        parse_state@entry=0x100000000,
        list=0x2aa003d47b0, list@entry=<error reading variable:
                value has been optimized out>, type=type@entry=0,
    config=<optimized out>, head_config=<optimized out>, head_config@entry=0x0, wildcard=true)
    at util/parse-events.c:1347
 #8  0x000002aa0017b7c2 in parse_events_parse (_parse_state=0x100000000,
        _parse_state@entry=0x3ffffff7718, scanner=<optimized out>) at util/parse-events.y:418
 #9  0x000002aa0012ca6e in parse_events__scanner (parse_state=0x3ffffff7718, input=0x0,
        str=0x3ffffffa58a "cycles") at util/parse-events.c:1822
 #10 __parse_events (evlist=0x3ffffff7830, str=str@entry=0x3ffffffa58a "cycles",
        pmu_filter=<optimized out>, err=err@entry=0x3ffffff7830, fake_pmu=fake_pmu@entry=0x0,
        warn_if_reordered=true) at util/parse-events.c:2094
 ....rest omitted.....


Variable table is not assigned any value and remains a NULL pointer.
This happens because on a z/VM vertual machines (on s390) there
is not CPU measurement facility and the directories
   /sys/devices/cpum_cf
   /sys/devices/cpum_sf
do not exist. Therefore the event cycles as treated as software event
and this default does work with the latest pmu-events rework.

Note: This core-dump will also happen on an LPAR when the CPU Measurement
facility is not configured. Then above PMU directory do not exist on
an LPAR.

The other PMU for s390 are
   /sys/devices/pai_crypto
   /sys/devices/pai_ext
do exist on z/VM and LPAR on s390 (when configured).

Do you have an idea how to fix this?
Since the pmu-event subtree was completely redesigned, I would
like some guidance on how to proceed.

Thanks a lot for your help.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
