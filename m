Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F539C621;
	Thu,  8 Jan 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868355; cv=none; b=ikY/XuS5BiXCkWnlB0cZWiKbXHRzf9PCZLPzj8Zy6XLxxM+iZiIo6a19ok60tqWyiyxBP216p1SUtMWBkLawKXcqqf4zB4Vii+mt11bec4ldlyZJ7oTERO8WDQuIK9tkRp+HXYdrA4zcev9pBErao14TatsOJu1TM86SSvazp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868355; c=relaxed/simple;
	bh=/zozxWp1gAR5kn2D4eO0IR5FOS3lXmmSjPcQFGvZws4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyJvGhReC0deqo3N+hyW9101Hgs36QDdMQWo2OURCx5YX7FJVKcOqQojUD1n25bb3BQ5j0wLZJanEeZBOekuqgJazQUeX2qDGe8bpBfLAIPp/dNWH0kUFMsFlMjIO4nku2lHVmaGk6kBGzVTqRVNRXpt/j2klgvbFVUVd2jT3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZKxl6FD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZKxl6FD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4TykfQTVnHdzOlmvUj8oYdH4DJAb/a+JosOJz/5k0V8=; b=NZKxl6FDCCZ2InF6XW80ZZuvi6
	m5I8VhN42y0D6niiT7aLOQ27DbN4/Ic/0Df3wbH+AfbQkjBtvW4vVGTT4EOmJIeGsDe44a8VaUykJ
	vYcbrUEMD9RDci1/XXoIh0XMscLhGsf7JLntYLAgD4ACa5DUItQjQ3OYV+iDqP/gGDMU22Dlsgtu5
	mBkjwMf36RC4BlDhwV/rOcUg5CghFnkSaEKNmH4tS4fQS2WFx+eFIAWaG0ngjNSn3wltjnyPtdpAN
	XdgItHkGrENzKDk7+xkRo5JstbXx6VGzWMZhYjvDnJEHpOoCctHtJHjomJhonPfzNZG2NlDDKhkUN
	R6SyQYqw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdnJQ-0000000Enhd-43rY;
	Thu, 08 Jan 2026 10:32:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2876300E8E; Thu, 08 Jan 2026 11:32:14 +0100 (CET)
Date: Thu, 8 Jan 2026 11:32:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Subject: Re: [PATCH] perf/core: Speed up kexec shutdown by avoiding
 unnecessary cross CPU calls
Message-ID: <20260108103214.GG272712@noisy.programming.kicks-ass.net>
References: <0d0b7fe70e6dfa7979cb83b05317deb21187f74d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0d0b7fe70e6dfa7979cb83b05317deb21187f74d.camel@infradead.org>

On Thu, Jan 08, 2026 at 11:14:24AM +0100, David Woodhouse wrote:
> From: Jan H. Sch=F6nherr <jschoenh@amazon.de>
>=20
> There are typically a lot of PMUs registered, but in many cases only few
> of them have an event registered (like the "cpu" PMU in the presence of
> the watchdog). As the mutex is already held, it's safe to just check for
> existing events before doing the cross CPU call.
>=20
> This change saves tens of milliseconds from kexec time (perceived as
> steal time during a hypervisor host update), with <2ms remaining for
> this step in the shutdown. There might be additional potential for
> parallelization or we could just disable performance monitoring during
> the actual shutdown and be less graceful about it.
>=20
> Signed-off-by: Jan H. Sch=F6nherr <jschoenh@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---

Fair enough I suppose. Let me go queue this.

>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 413b88a4e00f..e36372b3c83f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14712,7 +14712,8 @@ static void perf_event_exit_cpu_context(int cpu)
>  	ctx =3D &cpuctx->ctx;
> =20
>  	mutex_lock(&ctx->mutex);
> -	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
> +	if (ctx->nr_events)
> +		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
>  	cpuctx->online =3D 0;
>  	mutex_unlock(&ctx->mutex);
>  	mutex_unlock(&pmus_lock);
> --=20
> 2.43.0
>=20
>=20


