Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FC33F6;
	Mon,  2 Dec 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147306; cv=none; b=EiCiYHyvhzEQoAB1X6tGmtw8rhAZ4IamP9Sn9HXzi2h8dV2mwI490/c4VRq490+8Yaz0RMRHjyb8gxLHqF8I2Da6O+fKz6OF2XCzyaTyphTFwFcdkV1uHv8+vY+YcSa4N7oqrpnIQELzwEwa21MmXn/xyxz5sECUvg1oSPm0XxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147306; c=relaxed/simple;
	bh=yRFF5Cn9hYJ5NxNNwgBFZ18HfvfvKPMofL1WAQo1+F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWwzByUOkDMxSXC6MhdVLqWMndC+gk24jCJ5uEMTjn8emUZgANsWGqu8UGLMuP/k0CGiijucEzRNRcNZ+t3FE6IqzvRXEqrHBZv2ldpwGqah74WSnVJUspR4GgU+6TOtxH7TdeyGCzwHE7EH5o1RM1yNSLVoiOBCMy3vhDe+I3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/qhtRXq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/qhtRXq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28vMNk008687;
	Mon, 2 Dec 2024 13:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rqNlJL
	dkxznHHoNexL0Ceqcdh2TqPu6ZQPu6UIy4HYs=; b=C/qhtRXqXQW9WXvEsIYLjW
	hNFKgO2PE43GndzSJIq2IbinLmEIJTzQEb47QZopU4zu2cnzW2Pst31199Fe7sFC
	yE2jgnseoB3Pgmw+l85d9J+J0CSH9cuvozKpjOgdgs4tjNuGgQaohqWyY7j8cOCk
	UpXCFcmBCBLAiEVpdc+40qhipcg2td9h5cgSnuC5hkKtTyT6B9WYPL/X3fJjIsxB
	uJHAKDvu0NnJ1rLG3dCMNqrLWwLiRmMw1h/83TtutR9fhWM8EdM4jxd1t1HTOuQw
	Q53LR2nPwur84WvDR0FPjAA4F5RY0LSRHuuOO+f87l2GrGI66biuRnP/LqyGiR3A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437te8sj4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 13:48:05 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B2DgHJF010973;
	Mon, 2 Dec 2024 13:48:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437te8sj4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 13:48:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26GUkT020536;
	Mon, 2 Dec 2024 13:48:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s2g69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 13:48:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2Dm2wY65798614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 13:48:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67A1D2006A;
	Mon,  2 Dec 2024 13:48:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEC2C20074;
	Mon,  2 Dec 2024 13:48:01 +0000 (GMT)
Received: from [9.171.14.28] (unknown [9.171.14.28])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 13:48:01 +0000 (GMT)
Message-ID: <2b3bc88a-e435-4ccc-a543-c8f8566dd306@linux.ibm.com>
Date: Mon, 2 Dec 2024 14:48:01 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test record+probe_libc_inet_pton: Make test
 resilient
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jing Zhang <renyu.zj@linux.alibaba.com>,
        Guilherme Amadio <amadio@gentoo.org>
References: <20241202111958.553403-1-leo.yan@arm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20241202111958.553403-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 384liJLtZORsnI_2gW8-8CeKyVM7eI1X
X-Proofpoint-ORIG-GUID: VIzwQ9x8qYuswBlnADDWHSPxs_OkP4uX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=884 impostorscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020117

On 12/2/24 12:19, Leo Yan wrote:
> The test failed back and forth due to the call chain being heavily
> impacted by the libc, which varies across different architectures and
> distros.
> 

For s390 using 6.13.0.rc1

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
