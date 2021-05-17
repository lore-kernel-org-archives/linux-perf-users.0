Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B7C433ED
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99E661454
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 May 2021 14:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhEQOMm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 May 2021 10:12:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238523AbhEQOLD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 May 2021 10:11:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HE4BCL055678;
        Mon, 17 May 2021 10:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Q0TO+kcuIjMe7MQJjWxd00opYUXpbEKIDdLPIWA61EE=;
 b=fR+CdIhZTjfDOPqqpqM9jVfj7hk/PTic6+23oGbYH65Fk0mHmoN1izaCE/WLO+knV6zl
 ghe3sgUEZMmYAtJK/6UIXsRkaWn/YYuMrX3W9G1Cr2isWWVsB/aWQtPPvgvvraHQRrai
 jZNTdn808JEKGbeCgLmTUJh3GhlQ9jVHtQt9lJuGmvaVsCqv8QcF6BYTrwhEisayRaLC
 4R0XzMYNRBvDNXDZnD0+NB9nzAyWv7MhSgsGKLLkCawN8kFbTC80UyFzjnYwu37lL66H
 2BmsrG4Y62lhOzwSAIiQr4KCkfcfDofW8cEwKr75rJ+iwPBQh/9St2dpWKAlyzazMGKp ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ksefs9um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 10:09:45 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14HE4HEV056134;
        Mon, 17 May 2021 10:09:45 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ksefs9su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 10:09:45 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14HDw38e026118;
        Mon, 17 May 2021 14:09:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 38j5x8gfft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 14:09:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14HE9e4j35848492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 14:09:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 161835204E;
        Mon, 17 May 2021 14:09:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE9D952052;
        Mon, 17 May 2021 14:09:39 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, eranian@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Test libpfm4 support (63) reports error
Date:   Mon, 17 May 2021 16:09:31 +0200
Message-Id: <20210517140931.2559364-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: px00ve8kV28Y_SWxZdlxTC5a_hl8PJ__
X-Proofpoint-GUID: WTUrRuid7QW42ruRZYtS0fNkviNr83Lt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_05:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170100
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Compiling perf with make LIBPFM4=1 includes libpfm support and
enables test case 63 'Test libpfm4 support'. This test reports an error
on all platforms for subtest 63.2 'test groups of --pfm-events'.
The reported error message is 'nested event groups not supported'

 # ./perf test -F 63
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               :
 Error:
 failed to parse event stereolab : event not found
 Error:
 failed to parse event stereolab,instructions : event not found
 Error:
 failed to parse event instructions,stereolab : event not found
  Ok
 63.2: test groups of --pfm-events                                   :
 Error:
 nested event groups not supported    <------ Error message here
 Error:
 failed to parse event {stereolab} : event not found
 Error:
 failed to parse event {instructions,cycles},{instructions,stereolab} :\
	 event not found
 Ok
 #

This patch addresses the error message 'nested event groups not supported'.
The root cause is function parse_libpfm_events_option() which parses the
event string '{},{instructions}' and can not handle a leading empty
group notation '{},...'.

The code detects the first (empty) group indicator '{' but does not
terminate group processing on the following group closing character '}'.
So when the second group indicator '{' is detected, the code assumes
a nested group and returns an error.

With the error message fixed, also change the expected event number to
one for the test case to succeed.

While at it also fix a memory leak. In good case the function does not
free the duplicated string given as first parameter.

Output after:
 # ./perf test -F 63
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               :
 Error:
 failed to parse event stereolab : event not found
 Error:
 failed to parse event stereolab,instructions : event not found
 Error:
 failed to parse event instructions,stereolab : event not found
  Ok
 63.2: test groups of --pfm-events                                   :
 Error:
 failed to parse event {stereolab} : event not found
 Error:
 failed to parse event {instructions,cycles},{instructions,stereolab} : \
	 event not found
  Ok
 #
Error message 'nested event groups not supported' is gone.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/pfm.c |  4 ++--
 tools/perf/util/pfm.c  | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index 76a53126efdf..d4b0ef74defc 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -131,8 +131,8 @@ static int test__pfm_group(void)
 		},
 		{
 			.events = "{},{instructions}",
-			.nr_events = 0,
-			.nr_groups = 0,
+			.nr_events = 1,
+			.nr_groups = 1,
 		},
 		{
 			.events = "{instructions},{instructions}",
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index d735acb6c29c..6eef6dfeaa57 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -62,8 +62,16 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 		}
 
 		/* no event */
-		if (*q == '\0')
+		if (*q == '\0') {
+			if (*sep == '}') {
+				if (grp_evt < 0) {
+					ui__error("cannot close a non-existing event group\n");
+					goto error;
+				}
+				grp_evt--;
+			}
 			continue;
+		}
 
 		memset(&attr, 0, sizeof(attr));
 		event_attr_init(&attr);
@@ -107,6 +115,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 			grp_evt = -1;
 		}
 	}
+	free(p_orig);
 	return 0;
 error:
 	free(p_orig);
-- 
2.31.1

