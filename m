Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46BACA0ECE
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 06:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjILGir (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjILGir (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 02:38:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB1E76
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 23:38:43 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C6aeQZ003197;
        Tue, 12 Sep 2023 06:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mHX5r4EE7M9edmf1gTkvH6HdkVNl1vwejw5sDbrux50=;
 b=IHnDcBjurkl7JIy6f9AIYHvJe8tLelrehvBSI3RxLTcVU1PRwQz/8N/sDk22qU+4wACs
 ZvYy8ccsuhxzpq1vpAsUerQfttgKlnjghcN57dUzQKuo1XY9QBdJLLcSlrB4XpEPkpmW
 mwkRpcBsp0N/vfqMCK1VqhtQsusu37ddDW0zVArcnCc6gqdXa8zgfBRbcdqt/qnfvHg/
 U+pTtJp97nqZ+u6XYqN50ACkWG3WpD103JFxDEZrlOiUBmAQ5997sw55hK9ammsvhJic
 jAgcTU6KnyKJzOmx68nkgZxVh9Oc6eILiAdJDQnp3E06o+C5J3YAppwNYCXdp92+JPCv 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2hv51ck5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:38:30 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C6cUtl009875;
        Tue, 12 Sep 2023 06:38:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2hv51cjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:38:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C6Kxre002724;
        Tue, 12 Sep 2023 06:38:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkrstn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:38:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C6cPMf45809970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 06:38:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DD3420049;
        Tue, 12 Sep 2023 06:38:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27BC920040;
        Tue, 12 Sep 2023 06:38:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.60.12])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 06:38:21 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V3] tools/perf: Add includes for detected configs in Makefile.perf
Date:   Tue, 12 Sep 2023 12:08:07 +0530
Message-Id: <20230912063807.74250-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ywloclwEZv9rTynK_qG3jP0fkLL_jCVy
X-Proofpoint-GUID: LY3L4GxxZf1010LV6G6GnXywxUHKVrx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120054
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
Changelog:
v2 -> v3:
Added -include since in some cases make clean or make
will fail when config is not included and if config-detected
file is not present.

v1 -> v2:
Added $(OUTPUT) prefix to config-detected as pointed
out by Ian

 tools/perf/Makefile.perf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 37af6df7b978..f6fdc2d5a92f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -351,6 +351,9 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
+# Use the detected configuration
+-include $(OUTPUT).config-detected
+
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
 else
-- 
2.31.1

