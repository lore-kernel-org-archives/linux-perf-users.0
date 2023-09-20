Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C473FC04FF3
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 19:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjITT3q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjITT3X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E701A7
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 12:29:04 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KJ6VTV028063;
        Wed, 20 Sep 2023 19:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xHviIjSIGtAjHbY83gxmWUsuMOT6BxdHNIbHYoS1Z48=;
 b=lwiDoZprf2anNCsw8K5/HG7JQW9E4+XrWg8p9/VoHXswHPWPUiOpbMv1ooaUPmJHYMab
 NiD6AUOdRxXNGVeCc/jXwIdR7MAn3OXvwnctc4seQDNhAECKsWS8K84DDDq13UnloYez
 pPWj8wdu9hd9y3Kg58u//1F6BmaizUpfsJpVja3KdZwNxmp0jpzr0h4dJCIsrbl8QotC
 enJsrRUXgceAiOF7KpM1HqaLes7TFFfbr4/Xhl1RpM5jUHoU+pU/3k1S0hnDVOGtrAqE
 qCigtmAFOtZ8EfpGZaNJe3mlAat5Xurt/yZtr/IqrqtbKdvJYpS0mMg97yOvH5bOA2YC 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t80heumvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:29:01 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KJ6j0V029558;
        Wed, 20 Sep 2023 19:29:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t80heumuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:29:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KJ1PFW031222;
        Wed, 20 Sep 2023 19:28:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6m0mpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:28:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KJSuNJ18350774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 19:28:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DBE920043;
        Wed, 20 Sep 2023 19:28:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A0DF20040;
        Wed, 20 Sep 2023 19:28:54 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.61.45])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 19:28:54 +0000 (GMT)
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v2 2/4] perf version: update --build-options to use 'supported_features' array
Date:   Thu, 21 Sep 2023 00:58:45 +0530
Message-ID: <20230920192847.975897-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192847.975897-1-adityag@linux.ibm.com>
References: <20230920192847.975897-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _RgApOW1ikTEucEWBaaCAURQFOLWqcsJ
X-Proofpoint-ORIG-GUID: TCSTpUG_mEnwdfxMkOrcCfnhRZnIzlUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_09,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=969 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200158
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Now that the feature list has been duplicated in a global
'supported_features' array, use that array instead of manually checking
status of built-in features.

This helps in being consistent with commands such as 'perf check --feature',
so commands can use the same array, and any new feature can be added at
one place, in the 'supported_features' array

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/builtin-version.c | 39 ++++++++----------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index e5859c70e195..e149d96c6dc5 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -46,41 +46,18 @@ static void status_print(const char *name, const char *macro,
 	printf("  # %s\n", macro);
 }
 
-#define STATUS(__d, __m)				\
-do {							\
-	if (IS_BUILTIN(__d))				\
-		status_print(#__m, #__d, "on");		\
-	else						\
-		status_print(#__m, #__d, "OFF");	\
+#define STATUS(feature)                                   \
+do {                                                      \
+	if (feature.is_builtin)                               \
+		status_print(feature.name, feature.macro, "on");  \
+	else                                                  \
+		status_print(feature.name, feature.macro, "OFF"); \
 } while (0)
 
 static void library_status(void)
 {
-	STATUS(HAVE_DWARF_SUPPORT, dwarf);
-	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
-#ifndef HAVE_SYSCALL_TABLE_SUPPORT
-	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
-#endif
-	STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
-	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
-	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
-	STATUS(HAVE_LIBELF_SUPPORT, libelf);
-	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
-	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
-	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
-	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
-	STATUS(HAVE_SLANG_SUPPORT, libslang);
-	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
-	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
-	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
-	STATUS(HAVE_ZLIB_SUPPORT, zlib);
-	STATUS(HAVE_LZMA_SUPPORT, lzma);
-	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
-	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
-	STATUS(HAVE_AIO_SUPPORT, aio);
-	STATUS(HAVE_ZSTD_SUPPORT, zstd);
-	STATUS(HAVE_LIBPFM, libpfm4);
-	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
+	for (int i = 0; supported_features[i].name; ++i)
+		STATUS(supported_features[i]);
 }
 
 int cmd_version(int argc, const char **argv)
-- 
2.41.0

