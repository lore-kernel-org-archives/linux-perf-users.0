Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435401B6CF5;
	Wed, 19 Feb 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990266; cv=none; b=mJqqZyPKB1KrVDNMilgZFXOUcfVNEeQUwkTaGLkqG1Rx5DM6c7312cfidVKGUfCbDPy+35FA9yiqorWJWakWLH5s0ACBXeYjIIwQcWN5s3hSVZa8RipWNp2hqa3yzTCQ5E4o/yjS3rbfN6/AhdRlAmATuE8B/CoUHXpC+5FJ8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990266; c=relaxed/simple;
	bh=EmZ7KSeG00YMRhRCa8woOJEatfu3xhEfOh4AqXrg/ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od/uVy+pbMtl7jsQxHyl7FoMuzLMllHb6ug9KJfI7gMaPmvZqFmJ/TiTEsZai14RxgHYh3VYl5FGJwWisbQANHi1wtBL1zu8/2pFBkLeEIzZMpkLKVJVZcjp52KcTu5aObc4NLrS+gsxkL8T+L68/X5GbdcHuBVvf5eweUl3EHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nd5LR0LN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd5LR0LN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739990264; x=1771526264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EmZ7KSeG00YMRhRCa8woOJEatfu3xhEfOh4AqXrg/ZE=;
  b=Nd5LR0LN807USzEh0J1qd6zv7iL55+fnt3e9JtUyVW/D3jRqtREXj/mD
   /kXz0xBMHDT+bcVrhrOOB88hmegZJg3XSuoFbdulHG0M4v04hOCRPGCW/
   fJUYKxyrOQPQHe9vM1vGLg7ThiZqdprmsJ0C6oB54k4lBovHJbWg42Kn/
   Iq7TCTWNRAKKASRu4/DOMFcjTn+ofAEvLvaxGl4V1MgD+FgRN7JsrxyG1
   fmf/tkSKlFEyHnVQd/5+/gmzVw107OWIZIuVkCdYYCaUDYJAGaM8SfYuz
   U+Bd2p95Vz4SwJbfR2p6upEvcNpNvb9MqBxnI0RI6+i+jl/AfPx2GGlmg
   g==;
X-CSE-ConnectionGUID: AqsotApGQBuTg/LtHzdpGA==
X-CSE-MsgGUID: 5rLokEpKTq+ajZWt08A4eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39975396"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39975396"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:37:43 -0800
X-CSE-ConnectionGUID: eZxDV/s7T+a4HyG0v8Zw/g==
X-CSE-MsgGUID: WwArcHx1TNqVUFvNqBCvzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114628779"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:37:43 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5837A20B5713;
	Wed, 19 Feb 2025 10:37:41 -0800 (PST)
