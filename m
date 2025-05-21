Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B02261591;
	Wed, 21 May 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830500; cv=none; b=bPJHdjj1HtJ9AH2eU9wfZxjOxBi+Hy7Ihb+Cx2cRRoMEWwYIHV8/39WpSK3IAKvVDLeD8B7GAatttQavC6KC2fVAsvy6XXI7+3jq9K1mX7A/ewTjjTiHY3uUoI5MRI8yO3/dLC5u5S4IdAhggUk3x32lj/w81TaFHApw1pZROxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830500; c=relaxed/simple;
	bh=D7JPv7eGQSBe92zqvRVBeFxbKIukpL4fYfOYc4Xw8XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZqi6rDY3xcFrg+VI4DXxfPGxywI5HgiStULnQhXUIYnv69Qim2sLlopLR3K5enbbeFb0b0nIvwPOW6c7OOMBGQ5gxN/288asvtyOu1rflseLOcryKdypbbOfCBL/vpkb5JxXDpVUNHc8bNWuQZmYJUarkJcbBOz3LO1m/Q5Krk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MzQz5Bxp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MzQz5Bxp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L5snAr025180;
	Wed, 21 May 2025 12:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D7JPv7eGQSBe92zqvRVBeFxbKIukpL
	4fYfOYc4Xw8XM=; b=MzQz5BxpPC+vud1PiTI3OlZ/t09C3I/X6eFOh5Q2JWvEzA
	2R79PZTzCwvIyMLlDiZ7FepHcmfsIHwL+Pkm/jT7BTgyJzO+MmChGxXtdQAg8J6M
	wTN/XFKhYWtBM9UmRL/XHf2vqzmERDX+yTGimLboBA+ZfUQuuThZSzg3Q/FDC+Tj
	kmkw832jyM3UBUE5UH0bLEM7ypiKCQOhgeQpVqprdZFZsqW7oRl9PDyYVNLuSm2E
	iiiOvplY5AuGDoBaRP2NVbSSUs5Td/KjpqRAtv4pkxcESaNhXvqGkgwhH3e60oKl
	l4cormMaNzZZ4NCbtr1GuxxAzMZkA5A70uTqCUPA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rxaam9jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:28:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54LCS2Ow009969;
	Wed, 21 May 2025 12:28:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rxaam9jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:28:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9n4Gs032091;
	Wed, 21 May 2025 12:28:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnmc3hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:28:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LCRxgH42861048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:27:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E1ED20040;
	Wed, 21 May 2025 12:27:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E1A2004B;
	Wed, 21 May 2025 12:27:56 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.39.29.161])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 May 2025 12:27:56 +0000 (GMT)
Date: Wed, 21 May 2025 17:57:51 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 0/7] perf python: Add missing infra pieces for counting
Message-ID: <xlndgr2qjxvktrw6i3m277whhcs2unbbpyc3r3cmpjjkpgayo6@u2s352674aot>
References: <20250519195148.1708988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519195148.1708988-1-irogers@google.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CMEqXQrD c=1 sm=1 tr=0 ts=682dc6d2 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=KCNhQDSLkcH-k2fJqYMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DehgTSWR0iPgl28Ggleb4ZX2M-U2uUc2
X-Proofpoint-GUID: kKj-2oIHWNgOffK2oCkNyBDLUjzSqS4_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDExOSBTYWx0ZWRfXwV4KIrIgeH// CfZdXs+NOJgSj3STIflgTtJ5TOkJmchqIPITR8y5wc9AhXdlcQQwO3PsxZRBQsF59UrrU9+/zt0 /RwI2BXO+RLtRRvbP7iiSK+d8CmPUFS7lmCb6jNc8Fc0/T7r8xul/8pwvNHRMstd00Xta2EJidT
 fD3x5Z4NKHnbhElX2Fm8JOH+mLgVAttm7qi+WclKiAUsdeUxtsKAHGej0rc8fVmFx2Qwe+qB1VH jmEy0pxfl8MQ3Fj4nvAJe8d5+ySBulfEJ/oDbr3qTnJfrXOM94YtXyUc+RdVvQDY8KytxNjzxYe Z1s8/HH5bd/w2DNcXfM1uIGZAac5ConPSSwmVZJI4cOvDW/oCzI682mkqmTwf2x7V3n9u+4uUNL
 lrY/jDuMCwXrA6uNggOZbnSBtTQdvxHWepMhhflINwVvG9dlRxEu542LBj/ztPJSluwogBM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxlogscore=704 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210119

Hi Ian,

Thanks for adding the API related changes, LGTM

Thanks,
Gautam
