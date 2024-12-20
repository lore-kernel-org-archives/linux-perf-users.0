Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70C800;
	Fri, 20 Dec 2024 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655367; cv=none; b=HxK9v8uYMQVa5JLhwH8paC8Z38I4jCY8YW94WG4s2vddoYj+3kZtQlpqsgjI5k9lrxw38ud7mZwxgM0XwaqHP4z5YAwJjFcNnP6HeDgSZedpNBBKvGW+X2ZdqZJo6BSbmBvjJM02Naq133bSv+Ck/ats+odWc0iiyjGzXPjC7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655367; c=relaxed/simple;
	bh=F8XACs988i72i7l+HKg2v7Y8eiSG0u+/SzxRx6iyAKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+MgFg9bGr3Zm0u8JUErJd4unS76FpdQEahQfybF4a68WDrYzurT+NjvFy0WJnL4wXpGPjuv2wA4hECMLqo7HwlGY9weBeiypsQEk85DX3GUCuWTxp3n4YZkW1xgwrLnwZ5+CWOYtmfxSqevGWGchk/AM99uK0/sT+MNtVogB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKGya867; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKGya867"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734655366; x=1766191366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F8XACs988i72i7l+HKg2v7Y8eiSG0u+/SzxRx6iyAKw=;
  b=RKGya867VjJSEEk8vrnADIOlA27zxmEVaXiEOasrA/f1gC0BIj+LkLKF
   RDt2VOYm0hHHLxZVhdwzg2Ciji1WWaqg7F8gJHJkGqtn9DhRnjZzZQL16
   Te6qQacte3q3DAjT7y64MVALVCecTJ0XTTb0FDOAAbHMJ78Daa09dzTbk
   w7JNt7mhNvTPvDLmfwAVp1AmvpqXYyyjWzpDhVs1sG2kk4BvUMnNdDI1P
   fm1VWRModAsmbtDAPHJOjd66utMy56zW14Avgw/iXXaSfXld+uPNs1ofW
   UBCfTenkgwbjj2rdPQRpE/9LLGTpb928UXm997SAMq/cYyEPArzp0Nkis
   g==;
X-CSE-ConnectionGUID: mY1fx5OERz+20crmKEADiA==
X-CSE-MsgGUID: nD+hJVP1S+eq5Frc2L2d7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="34521288"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="34521288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 16:42:45 -0800
X-CSE-ConnectionGUID: ix93rQpySfSMrFAAwqVxLw==
X-CSE-MsgGUID: GCSbjl4oQGGkOPNx01sfvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102977324"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 16:42:44 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7365D20B5713;
	Thu, 19 Dec 2024 16:42:43 -0800 (PST)
Message-ID: <eefa07cf-7f27-4432-949a-50de4a0ae304@linux.intel.com>
Date: Thu, 19 Dec 2024 19:42:42 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/3] perf: Extend perf_output_read
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
 <20241218151643.1031659-2-kan.liang@linux.intel.com>
 <20241219222110.GH26279@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241219222110.GH26279@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-19 5:21 p.m., Peter Zijlstra wrote:
> On Wed, Dec 18, 2024 at 07:16:42AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The event may have been updated in the PMU-specific implementation,
>> e.g., Intel PEBS counters snapshotting. The common code should not
>> read and overwrite the value.
>>
>> The PERF_SAMPLE_READ in the data->sample_type can be used to detect
>> whether the PMU-specific value is available. If yes, avoid the
>> pmu->read() in the common code.
> 
> I had a poke at this, and ended up with the below. Not sure though,
> wdyt?

It looks good to me. I will do more tests tomorrow and send a V7.

Thanks,
Kan
> 
> ---
>  include/linux/perf_event.h  |  8 +++++++-
>  kernel/events/core.c        | 33 ++++++++++++++++-----------------
>  kernel/events/ring_buffer.c |  1 +
>  3 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 8333f132f4a9..582f517a5dc8 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1062,7 +1062,13 @@ struct perf_output_handle {
>  	struct perf_buffer		*rb;
>  	unsigned long			wakeup;
>  	unsigned long			size;
> -	u64				aux_flags;
> +	union {
> +		u64			flags;	   /* perf_output*() */
> +		u64			aux_flags; /* perf_aux_output*() */
> +		struct {
> +			u64		skip_read : 1;
> +		};
> +	};
>  	union {
>  		void			*addr;
>  		unsigned long		head;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b2bc67791f84..f91ba29048ce 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1191,6 +1191,12 @@ static void perf_assert_pmu_disabled(struct pmu *pmu)
>  	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
>  }
>  
> +static inline void perf_pmu_read(struct perf_event *event)
> +{
> +	if (event->state == PERF_EVENT_STATE_ACTIVE)
> +		event->pmu->read(event);
> +}
> +
>  static void get_ctx(struct perf_event_context *ctx)
>  {
>  	refcount_inc(&ctx->refcount);
> @@ -3473,8 +3479,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
>  	 * we know the event must be on the current CPU, therefore we
>  	 * don't need to use it.
>  	 */
> -	if (event->state == PERF_EVENT_STATE_ACTIVE)
> -		event->pmu->read(event);
> +	perf_pmu_read(event);
>  
>  	perf_event_update_time(event);
>  
> @@ -4618,15 +4623,8 @@ static void __perf_event_read(void *info)
>  
>  	pmu->read(event);
>  
> -	for_each_sibling_event(sub, event) {
> -		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
> -			/*
> -			 * Use sibling's PMU rather than @event's since
> -			 * sibling could be on different (eg: software) PMU.
> -			 */
> -			sub->pmu->read(sub);
> -		}
> -	}
> +	for_each_sibling_event(sub, event)
> +		perf_pmu_read(sub);
>  
>  	data->ret = pmu->commit_txn(pmu);
>  
> @@ -7400,9 +7398,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>  		values[n++] = running;
>  
> -	if ((leader != event) &&
> -	    (leader->state == PERF_EVENT_STATE_ACTIVE))
> -		leader->pmu->read(leader);
> +	if ((leader != event) && !handle->skip_read)
> +		perf_pmu_read(leader);
>  
>  	values[n++] = perf_event_count(leader, self);
>  	if (read_format & PERF_FORMAT_ID)
> @@ -7415,9 +7412,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  	for_each_sibling_event(sub, leader) {
>  		n = 0;
>  
> -		if ((sub != event) &&
> -		    (sub->state == PERF_EVENT_STATE_ACTIVE))
> -			sub->pmu->read(sub);
> +		if ((sub != event) && !handle->skip_read)
> +			perf_pmu_read(sub);
>  
>  		values[n++] = perf_event_count(sub, self);
>  		if (read_format & PERF_FORMAT_ID)
> @@ -7476,6 +7472,9 @@ void perf_output_sample(struct perf_output_handle *handle,
>  {
>  	u64 sample_type = data->type;
>  
> +	if (data->sample_flags & PERF_SAMPLE_READ)
> +		handle->skip_read = 1;
> +
>  	perf_output_put(handle, *header);
>  
>  	if (sample_type & PERF_SAMPLE_IDENTIFIER)
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4f46f688d0d4..9b49ecca693e 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -185,6 +185,7 @@ __perf_output_begin(struct perf_output_handle *handle,
>  
>  	handle->rb    = rb;
>  	handle->event = event;
> +	handle->flags = 0;
>  
>  	have_lost = local_read(&rb->lost);
>  	if (unlikely(have_lost)) {
> 

