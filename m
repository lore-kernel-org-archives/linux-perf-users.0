Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FA1F5413
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175561; cv=none; b=UaNK4ndPdKdSR+RM7H7jF2/07TTrmBjT2n1XZGOBgLiMrmPRg3h3TGQZd062KaDzCcBsArB+jgfRhIkj1YOhOqbuMGEU29d43Qc9nNgFhKR8q5cHDbhCsuoK4VoHRNwn6V3cJMogDyjOalwSsQdhlVDfBR8NijWOhbKUoAyGcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175561; c=relaxed/simple;
	bh=C5H/EX6c1W/vDEsCv4Rc7/p4rNwkFMsy2Oa3PEWFl6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7NmB0JGSKFvmGADWuIIdkC2jrJPcYHu+Z1gwVUip7G8kiFHSjf9jhIebSGYDPBZSA0747zZJn4Zy/NwpnKkpAf/XmLfLuXEP0WNdcZYroQK2Zhcfw/6uhjMRrBZXZe6RZcQ+484xvKRKyJZ+nxgIlxyfAA3x6OSmKX5lnnyYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rLAHfDGZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rLAHfDGZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5259XmAN026572;
	Wed, 5 Mar 2025 11:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CmWgwM
	XAI84JfO12Ie7NIZL1K4VwQJz7DUej6aLPSqs=; b=rLAHfDGZkwKrfWu7cSHGEO
	JBlPAVr3bH9BUgE/ODLJqeqdax4XdwHW5ewmiwQD4ro7ba42WFh+VqEnzj2/0YkN
	lhIh2+hcpVjfG2jNVpiMYlTv4IZI3COxV2ccaDV9BLfVdjHSgQQd6DClNaf9pGXL
	1HQ5x9LCznEUL+wg6raJtAb41Ch+XljOEswJuf6rzty/WAvIfldd3ANIZfLkCA7O
	daLFxZQ52OLWtkm6OUmJHKyGx4LD8C25JcDvzeUTB0Mc9of4if2N8pVlce4L3FX+
	aeDcmGyyda0P7YGnxQpt5DgCUR2DCOZ81FvXUjkU/88pN8PYV3G/dya4wxpe/avQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568x538gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:52:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 525BnsG6018282;
	Wed, 5 Mar 2025 11:52:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568x538gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:52:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5258hciC020928;
	Wed, 5 Mar 2025 11:52:29 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk29qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:52:29 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525BqPq365798506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 11:52:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 876E458050;
	Wed,  5 Mar 2025 11:52:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C08F5805F;
	Wed,  5 Mar 2025 11:52:22 +0000 (GMT)
Received: from [9.204.204.161] (unknown [9.204.204.161])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 11:52:21 +0000 (GMT)
Message-ID: <569fed73-20f7-4f54-bcdd-67fa9357aa1d@linux.ibm.com>
Date: Wed, 5 Mar 2025 17:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools/perf/powerpc: Use return code from
 disasm_line__parse
Content-Language: en-GB
To: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
        Tejas.Manhas1@ibm.com
References: <20250304154114.62093-1-atrajeev@linux.ibm.com>
 <20250304154114.62093-2-atrajeev@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250304154114.62093-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n6wKdJOmpaRpc6VNUbLl-5KBdDuxofiJ
X-Proofpoint-ORIG-GUID: QwBWc00gfUCfNTo0Y7X4NxJ_KdEEMXUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050093

I was able to reproduce the issue without this patch.

Applied this patch on next-20250227 kernel and tested the patch and 
issue is fixed.

Please add below tag.

Tested-By: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

On 04/03/25 9:11 pm, Athira Rajeev wrote:
> In disasm_line__parse_powerpc() , return code from function
> disasm_line__parse() is ignored. This will result in bad results
> if the disasm_line__parse fails to disasm the line. Use
> the return code to fix this.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>   tools/perf/util/disasm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index a53e8c4e5bca..8f0eb56c6fc6 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -976,6 +976,7 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
>   	char *tmp_raw_insn, *name_raw_insn = skip_spaces(line);
>   	char *name = skip_spaces(name_raw_insn + RAW_BYTES);
>   	int disasm = 0;
> +	int ret = 0;
>   
>   	if (args->options->disassembler_used)
>   		disasm = 1;
> @@ -984,7 +985,7 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
>   		return -1;
>   
>   	if (disasm)
> -		disasm_line__parse(name, namep, rawp);
> +		ret = disasm_line__parse(name, namep, rawp);
>   	else
>   		*namep = "";
>   
> @@ -998,7 +999,7 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
>   	if (disasm)
>   		dl->raw.raw_insn = be32_to_cpu(dl->raw.raw_insn);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static void annotation_line__init(struct annotation_line *al,
