Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB12EEC5;
	Thu,  6 Jun 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681820; cv=none; b=S3bQ2aCSe3cDjN+1qGFJ9EhxDdroDiuOJk13zA6Rm1a8IPyh4ulUgO3H5sTVXYhac/OKlRGuCN0xkqAjyUVKJFH3mqd9ECiURcirNJglxVKLZLn/ro+C4DWRU3/arNk+3eo4EwJsh64mHOhnH4FwJHfp6qH5OQNm25HBa5Ex6Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681820; c=relaxed/simple;
	bh=3LuX/QV3TpK7qr9XiAHZUziseAcl7DjB5NEfhSz4sGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPPWA2TUaAiwRsj3tVZrSjatvxJN8KlJzP+wbVp7dw/DZgB0QyvbQlFL5jJQ6/ZWRxWQv2xW09yqrjBAk6ngG1+i0StRyMcUVRd3AVOjMpItPn0bGmlSiKeH/dJM/CLyzh8/VBaoDVnkxVWr+dWSOTMydT2sU7g1WB2T+ky8KCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB5C2F4;
	Thu,  6 Jun 2024 06:50:41 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1272C3F64C;
	Thu,  6 Jun 2024 06:50:12 -0700 (PDT)
Message-ID: <d8b016dc-2ab0-442b-97b9-00ae352553c6@arm.com>
Date: Thu, 6 Jun 2024 14:50:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] coresight: Expose map arguments in trace ID API
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 leo.yan@linux.dev, anshuman.khandual@arm.com
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240604143030.519906-1-james.clark@arm.com>
 <20240604143030.519906-12-james.clark@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240604143030.519906-12-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 15:30, James Clark wrote:
> The trace ID API is currently hard coded to always use the global map.
> Add public versions that allow the map to be passed in so that Perf
> mode can use per-sink maps. Keep the non-map versions so that sysfs
> mode can continue to use the default global map.
> 
> System ID functions are unchanged because they will always use the
> default map.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   .../hwtracing/coresight/coresight-trace-id.c  | 36 ++++++++++++++-----
>   .../hwtracing/coresight/coresight-trace-id.h  | 20 +++++++++--
>   2 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index 19005b5b4dc4..5561989a03fa 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -12,7 +12,7 @@
>   
>   #include "coresight-trace-id.h"
>   
> -/* Default trace ID map. Used on systems that don't require per sink mappings */
> +/* Default trace ID map. Used in sysfs mode and for system sources */
>   static struct coresight_trace_id_map id_map_default;
>   
>   /* maintain a record of the mapping of IDs and pending releases per cpu */
> @@ -47,7 +47,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
>   #endif
>   
>   /* unlocked read of current trace ID value for given CPU */
> -static int _coresight_trace_id_read_cpu_id(int cpu)
> +static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>   {
>   	return atomic_read(&per_cpu(cpu_id, cpu));
>   }
> @@ -152,7 +152,7 @@ static void coresight_trace_id_release_all_pending(void)
>   	DUMP_ID_MAP(id_map);
>   }
>   
> -static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>   {
>   	unsigned long flags;
>   	int id;
> @@ -160,7 +160,7 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>   	spin_lock_irqsave(&id_map_lock, flags);

Could we also reduce the contention on the id_map_lock, by moving the 
spinlock per map ? It can be a separate patch.

This patch as such looks good to me.

Suzuki


>   
>   	/* check for existing allocation for this CPU */
> -	id = _coresight_trace_id_read_cpu_id(cpu);
> +	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
>   	if (id)
>   		goto get_cpu_id_clr_pend;
>   
> @@ -196,13 +196,13 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>   	return id;
>   }
>   
> -static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>   {
>   	unsigned long flags;
>   	int id;
>   
>   	/* check for existing allocation for this CPU */
> -	id = _coresight_trace_id_read_cpu_id(cpu);
> +	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
>   	if (!id)
>   		return;
>   
> @@ -254,22 +254,40 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>   
>   int coresight_trace_id_get_cpu_id(int cpu)
>   {
> -	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
> +	return _coresight_trace_id_get_cpu_id(cpu, &id_map_default);
>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
>   
> +int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +	return _coresight_trace_id_get_cpu_id(cpu, id_map);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id_map);
> +
>   void coresight_trace_id_put_cpu_id(int cpu)
>   {
> -	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
> +	_coresight_trace_id_put_cpu_id(cpu, &id_map_default);
>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
>   
> +void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +	_coresight_trace_id_put_cpu_id(cpu, id_map);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id_map);
> +
>   int coresight_trace_id_read_cpu_id(int cpu)
>   {
> -	return _coresight_trace_id_read_cpu_id(cpu);
> +	return _coresight_trace_id_read_cpu_id(cpu, &id_map_default);
>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
>   
> +int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +	return _coresight_trace_id_read_cpu_id(cpu, id_map);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id_map);
> +
>   int coresight_trace_id_get_system_id(void)
>   {
>   	return coresight_trace_id_map_get_system_id(&id_map_default);
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 49438a96fcc6..840babdd0794 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -42,8 +42,6 @@
>   #define IS_VALID_CS_TRACE_ID(id)	\
>   	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
>   
> -/* Allocate and release IDs for a single default trace ID map */
> -
>   /**
>    * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
>    *
> @@ -59,6 +57,12 @@
>    */
>   int coresight_trace_id_get_cpu_id(int cpu);
>   
> +/**
> + * Version of coresight_trace_id_get_cpu_id() that allows the ID map to operate
> + * on to be provided.
> + */
> +int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
> +
>   /**
>    * Release an allocated trace ID associated with the CPU.
>    *
> @@ -72,6 +76,12 @@ int coresight_trace_id_get_cpu_id(int cpu);
>    */
>   void coresight_trace_id_put_cpu_id(int cpu);
>   
> +/**
> + * Version of coresight_trace_id_put_cpu_id() that allows the ID map to operate
> + * on to be provided.
> + */
> +void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
> +
>   /**
>    * Read the current allocated CoreSight Trace ID value for the CPU.
>    *
> @@ -92,6 +102,12 @@ void coresight_trace_id_put_cpu_id(int cpu);
>    */
>   int coresight_trace_id_read_cpu_id(int cpu);
>   
> +/**
> + * Version of coresight_trace_id_read_cpu_id() that allows the ID map to operate
> + * on to be provided.
> + */
> +int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
> +
>   /**
>    * Allocate a CoreSight trace ID for a system component.
>    *

