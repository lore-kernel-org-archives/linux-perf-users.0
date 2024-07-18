Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27380638
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293230; cv=none; b=UZHpFN4RcsoOC5p+Kr6COmyd9gq9NEI1aLeWBNDomjq9oAhMXEyBzjacnDA2U2JUTfGHFX4ZEc6DeheiQZnembO3gT7epRDlm2ztaBdK0R3IwdZbkPQBSNg75A8DIEdp3ROAIVtrMQDNdiLxGNZjN2FBXfBotsMzEq4PwilvvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293230; c=relaxed/simple;
	bh=KVM4lfG+B7p6IEJvcdvAhvq6KFbo1T9Wur+MTpJYsp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZERO5nFYPyYP53tWmamri1JRfMVX/U/MV5SUHLIfu6oT1jedVpKrdkUljT9rzJMaO2d6hSR75gala4dQugzd4lhXwaZtblljdifI2r1MTOCMqicF9Sf2LBaZDRB9bI44maxSTQhTYDox9g/vAo5gucIARVODi/5SsUjx+ntmhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KIS5ftPl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KIS5ftPl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8w3qn019718;
	Thu, 18 Jul 2024 09:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=DZDgybpv8V9kr
	VxBcJIrSK6Ml78wASuTWkICxnwzJyI=; b=KIS5ftPluW9tqmB6U8YPwzOpmz6em
	2S9NZ5gcWHoV0AETwQNnbsqg+a45HbzOWL38umK5DzP+FDmkp4q8vfF+M91q1P3S
	33qwDf/HToZHREtETFnRiHKXsX9+r/DbKHjASbSuslIc22HTNM+CHOmgrppGncUU
	yRFZ82mveSKMRBOeMME9r3h0yocqJ07wqgNLztWsznknQWvgZ8Og1a4mUveC99zY
	FWbNp6cKcB0O5AtLjzoZEKLtTWPwM8+IoaRFSiPUH8NnW/KWlaZ5+lnOS1VSja2f
	/V4NJewc1fu7zU3Phr7P+AKOf75NSQ59aoeWdx5oGlm2w/vCvnvd3HvLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40evxe0ed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I90QmL023144;
	Thu, 18 Jul 2024 09:00:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40evxe0ed0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I5Dsfa000462;
	Thu, 18 Jul 2024 09:00:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkk8sg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I90JrK58130864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:00:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 528F52004F;
	Thu, 18 Jul 2024 09:00:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F01BB2004B;
	Thu, 18 Jul 2024 09:00:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 09:00:16 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v13 7/7] perf: Add more features to supported_features list
Date: Thu, 18 Jul 2024 14:29:57 +0530
Message-ID: <20240718085957.550858-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718085957.550858-1-adityag@linux.ibm.com>
References: <20240718085957.550858-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zYHnRqa7B352a-3aTpbx5XnisaTkn-0f
X-Proofpoint-ORIG-GUID: AbBA-4kwa_ytMcArrQZfc5hSWihhOUkt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180056

As suggested in [1], add more feature names and corresponding names,
based on the information in Makefile.config

The entries were added after seeing the corresponding -D option which is
added to CFLAGS, based on the presence of a feature in Makefile.config,
such as:

    ifeq ($(feature-file-handle), 1)
      CFLAGS += -DHAVE_FILE_HANDLE
    endif

For above feature 'file-handle', corresponding entry has been added to
supported_features as below:

    FEATURE_STATUS("file-handle", HAVE_FILE_HANDLE)

[1]: https://lore.kernel.org/linux-perf-users/Zn7EvDbsnlbLXj4g@x1/

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
Could not add below features to the list:

* 'fortify-source': is a compiler option, doesn't add any feature MACRO
* 'stackprotector-all': is a compiler option, doesn't add any feature MACRO
* 'libtracefs': defines 'LIBTRACEFS_VERSION', not something like 'HAVE_LIBTRACEFS_SUPPORT'
* 'reallocarray': it's absence is known by 'COMPAT_NEED_REALLOCARRAY', but no flag for 'presence' of feature

Also, few names may feel inconsistent, but left as is:
* 'HAVE_GETTID': could be 'HAVE_GETTID_SUPPORT'
* 'LIBC_SUPPORT': could be 'HAVE_LIBC_SUPPORT'
* 'HAVE_LIBNUMA_SUPPORT': used by both 'numa_num_possible_cpus' and
  'libnuma', can remove one of those
