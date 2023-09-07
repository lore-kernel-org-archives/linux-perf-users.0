Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD6EC874C
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 17:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbjIGRRP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242507AbjIGRRM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 13:17:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBBBBC
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 10:16:49 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387H8kLp002201;
        Thu, 7 Sep 2023 17:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+rwfNcACcxYTNaytUgMMAPHhVp1QYQ16ziffVLqt6R0=;
 b=EJ5HQGbLfyO+IelrHLaoyUlV45GxSf0UiZqA5pBwdyBE1sMaQBwFNdByAj0R81G3/L5J
 bMyz4URgdRXwjjNcv0B4LeJx2n2YLlMgCcv62CJYDXdzWM6f+Tc6bDh1hNa43KrKvzl6
 lmQd0DCAGrWGQRjSPk3hXSzuutYHO4xNND0Nih5dq92pukhh+j9dQ338sl4qRTbBb3b0
 MICmKp0DxbBza5j/2xlck/B4IDe59SL4fDPvW6acl32pGSlVdu3+EFegkPZy4YenQ58I
 hszjcyALvCpl7S1j7p4QRPIKv17OULi9gvVkGNuZO5VO4t7YNIaMqxuNmr9uzPKob456 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syf6rqtfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:15:56 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 387H9pki005027;
        Thu, 7 Sep 2023 17:15:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syf6rqtf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:15:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 387GPFQQ006602;
        Thu, 7 Sep 2023 17:15:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkw6kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:15:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 387HFpAe41812250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 17:15:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 160E720043;
        Thu,  7 Sep 2023 17:15:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A919B20040;
        Thu,  7 Sep 2023 17:15:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.9.102])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Sep 2023 17:15:48 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 2/3] tests/shell: Fix shellcheck issues in tests/shell/stat+shadow_stat.sh tetscase
Date:   Thu,  7 Sep 2023 22:45:39 +0530
Message-Id: <20230907171540.36736-3-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230907171540.36736-1-atrajeev@linux.vnet.ibm.com>
References: <20230907171540.36736-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t1SKAsO7wHDFLRnwsjde-Tr2kplZDxwI
X-Proofpoint-GUID: lKSQhA88QsOkaGVfB6CDuwZZAEZA9Mxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070152
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Running shellcheck on stat+shadow_stat.sh generates below
warning

    In tests/shell/stat+csv_summary.sh line 26:
    while read _num _event _run _pct
           ^--^ SC2034: _num appears unused. Verify use (or export if used externally).
                ^----^ SC2034: _event appears unused. Verify use (or export if used externally).
                       ^--^ SC2034: _run appears unused. Verify use (or export if used externally).
                            ^--^ SC2034: _pct appears unused. Verify use (or export if used externally).

This variable is intentionally unused since it is
needed to parse through the output. commit used "_"
as a prefix for this throw away variable. But this
stil shows warning with shellcheck v0.6. Fix this
by only using "_" instead of prefix and variable name.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/stat+csv_summary.sh | 4 ++--
 tools/perf/tests/shell/stat+shadow_stat.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/stat+csv_summary.sh b/tools/perf/tests/shell/stat+csv_summary.sh
index 8bae9c8a835e..323123ff4d19 100755
--- a/tools/perf/tests/shell/stat+csv_summary.sh
+++ b/tools/perf/tests/shell/stat+csv_summary.sh
@@ -10,7 +10,7 @@ set -e
 #
 perf stat -e cycles  -x' ' -I1000 --interval-count 1 --summary 2>&1 | \
 grep -e summary | \
-while read summary _num _event _run _pct
+while read summary _ _ _ _
 do
 	if [ $summary != "summary" ]; then
 		exit 1
@@ -23,7 +23,7 @@ done
 #
 perf stat -e cycles  -x' ' -I1000 --interval-count 1 --summary --no-csv-summary 2>&1 | \
 grep -e summary | \
-while read _num _event _run _pct
+while read _ _ _ _
 do
 	exit 1
 done
diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index a1918a15e36a..386821462f3c 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -14,7 +14,7 @@ test_global_aggr()
 {
 	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
 	grep -e cycles -e instructions | \
-	while read num evt _hash ipc rest
+	while read num evt _ ipc rest
 	do
 		# skip not counted events
 		if [ "$num" = "<not" ]; then
@@ -45,7 +45,7 @@ test_no_aggr()
 {
 	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
 	grep ^CPU | \
-	while read cpu num evt _hash ipc rest
+	while read cpu num evt _ ipc rest
 	do
 		# skip not counted events
 		if [ "$num" = "<not" ]; then
-- 
2.31.1

