Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B644A40A;
	Fri, 28 Aug 2026 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918387; cv=none; b=s5Zut7rXWbqifE9UocsPM0zUyeCoEv4Evj9JJPAQ08Xs3gt52ZV2HpAhu0k8bq4s2Xe6VJAyDjMkO2cltnPmg1Df0t6qcf5XOFeJDkhFJRCD7GNjPG34LNLGiI5+8JPQLyb07jSIHgL3dJkoOaZcMbTDh/MtaCp1xS4iEW5fj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918387; c=relaxed/simple;
	bh=7/FYmHTxFJFe0LbcTjqiwV17AgYCBMgEB6cNbf2DWv8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IRz+9CT2M1hSyEZw2qyRhqmGoclaGnx0XHL0KRgqHfsBoSPRXL3Co3cJHlC/MDtG2/LuzSIzWEqb/zUfTNK90qIg1ItDrsSECdCnJLL3fauZJVWraca10ZaeFEAUtjk3JdCoifQztVHLR/7Q6X9rvRQcNd/khpOgSiDD7Q4RA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0bpCAt2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0bpCAt2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAVfnq602751;
	Fri, 28 Aug 2026 11:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Taxb3J
	bSUnHxLpAq+NwKO8fodpIhxdVmldoDuesMewo=; b=F0bpCAt2FUDhG0FtGnlwRe
	C3quCKPHckHXRMZ26vd7+RvCIy6dnLJkL03aYVPQz4XePy+XNV3N9BHsiToaUZR1
	sO2wb/EG37JI90LfN/mNSHVCPBezDx0cgV4yYE/6awpOAIg1mrvZzWhMpjfa4tSn
	Bu/mC521+YG/ivvaenc6uGbAmAEiWncKxoo5Y/5BMlMeJAf66wLrzr/qquPFZUu7
	6X2EaCUZSkJlYtpRotkKdnP+ChRHEuRl5FHHabMFPeh3ILv9VPRL7zvwAS7gyqjg
	LK+aQPnV6NkU45SRuRSOitR75rwJkC20uBEIIEMYbAjsUeCunycmz16EpLp8wZ0w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726f3sdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:59:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBuNrE027683;
	Fri, 28 Aug 2026 11:59:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhnw38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:59:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBxFlA35783132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:59:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A42320040;
	Fri, 28 Aug 2026 11:59:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3846920049;
	Fri, 28 Aug 2026 11:59:12 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.217.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Aug 2026 11:59:11 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] perf powerpc-vpadtl: Fix raw_size of DTL samples
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260825094733.1031566-1-wangyan01@kylinos.cn>
Date: Fri, 28 Aug 2026 17:29:00 +0530
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <85CF9B6A-8E46-4D5E-8AAD-A9B3B75DF6BF@linux.ibm.com>
References: <20260825094733.1031566-1-wangyan01@kylinos.cn>
To: Wang Yan <wangyan01@kylinos.cn>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a917816 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Vx405MAVRAb3j5YeDM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX7BAzKchEOTys
 O8SdSJADNHNIae1cubyWzEF4HV7a/JRFr2BwTqQUHzhRGwPTE3d54NL4BZ9pAm68Jq5F0YC/3s8
 3P8DYcT8uMKL5ANAHOILPLWbDqUMKyM=
X-Proofpoint-GUID: IrGW-8fw8acYqpFLg_KVf6UEAxEH91qX
X-Proofpoint-ORIG-GUID: QYkxM62rP70sNU17MCjVUXbfnGeuvVvG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX8ZEnRlM/EkCC
 CnGrbOHuSEje2Aj7MCofY5rJxoAu3uBl4RVL0UdtphXXyYnKQdUuO/pcOyrv3fgKEZPU8sDRzzm
 nq2Pr+wlP9OOkPPe9OGFMQiJ7uGN7dfvGpGiekA172CsjnJnBYkXzPNBxzgq19THj9uMdDv/o2q
 alk6Yr/Rs44F5SjTF6UESTBlGZNoMWWODLgBAm41Kuwr+hi2u1WC84n5McYpNHuZYklwiKS1oPd
 4LZe/EDBaMmoMtqFURxlZWaTh5MtuoiMmILHEZvq26pz3GMNS/w8Or72LgGWVpebGMWZMKlp1aM
 /4h2Jm0AeA/fUDYPIUzm1aW6Z/AebaBMwoV3GI5Nnv67kFxBRTHYpy+sM0X8fSFJUhdVRcg6fD2
 HgyU0mCgyVd3ayBWtsKZA1dkZwVL5/RmmwmKjFs3YF6UHuuo0eaGMiTp15V/mR/WKzJIbgg1e+Y
 v42NZpxsvyAPU40R3WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099



> On 25 Aug 2026, at 3:17=E2=80=AFPM, Wang Yan <wangyan01@kylinos.cn> =
wrote:
>=20
> In powerpc_vpadtl_sample(), raw_data of the synthetic sample points to =
a
> struct powerpc_vpadtl_entry (48 bytes), but raw_size is set to
> sizeof(record).  record is a struct powerpc_vpadtl_entry pointer, so
> sizeof(record) is the size of the pointer (8 bytes on 64-bit) rather
> than the size of the record itself.
>=20
> As a result, consumers that bound their access to raw_data by raw_size
> only see or copy the first 8 bytes of each DTL entry instead of the =
full
> record.
>=20
> Use sizeof(*record) so that raw_size reflects the actual length of the
> raw data.
>=20
> Fixes: 8644834a482a ("perf powerpc: Process the DTL entries in queue =
and deliver samples")
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks
Athira
> ---
> tools/perf/util/powerpc-vpadtl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/powerpc-vpadtl.c =
b/tools/perf/util/powerpc-vpadtl.c
> index 710f3093f3f9..af6783cfdb53 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -196,7 +196,7 @@ static int powerpc_vpadtl_sample(struct =
powerpc_vpadtl_entry *record,
> sample.cpumode =3D PERF_RECORD_MISC_KERNEL;
> sample.time =3D save;
> sample.raw_data =3D record;
> - sample.raw_size =3D sizeof(record);
> + sample.raw_size =3D sizeof(*record);
> event.sample.header.type =3D PERF_RECORD_SAMPLE;
> event.sample.header.misc =3D sample.cpumode;
> event.sample.header.size =3D sizeof(struct perf_event_header);
> --=20
> 2.25.1
>=20

