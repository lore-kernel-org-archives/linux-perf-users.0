Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8281D3197;
	Tue,  5 Nov 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809518; cv=none; b=p7q9ZQoFdKzCexmRIWpjVZTaj6f+Ny+3mkyXSILauVwejoU8AEmqg/5XCl01CFeXhJQAO6/joIaebpLK/JlMqp87ToVxyZu39VNTpX7vdMHpsl6NSQ3jz6bgMXUL0BuKPareJ+gB6WWzqZjZLFrg07kRSaDUbIz5pWJC7rIXN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809518; c=relaxed/simple;
	bh=Hg253i8CHR/taXbxfdSBYiLOMiSQK7hYTUBUA/CoWTo=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=jPExzVFRxb3pqGiCn3Tb0N5bjHT62BOl5eBNMkIiosfU47sglzmLb6aYGS2eB8A7Ipl5Poh5xkaWdmyb7YhajDYYG1Rl5y/QWJLq/mYthL4ePaqzBNJZE/QzBAfmyVR3qm5LDU8Ens/8+lIBUK++zyXQcyoK/8U3CNnziuKTsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GR4djpMM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GR4djpMM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5CEKjs002844;
	Tue, 5 Nov 2024 12:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pgu/yu
	AR4STsCpaIbMhLoQ22Bp3bjl993icPXv/Q6GU=; b=GR4djpMMFxFnFQnRaXSyyg
	yCSa+LJ8uLo3j56OUIOMX/u96plHN4SEtD7ZVf3C/x0ARNJ/k7GexM7T7ZeooQZi
	P7Oy143D4lLRHLwcPMt6RlL65tSnRQqbfMyLslErFMD75R3jnxyt6QDoWO/qTnAK
	0RmSu+4mPpNlnAFj6VnaxqQj0MZppXMPSdqKlQP21mlR9F4t0tgSJpgBKWAV4CIP
	VIeEMoGFT1QMOPWy72grqaism/tswMm3guPebPOZ/iYkDqFrFEAWxxwHa1p8iVAx
	sMeSbe8onViGNgB/MQALYPSsY9ypyO5gSPhIR0Jc2AdPX8TYDoyOlSyDRP1E8+gQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qjpgg74d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 12:25:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A5CP0Xv030567;
	Tue, 5 Nov 2024 12:25:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qjpgg74b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 12:25:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A57E1MG032065;
	Tue, 5 Nov 2024 12:24:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmm38f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 12:24:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A5COvC031654246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 12:24:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D145620043;
	Tue,  5 Nov 2024 12:24:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF9920040;
	Tue,  5 Nov 2024 12:24:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.252.221])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Nov 2024 12:24:52 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH] Use strscpy() instead of the deprecated strlcpy()
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241105070046.424750-1-danielyangkang@gmail.com>
Date: Tue, 5 Nov 2024 17:54:38 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Message-Id: <3CA737FF-2F21-42CA-BF95-5F0341F6B68B@linux.vnet.ibm.com>
References: <20241105070046.424750-1-danielyangkang@gmail.com>
To: Daniel Yang <danielyangkang@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NTM1hEnfVdrICNzUlF4P6YdiJs62CnFE
X-Proofpoint-GUID: x0BMgx5mDjxnnW4HIMFBvzlyrxSGmfd5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050093



> On 5 Nov 2024, at 12:30=E2=80=AFPM, Daniel Yang <danielyangkang@gmail.com=
> wrote:
>=20
> The latest kernel doc:
> https://www.kernel.org/doc/html/latest/process/deprecated.html
> recommends replacing strlcpy with strscpy. Since the return value of
> strlcpy is not used, replacing with strscpy should be safe.
>=20
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> tools/perf/util/symbol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3bbf173ad..660ed5626 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1893,7 +1893,7 @@ int dso__load(struct dso *dso, struct map *map)
> char *new_name =3D dso__filename_with_chroot(dso, name);
> if (new_name) {
> is_reg =3D is_regular_file(new_name);
> - strlcpy(name, new_name, PATH_MAX);
> + strscpy(name, new_name, PATH_MAX);
> free(new_name);

Hi,

This hits a compilation fail:

In file included from util/symbol.c:10:
util/symbol.c: In function =E2=80=98dso__load=E2=80=99:
/home/athira/perf-tools-next/tools/include/linux/string.h:15:17: error: too=
 many arguments to function =E2=80=98strcpy=E2=80=99
   15 | #define strscpy strcpy
      |                 ^~~~~~
util/symbol.c:1896:33: note: in expansion of macro =E2=80=98strscpy=E2=80=99
 1896 |                                 strscpy(name, new_name, PATH_MAX);
      |                                 ^~~~~~~
In file included from /usr/include/features.h:490,
                 from /usr/include/dirent.h:25,
                 from util/symbol.c:2:
/usr/include/bits/string_fortified.h:77:1: note: declared here
   77 | __NTH (strcpy (char *__restrict __dest, const char *__restrict __sr=
c))
      | ^~~~~



=E2=80=9Cstrscpy" in perf tools is defined here: tools/include/linux/string=
.h as =E2=80=9Cstrcpy=E2=80=9D

#define strscpy strcpy

And this is introduced from below commit:

commit 9e3d665384fca2a1c56283c7a79a968243ef4614
Author: Wei Yang <richard.weiyang@gmail.com>
Date:   Tue Aug 6 01:03:19 2024 +0000

    memblock test: fix implicit declaration of function 'strscpy'
   =20
    Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
    memory at boot up") introduce the usage of strscpy, which breaks the
    memblock test.
   =20
    Let's define it as strcpy in userspace to fix it.
   =20
    Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
    Link: https://lore.kernel.org/r/20240806010319.29194-5-richard.weiyang@=
gmail.com
    Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index fb8eda3019b5..41e7fa734922 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -12,6 +12,8 @@ void argv_free(char **argv);
=20
 int strtobool(const char *s, bool *res);
=20
+#define strscpy strcpy
+
 /*
  * glibc based builds needs the extern while uClibc doesn't.
  * However uClibc headers also define __GLIBC__ hence the hack below


So the strscpy here is defined as strcpy itself.=20

Ian discussed about having an strscpy shim for perf here :
https://lore.kernel.org/linux-perf-users/172892779710.897882.14949543082561=
189584.b4-ty@kernel.org/T/#meaa2f8d993c6db435f9ed399dc1bf10132a31292

So IIUC, we are yet to have the safe strscpy in the tools perf.
Please correct if I am wrong. Were you able to compile the patch in your se=
tup or am I missing something ?

Thanks
Athira

> }
> }
> --=20
> 2.39.2
>=20
>=20

