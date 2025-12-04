Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6402C11D9;
	Thu,  4 Dec 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852250; cv=none; b=pkTatExe2PjIRUCwampe4rx8g6x8Avh1Z/vOkvukxGGXvC847wS+CS3j5QjieRvnFCJ8vW1A10MMRtURk+atqRMvTFtIK78xkga9i0glBhUeUpbjnPLb1UPX8d74lycL1Ky+fnir1xsTapWyCPIndvJUEOzIeHLw75VfJtJKg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852250; c=relaxed/simple;
	bh=WzG3RMmSsZoe4jqT1lSZceqSLkIUVx1PT/e6OVC4RSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NL5PyMss8XTTvteM2vwFciH8q6+Vd4GujyGxMpuyQ/7nxLnoLB0Z3qvWVgKCjZuXtjF1ZqvxRlJnzdsH0L89fNmwVn17R0JnPhhgD5rIFKOAdnCklo708CC3kSV7kzSuOsyxwRQNQI/qMGKAepsn3adfX/OlHyy4zco+37pjU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F02F339;
	Thu,  4 Dec 2025 04:43:58 -0800 (PST)
Received: from [10.163.49.196] (unknown [10.163.49.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85A4C3F73B;
	Thu,  4 Dec 2025 04:43:59 -0800 (PST)
Message-ID: <789573eb-c12b-419f-80bc-3de65367583e@arm.com>
Date: Thu, 4 Dec 2025 18:13:56 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] coresight: trbe: Remove set_trbe_disabled() from
 the enable flow
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
 <20251201-trbe_buffer_refactor_v1-1-v1-4-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-4-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:51 PM, Leo Yan wrote:
> set_trbe_disabled() should never appear in the enable flow, otherwise,
> it may potentially hide bugs in the disable flow.
> 
> Remove set_trbe_disabled() from the enable path.

IIRC without first disabling TRBLIMITR_EL1_E - TRBE registers or their
fields should not be fetched or interpreted. Without that none of the
subsequent HW operations should be performed inside trbe_enable_hw()
leading upto enabling it.

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index f5597bd9b5fba9a8f5053d5823b03380fd468b5c..e426991e2c2c398a9d3982e9d0f7f542e404cbab 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -629,7 +629,6 @@ static void trbe_enable_hw(struct trbe_buf *buf)
>  	WARN_ON(buf->trbe_hw_base < buf->trbe_base);
>  	WARN_ON(buf->trbe_write < buf->trbe_hw_base);
>  	WARN_ON(buf->trbe_write >= buf->trbe_limit);
> -	set_trbe_disabled(buf->cpudata);
>  	clr_trbe_status();
>  	set_trbe_base_pointer(buf->trbe_hw_base);
>  	set_trbe_write_pointer(buf->trbe_write);
> 

