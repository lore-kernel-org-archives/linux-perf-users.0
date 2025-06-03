Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FE11CAF;
	Tue,  3 Jun 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954744; cv=none; b=k5e7unMJriSEdoAM4UeNNmEblIbNe5+oBMAPSDYo95wyOxyXxsQFKzaYyw6QiUJILB2ps/tvdS6s061h+Y25ZVPSLLT6Qk7/L3VPFkNDEh9gxRaUy3VxzxqcfVDSCPOQjKHr+UUgym6K9JOGQjJa/vfvpLsN121O2mRKXiSo5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954744; c=relaxed/simple;
	bh=V5UWiQ2cd2GZDq83YkJb6HXdl0zlt3Ihyk4bCUmA5jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SssQKzCowDDbH2LC7rTIoTjWOgl3PrGWzYafMiTGICNy5FLwA3bpraaGQ/Oy1z651yGi3JPut9j1kMmEm8/zLeSbBwTQFvSBa+3TF/v6MS+iRrhGuI9lmvK4DImipQvrrgRAa+x6T1ELYL7PVJsm1D33oeklbdaKBJ9iJK31ww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EDhvxov/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EDhvxov/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5536wXxH031594;
	Tue, 3 Jun 2025 12:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WsTFJJ
	zNvHeSfLCtA5LsOyoO3yuPGZRu4LtJ9glu2r4=; b=EDhvxov/Rop/AWT5c5F+ev
	my5OFqkmYmTK2+hlaZ1/Ph5dYe8FxzqzxdKgKjn+QiOtexPGH9IER9GliDwe3r2J
	PTQz2vZKcLU6dmknRXG0jlKtj9ws2SLjmQ+FHpNmYeXsNSYj/SDmO11maXaCiMYr
	22ZeWg8JJJucMlq1xhh/HlbMnlp/yczpHPtzSKX0ThWBOAkxNEi9r7AIc4A4sx1j
	QcHZh0sDZV1oKr1qvn0m4+nzTi7HWyL/7bdbO/UQeBUPUpCt3TYvsSZH6ChoTHsq
	W00J8JBt1mjMoBrQru6oIAR5wXFXfb9R5wANAz4PW8TtRIzOyFzTu+7k6+pp86xw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf04d4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 12:45:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 553Cf60m023086;
	Tue, 3 Jun 2025 12:45:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf04d4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 12:45:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553A81qm028479;
	Tue, 3 Jun 2025 12:45:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 470eakakv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 12:45:24 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 553CjMEM32834256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Jun 2025 12:45:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D5BA5805E;
	Tue,  3 Jun 2025 12:45:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2022A58052;
	Tue,  3 Jun 2025 12:45:18 +0000 (GMT)
Received: from [9.61.248.228] (unknown [9.61.248.228])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Jun 2025 12:45:17 +0000 (GMT)
Message-ID: <8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com>
Date: Tue, 3 Jun 2025 18:15:16 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf: Fix the throttle error of some clock events
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, irogers@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
        leo.yan@arm.com, Aishwarya TCV <aishwarya.tcv@arm.com>
References: <20250528175832.2999139-1-kan.liang@linux.intel.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250528175832.2999139-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wyXliENgdp2QtoF2R1PL3Sa3uY9peLpc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwOSBTYWx0ZWRfX8TXD4jvfA4++ D0y/ZXk99erNTDSxVkxJZD7aCVBmolNKr98ezndg18v5RftIJsBC0mtmF+pZ5hINDNYoSm99b+t am4YMjPIGu6Uf+UKis5YCv8wq1HwdBZnHcOIRfqgUzQ+dYh1rJCPea5z7z4oF+p+i2ToEt8iscW
 yeXqdH+GpqnOgcJH+P5lbxFditQZp2w2EY4sDCEaq0KXwJZPrYV6KBbebBYXDO38BGAnTQWeD43 8EHkwkTvPgIxA9+EuPrithRfySO2k876vPSkp+wTkhXG0/JbzvdoBSlaNHj9DyEPbO5vgDwVZNz XzWLljzksSX1DchhnUtwjCy6YnQbtnmG8t3uRJQd4EDp4Xem6m7Gsz+oQEamsNwdBPsLW25PJwC
 lf9PWoehoAmirIvfbSLn2IN8tPiKjbv3dLH2AdKQsNXINfo9AF7cyfWNn5ncTNZRkZcNl6RY
