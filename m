Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9E16F902;
	Tue, 25 Jun 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327632; cv=none; b=Zvd6frk2XAxJJEIuwzWm9H49A5OvISZeUCEtJHB/H5T67yzjs33W2pUhoEGhqR1dVA2VBXVY2c2lkuY1qe4pOktph5RKGU0ILP2i+cX3m6Qu9Zna3utvaarWSi0jh/BgXOnEdhwCmvjFIp/RlYgKXgnqqSpD2IUhHFinCBepu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327632; c=relaxed/simple;
	bh=nEtb+g2Rq7X61OxETKCfKwTOWku4feoQj/E5VaA8RJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Swm1cNThux7GFgvzdgO3qt6jJ4Q1qNN245e91zn62bB+VTB4XsKfkZL4NVjvDy2enhFDNe78yUIw0EsUdIvdcQOU7/sEn9GRB9XqxcisWLc1nG6FkefCR4NW/RglVtoc6++H/Cwef5/ZJrKVl9DMlkGIZLuzreQd+8UIZxDNIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AC0C339;
	Tue, 25 Jun 2024 08:00:48 -0700 (PDT)
Received: from [192.168.4.86] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7758D3F766;
	Tue, 25 Jun 2024 08:00:20 -0700 (PDT)
Message-ID: <36714d76-f978-4dca-8ada-0de902d23a29@arm.com>
Date: Tue, 25 Jun 2024 16:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] coresight: Remove pending trace ID release
 mechanism
Content-Language: en-GB
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 leo.yan@linux.dev, anshuman.khandual@arm.com, jszu@nvidia.com,
 bwicaksono@nvidia.com
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240625133105.671245-1-james.clark@arm.com>
 <20240625133105.671245-16-james.clark@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240625133105.671245-16-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2024 14:30, James Clark wrote:
> Pending the release of IDs was a way of managing concurrent sysfs and
> Perf sessions in a single global ID map. Perf may have finished while
> sysfs hadn't, and Perf shouldn't release the IDs in use by sysfs and
> vice versa.
> 
> Now that Perf uses its own exclusive ID maps, pending release doesn't
> result in any different behavior than just releasing all IDs when the
> last Perf session finishes. As part of the per-sink trace ID change, we
> would have still had to make the pending mechanism work on a per-sink
> basis, due to the overlapping ID allocations, so instead of making that
> more complicated, just remove it.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 11 ++--
>   .../hwtracing/coresight/coresight-trace-id.c  | 62 +++++--------------
>   .../hwtracing/coresight/coresight-trace-id.h  | 31 +++++-----
>   include/linux/coresight.h                     |  6 +-
>   4 files changed, 34 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 7fb55dafb639..17fa29969643 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -232,15 +232,14 @@ static void free_event_data(struct work_struct *work)
>   		if (!(IS_ERR_OR_NULL(*ppath))) {
>   			struct coresight_device *sink = coresight_get_sink(*ppath);
>   
> -			coresight_trace_id_put_cpu_id_map(cpu, &sink->perf_sink_id_map);
> +			/* mark perf event as done for trace id allocator */
> +			coresight_trace_id_perf_stop(&sink->perf_sink_id_map);

See my comment below. It may be a good idea to add/copyt comment here to
explain why we don't "put_cpu_id" anymore.


> +
>   			coresight_release_path(*ppath);
>   		}
>   		*ppath = NULL;
>   	}
>   
> -	/* mark perf event as done for trace id allocator */
> -	coresight_trace_id_perf_stop();
> -
>   	free_percpu(event_data->path);
>   	kfree(event_data);
>   }
> @@ -328,9 +327,6 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   		sink = user_sink = coresight_get_sink_by_id(id);
>   	}
>   
> -	/* tell the trace ID allocator that a perf event is starting up */
> -	coresight_trace_id_perf_start();
> -
>   	/* check if user wants a coresight configuration selected */
>   	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
>   	if (cfg_hash) {
> @@ -411,6 +407,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   			continue;
>   		}
>   
> +		coresight_trace_id_perf_start(&sink->perf_sink_id_map);
>   		*etm_event_cpu_path_ptr(event_data, cpu) = path;
>   	}
>   
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index 8a777c0af6ea..1e70892f5beb 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -18,12 +18,6 @@ static struct coresight_trace_id_map id_map_default = {
>   	.cpu_map = &id_map_default_cpu_ids
>   };
>   
> -/* maintain a record of the pending releases per cpu */
> -static cpumask_t cpu_id_release_pending;
> -
> -/* perf session active counter */
> -static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
> -
>   /* lock to protect id_map and cpu data  */
>   static DEFINE_SPINLOCK(id_map_lock);
>   
> @@ -122,34 +116,18 @@ static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_ma
>   	clear_bit(id, id_map->used_ids);
>   }
>   
> -static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
> -{
> -	if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
> -		return;
> -	set_bit(id, id_map->pend_rel_ids);
> -}
> -
>   /*
> - * release all pending IDs for all current maps & clear CPU associations
> - *
> - * This currently operates on the default id map, but may be extended to
> - * operate on all registered id maps if per sink id maps are used.
> + * Release all IDs and clear CPU associations.
>    */
> -static void coresight_trace_id_release_all_pending(void)
> +static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map)
>   {
> -	struct coresight_trace_id_map *id_map = &id_map_default;
>   	unsigned long flags;
> -	int cpu, bit;
> +	int cpu;
>   
>   	spin_lock_irqsave(&id_map_lock, flags);
> -	for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
> -		clear_bit(bit, id_map->used_ids);
> -		clear_bit(bit, id_map->pend_rel_ids);
> -	}
> -	for_each_cpu(cpu, &cpu_id_release_pending) {
> -		atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
> -		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
> -	}
> +	bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
> +	for_each_possible_cpu(cpu)
> +		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
>   	spin_unlock_irqrestore(&id_map_lock, flags);
>   	DUMP_ID_MAP(id_map);
>   }
> @@ -164,7 +142,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>   	/* check for existing allocation for this CPU */
>   	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
>   	if (id)
> -		goto get_cpu_id_clr_pend;
> +		goto get_cpu_id_out_unlock;
>   
>   	/*
>   	 * Find a new ID.
> @@ -185,11 +163,6 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>   	/* allocate the new id to the cpu */
>   	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
>   
> -get_cpu_id_clr_pend:
> -	/* we are (re)using this ID - so ensure it is not marked for release */
> -	cpumask_clear_cpu(cpu, &cpu_id_release_pending);
> -	clear_bit(id, id_map->pend_rel_ids);
> -
>   get_cpu_id_out_unlock:
>   	spin_unlock_irqrestore(&id_map_lock, flags);
>   
> @@ -210,15 +183,8 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
>   
>   	spin_lock_irqsave(&id_map_lock, flags);
>   
> -	if (atomic_read(&perf_cs_etm_session_active)) {
> -		/* set release at pending if perf still active */
> -		coresight_trace_id_set_pend_rel(id, id_map);
> -		cpumask_set_cpu(cpu, &cpu_id_release_pending);
> -	} else {
> -		/* otherwise clear id */
> -		coresight_trace_id_free(id, id_map);
> -		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
> -	}
> +	coresight_trace_id_free(id, id_map);
> +	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
>   
>   	spin_unlock_irqrestore(&id_map_lock, flags);
>   	DUMP_ID_CPU(cpu, id);
> @@ -302,17 +268,17 @@ void coresight_trace_id_put_system_id(int id)
>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
>   
> -void coresight_trace_id_perf_start(void)
> +void coresight_trace_id_perf_start(struct coresight_trace_id_map *id_map)
>   {
> -	atomic_inc(&perf_cs_etm_session_active);
> +	atomic_inc(&id_map->perf_cs_etm_session_active);
>   	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
>   
> -void coresight_trace_id_perf_stop(void)
> +void coresight_trace_id_perf_stop(struct coresight_trace_id_map *id_map)
>   {
> -	if (!atomic_dec_return(&perf_cs_etm_session_active))
> -		coresight_trace_id_release_all_pending();
> +	if (!atomic_dec_return(&id_map->perf_cs_etm_session_active))
> +		coresight_trace_id_release_all(id_map);
>   	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));

