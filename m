Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B323DB
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lvQN0CyR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E033D47
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Nov 2023 19:43:13 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A73e1xE029758;
	Tue, 7 Nov 2023 03:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=isFABIWqCaa+mfdU5DHOkW7jYUHm49RapwvNrrUPvDs=;
 b=lvQN0CyRh3meycJhsceO9Q0z/jbiQ1Xwx41eDmJL7q9yAcdxfH4XsousPnOCWyqm05Vq
 Mn1/ryXSthvTwwUNFIMDxSUcrdeHXfh/aN5liT3YR2vrlur7LQK5ZW5f7g+w6s0eTK91
 fmBMFyiIik/td2XQne3r5tKDnLaXnTGF4mvAebnkPK1geUbaAwkRsYxc9rd52XrvtC62
 XUBXKf7z5FeFjfvHMDTf+bNIevfPbZyCcbUjBQ/fqkegSLnswpMGrtG2A+oG4Buy9ium
 /0YO3BepOQdVEy+FQKsGiDlZ6Klv2fQXtVb7a5GXX+hP8kz6ept7ijp7t6ax+qDbex5p sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7dhgg2ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 03:43:08 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A73gj0A004111;
	Tue, 7 Nov 2023 03:43:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7dhgg2a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 03:43:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A71pDWX007827;
	Tue, 7 Nov 2023 03:43:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skdu6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 03:43:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A73h4Uh35586676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Nov 2023 03:43:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE00320043;
	Tue,  7 Nov 2023 03:43:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DECA420040;
	Tue,  7 Nov 2023 03:42:52 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.171.59.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Nov 2023 03:42:52 +0000 (GMT)
Date: Tue, 7 Nov 2023 09:12:47 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v6 0/4] Introduce perf check subcommand
Message-ID: <ufowvhxelymjvoyuwp4a74hzv5jfcnal5vsbqahyr5kmtijvu5@cftm4p5nq6uk>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021150526.2231803-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UEdQg6SRhkpDscInVVMB4QKPm7LleHjc
X-Proofpoint-GUID: ngdwVkL-hE5MPfGGyrVLGisQZrddJSEJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070030

Hello,
Just a ping. Any comments on this series ?

Thanks,
Aditya Gupta

On Sat, Oct 21, 2023 at 08:35:22PM +0530, Aditya Gupta wrote:
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
> scripts can test for presence of a feature, such as:
> 
>     perf check --feature HAVE_LIBTRACEEVENT
> 
>     or
> 
>     perf check --feature libtraceevent
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
> https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v6
> 
> Changelog
> =========
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
