Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48047C47087
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 09:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AF66113D
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 09:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhE1JMq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 May 2021 05:12:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229950AbhE1JMq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 May 2021 05:12:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14S93QYu104548;
        Fri, 28 May 2021 05:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tn2zEgwVzSteBJj+sZRcP8OL5JTaJ+MzcqK70H+dNVs=;
 b=UVIzg4MsCkmsrPqAdhEUWs5X/8C9nI+1mGa2HfMl+Zb7BWvD13GwQf/Rx756TdKvaiCa
 CxOgnvvB+Vz3iEUIGrJvf6mYzaGy8V3bP7QqfCQlOcdodt5WTWxhSxRqS+DFECQinP5H
 9NovM4XhAX58tXcWHwBcr2GrvMkUaPbr2WlqCCusslG0DQhaTalAbUPdA0NSqPxY6+nC
 D3yWHOivbF+OSGpy492L2sppPcK0aottrbVeloW9rJ4km/iXx/HYavv3FZk+pOut6pJR
 0lrQGox8QFEJ5g71t489/VDC68NWUD4/3olvYdzCiZL8sjfrsKP1og93wlCbnukSH80S 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38twh48ak4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 05:11:10 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14S94ID9108778;
        Fri, 28 May 2021 05:11:09 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38twh48aje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 05:11:09 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14S98L5U013200;
        Fri, 28 May 2021 09:11:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 38s1ukhngk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 09:11:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14S9B55A25035078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 09:11:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36E36AE056;
        Fri, 28 May 2021 09:11:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7CF5AE045;
        Fri, 28 May 2021 09:11:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 May 2021 09:11:04 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, acme@redhat.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH V2][Ping] perf test: Test 17 fails with make LIBPFM4=1 on s390 z/VM
Date:   Fri, 28 May 2021 11:10:50 +0200
Message-Id: <20210528091050.245838-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3KdXJix7-7tzRLR4Aian1nmwIuJ0bASC
X-Proofpoint-GUID: RGBhQ0F45C9cvUNWBOtzbx1XreMXWnkY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280059
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Version 2:
   As suggested by Ian Rogers make perf_event_attribute member
   exclude_hv more robust and accept value 0 or 1 to handle more
   test cases which might fail on s390 virtual machine z/VM.

This test case fails on s390 virtual machine z/VM which has no PMU support
when the perf tool is built with LIBPFM4=1.

Using make LIBPFM4=1 builds the perf tool with support for libpfm
event notation. The command line flag --pfm-events is valid:
 # ./perf record --pfm-events cycles -- true
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.001 MB perf.data (2 samples) ]
 #

However the command 'perf test -Fv 17' fails on s390 z/VM virtual machine
with LIBPFM4=1:
  # perf test -Fv 17
  17: Setup struct perf_event_attr                                    :
  --- start ---
  .....
  running './tests/attr/test-record-group2'
  unsupp  './tests/attr/test-record-group2'
  running './tests/attr/test-record-pfm-period'
  expected exclude_hv=0, got 1
 FAILED './tests/attr/test-record-pfm-period' - match failure
 ---- end ----
 Setup struct perf_event_attr: FAILED!

When --pfm-event system is not supported, the test returns unsupported
and continues. Here is an example using a virtual machine on x86 and
Fedora 34:
 [root@f33 perf]# perf test -Fv 17
 17: Setup struct perf_event_attr                                    :
 --- start ---
 .....
 running './tests/attr/test-record-group2'
 unsupp  './tests/attr/test-record-group2'
 running './tests/attr/test-record-pfm-period'
 unsupp  './tests/attr/test-record-pfm-period'
 ....

The issue is file ./tests/attr/test-record-pfm-period
which requires perf event attribute member exclude_hv to be zero.
This is not the case on s390 where the value of exclude_hv is one when
executing on a z/VM virtual machine without PMU hardware support.

Fix this by allowing value exlucde_hv to be zero or one.

Output before:
 # /usr/bin/python ./tests/attr.py -d ./tests/attr/ -t \
	test-record-pfm-period -p ./perf  -vvv 2>&1| fgrep match
    matching [event:base-record]
    match: [event:base-record] matches []
 FAILED './tests/attr//test-record-pfm-period' - match failure
 #

Output after:
 # /usr/bin/python ./tests/attr.py -d ./tests/attr/ -t \
	test-record-pfm-period -p ./perf  -vvv 2>&1| fgrep match
    matching [event:base-record]
    match: [event:base-record] matches ['event-1-0-6', 'event-1-0-5']
  matched

Background:
Using libpfm library ends up in this function call sequence

pfm_get_perf_event_encoding()
+-- pfm_get_os_event_encoding()
    +-- pfmlib_perf_event_encode()

is called when no hardware specific PMU unit can be detected
as in the s390 z/VM virtual machine case. This uses the
"perf_events generic PMU" data structure which sets exclude_hv
to 1 per default.  Using this PMU that test case always fails.

That is the reason why exclude_hv attribute setting varies.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/attr/base-record | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 4a7b8deef3fd..8c10955eff93 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -16,7 +16,7 @@ pinned=0
 exclusive=0
 exclude_user=0
 exclude_kernel=0|1
-exclude_hv=0
+exclude_hv=0|1
 exclude_idle=0
 mmap=1
 comm=1
-- 
2.31.1

