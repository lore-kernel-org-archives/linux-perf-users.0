Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA50AC636CC
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Jan 2023 13:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjAaNus (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjAaNur (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Jan 2023 08:50:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCCE4B8A1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Jan 2023 05:50:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VCxqVT018708;
        Tue, 31 Jan 2023 13:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=d10M5Yzul/jOpxw2u+Q/EF8lv+QxeQFXJOgJbU++I4Q=;
 b=DD4DqQPuXT4aT0rSdexfX9KSWuSFfug3O1dkFKNW45/USqo6+jVftLoeD3zQj1AP23ro
 /VR5h7l3es/Ca/X5hFAGkl6cSR7TzopF2s4Cm1uuPkbG1kYzyPK9/zT54esShqkwX1tZ
 CZ5V/KMTQ+q+KQD95tFWBLoh9GC8lCYngb53ix+BwQYyGJuXJlf+YEhCzxjCfVHQlMw7
 WTjmdfW88EPmx26E07VRSnGpQS4fSP8CX8HVJ2Rti3HKqcUFr5GuYp6T+RApcoFtXk/S
 yPs32au6ovP6qRhsKJMKK+VQpc1XnLzRfRp4XNKKwWIe58UlP2ZAWf7Bzy9xZZwk9HnI 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3g019ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:50:11 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VD067K019397;
        Tue, 31 Jan 2023 13:50:10 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3g019vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:50:10 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UKWnZG013274;
        Tue, 31 Jan 2023 13:50:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtybj69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:50:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VDo5h129163848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 13:50:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2039320049;
        Tue, 31 Jan 2023 13:50:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87A522004B;
        Tue, 31 Jan 2023 13:50:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.7.122])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 13:50:02 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     ak@linux.intel.com, namhyung@kernel.org, irogers@google.com,
        james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: [PATCH] tests/bpf: Fix the bpf test to check for libtraceevent support
Date:   Tue, 31 Jan 2023 19:20:01 +0530
Message-Id: <20230131135001.54578-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8UIBKq2trIMt9VUPx_YlwzxoDOntDOi2
X-Proofpoint-ORIG-GUID: UjGT5MifXyimIjAm7O184LP46MrkuZWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310121
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

"bpf" tests fails in environment with missing libtraceevent
support as below:

 # ./perf test 36
 36: BPF filter                                                      :
 36.1: Basic BPF filtering                                           : FAILED!
 36.2: BPF pinning                                                   : FAILED!
 36.3: BPF prologue generation                                       : FAILED!

The environment has clang but missing the libtraceevent
devel. Hence perf is compiled without libtraceevent support.

Detailed logs:
	./perf test -v "Basic BPF filtering"

	Failed to add BPF event syscalls:sys_enter_epoll_pwait
	bpf: tracepoint call back failed, stop iterate
	Failed to add events selected by BPF

The bpf tests tris to add probe event which fails
at "parse_events_add_tracepoint" function due to missing
libtraceevent. Add check for "HAVE_LIBTRACEEVENT" in the
"tests/bpf.c" before proceeding with the test.

With the change,

	# ./perf test 36
 	36: BPF filter                                                      :
 	36.1: Basic BPF filtering                                           : Skip (not compiled in or missing libtraceevent support)
 	36.2: BPF pinning                                                   : Skip (not compiled in or missing libtraceevent support)
 	36.3: BPF prologue generation                                       : Skip (not compiled in or missing libtraceevent support)

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/bpf.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 17c023823713..4af39528f611 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -23,7 +23,7 @@
 #define NR_ITERS       111
 #define PERF_TEST_BPF_PATH "/sys/fs/bpf/perf_test"
 
-#ifdef HAVE_LIBBPF_SUPPORT
+#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
 
@@ -330,10 +330,10 @@ static int test__bpf(int i)
 static int test__basic_bpf_test(struct test_suite *test __maybe_unused,
 				int subtest __maybe_unused)
 {
-#ifdef HAVE_LIBBPF_SUPPORT
+#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 	return test__bpf(0);
 #else
-	pr_debug("Skip BPF test because BPF support is not compiled\n");
+	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
 	return TEST_SKIP;
 #endif
 }
@@ -341,10 +341,10 @@ static int test__basic_bpf_test(struct test_suite *test __maybe_unused,
 static int test__bpf_pinning(struct test_suite *test __maybe_unused,
 			     int subtest __maybe_unused)
 {
-#ifdef HAVE_LIBBPF_SUPPORT
+#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 	return test__bpf(1);
 #else
-	pr_debug("Skip BPF test because BPF support is not compiled\n");
+	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
 	return TEST_SKIP;
 #endif
 }
@@ -352,17 +352,17 @@ static int test__bpf_pinning(struct test_suite *test __maybe_unused,
 static int test__bpf_prologue_test(struct test_suite *test __maybe_unused,
 				   int subtest __maybe_unused)
 {
-#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_BPF_PROLOGUE)
+#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_BPF_PROLOGUE) && defined(HAVE_LIBTRACEEVENT)
 	return test__bpf(2);
 #else
-	pr_debug("Skip BPF test because BPF support is not compiled\n");
+	pr_debug("Skip BPF test because BPF or libtraceevent support is not compiled\n");
 	return TEST_SKIP;
 #endif
 }
 
 
 static struct test_case bpf_tests[] = {
-#ifdef HAVE_LIBBPF_SUPPORT
+#if defined(HAVE_LIBBPF_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 	TEST_CASE("Basic BPF filtering", basic_bpf_test),
 	TEST_CASE_REASON("BPF pinning", bpf_pinning,
 			"clang isn't installed or environment missing BPF support"),
@@ -373,9 +373,9 @@ static struct test_case bpf_tests[] = {
 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
 #endif
 #else
-	TEST_CASE_REASON("Basic BPF filtering", basic_bpf_test, "not compiled in"),
-	TEST_CASE_REASON("BPF pinning", bpf_pinning, "not compiled in"),
-	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
+	TEST_CASE_REASON("Basic BPF filtering", basic_bpf_test, "not compiled in or missing libtraceevent support"),
+	TEST_CASE_REASON("BPF pinning", bpf_pinning, "not compiled in or missing libtraceevent support"),
+	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in or missing libtraceevent support"),
 #endif
 	{ .name = NULL, }
 };
-- 
2.39.0

