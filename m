Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7376035
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293215; cv=none; b=L5EjlXYkH8p2GMFLjv5h/jkNoMTP9AESBhcJOaEKKY1HkIyk9h2RLT++oTHSzJKNiAOd46JTYwdzGs+lYsApbD8mZHLXpsqIoNZPBa1bRzuB/UFu5NGLQbfQLt9g7d0l29XFbjqbF2EpuLk0PgkT7iT5AbO1XLP3fqPIoCVJfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293215; c=relaxed/simple;
	bh=CI7jeRvX6SK1dwalsKtdVuoDH+heSAfIiExOaqXCjN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7V7y6p/eMUcLAmZXGQIKrfAF43g8z0QRLFigTg0GofGXajJxov9eblzBDEahsAT7n+KC9c7n6VKYwR5woaBk4bNfqv4eBTSk8r35c1cx9gZepLNbUnit/xebw0VJsd5MVGdk2O3ig/GCe2W1KA3HBUcZg0xWvvre9ogLFG1cQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nj9VsnKv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nj9VsnKv"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I7uZk1003060;
	Thu, 18 Jul 2024 09:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=k7V1gn1JU959AHlT0XkxlxGt2lX0D3zKfue0nlH
	6Xds=; b=nj9VsnKvKMGQ4gUYxSjxinkAkZGMY5jiztzBIMhgd73cCk0Dapo63n/
	sm4pEbJHXcAlH8H9ZWuWZ+9WvdC/+MDbuo47D0xOSbyxCCCSjBJaH9/BWMyeDJPf
	A2KU38AUxq3T3yfeAHVb7COW2Gi0iW9oZOUF8ahKiInKC3QBdUW/dTgAFuyTvDvs
	DdlPJaZNmOTjoiGFJmFAL4fMXDk6M4C5P6T6yHpG+IShCXyOzpqCcDbhusAGb1rF
	RfZ4IG/sAE42NggL6r1y1399GAFfLOxC1XX5zTYtmXKYP2CPUlGUkeatt1NfSHfI
	BSRvIJT38jlfmO4tK5uClDND1lWXEaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expu05y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:09 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I909fM003319;
	Thu, 18 Jul 2024 09:00:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expu05y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I55cH8028822;
	Thu, 18 Jul 2024 09:00:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkn0sku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I901Ww31851152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:00:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41CE020040;
	Thu, 18 Jul 2024 09:00:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D11FD20043;
	Thu, 18 Jul 2024 08:59:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 08:59:58 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v13 0/7] Introduce perf check subcommand
Date: Thu, 18 Jul 2024 14:29:50 +0530
Message-ID: <20240718085957.550858-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TeFoLCQqvwQl0Ld8rQN46YVmdVv9JNEn
X-Proofpoint-ORIG-GUID: 6BO8qvjRMfdc4FVOUEHpZsIyBAVjChuA
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180056

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

Git tree
========

Git tree with this patch series applied for testing:
https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v13

Changelog
=========

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

