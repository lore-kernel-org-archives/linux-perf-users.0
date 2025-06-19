Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFA1C8611;
	Thu, 19 Jun 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344660; cv=none; b=hx/L/KaUGM5Avds5LGTJzXjliUAK4JtuzTcLGD1Pig7///tHSfYZNoAmMuBA9Ce9NRNWe8gxXrBjEw6ar0mAa8fl6MzPG0F+A1aWRaIg9XTB6dXdE8dekyA5W6RwCHWBwlacoMvKqe4qrj322Iymc7UfIpp/kwGVrSmr9kds/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344660; c=relaxed/simple;
	bh=VwvqMdaa9NZw6/FN4BrrnCTsukLuvToppo7JfxBzAXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+LTzNmSDT6MWRBeLQ1pxEJw8crajvTEBoLfdXmG6yrHrFgtIOaPxw57PNWG9hDq2VZk1axOuQxDnpwO11jlwwRxRW+HfCQQaU43eSnTuQxL8WrJ/DG6Tyk3j+jkUBVeMBcZpeDJm5ZSSDbcHBrt4u7ARkrauwacbfFlOlLS2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SB9xZ8Lv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SB9xZ8Lv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lyjCyObuqLYarHT2NF3ZABGgRv6FP79VVqjAGnV/Lrk=; b=SB9xZ8LvbT07yHDi2QBJXj6mrz
	EEscIKEuvH+S6/2TK/aNwbqSYZmPFAc+xVwggcqHaIaT3tv0scVpqXZWj5vI9w1baNObE8X6ar38r
	d2r+VReGkKIgvSqxMcf5nm7Zw7KW26gfcE8xrb0aN3RTgBnYcOXHosqPhF4NSYuRK4Yok6OZwJN46
	EMNOwJ9oRV4w8/kPj547zrMqs5epd9XLAUw+V8ZqwUipI1kiQlvHOrB70WR/0VakgynHXvriXVhB+
	gXsGQQBIIl/hHyhZHNhRyd6cZeVzaP3lZ2sY22UmG/8NMpJsbzZxTnrK1rs6HJ6D28kcpFtV5ewAA
	/iNhMmhA==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSGbF-000000097uB-1ys9;
	Thu, 19 Jun 2025 14:50:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9DA230890E; Thu, 19 Jun 2025 16:50:44 +0200 (CEST)
Date: Thu, 19 Jun 2025 16:50:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kernel@collabora.com,
	Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/headers: Document PERF_PMU_CAP capability flags
Message-ID: <20250619145044.GL1613376@noisy.programming.kicks-ass.net>
References: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>


Mark just linked this thread from another thread:

  https://lkml.kernel.org/r/20250619144254.GK1613376@noisy.programming.kicks-ass.net


On Wed, Jun 18, 2025 at 09:08:34PM +0200, Nicolas Frattaroli wrote:

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ec9d96025683958e909bb2463439dc69634f4ceb..7d749fd5225be12543df6e475277563bf16c05b1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -294,16 +294,90 @@ struct perf_event_pmu_context;
>  /**
>   * pmu::capabilities flags
>   */
> +
> +/**
> + * define PERF_PMU_CAP_NO_INTERRUPT - \
> + *    PMU is incapable of generating hardware interrupts
> + */
>  #define PERF_PMU_CAP_NO_INTERRUPT	0x0001

This is not quite right; CAP_NO_INTERRUPT means it is not able to
generate samples.

While not being able to generate interrupts and not being able to
generate sample is more or less the same for CPU PMU drivers, this is
not true for uncore drivers. Even if an uncore driver has interrupt
capacility to help with counter overflow, it cannot generate samples.

