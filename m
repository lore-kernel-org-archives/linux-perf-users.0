Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S38dokYd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B423172E
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 21:23:07 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5Mo3Y017898;
	Wed, 29 Nov 2023 05:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=9BZRD7+g12jtxt2zKB4bSK5o36BET56W5aEFeCFEpNc=;
 b=S38dokYdqy2bHcRn7M6czdqw7KjiwMgkE/uRaHOLYeE0u1dq0iOhtfC18MhqvqwN+LAc
 boyox0e+Jdz0y7jpVMizGN82em8G3tdXLKb2GMXd2OUHUmejV4ud1zQZSiPpX2ZzMDDx
 pkBcIywy+FDWMuwn4ZLxw8TwQCxV0OnI7z0GdH7yTqwJYJwPRotZa1S3PPMaCeFSFdem
 Sy9ivV7w8zSTGWaTBoiAhKB/9GDgiNjjEzsC6jRa5PvI2WMZQO2NGuTBqBk11qRzetqn
 lSXXj4Nrb/ESga1X8Qa7uq50prSmbMOBymRoYW3Z11FqygFySGfai8wgs2FIfNv/TYaP Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uny3mg048-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:22:53 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT5Mqxp017950;
	Wed, 29 Nov 2023 05:22:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uny3mg03q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:22:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT581JO018236;
	Wed, 29 Nov 2023 05:22:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1vnp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 05:22:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT5Mm025112326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 05:22:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B34620040;
	Wed, 29 Nov 2023 05:22:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8851620043;
	Wed, 29 Nov 2023 05:22:46 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.74.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 05:22:46 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH V4] tools/perf: Add perf binary dependent rule for
 shellcheck log in Makefile.perf
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZWSs6zn1NqWqzoyC@kernel.org>
Date: Wed, 29 Nov 2023 10:52:34 +0530
Cc: Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D08EDB0-E0FD-4D1C-A9D8-5FF9EB9329AC@linux.vnet.ibm.com>
References: <20231123160232.94253-1-atrajeev@linux.vnet.ibm.com>
 <e8143e4d-d3ca-88c5-f1c8-b79f70ee5ffa@arm.com> <ZWSs6zn1NqWqzoyC@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SyP_gbK58jxCdmTjTcSUojZw8EYBTUcG
X-Proofpoint-GUID: 3HvkAO0Jp9bV1OQDdqlDhykgcqbvHj6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_02,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=508 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290039



> On 27-Nov-2023, at 8:21=E2=80=AFPM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> Em Mon, Nov 27, 2023 at 11:12:57AM +0000, James Clark escreveu:
>> On 23/11/2023 16:02, Athira Rajeev wrote:
>>> Add rule in new Makefile "tests/Makefile.tests" for running
>>> shellcheck on shell test scripts. This automates below shellcheck
>>> into the build.
>=20
>> Seems to work really well. I also tested it on Ubuntu, and checked
>> NO_SHELLCHECK, cleaning and with and without shellcheck installed =
etc.
>=20
>> Reviewed-by: James Clark <james.clark@arm.com>
>=20
> Tested on Fedora 38, works as advertised, applied.
>=20
> - Arnaldo

Hi James, Arnaldo

Thanks for testing the patch and comments.

Athira Rajeev=
