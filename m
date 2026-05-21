Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C1332EA7
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345450; cv=none; b=Age0l9F99lJhl/XCEx0ozIDr2CdjRJl1XpDp+2W3GwG4ZBTWN6/upU8mRX1CpecuCzgvxiV0X8rW8BsDbHXibsokWuvTQTWyZpGPnprvsjrD+T4AK81PmEQCUOPPTys/jrO8XF2hj+E6rtWCCAKvEqbuPCTK5CzA2mhXJ4Cp7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345450; c=relaxed/simple;
	bh=Bd4VFCODXTw79T6XjyCRIQ8hpjRnHr49ASGlZQzO6bs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=b/uvGEHlPoPBgj6szmQBhayh85lf/wS5v7ijdah+WYHDOa1hqcgTMPMgPADnTDr0dm3b4ZqHzR0KmL8eqi6o2TqEum4TtWe7KeltfpTNqOGdQ//9ZJ5+tW6TEYEwLA8MgfNXL7d6XPHO9P80S99sqNneNpGdhxdwCANlj2NjlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A9wcFjCu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A9wcFjCu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L56K45069859;
	Thu, 21 May 2026 06:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YFsFm1
	NmZNSdFNO+pi8r6SX56LEQ8AyHEDEPH5ey5F0=; b=A9wcFjCuYaPtuiIHkx9Mh6
	PhDPM8IP3dXa8ZjiOOFvgK0fMUiFeKIoKREXT1BW3a4hGVno9PIK/iyyND7aWMvU
	Qh+EdaaZKR+2u1kM42yJ3vffVn5ET/Z5x+4gkj4jLz40MR4x78lgbydyxCnowqJy
	nI11jfRnhfltjKtgVSRONrmP5BiIqhEMkhtewFJYKseByVvABnfqweXxYHKE1sLf
	34MHYYKKUouhcW9LXAsQMKQCZ09gizupbrzmHnTQN17Cl5nDg8ETvRUghnKRzCZo
	GFCv4A5ErV9tzV1FYDHCMi1v/jMUEIxKTqAWvAWIxbYI9ckwNrVVoxtX3NekBfQg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mweju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:37:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6OA31030836;
	Thu, 21 May 2026 06:37:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqb12f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:37:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6bHpc46465322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:37:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1378A20040;
	Thu, 21 May 2026 06:37:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B06720043;
	Thu, 21 May 2026 06:37:14 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.10.78])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 May 2026 06:37:14 +0000 (GMT)
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
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260504154205.21394-1-atrajeev@linux.ibm.com>
Date: Thu, 21 May 2026 12:07:02 +0530
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, shivani@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, mpetlan@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D09EA54-8065-48C2-B1DF-95D2AA15C6B6@linux.ibm.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rsCSKfZvaYNi4w954FtQjTt6QN_pNTWS
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0ea821 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=pavtPC5taW5ojbBlbRgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8MXwiBs44qM_NNVds_T3PAmwmnnZop72
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MiBTYWx0ZWRfX9AxNOkUgepOj
 fapOFqi66eCSI+cqSRWp0nStiGIO8xXLUSmTpRnzSroaiW1qUUjaKkrFTuT5E1F5Mdppp+eo5y9
 /535FZvsl56QxwAatCBdcJj7+DDXbkk3h62zB+iaCydV35QB+kujTG6F9cR6PKM93hAg07gjITl
 NdZT4j9PUE7h5nZZmzj6icza8py2yt18/vMQyV76ATQJ88zH5UoMoXpMqCK3n2NHyiD4lX9oNUu
 6NDX6oCrKDw/vPCv8U0y37YaToQzSW7ZziGuf9oioE0iS+MsCuy2dFFr+HM5yTFm/BaaiGffsTh
 ZGL8cq68RGpyTNpQ58yLB89YkLkseb3M6k2cGrywjw+R2yaCOiOcA87fUrV0Ae2qIohcdzZYOYv
 W4ywO5H7pPpQUs8FxsBYJkpF+7JVT9thJpzFdHjUXe5V9I7xaPuX2ytYiqGME6Un2Qi2hi0Of36
 xzSTAOYY4Rn6rgVf0HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210062



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

Hi,

Can we please have this pulled in, if the changes looks fine.

Thanks
Athira
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

