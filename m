Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670C2E419
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293779; cv=none; b=QTabJHOwNaWmmxHu7M4cJr+lY2vjUFmmZaDua4m+uA8w44bNSCwfcHYreR3bI7AL+aIEwUOMjTkroyDxk/JNkCxu4ZTJDDPpj/zqiBT75SBiVL8/hcINsrrqvUO9/HX9QVJ1UhyWmv/5QGDnNzhc9Dx0gwBuRsmPQmauZGxM1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293779; c=relaxed/simple;
	bh=INIkG0ufyz8CKpmn7DnE8MBsmrOX/X7R7q1ZZaCACqU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WE9yvK9t/lT09tg+2omz5bDTbQu85y5Ny9WJpdo1qqo/sQ/nBGwvVBIeI9TWUZ7XR7cLuQ/n3O0NE+xQsI7byv7Y4/GiXxI+7aNWMqWKdPdwPt/bv+YbyL2/twogxb17mVxSF5ZwRL4R7603iyCRE8BzUy9mHuBr+XTQk7hh/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a+dtMmKn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a+dtMmKn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8vK8g018601;
	Thu, 18 Jul 2024 09:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	hRHIND4JQcaEy6bCrs22mVeM23CGv8gX0LzY5vg+Z7Q=; b=a+dtMmKnHVKQvDKI
	qSQP2WH4AEnTTFSVwsdRdwy14onu6u7Ab9GshLp9ShUk9+CXkekQT9oa0BVH5+35
	RGOBOyOy1fzuKGKq1Mg5Fq2BUrpb+DlCXZutXyIyFjDiJAdX48y4RCbhoMd6Vi0S
	nvhArlLp04Aa3AdaLzoLgv1HFUXD21YIES1qEwjXqvAHLKdLg64BPAnF0ox+rUTy
	ZONAn3g1J16xrtLLgJQxwFJfQP4B4bpfgJv1rRJLDYFPm6mkBs48mLtQgCO34Y/i
	tYWYkKFUpvZWB7/LK1NhZ/Hqhetm6KbTcm7AMo/aOaF5Z3G4hxjkx3Lr67tJAptp
	6mR2dQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40evxe0f0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:09:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I99YYL004579;
	Thu, 18 Jul 2024 09:09:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40evxe0f0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:09:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I8sKkR006082;
	Thu, 18 Jul 2024 09:09:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmgume-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:09:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I99Sjk27656810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:09:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F0D12004B;
	Thu, 18 Jul 2024 09:09:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E642820043;
	Thu, 18 Jul 2024 09:09:25 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 09:09:25 +0000 (GMT)
Message-ID: <b1d59ea7-dc82-4bd6-8f11-fd35282a4fed@linux.ibm.com>
Date: Thu, 18 Jul 2024 14:39:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/7] Introduce perf check subcommand
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240718085957.550858-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240718085957.550858-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fPihDqdMkxFg-j9Xm4XioMOo4f8Tyj1V
X-Proofpoint-ORIG-GUID: uByJxdNMkArdoHSwTo2iCQGNDJk5pe2C
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

Linux-ci build test results for all patches (all green, except some 
g5_defconfig in kernel+qemu, which is red irrespective of this series):  
https://github.com/adi-g15-ibm/linux-ci/actions


Thanks,

Aditya Gupta