> +/**
> + * define PERF_PMU_CAP_NO_NMI - \
> + *    PMU is guaranteed to not generate non-maskable interrupts
> + */
>  #define PERF_PMU_CAP_NO_NMI		0x0002
> +/**
> + * define PERF_PMU_CAP_AUX_NO_SG - \
> + *    PMU does not support using scatter-gather as the output
> + *
> + * The PERF_PMU_CAP_AUX_NO_SG flag indicates that the PMU does not support
> + * scatter-gather for its output buffer, and needs a larger contiguous buffer
> + * to output to.
> + */
>  #define PERF_PMU_CAP_AUX_NO_SG		0x0004
> +/**
> + * define PERF_PMU_CAP_EXTENDED_REGS - \
> + *    PMU is capable of sampling extended registers
> + *
> + * Some architectures have a concept of extended registers, e.g. XMM0 on x86
> + * or VG on arm64. If the PMU is capable of sampling these registers, then the
> + * flag PERF_PMU_CAP_EXTENDED_REGS should be set.
> + */
>  #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
> +/**
> + * define PERF_PMU_CAP_EXCLUSIVE - \
> + *    PMU can only have one scheduled event at a time
> + *
> + * Certain PMU hardware cannot track several events at the same time. Such
> + * hardware must set PERF_PMU_CAP_EXCLUSIVE in order to avoid conflicts.
> + */
>  #define PERF_PMU_CAP_EXCLUSIVE		0x0010
> +/**
> + * define PERF_PMU_CAP_ITRACE - PMU traces instructions
> + *
> + * Some PMU hardware does instruction tracing, in that it traces execution of
> + * each instruction. Setting this capability flag makes the perf core generate
> + * a %PERF_RECORD_ITRACE_START event, recording the profiled task's PID and TID,
> + * to allow tools to properly decode such traces.
> + */
>  #define PERF_PMU_CAP_ITRACE		0x0020
> +/**
> + * define PERF_PMU_CAP_NO_EXCLUDE - \
> + *    PMU is incapable of excluding events based on context
> + *
> + * Some PMU hardware will count events regardless of context, including e.g.
> + * idle, kernel and guest. Drivers for such hardware should set the
> + * PERF_PMU_CAP_NO_EXCLUDE flag to explicitly advertise that they're unable to
> + * help themselves, so that the perf core can reject requests to exclude events
> + * based on context.
> + */
>  #define PERF_PMU_CAP_NO_EXCLUDE		0x0040

More to the point might be saying that it will reject any event that
has: perf_event_attr::exclude_{user,kernel,hv,idle,host,guest} set.

> +/**
> + * define PERF_PMU_CAP_AUX_OUTPUT - PMU non-AUX events generate AUX data
> + *
> + * Drivers for PMU hardware that supports non-AUX events which generate data for
> + * AUX events should set PERF_PMU_CAP_AUX_OUTPUT. This flag tells the perf core
> + * to schedule non-AUX events together with AUX events, so that this data isn't
> + * lost.
> + */
>  #define PERF_PMU_CAP_AUX_OUTPUT		0x0080
> +/**
> + * define PERF_PMU_CAP_EXTENDED_HW_TYPE - \
> + *    PMU supports PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> + */
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
> +/**
> + * define PERF_PMU_CAP_AUX_PAUSE - \
> + *    PMU can pause and resume AUX area traces based on events
> + */
>  #define PERF_PMU_CAP_AUX_PAUSE		0x0200
> +/**
> + * define PERF_PMU_CAP_AUX_PREFER_LARGE - PMU prefers contiguous output buffers
> + *
> + * The PERF_PMU_CAP_AUX_PREFER_LARGE capability flag is a less strict variant of
> + * %PERF_PMU_CAP_AUX_NO_SG. PMU drivers for hardware that doesn't strictly
> + * require contiguous output buffers, but find the benefits outweigh the
> + * downside of increased memory fragmentation, may set this capability flag.
> + */
>  #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
>  
>  /**
> 
> ---
> base-commit: 31d56636e10e92ced06ead14b7541867f955e41d
> change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac
> 
> Best regards,
> -- 
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
