Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyT/tVB6"
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0061710D2
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Dec 2023 22:27:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2328484a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Dec 2023 22:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702103245; x=1702708045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOywlATSaLLTLIkfA5QrbrC4pRY38TI520iihL5e3qI=;
        b=VyT/tVB6HmkoGkkl7flJwE3lbmlmTs4zIoQBfOfY7qVyu3KYSRKDrW6J8TfZvYIC/4
         ggF207DLRC0i2cmlF9fMci3nB6WedTypdjQ4yRtif27OSR2srAZjRgHIpBcVngt/8YB+
         21293DC4V0QnmCvjjHaNsjNnC/1MYD54IN9jK7SmJC14zRIzpyFx/0/tELEW4lbNHzMo
         Y5do5IfaLBS53QIGYkscUr4q6SwjfiJyvbdDdFWgg4xckF1BtcjOAtdhMbG5A7mwBEPa
         hQLVsKxhtDxSUas2YnE5/tuXypJPjTpsoC6CPXzsPojqqdRaSkCH/UYa30hJv1KAFlZ1
         2TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702103245; x=1702708045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOywlATSaLLTLIkfA5QrbrC4pRY38TI520iihL5e3qI=;
        b=Dbx4RQoOJs180qX28jgiL6s6Mv8eFj25zjTFbQ4VaHFmMSObwH6tbV5Lt7yAQzi67k
         iastHnhXgawV+sQGvkkxv0HVqu23UInn/6SrJ0MidZXO8BmDGwPZyQAKCZ5j7g5sqB6B
         Zpo0mfauQbtgvvkdaorIstUdzDxDcjNIbE2Pr7jzL50bQ/X5CJxIeZb4MvtX9VT3vbt6
         qXPJfAChZA/VYqckUjeWEZ7VzYb+ynzsw2nrFDNUtXvMvuiZkKxR9q+zej0suuwrKag2
         4GIuAKb3y+oDW5VTWhYpcQDquJ9kWTKf2W/EmlRNSvRqs/R01ym5lL1E3927/9XPMTDY
         vd0w==
X-Gm-Message-State: AOJu0Yzb5sXVGQjEMufmpArTg+afX8x0dCEvf+AH4eqTiaW+qGI51qNA
	DqUNEAhIHI9G6ztvieyrPRtGSFX8z55aIceVjmK0b+nN
X-Google-Smtp-Source: AGHT+IG9nHpHovhaTeu532zPZLD/DDj4SvRjGeL7lzhycSyevoMivwHnKhcOWE0TbNrPry+h/gO4sw==
X-Received: by 2002:a05:6a21:339b:b0:18b:30e2:7e55 with SMTP id yy27-20020a056a21339b00b0018b30e27e55mr1463576pzb.46.1702103245352;
        Fri, 08 Dec 2023 22:27:25 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id a4-20020aa78644000000b006ce36ffb0cfsm2579290pfo.33.2023.12.08.22.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:27:24 -0800 (PST)
Date: Sat, 9 Dec 2023 14:27:09 +0800
From: Leo Yan <leo.yan@linaro.org>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
	adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
	james.clark@arm.com, mike.leach@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 5/5] perf mem: Clean up is_mem_loads_aux_event()
Message-ID: <20231209062709.GD2116834@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-6-kan.liang@linux.intel.com>

On Thu, Dec 07, 2023 at 11:23:38AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The aux_event can be retrieved from the perf_pmu now. Implement a
> generic support.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/mem-events.c | 23 ++++-------------------
>  tools/perf/util/mem-events.c          | 14 ++++++++++++--
>  2 files changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index b776d849fc64..62df03e91c7e 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -1,11 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "util/pmu.h"
> -#include "util/pmus.h"
> -#include "util/env.h"
> -#include "map_symbol.h"
> -#include "mem-events.h"
>  #include "linux/string.h"
> -#include "env.h"
> +#include "util/map_symbol.h"
> +#include "util/mem-events.h"
> +#include "mem-events.h"
> +
>  
>  #define MEM_LOADS_AUX		0x8203
>  
> @@ -28,16 +26,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E("mem-ldst",	"%s//",		NULL,	false,	0),
>  };
> -
> -bool is_mem_loads_aux_event(struct evsel *leader)
> -{
> -	struct perf_pmu *pmu = perf_pmus__find("cpu");
> -
> -	if (!pmu)
> -		pmu = perf_pmus__find("cpu_core");
> -
> -	if (pmu && !perf_pmu__have_event(pmu, "mem-loads-aux"))
> -		return false;
> -
> -	return leader->core.attr.config == MEM_LOADS_AUX;
> -}
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0d174f161034..d418320e52e3 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -103,9 +103,19 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
>  	return NULL;
>  }
>  
> -__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
> +bool is_mem_loads_aux_event(struct evsel *leader)
>  {
> -	return false;
> +	struct perf_pmu *pmu = leader->pmu;
> +	struct perf_mem_event *e;
> +
> +	if (!pmu || !pmu->mem_events)
> +		return false;
> +
> +	e = &pmu->mem_events[PERF_MEM_EVENTS__LOAD];
> +	if (!e->aux_event)
> +		return false;
> +
> +	return leader->core.attr.config == e->aux_event;
>  }

I am wandering if we need to set the field 'aux_event' for Arm SPE.

So a quesiton maybe is not relevant with this patch actually, we can
see is_mem_loads_aux_event() is invoked in the file util/record.c:

  static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evlist)
  {
          struct evsel *leader = evsel__leader(evsel);

          if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader) ||
              is_mem_loads_aux_event(leader)) {
              ...
          }
  
          return leader;
  }

Has evsel__is_aux_event() covered the memory load aux event?  If it's,
then is_mem_loads_aux_event() is not needed anymore.

Thanks,
Leo
