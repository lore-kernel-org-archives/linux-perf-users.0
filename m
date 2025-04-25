Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B473258CFA
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592448; cv=none; b=d1xapH4P+SlFD6uvH4yVnBQxyUqgqoe6pwYmS6IIDpkFUVs0n6CEr6TdPJM84OnoFkHxZcwUD0WKl0UVltGM/H4dNg8SwQ9IeB14qpdTVAuhUKGe8vdgOMI/tSPHu2EqROFeI5x8ZGu4wSr0HR8KBvib5qBTfH4O2rKVX/ULCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592448; c=relaxed/simple;
	bh=7k9iA+WRJHjVv/VYZsaECHtMQrGnySy2z9m4Ec1TSkQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sWo0pErSZdIig2o3a7CO/Px9WVKIjiuiTuTFj+8J+Tok6Fqa/6ntTvHHk0iJncX8K2n4yFFzCA0PavjLwmD3cjEGnrc5ocboOUYjlXQxUo3WilIJgALnbPUpByIFMF02/HzauB3nWHSDjL2PY5oE2qU7FoJLt4Rt6a6+7B2o4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VvQ6bchm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VvQ6bchm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P98OjL007191;
	Fri, 25 Apr 2025 14:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m62+7u
	TH6YLNjDx13EBc2/zcd03+OJ25rwPKzcgtDoc=; b=VvQ6bchmq/Q8OR1mdEJ4QS
	PM7p00hZ46Y8U4jGCYPq64MrY4jKw6AX2hvCsmL1jMVizK381Fq9j+9hW2NUYkgz
	oTRtd8EyS/5FWtnLZXH2AZ0mTIBoxwwmyUIagiuuiOo81T3KOrqVNWhm3vAL98zZ
	ydw4zIfoV7oz3mzMjTFr6wk4C3Yga+anioDO5zpw1kqDibgbceRyOCqJU/97PpcG
	5rvb4drRn85qxVYuSIvGD6NE5jiz8GYRVJVGK2GKqSOHxylO9BTD9aFmXnYTuQN5
	4f8U4trKwcRcq6Li015tHTfUXbT+GUxPxX91cK7YZnx2UqaaiMxUazqZ2nonyUaA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9kvcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:47:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53PEiVAx004669;
	Fri, 25 Apr 2025 14:47:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9kvct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:47:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PDEYuq028426;
	Fri, 25 Apr 2025 14:47:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvwn1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:47:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PElCZA18612582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:47:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FE062004D;
	Fri, 25 Apr 2025 14:47:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B197220043;
	Fri, 25 Apr 2025 14:47:05 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.250.235])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Apr 2025 14:47:05 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] tools headers: Update the include/vdso/unaligned.h to
 sync headers
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <0f2b7c10-a30a-4d2e-ac3f-baec1b45d945@linaro.org>
Date: Fri, 25 Apr 2025 20:16:51 +0530
Cc: "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, jiang.peng9@zte.com.cn,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Tejas Manhas <Tejas.Manhas1@ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <607CE194-2D87-4E28-B65A-2407F3C265AB@linux.ibm.com>
References: <20250421034143.67607-1-atrajeev@linux.ibm.com>
 <0f2b7c10-a30a-4d2e-ac3f-baec1b45d945@linaro.org>
To: James Clark <james.clark@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J70XttYYBDRsrOTeFSXF_oQNWu5AEFfo
X-Proofpoint-ORIG-GUID: weBAXFe5WRfpnkP4tv6l_Wh_HX35eHO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNCBTYWx0ZWRfX3rbr8UgJ4DIF hl6lGRK+Ik0JaBTZf5TvAsj5+sKSQhitRYhgC5kTALs2cDD3MZtVRxQsLmZf6nkgBni902i29Ez WBNkXgwiIY0NQFtXr31S+JBdsUGkTjaj1bZjk2uTyjAHHOFJAJ1s+LEHtWemUvvBp5oEKHwMnq6
 tC2nBYTMHUHB4LFbbhWPZ3esh0gKrTaIn+20PUFCxYNjuVoltZarIrS8vPvIMlxYCG+XNi3wi0g 8v3KkKowiz/68FFU3e0RtvJ/xWd1yoZsULYxFPBGmOem25CNI4Dm1EkdHc147ikoEeop5k+Lt4a gELZPx4OD/4U1F46uMT35sXA3U8coctWz8LR+rtaLYOJIcsBUQxGHUcG4vlFjWfuGgfI3pYS5pZ
 ddFAZDadrDO7zxb3n6V6FN88NlWukU8Nr9of74X4HMvM86ttUERF6xVvfXCis/i7LF7JTdAO
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680ba076 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=t76MFMGQftYPq3j9xbcA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250104



> On 22 Apr 2025, at 2:41=E2=80=AFPM, James Clark =
<james.clark@linaro.org> wrote:
>=20
>=20
>=20
> On 21/04/2025 4:41 am, Athira Rajeev wrote:
>> To pick up the changes in:
>> commit acea9943271b ("vdso: Address variable shadowing in macros")
>> Addressing this perf tools build warning:
>> diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> ---
>>  tools/include/vdso/unaligned.h | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> diff --git a/tools/include/vdso/unaligned.h =
b/tools/include/vdso/unaligned.h
>> index eee3d2a4dbe4..ff0c06b6513e 100644
>> --- a/tools/include/vdso/unaligned.h
>> +++ b/tools/include/vdso/unaligned.h
>> @@ -2,14 +2,14 @@
>>  #ifndef __VDSO_UNALIGNED_H
>>  #define __VDSO_UNALIGNED_H
>>  -#define __get_unaligned_t(type, ptr) ({ \
>> - const struct { type x; } __packed *__pptr =3D =
(typeof(__pptr))(ptr); \
>> - __pptr->x; \
>> +#define __get_unaligned_t(type, ptr) ({ \
>> + const struct { type x; } __packed * __get_pptr =3D =
(typeof(__get_pptr))(ptr); \
>> + __get_pptr->x; \
>>  })
>>  -#define __put_unaligned_t(type, val, ptr) do { \
>> - struct { type x; } __packed *__pptr =3D (typeof(__pptr))(ptr); \
>> - __pptr->x =3D (val); \
>> +#define __put_unaligned_t(type, val, ptr) do { \
>> + struct { type x; } __packed * __put_pptr =3D =
(typeof(__put_pptr))(ptr); \
>> + __put_pptr->x =3D (val); \
>>  } while (0)
>>    #endif /* __VDSO_UNALIGNED_H */
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>

Hi,=20

Looking for feedback on this change.

Thanks
Athira

