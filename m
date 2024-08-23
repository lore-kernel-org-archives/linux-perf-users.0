Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA17153800;
	Fri, 23 Aug 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413264; cv=none; b=Ju94DcU7FK3HIUMwbhHrg9nSxaXI5y6Lz/2CcWo9XLBb0WIUmD6WTKHZGs4lMd5njmgCaJWvOVIA1C8Zvk9aHAZnVqG5gwInzgwPuha3zLaWj6LRl3QfCj3Au7TJKXLYuKdYcB+E3tTn5ixnqmWLxYnPN1Nj4QlIIlc/6enCMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413264; c=relaxed/simple;
	bh=LUhOrVYfKT0isygGSeX4L4NapNsHu0dSaJKHucmj5cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ek4lCnWplCCDltvON4LUGdR8KFfyabMG7SyXccrZCIUlujYe8J1/687bTgHv4E6s5xTYSdDMvZjPuDT1GtCVHqGlGUBOPXdrrR7mGg/zUUGshI34GnHvOztpB6CYBrd+9w7UG/j1DYtxfS86USKvQZ1g13WzvrZgPVbEj6IYbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F1BDA7;
	Fri, 23 Aug 2024 04:41:28 -0700 (PDT)
Received: from [10.57.80.121] (unknown [10.57.80.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6C323F58B;
	Fri, 23 Aug 2024 04:40:59 -0700 (PDT)
Message-ID: <c2804576-6a79-46ba-b3d6-1c5879ad36b4@arm.com>
Date: Fri, 23 Aug 2024 12:40:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] perf/core: Allow multiple AUX PMU events with the
 same module
To: Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20240823113306.2310957-1-leo.yan@arm.com>
 <20240823113306.2310957-2-leo.yan@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240823113306.2310957-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter, Adrian,

On 8/23/2024 12:32 PM, Leo Yan wrote:
> 
> This commit changes the condition from checking the same PMU instance to
> checking the same .setup_aux() callback pointer. If PMU events have the
> same callback pointer, it means they share the same PMU driver module.
> This allows support for multiple PMU events with the same driver module.
> 
> As a result, more than one AUX event (e.g. arm_spe_0 and arm_spe_1)
> can record trace into the AUX ring buffer.

This patch is the only change in the kernel, so it is crucial for this
series. Can I get your opinion? Thanks a lot!

Leo 
 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  kernel/events/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c973e3c11e03..883c457911a3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12345,9 +12345,16 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
> 
>         /*
>          * If both events generate aux data, they must be on the same PMU
> +        * module but can be with different PMU instances.
> +        *
> +        * For a built-in PMU module, the 'pmu->module' pointer is NULL,
> +        * thus it is not feasible to compare the module pointers when
> +        * AUX PMU drivers are built into the kernel image. Instead,
> +        * comparing the .setup_aux() callback pointer can determine if
> +        * the two PMU events come from the same PMU driver.
>          */
>         if (has_aux(event) && has_aux(output_event) &&
> -           event->pmu != output_event->pmu)
> +           event->pmu->setup_aux != output_event->pmu->setup_aux)
>                 goto out;
> 
>         /*
> --
> 2.34.1
> 
