Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5955C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 May 2021 13:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2DE60FF3
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 May 2021 13:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbhETNzM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 May 2021 09:55:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243483AbhETNyH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 May 2021 09:54:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KDYe56094098;
        Thu, 20 May 2021 09:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6G4eJy9XX0mmudGqBVSBYCBB6dfYDPA9iezIfQ/ikNA=;
 b=qRHuS02k1iL5YxloX3yiVx7gUcm30Bbq82ed2ra9K3KtRbCFPmRPe3SQFNYU2KI7Jm8Q
 qcOWv36fVGu+umkuRjkPNPUw0x8OvMhUqCoAmmHF0e6YE1xr2a6eocduLXIOXqll5SfJ
 MDDRIyUIWn5sAy9k7JjY/vqKDirUhuiIpdwHk5EkJbiUich3kfQcrQykORNWfTSAzGxi
 TnrmgQOXAYMWywiL3jJoq9yON8/VWBK02yr+fgXjfeon+OqgHu37LYZWKWrxU8cuB05d
 wGITXfekSuwQN5W0A0cHGOZmCKot7EHPdcYRSu4qvXgaLL2LS7EwzFhz+exfxTxgxlT7 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38nqw7jj0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 09:52:44 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14KDYxgt095898;
        Thu, 20 May 2021 09:52:43 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38nqw7jhyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 09:52:43 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14KDqWDn003960;
        Thu, 20 May 2021 13:52:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 38m1gv0ujb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 13:52:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14KDqASE28705166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 13:52:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B3065204E;
        Thu, 20 May 2021 13:52:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3BE0C52050;
        Thu, 20 May 2021 13:52:38 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, sumanthk@linux.ibm.com,
        eranian@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH][Ping] perf test: Test 17 fails with make LIBPFM4=1 on s390 z/VM
Date:   Thu, 20 May 2021 15:52:26 +0200
Message-Id: <20210520135226.2335704-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JKa92EvHhQklILbU7tYTmLDXdtCZ3x7N
X-Proofpoint-GUID: 3EF88J0Du857wxvUOvZvHUunlMjsQuw7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_03:2021-05-20,2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200099
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

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
    matching [event-1-0-6]
    match: [event-1-0-6] matches ['event:base-record']
    matching [event-1-0-5]
    match: [event-1-0-5] matches ['event:base-record']
  matched
 #

Background:
Using libpfm library ends up in this function call sequence

pfm_get_perf_event_encoding()
+-- pfm_get_os_event_encoding()
    +-- pfmlib_perf_event_encode()

is called when no hardware specific PMU unit can be detected
as in the s390 z/VM virtual machine case. This uses the
"perf_events generic PMU" data structure which sets exclude_hv per default.
Using this PMU that test case always fails.

That is the reason why exclude_hv attribute setting varies.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/attr/test-record-pfm-period | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/attr/test-record-pfm-period b/tools/perf/tests/attr/test-record-pfm-period
index 368f5b814094..b962d6d11ee2 100644
--- a/tools/perf/tests/attr/test-record-pfm-period
+++ b/tools/perf/tests/attr/test-record-pfm-period
@@ -7,3 +7,4 @@ ret     = 1
 sample_period=77777
 sample_type=7
 freq=0
+exclude_hv=0|1
-- 
2.30.2