Message-ID: <70aec50b-09a3-45b4-8eb9-138518a8476a@linux.intel.com>
Date: Wed, 19 Feb 2025 13:37:40 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: fix up some comments and code to properly use the
 event_source bus
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: stable <stable@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org
References: <2025021955-implant-excavator-179d@gregkh>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <2025021955-implant-excavator-179d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-19 8:40 a.m., Greg Kroah-Hartman wrote:
> In sysfs, the perf events are all located in
> /sys/bus/event_source/devices/ but some places ended up hard-coding the
> location to be at the root of /sys/devices/ which could be very risky as
> you do not exactly know what type of device you are accessing in sysfs
> at that location.
> 
> So fix this all up by properly pointing everything at the bus device
> list instead of the root of the sysfs devices/ tree.
> 
> Cc: stable <stable@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: "Liang, Kan" <kan.liang@linux.intel.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/Documentation/intel-hybrid.txt | 12 ++++++------
>  tools/perf/Documentation/perf-list.txt    |  2 +-
>  tools/perf/arch/x86/util/iostat.c         |  2 +-
>  tools/perf/builtin-stat.c                 |  2 +-
>  tools/perf/util/mem-events.c              |  2 +-
>  tools/perf/util/pmu.c                     |  4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
> index e7a776ad25d7..0379903673a4 100644
> --- a/tools/perf/Documentation/intel-hybrid.txt
> +++ b/tools/perf/Documentation/intel-hybrid.txt
> @@ -8,15 +8,15 @@ Part of events are available on core cpu, part of events are available
>  on atom cpu and even part of events are available on both.
>  
>  Kernel exports two new cpu pmus via sysfs:
> -/sys/devices/cpu_core
> -/sys/devices/cpu_atom
> +/sys/bus/event_source/devices/cpu_core
> +/sys/bus/event_source/devices/cpu_atom
>  
>  The 'cpus' files are created under the directories. For example,
>  
> -cat /sys/devices/cpu_core/cpus
> +cat /sys/bus/event_source/devices/cpu_core/cpus
>  0-15
>  
> -cat /sys/devices/cpu_atom/cpus
> +cat /sys/bus/event_source/devices/cpu_atom/cpus
>  16-23
>  
>  It indicates cpu0-cpu15 are core cpus and cpu16-cpu23 are atom cpus.
> @@ -60,8 +60,8 @@ can't carry pmu information. So now this type is extended to be PMU aware
>  type. The PMU type ID is stored at attr.config[63:32].
>  
>  PMU type ID is retrieved from sysfs.
> -/sys/devices/cpu_atom/type
> -/sys/devices/cpu_core/type
> +/sys/bus/event_source/devices/cpu_atom/type
> +/sys/bus/event_source/devices/cpu_core/type
>  
>  The new attr.config layout for PERF_TYPE_HARDWARE:
>  
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index d0c65fad419a..c3ffd93f94d7 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -188,7 +188,7 @@ in the CPU vendor specific documentation.
>  
>  The available PMUs and their raw parameters can be listed with
>  
> -  ls /sys/devices/*/format
> +  ls /sys/bus/event_source/devices/*/format
>  
>  For example the raw event "LSD.UOPS" core pmu event above could
>  be specified as
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> index 00f645a0c18a..7442a2cd87ed 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -32,7 +32,7 @@
>  #define MAX_PATH 1024
>  #endif
>  
> -#define UNCORE_IIO_PMU_PATH	"devices/uncore_iio_%d"
> +#define UNCORE_IIO_PMU_PATH	"bus/event_source/devices/uncore_iio_%d"
>  #define SYSFS_UNCORE_PMU_PATH	"%s/"UNCORE_IIO_PMU_PATH
>  #define PLATFORM_MAPPING_PATH	UNCORE_IIO_PMU_PATH"/die%d"
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 77e327d4a9a7..68ea7589c143 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -97,7 +97,7 @@
>  #include <internal/threadmap.h>
>  
>  #define DEFAULT_SEPARATOR	" "
> -#define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
> +#define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
>  
>  static void print_counters(struct timespec *ts, int argc, const char **argv);
>  
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 3692e988c86e..0277d3e1505c 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -189,7 +189,7 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
>  	if (!e->event_name)
>  		return true;
>  
> -	scnprintf(path, PATH_MAX, "%s/devices/%s/events/%s", mnt, pmu->name, e->event_name);
> +	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/%s", mnt, pmu->name, e->event_name);
>  
>  	return !stat(path, &st);
>  }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6206c8fe2bf9..a8193ac8f2e7 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -36,12 +36,12 @@
>  #define UNIT_MAX_LEN	31 /* max length for event unit name */
>  
>  enum event_source {
> -	/* An event loaded from /sys/devices/<pmu>/events. */
> +	/* An event loaded from /sys/bus/event_source/devices/<pmu>/events. */
>  	EVENT_SRC_SYSFS,
>  	/* An event loaded from a CPUID matched json file. */
>  	EVENT_SRC_CPU_JSON,
>  	/*
> -	 * An event loaded from a /sys/devices/<pmu>/identifier matched json
> +	 * An event loaded from a /sys/bus/event_source/devices/<pmu>/identifier matched json
>  	 * file.
>  	 */
>  	EVENT_SRC_SYS_JSON,

