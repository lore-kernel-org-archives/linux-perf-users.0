Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F9EC7EE29
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 12:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjFMMzP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbjFMMzF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 08:55:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18310D9
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 05:55:02 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DCm1h2025237;
        Tue, 13 Jun 2023 12:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=rsPuJJYG9Be+v3MNrxRf5oon4U570jj76RnQ/+s6rYE=;
 b=Zio+rSPjxQd2glswJlXodTagaGKWd4rDK8GQkSVLkaSBrEyWoNE4FOZs7wGJek9yzh58
 m9B79oe+sO9/ZI8E5vPhpOUorlxA0n6VzuXcX5X257L6MfsolHsQy6FX0d0tqlkg1YEp
 cq2RgdaAu1M/JTYEZMAVV491PB3Z7qUpCm3fEuvallLuJKDCzXTC1E6xFHvBIv7AjJ1C
 Uh3ljgFrXgHxsuH+7C75WL8U1P+KQSLFe9eYcKv9W8dCC8NZdH9iRjHnwY1XLU2qWI+o
 9EQ898jQ7N40kx/PXsJ6UiMkhpx2B0H0gzUQzN3+LGTWBx8uDspUG5RlIVe/HWVRPgu4 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6rrx84tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 12:54:57 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35DCn4bs028478;
        Tue, 13 Jun 2023 12:54:56 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6rrx84t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 12:54:56 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D50Jei029825;
        Tue, 13 Jun 2023 12:54:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r4gedsksr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 12:54:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DCspb822545018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 12:54:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64E9520043;
        Tue, 13 Jun 2023 12:54:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4292E20040;
        Tue, 13 Jun 2023 12:54:51 +0000 (GMT)
Received: from [9.152.212.165] (unknown [9.152.212.165])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 12:54:51 +0000 (GMT)
Message-ID: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
Date:   Tue, 13 Jun 2023 14:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf test failures in linux-next on s390
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PEQljUgjj43kju_nG07H42ZkD2A9kOAF
X-Proofpoint-ORIG-GUID: XsHYyAdu7tzs3zVDy9ai3GuW--VWU4up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130110
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all,

I have run the perf test suite on the current 6.4rc6 kernel and see just one error:
# ./perf test 2>&1 | fgrep FAILED
fgrep: warning: fgrep is obsolescent; using grep -F
 42.3: BPF prologue generation                                       : FAILED!
# 

However when I download the linux-next tree and build kernel and perf
tool with the same kernel config file, I get a bunch of failing test cases,
many with perf tool dumping core:

# perf test 2>&1 | fgrep FAILED
fgrep: warning: fgrep is obsolescent; using grep -F
  6.1: Test event parsing                                            : FAILED!
 10.3: Parsing of PMU event table metrics                            : FAILED!
 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
 17: Setup struct perf_event_attr                                    : FAILED!
 24: Number of exit events of a simple workload                      : FAILED! core-dump
 28: Use a dummy software event to keep tracking                     : FAILED!
 35: Track with sched_switch                                         : FAILED!
 42.3: BPF prologue generation                                       : FAILED!
 66: Parse and process metrics                                       : FAILED!
 68: Event expansion for cgroups                                     : FAILED!
 69.2: Perf time to TSC                                              : FAILED! core-dump
 74: build id cache operations                                       : FAILED! core-dump
 81: kernel lock contention analysis test                            : FAILED!
 86: Zstd perf.data compression/decompression                        : FAILED! core-dump
 87: perf record tests                                               : FAILED! core-dump
 94: perf all metricgroups test                                      : FAILED!
 95: perf all metrics test                                           : FAILED!
106: Test java symbol                                                : FAILED! core-dump
#

I am afraid this will show up pretty soon in the linux tree.
I am going to look into each failure in the next few days.

What I already found out is that many test cases now fail due to the
event/PMU rework, here is one example:

# perf test -Fvvvv 95
95: perf all metrics test
--- start ---
Testing cpi
....
Metric 'transaction' not printed in:
Error:
The TX_NC_TABORT event is not supported.
---- end ----
perf all metrics test: FAILED!
# ls -l /sys/devices/cpum_cf/events/TX_NC_TABORT
-r--r--r--. 1 root root 4096 Jun 13 13:49 /sys/devices/cpum_cf/events/TX_NC_TABORT
# 

As can be seen, the event is definitely there and supported.
This same test case succeeds in the linux tree!

Hopefully I can sort out some of the failures before this code show up
in the linux tree.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
