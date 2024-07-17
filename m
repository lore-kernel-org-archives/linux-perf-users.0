Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE673181BAB
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228610; cv=none; b=LoE1N1nnI1Sf6KgoZI/NIdv51Ejmeqy7rsRlnjkFYIZR+y7PXyBlqfjZ1qOC6cLeFFuQjXZtDDwQsGRF2x+0GyXewn/TYCudwIq52jug8ZifLWhixOSBP+p8TDMkBrkTDmpcQ0l0jxWGPzk+2nhmuYP/yxshnsrIHCLHdJ7oZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228610; c=relaxed/simple;
	bh=OK6g/lWDwmchpxyqOEbgh8WwxmJvtIX/PBh8+/17zck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip4xlNhhEOsdqVijgX9CLTLQiK1ig4mo7ViMDAzK2s/NFO8qY4Ag+dfRosialA5eqtVdIPfn3F5KX1eFq9KCXRRRxugINn3HbPidkU65GbizLUlJ0sfeNs9zWglPvIqTqGlNy/a0tKHHKMMpuUm5NqvWhccqzRo8KBjCh8IXNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qny24Z8j; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qny24Z8j"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-78aeee1068aso3630577a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721228608; x=1721833408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10gdFFvJv1+iPvT+xYjVbe0xzgeYMSRIMgDwYMfIOcs=;
        b=qny24Z8j5/Dh74oy7cVISXg4CnUXAkKVmSFad4VNhAz5AylO3fz72QDoogbePItucH
         6oLZmt3TBJw8ir921p99+SR1TxdDXlWcPcBEtwxqruMEFE26H33TqI7T6jLbSQrpe3vD
         G9NS3nTFXAAyGu3wLybPZfeHr6JxOfIOQ/fi3+UNxdEf0WlFs3HSGk6jhGYsGFTJBMlJ
         eUYfthSxVTAl+wz8AJfVYMQc3+Hq/jHZarqjOFBkZN8ZXFW8YLf7VVEysWxl2ObwhL3R
         /rNs4DrgjnytG4iLb7QF9YZk3e5I79OSUP/jg7fczlx9zlh+Xk1H9A2LkBISpEKa0hZw
         dmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228608; x=1721833408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10gdFFvJv1+iPvT+xYjVbe0xzgeYMSRIMgDwYMfIOcs=;
        b=FONExtL4oX20M1mzZX/ltkf5h7X5mVIoLy6RbJ1gB4zol3vpkxWvto94VJHFsJEeKA
         +YmD816Hf/aEEcDoGRPZpZRA0db62lYAxTpf23MjpRovDtZsomSGDlCH0olJGQeV0gsy
         K9IAP/0rGu0dcEbu3Z5LyHYcwOOho04O8nccbIKv35GpQHYkPDS+3D5NQjFO/0FXqE4Z
         Wtp39TqZrSrV9cxH2rXJ3wOfSz/OeqYZJ30NUsYUB7dcAdKrNAC3yLTtAXHZGeIv8hmj
         ckV9fNpYQ5c7BK2aFzHQHvhTIGG+/orOs55fn+gNBahtKBgYq8qG0OorR0LN1ilHXB5I
         1zHg==
X-Forwarded-Encrypted: i=1; AJvYcCVwAdOVq+sVJp2o/RlVvAW6Vnd5y/vUCTjagypifVRKjoDt79OYuFL/ciyiltkSFSMtn7XTxYCpFZSYCYzSAvFQC3tewZt9U3xgHu9GA/UtWA==
X-Gm-Message-State: AOJu0YyKeeXzxhJnSuiK2cksdl4jXpEeJBNA7ep+qm8kNm5dngUR8iXf
	iKOGn5aGvyveeOzl9yV4lCaIDpDzaK5twued9sqFxoQz8f3VKFZ+rNS0Z5zBvMEmesk9QV5wSLb
	7u5J3p5ipT0Gg/5nAdznr56rIdKX/z/xLeOrBbiPieWL0WFb6
X-Google-Smtp-Source: AGHT+IEejgs1nHZZEUVKuRT4OqPhcasDNwG7eWkBaIZiRpvgt+WEoYJIPSty2XnbpXqIZ5TozWF3quDi8DLQcb4bDY0=
X-Received: by 2002:a17:90b:803:b0:2c9:7a8d:43f7 with SMTP id
 98e67ed59e1d1-2cb527b83abmr1484253a91.23.1721228608148; Wed, 17 Jul 2024
 08:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-14-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-14-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 17 Jul 2024 16:03:16 +0100
Message-ID: <CAJ9a7Vg-L+Csx15G_sNci3koMhZY6g95_pAiFgormmdbvWw9hQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] coresight: Make CPU id map a property of a trace
 ID map
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 11:23, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> The global CPU ID mappings won't work for per-sink ID maps so move it to
> the ID map struct. coresight_trace_id_release_all_pending() is hard
> coded to operate on the default map, but once Perf sessions use their
> own maps the pending release mechanism will be deleted. So it doesn't
> need to be extended to accept a trace ID map argument at this point.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-trace-id.c | 16 +++++++++-------
>  include/linux/coresight.h                        |  1 +
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index 5561989a03fa..8a777c0af6ea 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -13,10 +13,12 @@
>  #include "coresight-trace-id.h"
>
>  /* Default trace ID map. Used in sysfs mode and for system sources */
> -static struct coresight_trace_id_map id_map_default;
> +static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
> +static struct coresight_trace_id_map id_map_default = {
> +       .cpu_map = &id_map_default_cpu_ids
> +};
>
> -/* maintain a record of the mapping of IDs and pending releases per cpu */
> -static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);
> +/* maintain a record of the pending releases per cpu */
>  static cpumask_t cpu_id_release_pending;
>
>  /* perf session active counter */
> @@ -49,7 +51,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
>  /* unlocked read of current trace ID value for given CPU */
>  static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
> -       return atomic_read(&per_cpu(cpu_id, cpu));
> +       return atomic_read(per_cpu_ptr(id_map->cpu_map, cpu));
>  }
>
>  /* look for next available odd ID, return 0 if none found */
> @@ -145,7 +147,7 @@ static void coresight_trace_id_release_all_pending(void)
>                 clear_bit(bit, id_map->pend_rel_ids);
>         }
>         for_each_cpu(cpu, &cpu_id_release_pending) {
> -               atomic_set(&per_cpu(cpu_id, cpu), 0);
> +               atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
>                 cpumask_clear_cpu(cpu, &cpu_id_release_pending);
>         }
>         spin_unlock_irqrestore(&id_map_lock, flags);
> @@ -181,7 +183,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>                 goto get_cpu_id_out_unlock;
>
>         /* allocate the new id to the cpu */
> -       atomic_set(&per_cpu(cpu_id, cpu), id);
> +       atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
>
>  get_cpu_id_clr_pend:
>         /* we are (re)using this ID - so ensure it is not marked for release */
> @@ -215,7 +217,7 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
>         } else {
>                 /* otherwise clear id */
>                 coresight_trace_id_free(id, id_map);
> -               atomic_set(&per_cpu(cpu_id, cpu), 0);
> +               atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
>         }
>
>         spin_unlock_irqrestore(&id_map_lock, flags);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index c16c61a8411d..7d62b88bfb5c 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -234,6 +234,7 @@ struct coresight_sysfs_link {
>  struct coresight_trace_id_map {
>         DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
>         DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> +       atomic_t __percpu *cpu_map;
>  };
>
>  /**
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
