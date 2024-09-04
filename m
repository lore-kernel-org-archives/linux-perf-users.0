Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236E13B597
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476509; cv=none; b=jo6bGvSdRdD6ULYaskzqtfBa4LbkARwhHogIBODn9wRhfYHezVkleg0Lx1BAc9tXQkKCbHSaUsAmIufFAn0eyTNYHd7eDSSAtH9yLK4cI7ANF/n0uvVbFYv2Hsp1P/a7Gu+XCdSThtWSEHSBSghV4j7BKVFkD4AwsoaCTDuJgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476509; c=relaxed/simple;
	bh=SvLq0SmDu41CSdY8eLxhCUSompygr+oV3jlNUeRNaG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgkfYMrZtAJIzreskKb24qicXp5UehcoRXWs12lFzKSSP2vJ/ExhIp9PXodftTzwelx7KTlO1BM72npl1RqaQbBxuD5/DNGkRAiOt1PJVFQn6maiLl7NBD2y1AHvt9H0W1xZAbPRM9k5f5drPZaSXrUdgGBqjj6jsJFSAjCirSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VfdVK67Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VfdVK67Q"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484Imw3x024830;
	Wed, 4 Sep 2024 19:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=cL6Qa2dMm/vBdVnIR/5f+tWKthguBTAp3ZFX2vu
	JNCQ=; b=VfdVK67Q3iEMbptW8fwG1bhGCBFHnmENLMAt+vdTNJAjcBvtCBcUvfa
	7buLVmj0k8vxp73YEhevlrP1P1C0I/SW/2aWlYU4wZik5APwVvejowBdCzHViLIc
	cF7MFnUgdwM7V2LjOdGMBrIrttKmLjXxuNFVJYj1AejGOqffOy6s3tuurQlx9aTd
	uD68kCmfnHd9tqHdQaRcV8/KxelCby9MR8/mSlOldgIYpFzcvza5Yzv8jL3fxEP3
	MgLK81psYhZ3ReaGJS2v/FSe7r2MrBmfZOzeUsxu3AY/BgEvnXFPCnopfDK8X2QR
	wgHBNUUG+rMpm7R+An87zW+yz/YakdQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwb4tc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 484J1fe8019061;
	Wed, 4 Sep 2024 19:01:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwb4tc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 484GmA73012045;
	Wed, 4 Sep 2024 19:01:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegq15h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 484J1aHS55640434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 19:01:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A2E820043;
	Wed,  4 Sep 2024 19:01:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD4F20040;
	Wed,  4 Sep 2024 19:01:33 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.39.16.11])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 19:01:33 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v15 0/7] Introduce perf check subcommand
Date: Thu,  5 Sep 2024 00:31:25 +0530
Message-ID: <20240904190132.415212-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Eh_kOJVVsGnbbG90RGEjQrcJyH2Qwtv4
X-Proofpoint-GUID: 5uaJoR2V5ZcaQ9il8z7pfCMCRbQoFyx6
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
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040140

The Problem
===========

Currently the presence of a feature is checked with a combination of
perf version --build-options and greps, such as:

    perf version --build-options | grep " on .* HAVE_FEATURE"

This relies on the output of perf version, and is a common pattern in tests.

Proposed solution
=================

As suggested by contributors in:
https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/

Introduce a subcommand "perf check feature", with which
scripts can test for presence of a feature or multiple features, such as:

    perf check feature HAVE_LIBTRACEEVENT  (feature macro)

    or

    perf check feature libtraceevent       (feature name)

    or

    perf check feature LibTraceEvent       (case-insensitive)

    or

    perf check feature libtraceevent,bpf   (multiple features)

The usage of "perf version --build-options | grep" has been replaced in two
tests, with "perf check feature" command

Also, to not duplicate the same feature list at multiple places, a new global
'supported_features' array has been introduced in builtin.h, so both commands
'perf check feature' and 'perf version --build-options' use the same array

'supported_features' feature is an array of 'struct feature_support', which
also has the name of the feature, macro used to test it's presence, and a
is_builtin member, which will be 0 if feature not built-in, and 1 if built-in

Architectures Tested
====================
* x86_64
* ppc64le

