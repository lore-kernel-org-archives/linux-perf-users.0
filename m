Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F76C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbjG1Oae (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjG1Oad (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 10:30:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FE3A97
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 07:30:32 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE4VQk012127
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 14:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=XxZ8ZUHouvHdTggPk4MrG6EvLffuzCjh93GVIGt8FEk=;
 b=NFBItQwPPnlyzAVRR1BUk3A3dRo0e5+JIbHA7MCE8LRAa3zs6FHuIJgsdyOPeNkixKMD
 gIWcWyCs8YJ6qSSS6GGdClaqszOqtOCf2b7oGy4rb7FWu2sqpXGAMztokonpvquGmJRK
 HP578mpkq8qXdR70W9gKY3qI/i4L+FIZDE53KP942ZQWQsk67TqVK/k6MizCB1w+hvCO
 cTnNkKP8s3vWZtZOq9I2IE5l1vLDgUhvgyytfilZKhG6ETFd0FDNcAWE33C/Xo+Nu0oB
 Jq+0QLE/z1DMLeRf73H9dAWgTolgwBwDxcEaKZy/q/ahr5sfWaf3EVJdJ4AwRwGlpGFA 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4d7gcshk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 14:30:30 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36SDwvdj029966
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 14:30:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4d7gcsh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 14:30:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE01xM014406;
        Fri, 28 Jul 2023 14:30:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stypw9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 14:30:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36SEUQTd41550326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 14:30:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF0092005A;
        Fri, 28 Jul 2023 14:30:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 802EA2004D;
        Fri, 28 Jul 2023 14:30:26 +0000 (GMT)
Received: from [9.179.4.63] (unknown [9.179.4.63])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jul 2023 14:30:26 +0000 (GMT)
Message-ID: <f0508123-780b-3370-e64a-c78a350d76fa@linux.ibm.com>
Date:   Fri, 28 Jul 2023 16:30:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test case 6 dumps core on s390 without PMU
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HGDOLvD1B8f0oTUYlsZMHZCzI8MNDQz_
X-Proofpoint-GUID: 4EaD86sWoHoY9N0qeS0JmKk1wMuDDqkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280130
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Using Linux 6.5.0rc3 perf test case 6 dumps core on an s390 without
configured PMU (this can happen depending on customer machine configuration).

In this configuration several perf test cases fail:
 # ./perf test 2>&1 | grep FAIL
  6.1: Test event parsing                                : FAILED!
 10.3: Parsing of PMU event table metrics                : FAILED!
 10.4: Parsing of PMU event table metrics with fake PMUs : FAILED!
 28: Use a dummy software event to keep tracking         : FAILED!
 35: Track with sched_switch                             : FAILED!
 66: Parse and process metrics                           : FAILED!
 #

Even worse the test case 6 dumps core:

 # ./perf test -F 6
  6: Parse event definition strings                      :
  6.1: Test event parsing                                :
 Segmentation fault (core dumped)
 #

The root cause for these failures and core dump is a missing
PMU, as can be seen by the debug output:
   ...
   Event test failure: test 57 'instructions:uep'
   running test 58 '{cycles,cache-misses,branch-misses}:e'
   No PMU found for 'cycles' <-- Here no PMU is found, because there is none!
   FAILED tests/parse-events.c:1516 wrong number of entries
   Event test failure: test 58 '{cycles,cache-misses,branch-misses}:e'
Here no PMU is found, because there is none!

   ....
   running test 59 'cycles/name=name/'
   No PMU found for 'name'
   Segmentation fault (core dumped)

Here the root cause in in function test__term_equal_term() variable
evsel->name is NULL:

 # gdb ./perf
....
Breakpoint 1, test__term_equal_term (evlist=0x1542c00) at\
                       tests/parse-events.c:1688
(gdb) p evsel->name
$3 = 0x3fff7fe3dc0 ""
(gdb) n
 691 TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
(gdb) n
1692 TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
(gdb) n
1693 TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
(gdb) n

Program received signal SIGSEGV, Segmentation fault.

I could fix this by checking for NULL pointer, but I have the
feeling that there is more to it. However I do not fully understand
the latest rework on the event handling.

The other test cases listed above fail due to the same root cause,
no PMU found.

Please advise. What should all these test return when a system does
not have any PMU defined at all?

Thanks a lot.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
