Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CB181BB4
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228619; cv=none; b=P4sS/ezldZAh4pNf4VUNNMGgDfVAJAZq2M6Offq3QEiVNSswnFtGlyo0fPkS029q2tFtymetgY/c0aRwYc40oOvIXkFk+lG6mqAno3xUdFccWNrJoRCjk6oCgdCx8jC6hbzn3Wl5MyHobPLYl0gCxYv1CAte0LXT9mK42xQ0TFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228619; c=relaxed/simple;
	bh=9/txrxmvcZD0hOFDXVug4xU4avWggkx/guB2o+3YzpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO8JRAcZ3gCEF3RNaYQvZdkHwIemKyxahld6YxXLMiUQUdvIlBhBRC5dkG7BlfHR6nIn02DDyXntDLpJl1Q9zzMC/DWsNL20j4kI4Q5P5JKN0vXII1v/Est3mvw9aBlgb0oP7PYaxfSoxGRCEHosVrf8NWLx0bSR08Qa24Lc75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M44AQcym; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M44AQcym"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so4261632b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721228616; x=1721833416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcoK7o2Rnp82wtUESvQoFUIPlNvtP5r+CD4LpyTcl6c=;
        b=M44AQcymApOjmL/ylKZ9JixhxccTdcLH6qusXgpa9ZE+ppvuGsNsUpkM3BWMehAwWQ
         +uxWUdPMN29Ac7uLnxWITF1PZJIZ4uOeqvoPV3FMODZvwyQRHNUTn99I7NuTAv8/UclP
         VvP2QBLZfhk127OHAW/uUrUW181eGYx0AmYiyXOsPvf7Z4OagQIB83asQGIIRUAVwUoD
         bpcZwaG/oQkJmLmABEbLAPFHj+YnnnAwz/eVAF0AoaMkklK4btztnUsBdkgQv8kvuHHE
         hfzFPos+Svn3XFL4eWTginZd9cgZ5p3ACmyz/Qx4xULEM9THOrSquzf8rt8zYUufsNA6
         85hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228616; x=1721833416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcoK7o2Rnp82wtUESvQoFUIPlNvtP5r+CD4LpyTcl6c=;
        b=Hs2FZhHG9FaBzz3COhHI1TEiaphlLbvrdQv/93UxHqhqG5wyZ0FCyuP/JexNqCf7+w
         4sgbTe2LPQjlLBFieyIIxIRiSiYvkNl4fERnSRdmqQrZagTrHwG9rO5kwzoyOP/S/AE9
         nTwveps8daiTDwM3KKJHhT/rBFCmAgHPKHFYmdkSy4WwArrXb210+/aF7vHuMa8MsrEw
         R3YYuGbSMBHDTUVKQuXIDL1LLSsRxa1V91DWfXU1PRtoueb9UDbXEsjjyQEjKIkraJ2W
         kQA+l3TioWE6ibsP2m27qKoLIHc6C6HhUQykYm/bO0QoFFbkNSzk6Xqpzr9GibWpqt8B
         pN0g==
X-Forwarded-Encrypted: i=1; AJvYcCUVNBx+zF0O8B/qSv1QlEAOeYJXDipZR/r36rfWM0tpMusc/xnu51aacWH/mg+w0APHUsEt/+4WxhjoNhCMUxg1+KDYgoCnQ4g8k04Kwv8azQ==
X-Gm-Message-State: AOJu0Yw9PW7GWxFfKI7/vvng/3VN2a6b57HlYMs5P4Si8cutrh9wpTLj
	K4Aeu3GqbeTtlMlsUdcAez2Olv27YX+c9kzX37kn9D8KOIdS1kgZRafpAy32NojwS08N0I/Np/E
	5Qv4b1Z4km67vrCabnesmv6gRP9z5a/jeUwAguA==
X-Google-Smtp-Source: AGHT+IEn4CYlMMrmMtO8qc932JSOdkJ9HWLDn0QtopT8e3V63WWfZI6hWPy//Bcf5GHX6sEXZatG859VztAE1c9JLX4=
X-Received: by 2002:a05:6a00:889:b0:705:9ddb:db6b with SMTP id
 d2e1a72fcca58-70ce4fa4a3bmr2041499b3a.13.1721228615834; Wed, 17 Jul 2024
 08:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-15-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-15-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 17 Jul 2024 16:03:24 +0100
