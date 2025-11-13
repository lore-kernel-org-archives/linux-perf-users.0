Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1E333754;
	Thu, 13 Nov 2025 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023056; cv=none; b=ueWYtd80rhPzuaSmNtwo+QaW5ybyyG4Kp9grFo1wNShaDeyi1nRBvR/YonenviS84OF/rQHVc9EOc0doAEPVJh/GE4lmyJzNbt+4un4Qq22CitW8QDK3gS0jkfwb2BMPS9cDHTSdCcOXZFVrlf9um4ZgdvRZyk2Dtp2IxgaW1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023056; c=relaxed/simple;
	bh=XFYtsFL4rpmfEMgLFxyr4sNRrEnFuAf9G3+wCL0Lr9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lgh1UjjneEQvAf4EwyLc6sz668v0S+8gmYUGqx96OxMBifcrudeeF6xe2AwyM9k5ywXgPcI1j8uTf2Z8LWgi23pLepdjQPwt9PmDQCMGCQUmE03AzaL0Ud/zxZtSOKA4kBdusdOQrSCcjyb9cA9jWiFLkg6HZcacbSAjhiyhAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=njdUq3Yj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="njdUq3Yj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACI2788023602;
	Thu, 13 Nov 2025 08:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YkcNE8
	5OfSU+IA4LUllS6N/nKIwxBgZ9u3GoTRgAqeQ=; b=njdUq3Yjp47sadiE5s8U3+
	odAAhyfbfaoAkpUsn+gNQxglhUJ5TS3z21E1vug94eDk3eKC9VxfirN95aDI+v4U
	gNdi2NA7EnYTpAgzvfqFDxTAzHsNNTBJjw23vTYrVCWUABpfvBw/tVy9YP331Yn9
	AKUgq5j+PvfzL0AedTuTuDSJQJOp9lvM43Cyz8jQSO6ffTLtRpPgQfgRFKG2z6Hk
	Mj4xvYn+1FB9ou07oKVK2Qi9TfDMuiZmXT1XLyxizT4lca6HEI0q2qYpUstNfg9Z
	SXFC89GGY01nwqFBDNTuiEGYkdIRRtx2AkAoQmFFMIvNS0oVM73bhthC7nNRPTbw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjdqk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:37:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AD8GsPu014482;
	Thu, 13 Nov 2025 08:37:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjdqk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:37:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8QX4X007375;
	Thu, 13 Nov 2025 08:37:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjmnmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:37:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD8bIJZ44761540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:37:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E6E20040;
	Thu, 13 Nov 2025 08:37:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D0220043;
	Thu, 13 Nov 2025 08:37:18 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 08:37:18 +0000 (GMT)
Message-ID: <65e7c3a9-dd73-4d4b-b255-0b2e8cd919cc@linux.ibm.com>
Date: Thu, 13 Nov 2025 09:37:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf vendor metrics s390: Avoid
 has_event(INSTRUCTIONS)
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112162439.1553368-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251112162439.1553368-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=691598c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=fUDWYMiWWKKnppuCQBQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX9G7o8WaoYxwL
 iIyTgyWqW+LiGG5dX6ix+HQAr2Ng/HSOhKmUB4CNgx7iner9r2AVLjC/uLdHrAmjIWPB9wyBIBZ
 NolwbFynjg81vRs6h/Q0IKblrPjHEGPLTKbCNt85zawJu06DJCgQcCWI6TRZaMtpSx23grFNgs7
 2Suh9B3OZGIzSs/K6+b8av+xKasUr/wygujSBuuGtLFgUWeOUbazs6VEE7lxtLPQ8rauICuEXuj
 Tn2U7fZ6xtTVSQr7i+lIKSNY6Zy4oRpvMdbuBtOl5NyeYQifj80VzQVhQauSDHXR77moIN9iplv
 KxiKXF0jc2Nmn3UvmkaDmgU6IWHeBAMB7WVUXDnWrFqeUBOmrfOzl+r+EynwP/DBBTP6YuKV6Ch
 cAkrSsiogcmkiy1d3N7/PHRJEO71gA==
X-Proofpoint-GUID: cyUXZenfqsSFp9aKtaueDUcyCZZJPUN4
X-Proofpoint-ORIG-GUID: OcGosf5xEsxzDEsbsxIzaz_u17H_SL7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

On 11/12/25 17:24, Ian Rogers wrote:
> The instructions event is now provided in json meaning the has_event
> test always succeeds. Switch to using non-legacy event names in the
> affected metrics.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/3e80f453-f015-4f4f-93d3-8df6bb6b3c95@linux.ibm.com/
> Fixes: 0012e0fa221b ("perf jevents: Add legacy-hardware and legacy-cache json")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/arch/s390/cf_z16/transaction.json | 8 ++++----
>  tools/perf/pmu-events/arch/s390/cf_z17/transaction.json | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> index 3ab1d3a6638c..57b785307a85 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> @@ -7,17 +7,17 @@
>    {
>      "BriefDescription": "Cycles per Instruction",
>      "MetricName": "cpi",
> -    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Problem State Instruction Ratio",
>      "MetricName": "prbstate",
> -    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(PROBLEM_STATE_INSTRUCTIONS) else 0"
>    },
>    {
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
> -    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(L1I_DIR_WRITES) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 2 cache",
> @@ -52,7 +52,7 @@
>    {
>      "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
>      "MetricName": "est_cpi",
> -    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
> index 74df533c8b6f..7ded6a5a76c0 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
> @@ -7,17 +7,17 @@
>    {
>      "BriefDescription": "Cycles per Instruction",
>      "MetricName": "cpi",
> -    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Problem State Instruction Ratio",
>      "MetricName": "prbstate",
> -    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(PROBLEM_STATE_INSTRUCTIONS) else 0"
>    },
>    {
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
> -    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(L1I_DIR_WRITES) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 2 cache",
> @@ -52,7 +52,7 @@
>    {
>      "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
>      "MetricName": "est_cpi",
> -    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(L1C_TLB2_MISSES) else 0"
>    },
>    {
>      "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",

Thanks a lot.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
