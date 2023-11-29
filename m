Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J2w6yZ9z"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552210F4
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 23:12:30 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6vbBS017046;
	Wed, 29 Nov 2023 07:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ND3zCKRtF1M7vKuXY9Z+vZqCiWiX1NGkrEDe3bFFzgk=;
 b=J2w6yZ9zueCgKiOPx+n5Ob8HBeO4TBDy7zKaKzqn+g3xKJxkFDbHO9jn2TkYeG5wfYNx
 277A6ctv0vRXyoMpD51RPSEUimxClqM5oMUv2U42j14k3qV4K4fJis+pBw4iv1ARjxAk
 S/iKH3Opk3/L0WaOYPvSql4B/3nyEGGl7XgIpo+oMbp/1SB2G7+rUBxpDtYhS9dyn4qM
 u3Sr0IDEDy/a/kok2iVswkgTrmqS5ugoJvl93bt5rXCuf+IyDXzYlenLKnWPG3Qo9qhC
 a//TniDxgWkLj/9g3HIaisXlJ89LL3VaJNqrJZe/wwAsgNxWFgSYRkCBrwDscwXGR1Du 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up0fx8s33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 07:12:26 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT6xuWD024342;
	Wed, 29 Nov 2023 07:11:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up0fx8rcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 07:11:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5VaS1004934;
	Wed, 29 Nov 2023 07:09:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk59xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 07:09:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT79nN935455358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 07:09:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80B8920043;
	Wed, 29 Nov 2023 07:09:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28E8420040;
	Wed, 29 Nov 2023 07:09:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 07:09:46 +0000 (GMT)
Date: Wed, 29 Nov 2023 12:39:43 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v7 0/4] Introduce perf check subcommand
Message-ID: <ebgef776v5uvigu2mqkj5mba36cewrhrxzo63fbczrcvyqexlt@nebkf5roy2gv>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116213435.382484-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q3h8bQNlGccofSVepOaZVSg3VgG3L3Ha
X-Proofpoint-ORIG-GUID: Ijygu9Gdwbo_nM5rtrBP9oEIt00Wx-he
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_04,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290051

Hi Arnaldo,
Can we get this moving if the series looks good ?

Thanks,
Aditya Gupta

On Fri, Nov 17, 2023 at 03:04:31AM +0530, Aditya Gupta wrote:
> The Problem
> ===========
> 
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
> 
>     perf version --build-options | grep " on .* HAVE_FEATURE"
> 
> Proposed solution
> =================
> 
> As suggested by contributors in:
> https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> 
> Introduce a subcommand "perf check --feature", with which
> scripts can test for presence of a feature or multiple features, such as:
> 
>     perf check --feature HAVE_LIBTRACEEVENT
> 
>     or
> 
>     perf check --feature libtraceevent
> 
>     or
> 
>     perf check --feature libtraceevent,libbpf_support
> 
> The usage of "perf version --build-options | grep" has been replaced in two
> tests, with "perf check --feature" command
> 
> Also, to not duplicate the same feature list at multiple places, a new global
> 'supported_features' array has been introduced in builtin.h, so both commands
> 'perf check --feature' and 'perf version --build-options' use the same array
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
> Git tree
> ========
> 
> Git tree with this patch series applied for testing:
> https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v7
> 
> Changelog
> =========
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
>     --feature
> 
>  tools/perf/Build                              |   1 +
>  tools/perf/Documentation/perf-check.txt       |  59 +++++++++
>  tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
>  tools/perf/builtin-version.c                  |  39 ++----
>  tools/perf/builtin.h                          |  18 +++
>  tools/perf/perf.c                             |   1 +
>  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
>  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
>  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
>  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
>  10 files changed, 221 insertions(+), 37 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-check.txt
>  create mode 100644 tools/perf/builtin-check.c
> 
> -- 
> 2.41.0
> 