On 18/07/24 14:29, Aditya Gupta wrote:
> The Problem
> ===========
>
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
>
>      perf version --build-options | grep " on .* HAVE_FEATURE"
>
> This relies on the output of perf version, and is a common pattern in tests.
>
> Proposed solution
> =================
>
> As suggested by contributors in:
> https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
>
> Introduce a subcommand "perf check feature", with which
> scripts can test for presence of a feature or multiple features, such as:
>
>      perf check feature HAVE_LIBTRACEEVENT  (feature macro)
>
>      or
>
>      perf check feature libtraceevent       (feature name)
>
>      or
>
>      perf check feature LibTraceEvent       (case-insensitive)
>
>      or
>
>      perf check feature libtraceevent,bpf   (multiple features)
>
> The usage of "perf version --build-options | grep" has been replaced in two
> tests, with "perf check feature" command
>
> Also, to not duplicate the same feature list at multiple places, a new global
> 'supported_features' array has been introduced in builtin.h, so both commands
> 'perf check feature' and 'perf version --build-options' use the same array
>
> 'supported_features' feature is an array of 'struct feature_support', which
> also has the name of the feature, macro used to test it's presence, and a
> is_builtin member, which will be 0 if feature not built-in, and 1 if built-in
>
> Architectures Tested
> ====================
> * x86_64
> * ppc64le
>
> Commands ran for testing (Fedora & RHEL):
>
>      sudo dnf install -y libtraceevent-devel
>      make clean
>      make -j$(nproc)
>      ./perf check feature libtraceevent,bpf; echo Return Code: $?
>      ./perf check feature libtraceevent; echo Return Code: $?
>      
>      sudo ./perf test -v "task-analyzer"
>      sudo ./perf test -v "probe libc's inet_pton & backtrace it with ping"
>      sudo ./perf test -v "Use vfs_getname probe to get syscall args filenames"
>      
>      sudo dnf remove -y libtraceevent-devel
>      make clean
>      make NO_LIBTRACEEVENT=1 -j$(nproc)
>      ./perf check feature libtraceevent,bpf; echo Return Code: $?
>      ./perf check feature libtraceevent; echo Return Code: $?
>      
>      sudo ./perf test -v "task-analyzer"
>      sudo ./perf test -v "probe libc's inet_pton & backtrace it with ping"
>      sudo ./perf test -v "Use vfs_getname probe to get syscall args filenames"
>
> Git tree
> ========
>
> Git tree with this patch series applied for testing:
> https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v13
>
> Changelog
> =========
>
> v13:
> + patch #1: add fix for parse_options_subcommand not setting usage string
> + patch #2: if unknown feature name passed, print "please use 'perf version
>    --build-options' to see which ones are available"
> + patch #6: fix inconsistency in feature names (dwarf-unwind-support & get_cpuid)
> + patch #7: add more features to feature_list
>
> v12
> + patch #1: fix comment to mention argv[0] instead of argv[1]
> + patch #2: fix alignment
>
> v11
> + patch #1: fix build error due to const *const instead of const*
>
> v10
> + patch #1: use 'strdup' instead of 'malloc+memcpy'
> + patch #1: replace '-q' with '--quiet' in doc
> + patch #1: add usage for perf check
>
> V9
> + make 'feature' a subcommand instead of an option
> + make feature name/macro check case-insensitive
> + rename 'FEATURE_SUPPORT' as 'FEATURE_STATUS'
> + rebase on upstream perf-tools-next
>
> V8
> + handle return value of 'malloc' in patch #1
> + fix error due to strncpy depending on source string's length
>
> V7
> + modified patch #1 to fix compile issue, and add feature to allow
>    multiple comma-separated features
>
> V6
> + rebased to perf-tools-next/perf-tools-next
> + modified patch #1 to include FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL)
>
> V5
> + invert return value of 'has_support', but return value of perf check --feature
> according to shell convention
>
> V4
> + invert return value of perf check --feature
>
> V3
> + simplified has_support code in builtin-check.c (patch #1)
> + modified patch #3 and patch #4 according to change in return value in patch #1
>
> V2
> + improved the patch series with suggestions from Namhyung
> + fix incorrect return value, added -q option, and moved array definition to
>    perf-check.c
>
> V1
> + changed subcommand name to 'perf check --feature'
> + added documentation for perf check
> + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
>    input to 'perf check --feature'
> + change subject and descriptions of all patch mentioning perf check instead of
>    perf build
>
> V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
>
> Aditya Gupta (6):
>    tools/lib/subcmd: Don't free the usage string
>    perf check: Introduce 'check' subcommand
>    perf version: Update --build-options to use 'supported_features' array
>    tools/perf/tests: Update test_task_analyzer.sh to use perf check
>      feature
>    perf: Fix inconsistencies in feature names
>    perf: Add more features to supported_features list
>
> Athira Rajeev (1):
>    tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
>      feature
>
>   tools/lib/subcmd/parse-options.c              |   8 +-
>   tools/perf/Build                              |   1 +
>   tools/perf/Documentation/perf-check.txt       | 106 +++++++++
>   tools/perf/builtin-check.c                    | 205 ++++++++++++++++++
>   tools/perf/builtin-kmem.c                     |   2 +
>   tools/perf/builtin-kvm.c                      |   3 +
>   tools/perf/builtin-kwork.c                    |   3 +
>   tools/perf/builtin-lock.c                     |   3 +
>   tools/perf/builtin-mem.c                      |   3 +
>   tools/perf/builtin-sched.c                    |   3 +
>   tools/perf/builtin-version.c                  |  43 +---
>   tools/perf/builtin.h                          |  17 ++
>   tools/perf/perf.c                             |   1 +
>   .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
>   .../shell/record+probe_libc_inet_pton.sh      |   5 +-
>   .../shell/record+script_probe_vfs_getname.sh  |   5 +-
>   tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
>   17 files changed, 370 insertions(+), 46 deletions(-)
>   create mode 100644 tools/perf/Documentation/perf-check.txt
>   create mode 100644 tools/perf/builtin-check.c
>
