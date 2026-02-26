Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E62DEA74;
	Thu, 26 Feb 2026 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088375; cv=none; b=hb9YHCt1yAHGVSJgDlSC3oh596fPFaXXM6Sypq0cLfDiG6zoE2NXb6p0JJKPste/IEkF7+MgSERZ2QecQJSv+dwtqRPPbtEjTTArGQx+9B3MjPtuHTbEc/9aIahnjosRU9VyFHVrdrYdSTbHijpnRTNtwwkOhdFjBpwv4xCMiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088375; c=relaxed/simple;
	bh=Xcv8uDI9RGWRnm2HZliIqjElH+7dIkusPNvUWdBre7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz9vFfvED6TiJHvsoBhO0IJMiL8mQK/MrJuQwbqeZ17PWYAdW/mW4h9nhyY6BWJ1ttNQB8CYetZYnwTe/hNePy8NmGGE73Bm37vt1Rp5GDPCgQvruZcTZcrcOjjh+WiAAVnvt63B7GFe0jJI8ZFdX9emH5gnstl6IpjtzPnlbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLoUJk5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLoUJk5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23A6C19422;
	Thu, 26 Feb 2026 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772088375;
	bh=Xcv8uDI9RGWRnm2HZliIqjElH+7dIkusPNvUWdBre7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLoUJk5BDuMUnpXpAwXXReyNsEh7TozxbkpYMqDIw0WhesITvBHkn0NfFUqJjwP8z
	 wRoFFiqmy//4aUClzaCSoveoNLpC/uqOKJHKsudMhoJk2dekRciPT4FonT2CyvRF0z
	 szFF+TSKwTcWbPAT4kSPFfxnlhltmuyy/Fz9LusHWKulbZ55M/mkEW2MvPiqcK+bTg
	 MqHkT4pDUo2noG0c1fPAipmvDLsEuiMauxihpcw4f+gLdc9rckeOorkX+iwDfSB4ZA
	 i2KRVKzjlXfCwuTgnf3LEjDELtduusWsVKy0GmxjpOUCo0X1hvasoQiYjd6hlnjvQZ
	 mvKi2cjSbL3Og==
Date: Wed, 25 Feb 2026 22:46:13 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Derek Foreman <derek.foreman@collabora.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] perf session: Extra logging for failed to process
 events
Message-ID: <aZ_sNRDcMI-uyi9K@z2>
References: <20260226013534.2028272-1-irogers@google.com>
 <20260226013534.2028272-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226013534.2028272-4-irogers@google.com>

On Wed, Feb 25, 2026 at 05:35:32PM -0800, Ian Rogers wrote:
> Print log information in ordered event processing so that the cause of
> finished round failing is clearer. Print the event name along with its
> number when an event isn't processed. Add extra detail about where the
> failure happened.

It'd be nice if you show messages before and after the change.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/session.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4b465abfa36c..7f3ffbe633af 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -131,10 +131,17 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>  {
>  	struct perf_session *session = container_of(oe, struct perf_session,
>  						    ordered_events);
> +	int ret =  perf_session__deliver_event(session, event->event,

Slightly unaligned.. it seems to have 2 spaces.

Thanks,
Namhyung


> +					      session->tool, event->file_offset,
> +					      event->file_path);
>  
> -	return perf_session__deliver_event(session, event->event,
> -					   session->tool, event->file_offset,
> -					   event->file_path);
> +	if (ret) {
> +		pr_err("%#" PRIx64 " [%#x]: ordered event processing failed (%d) for event of type: %s (%d)\n",
> +			event->file_offset, event->event->header.size, ret,
> +			perf_event__name(event->event->header.type),
> +			event->event->header.type);
> +	}
> +	return ret;
>  }
>  
>  struct perf_session *__perf_session__new(struct perf_data *data,
> @@ -2110,8 +2117,10 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  	}
>  
>  	if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
> -		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> -		       head, event->header.size, event->header.type);
> +		pr_err("%#" PRIx64 " [%#x]: piped event processing failed for event of type: %s (%d)\n",
> +			head, event->header.size,
> +			perf_event__name(event->header.type),
> +			event->header.type);
>  		err = -EINVAL;
>  		goto out_err;
>  	}
> @@ -2225,8 +2234,10 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  		if (size < sizeof(struct perf_event_header) ||
>  		    (skip = perf_session__process_event(session, event, decomp->file_pos,
>  							decomp->file_path)) < 0) {
> -			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> -				decomp->file_pos + decomp->head, event->header.size, event->header.type);
> +			pr_err("%#" PRIx64 " [%#x]: decompress event processing failed for event of type: %s (%d)\n",
> +				decomp->file_pos + decomp->head, event->header.size,
> +				perf_event__name(event->header.type),
> +				event->header.type);
>  			return -EINVAL;
>  		}
>  
> @@ -2382,8 +2393,9 @@ reader__read_event(struct reader *rd, struct perf_session *session,
>  	if (size < sizeof(struct perf_event_header) ||
>  	    (skip = rd->process(session, event, rd->file_pos, rd->path)) < 0) {
>  		errno = -skip;
> -		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%m]\n",
> +		pr_err("%#" PRIx64 " [%#x]: processing failed for event of type: %s (%d) [%m]\n",
>  		       rd->file_offset + rd->head, event->header.size,
> +		       perf_event__name(event->header.type),
>  		       event->header.type);
>  		err = skip;
>  		goto out;
> -- 
> 2.53.0.414.gf7e9f6c205-goog
> 
