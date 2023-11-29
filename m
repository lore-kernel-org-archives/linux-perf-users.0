Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cXp0uE6a"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803610F4
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 23:08:48 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6vd4V017078;
	Wed, 29 Nov 2023 07:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JEPy1YZg6njk+55pq2kian8Y6vaH+gK++c0BIDiQMno=;
 b=cXp0uE6aZ2639hOpSisslgHCn9Xw1Ib16X2VnhgoOL4mjf4f5lRN9yWScI64GSMoBuft
 WtG9LyoNffEu/ujrRz92k8V7VLObdkwbFUYW5RKAH2XTiz6MGGBd6OXRCV2Tt0KX68ZY
 TI+tgDfAcJ44xnn3yGrNBQ1f7LzLHA8D1sDdoEx6os/bOnNS/erWRhXDGAwEZI/UulQ8
 7+L1egGCZ10Ap+sPSd/vfiPjSg0w3m/yv3KFSfj+gDyC0nJb87TyoEW53JxNkPRE0dXK
 y15j8duzhdq/HGlzlZHGkIgrUGf3jGA7JZxcZ6/kBIXEhBFslfw6sOcMNyNZ8zID8zXZ +g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up0fx8dcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 07:08:44 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT70OIA027246;
	Wed, 29 Nov 2023 07:08:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up0fx8c19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 07:08:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5FBni031027;
	Wed, 29 Nov 2023 07:07:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8t5wrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 07:07:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT77qSr44499386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 07:07:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B3D120043;
	Wed, 29 Nov 2023 07:07:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0BBB20040;
	Wed, 29 Nov 2023 07:07:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 07:07:49 +0000 (GMT)
Date: Wed, 29 Nov 2023 12:37:44 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 0/4] Introduce perf check subcommand
Message-ID: <5gkw2eqtfvxommezgyl4pxedbcz6zsivgw46r2w52nmpmesjuq@4xrzm4bl6uc7>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
 <02ADEADB-0FEB-423B-B3A3-96C5529AF0A8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02ADEADB-0FEB-423B-B3A3-96C5529AF0A8@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QfZfGPyTlsx-XCkpL5N3vSYp7JwzBOiq
X-Proofpoint-ORIG-GUID: BAsI99cFeGSjk-EZJMn-wwZpFM0SqlXe
Content-Transfer-Encoding: 8bit
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

On Wed, Nov 29, 2023 at 11:03:15AM +0530, Athira Rajeev wrote:
> 
> 
> > On 17-Nov-2023, at 3:04 AM, Aditya Gupta <adityag@linux.ibm.com> wrote:
> > 
> > The Problem
> > ===========
> > 
> > Currently the presence of a feature is checked with a combination of
> > perf version --build-options and greps, such as:
> > 
> >    perf version --build-options | grep " on .* HAVE_FEATURE"
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
> >    perf check --feature HAVE_LIBTRACEEVENT
> > 
> >    or
> > 
> >    perf check --feature libtraceevent
> > 
> >    or
> > 
> >    perf check --feature libtraceevent,libbpf_support
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
> 
> For the series, 
> 
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks for the tag, Athira.

Thanks,

> 
> Thanks
> Athira
> > Architectures Tested
> > ====================
> > * x86_64
> > * ppc64le
> > 
> > Git tree
> > ========
> > 
> > Git tree with this patch series applied for testing:
> > https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v7
> > 
> > Changelog
> > =========
> > V7
> > + modified patch #1 to fix compile issue, and add feature to allow
> >  multiple comma-separated features
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
> >  perf-check.c
> > 
> > V1
> > + changed subcommand name to 'perf check --feature'
> > + added documentation for perf check
> > + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
> >  input to 'perf check --feature'
> > + change subject and descriptions of all patch mentioning perf check instead of
> >  perf build
> > 
> > V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
> > 
> > Aditya Gupta (3):
> >  perf check: introduce check subcommand
> >  perf version: update --build-options to use 'supported_features' array
> >  perf tests task_analyzer: use perf check for libtraceevent support
> > 
> > Athira Rajeev (1):
> >  tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
> >    --feature
> > 
> > tools/perf/Build                              |   1 +
> > tools/perf/Documentation/perf-check.txt       |  59 +++++++++
> > tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
> > tools/perf/builtin-version.c                  |  39 ++----
> > tools/perf/builtin.h                          |  18 +++
> > tools/perf/perf.c                             |   1 +
> > .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
> > .../shell/record+probe_libc_inet_pton.sh      |   5 +-
> > .../shell/record+script_probe_vfs_getname.sh  |   5 +-
> > tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
> > 10 files changed, 221 insertions(+), 37 deletions(-)
> > create mode 100644 tools/perf/Documentation/perf-check.txt
> > create mode 100644 tools/perf/builtin-check.c
> > 
> > -- 
> > 2.41.0
> > 
> 
