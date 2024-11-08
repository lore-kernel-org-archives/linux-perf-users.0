Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7204208C4;
	Fri,  8 Nov 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080518; cv=none; b=dp0A8NWwn5CQDX87tscpT4k9hsUMuoBL4p24vNuSElGph/p7ezTnHwNUcb5o6MF/v1G6Eb/sH/jb/4XfF4CHIRXq7RuC3CXa4XiBbR6lZVhJkIOePxYRh+vpzCrmIL39fjxNBU8uUSgshkZk59IH6bHXmgEeaJWbu3ceMcXCmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080518; c=relaxed/simple;
	bh=p6Q2kENGgJYnVKYy7IH0dBBMNKRWl7ZQDQlbhq5EMfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBJX+yK6vVr2l6qHWyj52UDS7MALeT78tFZs2yI+7AHy6VqLMG35F48TKwBwbi0kGbZLO72WCICM6duI7qWEFI4dWVHCVe7xchz1f/PuOwn+6iuxZnBOLUEW3MUCRrdxJM89Omm7jOlSoYJZZzXWFBIqJYbntAw0HAkmQB4e8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C60339;
	Fri,  8 Nov 2024 07:42:24 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C0EA3F528;
	Fri,  8 Nov 2024 07:41:54 -0800 (PST)
Date: Fri, 8 Nov 2024 15:41:52 +0000
From: Leo Yan <leo.yan@arm.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V14 08/11] perf tools: Add missing_features for
 aux_start_paused, aux_pause, aux_resume
Message-ID: <20241108154152.GA197781@e132581.arm.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
 <20241022155920.17511-9-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022155920.17511-9-adrian.hunter@intel.com>

Hi Adrian,

On Tue, Oct 22, 2024 at 06:59:14PM +0300, Adrian Hunter wrote:
> 
> Display "feature is not supported" error message if aux_start_paused,
> aux_pause or aux_resume result in a perf_event_open() error.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
> 
> 
> Changes in V13:
>         Add error message also in EOPNOTSUPP case (Leo)
> 
> 
>  tools/perf/util/evsel.c | 12 ++++++++++++
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 95593b55d9a7..88b31a005ac6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2102,6 +2102,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>                 perf_missing_features.inherit_sample_read = true;
>                 pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
>                 return true;
> +       } else if (!perf_missing_features.aux_pause_resume &&
> +           (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
> +            evsel->core.attr.aux_start_paused)) {
> +               perf_missing_features.aux_pause_resume = true;
> +               pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
> +               return false;

This patch fails to apply on the latest perf-tools-next branch due to
conflict:

  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
  branch: perf-tools-next

You might need to rebase it on the latest code base.

Thanks,
Leo

>         } else if (!perf_missing_features.branch_counters &&
>             (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
>                 perf_missing_features.branch_counters = true;
> @@ -3279,6 +3285,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                         return scnprintf(msg, size,
>         "%s: PMU Hardware doesn't support 'aux_output' feature",
>                                          evsel__name(evsel));
> +               if (evsel->core.attr.aux_action)
> +                       return scnprintf(msg, size,
> +       "%s: PMU Hardware doesn't support 'aux_action' feature",
> +                                       evsel__name(evsel));
>                 if (evsel->core.attr.sample_period != 0)
>                         return scnprintf(msg, size,
>         "%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
> @@ -3309,6 +3319,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                         return scnprintf(msg, size, "clockid feature not supported.");
>                 if (perf_missing_features.clockid_wrong)
>                         return scnprintf(msg, size, "wrong clockid (%d).", clockid);
> +               if (perf_missing_features.aux_pause_resume)
> +                       return scnprintf(msg, size, "The 'aux_pause / aux_resume' feature is not supported, update the kernel.");
>                 if (perf_missing_features.aux_output)
>                         return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
>                 if (!target__has_cpu(target))
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 9fcaf417b277..87135012217d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -205,6 +205,7 @@ struct perf_missing_features {
>         bool weight_struct;
>         bool read_lost;
>         bool branch_counters;
> +       bool aux_pause_resume;
>         bool inherit_sample_read;
>  };
> 
> --
> 2.43.0
> 
> 
