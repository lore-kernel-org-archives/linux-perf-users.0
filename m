Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F62AD3E;
	Sat, 11 Oct 2025 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152290; cv=none; b=Hu73YlVd1aznVREp9jte3FncjuVRGTPvgO2tz/JazCuW2j0etG1ysulmXIdErqhdfYLbrkeYia09zwgWEX9OKyIsbo/18MOEG2iXNTm2eSu32uzQET3HiGK5HBIiR2bhBQBE0FpLVh0x76djaoKVpsHRIpVIfXtOHGthFp9+VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152290; c=relaxed/simple;
	bh=vh7k2RZkHuWH0jWKYl7znOscIvIPswvBJT5xk+zCli8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hChIweH264DmcHtz1KlY8VD8eHr8WmMGFw3Hn6lqsCROlsl6Bu8/CB2Pg3OQWQ6DvLjrFZWK1GzRl/cmEmrPU5sdH5BRrCJV3Sng2EgvVLaZanoNHzeyAuBpsLS8Whjd7/Q8LqbTs6t7VW9M5sKWLfqfESDk7H5KBoxh90bIoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hw0WCZPe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hw0WCZPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760152288; x=1791688288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vh7k2RZkHuWH0jWKYl7znOscIvIPswvBJT5xk+zCli8=;
  b=Hw0WCZPeNSuuyLi7J+gGRmYmjXVCTjqsyBTlj8i/hQK8HmvHnoUjL8X6
   EWoiV/fdLbCKqQooYmUQrnzfVOYcAWs99G/RQ82H+HDlkzJbcQQtYhmwM
   erdswgQBAvmqBJuuowubFgzipKGCBdzuwSgSwBJWMdxvWCNEP8fVqt0+6
   7+9YqolvP1IHyVTAx/bfVX4Y5mrTX9Il/0iE2uZbN5pOzACkRWEo648O+
   KC/FF2CQCtWzfob/azMnAF9KsTjtyy38kONSn3U8bTaeIBbll4vIRiMIj
   euqcBoAUwol6tKmpcddNp1gStzIfxwafZs2AhbcQFsXOvHn67+QR5IroD
   Q==;