Message-ID: <CAJ9a7VguCUAnLsaGevnyrAk2JJO1eSDBMn7-geiNZi+TaLvgUA@mail.gmail.com>
Subject: Re: [PATCH v5 14/17] coresight: Use per-sink trace ID maps for Perf sessions
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
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-core.c      | 10 ++++++++++
>  drivers/hwtracing/coresight/coresight-dummy.c     |  3 ++-
>  drivers/hwtracing/coresight/coresight-etm-perf.c  | 15 ++++++++++-----
>  .../hwtracing/coresight/coresight-etm3x-core.c    |  9 +++++----
>  .../hwtracing/coresight/coresight-etm4x-core.c    |  9 +++++----
>  drivers/hwtracing/coresight/coresight-stm.c       |  3 ++-
>  drivers/hwtracing/coresight/coresight-sysfs.c     |  3 ++-
>  drivers/hwtracing/coresight/coresight-tpdm.c      |  3 ++-
>  include/linux/coresight.h                         |  3 ++-
>  9 files changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 9fc6f6b863e0..faf560ba8d64 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -902,6 +902,7 @@ static void coresight_device_release(struct device *dev)
>         struct coresight_device *csdev = to_coresight_device(dev);
>
>         fwnode_handle_put(csdev->dev.fwnode);
> +       free_percpu(csdev->perf_sink_id_map.cpu_map);
>         kfree(csdev);
>  }
>
> @@ -1159,6 +1160,15 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>         csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>         dev_set_name(&csdev->dev, "%s", desc->name);
>
> +       if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> +           csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> +               csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
> +               if (!csdev->perf_sink_id_map.cpu_map) {
> +                       kfree(csdev);
> +                       ret = -ENOMEM;
> +                       goto err_out;
> +               }
> +       }
>         /*
>          * Make sure the device registration and the connection fixup
>          * are synchronised, so that we don't see uninitialised devices
> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
> index ac70c0b491be..1f1b9ad160f6 100644
> --- a/drivers/hwtracing/coresight/coresight-dummy.c
> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> @@ -21,7 +21,8 @@ DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
>  DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
>
>  static int dummy_source_enable(struct coresight_device *csdev,
> -                              struct perf_event *event, enum cs_mode mode)
> +                              struct perf_event *event, enum cs_mode mode,
> +                              __maybe_unused struct coresight_trace_id_map *id_map)
>  {
>         dev_dbg(csdev->dev.parent, "Dummy source enabled\n");
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c0c60e6a1703..7fb55dafb639 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -229,10 +229,13 @@ static void free_event_data(struct work_struct *work)
>                 struct list_head **ppath;
>
>                 ppath = etm_event_cpu_path_ptr(event_data, cpu);
> -               if (!(IS_ERR_OR_NULL(*ppath)))
> +               if (!(IS_ERR_OR_NULL(*ppath))) {
> +                       struct coresight_device *sink = coresight_get_sink(*ppath);
> +
> +                       coresight_trace_id_put_cpu_id_map(cpu, &sink->perf_sink_id_map);
>                         coresight_release_path(*ppath);
> +               }
>                 *ppath = NULL;
> -               coresight_trace_id_put_cpu_id(cpu);
>         }
>
>         /* mark perf event as done for trace id allocator */
> @@ -401,7 +404,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>                 }
>
>                 /* ensure we can allocate a trace ID for this CPU */
> -               trace_id = coresight_trace_id_get_cpu_id(cpu);
> +               trace_id = coresight_trace_id_get_cpu_id_map(cpu, &sink->perf_sink_id_map);
>                 if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>                         cpumask_clear_cpu(cpu, mask);
>                         coresight_release_path(path);
> @@ -495,7 +498,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>                 goto fail_end_stop;
>
>         /* Finally enable the tracer */
> -       if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
> +       if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF,
> +                                     &sink->perf_sink_id_map))
>                 goto fail_disable_path;
>
>         /*
> @@ -507,7 +511,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>                 hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
>                                    CS_AUX_HW_ID_CURR_VERSION);
>                 hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
> -                                   coresight_trace_id_read_cpu_id(cpu));
> +                                   coresight_trace_id_read_cpu_id_map(cpu,
> +                                                                      &sink->perf_sink_id_map));
>                 perf_report_aux_output_id(event, hw_id);
>         }
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 8b362605d242..c103f4c70f5d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -481,7 +481,8 @@ void etm_release_trace_id(struct etm_drvdata *drvdata)
>  }
>
>  static int etm_enable_perf(struct coresight_device *csdev,
> -                          struct perf_event *event)
> +                          struct perf_event *event,
> +                          struct coresight_trace_id_map *id_map)
>  {
>         struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>         int trace_id;
> @@ -500,7 +501,7 @@ static int etm_enable_perf(struct coresight_device *csdev,
>          * with perf locks - we know the ID cannot change until perf shuts down
>          * the session
>          */
> -       trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
> +       trace_id = coresight_trace_id_read_cpu_id_map(drvdata->cpu, id_map);
>         if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>                 dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
>                         dev_name(&drvdata->csdev->dev), drvdata->cpu);
> @@ -553,7 +554,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>  }
>
>  static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
> -                     enum cs_mode mode)
> +                     enum cs_mode mode, struct coresight_trace_id_map *id_map)
>  {
>         int ret;
>         struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -568,7 +569,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
>                 ret = etm_enable_sysfs(csdev);
>                 break;
>         case CS_MODE_PERF:
> -               ret = etm_enable_perf(csdev, event);
> +               ret = etm_enable_perf(csdev, event, id_map);
>                 break;
>         default:
>                 ret = -EINVAL;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index bf01f01964cf..66d44a404ad0 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -752,7 +752,8 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>  }
>
>  static int etm4_enable_perf(struct coresight_device *csdev,
> -                           struct perf_event *event)
> +                           struct perf_event *event,
> +                           struct coresight_trace_id_map *id_map)
>  {
>         int ret = 0, trace_id;
>         struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -775,7 +776,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>          * with perf locks - we know the ID cannot change until perf shuts down
>          * the session
>          */
> -       trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
> +       trace_id = coresight_trace_id_read_cpu_id_map(drvdata->cpu, id_map);
>         if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>                 dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
>                         dev_name(&drvdata->csdev->dev), drvdata->cpu);
> @@ -837,7 +838,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>  }
>
>  static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
> -                      enum cs_mode mode)
> +                      enum cs_mode mode, struct coresight_trace_id_map *id_map)
>  {
>         int ret;
>
> @@ -851,7 +852,7 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
>                 ret = etm4_enable_sysfs(csdev);
>                 break;
>         case CS_MODE_PERF:
> -               ret = etm4_enable_perf(csdev, event);
> +               ret = etm4_enable_perf(csdev, event, id_map);
>                 break;
>         default:
>                 ret = -EINVAL;
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 117dbb484543..cb3e04755c99 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -194,7 +194,8 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
>  }
>
>  static int stm_enable(struct coresight_device *csdev, struct perf_event *event,
> -                     enum cs_mode mode)
> +                     enum cs_mode mode,
> +                     __maybe_unused struct coresight_trace_id_map *trace_id)
>  {
>         struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index 1e67cc7758d7..a01c9e54e2ed 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>
>  #include "coresight-priv.h"
> +#include "coresight-trace-id.h"
>
>  /*
>   * Use IDR to map the hash of the source's device name
> @@ -63,7 +64,7 @@ static int coresight_enable_source_sysfs(struct coresight_device *csdev,
>          */
>         lockdep_assert_held(&coresight_mutex);
>         if (coresight_get_mode(csdev) != CS_MODE_SYSFS) {
> -               ret = source_ops(csdev)->enable(csdev, data, mode);
> +               ret = source_ops(csdev)->enable(csdev, data, mode, NULL);
>                 if (ret)
>                         return ret;
>         }
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 0726f8842552..0a5e20cf23e8 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -439,7 +439,8 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>  }
>
>  static int tpdm_enable(struct coresight_device *csdev, struct perf_event *event,
> -                      enum cs_mode mode)
> +                      enum cs_mode mode,
> +                      __maybe_unused struct coresight_trace_id_map *id_map)
>  {
>         struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 7d62b88bfb5c..9c3067e2e38b 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -290,6 +290,7 @@ struct coresight_device {
>         bool sysfs_sink_activated;
>         struct dev_ext_attribute *ea;
>         struct coresight_device *def_sink;
> +       struct coresight_trace_id_map perf_sink_id_map;
>         /* sysfs links between components */
>         int nr_links;
>         bool has_conns_grp;
> @@ -384,7 +385,7 @@ struct coresight_ops_link {
>  struct coresight_ops_source {
>         int (*cpu_id)(struct coresight_device *csdev);
>         int (*enable)(struct coresight_device *csdev, struct perf_event *event,
> -                     enum cs_mode mode);
> +                     enum cs_mode mode, struct coresight_trace_id_map *id_map);
>         void (*disable)(struct coresight_device *csdev,
>                         struct perf_event *event);
>  };
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
