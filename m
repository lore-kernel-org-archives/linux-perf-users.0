Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B63F9F5E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182287; cv=none; b=D6nZfCVeTkeIL0CGid66JPKQJM7Lh+Jd22fEdziHd5f8gLDm1f4R2AQfzbi9e+hdGznzZJS73iJQwUBCCblgOH7YlK8XVw4fyG9pC2C/rvzPKonurIOWGIUayhtG/lelsxEmAI8AQyAEKRvhQttnUno3Mrpn/TgmNSwO4Sebx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182287; c=relaxed/simple;
	bh=18nZfrkXlHqAXNQXmjvYjPTOr6OF8vSx+TEkfpYAIII=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h38IfUrl+w+EGioAouQ1tL29Uo6lz3JvYGqrcPWUxfDNMnI0kJDWNXlkFVqPuUjLVa+J5dimRzYDUu57j2l2ZeOkZLR/faHdYfx+uKYNwQqno1CMoAKpNPRNYWGPBqG6E6CyMYcygM0Af61sppaTQakFDoiAhx6ZbOput2l9v7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U3PZacQR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U3PZacQR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCCX791742452;
	Thu, 11 Jun 2026 12:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=18nZfr
	kXlHqAXNQXmjvYjPTOr6OF8vSx+TEkfpYAIII=; b=U3PZacQRmVXjPmUw+u6aqk
	U0L8lieMx+uaSXloxiP4ZGKbxZhA+GOO8xrFLkLjlbv22brq2sc33IvN9FyEYDSw
	ak/TvS0lemeSeZxeYSsmefeZ6RmtrsSY8mkYyOYYFMmxWKLpeBumHHsXHd5hefOB
	+jvMV4Cfqlp3/HppwFzpsnxrq0sCcC8i/BJqd5oblBM23D1anhB0EpbNgqb2bNLn
	KZJa3VqD1S3QNAQvgpx6Kw1E/Z8JYCFBHbbiMyOZvCYG59X+dKjDHhW0r9cU9I87
	aP99F32YNaDw4QkMZn0p6F4VgFK3FUAwUs5j9if25s/2ttRWprsljxXEt2M8gApg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bkdqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 12:51:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BCYssC004073;
	Thu, 11 Jun 2026 12:51:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09u6tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 12:51:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BCpBfG60817722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 12:51:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0D02004D;
	Thu, 11 Jun 2026 12:51:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743872004B;
	Thu, 11 Jun 2026 12:51:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Jun 2026 12:51:08 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V5 1/2] tools/perf: Fix the check for parameterized field
 in event term
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <ainEHlAh0aJ7zSyH@x1>
Date: Thu, 11 Jun 2026 18:20:55 +0530
Cc: jolsa@kernel.org, adrian.hunter@intel.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com,
        venkat88@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C24D6E1-28BB-4F43-8EA5-6B4E06014923@linux.ibm.com>
References: <20260609134332.97954-1-atrajeev@linux.ibm.com>
 <ainEHlAh0aJ7zSyH@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2aaf44 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=Rlq1kauLLktXqVg0nm8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNyBTYWx0ZWRfX0k84lfHFQEu5
 pexGO0KoDWg26QasZApp+VAgRvXOp5XoakzQ/I+6B+QkiX8buRvsAHNoMoxlZSGYIUVNuvFtzCA
 i0kDfP8utcXZaQQk+C64hXOQvEnKcsEQHGMADK6zBER1Rhl3ioGqSpmojw0eLvOWG0tZM/+IFmZ
 FT9Im1jNURvKVAiOknapG+l6bhKfct8T5sBgafsxxHioQ73cnaAXd3lCJV/MSu52PZrvADKyDbv
 8E9Iv7m5bkYew5CWwzWo/72bHPuyqS2xruGU3ZojXVoNFuazFEv1EMzuoWu6Mpo1XyXv61Yu6YU
 X6K52u+y1FguzvDY6GgijbUvIuy8/z4ICPFZu2L2nqHHfxfNqSo+T/binpNBbGk4owEMfIZghCr
 FddQAdcdbGNQEUk01Eg/fiXj1zipm1Cocgr35XNhqZloSChjQW2F+sJbX5oXEDepVl8yy72zpQv
 CHhq58rdIyA2IAtZvTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNyBTYWx0ZWRfX4o7RmcQyhH/c
 MwD44ej+0NmRdtafFW4DF6eqSC1Fr/5X0llf01PaA4BgFxF4DEYKuAyjeyeQ1eAGkc3U5YESgp5
 iGTbSSFN1X/py1povnyqbW49BuxV0lE=
X-Proofpoint-ORIG-GUID: 1j94Gt6hXZWuMpSAbV5x7IC-P-9TNfss
X-Proofpoint-GUID: FXsLwx4CEpiahbDtdv6Mv1cNXEGJrt4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110127



> On 11 Jun 2026, at 1:37=E2=80=AFAM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Tue, Jun 09, 2026 at 07:13:31PM +0530, Athira Rajeev wrote:
>> The format_alias() function in util/pmu.c has a check to
>> detect whether the event has parameterized field ( =3D? ).
>> The string alias->terms contains the event and if the event
>> has user configurable parameter, there will be presence of
>> sub string "=3D?" in the alias->terms.
>=20
> Thanks, applied to perf-tools-next, for v7.2.
>=20
> - Arnaldo
Thanks Arnaldo

Athira

