Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4A13BC1B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476515; cv=none; b=eo8b1Mmoykfggtrr9vO0iWR/pguIOZUhbnPNHNFHs5O/IZ2kYEHr8KpZHhplsX+7BKLXU8wO3t4F2/cj8UwtsM8jg9qgy8dCVOZPKQHquLhGsp+n9WX2XKIuDBp18XKgpIfddmIPp6M0+ADpUL2wjiQ8wVyrREtcHIPg8wIO1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476515; c=relaxed/simple;
	bh=WpBp3/z+BRAfdauAhxx3G6YbdWrB3ili4i6diOt9T9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bd+hhrHCwUiv1yAdlE17n8W2+/4f7eTbHF6ApvCZpPVggfKShkknaKFNv2okb569+cFNC9LKrYF2bLnAYQTkYgrbxU25r92zhL/yZgzUnfWlAsg/C8zhVI6yg3S2WX2p48m2fvFzpqSWGfkEnNnre+U+JvDcnRsup5QO+z/X0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JGweZPPd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JGweZPPd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484AwNXH005020;
	Wed, 4 Sep 2024 19:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=5SzB6YWZBjtCe
	fAZasoqdorcb4qZ/IjRpbY7E/Ib6AE=; b=JGweZPPdJkOWpPTWcX2l9jeqtJboE
	y6Nz86GsBEbcoxk9rTdSKMvuArBgLNiVSpIfirBpCkIMRyKzAzdkPtgQxgiGa4HZ
	6QcxuLrLsoq3w2olVSNdk1ZXmQdbLkSTEX2EhyebCRtawgW+pe2MU2mnqVLW9QQP
	1UDS0oxeyFRheXei1ogYptq03n77X0Z8gfKu65hF9hzdKj3U5hFbcBUYyje/Tm/n
	Cz6AHmWwcddB/HklhaM878qrLY8NVq+ko3xVaEGVEo096yyC33Q/Ls/1QOHS50QH
	bNob0ZcAHl/xZMXUCNnvBnA7BQa67vb6/FmaPDrBkQqlRT1I//YX9iYEw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwb4tcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 484IvBln009269;
	Wed, 4 Sep 2024 19:01:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwb4tct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 484GXL4e018726;
	Wed, 4 Sep 2024 19:01:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw19a6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 484J1iH628574338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 19:01:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A731220043;
	Wed,  4 Sep 2024 19:01:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7292820040;
	Wed,  4 Sep 2024 19:01:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.39.16.11])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 19:01:42 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v15 3/7] perf version: Update --build-options to use 'supported_features' array
Date: Thu,  5 Sep 2024 00:31:28 +0530
Message-ID: <20240904190132.415212-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904190132.415212-1-adityag@linux.ibm.com>
References: <20240904190132.415212-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: buFvqGtr2kO8HG3o4rlO1yA1TCNemUAu
X-Proofpoint-GUID: sAYFWK-WW_EODvvBchD1pPCDUdnLvF_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040140

Now that the feature list has been duplicated in a global
'supported_features' array, use that array instead of manually checking
status of built-in features.

This helps in being consistent with commands such as 'perf check feature',
so commands can use the same array, and any new feature can be added at
one place, in the 'supported_features' array

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
The following line was removed in this patch: "STATUS(HAVE_LIBLLVM_SUPPORT, libllvm);"

Added that feature entry to a later patch: "perf: Add more features to supported_features list"
---
---
 tools/perf/builtin-version.c | 44 +++++++-----------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 4b252196de12..e149d96c6dc5 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -46,46 +46,18 @@ static void status_print(const char *name, const char *macro,
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
-	STATUS(HAVE_LIBLLVM_SUPPORT, libllvm);
-	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
-	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
-	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
-	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
-	STATUS(HAVE_SLANG_SUPPORT, libslang);
-	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
-	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
-	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
-	STATUS(HAVE_LIBCAPSTONE_SUPPORT, libcapstone);
-	STATUS(HAVE_ZLIB_SUPPORT, zlib);
-	STATUS(HAVE_LZMA_SUPPORT, lzma);
-	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
-	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
-	STATUS(HAVE_AIO_SUPPORT, aio);
-	STATUS(HAVE_ZSTD_SUPPORT, zstd);
-	STATUS(HAVE_LIBPFM, libpfm4);
-	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
-	STATUS(HAVE_BPF_SKEL, bpf_skeletons);
-	STATUS(HAVE_DWARF_UNWIND_SUPPORT, dwarf-unwind-support);
-	STATUS(HAVE_CSTRACE_SUPPORT, libopencsd);
+	for (int i = 0; supported_features[i].name; ++i)
+		STATUS(supported_features[i]);
 }
 
 int cmd_version(int argc, const char **argv)
-- 
2.46.0

