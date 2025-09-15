Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B00218EB1
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950827; cv=none; b=rTl4MF+CTM5B585ZX13z/IfAUaB6as5Hlq0UF/3b2MHwp+sydrIWhEWWSI4Zk4vHj+SPQZYS+6hqPZ7BtedldHVP3Cq+1K9n4+HxCh8lC10gV+G6CcXfuh6x5vL7WuwOKYK3YzrpzMo1t0ztCJ8jRCM4a8AR5hpzjh59LOy9nYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950827; c=relaxed/simple;
	bh=EOAHCwCG2rnPR3Phoz/qA4caYX/V/qkk0XjVgU4cbVU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AUgYdDm6oCSVlZ+T5vaT6eUYH1Q2y0Z742ya022iyYSB/mIZ5jU6ubQ3Vqq83WCeOAjyfXHJMp0i8iz0BxlV5L44Pz3H/pUNdvwBPiArG5krA+x2/p9Y2QobeLpZm2BZ2MyPq30UhjR+jfrOszBxQtUCV6nQNcwOeOc1pcf02vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cd6gamv/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cd6gamv/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9Onju017363;
	Mon, 15 Sep 2025 15:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EOAHCw
	CG2rnPR3Phoz/qA4caYX/V/qkk0XjVgU4cbVU=; b=cd6gamv/ZS3kL2CpprG1X4
	oRbaS56dP0CfM9Mt7DlVzRhLk/q8/LDfJ789UdX/ZMz4T+dCEcVPWAf9Endq6q2q
	rnUTN0jqAQjAtfrDi04kJ3KkQeHiv09bJU9vk5iVdwF3F5jz6alqsT2oAz/kzXzK
	4cEqB162+fJWKcxZVQlBL3vwNoxVpDWRFAjGcxth7uzuK80CEesKTFeHJK1x32tn
	FbjDIYPhkdA8K/yictPQaFA88NV/cRHp0f1GUmETee3ByRPLpFIrPXU8LjL/+cj/
	UUOYet7HqExqmX8naY1fCqTnNSpbQ140iOIh8n59wlLlp0mrpD2BEZSAGPSirFMQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g531yfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:40:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FFdOtW012798;
	Mon, 15 Sep 2025 15:40:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g531yf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:40:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEHfpS029472;
	Mon, 15 Sep 2025 15:40:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb0qbdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:40:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FFeHfs53805460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:40:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDFDD2004B;
	Mon, 15 Sep 2025 15:40:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D3420040;
	Mon, 15 Sep 2025 15:40:12 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.250.129])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Sep 2025 15:40:12 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] tools/perf/tests: Update perf record testcase to fix
 usage of affinity for machines with #CPUs > 1K
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <aMWE1A-ruPozj9f-@x1>
Date: Mon, 15 Sep 2025 21:10:07 +0530
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, hbathini@linux.vnet.ibm.com,
        Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
        Tejas Manhas <tejas05@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C298E78E-04BE-4CB6-8959-65E4E26BEC45@linux.ibm.com>
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
 <aJ5FvBa4LPhMO0u-@google.com>
 <4772D6D1-D61B-4269-B20F-17A387CAAAD9@linux.ibm.com>
 <D3D67CAC-C609-4C25-99E3-4E130E2C9AFE@linux.ibm.com>
 <CAP-5=fXMKoF1z4TPDJhBFqz8gRdXcrCBTJdBvRLhY9rzrCFxfQ@mail.gmail.com>
 <aMWE1A-ruPozj9f-@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4RZGDWbMc_7wXzcWhb0bvv0-B2BxKzGb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX6/1lyZnGh04k
 NevoTUXQ4/meP6WemnoGKIIL5Ij5tuhzDEquqpsZ1bq7r7NieSKmnus3A9CvdHMB3R9vIsmPEDD
 +QzX1Iqrzi2luhgnKyVh3fhbC6B+jQBpLihrX2aNHcNprz5kNTQ0FO7UgE6Al1Agd0wdRMRNyhd
 vSaJjnEPhRjatK2e3zcGs1xIQEScYOJgg6jZtu3ntntwghreIjI1GWaL/7Thg7ne/X2ml7FsXe+
 u5xT53C7ikqX6nnvp8y47Ko/POD9+lNusDpD8vwYwwBFGURUGVcgxPOar7MDRZ/Axj8ukQz2g0c
 pcJcS1Qwh0Q8YgmtWfe07ddcc7i6b+2ut7N0fG5dSOOp0UMaHpOl7oXQOUnQwzIqtcqTV3QBuwF
 WwB5kCVa
X-Proofpoint-ORIG-GUID: gw0o5SJm2du9j41zjavkmGoKI_Bp8WyU
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c83365 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=WhmIiR-BnfdzuEMxMSIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086



> On 13 Sep 2025, at 8:21=E2=80=AFPM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> On Wed, Sep 10, 2025 at 10:46:04AM -0700, Ian Rogers wrote:
>> On Tue, Sep 9, 2025 at 10:56=E2=80=AFPM Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>>> On 20 Aug 2025, at 10:50=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>>>> On 15 Aug 2025, at 1:53=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> On Thu, Aug 14, 2025 at 05:19:08PM +0530, Athira Rajeev wrote:
>>>>>> Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
>>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>>=20
>>>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>>>>=20
>>> Hi,
>>>=20
>>> Can we please pull this patch in if this looks good ?
>>=20
>> Tested-by: Ian Rogers <irogers@google.com>
>>=20
>=20
> Thanks, applied to perf-tools-next,
>=20
> - Arnaldo

Thanks Arnaldo for picking the patch

Thanks
Athira

