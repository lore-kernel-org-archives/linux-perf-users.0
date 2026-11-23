Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795431670;
	b=ELHMd732ICRd6YKGiVHrnmdO/xk6Gi5TryxgnUWA7l/pWGs+MIy+DEr3gxsZSp/HVrNW
	 S7+zoSYIjB50bhda4w0i53BfZhIVXuSaKfOjilflyrefqYCFZp4owWxlacjfecCXkvPuf
	 1+npGi9C/dMu/kR8FW4EPFXyqR+y/IetYapm12ryk6m6YqT++nXZjutPRJoNxfSQrVxjY
	 vH8qgZNmfOlEHnCsB94XaJIkNj2aLHyLowLu05vw0KlpOnggszX/bR6XlFKlS0PkL/giS
	 9Y6n1NM4EPvhvqusp5giO734/liZJBAbxKu8kudVVkEbLv4VtUGpVQaR21k9bSzSGfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795431670;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=v1EPDBfCUXLkCMUnKA+ddnw+k7IZSD+WYZvJNgZjYWw=;
	b=QDMBqyyEr8PXQHkYzv3wflEeSqItpln/ekElL+MRpmB31Pthjw/tJYG6ATLKjaSPh3YX
	 AuYLYoIwQQDMA/tVbQqFJvedk7Jl7VKD2ICxNUSU9E0RpShVAGEZ7isGpIRhM5rMu3zfv
	 meP0cMjY229OzKy9s572UZ0ed5lqEqQ2NVE4o2crd8einPM6RZnuuLIoaGwHBV1iHSuGa
	 AIgu9uPpwGaVBJ/Q67nxmVSms5VWhs+n0Qgib+VsO4XUS52DcTX0UKuf2C0AIt0dfg1Wp
	 zZAkCZL4/3D2o1xjaEvlubwzWJQdrsG3WG5jC9B0EQz2AmMBB4WyL3vNrKmnbwUocPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VfxyN8YL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB7606A31A;
	Mon, 23 Nov 2026 11:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6EB7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VfxyN8YL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B38C8143D;
	Mon, 23 Nov 2026 03:01:05 -0800 (PST)
