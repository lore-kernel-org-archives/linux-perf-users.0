Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F1139580;
	Mon, 10 Jun 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033269; cv=none; b=c8ihT0hFCWIxdVT9BEcHS4OanFRZDWbN8MRVrCqJSoy1Kmh/1i1chLqMt/0xEprnsZ6Sp1jDBPxgCIkJdgXkjULmhVrVOt2AbVbuOPYFXCoQkInHb4VAVsyQ4iGTSR518arDgezHbuUPdDSgByoI3SujsN83I3FVNr7AVi0s5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033269; c=relaxed/simple;
	bh=h8hMUgKb5MjoZLOZI4M6SkmcgfbPjGOkBzTRSqRzFvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO/qF2t/COtlQauMeXY8K/L6ufqVG6DQPwNp+w06vBr0ui7ruKnXd8hk2knQonvnWAaVId9ElObWQSpdibgnn+zoOcv+uahKomQFrVB2Qpwr0KDmlFsSrTmDI1QFgfSNOIZ0N08ddipxsUZJCyOPPSC/sWsn8a9H+8t+Z3GBpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E136111FB;
	Mon, 10 Jun 2024 08:28:09 -0700 (PDT)
Received: from [10.57.42.97] (unknown [10.57.42.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0673F64C;
	Mon, 10 Jun 2024 08:27:40 -0700 (PDT)
Message-ID: <78a67d94-a649-4a4c-bb48-80b81d7eeb2a@arm.com>
Date: Mon, 10 Jun 2024 16:27:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] coresight: Remove pending trace ID release
 mechanism
To: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
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
 <20240604143030.519906-15-james.clark@arm.com>
 <4165a188-8c78-4675-8557-844b5d270f3d@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <4165a188-8c78-4675-8557-844b5d270f3d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/06/2024 14:43, Suzuki K Poulose wrote:
> On 04/06/2024 15:30, James Clark wrote:
>> Pending the release of IDs was a way of managing concurrent sysfs and
>> Perf sessions in a single global ID map. Perf may have finished while
>> sysfs hadn't, and Perf shouldn't release the IDs in use by sysfs and
>> vice versa.
>>
>> Now that Perf uses its own exclusive ID maps, pending release doesn't
>> result in any different behavior than just releasing all IDs when the
>> last Perf session finishes. As part of the per-sink trace ID change, we
>> would have still had to make the pending mechanism work on a per-sink
>> basis, due to the overlapping ID allocations, so instead of making that
>> more complicated, just remove it.
> 
> minor nit: Given that we drastically changed the meaing of the
> perf_session_start/stop calls to, grab a refcount on idmap, drop
> refcount, should we rename those helpers as such :
> 
> coresight_trace_id_map_get() / _put() ?
> 
> 

I don't mind keeping it as coresight_trace_id_perf_start() because it's
not used in the global map and I can't see it being used for sysfs in
the future either. It's something quite specific to Perf so it's more
self documenting this way.

>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   .../hwtracing/coresight/coresight-etm-perf.c  | 11 ++--
>>   .../hwtracing/coresight/coresight-trace-id.c  | 62 +++++--------------
>>   .../hwtracing/coresight/coresight-trace-id.h  | 31 +++++-----
>>   include/linux/coresight.h                     |  6 +-
>>   4 files changed, 34 insertions(+), 76 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 7fb55dafb639..17cafa1a7f18 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -232,15 +232,14 @@ static void free_event_data(struct work_struct
>> *work)
>>           if (!(IS_ERR_OR_NULL(*ppath))) {
>>               struct coresight_device *sink = coresight_get_sink(*ppath);
>>   -            coresight_trace_id_put_cpu_id_map(cpu,
>> &sink->perf_sink_id_map);
>> +            /* mark perf event as done for trace id allocator */
>> +            coresight_trace_id_perf_stop(&sink->perf_sink_id_map);
>> +
>>               coresight_release_path(*ppath);
>>           }
>>           *ppath = NULL;
>>       }
>>   -    /* mark perf event as done for trace id allocator */
>> -    coresight_trace_id_perf_stop();
>> -
>>       free_percpu(event_data->path);
>>       kfree(event_data);
>>   }
>> @@ -328,9 +327,6 @@ static void *etm_setup_aux(struct perf_event
>> *event, void **pages,
>>           sink = user_sink = coresight_get_sink_by_id(id);
>>       }
>>   -    /* tell the trace ID allocator that a perf event is starting up */
>> -    coresight_trace_id_perf_start();
>> -
>>       /* check if user wants a coresight configuration selected */
>>       cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >>
>> 32);
>>       if (cfg_hash) {
>> @@ -404,6 +400,7 @@ static void *etm_setup_aux(struct perf_event
>> *event, void **pages,
>>           }
>>             /* ensure we can allocate a trace ID for this CPU */
>> +        coresight_trace_id_perf_start(&sink->perf_sink_id_map);
>>           trace_id = coresight_trace_id_get_cpu_id_map(cpu,
>> &sink->perf_sink_id_map);
>>           if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>>               cpumask_clear_cpu(cpu, mask);
> 
> I think we are leaking a reference above, if the allocation of trace id
> fails. i.e., we don't drop the refcount here, nor we do that in
> free_event_dat() since the ppath is set to NULL in case of failure ?
> 
> 

Nice catch. I'll move the perf_start() call to where path is assigned
because that's what guards the perf_stop() call in free_event_data().
Rather than add an extra perf_stop() call.

> 
>> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c
>> b/drivers/hwtracing/coresight/coresight-trace-id.c
>> index 8a777c0af6ea..acb99ccf96b5 100644
>> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
>> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
>> @@ -18,12 +18,6 @@ static struct coresight_trace_id_map id_map_default
>> = {
>>       .cpu_map = &id_map_default_cpu_ids
>>   };
>>   -/* maintain a record of the pending releases per cpu */
>> -static cpumask_t cpu_id_release_pending;
>> -
>> -/* perf session active counter */
>> -static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
>> -
>>   /* lock to protect id_map and cpu data  */
>>   static DEFINE_SPINLOCK(id_map_lock);
>>   @@ -122,34 +116,18 @@ static void coresight_trace_id_free(int id,
>> struct coresight_trace_id_map *id_ma
>>       clear_bit(id, id_map->used_ids);
>>   }
>>   -static void coresight_trace_id_set_pend_rel(int id, struct
>> coresight_trace_id_map *id_map)
>> -{
>> -    if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
>> -        return;
>> -    set_bit(id, id_map->pend_rel_ids);
>> -}
>> -
>>   /*
>> - * release all pending IDs for all current maps & clear CPU associations
>> - *
>> - * This currently operates on the default id map, but may be extended to
>> - * operate on all registered id maps if per sink id maps are used.
>> + * release all IDs and clear CPU associations
> 
> minor nit:
> 
>     * Release all IDs and clear CPU associations.
> 

Done

>>    */
>> -static void coresight_trace_id_release_all_pending(void)
>> +static void coresight_trace_id_release_all(struct
>> coresight_trace_id_map *id_map)
>>   {
>> -    struct coresight_trace_id_map *id_map = &id_map_default;
>>       unsigned long flags;
>> -    int cpu, bit;
>> +    int cpu;
>>         spin_lock_irqsave(&id_map_lock, flags);
>> -    for_each_set_bit(bit, id_map->pend_rel_ids,
>> CORESIGHT_TRACE_ID_RES_TOP) {
>> -        clear_bit(bit, id_map->used_ids);
>> -        clear_bit(bit, id_map->pend_rel_ids);
>> -    }
>> -    for_each_cpu(cpu, &cpu_id_release_pending) {
>> -        atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
>> -        cpumask_clear_cpu(cpu, &cpu_id_release_pending);
>> -    }
>> +    bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
>> +    for_each_possible_cpu(cpu)
>> +        atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
> 
> Do we ever read these values without spinlock ? Do they need to be atomic ?
> 

Yeah they're still read in a few places without taking the lock.
Specifically because reading and checking if it's valid is so easy to do
without locking.

>>       spin_unlock_irqrestore(&id_map_lock, flags);
>>       DUMP_ID_MAP(id_map);
>>   }
>> @@ -164,7 +142,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu,
>> struct coresight_trace_id_map
>>       /* check for existing allocation for this CPU */
>>       id = _coresight_trace_id_read_cpu_id(cpu, id_map);
>>       if (id)
>> -        goto get_cpu_id_clr_pend;
>> +        goto get_cpu_id_out_unlock;
>>         /*
>>        * Find a new ID.
>> @@ -185,11 +163,6 @@ static int _coresight_trace_id_get_cpu_id(int
>> cpu, struct coresight_trace_id_map
>>       /* allocate the new id to the cpu */
>>       atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
>>   -get_cpu_id_clr_pend:
>> -    /* we are (re)using this ID - so ensure it is not marked for
>> release */
>> -    cpumask_clear_cpu(cpu, &cpu_id_release_pending);
>> -    clear_bit(id, id_map->pend_rel_ids);
>> -
>>   get_cpu_id_out_unlock:
>>       spin_unlock_irqrestore(&id_map_lock, flags);
>>   @@ -210,15 +183,8 @@ static void _coresight_trace_id_put_cpu_id(int
>> cpu, struct coresight_trace_id_ma
>>         spin_lock_irqsave(&id_map_lock, flags);
>>   -    if (atomic_read(&perf_cs_etm_session_active)) {
>> -        /* set release at pending if perf still active */
>> -        coresight_trace_id_set_pend_rel(id, id_map);
>> -        cpumask_set_cpu(cpu, &cpu_id_release_pending);
>> -    } else {
>> -        /* otherwise clear id */
>> -        coresight_trace_id_free(id, id_map);
>> -        atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
>> -    }
>> +    coresight_trace_id_free(id, id_map);
>> +    atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
> 
> Can we do this unconditionally now ? What is another session has
> reserved this id for the same CPU and that gets scheduled later ?
> We should simply stop doing the "put_cpu_id()" and instead rely
> on the perf_session_stop()/(or the suggested trace_id_map_put())
> to free the ids and clear everything.
> 

We do do it unconditionally, the Perf code doesn't call put() anymore.
Only sysfs does but it still needs to because it uses the global map so
this function can't be dropped completely.

>>         spin_unlock_irqrestore(&id_map_lock, flags);
>>       DUMP_ID_CPU(cpu, id);
>> @@ -302,17 +268,17 @@ void coresight_trace_id_put_system_id(int id)
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
>>   -void coresight_trace_id_perf_start(void)
>> +void coresight_trace_id_perf_start(struct coresight_trace_id_map
>> *id_map)
>>   {
>> -    atomic_inc(&perf_cs_etm_session_active);
>> +    atomic_inc(&id_map->perf_cs_etm_session_active);
>>       PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
>>   -void coresight_trace_id_perf_stop(void)
>> +void coresight_trace_id_perf_stop(struct coresight_trace_id_map *id_map)
>>   {
>> -    if (!atomic_dec_return(&perf_cs_etm_session_active))
>> -        coresight_trace_id_release_all_pending();
>> +    if (!atomic_dec_return(&id_map->perf_cs_etm_session_active))
>> +        coresight_trace_id_release_all(id_map);
>>       PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
>> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h
>> b/drivers/hwtracing/coresight/coresight-trace-id.h
>> index 840babdd0794..9aae50a553ca 100644
>> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
>> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
>> @@ -17,9 +17,10 @@
>>    * released when done.
>>    *
>>    * In order to ensure that a consistent cpu / ID matching is maintained
>> - * throughout a perf cs_etm event session - a session in progress
>> flag will
>> - * be maintained, and released IDs not cleared until the perf session is
>> - * complete. This allows the same CPU to be re-allocated its prior ID.
>> + * throughout a perf cs_etm event session - a session in progress
>> flag will be
>> + * maintained for each sink, and IDs are cleared when all the perf
>> sessions
>> + * complete. This allows the same CPU to be re-allocated its prior ID
>> when
>> + * events are scheduled in and out.
>>    *
>>    *
>>    * Trace ID maps will be created and initialised to prevent
>> architecturally
>> @@ -66,11 +67,7 @@ int coresight_trace_id_get_cpu_id_map(int cpu,
>> struct coresight_trace_id_map *id
>>   /**
>>    * Release an allocated trace ID associated with the CPU.
>>    *
>> - * This will release the CoreSight trace ID associated with the CPU,
>> - * unless a perf session is in operation.
>> - *
>> - * If a perf session is in operation then the ID will be marked as
>> pending
>> - * release.
>> + * This will release the CoreSight trace ID associated with the CPU.
>>    *
>>    * @cpu: The CPU index to release the associated trace ID.
>>    */
>> @@ -133,21 +130,21 @@ void coresight_trace_id_put_system_id(int id);
>>   /**
>>    * Notify the Trace ID allocator that a perf session is starting.
>>    *
>> - * Increase the perf session reference count - called by perf when
>> setting up
>> - * a trace event.
>> + * Increase the perf session reference count - called by perf when
>> setting up a
>> + * trace event.
>>    *
>> - * This reference count is used by the ID allocator to ensure that
>> trace IDs
>> - * associated with a CPU cannot change or be released during a perf
>> session.
>> + * Perf sessions never free trace IDs to ensure that the ID
>> associated with a
>> + * CPU cannot change during their and other's concurrent sessions.
>> Instead,
>> + * this refcount is used so that the last event to finish always
>> frees all IDs.
>>    */
>> -void coresight_trace_id_perf_start(void);
>> +void coresight_trace_id_perf_start(struct coresight_trace_id_map
>> *id_map);
>>     /**
>>    * Notify the ID allocator that a perf session is stopping.
>>    *
>> - * Decrease the perf session reference count.
>> - * if this causes the count to go to zero, then all Trace IDs marked
>> as pending
>> - * release, will be released.
>> + * Decrease the perf session reference count. If this causes the
>> count to go to
>> + * zero, then all Trace IDs will be released.
>>    */
>> -void coresight_trace_id_perf_stop(void);
>> +void coresight_trace_id_perf_stop(struct coresight_trace_id_map
>> *id_map);
>>     #endif /* _CORESIGHT_TRACE_ID_H */
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 9c3067e2e38b..197949fd2c35 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -227,14 +227,12 @@ struct coresight_sysfs_link {
>>    * @used_ids:    Bitmap to register available (bit = 0) and in use
>> (bit = 1) IDs.
>>    *        Initialised so that the reserved IDs are permanently
>> marked as
>>    *        in use.
>> - * @pend_rel_ids: CPU IDs that have been released by the trace source
>> but not
>> - *          yet marked as available, to allow re-allocation to the same
>> - *          CPU during a perf session.
>> + * @perf_cs_etm_session_active: Number of Perf sessions using this ID
>> map.
>>    */
>>   struct coresight_trace_id_map {
>>       DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
>> -    DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
>>       atomic_t __percpu *cpu_map;
>> +    atomic_t perf_cs_etm_session_active;
> 
> minor nit: this could simply be :
>     atomic_t map_refcnt;
> 
> i.e., number of references to the trace_id map ?
> 
> Suzuki

As I mentioned above I think it's clearer to keep this labelled with
Perf as long is it's still only used for Perf. I'd agree to rename it at
the point when it is a more generic refcnt though. Not sure what you think?

James

