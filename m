Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA5C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 12:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjAEMSU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 07:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjAEMSQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 07:18:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C2458FBB
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 04:18:15 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305Bi1ZR030935;
        Thu, 5 Jan 2023 12:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+ZiipjEgurw0phUcfj9PmZND23SMpzPzj0FOmyxbmDQ=;
 b=NLOg19IH7yjLaaLEW8hm+UkpUt/bl+8iNcTRcg02e4OfBtRPLHt2rADxGFRmSiZ16/GY
 KkQvt3hK+Lmc+TfXRnMd3Y/00ZPsweHBjrzfmMK2vAVkvenq7mgVAsplFp5ZA/JYGXKu
 OW2iJ7cAv/mLKHwkQIdYfDSajCqrgx4MPrUvI1VYwKpQ6WGa7lm59wM2J0RxGVhUC3+i
 6nIVT4pdNUOHys6IbGQ2y4k97ayliguoATsrmmPADIyemRQzLRN/EV51EE5BD6vGYHjE
 GXkJc0cpV06DBS787czCGT5jWBBYBYKmhCJZq2J0Qe0xXrKyuwaQcl0FW48VMTR/qjS1 tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwwx8rpue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 12:17:56 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 305Bl6fe006896;
        Thu, 5 Jan 2023 12:17:56 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwwx8rptv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 12:17:55 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3053qW48001912;
        Thu, 5 Jan 2023 12:17:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6er7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 12:17:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 305CHnQT30933346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jan 2023 12:17:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8851220049;
        Thu,  5 Jan 2023 12:17:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A52D920040;
        Thu,  5 Jan 2023 12:17:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.120.85])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jan 2023 12:17:46 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     ak@linux.intel.com, namhyung@kernel.org, irogers@google.com,
        james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: [PATCH 2/2] perf test bpf: Skip test if kernel-debuginfo is not present
Date:   Thu,  5 Jan 2023 17:47:42 +0530
Message-Id: <20230105121742.92249-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230105121742.92249-1-atrajeev@linux.vnet.ibm.com>
References: <20230105121742.92249-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w8DXrrs75cnw21zhSMlvaqu8NjJ3rhCG
X-Proofpoint-ORIG-GUID: SvHkVjmCQLCuoUXrfSHiKXOtTNMoH70T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050095
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf BPF filter test fails in environment where "kernel-debuginfo"
is not installed.

Test failure logs:
<<>>
42: BPF filter                            :
42.1: Basic BPF filtering                 : Ok
42.2: BPF pinning                         : Ok
42.3: BPF prologue generation             : FAILED!
<<>>

Enabling verbose option provided debug logs, which says debuginfo
needs to be installed. Snippet of verbose logs:

<<>>
42.3: BPF prologue generation                                       :
--- start ---
test child forked, pid 28218
<<>>
Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo
package.
bpf_probe: failed to convert perf probe events
Failed to add events selected by BPF
test child finished with -1
---- end ----
BPF filter subtest 3: FAILED!
<<>>

Here subtest, "BPF prologue generation" failed and
logs shows debuginfo is needed. After installing
kernel-debuginfo package, testcase passes.

Subtest "BPF prologue generation" failed because, the "do_test"
function returns "TEST_FAIL" without checking the error type
returned by "parse_events_load_bpf_obj" function.
Function parse_events_load_bpf_obj can also return error of type
"-ENODATA" incase kernel-debuginfo package is not installed. Fix this
by adding check for -ENODATA error.

Test result after the patch changes:

Test failure logs:
<<>>
42: BPF filter                 :
42.1: Basic BPF filtering      : Ok
42.2: BPF pinning              : Ok
42.3: BPF prologue generation  : Skip (clang/debuginfo isn't
installed or environment missing BPF support)

Fixes: ba1fae431e74 ("perf test: Add 'perf test BPF'")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Note: This is dependent on patch 1:
 tools/perf: Update the exit error codes in function
 try_to_find_probe_trace_event

 tools/perf/tests/bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 17c023823713..6a4235a9cf57 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -126,6 +126,10 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 
 	err = parse_events_load_bpf_obj(&parse_state, &parse_state.list, obj, NULL);
 	parse_events_error__exit(&parse_error);
+	if (err == -ENODATA) {
+		pr_debug("Failed to add events selected by BPF, debuginfo package not installed\n");
+		return TEST_SKIP;
+	}
 	if (err || list_empty(&parse_state.list)) {
 		pr_debug("Failed to add events selected by BPF\n");
 		return TEST_FAIL;
@@ -368,7 +372,7 @@ static struct test_case bpf_tests[] = {
 			"clang isn't installed or environment missing BPF support"),
 #ifdef HAVE_BPF_PROLOGUE
 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test,
-			"clang isn't installed or environment missing BPF support"),
+			"clang/debuginfo isn't installed or environment missing BPF support"),
 #else
 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
 #endif
-- 
2.31.1