Received: from [10.0.129.12] (Suzukis-MBP.cambridge.arm.com [10.0.129.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27B53F632;
	Mon, 23 Nov 2026 03:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795431668; bh=yH94hp9pyvROLIBHpnJ0R79MNc8SMsVjXE5MaCpB5tg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VfxyN8YLNEYDqO9z4WwzX85gI/FItsDFLkbwmnuvfa7/o97r++NRfEe11vq6ymZrg
	 3Pvbba3y2TdV/GLDmvT1sW2vVHZMGYH12b92p+SgP7y8nx2XlLvC/IGD9NbeBvjWiZ
	 PtUmtTar5kCdNQnCErtakhXVBF2c7IodMInz3aG0=
Message-ID: <5b94b79b-8c4c-433d-8c9c-d92b4a8399c5@arm.com>
Date: Mon, 23 Nov 2026 11:01:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/25] coresight: perf: End AUX output when an event is
 throttled
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-4-35cf6f297d20@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-4-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2026 16:48, Leo Yan wrote:
> Since commit 9734e25fbf5a ("perf: Fix the throttle logic for a
> group"), the perf core stops every event in a throttled group by calling
> the PMU stop callback with flags set to zero:
> 
>    perf_event_throttle()
>      `> event->pmu->stop(event, 0)
> 
> The ETM perf stop callback only ends the AUX output handle when
> PERF_EF_UPDATE was set. For throttling with mode is zero, it skips to
> end the AUX handle. When the event is later unthrottled and ETM tracing
> is started again, perf_aux_output_begin() sees the perf handle is nest
> enabled and triggers a warning:
> 
>    [  181.161897] ------------[ cut here ]------------
>    [  181.161906] WARNING: kernel/events/ring_buffer.c:415 at perf_aux_output_begin+0x1dc/0x1f0, CPU#0:2
>    [  181.234120] arm-scmi arm-scmi.1.auto: timed out in resp(caller: do_xfer+0x1a0/0x558)
>    [  181.234223] cpufreq: __target_index: Failed to change cpu frequency: -110
>    [  181.286675] Modules linked in: panfrost tda9950 hdlcd tda998x drm_shmem_helper drm_client_lib cect
>    [  181.314139] CPU: 0 UID: 0 PID: 352 Comm: perf Not tainted 7.1.0-rc1-00058-gdca922e019dd-dirty #11
>    [  181.323915] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, B5
>    [  181.334732] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    [  181.341721] pc : perf_aux_output_begin+0x1dc/0x1f0
>    [  181.346547] lr : perf_aux_output_begin+0x9c/0x1f0
>    [  181.351280] sp : ffff800080003be0
>    [  181.354606] x29: ffff800080003be0 x28: ffff0008023fc000 x27: ffff4b45d287f000
>    [  181.361789] x26: ffff0009764787a8 x25: 0000000000000000 x24: ffff00080dc99710
>    [  181.368970] x23: ffffb4c334553000 x22: 0000000000000001 x21: ffff00080dc99710
>    [  181.376151] x20: ffff0009764787a8 x19: ffff000801cc6000 x18: 00000000ffffffff
>    [  181.383332] x17: 0000000000000000 x16: ffffb4c3a118c998 x15: 0000000000000000
>    [  181.390512] x14: 00003d0900000000 x13: 00000001ffff006e x12: 696765625f747570
>    [  181.397692] x11: ffffb4c3a52758d8 x10: 0000000000000108 x9 : ffffb4c3a117f620
>    [  181.404873] x8 : ffff800080003a58 x7 : ffff000808de4000 x6 : 00000000000fffff
>    [  181.412053] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>    [  181.419232] x2 : 0000000000000007 x1 : 0000000000000000 x0 : 0000000000000007
>    [  181.426411] Call trace:
>    [  181.428868]  perf_aux_output_begin+0x1dc/0x1f0 (P)
>    [  181.433692]  etm_event_start+0xdc/0x290 [coresight]
>    [  181.438665]  perf_event_unthrottle+0x70/0xa8
>    [  181.442964]  perf_event_unthrottle_group+0x40/0x170
>    [  181.447871]  perf_adjust_freq_unthr_events+0x178/0x1a8
>    [  181.453038]  perf_adjust_freq_unthr_context+0x74/0xf8
>    [  181.458120]  perf_event_task_tick+0xa8/0x290
>    [  181.462418]  sched_tick+0x144/0x2c8
>    [  181.465937]  update_process_times+0xc0/0x198
> 
> Reproduce this with the command:
> 
>    perf record -a -e cs_etm/aux-action=start-paused/k \
> 	-e cycles/aux-action=pause,period=3000/ \
> 	-e cycles/aux-action=resume,period=1500/ -- sleep 10
> 
> An update of the sink buffer is unnecessary when PERF_EF_UPDATE is not
> set, but the AUX output operation must still be terminated. End it with
> a size of zero so that a later restart can acquire a new handle.
> 
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 09b21a711a8764ea429d712890265c84648e889e..a45f69f39f175f3044322b25fe5413fb97154496 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -748,13 +748,16 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   	 * handle due to lack of buffer space), we don't
>   	 * have to do anything here.
>   	 */
> -	if (handle->event && (mode & PERF_EF_UPDATE)) {
> +	if (!handle->event)
> +		goto out;
> +
> +	if (mode & PERF_EF_UPDATE) {
>   		if (WARN_ON_ONCE(handle->event != event))
> -			return;
> +			goto out;

We seem to be disabling the path in this case, which is a new side
effect ? Do we want this ? Also, could we not move this out of the
if condition ?

Cheers
Suzuki

>   
>   		/* update trace information */
>   		if (!sink_ops(sink)->update_buffer)
> -			return;
> +			goto out;
>   
>   		size = sink_ops(sink)->update_buffer(sink, handle,
>   					      event_data->snk_config);
> @@ -773,8 +776,11 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   			perf_aux_output_end(handle, size);
>   		else
>   			WARN_ON(size);
> +	} else {
> +		perf_aux_output_end(handle, 0);
>   	}
>   
> +out:
>   	/* Disabling the path make its elements available to other sessions */
>   	coresight_disable_path(path);
>   }
> 

