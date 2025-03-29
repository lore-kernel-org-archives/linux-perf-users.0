Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CF79C4;
	Sat, 29 Mar 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743208788; cv=none; b=cG1/CmfIgrtWVBkkV4/tbM3SraEymyhX6c0OLtFLZDHKwD8+WYi2IjYl+wtnyoErswGcfkP55HXW7oOLaXSfO9J/WiybcF2iiHp/X3um2w9TR4a7vytH9wv2X5k3DFon+YGX7Xbe9ehnKqhplMTZd/EQOQoEqHG130ppvF+AzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743208788; c=relaxed/simple;
	bh=HDsdxVVWnygJ/AAF+UZuEQPM/Yh7PWa4YvOGbzPiefE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9NLxVKUkdqjZcJMpXMHnaU30qKKj0yrU9ioqR5F4hMEEL6raFG+sRcMIZ5B8gPNI3SGdtvY6xPBaTEt4ZLXYXd8oD0eGNemIcI7ozJ3b3JQpVMqPa9AcF1e6xKWEDiLXRIq3uVkfjQMhP735e6G2HamR0HnLpaRV75eZfgG59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO/QcYV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO/QcYV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4030C4CEE4;
	Sat, 29 Mar 2025 00:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743208787;
	bh=HDsdxVVWnygJ/AAF+UZuEQPM/Yh7PWa4YvOGbzPiefE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uO/QcYV+BvYIqwDJGhHXUH7Oibmy72fLxqbE3VHGOmg0aDkO0HRzgE91QpmPBPYBH
	 G/qeBCxG2V0bXZ794m++C8VofBw/ti9VkUiko7RG0+VwMJFAIhhsJmPamhru9rKcDx
	 16HVMnKEDxYYzGr0IUEUH/ttpB25iihxfnrhKH7jCpz2PjKM/wefphZDIoqX/5CGBw
	 +vd41By/MG+3V86Di/NrNpj6ur4DbEu2Mwq3GgD1uTD8fxDhqR0q1BkPGkgj693Cle
	 rDnIckz/a59dGLEAv8kc2PvHzcxLygdxwvcCYNRkvu9RDIH+h6Tu/epixkjXIIv3E+
	 0uAylJ1Qi2/Gw==
Date: Fri, 28 Mar 2025 17:39:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, dvyukov@google.com, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf report: Skip unsupported new event types
Message-ID: <Z-dBUbCqjGtMg2RS@google.com>
References: <20250328230219.826726-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250328230219.826726-1-ctshao@google.com>

Hello,

On Fri, Mar 28, 2025 at 04:01:57PM -0700, Chun-Tse Shao wrote:
> `perf report` currently halts with an error when encountering
> unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
> This patch modifies the behavior to skip these samples and continue
> processing the remaining events.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 60fb9997ea0d..d58fc1ed2fdf 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1639,8 +1639,13 @@ static s64 perf_session__process_event(struct perf_session *session,
>  	if (session->header.needs_swap)
>  		event_swap(event, evlist__sample_id_all(evlist));
>  
> -	if (event->header.type >= PERF_RECORD_HEADER_MAX)
> -		return -EINVAL;
> +	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
> +		/* This perf is outdated and does not support the latest event type. */
> +		ui__warning("Unsupported type %u, please considering update perf.\n",
> +			    event->header.type);
> +		/* Skip the supported event by returning its size. */
> +		return event->header.size;

Please make sure if the size is 8-byte aligned.

Thanks,
Namhyung


> +	}
>  
>  	events_stats__inc(&evlist->stats, event->header.type);
>  
> -- 
> 2.49.0.472.ge94155a9ec-goog
> 
