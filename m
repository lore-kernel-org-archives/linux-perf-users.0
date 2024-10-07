Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756013B797;
	Mon,  7 Oct 2024 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328597; cv=none; b=XrZ1DgiuYDwFluca0r9DH6hSk6yag4ZJygaf9T6Vgg1xFnKFUrrPmIMyGsL41SHokfTixhcrwAL9lUVik5eB/ljO0yIRrONOb8NHZRf54bwOxJkXdyx50squy7K83NoyjEZUbY428oC2P411FqC1WtpN/6yQPkB8Eje96gKNjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328597; c=relaxed/simple;
	bh=hjgmtqWfHuUSGGNpCUvFJUzcxQ6YhsMkSL4cvOC3GLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsRpXi+db4KfThWM57lNTFcmAA3KHM8iYYJIfffMKaXSagh4z6fVuFOzEBMI9QiFfbw3emi+agqWBOe1u9jDbr9pHkknT8lC3a7pbc0Lc0h5MV2bydCEyPIX7cY55byWpwDoDtFUpygbna4GuHMBFENy3b0XAfIF+tXbRm9v6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV5V+8xM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV5V+8xM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C09C4CEC6;
	Mon,  7 Oct 2024 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728328597;
	bh=hjgmtqWfHuUSGGNpCUvFJUzcxQ6YhsMkSL4cvOC3GLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rV5V+8xM6cSeY9J6YsBLn+QQXTAb80unxwFqHalparDA01TttJZEtxm+S82dINaCY
	 GUmblJVLPj+PWzxYLahkUL1rtS+57tPM1EELun7COQd/JszSN09oarjbPdpRhjw4ml
	 bwOk2E47HsUgAruitJuCSLSjwu/Atw/+DIZ8YTewFcn/0rt4G+xQCOCt9nIlgfkDZ8
	 Y8RMrcTOD9wKJsbdzXzmGWwYdGbD4tQMx7+ohvQPKONO8ooFPqlH4nA+A7nu/4qpW5
	 BO3EL6CWrH52S77S+0daKtTRZzq5AUqJjXP8m3INxO3GCgLEX63RGNWGpemHpa1fdG
	 LvkVv9NPv54LQ==
Date: Mon, 7 Oct 2024 12:16:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH 2/8] perf/amd/ibs: Remove pointless sample period check
Message-ID: <ZwQzk7mH-QW13PtC@google.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007034810.754-3-ravi.bangoria@amd.com>

Hello,

On Mon, Oct 07, 2024 at 03:48:04AM +0000, Ravi Bangoria wrote:
> Valid perf event sample period value for IBS PMUs (Fetch and Op both)
> is limited to multiple of 0x10. perf_ibs_init() has this check:
> 
>   if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
>           return -EINVAL;
> 
> But it's broken since hwc->sample_period will always be 0 when
> event->attr.sample_freq is 0 (irrespective of event->attr.freq value.)

Right, hwc->sample_period is set to event->attr.sample_period and it's
the same as sample_freq since there are in a union.

struct perf_event_attr {
	__u32			type;
	__u32			size;
	__u64			config;
	union {
		__u64		sample_period;
		__u64		sample_freq;
	};
	...

perf_event_alloc() sets the hwc->sample_period and changes it only when
both attr->freq and attr->sample_freq are not zero.

> 
> One option to fix this is to change the condition:
> 
>   - if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
>   + if (!event->attr.freq && hwc->sample_period & 0x0f)

Right, I believe this is the intention.

> 
> However, that will break all userspace tools which have been using IBS
> event with sample_period not multiple of 0x10.

Correct.

> 
> Another option is to remove the condition altogether and mask lower
> nibble _silently_, same as what current code is inadvertently doing.
> I'm preferring this approach as it keeps the existing behavior.

Agreed.  The condition never worked and should be safe to remove.

Thanks,
Namhyung

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 347353b9eb70..6b55a8520166 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -294,13 +294,8 @@ static int perf_ibs_init(struct perf_event *event)
>  		if (config & perf_ibs->cnt_mask)
>  			/* raw max_cnt may not be set */
>  			return -EINVAL;
> -		if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
> -			/*
> -			 * lower 4 bits can not be set in ibs max cnt,
> -			 * but allowing it in case we adjust the
> -			 * sample period to set a frequency.
> -			 */
> -			return -EINVAL;
> +
> +		/* Silently mask off lower nibble. IBS hw mandates it. */
>  		hwc->sample_period &= ~0x0FULL;
>  		if (!hwc->sample_period)
>  			hwc->sample_period = 0x10;
> -- 
> 2.46.2
> 
