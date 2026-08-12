Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635E399357;
	Wed, 12 Aug 2026 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520517; cv=none; b=YgC7Iu6JPHNchnB3SsCJwMTigg2pHjNGMLREbbTbScjLTNP0FzA+zqOfFaVzwSg42XAjSboTgra8DealNmY7lw6Aik9Yhq0qNJiUD8uq0SkKnl4CKBK3Gpfh9fipnSkXPPZsu6R3Cbxx815PuPLBkfOS9lnZJd6si1sygjkavOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520517; c=relaxed/simple;
	bh=z5qP7X/99hM2T0Rk4TFjMNkRIxbz4CezaFktS/HAFtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv8WUDjiQvWi6t0eSonOLjkvN9Uc8nUTbfCMq8gDLWXTz/kgQEyzhOaNYtjYmH2ZNfLZQfEaHyVaN4l6swh/wEPve2Rbh1yjXJu1PXmMeHsyFKnRgxfSdCYcO0MEGOS9LeO9YsBBRlIIdGOmZOk2yhDUd0uDJMyChb309FdD8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4xJGKvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4xJGKvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F871F000E9;
	Wed, 12 Aug 2026 07:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520514;
	bh=UbQDo+98M71b04siZ4bnvhOa1s3ZN5qToN8bhnVCZXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X4xJGKvFdAGyIqoBS4BJQll75JYuBYz0bJ07+t8gshUqpVe8Yw+5H+TJ7kT0PVvlh
	 0nhRKD2OPfh0NhQEHW61JGCkDk7WFmrsjqQ+rPjoeaEZaGo0P6mnIeqxZsE58n6lVz
	 24BNF465DEXNWuRyxPZXZXWe2ITzG1grNr4LAtnDscgNGPcXz/YK8O38IT8sKdbwQw
	 /zMnPzJdRWN7bFDm4lyRS19AY3ED2/uqJvXO+UZYESRo1VBmlg/Oamja9hC/Ced533
	 n7gkW8XGl/hwd6YFdfuXdEOu83pcyW+HBC7PJA3RtWLapTZKbm1e9ifq0wLoYGAu/B
	 PLgZi4dFpYtqA==
Date: Wed, 12 Aug 2026 16:41:50 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: michael.niarchos@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf kvm: Fix memory leak in process_sample_event()
Message-ID: <anwjvuglUFEOld5F@google.com>
References: <20260807-perf-kvm-leaks-v1-0-7b5e2f97905a@gmail.com>
 <20260807-perf-kvm-leaks-v1-1-7b5e2f97905a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807-perf-kvm-leaks-v1-1-7b5e2f97905a@gmail.com>

Hello,

On Fri, Aug 07, 2026 at 05:08:35PM +0200, Michalis Niarchos via B4 Relay wrote:
> From: Michalis Niarchos <michael.niarchos@gmail.com>
> 
> machine__resolve() indirectly acquires a thread reference via
> machine__findnew_thread(). Release it, as suggested by the documentation
> of the former.
> 
> Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
> ---
>  tools/perf/builtin-kvm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 00baafb05603..8e7bc7b2db18 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1145,7 +1145,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  	if (machine__resolve(machine, &kvm->al, sample) < 0) {
>  		pr_warning("WARNING: at offset %#" PRIx64 ": fail to resolve address location, skipping sample\n",
>  			   sample->file_offset);
> -		return 0;
> +		goto out;

I think it's ok to return here when machine__resolve() returns -1.
I'll remove this hunk.

Thanks,
Namhyung


>  	}
>  
>  	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
> @@ -1153,13 +1153,16 @@ static int process_sample_event(const struct perf_tool *tool,
>  		pr_debug("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
>  			 perf_event__name(event->header.type), event->header.type,
>  			 sample->file_offset);
> -		return -1;
> +		err = -1;
> +		goto out;
>  	}
>  
>  	if (!handle_kvm_event(kvm, thread, sample))
>  		err = -1;
>  
>  	thread__put(thread);
> +out:
> +	addr_location__exit(&kvm->al);
>  	return err;
>  }
>  
> 
> -- 
> 2.55.0
> 
> 
