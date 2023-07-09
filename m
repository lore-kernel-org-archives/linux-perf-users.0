Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AAEEB64DC
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jul 2023 18:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGIS3V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jul 2023 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGIS3V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jul 2023 14:29:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C711C
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jul 2023 11:29:19 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 369IHU8K003583;
        Sun, 9 Jul 2023 18:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oFniWbFbEHU2BiWKSygNR7EOUCBmzzDngUOOs7Av9aw=;
 b=nQSJFE79kQp/XLjE2X6GPLaZ/UE/TWsH2h8PvF9DpSotQ18j7UYLYYTdxff5eMBRXDUx
 FPpnOF/Q55kSQCZJMmyeagBX4LDwvM3uaYOcyMqgMOVZuWUdTwdv0Kec84U4GwwzdkTx
 KjiKlcU4x62JDsEqxd/h2NisnEg0AVcNv/ZHzFy41JIzq6wzmPrKG8ilMuCDqqcuViLU
 rkvr2VKuBLNlNK8ELdGhRufygtjqoFP5ayoaeWyS5lzh6Z4GRzbatl/+WXKz8XTTzjva
 +j7Qn237iJEM97gNA3j9X67JV0L43EtJQUKnPchEVzafuvFBo3UMpCwWCQRJigL8cmba Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr21nr408-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:29:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 369ISeX9030585;
        Sun, 9 Jul 2023 18:29:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr21nr401-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:29:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36983u9r015079;
        Sun, 9 Jul 2023 18:29:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye58v4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:29:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 369IT8vX36438464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jul 2023 18:29:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7CAF2004B;
        Sun,  9 Jul 2023 18:29:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86F6820040;
        Sun,  9 Jul 2023 18:29:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.24.202])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jul 2023 18:29:06 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 24/26] tools/perf/tests/shell/lib: Fix shellcheck warning for stat_output.sh shell script
Date:   Sun,  9 Jul 2023 23:57:58 +0530
Message-Id: <20230709182800.53002-25-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
References: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LxjQbH_tsDeOzn_It0ZkhTyASzO8RVVL
X-Proofpoint-GUID: vDVqUdQtFZ9TC-ry2-1jys5-CFlL4QuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-09_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307090169
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

Running shellcheck on stat_output.sh throws below warning:

In tests/shell/lib/stat_output.sh line 1:
^-- SC2148 (error): Tips depend on target shell and yours is unknown. Add a shebang or a 'shell' directive.

Fixed the warning by adding shell directive.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/shell/lib/stat_output.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index 363979b1123d..db2a53e6989c 100755
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Return true if perf_event_paranoid is > $1 and not running as root.
-- 
2.39.1

