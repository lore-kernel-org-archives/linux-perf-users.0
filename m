Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1F39449C
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575997; cv=none; b=mQu/VsnA7juHA4e1LpBO63lcTnwFiZ2zDxf6f5EkUjGmzrrIy1PogbD7WrZg09X0+vNjy1A97pdqLTySasHf1quwXZfBnNWU9wfXhB1qsOg+ZMnHYvdd6KS6JyKlLm7i1erqEtfVsxv2i++L0n07J8fdm23gvzAO9Oqd87gV3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575997; c=relaxed/simple;
	bh=sMh/hkO7bJWyLZ6VErb+MuLHZ2R/dLoSoDLRlFYTP2A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k1wJvBtXCZLdznJ9hOsZmMtJikxqEf7jyGeC4z7FLkGSm4jeAxwLDBNG3q9pN2C5nePFiePJpd4DmCnMZ7ir7NqY/KKJCXIWlszVtu4U+5jPxwxGCsaGJQwjK9As62acywAsb37Oph1EvvbV+XP7n74Os7eOHj2qKRLyD5/wMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hJYvFx9Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hJYvFx9Y"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6qhd2607277;
	Tue, 12 May 2026 08:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eZc3uN
	oEL/uKtPTMromxFjx6kMpuZDZaR5NkP8zxJqo=; b=hJYvFx9Yf8Gk5MKHv6kjgG
	u0XS2AtjGLCfT1zx+cn0jFT71pk1Thric49nkFZjWzugMIUdvEYwwdxn1xWPGEXO
	Gwz2CVQNZh6LxoKQNDsHcd+kxn4BeYJQ/vYbcrBaLdr7DExTXV3sV7pk0DVLjrm/
	CEMvyPrrinHJMw13k442f/uKHI1IPT7gS7YvgCM9rj6AMirqLKoLM4dt7tD0yoe4
	QlJJv/nddgw8UygWTf7y7R7t9XXlCUhGdrLIJ3asTg6K4rNMTjROaBIhJcjK51wC
	FvaZ5yg6SLuHZRMZoiPEbgwkC6MQden2MzEGKWH5SeFq0ktcSShGWL1edKM+qeYA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv527r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:53:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C8dNEq012190;
	Tue, 12 May 2026 08:53:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjcuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 08:53:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C8qwqO34669246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 08:52:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EE645804E;
	Tue, 12 May 2026 08:52:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147BE5803F;
	Tue, 12 May 2026 08:52:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.10.165])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 May 2026 08:52:52 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V4 1/2] tools/perf: Fix the check for parameterized field
 in event term
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260504154205.21394-1-atrajeev@linux.ibm.com>
Date: Tue, 12 May 2026 14:22:40 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FE86BD2-554C-402C-80A2-C8F86FC2F685@linux.ibm.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
To: Athira Rajeev <atrajeev@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4NiBTYWx0ZWRfXxM/GFRstIpsX
 1oPyVQIg85G1wuAmr7P7UaH/LxOSXyahbAWBkmVbi8D7O5Xenlyu+xuxWnItYX1NgXcUj3ll9+a
 NcpzhwKLCkHvjwuQeURYt1QLmNEXfBY06AhTA/Og0ilnNO2lUpQUZC7vPYm61vNudeMGsSN7vdF
 h0oQ7NgBdQI5fkh7sP59oFffeXjxWkT0BUhX/tL4PHkXVOIf/eMuGdbNnHAqiCS6GICeylyJfcP
 EEvyZ/Mv6wh6nrc3yqM/QhODWbkcO0BxbmyyS9qrF8cx7ZKVCWM0E1VJOnMNIcGEQZrYiZJQc3L
 vuc72mS5trnP6ZubrUn2m/5ZmQ4jYNCGzVDFONcNUxkjeJcYD4caQqu14VSZqdWyjLciOPPa3v9
 Su+P8i4xJn+KAfpudLfdIEGK2/qFWPTQc+O2Ocj/Ta54oThpyk7vRcGQujpCEcxsh8UTO/ohKvv
 0Y1adfz48GS5Y2i75VA==
X-Proofpoint-ORIG-GUID: 41Sw65vucVvWl5GoTvZorxwU4QtZb83L
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a02ea6e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=gn8oeiLMC-0IUWM35G8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bwJvMwdIKraFPcjoz76QfOEeY-Kyyo96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120086



> On 4 May 2026, at 9:12=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
> The format_alias() function in util/pmu.c has a check to
> detect whether the event has parameterized field ( =3D? ).
> The string alias->terms contains the event and if the event
> has user configurable parameter, there will be presence of
> sub string "=3D?" in the alias->terms.
>=20
> Snippet of code:
>=20
> /* Paramemterized events have the parameters shown. */
>       if (strstr(alias->terms, "=3D?")) {
>               /* No parameters. */
>               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>=20
> if "strstr" contains the substring, it returns a pointer
> and hence enters the above check which is not the expected
> check. And hence "perf list" doesn't have the parameterized
> fields in the result.
>=20
> Fix this check to use:
>=20
> if (!strstr(alias->terms, "=3D?")) {
>=20
> With this change, perf list shows the events correctly with
> the strings showing parameters.
>=20
> Before the fix:
>=20
> # ./perf list|grep -w PM_PAU_CYC
>  hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]
>=20
> With this fix:
>=20
> # ./perf list|grep -w PM_PAU_CYC
>  hv_24x7/PM_PAU_CYC,chip=3D?/                         [Kernel PMU =
event]
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
> Changelog:
> v3 -> v4:
> Updated commit message to show real example
> addressing review comment from Namhyung.
>=20
> v2 -> v3:
> Split the strstr correction in a single patch
>=20
> tools/perf/util/pmu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..0b8d58543f17 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>   skip_duplicate_pmus);
>=20
> /* Paramemterized events have the parameters shown. */
> - if (strstr(alias->terms, "=3D?")) {
> + if (!strstr(alias->terms, "=3D?")) {
> /* No parameters. */
> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
> return buf;
> --=20
> 2.47.3
>=20

