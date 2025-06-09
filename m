Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908C257AFE;
	Mon,  9 Jun 2025 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455035; cv=none; b=Sq0CvUowlz4sBocNucAM2NTQCzjtP/3gzd426QLTHN5NlrYqQ/22UxNphlBMuOOoB7SUVZNuhYeuZHcITQs1ubpVdLkJGJQIT78fOU82fq6+ObVgegqzczO7lQCnfK7BoHmumJWTijzin/TNRCCMaXVGFT3zJV+yScXrZmI7wmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455035; c=relaxed/simple;
	bh=txkj+wOMrqyHZaw+DGAkhHTPU5noNCM6fqXNyuwhj4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCg+u7EO3NXLOHxpOXqpPHpkgrac/GTVWJiFaf3NVbN22hzgyOOM1M3Pjg4J1s1VqK+92yFg6uKjirgrKXhuZ3FRlt2lV7t9jEy7PMJENwKyp2n7RNfWeLxyobCBBKYOj9cVOmdHUzoq21nu1K/zL8qjFZmo6KuFuzSL2iAMJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R8vH+ubX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R8vH+ubX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5591j3SF016020;
	Mon, 9 Jun 2025 07:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gDVdN8
	Yat8T3mGPbJ4HCMwJa6fqRGq+MBn3zVXY7Abc=; b=R8vH+ubXOdGhOQts2R72XD
	lUWN7s4mV5O8PHCtofSMh2h6O1/8FGKhTs/Ng8i8xUCp8TMMkGZnLKdTEjaGjQHu
	2dAG2dLNDbpV1e2V6D4A9yJxNlq8I2DhovIyaM1qTbIyHfdwvr1vMS5AtOQogU3u
	rjYYv4hGufpy1p+jx/OtxgHgGEYSTUREMYToFpIkCpZGzisd3xq4KYUbyuXgtaLf
	/raJX+3RqoMANorD5qe9gqwooevDryeCglRKIyOin3nzYPvs0pETLsFVcGdypmgR
	oVC+5s9Km43LRcekLL99qsxEn9rxFqsLGWBByvKE7lonVyZGBc830sn1tOMWGfSQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hhdpm7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 07:43:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5597ha0R021334;
	Mon, 9 Jun 2025 07:43:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hhdpm7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 07:43:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55979Rad019586;
	Mon, 9 Jun 2025 07:43:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f24dt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 07:43:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5597hUkQ27853520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Jun 2025 07:43:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3EB58045;
	Mon,  9 Jun 2025 07:43:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04CA558050;
	Mon,  9 Jun 2025 07:43:30 +0000 (GMT)
Received: from [9.61.250.8] (unknown [9.61.250.8])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Jun 2025 07:43:29 +0000 (GMT)
Message-ID: <a10fb51a-d789-453f-8962-583959beb4ea@linux.ibm.com>
Date: Mon, 9 Jun 2025 13:13:28 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] perf: Fix the throttle error of some clock events
Content-Language: en-GB
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, irogers@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
        Leo Yan <leo.yan@arm.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>
References: <20250606192546.915765-1-kan.liang@linux.intel.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250606192546.915765-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DLGP4zNb c=1 sm=1 tr=0 ts=684690a9 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=DdKJZxPaou0ld4zBaDAA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 2_xXqHmiHaEcbO081SQQ9fGpyJ_1RUxL
X-Proofpoint-ORIG-GUID: RbTo3kmworXVuGGiV9Gr3ESf_1VI-iql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA1NiBTYWx0ZWRfX+XAlyWjaZo8v qGNDW3uX62kURb8DQtOWl8feN/2N1PtO1rewtMClIrSghaEUJQ3y3yV8gNI+776Fl2rCUMxEsxK XICJD+0KQ97RW5LmATFcv29phAqjddeeLbKZt0cJnWO11+wqBo6dVN2sLTlXvKBHV5lTwGeytqg
 Ya26/J2sTtiw3MlicTn7uDy6leMAKjQzfC4zcBYLmFaXeTgD/wB+YiGPu4Z0hX4oQ+GFbppRXym HeU8qNHNuCx2k4IBQiCZ5IkBBCUp/P1Ax4SSRg48dNJf2dz8qh+NoAvpmE2AY3Bkf1AgrlAyAcw 3meCM/X9dO2lfZNJe67KyEv2G/wHa1ra+1HTpfgedGaeWcEGD/LaGEbri6d9Ortpt0dRomVchE3
 OIwtCcb3jr4Ttd3cCX40XhYVCcyyj3SLDKjcS3z+RFCzlvH6NnmGv+CI4ubyUWpplRln9JON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090056


