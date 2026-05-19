Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D634DCD6;
	Tue, 19 May 2026 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169677; cv=none; b=hP4AtDRiT7fE9/GPeGcvcpG4RDoOPVT+Oic/mnGwtJ4bxFvGbQw233ytxo0IrYoQ1Y6oEirQBLc+R9xFNfo2tXm/u5M5D8N64DTn7xdWYGWU/eMpVBBCiKleEROaRLHlDkFNfnuoX3rDJZRo8VsGuKXC+v+QlRmgYBIRmJh5MD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169677; c=relaxed/simple;
	bh=rs93YS7qhau72+BtJqdRhOmhhhwWKOT44mlq8Lwm4E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OINlKCTFnvVlx9vOT7AHy+abxt6WYUL3v+gOdWYiaGrVldh3I9GEc/KmSMgijhIZz1vgUc0xFj+OlYyu4cHthv5RdYTrptXegJGvzmGnh1IVO6EbQqa0JlWnOedSvrPDEFrKuT1pCxH68vDjCyoDp2Y0B2DT6+MUvMdRYglIUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwvZw3Ob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwvZw3Ob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90E8C2BCB3;
	Tue, 19 May 2026 05:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169677;
	bh=rs93YS7qhau72+BtJqdRhOmhhhwWKOT44mlq8Lwm4E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwvZw3ObHnQMASZd/LCEO0ggR6Uxx0UMSx7PqBsDOe+UxIb+LDrsLqNEpFSyzdpfC
	 6APaNbGp6yCrEBMMsgMWan3EA8ejOOopRi3tlP2jqfqQk3kg3pgmXU63QHNT1R8Iwr
	 N4VLKn36GC2Z5bwgB75hZcuTjvVOFf0Ndh3IL/OXEo+7VLBLy3fY6lInTZHFlFVwf9
	 ZXW1zs0lAFVlIL+T3An1thPTGyOMzQGgwNdA4lt489tV75+AiDx8Ex3nKMFlA+oe1y
	 gSJpfxZBRpw7Ren7moR23BOB6tJSfqPI5tnfyBQNUupKPaa7mEeNATAf+7gdTbtpA1
	 ILEVe0QsZ2+zQ==
Date: Mon, 18 May 2026 22:47:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, skanev@google.com
Subject: Re: [PATCH v3 1/2] perf stat: Propagate supported flag to follower
 cgroup BPF events
Message-ID: <agv5i_xZCRMK4aid@z2>
References: <20260519015108.3094513-1-irogers@google.com>
 <20260519050150.3144907-1-irogers@google.com>
 <20260519050150.3144907-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519050150.3144907-2-irogers@google.com>

Hi Ian,

On Mon, May 18, 2026 at 10:01:49PM -0700, Ian Rogers wrote:
> When using BPF counters with cgroups, follower events (for cgroups
> other than the first one) are not opened. Because they are not opened,
> their `supported` flag was left as `false`.
> 
> During metric calculation, `prepare_metric` checks if the event is
> supported. If it is not supported (like the follower events), it
> explicitly sets the value to `NAN`, which eventually causes the metric
> to be reported as `nan %`.
> 
> Fix this by propagating the `supported` flag from the "leader" events
> (the ones opened for the first cgroup) to the "follower" events.
> 
> Reported-by: Svilen Kanev <skanev@google.com>
> Assisted-by: Antigravity:gemini-3-flash
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf_counter_cgroup.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index 519fee3dc3d0..dd1851634087 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -186,6 +186,21 @@ static int bperf_load_program(struct evlist *evlist)
>  		i++;
>  	}
>  
> +	/*
> +	 * Propagate supported flag from leaders to followers. Follower events
> +	 * are not opened, so their supported flag remains false.
> +	 */
> +	{
> +		struct evsel *leader;
> +		int num_events = evlist->core.nr_entries / nr_cgroups;
> +
> +		evlist__for_each_entry(evlist, evsel) {
> +			leader = evlist__find_evsel(evlist, evsel->core.idx % num_events);
> +			if (leader)
> +				evsel->supported = leader->supported;
> +		}
> +	}
> +
>  	/*
>  	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
>  	 * whether the kernel support it
> -- 
> 2.54.0.631.ge1b05301d1-goog
> 
