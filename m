Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E01E5B95;
	Wed, 10 Dec 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345219; cv=none; b=kOgsHnBseSvZvW55sBXnxFVPm9/U1oIn63LD+rpMF0wbM1CjZ8JYPHs6aZgZvx0Rl5JxPP+XzeiDCwJarIGpNCS/sEBnAClVQYe6NGZVcfqWRvXoEazjvYYkgjuypx7Fs05799YgVaaj+AOVXFdB/hmgyGTkRBY98jnQZy1ZC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345219; c=relaxed/simple;
	bh=VEoQCvM186q9DxXrZg0K+e5km4a9ShOBOQoDOBrvy2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YllL20HrZ74yk5zSzOrLfdGRtTXTMc7fKSt/qnDu6aqKo0bKqmaehHggU8dsLG4SOknwh97MLIstFR5EnvCTrCTtRqHHrxQdY0w2CtlZwTFwBcaagSFfVkBS4vjeRwdlxpoMJszkzElvtfTSWhki+b/XmLIo0wgNNPQ6RMtFqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MArJI+H3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MArJI+H3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9Ihnt2021763;
	Wed, 10 Dec 2025 05:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ne929R
	hiPyRUs00DATajk5dwpkFceLauo34VmXm7wLs=; b=MArJI+H3mE5Go53w9NPjb2
	+HN7pOhwePjEouYJQwXJPAZuerz9eYjxRM15BlbbzBp+BlH9qMJYstL9mYXxKWYN
	R5tOrgft3Lq+t8XXvBkhvr2dIjaQtvpJ9UYooOWsCVxckTmBVVy9bSI5n6nkD1gw
	IPWl9z1OYEELBBxGeTmuJFyoUsR6XnP1VRSZhzeSDqiq/F3sl3kW3ABIjgLTFSiK
	8739YlUr0ROlsnlKDgysS8oGMIrw2F4yr+Vp2SJmQ8P+BWV31fGj3ifNc8F+ybOt
	esQN6ZfdNJiOiH+UxAiHRXD6d8VzOATiHQibyhuOnJdeSmbQ316553RXIAYtUkXw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7c0r2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 05:39:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BA5dWlZ002590;
	Wed, 10 Dec 2025 05:39:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7c0r2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 05:39:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA2s9gn002057;
	Wed, 10 Dec 2025 05:39:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jesct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 05:39:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BA5dkxE28705430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 05:39:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43AA858055;
	Wed, 10 Dec 2025 05:39:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30A4A5804B;
	Wed, 10 Dec 2025 05:39:42 +0000 (GMT)
Received: from [9.109.209.83] (unknown [9.109.209.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 05:39:41 +0000 (GMT)
Message-ID: <a980f102-b468-4d55-abd6-885f02dc01e9@linux.ibm.com>
Date: Wed, 10 Dec 2025 11:09:40 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf vendor power9 nest metrics: Correct unit from MB
 to MiB
To: Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain
 <kjain@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251031162637.1456191-1-irogers@google.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20251031162637.1456191-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2ppglGSntKL4WxAo853DcF0E2LN3rbti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX/8SHgUDzG9Nl
 9Wud2jEgoJeLpKOmELfpT0eYZxKmwBsXG+TFCSTJzLlwOJFcAQrog4N800x51/DddrQV9ZLvMix
 gQC/RN6QhLoQBK10d067YkPJmIugSGeRMWwtZ5yYzN2x9CqLEO9onmpm9yGK/puO5QVM44MXQci
 oiVsB9TQ5gDUowWvu2SoAzepPB3Ci6dfGtxECj3JOjip8p9usGmKQRcL4jEQi0+57I8ch0qgMBy
 6aDZSGps+SFkYBO+B39mbp+d0dk73Vy3l+3zaJCobA5NQABmrp4ixOahG7IppcFCT+8+NpAIEaB
 0aZpbRWZLFoXGleKyXFxey1aQsh1jIyLN04XOBjCLkQYTOHSJxf5lJb0aOVciWkJyyROODxCTXQ
 lVzMdOH8Ncc/+fMrS/eveMMsmUZ4Rw==
X-Proofpoint-GUID: oCsal_Q9AEjnNx5nYbC139XtcgmxujJi
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693907a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=8XikZ0b0K-H9Q15HnnIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020


On 10/31/25 9:56 PM, Ian Rogers wrote:
> 6.1e-5 is very close to 1/16384, where 16384 is 2^14, i.e. a power of
> 2. When units are in powers of 2 the IEC unit is MiB (mebibytes)
> rather than MB (megabytes) where the values are powers of 10. This
> patch corrects the unit for uniformity and because such units may be
> pattern matched against.


Changes looks fine to me.

Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
b/w  power10 metrics file could also have this fix I guess.

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   .../perf/pmu-events/arch/powerpc/power9/nest_metrics.json | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index 7a5d1bf543f8..8d028a7c2777 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -29,25 +29,25 @@
>   	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
>   	"MetricName" : "mcs01-read",
>   	"MetricGroup" : "memory-bandwidth",
> -	"ScaleUnit": "6.1e-5MB"
> +	"ScaleUnit": "6.1e-5MiB"
>       },
>       {
>   	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
>   	"MetricName" : "mcs23-read",
>   	"MetricGroup" : "memory-bandwidth",
> -	"ScaleUnit": "6.1e-5MB"
> +	"ScaleUnit": "6.1e-5MiB"
>       },
>       {
>   	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
>   	"MetricName" : "mcs01-write",
>   	"MetricGroup" : "memory-bandwidth",
> -	"ScaleUnit": "6.1e-5MB"
> +	"ScaleUnit": "6.1e-5MiB"
>       },
>       {
>   	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
>   	"MetricName" : "mcs23-write",
>   	"MetricGroup" : "memory-bandwidth",
> -	"ScaleUnit": "6.1e-5MB"
> +	"ScaleUnit": "6.1e-5MiB"
>       },
>       {
>   	"MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
