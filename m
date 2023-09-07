Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED8EC8726
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 17:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbjIGR4W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbjIGR4V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 13:56:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6410E9
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 10:56:00 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387H8SHt017027;
        Thu, 7 Sep 2023 17:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NsenYzBx6lluuRqNF2twSn+96C52XaMWkD4/qQRlKtU=;
 b=VjdwKX8M8twSGTVGR5NFzl2J6gaqdl3hXHgX6hmnyrbO0KV8astrP1njgQNzJyilVxLE
 ds0j1yOLYKv1rMJwrBvVrV1Xy3vCT6jFnpNN6QTh5TNwH5RrMUO1CWAyWP8ROLgZ80KE
 NcfhIEhoHDMZ2fJ47mIDFnjAriYGY7LhcH4jYJf1JBM3Y64oJWvhyHG0l2sSXNpnRGwz
 vfxEctjvTa9dJtZOzcJob+J7Qlhq+NF3VGTCYiA2ZiIb9/GzdFqRYT8KbvTQX/MM7J1D
 qEhSTw81UKscszFs9Q6eHYJ4RlYxa6ClG5Elwrr3lujvWZ/kE6UwGKC86KY5JpuyJg5T FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syj3u145n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:19:54 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 387H8u9E019551;
        Thu, 7 Sep 2023 17:19:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syj3u145b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:19:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 387FNs4S021441;
        Thu, 7 Sep 2023 17:19:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfrywmkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 17:19:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 387HJnQh27984380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 17:19:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CADD2004B;
        Thu,  7 Sep 2023 17:19:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C24C20043;
        Thu,  7 Sep 2023 17:19:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.9.102])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Sep 2023 17:19:47 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH] tools/perf: Add includes for detected configs in Makefile.perf
Date:   Thu,  7 Sep 2023 22:49:44 +0530
Message-Id: <20230907171944.36953-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9CmyjHzwNiS1t-TN86MlxcnQKJENT6BR
X-Proofpoint-ORIG-GUID: DoOq1o8yDcIRCJXeuYNzvcbjZMSff-tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070152
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Makefile.perf uses "CONFIG_*" checks in the code. Example the config
for libtraceevent is used to set PYTHON_EXT_SRCS

	ifeq ($(CONFIG_LIBTRACEEVENT),y)
	  PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
	else
	  PYTHON_EXT_SRCS := $(shell grep -v '^\#\|util/trace-event.c' util/python-ext-sources)
	endif

But this is not picking the value for CONFIG_LIBTRACEEVENT that is
set using the settings in Makefile.config. Include the file
".config-detected" so that make will use the system detected
configuration in the CONFIG checks. This will fix isues that
could arise when other "CONFIG_*" checks are added to Makefile.perf
in future as well.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/Makefile.perf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 37af6df7b978..6764b0e156f4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -351,6 +351,9 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
+# Use the detected configuration
+include .config-detected
+
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
 else
-- 
2.31.1

