Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1D5E22C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 May 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561894; cv=none; b=sTK+7Pp5fZkxl0eK88nXLWziT7nCZYdm96FZfJX8V6K6lA6iWNHaURHrh3uGi/iYuWXw8Xj0l1BhyH5MDwnTNqyF36w3pqGRL6Q6FEKyB+QiRW8ZzNHAfxxB+tc7TvrYlgK4OWJMuQqbHD1Y4z08G+VIGilnpMK678isNVpeCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561894; c=relaxed/simple;
	bh=rP7uH6p9WSfZPD4zUjuFPD5EEQc4lxYWqVD/vJwLfNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgnAu57G9y7OXkjH+iruFBAnL/zMxt0uzOPv11nNY0cZ90DDDhSH4z9nw5k7XA4coeF9KX/gPT3MyQ5a8VjNQiJkQzQl4AD5uvsh5RzF3a34L393NCo2HHZB/0RRN4WQIdP6ugXyp1sZSUFUsWC0UmRMlzAjueucxYBkodB7Bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hPoyMt32; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPoyMt32"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3738077a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714561893; x=1715166693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZZTUr02OpFJNJ7PY9o47700VYpg5n+dM1vcCgaaNjM=;
        b=hPoyMt32QOT5dJckUKqav76+lbTkweH8adoewKYEQJUYPX7fH8npfKgTV8QM6BEtdl
         sGrYlYQCTLXLudT0RH4Ioc27zeNfkpPIadLaJHFr/yNAknd+6mSQiKhrwN6ZEA7j6ddM
         mWE7xqE4rsiS/fKr9ziqMaSdz1HKV9pApggUpFtD9ZZ4qYcsUiaKlXmZVkMnz/S0U1SS
         x8U35cy1pIWVJ8r3ShlTnNeGxjP6TMnkdfGO6Na1RUG0VehH2OxW+WUAg1aU1NKDIHbq
         IrDjvyXrQA+7nQfx4pphq2iW177lhN5ME43ZaEU0TxGMziXD8yV5BZZ8TZbkXCEQGXnj
         buxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561893; x=1715166693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZZTUr02OpFJNJ7PY9o47700VYpg5n+dM1vcCgaaNjM=;
        b=e/jhxIW+19SjiefTcY+NySUm5zIPBvPgbtqEIYLgEzdZULMYp0vW1IBdKreDZA1639
         LCTy+ARzeLI92nqADQzEDcD7JwP4rsuGQvh/LtFssz8FNBOm/H3Ge9pXV5dE9aMtCDj5
         XVrVbJdbckI63gxdUc29pMC6twWc9aDzc7QeTOSJK0sUtZQitX84tApbHku0u1bbfFJ7
         lueVLUzBAjy15k9mhIcM3bfZvWv8o90g0z2xMEH2Ic3JhtBg6KSZYzw444tXIVOEQDxD
         Jg2mxEMsBJpSXeWQZQEJVjyHjBUKAQnb1IeSiNI0/KyMcn89II/v1VjC5SpQvPTe1AnA
         haYA==
X-Gm-Message-State: AOJu0YzAJI6QLeDhKLUwTpcRIeFSS/8yFQd9clPenHtcmz6eGlvAvOmJ
	Vl/B/TmYJIvzip4/IGGq+A33dEek2oguE0y9PA6MoLyAjxX55OazR2kddEu79YFS/PEMY/LjVkD
	Dol9BwJnlBX2kKa3RZUnp10M9OyA6Cr0YUgAkwQ==
X-Google-Smtp-Source: AGHT+IHme+tbaissSNWWxihi7iBWbnHX1ITaUYwIqqsZ/hS87/ki1ILDQ1EHmGWbPiULm7pY0uK6xANN1WfW/TaXyVQ=
X-Received: by 2002:a17:90b:388f:b0:2b2:812e:1d8c with SMTP id
 mu15-20020a17090b388f00b002b2812e1d8cmr1795234pjb.2.1714561892566; Wed, 01
 May 2024 04:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-11-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-11-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 1 May 2024 12:11:21 +0100
Message-ID: <CAJ9a7VghkeaJ8e-mEZKodicQ++QyW_SKfacsPPsfQb2PiT6H0w@mail.gmail.com>
Subject: Re: [PATCH 10/17] coresight: Move struct coresight_trace_id_map to
 common header
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com, 
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org, 
	suzuki.poulose@arm.com, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 16:24, James Clark <james.clark@arm.com> wrote:
>
> The trace ID maps will need to be created and stored by the core and
> Perf code so move the definition up to the common header.
>
> Signed-off-by: James Clark <james.clark@arm.com>
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
>  #define IS_VALID_CS_TRACE_ID(id)       \
>         ((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
>
> -/**
> - * Trace ID map.
> - *
> - * @used_ids:  Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> - *             Initialised so that the reserved IDs are permanently marked as
> - *             in use.
> - * @pend_rel_ids: CPU IDs that have been released by the trace source but not
> - *               yet marked as available, to allow re-allocation to the same
> - *               CPU during a perf session.
> - */
> -struct coresight_trace_id_map {
> -       DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
> -       DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
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
>         const char *target_name;
>  };
>
> +/* architecturally we have 128 IDs some of which are reserved */
> +#define CORESIGHT_TRACE_IDS_MAX 128
> +
> +/**
> + * Trace ID map.
> + *
> + * @used_ids:  Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> + *             Initialised so that the reserved IDs are permanently marked as
> + *             in use.
> + * @pend_rel_ids: CPU IDs that have been released by the trace source but not
> + *               yet marked as available, to allow re-allocation to the same
> + *               CPU during a perf session.
> + */
> +struct coresight_trace_id_map {
> +       DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
> +       DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> +};
> +
>  /**
>   * struct coresight_device - representation of a device as used by the framework
>   * @pdata:     Platform data with device connections associated to this device.
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
