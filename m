Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6419D074;
	Tue, 27 Aug 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776369; cv=none; b=pDt5LJe688R1bAlgenxrDWCDYt7aXdAW9bujNJ41HCu22aUaZzohjAePXGUA9Oz8KhRdzTnCXX53H9nTitNgx48u7vcEKgrbhvHekHbZaOqri8gLH9kKfFStgW0nMNj21ka2IhPxuD2V2eFGmxGLsqlz5qkuo8HAM/xvHa4FxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776369; c=relaxed/simple;
	bh=UWasNlc54W1BHwFGH/q2jps6anYu8yLxqPLhNlKOaOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzSRMO38GEg0oEuER1kV78WgJY/ARA3daVLSvIjsh6kXO5NoBeBWlGEQxqfLDMO+1QjOPXKIAC0F/MhgMAAMy0LEwqn6V4CHKuNJbqMu94U8EnAudOZefA/sludAZ3RD7uNYojcDUqFNe6Re9qC+4Ads4p02CFjBxPe8XuNaMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNO7YGCQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNO7YGCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724776368; x=1756312368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UWasNlc54W1BHwFGH/q2jps6anYu8yLxqPLhNlKOaOw=;
  b=VNO7YGCQMjA2N00hgbucYYGlpdiv7gFyiHOIc9PuUhph2nRay3H7cijT
   53DmdtoabKg5mbOp2uFhdiziuvfE3IsZQrDOmH83+ZnMY/9UoMtIsQ824
   pGeXtrsqSGWJxeZ3gLZDqkeGEkxAEPsnaZNp4SU4WrJhkPhgCJdV1S43p
   ctcZxCsv4zOnUZ9WJ0sUy1/EvuNRiP4qfpO33Kb6+Hx21JSODmPYQ94n9
   k/OnA1ThdG6aJPGio/ladrtVE/0We5Ob4WXsm6hQJcxfHJq0jBrOx0LOz
   PFb/W42i0dhvaSGJBjSbzBRtXCZHS7x2HP9fJ4QrIOuWuOJ2vx53UIQ6d
   g==;
X-CSE-ConnectionGUID: vundmbgJT2SxUwcdKhMDOw==
X-CSE-MsgGUID: uPJjy7dtTIO4aMxaGk7F3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23448504"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23448504"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 09:32:47 -0700
X-CSE-ConnectionGUID: b8XDM3wTReyzNPyQBYvNTQ==
X-CSE-MsgGUID: epHKnMABQkuJZjqCwmY6MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63084795"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 09:32:46 -0700
Received: from [10.212.83.97] (kliang2-mobl1.ccr.corp.intel.com [10.212.83.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 43D3620CFED7;
	Tue, 27 Aug 2024 09:32:45 -0700 (PDT)
Message-ID: <a530f6de-3a89-47fc-bc4e-ea5cc57ee006@linux.intel.com>
Date: Tue, 27 Aug 2024 12:32:44 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf/core: Fix small negative period being ignored
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240821134227.577544-1-luogengkun@huaweicloud.com>
 <20240821134227.577544-2-luogengkun@huaweicloud.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240821134227.577544-2-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-21 9:42 a.m., Luo Gengkun wrote:
> In perf_adjust_period, we will first calculate period, and then use
> this period to calculate delta. However, when delta is less than 0,
> there will be a deviation compared to when delta is greater than or
> equal to 0. For example, when delta is in the range of [-14,-1], the
> range of delta = delta + 7 is between [-7,6], so the final value of
> delta/8 is 0. Therefore, the impact of -1 and -2 will be ignored.
> This is unacceptable when the target period is very short, because
> we will lose a lot of samples.
> 
> Here are some tests and analyzes:
> before:
>   # perf record -e cs -F 1000  ./a.out
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.022 MB perf.data (518 samples) ]
> 
>   # perf script
>   ...
>   a.out     396   257.956048:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.957891:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.959730:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.961545:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.963355:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.965163:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.966973:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.968785:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.970593:         23 cs:  ffffffff81f4eeec schedul>
>   ...
> 
> after:
>   # perf record -e cs -F 1000  ./a.out
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.058 MB perf.data (1466 samples) ]
> 
>   # perf script
>   ...
>   a.out     395    59.338813:         11 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.339707:         12 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.340682:         13 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.341751:         13 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.342799:         12 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.343765:         11 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.344651:         11 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.345539:         12 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.346502:         13 cs:  ffffffff81f4eeec schedul>
>   ...
> 
> test.c
> 
> int main() {
>         for (int i = 0; i < 20000; i++)
>                 usleep(10);
> 
>         return 0;
> }
> 
>   # time ./a.out
>   real    0m1.583s
>   user    0m0.040s
>   sys     0m0.298s
> 
> The above results were tested on x86-64 qemu with KVM enabled using
> test.c as test program. Ideally, we should have around 1500 samples,
> but the previous algorithm had only about 500, whereas the modified
> algorithm now has about 1400. Further more, the new version shows 1
> sample per 0.001s, while the previous one is 1 sample per 0.002s.This
> indicates that the new algorithm is more sensitive to small negative
> values compared to old algorithm.
> 
> Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

You may want to Cc stable to back port it to the LTS kernel.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  kernel/events/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c973e3c11e03..a9395bbfd4aa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4092,7 +4092,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>  	period = perf_calculate_period(event, nsec, count);
>  
>  	delta = (s64)(period - hwc->sample_period);
> -	delta = (delta + 7) / 8; /* low pass filter */
> +	if (delta >= 0)
> +		delta += 7;
> +	else
> +		delta -= 7;
> +	delta /= 8; /* low pass filter */
>  
>  	sample_period = hwc->sample_period + delta;
>  
