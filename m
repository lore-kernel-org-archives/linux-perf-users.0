Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKNJgN6c"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5372108
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Dec 2023 02:29:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d06d4d685aso14192315ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Dec 2023 02:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702031371; x=1702636171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qoKQ5iQtJ7ORKAjC/jbRnFF5PVRidwsUSKuUbzTiuc=;
        b=wKNJgN6c/ct0c7iwBrH1iRFQWXotLdF9N88tl0Ec48t0Uf6Sgh/0KRjCgWqvkPSAT3
         edB5nd2MOPRfvsKWdXJN11Ne7Fm/NaTzoFXTbxnCbp8AbnHJLUWPNlxFo+SDSnJJyNaO
         9c/iAskhpJniaSdPUHDe/j5CLZPjZ5DAWK7Y39nu8YwOB9IhInl5+5GwzDOvjMvHCUGj
         m7ISwxZtX3vNBCoVenUkUZTL6v5cuOfbvT5WNJiGgPMv9hyeoF3+L+u7exuURteU2gSt
         IHYqSBHnNMaol2uNU2GnTvO4BQVHYUKU4f01TrUMw5qAlfwaR1xdmVz+Q1NCj6RWwYEl
         iUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031371; x=1702636171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qoKQ5iQtJ7ORKAjC/jbRnFF5PVRidwsUSKuUbzTiuc=;
        b=XoGeyibNBgTdEQ9pm/EJAs01uvSOjWKL2HxABecuDANR7QkjmOU1ZmkiH+0dYGjwj9
         KGu34yxjEEqM0DdJ5d7SW1Z4SgA6mGd/I4UuENPXihFeTzsrjIOrAyPNBpDNROML27RP
         wYXvcdr4sTKPiV+EI4p34BT/5KMSYWXIJTW1O/DBTfK7kBEnfijMTNDy6bZm1y5whdta
         dNkuAO1Ik1jeQGRv2D77Pd6ANUJAqivVleraUplOq+tnXWpzv8NvFmbO03IRpEdkS0ws
         YorOWnxFXP7n0YbN4olVAh/dFGgCzuPzYa2ALJAS5fJMJ414CrWj839IDVGOzDOoM1yY
         aL+g==
X-Gm-Message-State: AOJu0YzuzP0fRxy0s79J/dW6msf6VxVKuKR73t2DQac8n9A/EzUP46W7
	eTPHSdNmunMeY9qQflw/vi+WSw==
X-Google-Smtp-Source: AGHT+IGp6gJKDTnj0Q50k3Oi+iQgxehq4lMqHqUBpi5q+BCl1I8EsTY+C3JfvDplR8rMKUtD5X/swg==
X-Received: by 2002:a17:903:1209:b0:1d0:cfdc:10cb with SMTP id l9-20020a170903120900b001d0cfdc10cbmr3805283plh.72.1702031370812;
        Fri, 08 Dec 2023 02:29:30 -0800 (PST)
Received: from leoy-huanghe.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001c9db5e2929sm1357806plx.93.2023.12.08.02.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:29:30 -0800 (PST)
Date: Fri, 8 Dec 2023 18:29:22 +0800
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
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
Message-ID: <20231208102922.GB769184@leoy-huanghe.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-2-kan.liang@linux.intel.com>

On Thu, Dec 07, 2023 at 11:23:34AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> With the mem_events, perf doesn't need to read sysfs for each PMU to
> find the mem-events-supported PMU. The patch also makes it possible to
> clean up the related __weak functions later.
> 
> The patch is only to add the mem_events into the perf_pmu for all ARCHs.
> It will be used in the later cleanup patches.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/arm64/util/mem-events.c | 4 ++--
>  tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
>  tools/perf/arch/arm64/util/pmu.c        | 6 ++++++
>  tools/perf/arch/s390/util/pmu.c         | 3 +++
>  tools/perf/arch/x86/util/mem-events.c   | 4 ++--
>  tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
>  tools/perf/arch/x86/util/pmu.c          | 7 +++++++
>  tools/perf/util/mem-events.c            | 2 +-
>  tools/perf/util/mem-events.h            | 1 +
>  tools/perf/util/pmu.c                   | 4 +++-
>  tools/perf/util/pmu.h                   | 7 +++++++
>  11 files changed, 48 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
> 
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index 3bcc5c7035c2..aaa4804922b4 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -4,7 +4,7 @@
>  
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>  
> -static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> +struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>  	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
>  	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
>  	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
> @@ -17,7 +17,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
>  	if (i >= PERF_MEM_EVENTS__MAX)
>  		return NULL;
>  
> -	return &perf_mem_events[i];
> +	return &perf_mem_events_arm[i];

I recognized that it's hard code to "arm_spe_0", which might break if
system registers different Arm SPE groups.  But this is not the issue
introduced by this patch, we might need to consider to fix it later.

>  }
>  
>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
> diff --git a/tools/perf/arch/arm64/util/mem-events.h b/tools/perf/arch/arm64/util/mem-events.h
> new file mode 100644
> index 000000000000..5fc50be4be38
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/mem-events.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ARM64_MEM_EVENTS_H
> +#define _ARM64_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX];
> +
> +#endif /* _ARM64_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 2a4eab2d160e..06ec9b838807 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -8,6 +8,12 @@
>  #include <api/fs/fs.h>
>  #include <math.h>
>  
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
> +{
> +	if (!strcmp(pmu->name, "arm_spe_0"))
> +		pmu->mem_events = perf_mem_events_arm;

This is not right and it should cause building failure on aarch64.

aarch64 reuses aarch32's file arch/arm/util/pmu.c, and this file has
already defined perf_pmu__arch_init(), you should add above change in
the file arch/arm/util/pmu.c.

Now I cannot access a machine for testing Arm SPE, but I will play
a bit for this patch set to ensure it can pass compilation.  After
that, I will seek Arm maintainers/reviewers help for the test.

Thanks,
Leo
