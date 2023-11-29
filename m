Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bUEmBzfJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6D120
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 21:33:35 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4g7E9014583;
	Wed, 29 Nov 2023 05:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K66gz+p529eAiE5mE/jqI+aiLewIzWdd/aGyOZrNxX8=;
 b=bUEmBzfJs85/nuPvs2kb/woEjj3ThxNkdfanIAcEXlZWltpfDZyzjxaetFYYu7mZeNtn
 nVXOplu68q4vSBHu7tf5YufWE54Jr6GSevPWC4cjkQmwiGJjHcGu+9abkRYEoZzCeE/R
 fbR6L73gSOXxx9O/iPxCjpcGO7V/hzBanAFflGg2RCBsV23S8aH8IHA62NYYyCRZMWk9
 EjyGYjrFm5ot5ZlerlEjK2tcFgaV0/WsHQwUtHRPOrfevkCS7ol/aUdh6mbedOgosau7
 nzRdh2QfqWeMdiYZgpsxRkcEa+IUQOTV2QWIu5sluAp+TnnXxrF7KuYlrODLXsR8o0sE Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unxgj15jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:33:32 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT5AQBo013428;
	Wed, 29 Nov 2023 05:33:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unxgj15jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:33:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT581Mw018236;
	Wed, 29 Nov 2023 05:33:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1vq6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:33:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT5XSxb43254192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 05:33:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B699D20043;
	Wed, 29 Nov 2023 05:33:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A6A520040;
	Wed, 29 Nov 2023 05:33:27 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.74.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 05:33:27 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH v7 0/4] Introduce perf check subcommand
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231116213435.382484-1-adityag@linux.ibm.com>
Date: Wed, 29 Nov 2023 11:03:15 +0530
Cc: Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Message-Id: <02ADEADB-0FEB-423B-B3A3-96C5529AF0A8@linux.vnet.ibm.com>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CH4hjnSpJWCfDzevmVUQLKJQTlKHNpvC
X-Proofpoint-GUID: FW_ddomR9_EFXqNURoe4YOHu2eiynMRW
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_02,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290040



> On 17-Nov-2023, at 3:04=E2=80=AFAM, Aditya Gupta <adityag@linux.ibm.com> =
wrote:
>=20
> The Problem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
>=20
>    perf version --build-options | grep " on .* HAVE_FEATURE"
>=20
> Proposed solution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> As suggested by contributors in:
> https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
>=20
> Introduce a subcommand "perf check --feature", with which
> scripts can test for presence of a feature or multiple features, such as:
>=20
>    perf check --feature HAVE_LIBTRACEEVENT
>=20
>    or
>=20
>    perf check --feature libtraceevent
>=20
>    or
>=20
>    perf check --feature libtraceevent,libbpf_support
>=20
> The usage of "perf version --build-options | grep" has been replaced in t=
wo
> tests, with "perf check --feature" command
>=20
> Also, to not duplicate the same feature list at multiple places, a new gl=
obal
> 'supported_features' array has been introduced in builtin.h, so both comm=
ands
> 'perf check --feature' and 'perf version --build-options' use the same ar=
ray
>=20
> 'supported_features' feature is an array of 'struct feature_support', whi=
ch
> also has the name of the feature, macro used to test it's presence, and a
> is_builtin member, which will be 0 if feature not built-in, and 1 if buil=
t-in

For the series,=20

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
> Architectures Tested
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * x86_64
> * ppc64le
>=20
> Git tree
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Git tree with this patch series applied for testing:
> https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v7
>=20
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> V7
> + modified patch #1 to fix compile issue, and add feature to allow
>  multiple comma-separated features
>=20
> V6
> + rebased to perf-tools-next/perf-tools-next
> + modified patch #1 to include FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_=
SKEL)
>=20
> V5
> + invert return value of 'has_support', but return value of perf check --=
feature
> according to shell convention
>=20
> V4
> + invert return value of perf check --feature
>=20
> V3
> + simplified has_support code in builtin-check.c (patch #1)
> + modified patch #3 and patch #4 according to change in return value in p=
atch #1
>=20
> V2
> + improved the patch series with suggestions from Namhyung
> + fix incorrect return value, added -q option, and moved array definition=
 to
>  perf-check.c
>=20
> V1
> + changed subcommand name to 'perf check --feature'
> + added documentation for perf check
> + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceeven=
t) as
>  input to 'perf check --feature'
> + change subject and descriptions of all patch mentioning perf check inst=
ead of
>  perf build
>=20
> V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230=
825061125.24312-1-adityag@linux.ibm.com/
>=20
> Aditya Gupta (3):
>  perf check: introduce check subcommand
>  perf version: update --build-options to use 'supported_features' array
>  perf tests task_analyzer: use perf check for libtraceevent support
>=20
> Athira Rajeev (1):
>  tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
>    --feature
>=20
> tools/perf/Build                              |   1 +
> tools/perf/Documentation/perf-check.txt       |  59 +++++++++
> tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
> tools/perf/builtin-version.c                  |  39 ++----
> tools/perf/builtin.h                          |  18 +++
> tools/perf/perf.c                             |   1 +
> .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
> .../shell/record+probe_libc_inet_pton.sh      |   5 +-
> .../shell/record+script_probe_vfs_getname.sh  |   5 +-
> tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
> 10 files changed, 221 insertions(+), 37 deletions(-)
> create mode 100644 tools/perf/Documentation/perf-check.txt
> create mode 100644 tools/perf/builtin-check.c
>=20
> --=20
> 2.41.0
>=20

