Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3712E1E9
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430746; cv=none; b=nviMuVVDqAp4Nc6casyiIndpMytyGv7BAPHi5KuhkrCCgCNt9zZjBNb6m1wP88477EF5qchVAf7t0kb6sq3AKohDOkJIjStXY1XUQw6bKOpdVwcxmOvaKkoNuGjprZ49PivxhpAqRxjgm3qgIoWgQ3Nuze4rkfS8LEQqkqkuIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430746; c=relaxed/simple;
	bh=JOedGhWsEYstzKVArZi0KrfJc5FstmXT16iojG2UrdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6Zk/XOuVPyf4375TFpDCnAIBsPW3rvX3bomMW2DPJ8NzplqeppOslBDsaG9d8+jI6sT/0sGwVDf1vylpGTOvQCr5T0eqxFNXrGfoxGbn/yqhY2XwCngVtRQ7vsObz5GVY7vz9akk8pKRgBYO12kdsHIJZbiYqux8uYujnd7FQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tm898geV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tm898geV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4844kmU6019529;
	Wed, 4 Sep 2024 06:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=Eu07D+/00fTD2
	E5ijCDuKZF9HDVW5D7YVN6EIaZLVI4=; b=tm898geVwPaQYbgJf7ndj02KEn87l
	CrvtJqkTmjuLgqjulhPbvXdqUls7cMHb0S4cDgSF5X44VHB1dDg5O71FmiFtrc5/
	jjLVDjfGi41qsbxbesERpolZx65eApdDBFTfI0fPJdWQsQqEbX3dqjXzuNxRSzhp
	bUrQDjtXGIX3Ro7tQUXpG4u4cdj8VpSzCezhIAgytAQ2nCrFptSRW84T4NwLcs/y
	idkAc5kXD5zf4/SD1VGI3byP2+shE6PclhGDwDJPDp6bJLhM5Nl/459cXLLgf9Cp
	ynQw9Jhg4WLknyv041xnFfVzBNn0+TJafDFsyWMTzfB73iCObDXNgafPg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bttyhfrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:19:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4846J1A5005281;
	Wed, 4 Sep 2024 06:19:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bttyhfre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:19:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4844a0mf018448;
	Wed, 4 Sep 2024 06:19:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw16fxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:19:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846Iu2r47448426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:18:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF33820049;
	Wed,  4 Sep 2024 06:18:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9972220040;
	Wed,  4 Sep 2024 06:18:54 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.38])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 06:18:54 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v14 7/7] perf: Add more features to supported_features list
Date: Wed,  4 Sep 2024 11:48:36 +0530
Message-ID: <20240904061836.55873-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904061836.55873-1-adityag@linux.ibm.com>
References: <20240904061836.55873-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OLUEuo54cAi629qqqazsMplxGf7SFCzk
X-Proofpoint-ORIG-GUID: 9898H223DJPTQ857872ynoraSxifGvSB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040045

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
2.46.0

