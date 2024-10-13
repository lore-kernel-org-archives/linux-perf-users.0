Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A6186A;
	Sun, 13 Oct 2024 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728797965; cv=none; b=tElQThSWZh4tdlZYndI2dc46qinnTf1/bTHdzIfmkUjlD3O/0HiNs7Zgb9TsJJtzJfn4OjK6+ADthMdV7nago3w3xl2+Fgeed++0OPQdkzoT5AHt/vonXuwxjbmVN0Jut8d/HbgCu8vkZT0B9k0mDgSvM4V835NcZ3mdzBh1G5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728797965; c=relaxed/simple;
	bh=ql0cqCjfWF3jG2jnyhm5/ewcg1XGtUBZ4D1Xm0snQ8Q=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=a3dQ09iM3JtMoIUHfWNfUZujFVThZHB78KvakE8QKBAgHjh35ufmHv34h6mq3KhO3cl95DXwtL0cFun5hT9vA7U0qgOIPwIZAsjnhE5r6Ew9etWES3aIBe4oNaotWGFv6oPeFegEsNcw5SAe8Ff+e5/7497WSymN1KvD2LOQyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lcxtwBn+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lcxtwBn+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49D4uC5J012520;
	Sun, 13 Oct 2024 05:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=K9bzlZAp7xjuv4GNuF5KdigbRFP9c80iG0D8UnRR/MY=; b=lcxtwBn+mhpn
	U932aSeu3KvWeKWek+DakoXPspUgxw46nLzmCTdUdMCFozRA0d/l7z8L3TGGCxqv
	A4SLx/EFf/53FBwW0gM4hn/piwBDXi6GhvKyOOlu5tDrrjmJweypczGP0/U+tUG8
	yrjHDoygkyDSWasc2CizkB0BoV8SItHSMU9bz9RHhHPygkS/SOaY3awJPagPjmaY
	iSuaH6MAc7BbQIBEWa6b7YzpUkX1FUjOGgTa1OJPV1KWBZwqJACUUeJxhJFyR3TS
	0R8ce6heanS2oOmfuf2Spy14xxeaJb35utrbZX+Y1md57o9uV8qNdV//5N6rgzSO
	9LIGnRsyaw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4287kug37d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2024 05:38:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49D5clMA025012;
	Sun, 13 Oct 2024 05:38:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4287kug379-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2024 05:38:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49D2gGgK004965;
	Sun, 13 Oct 2024 05:38:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nhrdhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2024 05:38:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49D5cj8Z20578764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 05:38:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA0B120043;
	Sun, 13 Oct 2024 05:38:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 441AD20040;
	Sun, 13 Oct 2024 05:38:37 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.243.56])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 13 Oct 2024 05:38:36 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20241011064824.1432562-1-namhyung@kernel.org>
Date: Sun, 13 Oct 2024 11:08:23 +0530
Cc: acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, howardchu95@gmail.com,
        irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
        kan.liang@linux.intel.com, leo.yan@linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tmricht@linux.ibm.com, vmolnaro@redhat.com, weilin.wang@intel.com,
        zegao2021@gmail.com, zhaimingbing@cmss.chinamobile.com
Message-Id: <DB114AFD-C80A-4789-80EC-715F7B0CC6A1@linux.vnet.ibm.com>
References: <172857541969.1131797.2693392463657578240.b4-ty@kernel.org>
 <20241011064824.1432562-1-namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yC_6lOOla4_WyQYWN2lJGf7K03aZ75yr
X-Proofpoint-GUID: BN6yxtjmh-RtjGLdP0Vp0vnZVCqOUy7Y
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-13_04,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410130038



> On 11 Oct 2024, at 12:18=E2=80=AFPM, Namhyung Kim <namhyung@kernel.org> w=
rote:
>=20
> On 2024-10-10 15:50 -0700, Namhyung Kim wrote:
>> On Tue, 01 Oct 2024 10:19:47 -0700, Ian Rogers wrote:
>>> The path detection for "Setup struct perf_event_attr" test is brittle
>>> and leads to the test frequently not running. Running shell tests is
>>> reasonably robust, so make the test a shell test. Move the test files
>>> to reflect this.
>>>=20
>>> Ian Rogers (3):
>>>  perf test: Add a shell wrapper for "Setup struct perf_event_attr"
>>>  perf test: Remove C test wrapper for attr.py
>>>  perf test: Move attr files into shell directory where they are used
>>>=20
>>> [...]
>>=20
>> Applied to perf-tools-next, thanks!
>=20
> Dropped from perf-tools-next due to build failures on PPC.
>=20
> https://lore.kernel.org/r/20241011102330.02bece12@canb.auug.org.au

Hi Namhyung

I am checking this on powerpc. Will respond with the findings

Thanks
Athira
>=20
> Thanks,
> Namhyung
>=20