X-Proofpoint-ORIG-GUID: Ak6jrcKSPN8OTB08XFQouZ6p0dAYbvDi
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=683eee69 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=KJf0t8lbo5Kj145lKHwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030109


On 28/05/25 11:28 pm, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The Arm CI reports RCU stall, which can be reproduced by the below perf
> command.
>    perf record -a -e cpu-clock -- sleep 2


This issue is reported on IBM CI as well. But the issue is hit, while 
running perf test (specifically while running  76: perf list tests)

>
> The cpu-clock and task_clock are two special SW events, which rely on
> the hrtimer. Instead of invoking the stop(), the HRTIMER_NORESTART is
> returned to stop the timer. Because the hrtimer interrupt handler cannot
> cancel itself, which causes infinite loop.
>
> There may be two ways to fix it.
> - Add a check of MAX_INTERRUPTS in the event_stop. Return immediately if
> the stop is invoked by the throttle.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
> perf_event_throttle() if the flag is detected.
>
> The latter looks more generic. It may be used if there are more other
> cases that want to avoid the stop later. The latter is implemented.


Tested this patch by applying on the linux-mainline kernel on IBM Power9 
system, and it fixes the issue. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.

>
> Reported-by: Leo Yan <leo.yan@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>
> Changes since V1:
> - Rebase on top of the latest tip.git
> - Add Tested-by from Leo
>
>   include/linux/perf_event.h |  1 +
>   kernel/events/core.c       | 23 ++++++++++++++++++++---
>   2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 52dc7cfab0e0..97a747a97a50 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -305,6 +305,7 @@ struct perf_event_pmu_context;
>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
>   #define PERF_PMU_CAP_AUX_PAUSE		0x0200
>   #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
> +#define PERF_PMU_CAP_NO_THROTTLE_STOP	0x0800
>   
>   /**
>    * pmu::scope
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f34c99f8ce8f..abd19bb571e3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2656,7 +2656,22 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>   
>   static void perf_event_throttle(struct perf_event *event)
>   {
> -	event->pmu->stop(event, 0);
> +	/*
> +	 * Some PMUs, e.g., cpu-clock and task_clock, may rely on
> +	 * a special mechanism (hrtimer) to manipulate counters.
> +	 * The regular stop doesn't work, since the hrtimer interrupt
> +	 * handler cannot cancel itself.
> +	 *
> +	 * The stop should be avoided for such cases. Let the
> +	 * driver-specific code handle it.
> +	 *
> +	 * The counters will eventually be disabled in the driver-specific
> +	 * code. In unthrottle, they still need to be re-enabled.
> +	 * There is no handling for PERF_PMU_CAP_NO_THROTTLE_STOP in
> +	 * the perf_event_unthrottle().
> +	 */
> +	if (!(event->pmu->capabilities & PERF_PMU_CAP_NO_THROTTLE_STOP))
> +		event->pmu->stop(event, 0);
>   	event->hw.interrupts = MAX_INTERRUPTS;
>   	if (event == event->group_leader)
>   		perf_log_throttle(event, 0);
> @@ -11848,7 +11863,8 @@ static int cpu_clock_event_init(struct perf_event *event)
>   static struct pmu perf_cpu_clock = {
>   	.task_ctx_nr	= perf_sw_context,
>   
> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>   	.dev		= PMU_NULL_DEV,
>   
>   	.event_init	= cpu_clock_event_init,
> @@ -11930,7 +11946,8 @@ static int task_clock_event_init(struct perf_event *event)
>   static struct pmu perf_task_clock = {
>   	.task_ctx_nr	= perf_sw_context,
>   
> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>   	.dev		= PMU_NULL_DEV,
>   
>   	.event_init	= task_clock_event_init,
