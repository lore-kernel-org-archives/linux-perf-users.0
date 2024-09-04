Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD412DD90
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430735; cv=none; b=pJb+6/89vjnE5NboB+me+J/ojbPbTPWo7eB96WpLoK2RdU8LjD42n0gz9Q8QZNEpkEDoNYziWWXZKdn36XZsTu7xdn06vAP+fIjLlvFU0gosdsttV1gE1wU5HiiKH0eNYxYDzP4kIcnV4i9b5ZhUj4eXGziZ1B/ze498NGrnECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430735; c=relaxed/simple;
	bh=I+o/6ahQWBb8pff2D88CbhqJ89DXclCY3MDWyKIksYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adjO/tq+DuyC4OtHBxL6bU/Vmbzzw4ibfV88wNWwmvMko8+DPaBuHscVb3tlqHtb2eNLT6kRwCz3w2k/6HHGuWHuIPCvsJbTcVJpUAr9/+9HdXH6c+IG5A7ZTPrX4lqYnGujBl9Z1HvN74U5lgs8LJkbolpsyJiXD/4CQpTscnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QJT97XPX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QJT97XPX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483MnRBI032499;
	Wed, 4 Sep 2024 06:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=fM/p2UqnJsmcA
	vtSqA6DMxknaMaqB0QY5jm9tMeYhEc=; b=QJT97XPX2Ntqsw18nYEQNF8xuTS4g
	vqNrQ8ddLQ2DH0V/5KZ0qKyvumI1dzfutAo3UWhqP0LGDtgVN3qQo65wWxkgsVBA
	1CeqKXcp6euni2PAMQq6Yv749NCJLhRR0XNfBE4cBdWmsucIOMOOCAk98r8yKPuC
	jQg4pNoRtd5mDutzqVLEDYC3hesd4yVm2JYV64HxMNeCCBlcxSpVJprYF7M+kaaQ
	mSdW8YRHSf+kNU/BOW0n4fjk94IBv00qN2I3T5B6dXb1DW5Bc1LdLajqjk7JgP7X
	cAKRkCwbReTXXVVCMfpXwy3oHakXxWRW0yQvgiLjWDZKypOO1Rnabty9w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqsw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:18:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4846Iogn005836;
	Wed, 4 Sep 2024 06:18:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqsw6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:18:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4841fH2L009141;
	Wed, 4 Sep 2024 06:18:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cg73p1gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:18:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846IkPr9109950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:18:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3807A20049;
	Wed,  4 Sep 2024 06:18:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4432420040;
	Wed,  4 Sep 2024 06:18:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.38])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 06:18:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v14 3/7] perf version: Update --build-options to use 'supported_features' array
Date: Wed,  4 Sep 2024 11:48:32 +0530
Message-ID: <20240904061836.55873-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904061836.55873-1-adityag@linux.ibm.com>
References: <20240904061836.55873-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sp4HccCWljH-ZvRgZc7qcDqM7jH-v6Hn
X-Proofpoint-ORIG-GUID: _9MRBOhIMTSWfQwux9T3l8wyiTu3pyuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040045

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
 tools/perf/builtin-version.c | 43 +++++++-----------------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 398aa53e9e2e..e149d96c6dc5 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -46,45 +46,18 @@ static void status_print(const char *name, const char *macro,
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

