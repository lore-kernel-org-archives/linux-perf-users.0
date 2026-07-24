Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FB4908B7;
	Fri, 24 Jul 2026 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876593; cv=none; b=L2h6pLLW+1InL1btsqqbxf82pkadXTqmjFrv0tTJhBqFDgsePivlya3RtIrdnTlBdG5GImK8S9bGYQFwXLIUwtJ4SZEMVaUlsupE2+HQSb4BWtrJ//FJXbbIPKlhY9EVRy5nS+EaKqa1rCoZb0SGemlyPwsa9MrPhJgjL6vCpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876593; c=relaxed/simple;
	bh=PJ/+ByJksAe7HOdMDSfC6NV924/lgQj6Ni60jm9Ders=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XJ384GYlb9b+g38Niw8HkuWP5O0QHQ99gQCsnDU3grEl1uyvDFe9fHJ8cLu2kYB86kjMq8ahIIRsywl6YAPRpJyiUZd8MltwJ+QH9GEALiL8re+UDK9Q1mWndDHqXm7u8Rq/C1oZ2LI3mDcp7VVEf9ldUl9G48yv4TwcCrP6U+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bG4H+j5D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bG4H+j5D"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5BlWX913982;
	Fri, 24 Jul 2026 07:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m8mRTY
	+YW7PlP6TzGh55fpIegJOfbBL0IriTvNKR6Kg=; b=bG4H+j5D4nyMcMo3Uxot0r
	u7jhcEttQlUsfXgTsZxXWmAViMjh4wSTU/w843IYFdLO9bi9YDnFlJ3PUFvs1NKE
	+sxW3VpzWx04tMv/771c4XF3rDvrXqUK3BdYa2j179vG8quA8Y7OEEofJZfJvyw1
	XCjAY/Av2CIwGZCY3rq7LmBXGNKKjPcYB7lq9Vb/fwXw5auJTYpQ+gys8uI+bG+d
	jiwv9linioC12wnaHh1gT2CSMzoGotUvBGGFoN9tje2GzWia/u0L+6re4+c1tZWl
	6OZsmRHFEkfvX38v6T0AcItmAbO1JcIJ/rEZwHpXtZm2O7apbH3GhRKBiGK6Dc7g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahjt5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:03:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O6neRm032303;
	Fri, 24 Jul 2026 07:03:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gqmy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:03:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O738RH31457796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 07:03:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E6F201C7;
	Fri, 24 Jul 2026 07:03:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96A31201C5;
	Fri, 24 Jul 2026 07:03:07 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 07:03:07 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 5/6] docs: ABI: sysfs-bus-event_source-devices-htm:
 Document sysfs event format entries for htm pmu
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720111314.3B2DD1F0155E@smtp.kernel.org>
Date: Fri, 24 Jul 2026 12:32:56 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D07F241C-1C04-49DE-8F5C-ACC97CD75873@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-6-atrajeev@linux.ibm.com>
 <20260720111314.3B2DD1F0155E@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hrim4SkEDmoI_bEx9RkbYs6zVxG5m5HE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX3ggHIXJcpAs6
 5Ffv4hdMrp8cKQxy24Hrte1i3H8T3GayDBcLTQBbUzPVwbpij71sJvJ/vEcpKfkDYSdz7Nv7Dru
 PTdG49t+EUihkMrWJ00HhAN9SYJ8arSAdvZMZs4+AnSivQrsn/hN1+Irp9jMeJveta1CLzokirY
 L/ojsUSqjo9dkYiuQ+iswuvYhoMJ0kwI7Jvo7b/kgeKZtfvzBe1r2hsf6Av3bLPY70PTOFhgXR2
 bR7K66Dc4spdXq9wl/mtVrbmCLk6UV0fNZ0J5oVASBqJjgX9JriMKGxzPqwAPUAGwsvQ24VWwwM
 /raLwRAlaWLD7u/7Ve1t7DPlq2vNf6OAwOKl3jPXJVTLzTEcLgS7RQx3okdDBIBDWOxbeH/w8n5
 3wj0GTSgpG8WuhDvZ38Kk5CVfijeY3nGkfz/hdwBmImbbULjxb3pTLTuUsEq1pJlAfexLYURkMB
 xVdXizaSxImPNaEqPiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfXxaRo6gLLPhmx
 mNK6hi21RgxYSKWjrW0wZzLUvlYHxts2+z1HwZBUtq1ZSSmGnwjMjYFwbTjQEvVQSP7hJ+M8a84
 FVilIfswK6k3fVdZ9nQUqGwg1xMee/E=
X-Proofpoint-GUID: hrim4SkEDmoI_bEx9RkbYs6zVxG5m5HE
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a630e2f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=voM4FWlXAAAA:8 a=jfP95tfrkVojahAY4dIA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240059



> On 20 Jul 2026, at 4:43=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [Medium] The format attributes documented in the ABI file do not =
match the V2 layout claimed in the commit message.
> - [Medium] The commit message provides a fundamentally flawed example =
for using the 'events' attribute group, conflating it with the 'format' =
group.
> - [Low] Minor grammatical error in the description text.
> --
>=20
> --- Patch [5]: [PATCH V2 5/6] docs: ABI: =
sysfs-bus-event_source-devices-htm: Document sysfs event format entries =
for htm pmu ---
> commit 9ec8c4a8a34dc7a4a75859018f086bb71432aa4a
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event =
format entries for htm pmu
>=20
> This commit adds ABI documentation for the sysfs entries exposed by =
the
> HTM PMU under /sys/bus/event_source/devices/htm/. It documents the =
format
> attribute group and the events attribute group.
>=20
>> Document the events attribute group, which lists the named events
>> available on the PMU.  Users can pass these names directly to perf:
>>=20
>>  # perf record -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1/ =
...
>=20
> [Severity: Medium]
> Does this example conflate the 'events' attribute group with the =
'format'
> group? The example provided uses format attribute fields (key-value =
pairs),
> whereas the 'events' directory is supposed to provide named aliases.
Thanks for the feedback

I will address this in V3
>=20
>> diff --git =
a/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm =
b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
>> new file mode 100644
>> index 0000000000000..784ba7c31b89b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
>> @@ -0,0 +1,21 @@
>> +What:           /sys/bus/event_source/devices/htm/format
>> +Date:           June 2026
>> +Contact:        Linux on PowerPC Developer List <linuxppc-dev at =
lists.ozlabs.org>
>> +Description:    Read-only. Attribute group to describe the magic =
bits
>> +                that go into perf_event_attr.config for a particular =
pmu.
>> +                (See =
ABI/testing/sysfs-bus-event_source-devices-format).
>> +
>> +                Each attribute under this group defines a bit range =
of the
>> +                perf_event_attr.config. Supported attribute are =
listed
>                                                             ^^^^^^^^^
> [Severity: Low]
> This isn't a bug, but there is a grammatical error here ("attribute =
are"
> instead of "attributes are=E2=80=9D).
Sure
>=20
>> +                below::
>> +
>> + event  =3D "config:0-27"  - event ID
>=20
> [Severity: Medium]
> Is the documentation missing the format attributes claimed in the =
commit
> message?
>=20
> The commit message explicitly states that htm_type, nodeindex,
> nodalchipindex, and coreindexonchip were added for the V2 layout, but =
only
> the generic 'event' attribute is listed here.
Will be updated, sorry for missing that information in patch

Thanks
Athira
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720104447.11843-1-atrajeev@linux.ibm.c=
om?part=3D5

