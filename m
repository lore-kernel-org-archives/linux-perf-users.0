Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE9383A5;
	Mon, 30 Sep 2024 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727673922; cv=none; b=Nls/T2KH2So54A4LT74Wl+25RZIbJgN0LV1ZjiM75ElYoyy01m7ZoQpEvVrJnnR4jUl2hmzY9Aq1VRzOnkUXnMdqQC8qfF89hsu49VG9uCTPckAWxnwyzQL807oFJX4jZ7lcAMwdPtGdRZpMgwRlX1ePEKwiiEPFAQyEtjZ1CLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727673922; c=relaxed/simple;
	bh=imzARbgxmAoMCo8ItlsHwAYnltYA+M0UizbbP29H5XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAI1E04R/nc+aGgAQmwvhJQeG7+CUpQ6aVQ02eiw923mP2/OUhX9ArulO9POaPLzS/M4P9t91yTBSGUe9I6ZRtmkvAHqM4xxfkQV6KPjG4Rf+2RoM2gyYON0EbXncQLfOnaqDG8dgOxwgqemoOdjpASbojZjH9ULpVlzH5pBqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZE2pX3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZE2pX3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE63C4CECE;
	Mon, 30 Sep 2024 05:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727673921;
	bh=imzARbgxmAoMCo8ItlsHwAYnltYA+M0UizbbP29H5XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZE2pX3Dl8+tCS2t83tZqqXWK6ycAAVI0pbYmZuAEOeKhkNIg3sFhkJDRppyfR/h4
	 Ypo4KAz2nbZQrYEkO7gq7LJ7RQn69pydOwWeUhoGNGtlf84Rbta3n74He5vLUbNb5F
	 IOf6+VuOaJqR7Kr5C0A8BQqObrEPwDpywVMajMCqaT11KP07Ei9CHraMyVCDSF+hGB
	 eQ64dnq/W0UlGxk/IhijO0C95AeTyDFXQ4Ua39UqDeCHnU21+hvJAT0lpbewSqLU4h
	 0s83IWGbz1hZdauVsySOWlgcB/UgOJ2nubzxHkTiEm7aFMaduea2oRGJscJwqtz1jP
	 zzKcyV2+6X7rw==
Date: Sun, 29 Sep 2024 22:25:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: linux@treblig.org
Cc: irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf: Remove unused add_perf_probe_events
Message-ID: <Zvo2PxCFp5M1JTND@google.com>
References: <20240929010659.430208-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240929010659.430208-1-linux@treblig.org>

Adding Masami to CC.

On Sun, Sep 29, 2024 at 02:06:59AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> add_perf_probe_events has been unused since 2015's commit
> b02137cc6550 ("perf probe: Move print logic into cmd_probe()")
> which confusingly now uses perf_add_probe_events.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  tools/perf/util/probe-event.c | 18 ------------------
>  tools/perf/util/probe-event.h |  1 -
>  2 files changed, 19 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index a17c9b8a7a79..698a92875374 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -3705,24 +3705,6 @@ void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs)
>  	}
>  }
>  
> -int add_perf_probe_events(struct perf_probe_event *pevs, int npevs)
> -{
> -	int ret;
> -
> -	ret = init_probe_symbol_maps(pevs->uprobes);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = convert_perf_probe_events(pevs, npevs);
> -	if (ret == 0)
> -		ret = apply_perf_probe_events(pevs, npevs);
> -
> -	cleanup_perf_probe_events(pevs, npevs);
> -
> -	exit_probe_symbol_maps();
> -	return ret;
> -}
> -
>  int del_perf_probe_events(struct strfilter *filter)
>  {
>  	int ret, ret2, ufd = -1, kfd = -1;
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 7e3b6c3d1f74..4850e52f274e 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -159,7 +159,6 @@ void line_range__clear(struct line_range *lr);
>  /* Initialize line range */
>  int line_range__init(struct line_range *lr);
>  
> -int add_perf_probe_events(struct perf_probe_event *pevs, int npevs);
>  int convert_perf_probe_events(struct perf_probe_event *pevs, int npevs);
>  int apply_perf_probe_events(struct perf_probe_event *pevs, int npevs);
>  int show_probe_trace_events(struct perf_probe_event *pevs, int npevs);
> -- 
> 2.46.2
> 
