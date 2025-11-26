Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B017314D35;
	Wed, 26 Nov 2025 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140317; cv=none; b=txUI6D+WmK6olzPYmsQqIRVPyTsBynZEONleAKN1Aq0hkgbvVwFjtMm+PdkQKodb+Bva1gH7OC8DwqbBttndTCPjPO5ZZHoRzian6S4kocyJhgS82rQ6F0oJO7yQwYlNQvOD2LOHShvuZq29HTyJ28TRL0/Hh4tDkRvilOHGLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140317; c=relaxed/simple;
	bh=lWeRxaX4+VvnMpzF+TCIIN+QKdPRglpgu651nre//GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJNfu1irIARqYwCNJGlFVlfH4LQlIUPjBRJ+kH3YdQmAkd4lBFgmDl8wNwddy9w24nwfDSp5xsRAY2gb7pPMNfYYo3+jfFCiOucyoCami0Ik57E70yEA46cWhRTrgJIvmZtMLDNbzjWw/GlFSwNCpgXc+UTlC90lSMDyNwIfmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSc1p9RA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSc1p9RA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036B5C116B1;
	Wed, 26 Nov 2025 06:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764140316;
	bh=lWeRxaX4+VvnMpzF+TCIIN+QKdPRglpgu651nre//GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSc1p9RAfvasmBoPJW8HrV7dMK/O5D1dd3N7tdVkc3J+qRkC6cqSivq2VX4Bs3ASc
	 6DJKZTi5f/jrei33ZNvAmSx12+qQXrqqD4X7mLrV5lvNMtQHosn0+2vFVll0O3fYeU
	 VD+meFe+UvXwDqnsrPqbeJzQ9hsWd1oojw7iccDK+augK0dmvPrI/Hvgk8N45qOQxB
	 rCA4+/k7xABodCDA9Gm6EtjlU2RFbW2faNoiMWbnQadrdyKOe7as2T4Zn/8RAlbs6W
	 2118WexJClryVZMfJ7VMOE/yhEzJGGe+W04Bg4ityHNf2v1OBNIPOgCl4zrknem2m3
	 M2a7zsJoCKFGQ==
Date: Tue, 25 Nov 2025 22:58:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 05/17] perf probe-event: Ensure probe event nsinfo is
 always cleared
Message-ID: <aSalGg5f8xaM_GBX@google.com>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-6-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:17AM -0800, Ian Rogers wrote:
> Move nsinfo__zput from cleanup_perf_probe_events to
> clear_perf_probe_event so it is always executed. Clean up
> clear_perf_probe_event to not call nsinfo__zput and use the pev

Do you mean clear_perf_probe_events?


> variable to avoid repeated array accesses.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/probe-event.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 6ab2eb551b6c..710e4620923e 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2419,6 +2419,7 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
>  	}
>  	pev->nargs = 0;
>  	zfree(&pev->args);
> +	nsinfo__zput(pev->nsi);

I'm not sure pev->nsi is always set properly.  At least it seems to miss
in the perf_probe_event__copy().

Thanks,
Namhyung


>  }
>  
>  #define strdup_or_goto(str, label)	\
> @@ -3767,12 +3768,11 @@ void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs)
>  	/* Loop 3: cleanup and free trace events  */
>  	for (i = 0; i < npevs; i++) {
>  		pev = &pevs[i];
> -		for (j = 0; j < pevs[i].ntevs; j++)
> -			clear_probe_trace_event(&pevs[i].tevs[j]);
> -		zfree(&pevs[i].tevs);
> -		pevs[i].ntevs = 0;
> -		nsinfo__zput(pev->nsi);
> -		clear_perf_probe_event(&pevs[i]);
> +		for (j = 0; j < pev->ntevs; j++)
> +			clear_probe_trace_event(&pev->tevs[j]);
> +		zfree(&pev->tevs);
> +		pev->ntevs = 0;
> +		clear_perf_probe_event(pev);
>  	}
>  }
>  
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
