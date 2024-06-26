Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0C184117
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407820; cv=none; b=u2GsD2L1ma/ob93I65m0vQg+zL3FtiGnOkXzSipVg8tI99JRBohcTv+6sCIboS539VsUDeLbJpFpKi9/XT5td/rDvOjtQLZ/KOIBspLuD0FiU2Wf/8iRzWlm9wzV1iOIelTD1bIx1BwDAvVa4uweWHuCV/4eyJcL7jX1MiVYgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407820; c=relaxed/simple;
	bh=tja9k/RJ+QBxYLlMwHBKGZWpn+7DRcoKA721o1rzeNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HD7AWO5ddiBrDE0jZrlDJULVWIMCFbyrIZC9QFYim5zA/K0glrwVZgvzRYsZpDnMu4lvqkrKtHEsi/LJBI4rSy4MbIT30Qr6IusDSZQnoLo2Hc/6o81kCt0h+pZ69z6bVsJmZ+o+ygwwOsIhahCBm2D5VsIkJkaCtKvat/CcZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DaCa/335; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DaCa/335"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QCSaPS032167;
	Wed, 26 Jun 2024 13:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=6TcYDp/Shlcq2IH1xmGLZ27qrEpn0wpcStwDjeU
	Umuo=; b=DaCa/335PjC/g+4OSG+LT3S0GKRYDl20cR+lljTLDZWFZkF6vmH1GSZ
	vUVOSLBdJ2284c/RUrFdEVbbmHqUMIkbQ5iLevhCoNeCU7RxTOpZMKIqzrIlNS6p
	gpGkAqsZErExKvbhpFtWng5vqJcCa9s9tzVwkpZ1dNUBSdUA6ob+rKGUiivc9uuF
	rrpSzCpWciIuynBNlqEFZBtVYzP8LR10/Ep5yFFBsA1IpU7eS2Sa70nbKu+rEA3l
	9gVBb8dX3MqGO4MYETVgABlbKb2J/xxoCVpuJOocFD7+126pUe0CIzPokxIPGUgf
	Pp5tAZPs3N3LU1LuxmsMD1u77YEG03w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400k15049d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QDGmfi008950;
	Wed, 26 Jun 2024 13:16:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400k15049b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45QBrbYW000564;
	Wed, 26 Jun 2024 13:16:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaen4enr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QDGfKH45285774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:16:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9836520043;
	Wed, 26 Jun 2024 13:16:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7898620040;
	Wed, 26 Jun 2024 13:16:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.124.217.114])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 13:16:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v10 0/4] Introduce perf check subcommand
Date: Wed, 26 Jun 2024 18:46:34 +0530
Message-ID: <20240626131638.597544-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fNrXkv3SRpGJepOEtU7snovt8B7n-B8S
X-Proofpoint-ORIG-GUID: cQNZAqT1NuBMm3HOpIR_daeQGT09oceo
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
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260096

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
https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v10

Changelog
=========

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

Aditya Gupta (3):
  perf check: introduce check subcommand
  perf version: update --build-options to use 'supported_features' array
  perf tests task_analyzer: use perf check for libtraceevent support

Athira Rajeev (1):
  tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
    feature

 tools/perf/Build                              |   1 +
 tools/perf/Documentation/perf-check.txt       |  79 ++++++++
 tools/perf/builtin-check.c                    | 179 ++++++++++++++++++
 tools/perf/builtin-version.c                  |  43 +----
 tools/perf/builtin.h                          |  17 ++
 tools/perf/perf.c                             |   1 +
 .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
 .../shell/record+probe_libc_inet_pton.sh      |   5 +-
 .../shell/record+script_probe_vfs_getname.sh  |   5 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
 10 files changed, 297 insertions(+), 41 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/builtin-check.c

-- 
2.45.2

