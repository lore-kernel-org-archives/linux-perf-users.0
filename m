Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BF29D28B
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Oct 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560888; cv=none; b=UHEF3735K/ufdG3wjpdWc9daIaZYItOS9jmhBAApe2rIKJZZA1V6PKww0o1DhTQ/oTfn00zPpernpUo4tsbj7a/WiuLaoByRdkTM9CkLsKCTtJBkTgoRoZaYzwLUtkuhP9v0gLFr9cL/z/dyURt1Fh8z+AtE1WJp01F38YAqrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560888; c=relaxed/simple;
	bh=wBk2L0eYk+iuHwJmdmOw0NkROR15fBPvD4Xb9ND/xKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdOs2O2RiERw9+k+r6dK9Ru9HV/EWQRI3XZKE+9kR60QPWTF9f8S0tyIpjIA7Ftw5xDJRh692F2fTnDpMg/hKCxmbjPexS3Ut1ZI6F5xYtrQToq5JF75UPn5i1AbvFO0gO8jYqSuPpPkyBVDTffWO4Z0LzfLWvGW2rGxERawUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k7TgrPPf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k7TgrPPf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R0RMYi003891;
	Mon, 27 Oct 2025 10:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B5sSU6
	ZvuwqFwhw7dZYSK2iV4+M7PDSj2vSB6AlJoc8=; b=k7TgrPPfVgR5TXLp54mmBh
	yQdMdsCrM/WB3QsGoeMBfEHzLFdU1/B7cCxv+cdExnuacv+vQbfYZmGpS2/tiA3m
	fnoixLyi1QC33+JiJTc+xVG/WQimgUTvsCPr7tmzafejrf0G9B6x5lGdzctXMv4D
	lVrjJCCXPdVJBUZSyMbEXQFDUs8ic2dBiVwCVscufB9npk3Yz6Xqpsba98skxo/X
	fhFYWokPdVw3RiUZ38VOO9DhBdQDuwKPw4To0ivgMLD+/0OcP+3h66YYxa/8JNZC
	gQn8oKE1Qq/9t4z++gH+S4rIrjojiucOQzerjiBtwbwYosJM3pCWa+c96pjrfpww
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kyt6bm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 10:27:51 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RA1Pfk027967;
	Mon, 27 Oct 2025 10:27:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kyt6bkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 10:27:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8jJRQ006806;
	Mon, 27 Oct 2025 10:27:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk0vra4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 10:27:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RARl3r30212550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 10:27:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEDF920063;
	Mon, 27 Oct 2025 10:27:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CD112004D;
	Mon, 27 Oct 2025 10:27:47 +0000 (GMT)
Received: from [9.111.6.107] (unknown [9.111.6.107])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 10:27:47 +0000 (GMT)
Message-ID: <c929de25-92d1-4ca2-940f-cc4bdecd476a@linux.ibm.com>
Date: Mon, 27 Oct 2025 11:27:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling
 test"
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        dapeng1.mi@linux.intel.com, james.clark@linaro.org
References: <20251023132406.78359-2-ashelat@redhat.com>
 <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
 <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NENuAicXOiATQwIbC2aYKCWIvljhGd3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfXxbyfju1WKNc6
 8olEEZmwXkZS2xQIwfdoEudC+IBmacqUuiLek4fldKV4qmEc7UFgISVcrDzVpDJZKdJT7bDX19z
 7akAHEaVXuzjaOrBvBhR2ORBGjvmAlYpi7gPWs7/ceR8pRGPCWlVJmnWzkATpX9SjN80O5JFtbc
 sA+mjHp4MghvyrraGGX2XsXn+IVAmw44rL4S1RBx0ql8ZhQyW1eRtGGfzNA4Fzb5yfDMrjXyWja
 EIAM8q2RRzP0XLaS55R5Uj2SIimonZWk/TZOs7glNBztRJnz5fV73bf1oquSANIOLp9i47uDyds
 PJrWwglI1iFqtV0XwfG+23VjBucoMpv02cOf5VhR60gdb5ZX8p9U6SBZ5fy3/cRSE+oaoIsSMMA
 If0835GJ2MhgyPHcBj5ym1WIiqNsMQ==
X-Proofpoint-GUID: 6zVcjXqleDspXIVddALWBWl8qUzaLGKX
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=68ff4927 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HVa9FsKFN9bTpKEVuYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001

On 10/24/25 19:21, Anubhav Shelat wrote:
> The issue on arm is similar. Failing about half the time, with 1
> failing case. So maybe the same issue on arm.
> 
> Anubhav

Right, so can you please stop this reverting patch!

Thanks a lot.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
