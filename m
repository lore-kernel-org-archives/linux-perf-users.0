Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472335898;
	Thu,  4 Dec 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851524; cv=none; b=Z++OdnUaiDW7sNoUYcJCCHozDCXEoLNx708L5s9Lrr/KNxwRurqoEHWM2s2tSsjA5gpE6ctqPZf9hxPfKmrax20PNY0ACc50c84w5qtJE6LBICjZ4IA+udTYWMYrHa16w/wl+Twb5qIy0pkDEqfrbtwnhg9iHb/Q/m8Cfw9ki4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851524; c=relaxed/simple;
	bh=yQ7FF4tTlv5vVy/JM1xisoEQ549OG2Gj9Ri2qbTw8p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hq/0UpHNcvuxSBBOXojidAGt7xBLRjHAW16BHbOjdaaZX5Bzh8moxfc8nhW6Y8D6VJ7dKGg+unqPbmKawd6O1pU7URQvdRJZt7KVXoK3C8W7vQoJl3RLXdenlH+Yv7QxeQDmrXCGOGfYTiTquSmhvLMlG2RycuD6jLFo8I+GCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92ECD339;
	Thu,  4 Dec 2025 04:31:54 -0800 (PST)
Received: from [10.163.49.196] (unknown [10.163.49.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF183F73B;
	Thu,  4 Dec 2025 04:31:56 -0800 (PST)
Message-ID: <92ab073c-c2fc-4218-a8c8-458a69619db7@arm.com>
Date: Thu, 4 Dec 2025 18:01:53 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] coresight: trbe: Remove buffer disabling in
 trbe_handle_overflow()
To: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-3-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-3-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:51 PM, Leo Yan wrote:
> When trbe_handle_overflow() runs, the buffer has already been disabled
> and drained, so the duplicate operation is unnecessary.  Remove it.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 2f44e4a65e0ee2b2c8fdd06a51ab01fc57f44a4e..f5597bd9b5fba9a8f5053d5823b03380fd468b5c 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1077,7 +1077,6 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
>  		 * is able to detect this with a disconnected handle
>  		 * (handle->event = NULL).
>  		 */
> -		trbe_drain_and_disable_local(buf->cpudata);
>  		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
>  		return -EINVAL;
>  	}
> 

Like the previous patch - trbe_drain_and_disable_local() would have run
if TRBE_FAULT_ACT_WRAP case is being handled via trbe_handle_overflow().
But please do mention these details in the commit message for things to
be clear and explicit.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
