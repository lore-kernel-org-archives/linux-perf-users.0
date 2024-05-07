Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6814EC77;
	Tue,  7 May 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079161; cv=none; b=Yn4/374Fs3nirpy7618F+dioGGNUdV3VK/PzbG5wipmJoCkQ6dqkR5D6gW5ixGLawRnce9gbhEYIeqJ4JPj5qWImTNIq+P7Zodqn9Qt+ZHY1GopfD4BJ04eJOAULUiTPGAQZGidHTKtcvuqC14nsN3OBI7JO2RWYneSp5vnTbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079161; c=relaxed/simple;
	bh=XL3ufL40J2O1QuQ7klcMbNbpYpQn7hiXcBzFLETGSEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rF+czUn83b6iVxx2hQsAx2OJDelwkWBdBBF6eZu/yZO6+k+qEyk9yeGuRBxXu9c2ZO4VjqwZBQTQrYS6DEhMc7Er1lS0WxxFoy5SuEdyxNZLxtFmNSmYEMjzXrLOeNBzPMALJ4uFqGja76qdnGsCGliVjdCxwHpX9NQ1c6omQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F461063;
	Tue,  7 May 2024 03:53:04 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD45C3F587;
	Tue,  7 May 2024 03:52:35 -0700 (PDT)
Message-ID: <3923dc07-c037-452a-9e77-d407703876cd@arm.com>
Date: Tue, 7 May 2024 11:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] coresight: Use per-sink trace ID maps for Perf
 sessions
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, mike.leach@linaro.org
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
 <20240429152207.479221-16-james.clark@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240429152207.479221-16-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 16:22, James Clark wrote:
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.
> 
> Each sink owns its own trace ID map, and any Perf session connecting to
> that sink will allocate from it, even if the sink is currently in use by
> other users. This is similar to the existing behavior where the dynamic
> trace IDs are constant as long as there is any concurrent Perf session
> active. It's not completely optimal because slightly more IDs will be
> used than necessary, but the optimal solution involves tracking the PIDs
> of each session and allocating ID maps based on the session owner. This
> is difficult to do with the combination of per-thread and per-cpu modes
> and some scheduling issues. The complexity of this isn't likely to worth
> it because even with multiple users they'd just see a difference in the
> ordering of ID allocations rather than hitting any limits (unless the
> hardware does have too many ETMs connected to one sink).
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c     | 10 ++++++++++
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 15 ++++++++-------
>   include/linux/coresight.h                        |  1 +
>   3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 9fc6f6b863e0..d1adff467670 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -902,6 +902,7 @@ static void coresight_device_release(struct device *dev)
>   	struct coresight_device *csdev = to_coresight_device(dev);
>   
>   	fwnode_handle_put(csdev->dev.fwnode);
> +	free_percpu(csdev->perf_id_map.cpu_map);
>   	kfree(csdev);
>   }
>   
> @@ -1159,6 +1160,14 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>   	dev_set_name(&csdev->dev, "%s", desc->name);
>   
> +	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> +	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> +		csdev->perf_id_map.cpu_map = alloc_percpu(atomic_t);
> +		if (!csdev->perf_id_map.cpu_map) {
> +			ret = -ENOMEM;
> +			goto err_out;
> +		}
> +	}
>   	/*
>   	 * Make sure the device registration and the connection fixup
>   	 * are synchronised, so that we don't see uninitialised devices
> @@ -1216,6 +1225,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   err_out:
>   	/* Cleanup the connection information */
>   	coresight_release_platform_data(NULL, desc->dev, desc->pdata);
> +	kfree(csdev);
>   	return ERR_PTR(ret);
>   }
>   EXPORT_SYMBOL_GPL(coresight_register);
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 177cecae38d9..86ca1a9d09a7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -229,10 +229,13 @@ static void free_event_data(struct work_struct *work)
>   		struct list_head **ppath;
>   
>   		ppath = etm_event_cpu_path_ptr(event_data, cpu);
> -		if (!(IS_ERR_OR_NULL(*ppath)))
> +		if (!(IS_ERR_OR_NULL(*ppath))) {
> +			struct coresight_device *sink = coresight_get_sink(*ppath);
> +
> +			coresight_trace_id_put_cpu_id(cpu, &sink->perf_id_map);
>   			coresight_release_path(*ppath);
> +		}
>   		*ppath = NULL;
> -		coresight_trace_id_put_cpu_id(cpu, coresight_trace_id_map_default());
>   	}
>   
>   	/* mark perf event as done for trace id allocator */
> @@ -401,8 +404,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   		}
>   
>   		/* ensure we can allocate a trace ID for this CPU */
> -		trace_id = coresight_trace_id_get_cpu_id(cpu,
> -							 coresight_trace_id_map_default());
> +		trace_id = coresight_trace_id_get_cpu_id(cpu, &sink->perf_id_map);

We could either store the perf_id_map or the traceid itself in the 
event_data isn't it ? Rather than passing the idmap to enable_source ?

Suzuki
