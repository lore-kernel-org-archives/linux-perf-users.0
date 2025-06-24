Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884B427FB31;
	Tue, 24 Jun 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771942; cv=none; b=VX1EZv6YwE+Zh9nZEFxr4EfivVk2HV7zi+4IBuAK8oQjmK1cHhpjfo346sq7T6bGZbqzykMtukf2elR6xx1gJRNncdcCbwv/CvOKYaG46rWTb9GrgtCNA+k0tdeEMGJyO32qTuRRTdTGP8pnTSqfAJTH0JFWSHReXtn0Z6jIoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771942; c=relaxed/simple;
	bh=VozcF0CvKTIfYr3POoFfypeicY3DQ7mgNp7G004Or0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hANXHUHCoirWOrOww+g2VhkU7i3GQZUFsbKiuTvc3ewrEarQc32j3C5qyJ0s2p5uTgBafd2Jnrw1TkyzQTXQAE3JsHmA7cZS4kyZMjdcNAvPHdq4g3aHs2moQvIv1VIgpvxbq2HvjYY6t7eOFAcIdZn1PTUGPPMxVWsJCnmLE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10041113E;
	Tue, 24 Jun 2025 06:32:02 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91A9D3F58B;
	Tue, 24 Jun 2025 06:32:19 -0700 (PDT)
Date: Tue, 24 Jun 2025 14:32:17 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/aux: Properly launch pending disable flow
Message-ID: <20250624133217.GO794930@e132581.arm.com>
References: <20250522150510.2942814-1-leo.yan@arm.com>
 <d87ddbbb-862d-4cf7-b2c4-a5eb0d072a33@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87ddbbb-862d-4cf7-b2c4-a5eb0d072a33@linaro.org>

On Tue, Jun 24, 2025 at 02:11:38PM +0100, James Clark wrote:

[...]

> > @@ -441,7 +441,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
> >   		 * store that will be enabled on successful return
> >   		 */
> >   		if (!handle->size) { /* A, matches D */
> > -			event->pending_disable = smp_processor_id();
> > +			perf_event_disable_inatomic(handle->event);
> >   			perf_output_wakeup(handle);
> >   			WRITE_ONCE(rb->aux_nest, 0);
> >   			goto err_put;
> > @@ -526,7 +526,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
> >   	if (wakeup) {
> >   		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> > -			handle->event->pending_disable = smp_processor_id();
> > +			perf_event_disable_inatomic(handle->event);
> >   		perf_output_wakeup(handle);
> >   	}
> 
> The types are now a bit misleading and pending_wakeup and pending_disable
> could be bool types. The other pending_*s do use their types properly
> though.
> 
> __perf_pending_disable() also still contains a big comment that describes
> use of CPU ID and -1 values.

I might use an extra patch to address type and comment issue.

> Other than that it makes sense.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks for review!
