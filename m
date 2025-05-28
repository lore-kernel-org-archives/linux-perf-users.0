Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C9199939
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455747; cv=none; b=LvpFDbHL/0J5DFBo/uHScIJ7BY9yIIzIVYEIgHWsOpAWTNPdmTUkmljnsXavi0D/zBMdbsnpBvU1IWQEzhaKwVl9aDXLteEu7kG6gKzMjjTXwfKI1Pu49DXqZNPQJ977RiISoNSdpflMXYeN4IZJkRYL9Dl9LH9yBbSr9/Ojczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455747; c=relaxed/simple;
	bh=IXXl9RvrM7CC7UIrTnZv+SFJ7VzTP9Osum4QpI+cYYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQL9acIAErtvkxFlNdqkOi7X55Vp2fUaAvBqcE/I8+qq12K7u+Ht5FL7FPqW5kU0oLczLOqY9LT51g5puL/o/a+gnHnwUoVGGRjbmys6tzbnO2dB/hN1s2CmmBxSPdXwGA0bLIT1fNjlhWtiHpm6cA3Qmh4N2NSVlIrIOC0dxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeBTndRT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeBTndRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55495C4CEE3;
	Wed, 28 May 2025 18:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748455746;
	bh=IXXl9RvrM7CC7UIrTnZv+SFJ7VzTP9Osum4QpI+cYYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeBTndRTQzVwE6JnlHRAzXy7YGKFRloxhIDzMO98qOkxcBs8jkbwYCoES+lpSSyQh
	 StBr6JJaNXvKlRMd5iUwXDDtGqdMqprNNmBkUp1huv+eicZnwIIYweLaFV9W1rJExc
	 z3NSpLRdxWqR0GgKFXCe+Gqj+w8db00RpdgSDJV+17WOtytpj7Dgmb2Bg9kFwR0Y44
	 3EoTQcXSMyGchQ04m/IyL1bi1GAdSsB4tMmqlup6kYbpuRuBc6KXDUN1YHPPzf+dXh
	 5bGcb0Y+49f9sVLHbCImjXvBUjAoR0X4Hv2/s0wXi5EDOc/SEc+t9f03VAHbCwzvV+
	 Ms+d9JR+47NIQ==
Date: Wed, 28 May 2025 15:09:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf script: Print PERF_AUX_FLAG_COLLISION flag
Message-ID: <aDdRP6v_q0vqen5t@x1>
References: <20250528153519.188644-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528153519.188644-1-leo.yan@arm.com>

On Wed, May 28, 2025 at 04:35:19PM +0100, Leo Yan wrote:
> Print out the collision flag for AUX trace data. This is helpful for
> inspecting sample collisions.
> 
> After:
> 
>   0x217b60@/data_nvme1n1/niayan01/upstream/perf.data [0x40]: event: 11
>   .
>   . ... raw event: size 64 bytes
>   .  0000:  0b 00 00 00 00 00 40 00 d2 ef 3f 00 00 00 00 00  ......@...?.....
>   .  0010:  ff 0f 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
>   .  0020:  1c 01 00 00 1c 01 00 00 10 bf 38 d6 11 01 00 00  ..........8.....
>   .  0030:  03 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................
> 
>   3 1176120114960 0x217b60 [0x40]: PERF_RECORD_AUX offset: 0x3fefd2 size: 0xfff flags: 0x8 [C]
> 
> The added character '[C]' indicates the collision.

Simple enough.
 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo
> ---
>  tools/perf/util/event.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index c23b77f8f854..2c3081e5c81a 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -448,12 +448,13 @@ int perf_event__exit_del_thread(const struct perf_tool *tool __maybe_unused,
>  
>  size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp)
>  {
> -	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s]\n",
> +	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s%s]\n",
>  		       event->aux.aux_offset, event->aux.aux_size,
>  		       event->aux.flags,
>  		       event->aux.flags & PERF_AUX_FLAG_TRUNCATED ? "T" : "",
>  		       event->aux.flags & PERF_AUX_FLAG_OVERWRITE ? "O" : "",
> -		       event->aux.flags & PERF_AUX_FLAG_PARTIAL   ? "P" : "");
> +		       event->aux.flags & PERF_AUX_FLAG_PARTIAL   ? "P" : "",
> +		       event->aux.flags & PERF_AUX_FLAG_COLLISION ? "C" : "");
>  }
>  
>  size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
> -- 
> 2.34.1
