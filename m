Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A63C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 May 2021 06:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26218610D2
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 May 2021 06:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhEEGtd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 May 2021 02:49:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28914 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhEEGtc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 May 2021 02:49:32 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1456WhR3017367;
        Wed, 5 May 2021 02:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rt3W2HKMBPDQcxJ3R9r2MqsbsKBgJoy7YfOrjxwAgz0=;
 b=dOeJ4Cg6fgLXk4WH99iLA9tvMvEToADiS5Xa9kwhCxd40WMlGdTG1XFwJ57rWGCbQNNg
 JDCNvrvNbrV8kGmZfLYE5ok0c8MZd4UIah17SWKZrtfLCNq6hg0Y2ULpOqzxyUNk3w4d
 JtnNGryxRYFRsarj/tZgtM98Ps/YBS/CjZ+9Z2cdZF7lYJf/1zL6xHsXLU7VHzR/yq1I
 PSfCnMC18plA9tV1cGYKjia3sJ1kdLgsDDWQuxda/u9IVa5nIEL9rjvhLvDAtAgreCZb
 5ITkQ4iM6x7qePEjOdg9dgNnzdPqqQuEihXTDCXAIwuxuZZ94ezS/Dp7oWWJBZiz8PWy UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bn6u9kd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 02:48:34 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1456XCqC018232;
        Wed, 5 May 2021 02:48:34 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bn6u9kcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 02:48:34 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1456mWjM012051;
        Wed, 5 May 2021 06:48:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 38beea82n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 06:48:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1456mTKs28180942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 06:48:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DFAEA4055;
        Wed,  5 May 2021 06:48:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7BA1A4057;
        Wed,  5 May 2021 06:48:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 May 2021 06:48:28 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, eranian@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Test perf_event_attr fails on s390 when built with make LIBPFM4=1
Date:   Wed,  5 May 2021 08:48:18 +0200
Message-Id: <20210505064818.1169840-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xPUtMkLJXm8N4x4QIYcaxCMbDnRW2Djs
X-Proofpoint-GUID: 8ndenka8ClbkcKIWml9cs12FNEmc2q78
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_02:2021-05-04,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050046
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Using make LIBPFM4=1 builds the perf tool with support for libpfm
event notation. The command line flag --pfm-events is valid:
 # ./perf record --pfm-events cycles -- true
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.001 MB perf.data (2 samples) ]
 #

However the command 'perf test -Fv 17' fails on s390 with LIBPFM4=1:
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
This is not the case on s390 where the value of exclude_hv is one.

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

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
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

