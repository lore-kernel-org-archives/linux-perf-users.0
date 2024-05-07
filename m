Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60D6BB20;
	Tue,  7 May 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061034; cv=none; b=MxS68HjrQgDcharyZPCauNmpXYNNx5YmW9zfNoilnMLTMoQ9kmLKoQX+cYsqbxImCmk/6dKAwXLTlYqY+al1aSK/8/ar6NMy2CXUVTCrr8LarRXlLfWeajubxFEV87FA+ol6me8ZlULVqmYFIpplPknp9t3unq1vox52g6PReVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061034; c=relaxed/simple;
	bh=/W6dzYssMBIkOqmW8TDIbDK8oNlXxHa/fxO/udxGjWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+lsBR5MI74hzIFYpqKBhlafeWl1bo5q4sgEfvtMJutwt+xIjXLYUxntgmFLYOq+ldTfxMFY45M116PP3lVKlhDP/6bc4xdj48f6E1IUh+tigujh4m6Zx0D0M96xgYTCoFuiZBPbHbpILsdgx9Y3AYxdkaJ0KO4YNP19x+ssmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A7F1042;
	Mon,  6 May 2024 22:50:56 -0700 (PDT)
Received: from [10.163.37.41] (unknown [10.163.37.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D393F587;
	Mon,  6 May 2024 22:50:21 -0700 (PDT)
Message-ID: <f6bcac4a-ba21-48dc-94f5-e1f1e1ac37a4@arm.com>
Date: Tue, 7 May 2024 11:20:23 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] coresight: Move struct coresight_trace_id_map to
 common header
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-11-james.clark@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240429152207.479221-11-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 20:51, James Clark wrote:
> The trace ID maps will need to be created and stored by the core and
> Perf code so move the definition up to the common header.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  .../hwtracing/coresight/coresight-trace-id.c  |  1 +
>  .../hwtracing/coresight/coresight-trace-id.h  | 19 -------------------
>  include/linux/coresight.h                     | 18 ++++++++++++++++++
>  3 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index af5b4ef59cea..19005b5b4dc4 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2022, Linaro Limited, All rights reserved.
>   * Author: Mike Leach <mike.leach@linaro.org>
>   */
> +#include <linux/coresight.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/cpumask.h>
>  #include <linux/kernel.h>
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 3797777d367e..49438a96fcc6 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -32,10 +32,6 @@
>  #include <linux/bitops.h>
>  #include <linux/types.h>
>  
> -
> -/* architecturally we have 128 IDs some of which are reserved */
> -#define CORESIGHT_TRACE_IDS_MAX 128
> -
>  /* ID 0 is reserved */
>  #define CORESIGHT_TRACE_ID_RES_0 0
>  
> @@ -46,21 +42,6 @@
>  #define IS_VALID_CS_TRACE_ID(id)	\
>  	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
>  
> -/**
> - * Trace ID map.
> - *
> - * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> - *		Initialised so that the reserved IDs are permanently marked as
> - *		in use.
> - * @pend_rel_ids: CPU IDs that have been released by the trace source but not
> - *		  yet marked as available, to allow re-allocation to the same
> - *		  CPU during a perf session.
> - */
> -struct coresight_trace_id_map {
> -	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
> -	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> -};
> -
>  /* Allocate and release IDs for a single default trace ID map */
>  
>  /**
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index f09ace92176e..c16c61a8411d 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -218,6 +218,24 @@ struct coresight_sysfs_link {
>  	const char *target_name;
>  };
>  
> +/* architecturally we have 128 IDs some of which are reserved */
> +#define CORESIGHT_TRACE_IDS_MAX 128
> +
> +/**
> + * Trace ID map.
> + *
> + * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> + *		Initialised so that the reserved IDs are permanently marked as
> + *		in use.
> + * @pend_rel_ids: CPU IDs that have been released by the trace source but not
> + *		  yet marked as available, to allow re-allocation to the same
> + *		  CPU during a perf session.
> + */
> +struct coresight_trace_id_map {
> +	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
> +	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> +};
> +
>  /**
>   * struct coresight_device - representation of a device as used by the framework
>   * @pdata:	Platform data with device connections associated to this device.
