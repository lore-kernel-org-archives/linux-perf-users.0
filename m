Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51114280A43;
	Fri, 11 Apr 2025 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404681; cv=none; b=ofymjF/MDmtxE1K/lkAu+2fmqWYEJDsvP7JQdisdD/cLmILsiCROu2ckgw5GRCOgnICVip3aCe/Cz99NW9AvSlQli7A1ydtFDxmQVlJarBkus5dUrH0mwX/MNEFUiGJkwNCdQBgLV8XHia1rXJ6+Hf0H0HltJniNggVzM4eLlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404681; c=relaxed/simple;
	bh=95xZDAA/WR9iJKjL3F+N7V3qT0zC4l+CdpP9RSoIxo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRpuBnyItkKZ4gkMKLz13O8GhL24MjSILdMTH1JdeQow0wnHhJWx+NNQFu/p12uvinLUml7FELZ+1YfASEUjJntU7pDTLnPdqs8RRwRiuhSh0xPUKEsmDFZdRdLSoRBTmsqTq9lZ6D3xqV6OZ7k2aAp6aVt7GlDJTaYrV3+dnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVXF5/yQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVXF5/yQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A0EC4CEE2;
	Fri, 11 Apr 2025 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744404680;
	bh=95xZDAA/WR9iJKjL3F+N7V3qT0zC4l+CdpP9RSoIxo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVXF5/yQRAQpwjWF5WMtF9OuOozUuNkNLUGPc8oZq/9WY6wzRxNxHrvMn+OB16E4b
	 VqqOFoOrmJEPQsuUf0lK1YseAvTNqNfLOZC5MObJNTiOw6LZeGLFMDadLh3km9I6qT
	 s5QYmdkOiNghuPjvVD7p0WOy1yIbdQFvU8egP/DnrMaLRXMbMD2z2PIHm37z0XALx7
	 IZp/nM2apmjCrybsqZUu/kHFGUs/Pk+numo856stkPE0Kb+TcOoRoNqKYBRFsFnveI
	 p5sDoNPHjivNd0FNSgjYqOOaYf+hqu3YNg4tLX8p2RYYUwRgZlz1DtJBqSoC5g13ao
	 Z46nJZfelHgNA==
Date: Fri, 11 Apr 2025 13:51:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, dvyukov@google.com, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf report: Skip unsupported new event types
Message-ID: <Z_mAxgbgVBqHDRfD@z2>
References: <20250411174547.2208959-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411174547.2208959-1-ctshao@google.com>

On Fri, Apr 11, 2025 at 10:45:21AM -0700, Chun-Tse Shao wrote:
> `perf report` currently halts with an error when encountering
> unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
> This patch modifies the behavior to skip these samples and continue
> processing the remaining events. Additionally, stops reporting if the
> new event size is not 8-byte aligned.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 60fb9997ea0d..f55b2ac4e103 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct perf_session *session,
>  	if (session->header.needs_swap)
>  		event_swap(event, evlist__sample_id_all(evlist));
>  
> -	if (event->header.type >= PERF_RECORD_HEADER_MAX)
> -		return -EINVAL;
> +	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
> +		/* perf should not support unaligned event, stop here. */
> +		if (event->header.size % sizeof(u64))
> +			return -EINVAL;
> +
> +		/* This perf is outdated and does not support the latest event type. */
> +		ui__warning("Unsupported type %u, please considering update perf.\n",
> +			    event->header.type);
> +		/* Skip unsupported/unaligned event by returning its size. */

This comment also needs update.  Other than that looks good to me.

Thanks,
Namhyung

> +		return event->header.size;
> +	}
>  
>  	events_stats__inc(&evlist->stats, event->header.type);
>  
> -- 
> 2.49.0.604.gff1f9ca942-goog
> 
