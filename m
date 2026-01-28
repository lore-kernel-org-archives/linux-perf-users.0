Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB72BE7BA;
	Wed, 28 Jan 2026 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586020; cv=none; b=HKX6frrBGEQENHTTdvHe9olt/BbVSbo4fmECo1n7FLll6UCiHNLl/BJi4KCXzWvQ6BNm4qw9wOAQK/t+G6y5FqGsjAYR6StqyikmO8uDqwSrLrbhT7aOtVhiWgjyrXw/JN6ektdPitSX0eCH78Bnazu8qon133wP2BNa2sMPEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586020; c=relaxed/simple;
	bh=RdGC3X6hlyEof5dnF2j0NDwDzUFWj5iyXkU5fzZhdTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReW/InzJoTE5tc1+yaiJgGJgIJieu1awYjizXOfOtAFfXpyF04Au6/SVibWvbaa/7alGCdI3lirB/Wn4BnPuiqES57EGP1fN12ciKXs1yE+YG3Uegom4/8TQo7nNVOnabk504omoL6tQ832WERj9PdStsMwI4qD0sDS4cl5BAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CMJkOTDX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CMJkOTDX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S1k660010943;
	Wed, 28 Jan 2026 07:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DY4YmE
	cgd+ENfrzss/JtX+30jxkeHFPrVTzRyryI99Y=; b=CMJkOTDXkcUSzOImnYSwHv
	IXmXCbDcxl1lPq05FIu489VExs+x+dI/WBfKg7yuG8vwXmRocgefag73GomkoM+z
	v1n1cwKlvujEk29ezO4JSxSsPIfWjA3qJCB214xEgliLpFdV48EsB0TmUoW6MKYN
	9kl0UfcHH6kIGSufeC1HVVLzSWtJ+f2eQif9eXECn5XjbrtipcQBY68sbuppLMld
	aPeO+GzRYZU5UR3uk3MvdQtPwfl0e4CuJRbPVDRvGuvUOYQH+nnifYXHlDIK4DlJ
	ub+NJDESpkLU6+RA20JGtHfMjtZMRZq2EtEUAGMtKnIs4uV55XAnpGwV+zeh1JpQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmr2ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 07:40:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60S7QvUg023988;
	Wed, 28 Jan 2026 07:40:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmr2dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 07:40:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60S6QHhs019647;
	Wed, 28 Jan 2026 07:40:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn4eka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 07:40:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60S7dw9a44892496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 07:39:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC0252004E;
	Wed, 28 Jan 2026 07:39:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F32FA20040;
	Wed, 28 Jan 2026 07:39:52 +0000 (GMT)
Received: from [9.111.60.95] (unknown [9.111.60.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Jan 2026 07:39:52 +0000 (GMT)
Message-ID: <0117fe41-0016-49d7-bc73-1ec682ca8783@linux.ibm.com>
Date: Wed, 28 Jan 2026 13:09:51 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] perf header: Replace hardcoded max cpus by
 MAX_NR_CPUS
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, thomas.falcon@intel.com, ashelat@redhat.com,
        yu.c.chen@intel.com, gautham.shenoy@amd.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, irogers@google.com, james.clark@arm.com
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
 <20260127185000.431884-2-swapnil.sapkal@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260127185000.431884-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6979bd52 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8 a=H9UQRV-y-7KEHpS-QRQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: URuGXVKlzN7WA7lqYqgRbGR1RTG2aR_H
X-Proofpoint-ORIG-GUID: e13B0yhQrzrCrya6wfAT3sGCLAtkJa5j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA1OCBTYWx0ZWRfXxyXcKqSnyGb1
 XHxoCL9l2auXha6ITQxLnOUeKAFq+Pg0B8AnB7Gs7L4R5uSM7z36MfEig+aFaRxzBMxLIuLhF8y
 7g3MWC+A02yqOeptPB9rBUt6nFnf0nYP+w2sZU1sBZO1Wk6DlcYXZiCRMm9THda1VNGMoRf36tu
 qx49nQA6bQYwCgfAfYF20BOQmy9/NswojI/wy47Yg7dupFwFRAFimG0PNI0uIzgYeX9mK/ynCOq
 np0+20AM5umD2X/D/4ZQMbJhxntghDbSh4id2cDyciU1xhS8n8sE/41lQaYxZGAiOoWzezUzWxr
 R1v2snEq6cC0DXQLzCirvtchUpOfe4PcygsE04tW297nqSoId93YGGGvRzBOawmYvsqkGMKsrzl
 +Cc0qjmoTyBRAeEBs0GkOsAhqnyXQ6Xt44S/AoJEYYA4J08b8UxIoo3BLxZr5pjyXNXGLGGzd4o
 k0Mq+hMmbqa+YzJuG/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280058



On 1/28/26 12:19 AM, Swapnil Sapkal wrote:
> cpumask and cpulist from cpu-domain header have hardcoded max_cpus value
> of 1024. Current systems have more cpus than this value. Replace it with
> MAX_NR_CPUS. Also define a macro to represent domain name length.
> 
> Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
> Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>   tools/perf/util/header.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index eefd1cd73b6a..31c3bab1b10a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -76,6 +76,7 @@ static const u64 __perf_magic2    = 0x32454c4946524550ULL;
>   static const u64 __perf_magic2_sw = 0x50455246494c4532ULL;
>   
>   #define PERF_MAGIC	__perf_magic2
> +#define DNAME_LEN	16
>   
>   const char perf_version_string[] = PERF_VERSION;
>   
> @@ -1616,10 +1617,10 @@ static int write_pmu_caps(struct feat_fd *ff,
>   
>   struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains, u32 nr)
>   {
> +	char dname[DNAME_LEN], cpumask[MAX_NR_CPUS];
>   	struct domain_info *domain_info;
>   	struct cpu_domain_map **cd_map;
> -	char dname[16], cpumask[256];
> -	char cpulist[1024];
> +	char cpulist[MAX_NR_CPUS];
>   	char *line = NULL;
>   	u32 cpu, domain;
>   	u32 dcount = 0;

Looking at
https://lore.kernel.org/all/20260119175833.340369-3-swapnil.sapkal@amd.com/

There was one more "char cpus[1024]"  in tools/perf/util/util.c.
You may need to fix that too. It is unlikely but, if one has created exclusive
cpusets comprising of only one cpu from a core, maybe you will run out the length.
So better use the MAX_NR_CPUS there as well.
