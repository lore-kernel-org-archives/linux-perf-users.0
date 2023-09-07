Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD5EC8752
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 18:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjIGS2v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbjIGS2s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 14:28:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642FC4
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 11:28:28 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Gckx2014947;
        Thu, 7 Sep 2023 17:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CRdb1SnuerVfXkkvHbHxQXRxBw2ZjpF3AYd2nC5UEfY=;
 b=XimzL3i/gWVOZK0lEn97gQbUIQyqYlBJEbMMZ5k4yiu97LL/SsKeHzx93MDJcYPaYTmn
 rSYgOJgbO/drSJDSTTgiuYWu9QLjCGPa51xMfZd1RkWz3cTLTgTKJI3WAMOLb+OaNVfq
 KYkEzGgN4/EC5Aq9nYBZ0ogzwcD+qMzzIF4IT0XuoEmQKrJH9ZX9bc+xq/6Dw2HLLfh1
 1EEt3juGlGsNOBBjzge8t3XKY5G4j2hxcn6SpVgMarQV2rF6psLOgMzNRlJI/t2izAim
 vIYyz9E/g1uKRcr9fVcjl5K6FbEhG633+q25ZZ3Z6E4+kyjXUzUMGyPQyvagYijswmon hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syhf5tc8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:15:57 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 387GcsSS015650;
        Thu, 7 Sep 2023 17:15:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syhf5tc8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:15:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 387GrM53011121;
        Thu, 7 Sep 2023 17:15:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj324whd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:15:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 387HFrLY24642178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 17:15:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB15C20043;
        Thu,  7 Sep 2023 17:15:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C07520040;
        Thu,  7 Sep 2023 17:15:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.9.102])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Sep 2023 17:15:51 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 3/3] tests/shell: Fix shellcheck warnings for SC2153 in multiple scripts
Date:   Thu,  7 Sep 2023 22:45:40 +0530
Message-Id: <20230907171540.36736-4-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230907171540.36736-1-atrajeev@linux.vnet.ibm.com>
References: <20230907171540.36736-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tLZnW3qVxwWhWPkL_SnofljJJd2-E_vw
X-Proofpoint-GUID: OpG1ltHIZNqWKq7OqjWNgsw4V15DGNBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070152
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Running shellcheck on some of the shell scripts, throws
below warning on shellcheck v0.6. Example:

   In tests/shell/coresight/asm_pure_loop.sh line 14:
   DATA="$DATD/perf-$TEST-$DATV.data"
          ^---^ SC2153: Possible misspelling: DATD may not be assigned, but DATA is.

Here, DATD is exported from "lib/coresight.sh" and this
warning can be ignored. Use "shellcheck disable=" to ignore
this check.

Signed-off-by:  Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/coresight/asm_pure_loop.sh            | 1 +
 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh     | 1 +
 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh | 1 +
 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh  | 1 +
 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop.sh b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
index 04387061e9f3..2d65defb7e0f 100755
--- a/tools/perf/tests/shell/coresight/asm_pure_loop.sh
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
@@ -11,6 +11,7 @@ TEST="asm_pure_loop"
 
 ARGS=""
 DATV="out"
+# shellcheck disable=SC2153
 DATA="$DATD/perf-$TEST-$DATV.data"
 
 perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
index c17e442ac741..ddcc9bb850f5 100755
--- a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
+++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
@@ -11,6 +11,7 @@ TEST="memcpy_thread"
 
 ARGS="16 10 1"
 DATV="16k_10"
+# shellcheck disable=SC2153
 DATA="$DATD/perf-$TEST-$DATV.data"
 
 perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
index e47c4e955d0e..2ce5e139b2fd 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
@@ -11,6 +11,7 @@ TEST="thread_loop"
 
 ARGS="10 1"
 DATV="check-tid-10th"
+# shellcheck disable=SC2153
 DATA="$DATD/perf-$TEST-$DATV.data"
 STDO="$DATD/perf-$TEST-$DATV.stdout"
 
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
index 8bf94a02e384..3ad9498753d7 100755
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
+++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
@@ -11,6 +11,7 @@ TEST="thread_loop"
 
 ARGS="2 20"
 DATV="check-tid-2th"
+# shellcheck disable=SC2153
 DATA="$DATD/perf-$TEST-$DATV.data"
 STDO="$DATD/perf-$TEST-$DATV.stdout"
 
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
index 0dc9ef424233..4fbb4a29aad3 100755
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
@@ -11,6 +11,7 @@ TEST="unroll_loop_thread"
 
 ARGS="10"
 DATV="10"
+# shellcheck disable=SC2153
 DATA="$DATD/perf-$TEST-$DATV.data"
 
 perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
-- 
2.31.1

