Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BD2DEA77;
	Wed, 28 Jan 2026 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587432; cv=none; b=E2uiFEMhCcBJY/Pt91WNYxvCFPfxlCHxTqPif1mpSZWvgiH8zYbXzlHMCAjB3A0OZSyXBP7Lktg9fOx1kA/KbEuCOQ66vTGX0G+ujG16uF/L5+FA6hJGLkyyHDhFfvRCfLzu/vGV7rbyoAImUWChpDEkF/5Y2rWQhjIKM0gdUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587432; c=relaxed/simple;
	bh=QMtU2ui/qdSYGowj3GUPGQfL2TGh8GUC4LorBe1Sh+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8NDJIYyIRXaCCym+cOqC1IG9Ck154ibF/96fJQdKsQGIGc2SMHPzpjYlG5BZhOx004r3ggiwyV9Ea/3jRnys249sg+K8yQ9mJd1qsh63LYW2Egy/E1DZw1DeK6MGLtM+EEJAFxf7nXPMfdDHn7VUXdr4uuJGts3bF3hUUFa1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O/4U4yBv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O/4U4yBv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60RIwZDG005646;
	Wed, 28 Jan 2026 08:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xSzg05
	hdPj/Ve0oEWxEDH6ceyLEegNWt+ecb7hh60iE=; b=O/4U4yBvwM/S8fHHKEmX7e
	99mw0f8Y94YYmnuEIry5ilywjmtVEmmn+huiWyCK1h/wy0ggeflqeBsLC8iTU0CY
	7+NH9gUFnatL5kV4ZOCs6ZUQvvK0c+PKR+5owAoqdmOesMyq/IKaActE3c2YVPms
	s18i4Kk4/r4z1Qva7qsEXO5fq04ewxOZwmuiAfKluzLLOUroB6+mAP06+6XfYhP4
	rmwGIBQnsNc4fv+8T9ccGtjFW5W7foSIOqWCcKEkE1FFCxh69HdkGd2VIM94jZb4
	7Q46xiO26ijwhvKsnVFtFV16BmIFAxRK1hb20GSIcnImbT87y7ZcBZqzCvNatwHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk72649-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 08:03:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60S7mwCu005908;
	Wed, 28 Jan 2026 08:03:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk72645-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 08:03:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60S34k0K018303;
	Wed, 28 Jan 2026 08:03:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41v8s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 08:03:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60S83WYh49283380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 08:03:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89DEA20043;
	Wed, 28 Jan 2026 08:03:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21F4B20040;
	Wed, 28 Jan 2026 08:03:27 +0000 (GMT)
Received: from [9.111.60.95] (unknown [9.111.60.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Jan 2026 08:03:26 +0000 (GMT)
Message-ID: <34c47190-d44c-47fc-b41a-04857054d287@linux.ibm.com>
Date: Wed, 28 Jan 2026 13:33:25 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] perf sched stats: Fixes and improvements
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, thomas.falcon@intel.com, ashelat@redhat.com,
        yu.c.chen@intel.com, gautham.shenoy@amd.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, irogers@google.com, james.clark@arm.com
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260127185000.431884-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VAXknQ7ZpXUD_SUHPqnjmH9BRE6GAI3R
X-Proofpoint-ORIG-GUID: YOpU6xi-GChDAbriM23tl3KagRRu-t1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA2MiBTYWx0ZWRfX5yXu69gR9gJX
 m4HYgAzz5kU7VMyeS4bKfikek9iz8CAQTbyIagFH4BilBHHb1+vGKhMq8TzJLpDARf/XplUluQe
 RKj0F4Z+uUttqRZLrnaSmsu/t+ZZhUvGFcgHPPhiECuxg22G9wBl4jbO/ulLgFqEwD2we4aiH4b
 6u+zYvBMSGQB0+brPHbaUVtKZMGGl7ALbp46ABIrEyg1ZRT9jn5PD5y3Pq/aQmovGcrqesBymZo
 OsEUFnpYVop7N0jVdF9NvLZS5lXZW5Tbz1TIboWr3IGagNm6IlN2/s+oFZ8dB+z1QuY8q65j6Dw
 N/XX43a4T9abe4VoT26N3DxZSYiBnnGIvH1Op3OdQttH/a1cP6dflkwn4cvQ8WMeHzX9fx4oZwg
 PzYOS/5JGNDMVjzP4NLY2KzEf92r9cZVmsa5SPBCt4i+52KjcIXhThw/Bvo5YNWjs9y+zsW71Tk
 pr9QozpcoD+WuTN+Rig==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6979c2d8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Cth0ZhdtbhwMw2FiYU4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280062



On 1/28/26 12:19 AM, Swapnil Sapkal wrote:
> These patches contain fixes and improvements related to perf sched stats
> code. The series includes:
> 
> * Bug fixes
>    - Add NULL check for cd_map in perf sched stats to prevent potential
>      NULL pointer dereference
>    - Fix NULL check in cpumask_to_cpulist() in perf util
> 
> * Code quality improvements:
>    - Replace hardcoded max cpus value with MAX_NR_CPUS constant in perf
>      header
>    - Define SEP_LEN macro to replace magic number in perf sched stats
>    - Correct spelling of function name in perf sched stats
> 
> * Documentation:
>    - Fix various issues in the perf sched stats man page
> 
> Swapnil Sapkal (6):
>    perf header: Replace hardcoded max cpus by MAX_NR_CPUS
>    perf util: Fix NULL check in cpumask_to_cpulist()
>    perf sched stats: Add NULL check for cd_map
>    perf sched stats: correct spelling of function name
>    perf sched stats: Define macro for SEP_LEN
>    perf sched stats: Fixes in man page
> 
>   tools/perf/Documentation/perf-sched.txt |  8 +++----
>   tools/perf/builtin-sched.c              | 30 +++++++++++++++----------
>   tools/perf/util/header.c                |  5 +++--
>   tools/perf/util/util.c                  |  2 +-
>   4 files changed, 26 insertions(+), 19 deletions(-)
> 

Other than the comment in Patch 1/6, rest looks good to me.

For the series:
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
