Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2E1372
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742630788; cv=none; b=Dv1Wee0b3uWpsWWLyWtqW7CdZfhyO7xQo35hKlz+kaiass//o18S2so1+z2VTz87DfCDODSKv2BOeNV24GpsflpGr+kj4b45zVNQLwQ01rpu/yvFUKhXyyUOe8CDG0OCdasi3ZaNhTO5S5EnA9KRUJIu3gN7xYf+dyouVx/GGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742630788; c=relaxed/simple;
	bh=QCohz+Z09lHNeaj0NBH3GCU5saL80AcJx3UHc7p72ks=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ESumKOirn+EIkX9ap6XKJp98h5UqpqnJsPy3ZH0tEuXT0MFBCtI/bezMwTlq/+douB223tILnbssXMZSstifonWzjN80pVAeJXUsFCNW2fZlzb3rR0FWca4+IsTubdhren1jRgAqTOCneTZ22h6ZKsSl+noeWnBfr+ye/NdM8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hRjU5uzW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hRjU5uzW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M3grr1030610;
	Sat, 22 Mar 2025 08:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HDF6RB
	kHi6jkmsGpsNlDQxqjfPEGr06K1bqndAdkZrE=; b=hRjU5uzWlzcuzH8MODT3qe
	fKxnjokaZhPxJs7KJlwaSj6OejNWtTv4ZumW730bPpuxCwO80gLamlooJicO+yn5
	VnDfupzgMxKWLXCbk4oJRHQWAYITC1Sxt4vT5zw2nQjzaRXe8x2XIZeayDwxeMdQ
	otVZxJN0MM2zOkqrG4mFBSjvuCEHBHZdhoOdPHH33frOidtJS8Pp5z95NpDgLK+u
	hLS18CSkGJUH25Yg6XxD0IXCIKUSm++kVrEzfOMbEDbmO4W+USwJHuTSnmaTFQo2
	yB/X84lQkzY2cuCv4/ENMWfCMNfqBMb/z4V6+cbNSBWypTLCVsdPmWU8oOr/TBPA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45hngm8nk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 08:06:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52M86Frf020527;
	Sat, 22 Mar 2025 08:06:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45hngm8nk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 08:06:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52M3JT4n009157;
	Sat, 22 Mar 2025 08:06:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45hn6grrn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 08:06:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52M86B3C40042902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 08:06:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D6520043;
	Sat, 22 Mar 2025 08:06:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD63A20040;
	Sat, 22 Mar 2025 08:06:06 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.245.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 22 Mar 2025 08:06:06 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] tools/perf/arch/powerpc/util: Fix is_compat_mode build
 break  in ppc64
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20250321100726.699956-1-likhitha@linux.ibm.com>
Date: Sat, 22 Mar 2025 13:35:52 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <22675B19-F5B4-4CAE-A320-58F42107FE44@linux.ibm.com>
References: <20250321100726.699956-1-likhitha@linux.ibm.com>
To: Likhitha Korrapati <likhitha@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2JNeXZHijJWmfC985k7YiPTooY6kTnLa
X-Proofpoint-GUID: kzU3Inqd7PhIS0v3e2c2d-QdoJ4TDbCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503220056



> On 21 Mar 2025, at 3:37=E2=80=AFPM, Likhitha Korrapati =
<likhitha@linux.ibm.com> wrote:
>=20
> Commit 54f9aa1092457 ("tools/perf/powerpc/util: Add support to
> handle compatible mode PVR for perf json events") introduced
> to select proper JSON events in case of compat mode using
> auxiliary vector. But this caused a compilation error in ppc64
> Big Endian.
>=20
> arch/powerpc/util/header.c: In function 'is_compat_mode':
> arch/powerpc/util/header.c:20:21: error: cast to pointer from
> integer of different size [-Werror=3Dint-to-pointer-cast]
>   20 |         if (!strcmp((char *)platform, (char *)base_platform))
>      |                     ^
> arch/powerpc/util/header.c:20:39: error: cast to pointer from
> integer of different size [-Werror=3Dint-to-pointer-cast]
>   20 |         if (!strcmp((char *)platform, (char *)base_platform))
>      |
>=20
> Commit saved the getauxval(AT_BASE_PLATFORM) and =
getauxval(AT_PLATFORM)
> return values in u64 which causes the compilation error.
>=20
> Patch fixes this issue by changing u64 to "unsigned long".
>=20
> Fixes: 54f9aa1092457 ("tools/perf/powerpc/util: Add support to handle =
compatible mode PVR for perf json events")
> Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>

Hi Likhitha,
Thanks for the fix.=20

Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks
Athira
> ---
> tools/perf/arch/powerpc/util/header.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/arch/powerpc/util/header.c =
b/tools/perf/arch/powerpc/util/header.c
> index c7df534dbf8f..0be74f048f96 100644
> --- a/tools/perf/arch/powerpc/util/header.c
> +++ b/tools/perf/arch/powerpc/util/header.c
> @@ -14,8 +14,8 @@
>=20
> static bool is_compat_mode(void)
> {
> - u64 base_platform =3D getauxval(AT_BASE_PLATFORM);
> - u64 platform =3D getauxval(AT_PLATFORM);
> + unsigned long base_platform =3D getauxval(AT_BASE_PLATFORM);
> + unsigned long platform =3D getauxval(AT_PLATFORM);
>=20
> if (!strcmp((char *)platform, (char *)base_platform))
> return false;
> --=20
> 2.43.5
>=20