Commands ran for testing (Fedora & RHEL):

    sudo dnf install -y libtraceevent-devel
    make clean
    make -j$(nproc)
    ./perf check feature libtraceevent,bpf; echo Return Code: $?
    ./perf check feature libtraceevent; echo Return Code: $?

    sudo ./perf test -v "task-analyzer"
    sudo ./perf test -v "probe libc's inet_pton & backtrace it with ping"
    sudo ./perf test -v "Use vfs_getname probe to get syscall args filenames"

    sudo dnf remove -y libtraceevent-devel
    make clean
    make NO_LIBTRACEEVENT=1 -j$(nproc)
    ./perf check feature libtraceevent,bpf; echo Return Code: $?
    ./perf check feature libtraceevent; echo Return Code: $?

    sudo ./perf test -v "task-analyzer"
    sudo ./perf test -v "probe libc's inet_pton & backtrace it with ping"
    sudo ./perf test -v "Use vfs_getname probe to get syscall args filenames"

Expected output of above commands (only the './perf check feature' command
outputs):
    ...
             libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
                       bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
    Return Code: 0
             libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
    Return Code: 0
    ...
             libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
                       bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
    Return Code: 1
             libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
    Return Code: 1

Git tree
========

Git tree with this patch series applied for testing:
https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v15

Changelog
=========

v15:
+ rebase on commit 98ad0b7 ("perf check: Introduce 'check' subcommand")
+ patch #1 and patch #2 are exactly same, as applied in perf-tools-next/tmp.perf-tools-next

v14:
+ rebase on commit 39c24341 ("perf sched timehist: Fixed timestamp ...")

v13:
+ patch #1: add fix for parse_options_subcommand not setting usage string
+ patch #2: if unknown feature name passed, print "please use 'perf version
  --build-options' to see which ones are available"
+ patch #6: fix inconsistency in feature names (dwarf-unwind-support & get_cpuid)
+ patch #7: add more features to feature_list

v12
+ patch #1: fix comment to mention argv[0] instead of argv[1]
+ patch #2: fix alignment

v11
+ patch #1: fix build error due to const *const instead of const*

v10
+ patch #1: use 'strdup' instead of 'malloc+memcpy'
+ patch #1: replace '-q' with '--quiet' in doc
+ patch #1: add usage for perf check

V9
+ make 'feature' a subcommand instead of an option
+ make feature name/macro check case-insensitive
+ rename 'FEATURE_SUPPORT' as 'FEATURE_STATUS'
+ rebase on upstream perf-tools-next

V8
+ handle return value of 'malloc' in patch #1
+ fix error due to strncpy depending on source string's length

V7
+ modified patch #1 to fix compile issue, and add feature to allow
  multiple comma-separated features

V6
+ rebased to perf-tools-next/perf-tools-next
+ modified patch #1 to include FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL)

V5
+ invert return value of 'has_support', but return value of perf check --feature
according to shell convention

V4
+ invert return value of perf check --feature

V3
+ simplified has_support code in builtin-check.c (patch #1)
+ modified patch #3 and patch #4 according to change in return value in patch #1

V2
+ improved the patch series with suggestions from Namhyung
+ fix incorrect return value, added -q option, and moved array definition to
  perf-check.c

V1
+ changed subcommand name to 'perf check --feature'
+ added documentation for perf check
+ support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
  input to 'perf check --feature'
+ change subject and descriptions of all patch mentioning perf check instead of
  perf build

V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/

Aditya Gupta (6):
  tools/lib/subcmd: Don't free the usage string
  perf check: Introduce 'check' subcommand
  perf version: Update --build-options to use 'supported_features' array
  tools/perf/tests: Update test_task_analyzer.sh to use perf check
    feature
  perf: Fix inconsistencies in feature names
  perf: Add more features to supported_features list

Athira Rajeev (1):
  tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
    feature

 tools/lib/subcmd/parse-options.c              |   8 +-
 tools/perf/Build                              |   1 +
 tools/perf/Documentation/perf-check.txt       | 106 +++++++++
 tools/perf/builtin-check.c                    | 205 ++++++++++++++++++
 tools/perf/builtin-kmem.c                     |   2 +
 tools/perf/builtin-kvm.c                      |   3 +
 tools/perf/builtin-kwork.c                    |   3 +
 tools/perf/builtin-lock.c                     |   3 +
 tools/perf/builtin-mem.c                      |   3 +
 tools/perf/builtin-sched.c                    |   3 +
 tools/perf/builtin-version.c                  |  43 +---
 tools/perf/builtin.h                          |  17 ++
 tools/perf/perf.c                             |   1 +
 .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
 .../shell/record+probe_libc_inet_pton.sh      |   5 +-
 .../shell/record+script_probe_vfs_getname.sh  |   5 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
 17 files changed, 370 insertions(+), 46 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/builtin-check.c

--
2.45.2

