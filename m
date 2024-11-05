Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B01D63EE;
	Tue,  5 Nov 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814815; cv=none; b=Sbnt764zw5vlXkZQFiAR9U7NeljSohnkWJ+ELs2PJQoJoII13qT3WpjIGQ+xUP9blktQe5kUiixTxp12PyOxio5ZarKivzbAmPCEfCJzW5VNdcBF73Fvfot858eL/atJF37W7Obv5CGSHU/T4LfIVy3uj/EXVu/mMcG9N3zDMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814815; c=relaxed/simple;
	bh=UsvC3m2JvvVYASUjWR0IgE6EmOJsUD6WK6mloPO4LsQ=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=PtjsFwojL1EcuNEBPG6tDgbhqCuCWwgmJczm5S36Jet11ThUY3LHyO3Hst0ldSNC8Remg1X14vT40ppuU2g0KXOj9G33oEcdlFYgNc5KCdaGHr2MqR7gw3zdLa45jy8kjTmhT8eUl9WsRL7o0dD6WZ9qOFv7UqyBfm2HDbDemIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G9HC5G/P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G9HC5G/P"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5De6qZ025769;
	Tue, 5 Nov 2024 13:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l0hkhG
	WWdLSxMBmOO+9gWFmOxAxKBPvD0qz5ng5GIYw=; b=G9HC5G/PMS4jKzMy8kZ0Ey
	d3KG+Ne8k5QBd7f7MO4VkiGuFJvF1upihxJdCr5AXQzuSOEnVKez2LJ2lQANsTiY
	udfUJ0njkQxejVqKJMw/xKMBOWS3Sjif0WiQ+EBNMDE0ATvkY83xPXFaWhwhosK8
	koJMwhXbFRyPwqrWsEayGpsazpeLYBgvRTTMhNy42y3Q8gUZ7YkgKHG02jTIUPgt
	zEH3Ad/N5OiTSP45UFWyeu9KOZuZBrYbLP3t2yGFs6jQtUFb/aOubkpFXCHBGxQk
	0dWTkq58gDZOi/LrTtCmvxrymes6q2uiImPtxEqgxhxy9P/VEEUxgJfWq7b6uoOg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qmepg2hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 13:53:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A5DrMCN030893;
	Tue, 5 Nov 2024 13:53:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qmepg2hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 13:53:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DLVDn023916;
	Tue, 5 Nov 2024 13:53:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsy8y40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 13:53:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A5DrJJ040370470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 13:53:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F4AD2004B;
	Tue,  5 Nov 2024 13:53:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D79BC20040;
	Tue,  5 Nov 2024 13:53:13 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.252.221])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Nov 2024 13:53:13 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH] copy_class_filename: replace deprecated strlcpy with
 strscpy
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241105071225.426026-1-danielyangkang@gmail.com>
Date: Tue, 5 Nov 2024 19:22:59 +0530
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
Message-Id: <B1BDDA8D-BD9F-4A4D-AE13-0D4902144DBE@linux.vnet.ibm.com>
References: <20241105071225.426026-1-danielyangkang@gmail.com>
To: Daniel Yang <danielyangkang@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d4wYiGxQJ-c8N31wQqugR6RTcV02frXJ
X-Proofpoint-ORIG-GUID: kwgg1pIi62c1u8sOyazCZtzOn6_Y5eOy
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050105



> On 5 Nov 2024, at 12:42=E2=80=AFPM, Daniel Yang <danielyangkang@gmail.com=
> wrote:
>=20
> The latest kernel docs:
> https://www.kernel.org/doc/html/latest/process/deprecated.html
> recommends replacing strlcpy with strscpy as the safer alternative. The
> value of strlcpy is not used so there shouldn't be issues with replacing
> the deprecated call.
>=20
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> tools/perf/jvmti/libjvmti.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index fcca275e5..04d6825d2 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -158,7 +158,7 @@ copy_class_filename(const char * class_sign, const ch=
ar * file_name, char * resu
> result[i] =3D '\0';
> } else {
> /* fallback case */
> - strlcpy(result, file_name, max_length);
> + strscpy(result, file_name, max_length);

Hi,

This hits a compilation error:

In file included from jvmti/libjvmti.c:3:
jvmti/libjvmti.c: In function =E2=80=98copy_class_filename=E2=80=99:
/home/athira/perf-tools-next/tools/include/linux/string.h:15:17: error: too=
 many arguments to function =E2=80=98strcpy=E2=80=99
   15 | #define strscpy strcpy
      |                 ^~~~~~
jvmti/libjvmti.c:161:17: note: in expansion of macro =E2=80=98strscpy=E2=80=
=99
  161 |                 strscpy(result, file_name, max_length);
      |                 ^~~~~~~
In file included from /usr/include/features.h:490,
                 from /usr/include/bits/libc-header-start.h:33,
                 from /usr/include/stdint.h:26,
                 from /usr/lib/gcc/ppc64le-redhat-linux/11/include/stdint.h=
:9,
                 from /home/athira/perf-tools-next/tools/include/linux/type=
s.h:7,
                 from /home/athira/perf-tools-next/tools/include/linux/comp=
iler.h:131,
                 from jvmti/libjvmti.c:2:
/usr/include/bits/string_fortified.h:77:1: note: declared here
   77 | __NTH (strcpy (char *__restrict __dest, const char *__restrict __sr=
c))
      | ^~~~~


My analysis/review for this is same as my response for your similar patch h=
ere:
https://lore.kernel.org/linux-perf-users/3CA737FF-2F21-42CA-BF95-5F0341F6B6=
8B@linux.vnet.ibm.com/T/#m619e016f6dd4abb1e1830580bdc74c86b4fcace8

Thanks
Athira

> }
> }
>=20
> --=20
> 2.39.2
>=20
>=20

