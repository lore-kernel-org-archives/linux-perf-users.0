Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324716DC38;
	Mon, 22 Jul 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661199; cv=none; b=pYzfLGhf8lWNKnCzkr4jdWAmMVaAYZnH/BjJdn5bcTmBa9B9kZP8p7SDXO+DzY9RHZlO7icXQXfl8vWV5+tGIis5J9BHiZLQ6tmg/mIzlzgmadPVmmQsE8TnKCTX8ahasR3FIOfV4Pu4lStM5N1lFIrDylRH1vKOABlj0QhFWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661199; c=relaxed/simple;
	bh=rizoxx8+hePDflCVF4JFGc8TvxCR9SR+Pnn0zJJPi/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvzHfRElWTiDQ0NRQFrIURWVZseagce7YCK6nLG8w9JUGQoKi3lGaBEPyr6Sl9bAWXfdAeNRYzJKnFn9u+QgXN1P/wBBZnpmwr7OdC6cNLwg+Bc/RKBm7bf2S/LYURcQltDbIAtvQaca8sxRTlvF49x/Aemj7BLPlAPkTp/N26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4591FEC;
	Mon, 22 Jul 2024 08:13:41 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 424F83F5A1;
	Mon, 22 Jul 2024 08:13:12 -0700 (PDT)
Message-ID: <e52c54a9-d34b-49a5-8c12-c609afcea1e6@arm.com>
Date: Mon, 22 Jul 2024 16:13:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 05/13] perf tools: Enable evsel__is_aux_event() to work
 for ARM/ARM64
To: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-6-adrian.hunter@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240715160712.127117-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/15/24 17:07, Adrian Hunter wrote:
> 
> Set pmu->auxtrace on ARM/ARM64 AUX area PMUs. evsel__is_aux_event() needs
> the setting to identify AUX area tracing selected events.
> 
> Currently, the features that use evsel__is_aux_event() are used only by
> Intel PT, but that may change in the future.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>
