Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNmeWsNL"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B410F1
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Dec 2023 21:48:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d05e4a94c3so24736815ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Dec 2023 21:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702100899; x=1702705699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I7r2/wVFWqLNrwi39oQp458P9HsniHeT8Z6IKjjg5Ps=;
        b=tNmeWsNLDT3nXBSGuwAGE6nTjQnv1pSNJVL0ZX5KP/pJQuyPCU1YRreQrQ4HZqsSz2
         AXH323VFD5r+jw0EcrXkaJFRVlRxTA6A9YXv7SZC71ai+Sp6dxj8qGw03gQsBLtbM4Qn
         /9y3HfOgvEyZPSuztGM0GEqmT3/35YLf7AAAL8VCKHf615nUPBIPU8xNTVORIex4ewfX
         lxuXRHN4x2ZlHDCWbMcd+Q1fP1B7tMG68ZCB2Qsyu9W96uUNlRqPV7J28B8Vr4BPQs8B
         h6wVn3CO0SFvrHHkLm/01SyamwcAYChKMGIs12X+fa3niio+ab2HmiTrbYf0NATPuXj0
         2uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702100899; x=1702705699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7r2/wVFWqLNrwi39oQp458P9HsniHeT8Z6IKjjg5Ps=;
        b=cWGFXVxe+ysjTem9Wtna1UkgGmQYwBFy63sLZon+PA1BX5HOpCebpFfDffgKcB76dM
         vfk5PUCPILuiFL/lMK93zE3/lx2cB2qATqM4ltvbZWtUkXC4SqMtMgTCC54KBNMX/L/s
         szijW5I9Jn2fMcV2LAYMVRIQbaKKNRRkok/2IU5LoMLdQ7rFa15TZHTjGG0EvttlYoo8
         eed4kbor/6qwiQYS+0US9jGz3mElzqj7UdpoUDhT0yMEV1K/5a/uBLO5bxuaROLRR27t
         +LLT12OR9W8Gzm9sAgUPlKDU30dwjGAoE14AF1Tw+rtWV/iONpMVxkGCJ+P+YOcNYL2e
         O5vg==
X-Gm-Message-State: AOJu0YxporhdcC+ZO2z4XYZrirNuMmaErnDySgdEl+WV5EEVrvmgcVJi
	yb1wIBTbVSgGgB0FYtSn49WXyg==
X-Google-Smtp-Source: AGHT+IEmcCGdGFhSjINurTckGIsRnDeFVE4Kbs1820z20S8wAk2wMmbCbPUXNynKN/jZcuj7SaBZeQ==
X-Received: by 2002:a17:903:41cf:b0:1d0:9661:1618 with SMTP id u15-20020a17090341cf00b001d096611618mr1174568ple.105.1702100898897;
        Fri, 08 Dec 2023 21:48:18 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001cfc6838e30sm2620926plb.308.2023.12.08.21.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 21:48:18 -0800 (PST)
Date: Sat, 9 Dec 2023 13:48:09 +0800
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
Subject: Re: [PATCH V2 3/5] perf mem: Clean up perf_mem_events__name()
Message-ID: <20231209054809.GB2116834@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-4-kan.liang@linux.intel.com>

On Thu, Dec 07, 2023 at 11:23:36AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
> one.

Now memory event naming is arch dependent, this is because every arch
has different memory PMU names, and it appends specific configurations
(e.g. aarch64 appends 'ts_enable=1,...,min_latency=%u', and x86_64
appends 'ldlat=%u', etc).  This is not friendly for extension, e.g. it's
impossible for users to specify any extra attributes for memory events.

This patch tries to consolidate in a central place for generating memory
event names, its approach is to add more flags to meet special usage
cases, which means the code gets more complex (and more difficult for
later's maintenance).

I think we need to distinguish the event naming into two levels: in
util/mem-events.c, we can consider it as a common layer, and we maintain
common options in it, e.g. 'latency', 'all-user', 'all-kernel',
'timestamp', 'physical_address', etc.  In every arch's mem-events.c
file, it converts the common options to arch specific configurations.

In the end, this can avoid to add more and more flags into the
structure perf_mem_event.

Anyway, I also have a question for this patch itself, please see below
inline comment.

[...]

> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index 2602e8688727..eb2ef84f0fc8 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -2,28 +2,10 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>  
> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>  
>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
> -	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
> -	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
> -	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
> +	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0",	true,	0),
> +	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0",	false,	0),
> +	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0",	true,	0),

Arm SPE is AUX event, should set '1' to the field '.aux_event'.

I am a bit suspect if we really need the field '.aux_event', the
'.aux_event' field is only used for generating event string.

So in the below function perf_pmu__mem_events_name(), I prefer to call
an arch specific function, e.g. arch_memory_event_name(event_id, cfg),
the parameter 'event_id' passes memory event ID for load, store, and
load-store, and the parameter 'cfg' which is a pointer to the common
memory options (as mentioned above for latency, all-user or all-kernel
mode, timestamp tracing, etc).

In the end, the common layer just passes the common options to low
level arch's layer and get a event string for recording.

Thanks,
Leo
