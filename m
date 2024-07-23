Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B5513B599;
	Tue, 23 Jul 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750720; cv=none; b=MYKOAsvAvo+YNDAmN1c9O9HpKJA+ZTeiPVuMgjS7KUY0DNLrdJOjcirhn+s39k9G1SSVlQ1wRkkt9T7INmUA7nzANveI47wc4Lfpq+80JRgZUKn2RbqtiF79mA3ZI9HwQkJYStiMBL6T8By8LzJ0gby8aWA19JPcmOFJuqQc4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750720; c=relaxed/simple;
	bh=XSB3cHZmX/mFVjU4AXw0EDtPAG2o8K+Z4DnBiMrAMws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET1tHBjByAG6SLOxlqxq48pqaH2U+nAQtC39njBpK4/BOAfJ9nT2SQUBK9ZdyrrD6T0dgyA80lKH32qSbckVewzypQfnuKdYzDju+uR0TGGd96lGwfY1JocqeFyTqgF9NPmYn22JKGMmG1jMwwXIazlD0HF0xESW+8F62FWboRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E7A81007;
	Tue, 23 Jul 2024 09:05:40 -0700 (PDT)
Received: from [10.1.37.20] (PF4Q20KV.arm.com [10.1.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEEAA3F73F;
	Tue, 23 Jul 2024 09:05:12 -0700 (PDT)
Message-ID: <7616d1dc-73e9-425e-9a62-1f3b20bec6e9@arm.com>
Date: Tue, 23 Jul 2024 17:05:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python: cs-etm: Restore first sample log in
 verbose mode
To: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Ruidong Tian <tianruidong@linux.alibaba.com>,
 Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240723132858.12747-1-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240723132858.12747-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/2024 2:28 PM, James Clark wrote:
> 
> The linked commit moved the early return on the first sample to before
> the verbose log, so move the log earlier too. Now the first sample is
> also logged and not skipped.
> 
> Fixes: 2d98dbb4c9c5 ("perf scripts python arm-cs-trace-disasm.py: Do not ignore disam first sample")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..7aff02d84ffb 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -192,17 +192,16 @@ def process_event(param_dict):
>         ip = sample["ip"]
>         addr = sample["addr"]
> 
> +       if (options.verbose == True):
> +               print("Event type: %s" % name)
> +               print_sample(sample)
> +
>         # Initialize CPU data if it's empty, and directly return back
>         # if this is the first tracing event for this CPU.
>         if (cpu_data.get(str(cpu) + 'addr') == None):
>                 cpu_data[str(cpu) + 'addr'] = addr
>                 return
> 
> -
> -       if (options.verbose == True):
> -               print("Event type: %s" % name)
> -               print_sample(sample)
> -
>         # If cannot find dso so cannot dump assembler, bail out
>         if (dso == '[unknown]'):
>                 return
> --
> 2.34.1
> 
