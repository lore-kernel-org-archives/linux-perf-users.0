Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97C187339
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407824; cv=none; b=qlYPWOto4KHdu0ND9QB2akyjX+vVgvDw/aDqovr7yioiMC1ScqUOhgH5HqlEgKh42NweQKuCimHmQsXxBBqeyzVy1qR1dh8Nwiqx9Xu0QJP4r/TVHoiodT5Ppb4CLiGTK1o86iCU9ZE/0NjKvTuvCitAKXtDdGZQ0g0AvmQ/9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407824; c=relaxed/simple;
	bh=Ud8JwXtBMVVjWXiD7nU6hEZsVyaSHijGU0Z28Po3oO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyw9sbGFvVNwI42hjONzMEspKixs3FVAdXgUzCxTWiSKsPGQ73TH5teK1O7qPZN3YUoShwl+HdNKt/GUj8/Wy3Fqd2h8qX1DiDwlBdYW50Ybf6N/CZ/3lxBbT4+tHoXyzB5Pq/ZwL4/1Cy7o/Hk8TXBJY90bvyKWU3upUY29IT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UvnDl0w/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UvnDl0w/"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QCxK7V029379;
	Wed, 26 Jun 2024 13:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Olk9IAhjcOxgM
	B23edEiID6rqmW/xp45Qb1sF5e4FGM=; b=UvnDl0w/vd1ZKSWkdzZ13SirNCu+x
	+7vqfczrbPDAjmbzwpwKGteUcY04/ySr0IwinwBn/IO6bxpadez21WtqRyZ0mOY3
	c8fE73jPR7i3NeqfwJ/+PTn0rFF0/PHHSluCoGeq/t7r6u4f0xmyic2fIj6AvLta
	1r/jvWEWre51TDSSNHW7R/luO0h7UyzESJfzCOlmeaVE6aU0IHU29oV1wEO/YVa5
	hAwOAjdq0xjxtb3YBLgIA8HnnYE5QpicEQJQ9abumlQbRCuSBf1znTXd8j4Yobe1
	bxxvUx/9a6fK3CidDdVa4Giidd7aTKGowQ8vSByxApdTXLXwQwuDB0hwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400kff81pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:54 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QDEaHg020070;
	Wed, 26 Jun 2024 13:16:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400kff81pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45QBVIvI008183;
	Wed, 26 Jun 2024 13:16:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b0vqf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QDGkYq54919452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:16:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 906AD20043;
	Wed, 26 Jun 2024 13:16:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7420C20040;
	Wed, 26 Jun 2024 13:16:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.124.217.114])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 13:16:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v10 2/4] perf version: update --build-options to use 'supported_features' array
Date: Wed, 26 Jun 2024 18:46:36 +0530
Message-ID: <20240626131638.597544-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626131638.597544-1-adityag@linux.ibm.com>
References: <20240626131638.597544-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GVv9l2PqaA2WW2YtKP2wbfKVcfH9Peyf
X-Proofpoint-ORIG-GUID: LUAz3RpLNQusYZQY0GTM63hkIzmprYT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260096

Now that the feature list has been duplicated in a global
'supported_features' array, use that array instead of manually checking
status of built-in features.

This helps in being consistent with commands such as 'perf check feature',
so commands can use the same array, and any new feature can be added at
one place, in the 'supported_features' array

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
2.45.2

