Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60548CE0
	for <linux-perf-users@vger.kernel.org>; Wed,  1 May 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561663; cv=none; b=kixD1mFJNi2v6JEFygK+d/y9fRlIwvxF+utZB4JKrGspru+qPC+kTXk+HoQ6xIW1zFFXfRdKYJeEovvdU+QIFUHo29aWTw3aVOog6xpeVdxBfLW9aFWurnj7Br641uiyXUrMdyLXV4QD/K0zA9mGOEWSKIJjM1GgmNstuyE5PM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561663; c=relaxed/simple;
	bh=PFvDOMRHeF4ceqtT1HoG5CTMOEV3p5eFI81RRqSaeRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDtjB0RcZfBeDPUxgTDHzgPJmkdJtxpXcosKXUoV7kwwTbWgjj8wjlMAM3cwGgtx9gnq0R9nlVaLPd50bHKQ75qZq3hPjWPPfIKGJruKAgA3IEP4QOobg3ZVIlP+eU/tvDyXUQTJuZ+QPc9pAR9y6o/k3bSPVYoeKfLAZglfrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B08lNSqO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B08lNSqO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso3689901b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714561660; x=1715166460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ek5F3YPIQaz7pVJGDrpZC6fIvMvYFFyBjkRJozj7mhk=;
        b=B08lNSqORCad23SG44rFFpG4gqe3jaITrZ3AG2hQ8xd6+9b3KwQc5XT2dU+g8f4dsj
         5eJWFBMNshAiz04IUZeIhJy87m5GAMx+bxMFXiC1GuAAtp6T4m/o9Awu+rKCo06jWSBL
         1iP0rIqF/FQX0bMlkgvPoY1zTUMeYETMCF0v6VcTV/6QLTXKKX5ek0YMVszrENtYjYIl
         HuWgJzEm4wTR/o7JRmATlhKLA2lDnE0KIq40jcb/9nnRU54w1DqyOJwR4KIgCyaU6tfT
         TGasvGS1NhgK7h/xlTkeN6R7TO3rDgHAuSiv9HD3m5gxBYrdFXfSGN3gJvDtu4xTXTls
         Eeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561660; x=1715166460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ek5F3YPIQaz7pVJGDrpZC6fIvMvYFFyBjkRJozj7mhk=;
        b=wwVihOTk0MAz3PyHYWiPG+0W67BLdVYNrIQxccviyiihGOv81eyLrt7ZUmAgRpACNU
         vzhlivkYGOiPuSrbBqV63ekpgSf+OzFhUxKDMymd9Hoe5HhlN7OUQ1z1lPY4mdfLpC4q
         w75r3hU7e5gjLafbS/oe7Y+Mz4Y+I0Ih95exyIso4VhZ3fprbOrk3KH3Dle5Viwt0si2
         xNtaMQz/mbJKpBbklG3OAdLwlsOvHWBFqciFh6CumrmFQQqrC2iX1qfpYcSHiE42cRtf
         Cg0/7joXfrH9Z9CEgj1LnPMI/Ls6GA0kCXX91toD59gICYBVPqkQSrMgSEgUrHIZ50k7
         eXxQ==
X-Gm-Message-State: AOJu0YxUFIZb8uvnN9qZ1c1WMpuW9jrezd5zU9eswaEnZZAi1PmgQV9M
	uMV++h3oTYUZdmP+MmA8UIO4/Odp+3GvCHYx42QyuShyWPEjnzGo5DeajH3uUJM9EyNctkHViUp
	JuFM1oqSYK2hAwI+7u2RCkR0X8bgC96nrkbkVrw==
X-Google-Smtp-Source: AGHT+IE/tyinAuqC8y5bBreMEgtKVRNCzWBS/7la0SOC/SOUmFsQmilGpTeNNFJve+JepEwqeq9sMzFbKUfoY4RzIdo=
X-Received: by 2002:a05:6a20:3213:b0:1a9:c757:a22d with SMTP id
 hl19-20020a056a20321300b001a9c757a22dmr2167796pzc.14.1714561659976; Wed, 01
 May 2024 04:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-10-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-10-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 1 May 2024 12:07:29 +0100
Message-ID: <CAJ9a7Vgvdjz9peyDzRzAJ3DDGFfjVD0dNXgcJ7b+g-WvCwZ1QQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] coresight: Clarify comments around the PID of the
 sink owner
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
> "Process being monitored" and "pid of the process to monitor" imply that
> this would be the same PID if there were two sessions targeting the same
> process. But this is actually the PID of the process that did the Perf
> event open call, rather than the target of the session. So update the
> comments to make this clearer.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
>  drivers/hwtracing/coresight/coresight-tmc.h     | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index e75428fa1592..8962fc27d04f 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -36,7 +36,8 @@ struct etr_buf_hw {
>   * etr_perf_buffer - Perf buffer used for ETR
>   * @drvdata            - The ETR drvdaga this buffer has been allocated for.
>   * @etr_buf            - Actual buffer used by the ETR
> - * @pid                        - The PID this etr_perf_buffer belongs to.
> + * @pid                        - The PID of the session owner that etr_perf_buffer
> + *                       belongs to.
>   * @snaphost           - Perf session mode
>   * @nr_pages           - Number of pages in the ring buffer.
>   * @pages              - Array of Pages in the ring buffer.
> @@ -1662,7 +1663,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>                 goto unlock_out;
>         }
>
> -       /* Get a handle on the pid of the process to monitor */
> +       /* Get a handle on the pid of the session owner */
>         pid = etr_perf->pid;
>
>         /* Do not proceed if this device is associated with another session */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index c77763b49de0..2671926be62a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -171,8 +171,9 @@ struct etr_buf {
>   * @csdev:     component vitals needed by the framework.
>   * @miscdev:   specifics to handle "/dev/xyz.tmc" entry.
>   * @spinlock:  only one at a time pls.
> - * @pid:       Process ID of the process being monitored by the session
> - *             that is using this component.
> + * @pid:       Process ID of the process that owns the session that is using
> + *             this component. For example this would be the pid of the Perf
> + *             process.
>   * @buf:       Snapshot of the trace data for ETF/ETB.
>   * @etr_buf:   details of buffer used in TMC-ETR
>   * @len:       size of the available trace for ETF/ETB.
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
