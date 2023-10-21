Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDCCA7E
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BvZMpobb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09D3CA
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Oct 2023 05:11:37 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39LC9xYn031636;
	Sat, 21 Oct 2023 12:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jMWPCZsNjIz0TGAeguklOPj3EZRk2W/9Qp/HShtSLQA=;
 b=BvZMpobbxjTPagsg1iNrkccTq/2MDD43+bfxsZkEA4pP65XlfPe5Ogov9AmNSuQ16xs1
 d7SyG0T0i2o3/x5vbBDYPyg30GhbLS3l6SGOHc4YEdQQiITflV+0p0L6vKDP3usw5zrc
 QCnRT28fSF2aWjOjf7SZ0LLDTtOKOuBm49NCw9jzahJX7n5hf5RRc0Q+i921ufyu/Fjn
 7ScWExAN5WDKCQs/yMvJXzv84cZMVGyxrL/UFgmEd9dw5IMsE1xqFxGt7oElseqQIE9S
 THM899DVHt2yn3cX1JEHZnQ8G4NlT/C0drds3TN/RvH3J9X4zEW0a9G0ka+ikmY9lVa/ TA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvedb81hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 12:11:26 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LCBMLR004004;
	Sat, 21 Oct 2023 12:11:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvedb81hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 12:11:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39L9UDvA002683;
	Sat, 21 Oct 2023 12:11:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc44k5gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Oct 2023 12:11:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39LCBMV541484974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Oct 2023 12:11:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC74B20040;
	Sat, 21 Oct 2023 12:11:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 944B520043;
	Sat, 21 Oct 2023 12:11:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.179.22.223])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 21 Oct 2023 12:11:20 +0000 (GMT)
Date: Sat, 21 Oct 2023 17:41:16 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, irogers@google.com, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v5 0/4] Introduce perf check subcommand
Message-ID: <meismbdm4cmw567a5i54wls4ooo2joad42c7tmvnuhv7rpxfa3@u53zxhhlulw7>
References: <20231003055440.111907-1-adityag@linux.ibm.com>
 <CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw@mail.gmail.com>
 <ZTLinqxncSO3wvSq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTLinqxncSO3wvSq@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4G12skDXjkn40c1JOwnjjcvbsmP1hLJ3
X-Proofpoint-ORIG-GUID: 3SpRR7H_kkoGoW3o0hGRHwpccaP2aAhN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210111

On Fri, Oct 20, 2023 at 05:27:10PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 04, 2023 at 09:48:49PM -0700, Namhyung Kim escreveu:
> > Arnaldo, Ian and others,
> > 
> > Are you ok with this?
> 
> Its not applying to the current perf-tools-next/perf-tools-next:
> 
> [acme@quaco perf-tools-next]$ git remote -v | grep -m1 ^perf-tools-next
> perf-tools-next	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git (fetch)
> [acme@quaco perf-tools-next]$
> 
> Aditya, can you please take a look, I think it needs a refresh.

Sure Arnaldo, I will rebase it onto current perf-tools-next, and send a v6.

Thanks,
Aditya Gupta

