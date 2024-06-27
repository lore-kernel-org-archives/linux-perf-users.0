Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0236137757
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479507; cv=none; b=bLT0reO760BjrEI5TEaPCpdpUzhYf1ESbkoYqwE5GZfmWMoA2BzmXFgxBT0If3JSUTcba3sqGUkvwe6b/mxTJDoIgWanYxV44eEcFZqY2v7CDRnBcBfEcJwRklDC3GhcsClziHyZjwy2EMOcCstnt/2WcIZ1cWIKXBoi9qZgsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479507; c=relaxed/simple;
	bh=EWb2Db7FE7BwtHudPs8CJxgjdMgPpNaQyqHVrUvNovc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oZqeVBW8XxIRjSyUEpRAMfBj+rlFhsoCFHhPQZk3t5QWTaePmAC+XNpKgIbfGCjQ7LxbnlCsBmHVj2NbMjN4vEAkED/61iKgIHtZbUsRJP79C9F9kMonPgSO1pobU+i5ZxX40DbrgxZn+Gb8wwEOIcmwMYPVoHIfsBqdsXrOHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UYEA2io0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UYEA2io0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R8qJa1001246;
	Thu, 27 Jun 2024 09:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	ZjiZDbUdJ9absvk3vIaIlwt8lZ6QPJq3qyCFODGF41Y=; b=UYEA2io0m/e0ZWve
	4HhaQz8tPz0TqYMdjV4uuR9d2cC6wBWgd6LnMPXbcztH8nll9P08Qm1UpXmfE1pO
	6S4nAAO9fiwJnbRXavutLTfDNfBKN4xYIPvpPeaUjNM1nz8kKRS4SSMufUcIH/M5
	DMQO/J5rMn0vnFGBysOA7PB21nzy+hNuLvIxYYzSduhQoNFy6jqQoOmysaMsX5zG
	VFnXmOYcsFFYU5YVL6EKFBD5THsmWhqVExn6NZE5p7IjsZFMqiPrlG1+uq9Hevd6
	HKN0ejUV5mGD1s6inKhAOeb0l+gemqL4RoAnyA2fVVBW3HOaNHouHpMSoo0c9q8f
	540VMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4014ks83hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:11:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45R9As4m001920;
	Thu, 27 Jun 2024 09:11:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4014ks83hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:11:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R7BB4U018132;
	Thu, 27 Jun 2024 09:11:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xuj5ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:11:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R9BaCs43123096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:11:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 488662004D;
	Thu, 27 Jun 2024 09:11:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F250F20040;
	Thu, 27 Jun 2024 09:11:35 +0000 (GMT)
Received: from [9.152.212.23] (unknown [9.152.212.23])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:11:35 +0000 (GMT)
Message-ID: <cfe80846-69de-4d19-a4be-10fa27ee057d@linux.ibm.com>
Date: Thu, 27 Jun 2024 11:11:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] Introduce perf check subcommand
To: Aditya Gupta <adityag@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240626131638.597544-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20240626131638.597544-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mWOZr7ja3C8wo_oo2RilUQAB7uWlI1qm
X-Proofpoint-ORIG-GUID: t2QvlWUcGjv0oLJUnWz2ikYqI-Ash7Oh
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
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

On 6/26/24 15:16, Aditya Gupta wrote:
> The Problem
> ===========
> 
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
> 
>     perf version --build-options | grep " on .* HAVE_FEATURE"
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
>     perf check feature HAVE_LIBTRACEEVENT  (feature macro)
> 
>     or
> 
>     perf check feature libtraceevent       (feature name)
> 
>     or
> 
>     perf check feature LibTraceEvent       (case-insensitive)
> 
>     or
> 
>     perf check feature libtraceevent,bpf   (multiple features)
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
>     sudo dnf install -y libtraceevent-devel
>     make clean
>     make -j$(nproc)
>     ./perf check feature libtraceevent,bpf; echo Return Code: $?
>     ./perf check feature libtraceevent; echo Return Code: $?
>     
>     sudo ./perf test -v "task-analyzer"
>     sudo ./perf test -v "probe libc's inet_pton & backtrace it with ping"
>     sudo ./perf test -v "Use vfs_getname probe to get syscall args filenames"
>     
>     sudo dnf remove -y libtraceevent-devel
>     make clean
>     make NO_LIBTRACEEVENT=1 -j$(nproc)
>     ./perf check feature libtraceevent,bpf; echo Return Code: $?
>     ./perf check feature libtraceevent; echo Return Code: $?
>     
>     sudo ./perf test -v "task-analyzer"
>     sudo ./perf test -v "probe libc's inet_pton & backtrace it with ping"
>     sudo ./perf test -v "Use vfs_getname probe to get syscall args filenames"
> 
> Git tree
> ========
> 
> Git tree with this patch series applied for testing:
> https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v10
> 
> Changelog
> =========
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
>   multiple comma-separated features
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
>   perf-check.c
> 
> V1
> + changed subcommand name to 'perf check --feature'
> + added documentation for perf check
> + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
>   input to 'perf check --feature'
> + change subject and descriptions of all patch mentioning perf check instead of
>   perf build
> 
> V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
> 
> Aditya Gupta (3):
>   perf check: introduce check subcommand
>   perf version: update --build-options to use 'supported_features' array
>   perf tests task_analyzer: use perf check for libtraceevent support
> 
> Athira Rajeev (1):
>   tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
>     feature
> 
>  tools/perf/Build                              |   1 +
>  tools/perf/Documentation/perf-check.txt       |  79 ++++++++
>  tools/perf/builtin-check.c                    | 179 ++++++++++++++++++
>  tools/perf/builtin-version.c                  |  43 +----
>  tools/perf/builtin.h                          |  17 ++
>  tools/perf/perf.c                             |   1 +
>  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
>  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
>  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
>  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
>  10 files changed, 297 insertions(+), 41 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-check.txt
>  create mode 100644 tools/perf/builtin-check.c
> 

I have a running linux-next kernel on fedora 40.
I applied your patches onto linux-next head and got these results:

 # git am ~/gupta1.patch
 Applying: perf check: introduce check subcommand
 .git/rebase-apply/patch:110: new blank line at EOF.
 +
 warning: 1 line adds whitespace errors.
 # git am ~/gupta2.patch

The other patches apply cleanly.
The compile of perf fails with this error:
 # make
 ...
 builtin-check.c: In function ‘cmd_check’:
 builtin-check.c:167:44: error: passing argument 5 of
       ‘parse_options_subcommand’ discards ‘const’ qualifier
       from pointer target type [-Werror=discarded-qualifiers]
  167 |                         check_subcommands, check_usage, 0);
      |                                            ^~~~~~~~~~~
 In file included from builtin-check.c:10:
 /root/mirror-linux-next/tools/perf/libsubcmd/include/subcmd/
       parse-options.h:180:45: note: expected ‘const char **’
       but argument is of type ‘const char * const*’
  180 |                                 const char *usagestr[], int flags);
      |                                 ~~~~~~~~~~~~^~~~~~~~~~
  CC      builtin-timechart.o
  CC      builtin-sched.o
 cc1: all warnings being treated as errors
 make[3]: *** [/root/mirror-linux-next/tools/build/Makefile.build:106: builtin-check.o] Error 1
 make[3]: *** Waiting for unfinished jobs....
 make[2]: *** [Makefile.perf:728: perf-in.o] Error 2
 make[1]: *** [Makefile.perf:265: sub-make] Error 2
 make: *** [Makefile:70: all] Error 2
 #

Hope this helps...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