On 07/06/25 12:55 am, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
> below perf command.
>    perf record -a -e cpu-clock -- sleep 2
>
> The issue is introduced by the generic throttle patch set, which
> unconditionally invoke the event_stop() when throttle is triggered.
>
> The cpu-clock and task-clock are two special SW events, which rely on
> the hrtimer. The throttle is invoked in the hrtimer handler. The
> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
> be used to stop the timer.
>
> There may be two ways to fix it.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
>    perf_event_throttle() if the flag is detected.
>    It has been implemented in the
>    https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>    The new flag was thought to be an overkill for the issue.
> - Add a check in the event_stop. Return immediately if the throttle is
>    invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>    method to stop the timer.
>
> The latter is implemented here.
>
> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
> the order the same as perf_event_unthrottle(). Except the patch, no one
> checks the hw.interrupts in the stop(). There is no impact from the
> order change.
>
> When stops in the throttle, the event should not be updated,
> stop(event, 0). But the cpu_clock_event_stop() doesn't handle the flag.
> In logic, it's wrong. But it didn't bring any problems with the old
> code, because the stop() was not invoked when handling the throttle.
> Checking the flag before updating the event.
>
> Reported-by: Leo Yan <leo.yan@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Closes: https://lore.kernel.org/lkml/4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu/
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---


Tested this patch by applying on top of 6.16.0-rc1, and it fixes the 
reported issue. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

>
> The patch is to fix the issue introduced by
>
>    9734e25fbf5a perf: Fix the throttle logic for a group
>
> It is still in the tip.git, I'm not sure if the commit ID is valid. So
> the Fixes tag is not added.
>
> There are some discussions regarding to a soft lockup issue.
> That is an existing issue, which are not introduced by the above change.
> It should be fixed separately.
> https://lore.kernel.org/lkml/CAADnVQ+Lx0HWEM8xdLC80wco3BTUPAD_2dQ-3oZFiECZMcw2aQ@mail.gmail.com/
>
> Changes since V3:
> - Check before update in event_stop()
> - Add Reviewed-by from Ian
>
>   kernel/events/core.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f34c99f8ce8f..cc77f127e11a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>   
>   static void perf_event_throttle(struct perf_event *event)
>   {
> -	event->pmu->stop(event, 0);
>   	event->hw.interrupts = MAX_INTERRUPTS;
> +	event->pmu->stop(event, 0);
>   	if (event == event->group_leader)
>   		perf_log_throttle(event, 0);
>   }
> @@ -11749,7 +11749,12 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
>   
> -	if (is_sampling_event(event)) {
> +	/*
> +	 * The throttle can be triggered in the hrtimer handler.
> +	 * The HRTIMER_NORESTART should be used to stop the timer,
> +	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
> +	 */
> +	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
>   		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
>   		local64_set(&hwc->period_left, ktime_to_ns(remaining));
>   
> @@ -11804,7 +11809,8 @@ static void cpu_clock_event_start(struct perf_event *event, int flags)
>   static void cpu_clock_event_stop(struct perf_event *event, int flags)
>   {
>   	perf_swevent_cancel_hrtimer(event);
> -	cpu_clock_event_update(event);
> +	if (flags & PERF_EF_UPDATE)
> +		cpu_clock_event_update(event);
>   }
>   
>   static int cpu_clock_event_add(struct perf_event *event, int flags)
> @@ -11882,7 +11888,8 @@ static void task_clock_event_start(struct perf_event *event, int flags)
>   static void task_clock_event_stop(struct perf_event *event, int flags)
>   {
>   	perf_swevent_cancel_hrtimer(event);
> -	task_clock_event_update(event, event->ctx->time);
> +	if (flags & PERF_EF_UPDATE)
> +		task_clock_event_update(event, event->ctx->time);
>   }
>   
>   static int task_clock_event_add(struct perf_event *event, int flags)
