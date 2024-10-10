Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E9B646;
	Thu, 10 Oct 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573732; cv=none; b=CLqbrOPaV7j/4+jb8UxyY4guyHeKn+80lfzVA5g1zFIzwXn2lsBTsJxbYYSAt3bpiNuRmuLbZYfxIJ1cFEh2YQndFnMRgi1zeA8i1N+vZcwk+jVpf+K4/NJQ+s7oBUeNatjSLvMfafxBz88wYY/+nV8uRl49p1iXvvq5CEBpRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573732; c=relaxed/simple;
	bh=TbuQCBi8yqP6ZJapCJwVDes4UUQTN5uMPU/g2lkkzbA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TGBrzkq/T7EvYoZp1imkHAX85VpDLXBPVpTh00Cd39no4Hm4yVf4V1QySLt9bwMIcLPn6od49G8DvlqYbq3eZMP0CG/OTLw46gg60J5ffWMiWxNt5b6cwO4xBSOThHVlqiJfZHWHIwBtcJQcjM1TZ3hJhn9sQ57RV8mRsGGxuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdv/01Fj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdv/01Fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510AAC4CEC5;
	Thu, 10 Oct 2024 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728573731;
	bh=TbuQCBi8yqP6ZJapCJwVDes4UUQTN5uMPU/g2lkkzbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zdv/01FjRjitSE8eD5INYrhD6NouyR7vQDSoxAOkU6gLmJ87+nmYPSGQ0pkFrb9Jz
	 oSTSfF0AnnvPyvY4+zhwZrZBtvE5WZQuZFnUbwSu0yKRNQmby3UN2prq2IMc8XJdXs
	 SYA4XkvOnTsGeRr/tvcFh4N3M9mPgpJFiTcchrccrFmFap9k7mtrUNWwoe6ekO26fO
	 7n+aqMwP7RMQK0Yre529Nwr9SlEL+eJlsCKlG+WFCOnxF9Yoe+Od0bsuEBxfGX/N+u
	 ntmfZosxdTAbF7/0lAoAo+3xehjJ0wzynS5iJIh+DDoPX09XL9AUjvaFoUBHesCo7u
	 e1CwDxBrGilFQ==
Date: Fri, 11 Oct 2024 00:22:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Dima
 Kogan <dima@secretsauce.net>, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf probe: Check group string length
Message-Id: <20241011002206.85960dfa895badd6136453ae@kernel.org>
In-Reply-To: <20241007141116.882450-3-leo.yan@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
	<20241007141116.882450-3-leo.yan@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 15:11:15 +0100
Leo Yan <leo.yan@arm.com> wrote:

> In the kernel, the probe group string length is limited up to
> MAX_EVENT_NAME_LEN (including the NULL terminator).

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Check for this limitation and report an error if it is exceeded.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-event.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index cad11d95af4f..71acea07cb46 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2872,6 +2872,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  	else
>  		group = PERFPROBE_GROUP;
>  
> +	if (strlen(group) >= MAX_EVENT_NAME_LEN) {
> +		pr_err("Probe group string='%s' is too long (>= %d bytes)\n",
> +			group, MAX_EVENT_NAME_LEN);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	/* Get an unused new event name */
>  	ret = get_new_event_name(buf, MAX_EVENT_NAME_LEN, event, namelist,
>  				 tev->point.retprobe, allow_suffix);
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