minor nit: The global variable perf_cs_etm_session_active is no longer 
needed and must be updated to use the id_map variant. Same as above.


>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 840babdd0794..9aae50a553ca 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -17,9 +17,10 @@
>    * released when done.
>    *
>    * In order to ensure that a consistent cpu / ID matching is maintained
> - * throughout a perf cs_etm event session - a session in progress flag will
> - * be maintained, and released IDs not cleared until the perf session is
> - * complete. This allows the same CPU to be re-allocated its prior ID.
> + * throughout a perf cs_etm event session - a session in progress flag will be
> + * maintained for each sink, and IDs are cleared when all the perf sessions
> + * complete. This allows the same CPU to be re-allocated its prior ID when
> + * events are scheduled in and out.
>    *
>    *
>    * Trace ID maps will be created and initialised to prevent architecturally
> @@ -66,11 +67,7 @@ int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id
>   /**
>    * Release an allocated trace ID associated with the CPU.
>    *
> - * This will release the CoreSight trace ID associated with the CPU,
> - * unless a perf session is in operation.
> - *
> - * If a perf session is in operation then the ID will be marked as pending
> - * release.
> + * This will release the CoreSight trace ID associated with the CPU.
>    *
>    * @cpu: The CPU index to release the associated trace ID.
>    */
> @@ -133,21 +130,21 @@ void coresight_trace_id_put_system_id(int id);
>   /**
>    * Notify the Trace ID allocator that a perf session is starting.
>    *
> - * Increase the perf session reference count - called by perf when setting up
> - * a trace event.
> + * Increase the perf session reference count - called by perf when setting up a
> + * trace event.
>    *
> - * This reference count is used by the ID allocator to ensure that trace IDs
> - * associated with a CPU cannot change or be released during a perf session.
> + * Perf sessions never free trace IDs to ensure that the ID associated with a
> + * CPU cannot change during their and other's concurrent sessions. Instead,
> + * this refcount is used so that the last event to finish always frees all IDs.

minor nit: I think it better to keep/copy the above comment to the 
etm_event_stop where we don't do "put_trace_id"

Suzuki


