Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F91922F2;
	Fri,  7 Jun 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767625; cv=none; b=VmIOXIDa54mNA0Xl/vIYlAEsdaqXJ3tzeLQsuTkbU/5b8DW+3QK+6Wi3d12UeJkD6PB+ZD4tU/3ySE5cTswUucYGji8Hxn+49u2AKNQVQgGGVo3ER2oJRLKVjA72KQATugZChPLuw2b/3NU8WIIy7GzWA/MYd/STROW5ZlCfVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767625; c=relaxed/simple;
	bh=obSgizG1NDDfvuV+r6uo0LV0gIsPk3Y+l9rFm405wzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcbesUDBZIgueRjJWEdNI+wYiGcJoro4aXDDzwhl/520rzegy83ckIawqE40m2gAdKr3ALkzR7OLXizR11mnyDxF5L2vasRpBo8Ps1p6ZacgT7CUYmh4vLYU57ifHxosa0w02ViLs4fqzveEzXp4ppuM8Vk06ywxZGEejvt60sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC130153B;
	Fri,  7 Jun 2024 06:40:46 -0700 (PDT)
Received: from [10.57.5.199] (unknown [10.57.5.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4663F792;
	Fri,  7 Jun 2024 06:40:18 -0700 (PDT)
Message-ID: <89337894-91b6-4c67-a5a9-7cfc5b902f76@arm.com>
Date: Fri, 7 Jun 2024 14:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] coresight: Use per-sink trace ID maps for Perf
 sessions
To: Suzuki K Poulose <suzuki.poulose@arm.com>
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
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com,
 mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com
References: <20240604143030.519906-1-james.clark@arm.com>
 <20240604143030.519906-14-james.clark@arm.com>
 <b236da36-0730-4284-98df-581d47bc612e@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <b236da36-0730-4284-98df-581d47bc612e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/06/2024 14:18, Suzuki K Poulose wrote:
> Hi James
> 
> On 04/06/2024 15:30, James Clark wrote:
>> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
>> as long as there are fewer than that many ETMs connected to each sink.
>>
>> Each sink owns its own trace ID map, and any Perf session connecting to
>> that sink will allocate from it, even if the sink is currently in use by
>> other users. This is similar to the existing behavior where the dynamic
>> trace IDs are constant as long as there is any concurrent Perf session
>> active. It's not completely optimal because slightly more IDs will be
>> used than necessary, but the optimal solution involves tracking the PIDs
>> of each session and allocating ID maps based on the session owner. This
>> is difficult to do with the combination of per-thread and per-cpu modes
>> and some scheduling issues. The complexity of this isn't likely to worth
>> it because even with multiple users they'd just see a difference in the
>> ordering of ID allocations rather than hitting any limits (unless the
>> hardware does have too many ETMs connected to one sink).
> 
> Please find my comments below.
> 
> 
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c      | 10 ++++++++++
>>   drivers/hwtracing/coresight/coresight-dummy.c     |  3 ++-
>>   drivers/hwtracing/coresight/coresight-etm-perf.c  | 15 ++++++++++-----
>>   .../hwtracing/coresight/coresight-etm3x-core.c    |  9 +++++----
>>   .../hwtracing/coresight/coresight-etm4x-core.c    |  9 +++++----
>>   drivers/hwtracing/coresight/coresight-stm.c       |  3 ++-
>>   drivers/hwtracing/coresight/coresight-sysfs.c     |  3 ++-
>>   drivers/hwtracing/coresight/coresight-tpdm.c      |  3 ++-
>>   include/linux/coresight.h                         |  3 ++-
>>   9 files changed, 40 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 9fc6f6b863e0..d5aaeafe5c7d 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -902,6 +902,7 @@ static void coresight_device_release(struct device
>> *dev)
>>       struct coresight_device *csdev = to_coresight_device(dev);
>>         fwnode_handle_put(csdev->dev.fwnode);
>> +    free_percpu(csdev->perf_sink_id_map.cpu_map);
>>       kfree(csdev);
>>   }
>>   @@ -1159,6 +1160,14 @@ struct coresight_device
>> *coresight_register(struct coresight_desc *desc)
>>       csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>>       dev_set_name(&csdev->dev, "%s", desc->name);
>>   +    if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>> +        csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
>> +        csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
>> +        if (!csdev->perf_sink_id_map.cpu_map) {
>> +            ret = -ENOMEM;
>> +            goto err_out;
>> +        }
>> +    }
>>       /*
>>        * Make sure the device registration and the connection fixup
>>        * are synchronised, so that we don't see uninitialised devices
>> @@ -1216,6 +1225,7 @@ struct coresight_device
>> *coresight_register(struct coresight_desc *desc)
>>   err_out:
>>       /* Cleanup the connection information */
>>       coresight_release_platform_data(NULL, desc->dev, desc->pdata);
>> +    kfree(csdev);
> 
> This hunk looked suspicious to me and is problematic. If we fail to
> register the device with "device_register()", we already free the
> csdev, via coresight_device_release() triggered via the device_put(),
> (See comments in that case) and we could trigger a double free of the
> csdev with this change.
> 
> I would recommend, you free the "csdev" in the above case, if we fail to
> allocate the percpu storage and fall through.
> 
>>       return ERR_PTR(ret);
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_register);
>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c
>> b/drivers/hwtracing/coresight/coresight-dummy.c
>> index ac70c0b491be..1f1b9ad160f6 100644
>> --- a/drivers/hwtracing/coresight/coresight-dummy.c
>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>> @@ -21,7 +21,8 @@ DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
>>   DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
>>     static int dummy_source_enable(struct coresight_device *csdev,
>> -                   struct perf_event *event, enum cs_mode mode)
>> +                   struct perf_event *event, enum cs_mode mode,
>> +                   __maybe_unused struct coresight_trace_id_map *id_map)
>>   {
>>       dev_dbg(csdev->dev.parent, "Dummy source enabled\n");
>>   diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index c0c60e6a1703..7fb55dafb639 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -229,10 +229,13 @@ static void free_event_data(struct work_struct
>> *work)
>>           struct list_head **ppath;
>>             ppath = etm_event_cpu_path_ptr(event_data, cpu);
>> -        if (!(IS_ERR_OR_NULL(*ppath)))
>> +        if (!(IS_ERR_OR_NULL(*ppath))) {
>> +            struct coresight_device *sink = coresight_get_sink(*ppath);
>> +
>> +            coresight_trace_id_put_cpu_id_map(cpu,
>> &sink->perf_sink_id_map);
>>               coresight_release_path(*ppath);
>> +        }
>>           *ppath = NULL;
>> -        coresight_trace_id_put_cpu_id(cpu);
>>       }
>>         /* mark perf event as done for trace id allocator */
>> @@ -401,7 +404,7 @@ static void *etm_setup_aux(struct perf_event
>> *event, void **pages,
>>           }
>>             /* ensure we can allocate a trace ID for this CPU */
>> -        trace_id = coresight_trace_id_get_cpu_id(cpu);
>> +        trace_id = coresight_trace_id_get_cpu_id_map(cpu,
>> &sink->perf_sink_id_map);
>>           if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>>               cpumask_clear_cpu(cpu, mask);
>>               coresight_release_path(path);
>> @@ -495,7 +498,8 @@ static void etm_event_start(struct perf_event
>> *event, int flags)
>>           goto fail_end_stop;
>>         /* Finally enable the tracer */
>> -    if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>> +    if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF,
>> +                      &sink->perf_sink_id_map))
>>           goto fail_disable_path;
>>         /*
>> @@ -507,7 +511,8 @@ static void etm_event_start(struct perf_event
>> *event, int flags)
>>           hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
>>                      CS_AUX_HW_ID_CURR_VERSION);
>>           hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
>> -                    coresight_trace_id_read_cpu_id(cpu));
>> +                    coresight_trace_id_read_cpu_id_map(cpu,
>> +                                       &sink->perf_sink_id_map));
>>           perf_report_aux_output_id(event, hw_id);
>>       }
>>   diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c
>> b/drivers/hwtracing/coresight/coresight-etm3x-core.c
>> index 9d5c1391ffb1..65cf7456426a 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
>> @@ -481,7 +481,8 @@ void etm_release_trace_id(struct etm_drvdata
>> *drvdata)
>>   }
>>     static int etm_enable_perf(struct coresight_device *csdev,
>> -               struct perf_event *event)
>> +               struct perf_event *event,
>> +               struct coresight_trace_id_map *id_map)
>>   {
>>       struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>       int trace_id;
>> @@ -500,7 +501,7 @@ static int etm_enable_perf(struct coresight_device
>> *csdev,
>>        * with perf locks - we know the ID cannot change until perf
>> shuts down
>>        * the session
>>        */
>> -    trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
>> +    trace_id = coresight_trace_id_read_cpu_id_map(drvdata->cpu, id_map);
>>       if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>>           dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s
>> on CPU%d\n",
>>               dev_name(&drvdata->csdev->dev), drvdata->cpu);
>> @@ -553,7 +554,7 @@ static int etm_enable_sysfs(struct
>> coresight_device *csdev)
>>   }
>>     static int etm_enable(struct coresight_device *csdev, struct
>> perf_event *event,
>> -              enum cs_mode mode)
>> +              enum cs_mode mode, struct coresight_trace_id_map *id_map)
>>   {
>>       int ret;
>>       struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> @@ -568,7 +569,7 @@ static int etm_enable(struct coresight_device
>> *csdev, struct perf_event *event,
>>           ret = etm_enable_sysfs(csdev);
>>           break;
>>       case CS_MODE_PERF:
>> -        ret = etm_enable_perf(csdev, event);
>> +        ret = etm_enable_perf(csdev, event, id_map);
>>           break;
>>       default:
>>           ret = -EINVAL;
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index a0bdfabddbc6..fcd0f9ba562d 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -752,7 +752,8 @@ static int etm4_parse_event_config(struct
>> coresight_device *csdev,
>>   }
>>     static int etm4_enable_perf(struct coresight_device *csdev,
>> -                struct perf_event *event)
>> +                struct perf_event *event,
>> +                struct coresight_trace_id_map *id_map)
>>   {
>>       int ret = 0, trace_id;
>>       struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> @@ -775,7 +776,7 @@ static int etm4_enable_perf(struct
>> coresight_device *csdev,
>>        * with perf locks - we know the ID cannot change until perf
>> shuts down
>>        * the session
>>        */
>> -    trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
>> +    trace_id = coresight_trace_id_read_cpu_id_map(drvdata->cpu, id_map);
>>       if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>>           dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s
>> on CPU%d\n",
>>               dev_name(&drvdata->csdev->dev), drvdata->cpu);
>> @@ -837,7 +838,7 @@ static int etm4_enable_sysfs(struct
>> coresight_device *csdev)
>>   }
>>     static int etm4_enable(struct coresight_device *csdev, struct
>> perf_event *event,
>> -               enum cs_mode mode)
>> +               enum cs_mode mode, struct coresight_trace_id_map *id_map)
>>   {
>>       int ret;
>>   @@ -851,7 +852,7 @@ static int etm4_enable(struct coresight_device
>> *csdev, struct perf_event *event,
>>           ret = etm4_enable_sysfs(csdev);
>>           break;
>>       case CS_MODE_PERF:
>> -        ret = etm4_enable_perf(csdev, event);
>> +        ret = etm4_enable_perf(csdev, event, id_map);
>>           break;
>>       default:
>>           ret = -EINVAL;
>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c
>> b/drivers/hwtracing/coresight/coresight-stm.c
>> index e1c62820dfda..a80ad1de4c23 100644
>> --- a/drivers/hwtracing/coresight/coresight-stm.c
>> +++ b/drivers/hwtracing/coresight/coresight-stm.c
>> @@ -194,7 +194,8 @@ static void stm_enable_hw(struct stm_drvdata
>> *drvdata)
>>   }
>>     static int stm_enable(struct coresight_device *csdev, struct
>> perf_event *event,
>> -              enum cs_mode mode)
>> +              enum cs_mode mode,
>> +              __maybe_unused struct coresight_trace_id_map *trace_id)
>>   {
>>       struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>   diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c
>> b/drivers/hwtracing/coresight/coresight-sysfs.c
>> index 1e67cc7758d7..a01c9e54e2ed 100644
>> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/kernel.h>
>>     #include "coresight-priv.h"
>> +#include "coresight-trace-id.h"
>>     /*
>>    * Use IDR to map the hash of the source's device name
>> @@ -63,7 +64,7 @@ static int coresight_enable_source_sysfs(struct
>> coresight_device *csdev,
>>        */
>>       lockdep_assert_held(&coresight_mutex);
>>       if (coresight_get_mode(csdev) != CS_MODE_SYSFS) {
>> -        ret = source_ops(csdev)->enable(csdev, data, mode);
>> +        ret = source_ops(csdev)->enable(csdev, data, mode, NULL);
>>           if (ret)
>>               return ret;
>>       }
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index a9708ab0d488..0376ad326a2f 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -439,7 +439,8 @@ static void __tpdm_enable(struct tpdm_drvdata
>> *drvdata)
>>   }
>>     static int tpdm_enable(struct coresight_device *csdev, struct
>> perf_event *event,
>> -               enum cs_mode mode)
>> +               enum cs_mode mode,
>> +               __maybe_unused struct coresight_trace_id_map *id_map)
>>   {
>>       struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>   diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 7d62b88bfb5c..9c3067e2e38b 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -290,6 +290,7 @@ struct coresight_device {
>>       bool sysfs_sink_activated;
>>       struct dev_ext_attribute *ea;
>>       struct coresight_device *def_sink;
>> +    struct coresight_trace_id_map perf_sink_id_map;
>>       /* sysfs links between components */
>>       int nr_links;
>>       bool has_conns_grp;
>> @@ -384,7 +385,7 @@ struct coresight_ops_link {
>>   struct coresight_ops_source {
>>       int (*cpu_id)(struct coresight_device *csdev);
>>       int (*enable)(struct coresight_device *csdev, struct perf_event
>> *event,
>> -              enum cs_mode mode);
>> +              enum cs_mode mode, struct coresight_trace_id_map *id_map);
> 
> I am slightly concerned by this change. We already pass down "event" for
> a generic "enable" call back which serves both SYSFS & PERF. Now we are
> adding one more, just for the PERF usage. Ideally, it is possible to
> pass a single argument, e.g. perf_aux_output_handle which can fetch you
> all the required infor for "enable".
> 
>  i.e, hanlde->event, perf_get_aux(handle) -> event_data. We could even
> add a helper to find the trace_id map from the handle, which could hide
> the implementation details from the backend drivers.
> 
> e.g.,
> 
> etm_perf_get_trace_id_map(handle) -> {
>   event_data = perf_get_aux()
>   path = per_cpu(event_data->path)
>   sink = sink_from_path(path)
>   return trace_id of the sink;
> }
> 
> 
> That said, we if we intend to extend the usage of trace_id_map for
> sysfs, this may be fine as is.
> 
> Suzuki

Yeah, that's what I was getting at here [1]. I added it so that sysfs
can use the same argument if we add per-sink IDs for sysfs (which seems
inevitable because of the core count limitation). Adding it to the
perf_event doesn't help for sysfs. And having a common argument will be
more obvious and straightforward than having to dig it out of different
places.

[1]:
https://lore.kernel.org/linux-perf-users/97c57424-6242-4ba1-8b46-6405c084645c@arm.com/

> 
> 
>>       void (*disable)(struct coresight_device *csdev,
>>               struct perf_event *event);
>>   };
> 
