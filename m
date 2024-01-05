Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7520310
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jan 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AlUsXwb8"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40577W0W016237;
	Fri, 5 Jan 2024 08:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=dan25+T8ZzTnujtHVgt8zXa1maYeC05FhthpGBHqS0Q=;
 b=AlUsXwb8Awkb02qxdewJAuLi8LCT58Q9q1fO6GRxAkz0zgbIdqGSmQoWBmxF6mQXT6OP
 3N9ENiFRNa3tRMX37TRqsmb/H5iMkQhx0ce1yAtbkLT/HSX9cV1o5Ij311ICOvJtBku0
 6lSwx3UOcFu3OVars4sX9UOOspz0uHqDeDUrTsvkcTFUBAJaNyHFXqZdTYrn3zI7wt6F
 XVTbEn5DFzmtTaAqAKtxf5G59uG9a3nxdFR57AceRvB3ANJR6uzf3mp4iSh5PIz1dMyk
 xDb6Gi+RZzDh1WBLXo+Ha6xLOzTgVtnIvlxIkaOa9Kkg4g6IO64Vq5B6riWKY4Jfed+h Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ved3nhadd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 08:00:29 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4057w3Ah028996;
	Fri, 5 Jan 2024 08:00:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ved3nhacr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 08:00:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4056KJjD017918;
	Fri, 5 Jan 2024 08:00:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawx06cdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 08:00:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40580Od762521808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 08:00:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7D2E2004F;
	Fri,  5 Jan 2024 08:00:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70C2F20040;
	Fri,  5 Jan 2024 08:00:22 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.179.23.75])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Jan 2024 08:00:22 +0000 (GMT)
Date: Fri, 5 Jan 2024 13:30:19 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v8 0/4] Introduce perf check subcommand
Message-ID: <3bgpdf5ha4go7xpxtgfa2ophxokoyiu2hjjumlwmtioi3bgjmv@bah667fiqp7x>
References: <20231204093954.304030-1-adityag@linux.ibm.com>
 <h5dyqz55bcbrrcykdrherwpioclnmbr4egccsr4qb5n7zky747@brkblmk7vazt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h5dyqz55bcbrrcykdrherwpioclnmbr4egccsr4qb5n7zky747@brkblmk7vazt>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dQdZMacYH6MHLBSn5rW-NxsUkiAaEVF2
X-Proofpoint-GUID: NZxdNyTUIcN0TXUkQs42tCLwle-U6X-0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_03,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401050067

Hi Arnaldo,
Any comments on the series ?

Thanks,
Aditya

> On Mon, Dec 04, 2023 at 03:09:50PM +0530, Aditya Gupta wrote:
> > The Problem
> > ===========
> > 
> > Currently the presence of a feature is checked with a combination of
> > perf version --build-options and greps, such as:
> > 
> >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > 
> > Proposed solution
> > =================
> > 
> > As suggested by contributors in:
> > https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> > 
> > Introduce a subcommand "perf check --feature", with which
> > scripts can test for presence of a feature or multiple features, such as:
> > 
> >     perf check --feature HAVE_LIBTRACEEVENT
> > 
> >     or
> > 
> >     perf check --feature libtraceevent
> > 
> >     or
> > 
> >     perf check --feature libtraceevent,bpf
> > 
> > The usage of "perf version --build-options | grep" has been replaced in two
> > tests, with "perf check --feature" command
> > 
> > Also, to not duplicate the same feature list at multiple places, a new global
> > 'supported_features' array has been introduced in builtin.h, so both commands
> > 'perf check --feature' and 'perf version --build-options' use the same array
> > 
> > 'supported_features' feature is an array of 'struct feature_support', which
> > also has the name of the feature, macro used to test it's presence, and a
> > is_builtin member, which will be 0 if feature not built-in, and 1 if built-in
> > 
> > Architectures Tested
> > ====================
> > * x86_64
> > * ppc64le
> > 
> > Git tree
> > ========
> > 
> > Git tree with this patch series applied for testing:
> > https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v8
> > 
> > Changelog
> > =========
> > V8
> > + handle return value of 'malloc' in patch #1
> > + fix error due to strncpy depending on source string's length
> > 
> > V7
> > + modified patch #1 to fix compile issue, and add feature to allow
> >   multiple comma-separated features
> > 
> > V6
> > + rebased to perf-tools-next/perf-tools-next
> > + modified patch #1 to include FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL)
> > 
> > V5
> > + invert return value of 'has_support', but return value of perf check --feature
> > according to shell convention
> > 
> > V4
> > + invert return value of perf check --feature
> > 
> > V3
> > + simplified has_support code in builtin-check.c (patch #1)
> > + modified patch #3 and patch #4 according to change in return value in patch #1
> > 
> > V2
> > + improved the patch series with suggestions from Namhyung
> > + fix incorrect return value, added -q option, and moved array definition to
> >   perf-check.c
> > 
> > V1
> > + changed subcommand name to 'perf check --feature'
> > + added documentation for perf check
> > + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
> >   input to 'perf check --feature'
> > + change subject and descriptions of all patch mentioning perf check instead of
> >   perf build
> > 
> > V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
> > 
> > Aditya Gupta (3):
> >   perf check: introduce check subcommand
> >   perf version: update --build-options to use 'supported_features' array
> >   perf tests task_analyzer: use perf check for libtraceevent support
> > 
> > Athira Rajeev (1):
> >   tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
> >     --feature
> > 
> >  tools/perf/Build                              |   1 +
> >  tools/perf/Documentation/perf-check.txt       |  59 +++++++++
> >  tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
> >  tools/perf/builtin-version.c                  |  39 ++----
> >  tools/perf/builtin.h                          |  18 +++
> >  tools/perf/perf.c                             |   1 +
> >  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
> >  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
> >  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
> >  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
> >  10 files changed, 221 insertions(+), 37 deletions(-)
> >  create mode 100644 tools/perf/Documentation/perf-check.txt
> >  create mode 100644 tools/perf/builtin-check.c
> > 
> > -- 
> > 2.41.0
> > 
