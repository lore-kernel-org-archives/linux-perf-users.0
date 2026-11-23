Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437088;
	b=AGghcAv/D5JbsjXeeWzORGkZmf5wO1/jeZ7u6S0qXNNkHq4fF7Nptr3xmDnWWznUiMyY
	 z0cyfEGjm77gBGllCNrPzW3cyhYvzezpJZUrOFKEdfaXf9PCW1We57991BcQAJXbsZt/n
	 f2UWPOltmaef+zx74qTWBW1NxhHNvw8UtT7q7HP9AYY7PtdpaJIkmQvDNiXK6hyN0SxRY
	 /wtJOuHNbsT2Xf7zv3yuqixKrXUYsGmtK51NDfSZUX2R/0N6i0H9jL+9lqNYt/LSRVHzG
	 xUgaE1T8YAWHB8fdNITZY4iAw7Ayz0AKdovDTK6vchr6Y2PiKNjTAG25Vif1pHoVYSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437088;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HHwsUvGyDIzr4MTYCYOgvSAv1GTsjvGvrF1aHvDwvUA=;
	b=WNyPDbvbpSZuEpUDLM0juMKFvw4mwVnKf5if2jbFZ4Reb01SJMm0CQkG5SCYv2jGwJPk
	 12cGWhdWtsJPzTGigZb9XwTdWV66LxCXRYAQHmD9NrNSluE//4Z5kKl2taG0qOgoGvySJ
	 CV3WDl5URfNHWFVmdWFMTCgS/J1zRQJS/sa85Zt7MKeUIED/Ot94cW25lHuWrHTpv/45L
	 mto1q5JLC7Wo6WxeK4lB26caEhdDGgn8o4QObMQwBskpSPwdDRfgFZMKyq8tarVNd5/zA
	 q05n2u5OC0HNHm0aOysOwMQIFstrPh0n6L43SMIfdZMSiLF35L81MBYdU7XYd8nGfJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sW+PNHd3;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DE606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 12:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F9DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sW+PNHd3
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9YxLq3195160
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 12:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HHwsUv
	GyDIzr4MTYCYOgvSAv1GTsjvGvrF1aHvDwvUA=; b=sW+PNHd371rgA0K6FGeHXa
	GmZoGwBY2NoEZ6QOLZmez/xKetNCbvRO2Cgy1DLb5NtrFd3oDWQuup8terZ8tsJw
	T7BWwgcLRnEUs/tNTo0xj8sLqjZ9aSBTK6MSifb5OUFIE0aD4S4A7e5YAkwotKJ0
	dgQgcsqnoapK7n/bNiP0qEP/XNP9NBJCyN4kcd/T4C8wDax1xvt3BAvmJW77W4uf
	bqyzsTs8RVSAllTZZu7ou+XQzwiCwu4Erdy+mEmRXlQDo9lioKfX0u3wO1DUwpnc
	Y1m9K/jS8GBEaJrEvUxQB0IwqLwqMywY76Gr8D1BL4tneVfssmJGfep5KXCZ9bHQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv2uju-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:31:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCK0mE2968049;
	Mon, 23 Nov 2026 12:31:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h6q2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:31:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANCVOl454919450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 12:31:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B26B2004B;
	Mon, 23 Nov 2026 12:31:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DAFC20043;
	Mon, 23 Nov 2026 12:31:23 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.209.178])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Nov 2026 12:31:23 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 1/3] perf vendor events powerpc: Fix misspellings in the
 power tables
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <sashiko-outbox-225778@kernel.org>
Date: Mon, 23 Nov 2026 18:01:10 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0A0296E-8123-4D30-9266-8AC33F555869@linux.ibm.com>
References: <20261120175840.1274637-1-takano32@gmail.com>
 <20261120175840.1274637-2-takano32@gmail.com>
 <sashiko-outbox-225778@kernel.org>
To: takano32@gmail.com
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b04321f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=lnWT7QV6wVhovZSZ-MsA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0OCBTYWx0ZWRfX1WzcX/+YlznF
 8HNRbR4W6p8vmFNatrByMI/vtpKeGfyCfXR+opIy9H8BOWJMYVm8Mm2xUeFGsrCGxbTH3BaDdbH
 htpR0AIMAgSaC0u9Zs8zkXiajfiRXcE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0OCBTYWx0ZWRfX7y8bNPFccLOh
 2EzVKkhkOQeQsNoqJxcNYwG2M/GLAzgEnvs5nD937uchkx6dxuMz1vb8FagggZmMuD4t0FTcEvF
 AKw4+t55/CQQfVe5q+jG+bgxTeAkttPIAE+s5AgyEtYfLp5ZLLPSg49bVbpyINz/gNLbsjLYJEa
 oquxP33/Ru3OslDlo0/7PYnVdt/uJRF6YpqU7vwVGztGCu6ZvkWNiT2Moh73m8SlTpit74+TQb0
 BucW9nC5KGySZ3uxU6UK1A9Z8paqElpuyLvx6kG5rNoAHkQLiz9SaKaxA27fgTx81mzRdqS0tVz
 AeJ7/7VptczeMmmhx85g3sAyb+bnnn34Et2SCgosjIVmDcGp581071w6Evkygs9O0er/E3yrYlE
 E9KIEvN8Q1AOcilEVmwdtK6ScL02X1xcRC3KNeak7lVTfN1p3QBhnKQmxQCnYU9W9HXrKlVf1DT
 vgf3xLqFR/LXtndxEBw==
X-Proofpoint-ORIG-GUID: Y93GjLKYPyu7H-A3BVMa0aozQ9vQBmDo
X-Proofpoint-GUID: 0FOcGkNJG_RTP9QalLGZnMJrK-0RBb61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230048



> On 20 Nov 2026, at 11:31=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
>> Thirty-two different words are wrong, 69 times in all, in 54 =
descriptions
>> of the power8, power9 and power10 tables.  Fifteen of them appear =
more
>> than once: "than than" and "thee" eight times each, "exceed" five =
times,
>> "cyles", "finshed" and "cant" four times each, "software.Fuzzy" three
>> times, and "coverted", "repoted", "Fetchs", "whtver", =
"Micrpartition",
>> "dmand", "invalidat" and "tread" twice each; the other seventeen =
appear
>> once.
>>=20
>> 62 of the 69 are in BriefDescription fields and seven in =
PublicDescription
>> fields, so `perf list` prints those 62 and `perf list -v` prints =
those
>> seven.  Eleven of the 62 are metric descriptions, printed by `perf =
list
>> metric`.
>>=20
>> Sixteen of the 69 are not misspellings: eight are a doubled "than", =
four
>> are missing spaces ("touchto" in "touch to L3", and "software.Fuzzy" =
in
>> [ ... ]
>> gone from the generated out-str.c, which shrinks by 393 bytes as some
>> corrected descriptions become identical to ones already stored for =
other
>> models.
>>=20
>> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> Sashiko has reviewed this patch and found no issues.
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20261120175840.1274637-1-takano32@gmail.com=
?part=3D1


