Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834181FAE
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jan 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kdtEAHFU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4064VBl8030639;
	Sat, 6 Jan 2024 05:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=WFlI4j5WdOa6HImbIH7Ben3j8qNMvsK/L4TsQqGQfis=;
 b=kdtEAHFU9FnrgMHcYnVKHnLqNl2+Qk5OpB8fRjb9f30SDzquXmK1RI/HC4XZz75nhpCj
 PAlYGSpxoxfmvulCKdf3V2G0WdPEtsFzi0CfggKxwZXdHruWHS6RtvbtAlnmxaur1xDL
 GzdFhW9+v2zTV0EZazSMTPkldPEx0lXoUoEo3ksgsraSgXOuVPWdjRIvGBFqtKbxujRL
 eVKRC1w+z6FVPZsFVqSxYVwEEurxVGcqEwgg/xi4Iw5d9jeBh434EM0w4H9anp4xx2J5
 DcqnTmm630tROu532f/ejrIFBxUmiTw+OTjRvPOT2+0lDxG2gIX7YAmVkntXOYMtDkj/ 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vexj0je8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 05:49:02 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4065UTR7002574;
	Sat, 6 Jan 2024 05:49:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vexj0je8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 05:49:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4064XxSF022289;
	Sat, 6 Jan 2024 05:49:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb082ugnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 05:49:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4065mwF152232584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jan 2024 05:48:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8787120043;
	Sat,  6 Jan 2024 05:48:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1462F20040;
	Sat,  6 Jan 2024 05:48:56 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.171.64.160])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  6 Jan 2024 05:48:55 +0000 (GMT)
Date: Sat, 6 Jan 2024 11:18:54 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: Re: [PATCH v8 0/4] Introduce perf check subcommand
Message-ID: <lzgtr2q7iqmip6k4kfxui3dnay3iff7u2rjwwtzjdjkbkxqp4n@pk7owbl45apa>
References: <20231204093954.304030-1-adityag@linux.ibm.com>
 <h5dyqz55bcbrrcykdrherwpioclnmbr4egccsr4qb5n7zky747@brkblmk7vazt>
 <3bgpdf5ha4go7xpxtgfa2ophxokoyiu2hjjumlwmtioi3bgjmv@bah667fiqp7x>
 <ZZgbifOT9Xgr-1Wo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZgbifOT9Xgr-1Wo@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dt6XB-3KrxZrd4jj9HVJTlNKN-tWmgUt
X-Proofpoint-ORIG-GUID: FsxW9s31vMwnP2t3UuhOgmg15XYULt51
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401060038

On Fri, Jan 05, 2024 at 12:08:57PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 05, 2024 at 01:30:19PM +0530, Aditya Gupta escreveu:
> > Hi Arnaldo,
> > Any comments on the series ?
> 
> I'm trying now to finish the pull req for v6.8, trying to avoid adding
> new features, Namhyung will take care for patches for v6.9, where he
> will most likely consider your latest v8 kit.

Sure, that's okay.

Thanks,
Aditya Gupta

> 
> Thanks,
> 
> - Arnaldo
>  
> > Thanks,
> > Aditya
> > 
> > > On Mon, Dec 04, 2023 at 03:09:50PM +0530, Aditya Gupta wrote:
> > > > The Problem
> > > > ===========
> > > > 
> > > > Currently the presence of a feature is checked with a combination of
> > > > perf version --build-options and greps, such as:
> > > > 
> > > >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > > > 
> > > > Proposed solution
> > > > =================
> > > > 
> > > > As suggested by contributors in:
> > > > https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> > > > 
> > > > Introduce a subcommand "perf check --feature", with which
> > > > scripts can test for presence of a feature or multiple features, such as:
> > > > 
> > > >     perf check --feature HAVE_LIBTRACEEVENT
> > > > 
> > > >     or
> > > > 
> > > >     perf check --feature libtraceevent
> > > > 
> > > >     or
> > > > 
> > > >     perf check --feature libtraceevent,bpf
> > > > 
> > > > The usage of "perf version --build-options | grep" has been replaced in two
> > > > tests, with "perf check --feature" command
> > > > 
> > > > Also, to not duplicate the same feature list at multiple places, a new global
> > > > 'supported_features' array has been introduced in builtin.h, so both commands
> > > > 'perf check --feature' and 'perf version --build-options' use the same array
> > > > 
> > > > 'supported_features' feature is an array of 'struct feature_support', which
> > > > also has the name of the feature, macro used to test it's presence, and a
> > > > is_builtin member, which will be 0 if feature not built-in, and 1 if built-in
> > > > 
> > > > Architectures Tested
> > > > ====================
> > > > * x86_64
> > > > * ppc64le
> > > > 
> > > > Git tree
> > > > ========
> > > > 
> > > > Git tree with this patch series applied for testing:
> > > > https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v8
> > > > 
> > > > Changelog
> > > > =========
> > > > V8
> > > > + handle return value of 'malloc' in patch #1
> > > > + fix error due to strncpy depending on source string's length
> > > > 
> > > > V7
> > > > + modified patch #1 to fix compile issue, and add feature to allow
> > > >   multiple comma-separated features
> > > > 
> > > > V6
> > > > + rebased to perf-tools-next/perf-tools-next
> > > > + modified patch #1 to include FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL)
> > > > 
> > > > V5
> > > > + invert return value of 'has_support', but return value of perf check --feature
> > > > according to shell convention
> > > > 
> > > > V4
> > > > + invert return value of perf check --feature
> > > > 
> > > > V3
> > > > + simplified has_support code in builtin-check.c (patch #1)
> > > > + modified patch #3 and patch #4 according to change in return value in patch #1
> > > > 
> > > > V2
> > > > + improved the patch series with suggestions from Namhyung
> > > > + fix incorrect return value, added -q option, and moved array definition to
> > > >   perf-check.c
> > > > 
> > > > V1
> > > > + changed subcommand name to 'perf check --feature'
> > > > + added documentation for perf check
> > > > + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
> > > >   input to 'perf check --feature'
> > > > + change subject and descriptions of all patch mentioning perf check instead of
> > > >   perf build
> > > > 
> > > > V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
> > > > 
> > > > Aditya Gupta (3):
> > > >   perf check: introduce check subcommand
> > > >   perf version: update --build-options to use 'supported_features' array
> > > >   perf tests task_analyzer: use perf check for libtraceevent support
> > > > 
> > > > Athira Rajeev (1):
> > > >   tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
> > > >     --feature
> > > > 
> > > >  tools/perf/Build                              |   1 +
> > > >  tools/perf/Documentation/perf-check.txt       |  59 +++++++++
> > > >  tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
> > > >  tools/perf/builtin-version.c                  |  39 ++----
> > > >  tools/perf/builtin.h                          |  18 +++
> > > >  tools/perf/perf.c                             |   1 +
> > > >  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
> > > >  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
> > > >  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
> > > >  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
> > > >  10 files changed, 221 insertions(+), 37 deletions(-)
> > > >  create mode 100644 tools/perf/Documentation/perf-check.txt
> > > >  create mode 100644 tools/perf/builtin-check.c
> > > > 
> > > > -- 
> > > > 2.41.0
> > > > 
> 
> -- 
> 
> - Arnaldo
