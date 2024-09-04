Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C513213C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476527; cv=none; b=Le6Kn4P8dTYFwNFhBPQAbn06QZAo+7qa4tERKdWauGf3eozJdQDJimhWbTSj/Fx3hQh7ev1Xzi4Y9WO4HmpgwAaLFAukIdK8a+lxf/iPSH8tlzUrBW06wK3KZVk9CLg8Vok3Nm6wEAAVh0suMMDx518dg3f7sS8ciWEW+qb2TNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476527; c=relaxed/simple;
	bh=bdyt3PneFo9C+MvhU2aYmtNQE/pWN8zMHVw6xeaJnjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svFKbPae4vgPPyJW0MMn1tTQWE/Ywk1bCIuElb7z+ndqE6CCOPaLTK/SyTRlDFa5PC7RSaFRSSov5eBIRn+BY9GPPskIcY5AHkum0OSn16CmB51dr6OCvKKIXjqiPlpicKHKwOlgoB/66QQlpu9uPKs1Bd0Ch6cGYatARgf4lPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HGNLMUWo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HGNLMUWo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484Gl0Dm018129;
	Wed, 4 Sep 2024 19:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=jRPwZyijW8pnT
	4nJp7cW5RK5TLWwEiVWPKkEI4uR3Mw=; b=HGNLMUWozvGW/1EDqlS78xZKhVWLd
	u7c3YCIqBepbXshYUHSr87+jjQL3fDuzvWmuwGkS/ottpq2wJOfpOa6eu26YkHvs
	8s1ECYNo1iVKhVI5mrihYQVlT7HK8KoJa/gTGMoGQD+wvmTVxMpbZNdrW7HH74eW
	f5d51dlO75+pnVXBsI33WR+c5ONx9IXxTfq0JXNapiWG+/xdjbcfmShMaWebrfUw
	1AV6zpLuP4TUViyzWxX3JtzHOHKmsE/S8oFObF+wo4uhnSFWCyeGMyabD4TMhZMx
	Tma3uhbO8Voc6bXhQbZzowg/+N3z3+GxKVXfzKjTe4iproS5LYcifGAXg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9mttv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:02:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 484J22jV007285;
	Wed, 4 Sep 2024 19:02:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9mttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:02:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 484H9QNr001015;
	Wed, 4 Sep 2024 19:02:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cf0n12gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:02:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 484J1vXf52691334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 19:01:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05292004B;
	Wed,  4 Sep 2024 19:01:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40FEA20040;
	Wed,  4 Sep 2024 19:01:54 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.39.16.11])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 19:01:54 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v15 7/7] perf: Add more features to supported_features list
Date: Thu,  5 Sep 2024 00:31:32 +0530
Message-ID: <20240904190132.415212-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904190132.415212-1-adityag@linux.ibm.com>
References: <20240904190132.415212-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lRr5MEGyMdjwiqVRMmHencBZaI985XcM
X-Proofpoint-ORIG-GUID: YTLRp7v0zvm_Nvu8ds9YOfPWVAX4UV4M
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
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040140

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
 tools/perf/builtin-check.c              | 29 ++++++++-
 2 files changed, 78 insertions(+), 29 deletions(-)

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
index 0b76b6e42b78..fbd1a14411c8 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -24,30 +24,55 @@ static const char *check_feature_usage[] = {
 
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
+	FEATURE_STATUS("libllvm", HAVE_LIBLLVM_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
 	FEATURE_STATUS("libperl", HAVE_LIBPERL_SUPPORT),
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

