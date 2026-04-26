Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9F1EFF8D;
	Sun, 26 Apr 2026 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777187559; cv=none; b=aQ7HGgQXiWiKMZ1ybnfjYVEG4wRyZKbd7Itgu3LUTyVp5wgT01cHkxMR8Hnv8Ms56p65al3V5JJse8tVFcBaVRJJIrO7+Nnyfs49xUjLK9OTKJH7+I1WCF1QGfxNtx+UEc+u3IDBpRXIg1ZhrDQBVS+HSmLBMEc5na9rO0eNIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777187559; c=relaxed/simple;
	bh=dqE5MUCFJra4dCbIabBvsYymBm79pCBFyyOgkKeaizA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tkGUuFZ3BnEOA4/NmbMiv4A3NNzndaaEroun1woOQ9Xy8jIu6DtRsGkA9rU1rSVQxCgQy6tL34ET4Aj0hni4vESvsWUkOl/SCDBRT+Ds9bCdN//Jv6uL2hca0QD2R1Ld5xsG9Z8G5V0HKJgddNFz+7j0+LGxQTmaTXHNI/JQKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ACRR5+Kj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ACRR5+Kj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63Q6mg2i2057613;
	Sun, 26 Apr 2026 07:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fPYI1s
	VYegqLXFdms/MmwRFA6pCSoqbKL3mvKn888zU=; b=ACRR5+KjfR6H6FrP/tobIe
	/Fgxxh58bz0pYffh1WsnKT2UX6y4EYXVKDoW9LGEmq+sBOIM+UtLWaNGTeZK272N
	VNW0na/aLKI1Rn+HMeCHyeMj2H26yGAeLisBuBBAJzWf0HoiOD7C2kQrJ+tdvgNn
	NUvqd4yauEyzpVDjjXyQgeL9O9DywQriypJEbKIzBGAY+3m+4fblpJYWhyBDYEB0
	7ZaIXx9hwBU/sQdenxrCAMzfhyK6XVQeI9/+2FUx8b9wgnHcJIz5eCrPKacKouxJ
	9WKhhNIZMSF4TNOFTBW1g78+hO3OB1KIuEywz8sZkMPGeyr0MtQRhltqCmbpu3vQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb4urdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 07:12:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63Q799QN020871;
	Sun, 26 Apr 2026 07:12:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq0v1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 07:12:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63Q7CZ1N24576466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Apr 2026 07:12:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 161B320043;
	Sun, 26 Apr 2026 07:12:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE722004B;
	Sun, 26 Apr 2026 07:12:34 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.219.109])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 26 Apr 2026 07:12:33 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2] tools/perf: Fix the check for parameterized field in
 event term
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260426045219.6AB15C2BCAF@smtp.kernel.org>
Date: Sun, 26 Apr 2026 12:42:21 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A2BF3B2-9DF2-43A5-93A6-C30B4AE39C78@linux.ibm.com>
References: <20260426043006.48113-1-atrajeev@linux.ibm.com>
 <20260426045219.6AB15C2BCAF@smtp.kernel.org>
To: sashiko@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69edbae5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=5CRW4Vl6K16SB2rdQKkA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDA3MCBTYWx0ZWRfX/F8CNdkjBUrA
 0RDUrwPeQG5H2zR1f/RCWWsvoyDwuWjjFr0Qj4jx4+pvAAOVdQJWJKlGhT6jWYzUJPBbfvEfkfV
 x5x5dXGXRXb2qV8ymrAdExsDTxTPvNbOwAa3fNarq6I2/xpfD1bONfvFVRwe/Nn0SK1q78Q9OyZ
 h6Q8+Aw8CrR98wClGpzIFjBTrX2u9X0BkMbvduCN7An7WVMYHQneaAOjFxHlDBZqTkLAfUCOdyP
 mIosgYIgw2OmA8hIbmlxJphYwz9n5bADYWobSs0+tvB5J+ShUIIodmiYmU9em98PjkT/VPdOf/g
 4K6nr5nEU5wiXJ/gyqndEChnfnio8Svr7aPff9GuU6Za6lmgP2GpSGjizOO+Rt7p3K8ay0ayl8y
 o36FG9b466NswcLSWZQqd4NjhFk/uAiR0XZ55TCQESzhuTOY8CpEGoylnMMy0198sUgwsjcbw5M
 WPZmcfSbzxRXjw6E0Ig==