* Currently some features have '_' in name, others have '-'
---
---
 tools/perf/Documentation/perf-check.txt | 78 ++++++++++++++++---------
 tools/perf/builtin-check.c              | 28 ++++++++-
 2 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 10f69fb6850b..cc1fe02ca01a 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -43,33 +43,57 @@ feature::
                 perf check feature libtraceevent,bpf
 
         Supported feature names/macro:
-                aio                     /  HAVE_AIO_SUPPORT
-                bpf                     /  HAVE_LIBBPF_SUPPORT
-                bpf_skeletons           /  HAVE_BPF_SKEL
-                debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
-                dwarf                   /  HAVE_DWARF_SUPPORT
-                dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
-                dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
-                auxtrace                /  HAVE_AUXTRACE_SUPPORT
-                libaudit                /  HAVE_LIBAUDIT_SUPPORT
-                libbfd                  /  HAVE_LIBBFD_SUPPORT
-                libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
-                libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
-                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
-                libelf                  /  HAVE_LIBELF_SUPPORT
-                libnuma                 /  HAVE_LIBNUMA_SUPPORT
-                libopencsd              /  HAVE_CSTRACE_SUPPORT
-                libperl                 /  HAVE_LIBPERL_SUPPORT
-                libpfm4                 /  HAVE_LIBPFM
-                libpython               /  HAVE_LIBPYTHON_SUPPORT
-                libslang                /  HAVE_SLANG_SUPPORT
-                libtraceevent           /  HAVE_LIBTRACEEVENT
-                libunwind               /  HAVE_LIBUNWIND_SUPPORT
-                lzma                    /  HAVE_LZMA_SUPPORT
-                numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
-                syscall_table           /  HAVE_SYSCALL_TABLE_SUPPORT
-                zlib                    /  HAVE_ZLIB_SUPPORT
-                zstd                    /  HAVE_ZSTD_SUPPORT
+                aio                         /  HAVE_AIO_SUPPORT
+                auxtrace                    /  HAVE_AUXTRACE_SUPPORT
+                backtrace                   /  HAVE_BACKTRACE_SUPPORT
+                bpf                         /  HAVE_LIBBPF_SUPPORT
+                bpf_skeletons               /  HAVE_BPF_SKEL
+                debuginfod                  /  HAVE_DEBUGINFOD_SUPPORT
+                disassembler-four-args      /  DISASM_FOUR_ARGS_SIGNATURE
+                disassembler-init-styled    /  DISASM_INIT_STYLED
+                dwarf_getcfi                /  HAVE_DWARF_CFI_SUPPORT
+                dwarf_getlocations          /  HAVE_DWARF_GETLOCATIONS_SUPPORT
+                dwarf                       /  HAVE_DWARF_SUPPORT
+                dwarf-unwind                /  HAVE_DWARF_UNWIND_SUPPORT
+                eventfd                     /  HAVE_EVENTFD_SUPPORT
+                file-handle                 /  HAVE_FILE_HANDLE
+                get_current_dir_name        /  HAVE_GET_CURRENT_DIR_NAME
+                gettid                      /  HAVE_GETTID
+                glibc                       /  LIBC_SUPPORT
+                libaio                      /  HAVE_AIO_SUPPORT
+                libaudit                    /  HAVE_LIBAUDIT_SUPPORT
+                libbfd-buildid              /  HAVE_LIBBFD_BUILDID_SUPPORT
+                libbfd                      /  HAVE_LIBBFD_SUPPORT
+                libcap                      /  HAVE_LIBCAP_SUPPORT
+                libcapstone                 /  HAVE_LIBCAPSTONE_SUPPORT
+                libcrypto                   /  HAVE_LIBCRYPTO_SUPPORT
+                libdw-dwarf-unwind          /  HAVE_DWARF_SUPPORT
+                libelf-gelf_getnote         /  HAVE_GELF_GETNOTE_SUPPORT
+                libelf-getphdrnum           /  HAVE_ELF_GETPHDRNUM_SUPPORT
+                libelf-getshdrstrndx        /  HAVE_ELF_GETSHDRSTRNDX_SUPPORT
+                libelf                      /  HAVE_LIBELF_SUPPORT
+                libnuma                     /  HAVE_LIBNUMA_SUPPORT
+                libopencsd                  /  HAVE_CSTRACE_SUPPORT
+                libperl                     /  HAVE_LIBPERL_SUPPORT
+                libpfm4                     /  HAVE_LIBPFM
+                libpython                   /  HAVE_LIBPYTHON_SUPPORT
+                libslang                    /  HAVE_SLANG_SUPPORT
+                libslang-include-subdir     /  HAVE_SLANG_INCLUDE_SUBDIR
+                libtraceevent               /  HAVE_LIBTRACEEVENT
+                libunwind                   /  HAVE_LIBUNWIND_SUPPORT
+                libzstd                     /  HAVE_ZSTD_SUPPORT
+                lzma                        /  HAVE_LZMA_SUPPORT
+                numa_num_possible_cpus      /  HAVE_LIBNUMA_SUPPORT
+                pthread-attr-setaffinity-np /  HAVE_PTHREAD_ATTR_SETAFFINITY_NP
+                pthread-barrier             /  HAVE_PTHREAD_BARRIER
+                scandirat                   /  HAVE_SCANDIRAT_SUPPORT
+                sched_getcpu                /  HAVE_SCHED_GETCPU_SUPPORT
+                sdt                         /  HAVE_SDT_EVENT
+                setns                       /  HAVE_SETNS_SUPPORT
+                syscall_table               /  HAVE_SYSCALL_TABLE_SUPPORT
+                timerfd                     /  HAVE_TIMERFD_SUPPORT
+                zlib                        /  HAVE_ZLIB_SUPPORT
+                zstd                        /  HAVE_ZSTD_SUPPORT
 
 OPTIONS
 -------
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 0b76b6e42b78..8c1deee80a68 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -24,18 +24,33 @@ static const char *check_feature_usage[] = {
 
 struct feature_status supported_features[] = {
 	FEATURE_STATUS("aio", HAVE_AIO_SUPPORT),
+	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
+	FEATURE_STATUS("backtrace", HAVE_BACKTRACE_SUPPORT),
 	FEATURE_STATUS("bpf", HAVE_LIBBPF_SUPPORT),
 	FEATURE_STATUS("bpf_skeletons", HAVE_BPF_SKEL),
 	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
-	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
+	FEATURE_STATUS("disassembler-four-args", DISASM_FOUR_ARGS_SIGNATURE),
+	FEATURE_STATUS("disassembler-init-styled", DISASM_INIT_STYLED),
+	FEATURE_STATUS("dwarf_getcfi", HAVE_DWARF_CFI_SUPPORT),
 	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
+	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
-	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
+	FEATURE_STATUS("eventfd", HAVE_EVENTFD_SUPPORT),
+	FEATURE_STATUS("file-handle", HAVE_FILE_HANDLE),
+	FEATURE_STATUS("get_current_dir_name", HAVE_GET_CURRENT_DIR_NAME),
+	FEATURE_STATUS("gettid", HAVE_GETTID),
+	FEATURE_STATUS("glibc", LIBC_SUPPORT),
+	FEATURE_STATUS("libaio", HAVE_AIO_SUPPORT),
 	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
+	FEATURE_STATUS("libbfd-buildid", HAVE_LIBBFD_BUILDID_SUPPORT),
 	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
+	FEATURE_STATUS("libcap", HAVE_LIBCAP_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
+	FEATURE_STATUS("libelf-gelf_getnote", HAVE_GELF_GETNOTE_SUPPORT),
+	FEATURE_STATUS("libelf-getphdrnum", HAVE_ELF_GETPHDRNUM_SUPPORT),
+	FEATURE_STATUS("libelf-getshdrstrndx", HAVE_ELF_GETSHDRSTRNDX_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
@@ -43,11 +58,20 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
 	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
+	FEATURE_STATUS("libslang-include-subdir", HAVE_SLANG_INCLUDE_SUBDIR),
 	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
 	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
+	FEATURE_STATUS("libzstd", HAVE_ZSTD_SUPPORT),
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_STATUS("pthread-attr-setaffinity-np", HAVE_PTHREAD_ATTR_SETAFFINITY_NP),
+	FEATURE_STATUS("pthread-barrier", HAVE_PTHREAD_BARRIER),
+	FEATURE_STATUS("scandirat", HAVE_SCANDIRAT_SUPPORT),
+	FEATURE_STATUS("sched_getcpu", HAVE_SCHED_GETCPU_SUPPORT),
+	FEATURE_STATUS("sdt", HAVE_SDT_EVENT),
+	FEATURE_STATUS("setns", HAVE_SETNS_SUPPORT),
 	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
+	FEATURE_STATUS("timerfd", HAVE_TIMERFD_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
 
-- 
2.45.2

