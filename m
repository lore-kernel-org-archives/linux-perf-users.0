Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75446202F7C;
	Mon, 16 Dec 2024 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343369; cv=none; b=Eb9sDgARNvWBeR+XpJfCa1RYfL11xMGctws4at03tEnjJ00X6sfWBGEbnWTNUo4RrucRrqXucU1PuyxuEspjqS94Ng14L1hAT1qkpbgljZKQ8On9kmbbDHwVN0B6UP20duKFDpovuKyumTgBQUmReDNnjzH9sDOzDDKQxCC09CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343369; c=relaxed/simple;
	bh=fdcJgULOjQL+Z6+pomzxQPrgHzhLspJqOhTDyxL5yBk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HTomKNTHliBvvtfcNX1TC86ttEsRcFlxWBitZBNXBFyIMmLTnYs0YGUZbNFVzgIS3hqWbuR19esozUqn1v+ruNHdSGLa6VIC5uvvTkoEO8cQl6V2rzjAr2aBJaI0yE1Li+6Tb3tTSxBxaPNmB0JfoVxs2unS3PwnuB2rL6jHad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T9pqEC0p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T9pqEC0p"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3qPq8011656;
	Mon, 16 Dec 2024 10:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GMfSVZ
	rUKd+3JsU6/oSzmVKPJb1iTEVgft5NcsULspk=; b=T9pqEC0p1qUk7+oYu3PIQq
	CSz5mDb6lSXiu2sX0KHl5RKrS7i6NGrXe4fhWxF/c4KlTTxeaZ22eMoC9fTpxNRc
	BoWbVYzCXD54smos6ME2OZx8228kApWFBt3vfO0BLgj96e3CZha7ecM8K1UPk+Q7
	mtoo1g1yaNSpQoaGtwfRwIwN+GIQAUyzo8gRkisJNnyhoPpFLRkwrBCkrpW4r/t2
	eW/2sl8bM+6sZmnX3hF86fKZBevqeQGgrUMqor/3HAfZzwwsR6RAv0P1gcmIAyNU
	3pezeX86vscGEMXEIS+RUF/in5XqFYoSS1coWy1ecUfcRnkmMHrkAx5NpnjtpsiA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb1h8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 10:02:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BG9vNn3003775;
	Mon, 16 Dec 2024 10:02:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb1h8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 10:02:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8JUWY029329;
	Mon, 16 Dec 2024 10:02:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsdk8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 10:02:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGA2Ykw48759252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 10:02:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D76020063;
	Mon, 16 Dec 2024 10:02:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F192005A;
	Mon, 16 Dec 2024 10:02:27 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.124])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 10:02:26 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf/arch/powerpc: Add register mask for power11
 PVR in extended regs
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <2907ca2f-b973-42fd-ae03-99732dfda7a1@linux.ibm.com>
Date: Mon, 16 Dec 2024 15:32:12 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0402AAF0-5498-48C7-BEBA-2C0B7508D9E2@linux.vnet.ibm.com>
References: <20241206135637.36166-1-atrajeev@linux.vnet.ibm.com>
 <2907ca2f-b973-42fd-ae03-99732dfda7a1@linux.ibm.com>
To: kajoljain <kjain@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r-IvdmR-sjJKaBbc_LpFv8jeup8W4K4o
X-Proofpoint-GUID: pkGSb33H05pQcJrbwsQWXg2E2tI0LIeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160083



> On 11 Dec 2024, at 5:32=E2=80=AFPM, kajoljain <kjain@linux.ibm.com> =
wrote:
>=20
>=20
>=20
> On 12/6/24 19:26, Athira Rajeev wrote:
>> Perf tools side uses extended mask to display the platform
>> supported register names (with -I? option) to the user
>> and also send this mask to the kernel to capture the extended =
registers
>> as part of each sample. This mask value is decided based on
>> the processor version ( from PVR ).
>>=20
>> Add PVR value for power11 to enable capturing the extended regs
>> as part of sample in power11.
>=20
> Patch looks fine to me.
>=20
> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

Hi

Can we please pull in this patch if it looks fine.

Thanks
Athira
>=20
>=20
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>>=20
>> tools/perf/arch/powerpc/util/perf_regs.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c =
b/tools/perf/arch/powerpc/util/perf_regs.c
>> index e8e6e6fc6f17..bd36cfd420a2 100644
>> --- a/tools/perf/arch/powerpc/util/perf_regs.c
>> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
>> @@ -16,6 +16,7 @@
>>=20
>> #define PVR_POWER9 0x004E
>> #define PVR_POWER10 0x0080
>> +#define PVR_POWER11 0x0082
>>=20
>> static const struct sample_reg sample_reg_masks[] =3D {
>> SMPL_REG(r0, PERF_REG_POWERPC_R0),
>> @@ -207,7 +208,7 @@ uint64_t arch__intr_reg_mask(void)
>> version =3D (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>> if (version =3D=3D PVR_POWER9)
>> extended_mask =3D PERF_REG_PMU_MASK_300;
>> - else if (version =3D=3D PVR_POWER10)
>> + else if ((version =3D=3D PVR_POWER10) || (version =3D=3D =
PVR_POWER11))
>> extended_mask =3D PERF_REG_PMU_MASK_31;
>> else
>> return mask;
>=20

