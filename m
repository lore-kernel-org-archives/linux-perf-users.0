Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6909202976;
	Tue, 26 Aug 2025 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192052; cv=none; b=rfdex6HwfhNpzXY7q4E22Xcs4+DCLLDWEK1Y9oaEmB2m0+fkKxepY0/kGaA2UyWTQUG6rSPHtFPl+bvnd0W+DpCYxyTpOXmK29ZDhnNoGquIrX6w1nW1Rt8pBxQVRIxmox8xsOs5zeTIB0W+/E14uRFvTjXOVtMhdeHZN2SMvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192052; c=relaxed/simple;
	bh=MQsAz2d9V8rtxDuBXZXaZkxQu9S3T1MwlkQ5EgjhVS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lScagPFq93UfT8dGXYvbMdl3N5qLoyT0fZcb7K24yfE6LkJuELIJMtBgu43L5dBuf3pYUr8+4XFnLVgF1rnwrSP+O8CjnNr9t9lF36Wda+FkqViWRO4tFexKtPeHafecTTx87cyTLyu8mxBGpybVQBwjBN02jhAF9q6HsjgwyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lygOm1kK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lygOm1kK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PMFVed028958;
	Tue, 26 Aug 2025 07:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MQsAz2d9V8rtxDuBXZXaZkxQu9S3T1
	MwlkQ5EgjhVS8=; b=lygOm1kK60wke11wCqgVHRFXi0dgtFLr4mBQsEtQgRbeyE
	9DiKT6dlJMWfM9fT/41PRb+vG+T5VKM3f6iT9x4QDZBQg7AG392aTOlnALGMW7EB
	1SdqAkUaPbNlDL3gW+QhnxzKR8W4Z3ZAV9KP2tR9zOymTv5ibSqpnAZoBvSvMX1c
	v3EKZOn0t0MwFC1rqiLTCSuoDKhoMoBjwpn4p61MeOq8pQ3h5ZZ5pKlGuiRnqKcH
	Omca1KW0d6RtpYvvnYWYUwQxuUBLtG61phXSyk3BXIxiHBKGbWecWCN99Yu/B4G2
	03BhX2IghhRaKeObO6aI2n9bM0kYIVqUZsa2d7Tg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q9754dek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 07:07:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57Q75hdh007387;
	Tue, 26 Aug 2025 07:07:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q9754deh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 07:07:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4IJj2002469;
	Tue, 26 Aug 2025 07:07:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6m9c80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 07:07:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57Q77AlG14877138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 07:07:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2507120043;
	Tue, 26 Aug 2025 07:07:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24A7820040;
	Tue, 26 Aug 2025 07:07:07 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.98.110.17])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 Aug 2025 07:07:06 +0000 (GMT)
Date: Tue, 26 Aug 2025 12:37:02 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
Message-ID: <aK1dFuYoySJuyqB0@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728055937.58531-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jd0f7pAXmwUWNK0OtL0rSY81G-alTL46
X-Proofpoint-ORIG-GUID: KPpVnWsC6fHuFlYZi7jn2s7FI6yPIpf4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfXxOaROWlMKAwH
 PthL+9P1dnZyZmHPD4x+Q+78duLeVpHjaBFhL7WXnLgAVZkjHCgoIR1zQzLM4OK3oyS1Q+0wfPr
 qxnjzcNUx1mWkl8EwFqrQR6ZjtCRD5JKwuOL3ny8Nun3M7ehnCzdyAlcbpav5vFVxO3uphhtJef
 ajzK3PC0HY4VnwNO/AIrDEUMP+56+hrlEEuOKjeU6LU0b3K+4rGs604VO8qgTGHrBfuTkr8er1q
 z/ALEB/yPvkCaLGAjFsZp8Y51C6ez+h9f2PNVtJZiIE6WV0amkL/fMC0jes+HQR533vA5OptUnC
 Wp2P4ZpiRoZlkpBVHw8YQJcuZD/k/XYuLLhmYYiY9023wPMfv4asnhrqh2GMSvn4KR2swx0TBa7
 6dPm+XPN
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68ad5d21 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=o2bzqXIHJ2Bs3r1v_k4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071

Hi,
Gentle ping. Please review this series and let me know if any changes
are needed.

Thanks,
Gautam
