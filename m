Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E914B96F;
	Tue, 23 Jul 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723227; cv=none; b=aMzjk/gaQCMPCf0/a9HP+fRDbhRnfjnUF2ATR1yz5UGOvYC33sI2iU7XEd5nUHddCN0+IWS+Hcgt4xqHEQKvmGYb7rqyvWXbVJaBBsie14f9ooBal5JqE5UhAtX014sDw98c+drDqGWvyYKJ1bm6/PTd32HeYJ2UP0IOVuLCTQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723227; c=relaxed/simple;
	bh=nVezNYzjGqmQFJLuQZZzsg5AIy/dLnVBzJbEdIgu7UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqoOVY80+KlvLJEqY3nvpnDZjrs/LJlWjeXfW6dEneBES2QhHxAHyaHpsELQSlkvxNCjqriV1DZt3KBhZ3bC/5pYHgW0p/1lABtzAiZ41N/w3zqyT4y9siIuGQRPeJl2Ms2My0CAJXTNopYExqykzZy5LghIb+Bo09OjtdOig3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C319139F;
	Tue, 23 Jul 2024 01:27:28 -0700 (PDT)
Received: from [10.1.37.20] (PF4Q20KV.arm.com [10.1.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C64503F766;
	Tue, 23 Jul 2024 01:26:59 -0700 (PDT)
Message-ID: <dbfae024-c7ce-4311-9f7b-419aacc7e7d9@arm.com>
Date: Tue, 23 Jul 2024 09:26:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 06/13] perf tools: Enable evsel__is_aux_event() to work
 for S390_CPUMSF
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
 <20240715160712.127117-7-adrian.hunter@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240715160712.127117-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/2024 5:07 PM, Adrian Hunter wrote:
> 
> evsel__is_aux_event() identifies AUX area tracing selected events.
> 
> S390_CPUMSF uses a raw event type (PERF_TYPE_RAW - refer
> s390_cpumsf_evsel_is_auxtrace()) not a PMU type value that could be checked
> in evsel__is_aux_event(). However it sets needs_auxtrace_mmap (refer
> auxtrace_record__init()), so check that first.
> 
> Currently, the features that use evsel__is_aux_event() are used only by
> Intel PT, but that may change in the future.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/util/pmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 986166bc7c78..0b38c51bd6eb 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1199,8 +1199,12 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
> 
>  bool evsel__is_aux_event(const struct evsel *evsel)
>  {
> -       struct perf_pmu *pmu = evsel__find_pmu(evsel);
> +       struct perf_pmu *pmu;
> 
> +       if (evsel->needs_auxtrace_mmap)
> +               return true;
> +
> +       pmu = evsel__find_pmu(evsel);
>         return pmu && pmu->auxtrace;
>  }
> 
> --
> 2.34.1
> 
> 