X-CSE-ConnectionGUID: crYkJsB1QsuXgjpNHgKgBA==
X-CSE-MsgGUID: GC/PJUp0TMeanMy7Y4CMBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="84995467"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="84995467"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:11:26 -0700
X-CSE-ConnectionGUID: XU6TFasmTCGVWCh9cjvMFw==
X-CSE-MsgGUID: oz61yQ7FRrywUnsazyA17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181137298"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:11:23 -0700
Message-ID: <d01d3f15-c144-4e2a-9aee-6308a897f3f2@linux.intel.com>
Date: Sat, 11 Oct 2025 11:11:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] perf/headers: Document PERF_PMU_CAP capability
 flags
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: kernel@collabora.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
References: <20250909-perf-pmu-cap-docs-v2-1-3c451f7b0b2e@collabora.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250909-perf-pmu-cap-docs-v2-1-3c451f7b0b2e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/9/2025 7:39 PM, Nicolas Frattaroli wrote:
> Over the years, capability flags for perf PMUs were introduced in a
>
> piecemeal fashion whenever a new driver needed to signal to the perf
>
> core some limitation or special feature.
>
>
>
> Since one more undocumented flag that can have its meaning inferred from
>
> the commit message and implementation never seems that bad, it's
>
> understandable that this resulted in a total of 11 undocumented
>
> capability flags, which authors of new perf PMU drivers are expected to
>
> set correctly for their particular device.
>
>
>
> Since I am in the process of becoming such an author of a new perf
>
> driver, it feels proper to pay it forward by documenting all
>
> PERF_PMU_CAP_ constants, so that no future person has to go through an
>
> hour or two of git blame + reading perf core code to figure out which
>
> capability flags are right for them.
>
>
>
> Add comments in kernel-doc format that describes each flag. This follows
>
> the somewhat verbose "Object-like macro documentation" format, and can
>
> be verified with
>
>
>
> 	./scripts/kernel-doc -v -none include/linux/perf_event.h
>
>
>
> The current in-tree kernel documentation does not include a page on the
>
> perf subsystem, but once it does, these comments should render as proper
>
> documentation annotation. Until then, they'll also be quite useful for
>
> anyone looking at the header file.
>
>
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>
> ---
>
> Changes in v2:
>
> - Fixed the description of PERF_PMU_CAP_NO_INTERRUPT and expanded it to
>
>   make it clearer for driver authors whether this flag is right for them
>
> - Made PERF_PMU_CAP_NO_EXCLUDE docs mention the precise attributes the
>
>   flag concerns itself with, as suggested by Peter Zijlstra
>
> - Link to v1: https://lore.kernel.org/r/20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com
>
> ---
>
>  include/linux/perf_event.h | 85 ++++++++++++++++++++++++++++++++++++++++++++++
>
>  1 file changed, 85 insertions(+)
>
>
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>
> index ec9d96025683958e909bb2463439dc69634f4ceb..d0e6b66cfd268bdad742b707633792f26352a428 100644
>
> --- a/include/linux/perf_event.h
>
> +++ b/include/linux/perf_event.h
>
> @@ -294,16 +294,101 @@ struct perf_event_pmu_context;
>
>  /**
>
>   * pmu::capabilities flags
>
>   */
>
> +
>
> +/**
>
> + * define PERF_PMU_CAP_NO_INTERRUPT - \
>
> + *    PMU is incapable of generating samples
>
> + *
>
> + * On CPU PMU hardware, a PMU driver is only capable of generating sample data
>
> + * in the form of &struct perf_sample_data if the hardware is capable of
>
> + * generating hardware interrupts. If such interrupt capability is missing,
>
> + * this flag should be set.
>
> + *
>
> + * Uncore drivers, i.e. drivers for hardware performance counters that are not
>
> + * closely entwined with CPUs and their model of execution, should also set
>
> + * this flag, as they are not able to generate meaningful sample data, even if
>
> + * they do use an interrupt for some purpose.
>
> + */
>
>  #define PERF_PMU_CAP_NO_INTERRUPT	0x0001
>
> +/**
>
> + * define PERF_PMU_CAP_NO_NMI - \
>
> + *    PMU is guaranteed to not generate non-maskable interrupts
>
> + */
>
>  #define PERF_PMU_CAP_NO_NMI		0x0002
>
> +/**
>
> + * define PERF_PMU_CAP_AUX_NO_SG - \
>
> + *    PMU does not support using scatter-gather as the output
>
> + *
>
> + * The PERF_PMU_CAP_AUX_NO_SG flag indicates that the PMU does not support
>
> + * scatter-gather for its output buffer, and needs a larger contiguous buffer
>
> + * to output to.
>
> + */
>
>  #define PERF_PMU_CAP_AUX_NO_SG		0x0004
>
> +/**
>
> + * define PERF_PMU_CAP_EXTENDED_REGS - \
>
> + *    PMU is capable of sampling extended registers
>
> + *
>
> + * Some architectures have a concept of extended registers, e.g. XMM0 on x86
>
> + * or VG on arm64. If the PMU is capable of sampling these registers, then the
>
> + * flag PERF_PMU_CAP_EXTENDED_REGS should be set.
>
> + */
>
>  #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
>
> +/**
>
> + * define PERF_PMU_CAP_EXCLUSIVE - \
>
> + *    PMU can only have one scheduled event at a time
>
> + *
>
> + * Certain PMU hardware cannot track several events at the same time. Such
>
> + * hardware must set PERF_PMU_CAP_EXCLUSIVE in order to avoid conflicts.
>
> + */
>
>  #define PERF_PMU_CAP_EXCLUSIVE		0x0010
>
> +/**
>
> + * define PERF_PMU_CAP_ITRACE - PMU traces instructions
>
> + *
>
> + * Some PMU hardware does instruction tracing, in that it traces execution of
>
> + * each instruction. Setting this capability flag makes the perf core generate
>
> + * a %PERF_RECORD_ITRACE_START event, recording the profiled task's PID and TID,
>
> + * to allow tools to properly decode such traces.
>
> + */
>
>  #define PERF_PMU_CAP_ITRACE		0x0020
>
> +/**
>
> + * define PERF_PMU_CAP_NO_EXCLUDE - \
>
> + *    PMU is incapable of excluding events based on context
>
> + *
>
> + * The PERF_PMU_CAP_NO_EXCLUDE flag, when set, makes the perf core reject any
>
> + * request for an event that has one of the attributes
>
> + * perf_event_attr::exclude_{user,kernel,hv,idle,host,guest} set.
>
> + *
>
> + * Drivers for PMU hardware that cannot distinguish between these different
>
> + * execution contexts should set this flag.
>
> + */
>
>  #define PERF_PMU_CAP_NO_EXCLUDE		0x0040
>
> +/**
>
> + * define PERF_PMU_CAP_AUX_OUTPUT - PMU non-AUX events generate AUX data
>
> + *
>
> + * Drivers for PMU hardware that supports non-AUX events which generate data for
>
> + * AUX events should set PERF_PMU_CAP_AUX_OUTPUT. This flag tells the perf core
>
> + * to schedule non-AUX events together with AUX events, so that this data isn't
>
> + * lost.
>
> + */
>
>  #define PERF_PMU_CAP_AUX_OUTPUT		0x0080
>
> +/**
>
> + * define PERF_PMU_CAP_EXTENDED_HW_TYPE - \
>
> + *    PMU supports PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>
> + */
>
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
>
> +/**
>
> + * define PERF_PMU_CAP_AUX_PAUSE - \
>
> + *    PMU can pause and resume AUX area traces based on events
>
> + */
>
>  #define PERF_PMU_CAP_AUX_PAUSE		0x0200
>
> +/**
>
> + * define PERF_PMU_CAP_AUX_PREFER_LARGE - PMU prefers contiguous output buffers
>
> + *
>
> + * The PERF_PMU_CAP_AUX_PREFER_LARGE capability flag is a less strict variant of
>
> + * %PERF_PMU_CAP_AUX_NO_SG. PMU drivers for hardware that doesn't strictly
>
> + * require contiguous output buffers, but find the benefits outweigh the
>
> + * downside of increased memory fragmentation, may set this capability flag.
>
> + */
>
>  #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400

Good to see we have comments/Doc to describe this flags. It's really
helpful for the newcomers into the Perf. Thanks.

LGTM. Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>
>  
>
>  /**
>
>
>
> ---
>
> base-commit: 1d07605c859ee3f483f07acd461452d9e505c58c
>
> change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac
>
>
>
> Best regards,
>