X-Proofpoint-GUID: ANYojQoAnHKXT-gL3a1GYLD80xbWBO4J
X-Proofpoint-ORIG-GUID: ANYojQoAnHKXT-gL3a1GYLD80xbWBO4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604260070



> On 26 Apr 2026, at 10:22=E2=80=AFAM, sashiko-bot@kernel.org wrote:
>=20
> Sashiko AI review found 2 potential issue(s):
> - [High] Stack-based buffer overflow in `perf_pmu__for_each_event` due =
to unchecked `snprintf` truncation underflow.
> - [Medium] Meaningful code and commit message mismatch regarding the =
substring check.
> --
>=20
> commit d8e4b8dc1bd869d8438cc91880ce9791dc581a82
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Fix the check for parameterized field in event term
>=20
> This commit fixes an issue where the check for parameterized fields in
> event terms was incorrect, causing them not to show in "perf list". It
> also updates buffer sizing logic to use scnprintf instead of snprintf =
to
> prevent out-of-bounds writes.
>=20
>> Fix this check to use:
>>=20
>> if (str_ends_with(alias->terms, "=3D?")) {
>=20
> This isn't a bug, but the commit message states it is using
> str_ends_with(), while the implemented code actually uses
> !strstr(alias->terms, "=3D?").
>=20
> The code implementation appears correct since parameterized terms =
might not
> be at the very end of the string, but the commit message does not =
match
> the code.

Thanks for catching that. I will update the commit message

>=20
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 23337d2fa281..fad7ef4c8e5d 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
> [ ... ]
>> @@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>> pr_err("Failure to parse '%s' terms '%s': %d\n",
>> alias->name, alias->terms, ret);
>> parse_events_terms__exit(&terms);
>> - snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>> + scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>> return buf;
>> }
>> - used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);
>> + used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);
>>=20
>> list_for_each_entry(term, &terms.terms, list) {
>> + const char *name =3D term->config;
>> +
>> + if (!name)
>> + name =3D parse_events__term_type_str(term->type_term);
>> if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
>> - used +=3D snprintf(buf + used, sub_non_neg(len, used),
>> - ",%s=3D%s", term->config,
>> + used +=3D scnprintf(buf + used, sub_non_neg(len, used),
>> + ",%s=3D%s", name,
>> term->val.str);
>> }
>=20
> The switch to scnprintf() here prevents buffer overflow within
> format_alias(), but does the immediate caller =
perf_pmu__for_each_event()
> also need this fix?
>=20
> Looking at tools/perf/util/pmu.c:perf_pmu__for_each_event():
>=20
>        char buf[1024];
>        ...
>        info.name =3D format_alias(buf, sizeof(buf), pmu, event, ...);
>        buf_used =3D strlen(buf) + 1;
>        ...
>        if (strlen(event->unit) || event->scale !=3D 1.0) {
>                info.scale_unit =3D buf + buf_used;
>                buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - =
buf_used,
>                                "%G%s", event->scale, event->unit) + 1;
>        }
>=20
> If snprintf truncates the string, it returns the number of characters =
it
> would have written. This causes buf_used to exceed sizeof(buf).
>=20
> The subsequent size calculation sizeof(buf) - buf_used would then =
underflow
> to a massive unsigned value, leading to a stack buffer overflow on the
> next write.
>=20
> Should the snprintf calls in perf_pmu__for_each_event() also be =
converted
> to scnprintf to prevent stack corruption?
I will address this in V3 by updating with scnprintf in =
perf_pmu__for_each_event() as well.

Thanks
Athira
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260426043006.48113-1-atrajeev@linux.ibm.c=
om?part=3D1

