Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BA1A2643;
	Thu, 10 Oct 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573666; cv=none; b=RP8tBI0PgaWSmrm89+SArAGQgLbIwg1mlDNRTtU8W3naGjvAL7z2U6CziXkbe1ODFrSJqi4nHYVIlsSd51mwZR+tPInIFrCXko0LUkROqR5+ToCojkjqDOKG+IqA3CeumZiTlmilqP7Fh5P+bk+WNszn9t0Xaa2SMh5jNmAtH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573666; c=relaxed/simple;
	bh=iQTO2xXg6kkK7go7IHXW64YkSWbqkfOn1Un0kAiicpk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SpUn9GG2jXXq5iLwNpFrszWvv+B0xrtssdhVyr+bnqsuLt5GTcuClFSip2fiPAJxUUiPsvCmPMzJWITBU67R2FaCKQLawcJR7qwn8gZaSOWohABU1D7K+vUbwyafdD7ykUYGwFEq+/gmEj4oEPb4qalgLEFmQX4d6E7409WuKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQd1u0qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQd1u0qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1656C4CEC5;
	Thu, 10 Oct 2024 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728573665;
	bh=iQTO2xXg6kkK7go7IHXW64YkSWbqkfOn1Un0kAiicpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HQd1u0qimlvNhJ3xuDSmoXI47XmjGNxRtauEHbVTGm4H+bjDzgvdySr75nN2HgmDq
	 XoPoaSasOGmiuZ6kxYxui9InjmAGWis4QoO9XvAwRWQDDhvCNPlDuv8icmFwM3sXGS
	 twTZnW6+mNsCzBGEwlBQKGUckYPd/c8CZz1XEG05N/lACjc6pa7wNoJByXV62sljmX
	 TxzRM437+nIFqSjqVtLhWdqVZSZOPboUl5lbMu5eL+CuGgiG/NR7bFpL8T8Th3q7LE
	 UNBQ2835gxE0+cNUfVTiJcp/JHig1LWVveuJHQRqmpwyT5YAmSsyUG6YiylJFPN+cm
	 aTWJpxOdWurLg==
Date: Fri, 11 Oct 2024 00:21:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Dima
 Kogan <dima@secretsauce.net>, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf: Dynamically allocate buffer for event
 string
Message-Id: <20241011002100.e0393340f950e2dc47c76f14@kernel.org>
In-Reply-To: <20241007141116.882450-2-leo.yan@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
	<20241007141116.882450-2-leo.yan@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 15:11:14 +0100
Leo Yan <leo.yan@arm.com> wrote:

> Dynamically allocate and free buffer to support event name.

Sorry, but I don't see any benefit from this patch. This looks making
code more complex.

Thank you,

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-event.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index a17c9b8a7a79..cad11d95af4f 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2834,6 +2834,9 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
>  	free(buf);
>  }
>  
> +/* Defined in kernel/trace/trace.h */
> +#define MAX_EVENT_NAME_LEN	64
> +
>  /* Set new name from original perf_probe_event and namelist */
>  static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  				       struct perf_probe_event *pev,
> @@ -2841,9 +2844,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  				       bool allow_suffix)
>  {
>  	const char *event, *group;
> -	char buf[64];
> +	char *buf;
>  	int ret;
>  
> +	buf = malloc(MAX_EVENT_NAME_LEN);
> +	if (!buf)
> +		return -ENOMEM;
> +
>  	/* If probe_event or trace_event already have the name, reuse it */
>  	if (pev->event && !pev->sdt)
>  		event = pev->event;
> @@ -2866,17 +2873,19 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  		group = PERFPROBE_GROUP;
>  
>  	/* Get an unused new event name */
> -	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
> +	ret = get_new_event_name(buf, MAX_EVENT_NAME_LEN, event, namelist,
>  				 tev->point.retprobe, allow_suffix);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	event = buf;
>  
>  	tev->event = strdup(event);
>  	tev->group = strdup(group);
> -	if (tev->event == NULL || tev->group == NULL)
> -		return -ENOMEM;
> +	if (tev->event == NULL || tev->group == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	/*
>  	 * Add new event name to namelist if multiprobe event is NOT
> @@ -2885,7 +2894,10 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  	 */
>  	if (!multiprobe_event_is_supported())
>  		strlist__add(namelist, event);
> -	return 0;
> +
> +out:
> +	free(buf);
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int __open_probe_file_and_namelist(bool uprobe,
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