> 
> - Arnaldo
> 
> [acme@quaco perf-tools-next]$ git checkout -b bla perf-tools-next/perf-tools-next
> branch 'bla' set up to track 'perf-tools-next/perf-tools-next'.
> Switched to a new branch 'bla'
> [acme@quaco perf-tools-next]$ b4 am -ctsl --cc-trailers CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw@mail.gmail.com
> Grabbing thread from lore.kernel.org/all/CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw%40mail.gmail.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 7 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH v5 1/4] perf check: introduce check subcommand
>     + Link: https://lore.kernel.org/r/20231003055440.111907-2-adityag@linux.ibm.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   [PATCH v5 2/4] perf version: update --build-options to use 'supported_features' array
>     + Link: https://lore.kernel.org/r/20231003055440.111907-3-adityag@linux.ibm.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   [PATCH v5 3/4] perf tests task_analyzer: use perf check for libtraceevent support
>     + Link: https://lore.kernel.org/r/20231003055440.111907-4-adityag@linux.ibm.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   [PATCH v5 4/4] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check --feature
>     + Link: https://lore.kernel.org/r/20231003055440.111907-5-adityag@linux.ibm.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ---
>   NOTE: install dkimpy for DKIM signature verification
> ---
> Total patches: 4
> ---
> Cover: ./v5_20231003_adityag_introduce_perf_check_subcommand.cover
>  Link: https://lore.kernel.org/r/20231003055440.111907-1-adityag@linux.ibm.com
>  Base: not specified
>        git am ./v5_20231003_adityag_introduce_perf_check_subcommand.mbx
> [acme@quaco perf-tools-next]$        git am ./v5_20231003_adityag_introduce_perf_check_subcommand.mbx
> Applying: perf check: introduce check subcommand
> Applying: perf version: update --build-options to use 'supported_features' array
> error: patch failed: tools/perf/builtin-version.c:46
> error: tools/perf/builtin-version.c: patch does not apply
> Patch failed at 0002 perf version: update --build-options to use 'supported_features' array
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> [acme@quaco perf-tools-next]$
>  
> > Thanks,
> > Namhyung
> > 
> > 
> > On Mon, Oct 2, 2023 at 10:54 PM Aditya Gupta <adityag@linux.ibm.com> wrote:
> > >
> > > The Problem
> > > ===========
> > >
> > > Currently the presence of a feature is checked with a combination of
> > > perf version --build-options and greps, such as:
> > >
> > >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > >
> > > Proposed solution
> > > =================
> > >
> > > As suggested by contributors in:
> > > https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> > >
> > > Introduce a subcommand "perf check --feature", with which
> > > scripts can test for presence of a feature, such as:
> > >
> > >     perf check --feature HAVE_LIBTRACEEVENT
> > >
> > >     or
> > >
> > >     perf check --feature libtraceevent
> > >
> > > The usage of "perf version --build-options | grep" has been replaced in two
> > > tests, with "perf check --feature" command
> > >
> > > Also, to not duplicate the same feature list at multiple places, a new global
> > > 'supported_features' array has been introduced in builtin.h, so both commands
> > > 'perf check --feature' and 'perf version --build-options' use the same array
> > >
> > > 'supported_features' feature is an array of 'struct feature_support', which
> > > also has the name of the feature, macro used to test it's presence, and a
> > > is_builtin member, which will be 0 if feature not built-in, and 1 if built-in
> > >
> > > Architectures Tested
> > > ====================
> > > * x86_64
> > > * ppc64le
> > >
> > > Git tree
> > > ========
> > >
> > > Git tree with this patch series applied for testing:
> > > https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v5
> > >
> > > Changelog
> > > =========
> > > V5
> > > + invert return value of 'has_support', but return value of perf check --feature
> > > according to shell convention
> > >
> > > V4
> > > + invert return value of perf check --feature
> > >
> > > V3
> > > + simplified has_support code in builtin-check.c (patch #1)
> > > + modified patch #3 and patch #4 according to change in return value in patch #1
> > >
> > > V2
> > > + improved the patch series with suggestions from Namhyung
> > > + fix incorrect return value, added -q option, and moved array definition to
> > >   perf-check.c
> > >
> > > V1
> > > + changed subcommand name to 'perf check --feature'
> > > + added documentation for perf check
> > > + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
> > >   input to 'perf check --feature'
> > > + change subject and descriptions of all patch mentioning perf check instead of
> > >   perf build
> > >
> > > V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
> > >
> > > Aditya Gupta (3):
> > >   perf check: introduce check subcommand
> > >   perf version: update --build-options to use 'supported_features' array
> > >   perf tests task_analyzer: use perf check for libtraceevent support
> > >
> > > Athira Rajeev (1):
> > >   tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
> > >     --feature
> > >
> > >  tools/perf/Build                              |   1 +
> > >  tools/perf/Documentation/perf-check.txt       |  59 +++++++++
> > >  tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
> > >  tools/perf/builtin-version.c                  |  39 ++----
> > >  tools/perf/builtin.h                          |  18 +++
> > >  tools/perf/perf.c                             |   1 +
> > >  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
> > >  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
> > >  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
> > >  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
> > >  10 files changed, 221 insertions(+), 37 deletions(-)
> > >  create mode 100644 tools/perf/Documentation/perf-check.txt
> > >  create mode 100644 tools/perf/builtin-check.c
> > >
> > > --
> > > 2.41.0
> > >
> 
> -- 
> 
> - Arnaldo
