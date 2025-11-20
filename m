Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187262D6E4F;
	Thu, 20 Nov 2025 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624270; cv=none; b=B9AN4+YNIunwmVQWuch9czy/EqebMKeJT7XgEYE4QPGw1stVgcFBHC7MSt+KOt7a0G3B3DpIGPCxmzGinxK48f47FXy2GuJ4RMNBE1aH07Mh7sZRlFJCDksmvp6L1DZMsA5m+uY1BdNsNjcfqZqxivzwGM+XEN8sdHgNMqDG/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624270; c=relaxed/simple;
	bh=j1lRiy/6p6/UShKSg5jUvceVavKPCYRx38h9pTDksPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SEaLpaQnMUCoHh5Hs1JYfIFXeyztP0lV5eUDjPwAWOIB/LR3UD5LY+kHiEPHFsWueMQNDs6NDo3EzS1j5t98ECL6ngBPjPzHWPwcEaNteT0rmPcioZ2hmobLlrpYqlLFUOsGFNuUF10YWlYTUGTSrZohmKkSG2j/Ze5rV3TlAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rRM5d2nv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rRM5d2nv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJLlKP9003959;
	Thu, 20 Nov 2025 07:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E0KCkp
	lvxwBvwICrfM6hydjcQnLn7cx1QFWUcNYjx/Y=; b=rRM5d2nvimMed1cVnmP/+B
	UaVGke+yrUkRDdxG+YN7pF08A7o2y4ymytL1gUYl99XAjaXWuc1ZBeUq3OTnQcL3
	HLrRO6JKdV5TbWpXc30Jp6YUNx5+KCLUEMQclY/r5hdL7qEhieirFSiYvz/GtZDQ
	87d/1rjj5P401nvSViTlltd6jiYEr3Fpg6BoaCud+W/A6FYR2teVIAKtuUbWlLIy
	i5KjsO59q6DbGOxYJtJiVV8Ya51nib+ZNUkzZiA+SA4dFKQGhfRdcSjCnmmJa77o
	fxNxkC8aeAJmGA9Md0jTtO8EMkYVmVYIgLhIp9KXrbBjFk6HJAy5zHPAwYDiGyFQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju3qdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:37:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AK7bR6j009468;
	Thu, 20 Nov 2025 07:37:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju3qd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:37:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK6mgHm006954;
	Thu, 20 Nov 2025 07:37:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62jmyva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:37:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AK7bOT242729896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 07:37:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A42C520043;
	Thu, 20 Nov 2025 07:37:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 212B420040;
	Thu, 20 Nov 2025 07:37:24 +0000 (GMT)
Received: from [9.111.89.55] (unknown [9.111.89.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Nov 2025 07:37:24 +0000 (GMT)
Message-ID: <f7192ccf-7702-4a40-978e-60fc7c1639c6@linux.ibm.com>
Date: Thu, 20 Nov 2025 08:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test all metrics: Fully ignore Default metric
 failures
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@linaro.org>
References: <20251119193047.2238095-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251119193047.2238095-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7etrxVUbi71juC4zHqdI1fpzugYGzJfq
X-Proofpoint-ORIG-GUID: v617qbINymV4coJX74VoolpKKoxWOayJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3z1GX7+hYHkv
 P/k+8k7hSeXUuTY5AaH2ucrb+0ziluR7giH8sq1uh3d6XxsHXdF20FIRqNiIksaWNCw46FZp8xj
 /G1WmrYtRpc+IY/J7ONcdwCkOyPzrWj9sZWygMZLnbniwetdGzFJXhkpfycL6S2d5fAxOF9A6vU
 N3u+meq6NZ76sxfmzKGRGMunI06mgZjcs4U8YarqWC5q7DRcZsM2TOpaEUBNrODfIOBVtnjJExs
 q7Z2wvEAAFHGCyoXeKQpIDem4bALghbDkx6gVHKsezMMpmUfR7EYLHG7CAC6c0LunqgUHacA77i
 q/N7p/H1bmGjhtx9nKVnUAAZIfY4xwnn5RPB0S6it+4AaKc78jULwpk2dWLflR6uqfjdvJSflZb
 7Jponv7c+bZmn+SQn3gsT8zsnmzH+w==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691ec538 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=HVa9FsKFN9bTpKEVuYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

On 11/19/25 20:30, Ian Rogers wrote:
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>

Tested-by: Thomas Richter <tmricht@linux.ibm.com>


Thanks for fixing this.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
