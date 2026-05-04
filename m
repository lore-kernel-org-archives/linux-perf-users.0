Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69F7E0E4
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777868230; cv=none; b=BSNQETuDdYn7bwnkK6vwJweqM9zgkB5XAjKYxpLTbkaSPerhyQWGoGq66lhTPG9lbBIjgtgGBSVpt3Q9izpiZ0E+zWFv9jg4znBO9JhKFu4ozOgQGsCH/XDV3GvqXauKnTdWx9sikTCv51c2TRzzOpofSjQCL2CS0GJ40csW3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777868230; c=relaxed/simple;
	bh=4SQmGh+2z3H67UJe7vYt2jltgmf1YA1gyVNsdpJ5e3g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JOpWRvI1aazTvUGCb1dl0J7mteSzg31VsXcYrG7wh5bJe5zceD0BB1KurnK1D6aOSn9QWXh01GymoCtp9wSJmO+5bCustSW+nBw4T+mg71rRz6d8g0SUJ4EiRJDLx217qog6mJhRKIrdVuB3DXl/q9MZzp8gHKwTM82bLKw2bzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pe8p2gG1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pe8p2gG1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6433TV40855288;
	Mon, 4 May 2026 04:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+LuKhD
	3yYhMAI47caqKiKblQEr4RtiQBIb2L/CFhkNg=; b=Pe8p2gG104pWLvs1gLx7w4
	kcEMGCbopaEW/tgti3tdSsgGlb2xdxK7lsc2RIKCvMb8dd6Eo30omp6jfTvCcVmO
	3bYUg9Bq+iDpR+mBhzrAlU1M398rFMKjoAMrWcrPvnQ5YQ8MUBR9XQjlakGU9d0u
	hFbHp64YrkOiX2RppaXzx6nPo08pJy/ZXT8vK01SNhmko8seegDlc6Inp5DUi3ZL
	73ObM5HbAuSo5+GJR5GUKSw3oF6q28nbbrDPsW7hEImvlhTf1tSutoGddRmMid6D
	IY2sz0Tr7rLgBj228YA37RKNFT8cY/dyvWICIAoqLzVqGIPu3xzqAwkXwHH2fbQg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v75eyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 04:17:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6443uY7H014222;
	Mon, 4 May 2026 04:16:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3guj14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 04:16:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6444GtvD48103688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 04:16:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB6820043;
	Mon,  4 May 2026 04:16:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B233620040;
	Mon,  4 May 2026 04:16:51 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.20.162])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 May 2026 04:16:51 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V4 2/2] tools/perf: Add kernel-doc comment to
 auxtrace_record__init() function
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <aff6kjIr-KL3Onuw@z2>
Date: Mon, 4 May 2026 09:46:38 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D38B0F5-0E9C-425D-87E5-5885B18981BD@linux.ibm.com>
References: <20260502143237.23456-1-atrajeev@linux.ibm.com>
 <20260502143237.23456-2-atrajeev@linux.ibm.com> <aff6kjIr-KL3Onuw@z2>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA0MSBTYWx0ZWRfX1Y7d5lU5KmG6
 p6uNLbcFh61wktFgDM6cfrREK607Ennybqvn+vi/TR32syNBSXlr9n0nG3/3DfNDqJcExJ2WsG/
 pywaUcnWXrBJCVcruV19/q3GSXMCIIV4NaeZ3HWMF5GqPlptEIcY1LrR+2LfAZo+/7qt6eKyDMN
 s/m+5OKSB6f6MEEa7NJaLQ1GWfIG32plCXYo6bnXZ69KZfRRCZwTWR9SdMQxd3ot/BEPLRm1Ogn
 QC07bK02u1aMR2frPLyDeFawTdXJhbEMsJlcNAKI51Z3lgCOP6rPPItBmueQaKg8nby/4Prqoa0
 IVtGhVtBw+F5ZUzUmS/rx+F1GV6BG1pA2xm4VtykKDHHfog0cn9xMI3WAKCxF6SWos63AiPCWTf
 1r8Kx8Z2PjvQ433J+CHiqxqWY7RTM0CJRVWQKTlB/zr2CZt/cGywcNSJmhr579eV33NbfSNCH1U
 k0Pr8J3XxQRlm+akPTw==
X-Proofpoint-GUID: OdQOp-fq0pV5DJtyzHTedW-f52gjXFm_
X-Proofpoint-ORIG-GUID: aYHtiTrpMX4Lid_9H5EWISRr1ZhLAsBy
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f81dbd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WYBppRGt9Tx3A1cNM9MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040041



> On 4 May 2026, at 7:16=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> Hello,
>=20
> On Sat, May 02, 2026 at 08:02:37PM +0530, Athira Rajeev wrote:
>> Add documentation comment describing the parameters
>> and return code for auxtrace_record__init() in util/auxtrace.c
>>=20
>> Using "struct evlist *evlist __maybe_unused", gives below
>> warning with "scripts/kernel-doc".
>>=20
>> # ./scripts/kernel-doc -none tools/perf/util/auxtrace.c
>> Warning: tools/perf/util/auxtrace.c:912 function parameter =
'__maybe_unused' not described in 'auxtrace_record__init'
>> Warning: tools/perf/util/auxtrace.c:912 function parameter =
'__maybe_unused' not described in 'auxtrace_record__init'
>>=20
>> Updated  parameter as "struct evlist __maybe_unused *evlist"
>> With the change, there is no erros/warnings with kernel-doc
>=20
> Hmm.. this is not what we used to have.  I'm not sure if we want to
> update them all.  Maybe better to leave it for now.

Sure, I will keep it as original version.

>=20
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> ---
>> Changelog:
>> v3 -> v4:
>> Addressed review comment from Sashiko:
>> Update return value expectation for fail as
>> non zero return err code.
>>=20
>> v2 -> v3:
>> Addressed review comment from Sashiko:
>> Update return value expectation for success and fail
>> correctly.
>>=20
>> tools/perf/util/auxtrace.c | 17 ++++++++++++++++-
>> 1 file changed, 16 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index a224687ffbc1..9e11cf4299b8 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -896,8 +896,23 @@ int auxtrace_parse_aux_action(struct evlist =
*evlist)
>> return 0;
>> }
>>=20
>> +/**
>> + * auxtrace_record__init - Initialize an AUX area tracing record.
>> + * @evlist: The list of events to check for AUX area tracing event.
>> + * @err: Pointer to an integer to store return code.
>> + *
>> + * This function looks through the @evlist to determine which AUX =
area
>> + * tracing hardware is being used and initializes the =
auxtrace_record
>> + * structure.
>> + *
>> + * Return:
>> + * a) A pointer to the struct auxtrace_record on success.
>=20
> I think you should mention that the this function should set *err to
> zero on success.
Sure, I will update this=20

Thanks
Athira
>=20
> Thanks,
> Namhyung
>=20
>=20
>> + * b) NULL with @err =3D 0 if no AUX area tracing event is =
found/supported
>> + *    (not considered an error).
>> + * c) NULL with non-zero @err on actual auxtrace_record__init =
failure.
>> + */
>> struct auxtrace_record *__weak
>> -auxtrace_record__init(struct evlist *evlist __maybe_unused, int =
*err)
>> +auxtrace_record__init(struct evlist __maybe_unused *evlist, int =
*err)
>> {
>> *err =3D 0;
>> return NULL;
>> --=20
>> 2.47.3


