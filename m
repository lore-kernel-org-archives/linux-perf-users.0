Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4823740
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0/RpHBT"
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D69F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 05:26:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27d3c886671so2534843a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697459184; x=1698063984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmn6/sIgRo7SY0ymPqgTtwfMgrfA0Y3BP4S+nWa7vE0=;
        b=P0/RpHBTxIy91mHQ6+UqC1YBBX6ZKtla+4FqL0LAOU2vRTAM3oLIv6bMQuOQmMuaWf
         wX9pcR86OUuHVWIq8v4tZRwl/AdeK+A8aC9MzfVYxfcI1I2mGNDj7mkCMTwiXye++/Nr
         7yaeo0WOGLLtMjrUjVEhL9v44f4sEKIDBkwLXZJjZw3/okbrHoh6Bjq6pCXVyC3Su8kS
         LplqiCzO3AKl7l5QvQUq+BrKDEM+gQOTqjXWkTut38S9Swc/joJ2OK1v2NT/niFvZGh4
         4yJQAlMIrTx1krUrnAfkku5Lo9K4u/C44C/4qLKiLAHM/IK5wi6Ud9Do5HhxM1pqk8lv
         s6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459184; x=1698063984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmn6/sIgRo7SY0ymPqgTtwfMgrfA0Y3BP4S+nWa7vE0=;
        b=w1LsJNH6ackZ3wbJrIl8G7P5WRMcYu72Lmpt5RCPRsmPH3pqu5mWZ7HCJSYwH1+kS7
         fvK642F0fU3HgBVoPnccA/yOxUh20UUh3Sc9p7qHzh7smty675HmXAvVWpFmAO6l2A6R
         y5kNvaPogJhmr/s/vg/YL2HTwqHdIcVn2ntdDlhwCW2q/97B3+1M+P1cCCxshR5grHHy
         TEY5x+8V4gkvFbLiuSkXBFMpgnCdb8N4auRGcktsdYIZutMl7u5+QCxBzu1V+KxXt9hL
         qwuAD1oi9g1VclXS3HYn1x3xiXNcULW0LjzE6tShL+ttXJwulRQ76SeBy9sA4wCirvta
         UtTA==
X-Gm-Message-State: AOJu0Yz7joFEIQ3Cbt2YcU8mhpn4/nrYRwc+FqGc2d/NppKdGx4oWSKL
	CYlen5Ar5GJH4G3rft9j2ukzfg==
X-Google-Smtp-Source: AGHT+IGTpZt5mh7PLLa+PXm7c+3dddBndmP/Iy/6mV9lRWJMNC172sZoHymfQsIRPUQVZ+MW6n45MA==
X-Received: by 2002:a17:90b:1289:b0:27d:694f:195d with SMTP id fw9-20020a17090b128900b0027d694f195dmr4527726pjb.6.1697459184104;
        Mon, 16 Oct 2023 05:26:24 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.160])
        by smtp.gmail.com with ESMTPSA id 6-20020a630806000000b0056c2f1a2f6bsm5673189pgi.41.2023.10.16.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:26:22 -0700 (PDT)
Date: Mon, 16 Oct 2023 20:26:15 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] perf arm-spe: Move PMU initialization from
 default config code
Message-ID: <20231016122615.GG928468@leoy-huanghe.lan>
References: <20231012175645.1849503-1-irogers@google.com>
 <20231012175645.1849503-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012175645.1849503-4-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 10:56:41AM -0700, Ian Rogers wrote:
> Avoid setting PMU values in arm_spe_pmu_default_config, move to
> perf_pmu__arch_init.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/arm/util/pmu.c       | 2 ++
>  tools/perf/arch/arm64/util/arm-spe.c | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index d55d2b15f2e6..f25f68f84a94 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -23,6 +23,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  		pmu->default_config = cs_etm_get_default_config(pmu);
>  #if defined(__aarch64__)
>  	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
> +		pmu->selectable = true;
> +		pmu->is_uncore = false;

Arm SPE is not an uncore PMU event.  Arm SPE driver registers sysfs node
'cpumask', thus it misleads the pmu_is_uncore() function and it returns
'true' for Arm SPE event.

Here we need to explictly set false to correct the 'is_uncore' flag.

I did test on my machine, the changes work well for Arm SPE event.

Tested-by: Leo Yan <leo.yan@linaro.org>
