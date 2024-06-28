Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F1D299
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556978; cv=none; b=c4dmncVquF5+Z2oYFu5QUkqah6YSfUh5PPbu07MwrvPx6p5m+eYYgsEjffARrdvn1m/rSKs+wNyEydK5/h25ElIx6dOXacPAidGEL8dauovEcwa4RzFM2igNMcUXmy920WmApV+2CmLLcm2GxJjfMikb7Z69easIOddPqIwrWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556978; c=relaxed/simple;
	bh=IHj5Ny5nKFYEiZa+dfyJWq6i13mnjTfCJXvlDAEvIK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaUEbBMB1QllziwIt0z+0CymC/QYmebjGz+bK21SzNtlzOeijpgG7nM17grKqCnv2txF//5yQjE4Q9aP6WDd8aC9tzLqxpu3OlCmHSYnWj8HiSm58Kn07MDGYZfgkOtA0ST/+xbRO9vC+jf3k6Zt26mcH/TTYosF88tgmrt5auY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=URKigs1Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="URKigs1Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S6RMnM016255;
	Fri, 28 Jun 2024 06:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=QNWyRAnDDkEo4iDMDz63e9vCFYFGvzmG2VxLSEu
	xEmo=; b=URKigs1YVm0N2S7BE9hZzNJ9Ux693P7YVn7zNP/jAyYxEjwbutvxQ02
	oGc68EwsRFaRnp5te6GynlMKV+DnoMj9VNVX/+W0TI1HeC+PHjD1n55M7sUZ2ps/
	MU1+rLcs6OYYd7WmY1erLfM5dn3/A+S9x5iTVbx/U87vw/5yewAVY91Lco1SqQQa
	YWJjqF0glW0LsaHytXNDorKR0AoGSQJ0s8B0wdoTGLFNybTlSo3xaORwCNnSz/hj
	/29eLXEA0F5uy7OuZ2JitqUEP6U4KQapqWH29A4/r8bvisI6jiI5iUc9ohyDnVBJ
	FwvqzS6Ku/13Z3PQ4InU7N2UEnCWLrQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qgb82tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:42:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S6gpG1006270;
	Fri, 28 Jun 2024 06:42:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qgb82tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:42:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S6IFLi000606;
	Fri, 28 Jun 2024 06:42:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaenewru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:42:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S6giFe47710708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 06:42:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC22D20043;
	Fri, 28 Jun 2024 06:42:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0141A20040;
	Fri, 28 Jun 2024 06:42:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.195.36.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 06:42:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v12 0/4] Introduce perf check subcommand
Date: Fri, 28 Jun 2024 12:12:32 +0530
Message-ID: <20240628064236.1123851-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VAZlQqjEVKM8hju7RWAx9QJvsG7e1_We
X-Proofpoint-GUID: 17hM21VOUGNsGF-Q3Qyq4kHyXlgamvie
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
 definitions=2024-06-28_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280045

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
https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v12

Changelog
=========

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


*** BLURB HERE ***

Aditya Gupta (3):
  perf check: introduce check subcommand
  perf version: update --build-options to use 'supported_features' array
  perf tests task_analyzer: use perf check for libtraceevent support

Athira Rajeev (1):
  tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
    feature

 tools/perf/Build                              |   1 +
 tools/perf/Documentation/perf-check.txt       |  79 ++++++++
 tools/perf/builtin-check.c                    | 178 ++++++++++++++++++
 tools/perf/builtin-version.c                  |  43 +----
 tools/perf/builtin.h                          |  17 ++
 tools/perf/perf.c                             |   1 +
 .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
 .../shell/record+probe_libc_inet_pton.sh      |   5 +-
 .../shell/record+script_probe_vfs_getname.sh  |   5 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
 10 files changed, 296 insertions(+), 41 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/builtin-check.c

-- 
2.45.2

