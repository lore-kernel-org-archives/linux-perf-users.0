Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02205D299
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556986; cv=none; b=Nb+7SrOeaNXXTMbN2h2eb1b4c6uIz/N/3mVo+974YQrdrrGoClBMmrvUPGV18e3NOmplYeuG+Ke1R3q4ytpPI8fHiDEhwV4Ia06Mk1xfX0pM6+cYXq6zHkP5TWE2LQ+VAgavSda7lR7LFEPb1ueVyJ/AX0vII84dC519kJMdYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556986; c=relaxed/simple;
	bh=Ud8JwXtBMVVjWXiD7nU6hEZsVyaSHijGU0Z28Po3oO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPvFa1hzUHMO41Ixtucl8KpqioXZoYw9pvZHLc+Y1vWNl/OTOxa+EUoqY4r5LBj/PhYbXLRQIDKPzzCzrt2Rw68AFKq1HZhR5m+scZy2XIIMDKFkPnVnlaPXOhHmr+xLogEJCFbuSGjyy9GltyARqpH0NMUBNZiDfAtm1O323b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EP+UTK+/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EP+UTK+/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S6TB6n023051;
	Fri, 28 Jun 2024 06:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Olk9IAhjcOxgM
	B23edEiID6rqmW/xp45Qb1sF5e4FGM=; b=EP+UTK+//f2WyupYykLqzLuOEwQHL
	8J4aZ1sKEa/aL3ZHGeDrWV/TQ5kj2OUZP+/LoWqJaFno+RpdkrjuB9z2MiwenWmY
	/YgbI7wO2c5gVELff8r1dI6PZJwblbo6XtgA0GGPIYgbRiGwbF4FHXwHfUcobPAZ
	Vg5Vnn0P6/e7fpuaVYZ59TUqiWs2+2Xoum6b4H+5fH6oI6H4rEts2oR5FMFCCn5L
	4sQKqbxx6jwnHASh4RJ4tSMS3LnJMSX/TgOD2cqZ66vxXYmS7KPqYZRUekepWPvb
	T6JF3OnT6imXr7kIsKEjFIeAQAINSY+gdov0o/JJ5J+JUeX1uq4Cc+BGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qxkg11h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:43:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S6h1mR010349;
	Fri, 28 Jun 2024 06:43:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qxkg11g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:43:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S6WLDq000674;
	Fri, 28 Jun 2024 06:43:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaenews9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:43:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S6gsSG17695148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 06:42:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0DE220040;
	Fri, 28 Jun 2024 06:42:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54CC02004B;
	Fri, 28 Jun 2024 06:42:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.195.36.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 06:42:49 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v12 2/4] perf version: update --build-options to use 'supported_features' array
Date: Fri, 28 Jun 2024 12:12:34 +0530
Message-ID: <20240628064236.1123851-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628064236.1123851-1-adityag@linux.ibm.com>
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d3LXY4qzKfNuWDyasnigbyeUNq_9ncPx
X-Proofpoint-ORIG-GUID: xKVKdpsbFJydG9ZLTqyJ8czO0rRNgvK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280045

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

