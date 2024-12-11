Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958C238E2C;
	Wed, 11 Dec 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918571; cv=none; b=lVMOk0pasfRSCqOrgaEZj+zbxosmCOOPv+oqjZD1F77f7tRfd2qA8EfPenyjVnbab6BP2XKDqvLhN2oVTW9wVAviKACtNxU8WDhKYGNEnBjZQLAu3EtBv7oxYkOyrK0BzOK8l4mz7UmkyhDrgZxBF5MnbjIl8L1UQLhE8p+Knh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918571; c=relaxed/simple;
	bh=ew4ix9I12b6Z8AdUyxYwTokUlh/HE4u6/P4gz1mtiyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8tREK3AmU81FYbv8WPUfiHRg2lWH47iMzM7m5S1bR5tmg4pU0VSx1+k1DKuKeogtdd0JjhdGIdaJ886m1qVtloVQLLQgSZAED5OoY6UHEvThhz4sazdil1P0nyJKHI6164BMN4WLfkw8xFe68L9yvTIt2qHn/m8MS1tL0m/d1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W9tArFSB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W9tArFSB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBC0Ucu005970;
	Wed, 11 Dec 2024 12:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3YcRWK
	xg1s7nYSdDzKaz4bSI+E2OJ91ZRGVWd8WWROA=; b=W9tArFSBILJRm1Gj9MZRJF
	ZjUB407XjUYczM+ravYd1EB9aflntIMoG0ykvWM48irOsHVYORVs8HQjgPULXA5X
	s8IEQ09PeP80N3MyE6pBB5WMH0RdLvPeTJPm2wXcHjR5TsHxL4cRzV0jSejMKieu
	h7rq8JvPl1Gxv34NKgQX27Yh3KWdWL10Pq0I6quRiMn2C/Op9intoWh6t3KlHrWW
	E5hvr634TEgULRBe8IsaOSP0nQe9taCtL49lKFO+JCrO11cAHas1df0c/ASVxBeR
	IhIHK9yEIi7xyt9tA7j+vsIgdLwj9n0KOIR3khC+bOV+BYa9PC3AvK5eZhTSF1WQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vw2dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:02:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BBBeeiK032543;
	Wed, 11 Dec 2024 12:02:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vw2df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:02:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8tT4n016944;
	Wed, 11 Dec 2024 12:02:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y9fas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:02:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBC2V8R56754458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 12:02:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F330820043;
	Wed, 11 Dec 2024 12:02:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72A612004B;
	Wed, 11 Dec 2024 12:02:28 +0000 (GMT)
Received: from [9.43.88.53] (unknown [9.43.88.53])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 12:02:28 +0000 (GMT)
Message-ID: <2907ca2f-b973-42fd-ae03-99732dfda7a1@linux.ibm.com>
Date: Wed, 11 Dec 2024 17:32:27 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf/arch/powerpc: Add register mask for power11
 PVR in extended regs
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
References: <20241206135637.36166-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20241206135637.36166-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PWzkMmgLJu_lWuUEdCvWTYlogUkihnG3
X-Proofpoint-ORIG-GUID: O2jEXNPWBRJ0QuaUNiPyGvgMWWIqTpuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110087



On 12/6/24 19:26, Athira Rajeev wrote:
> Perf tools side uses extended mask to display the platform
> supported register names (with -I? option) to the user
> and also send this mask to the kernel to capture the extended registers
> as part of each sample. This mask value is decided based on
> the processor version ( from PVR ).
> 
> Add PVR value for power11 to enable capturing the extended regs
> as part of sample in power11.

Patch looks fine to me.

Reviewed-by: Kajol Jain <kjain@linux.ibm.com>


> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> 
>  tools/perf/arch/powerpc/util/perf_regs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
> index e8e6e6fc6f17..bd36cfd420a2 100644
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
> @@ -16,6 +16,7 @@
>  
>  #define PVR_POWER9		0x004E
>  #define PVR_POWER10		0x0080
> +#define PVR_POWER11		0x0082
>  
>  static const struct sample_reg sample_reg_masks[] = {
>  	SMPL_REG(r0, PERF_REG_POWERPC_R0),
> @@ -207,7 +208,7 @@ uint64_t arch__intr_reg_mask(void)
>  	version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>  	if (version == PVR_POWER9)
>  		extended_mask = PERF_REG_PMU_MASK_300;
> -	else if (version == PVR_POWER10)
> +	else if ((version == PVR_POWER10) || (version == PVR_POWER11))
>  		extended_mask = PERF_REG_PMU_MASK_31;
>  	else
>  		return mask;

