Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE012FD7D3
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688389; cv=none; b=WiArJKK13/HYGA52o3CdHb+Gdp5+/jVMubYoBJz5Qf/CdxaiV8wnsPXGZnFM6fcVZ0VTG4xvGbFlOkyqCdNynDCwISOuorZKI+hl5tNK6WdCdPgW930+rAdtLZR5lb81q0vc54uX0vw7URms9UTSSBYHlsLdo435P3/e3uyyQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688389; c=relaxed/simple;
	bh=Z9sA5AD1p4e81PgCcZ5I8EelI0PYABWm5oU/mRc4xK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEWeI7RasE5YOxAl38r3aLBmkmk2fEX0XfrCBlBgbB4RhDZj1gaBAjWUpBVGOzLg9sfqJ/qXyFWibLGc4wSh1pDk1gKqTEz4QmFLtcVUXfM76yf5OcrrR8F24LAHZ0qf1qgalKBHNESIoRwQADfsVrHPyx5OHNTDjdNX1gdMblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkCxlb5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkCxlb5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B53B1F000E9;
	Fri, 14 Aug 2026 06:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786688388;
	bh=eG64mjYVSm1ydms7EB50XldY9WIE/qUIf2KOSDUwYvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gkCxlb5jDs+X/LiWbZa7w3pW4FOc1ut4sRJeO1FBgx8rVeCdlxwa0I/23R51ZWOWG
	 yCIJTOIs5NK6YpC+75A7LCuTzWnBNzPBmIfBcFU9XIudShADZWcNwydEM93BtSWC4y
	 d6M5cCSFOA/0x5+pJzvPqHOTE1EoX4dzOcwr9qeuGfmXSFh80sy7L+PEzF2XO+t798
	 WtKIKc0tbL5P/mNkSjdeEeNIazJI+MKPwhILFpwTbDaKs34Q+HizyDxx3GakQvgzCo
	 hF9Y5mcUeeRGFyQeeAAXFQv8Tmk5E17HtF894tebpM3bjxHUf2jLAxXwFS91c7G8u4
	 5PtZlsswqiYMQ==
Date: Fri, 14 Aug 2026 15:19:45 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf tools: Add support for displaying weights in
 annotate
Message-ID: <an6zgXlyzPZ_2pI-@google.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
 <20260813211109.240689-4-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813211109.240689-4-ak@linux.intel.com>

Hi Andi,

On Thu, Aug 13, 2026 at 02:10:09PM -0700, Andi Kleen wrote:
> Add support for showing all the three possible per IP weights in
> annotate. The weights are shown by defaults if any are non zero. This
> is useful, especially with the new insn lat statistics, but also
> for all the existing weights.
> 
> Add a hotkey to the interactive browser to turn them off (w), as well
> as a perf annotate command line option.
> 
> The weights are stored unconditionally in the sym_hist_entry, which
> will increase memory consumption somewhat.
> 
> Assisted-by: omp:GPT-5.6-Luna
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-annotate.txt |   3 +
>  tools/perf/builtin-annotate.c              |   3 +
>  tools/perf/builtin-report.c                |   1 +
>  tools/perf/ui/browsers/annotate.c          |  17 ++-
>  tools/perf/util/annotate.c                 | 117 ++++++++++++++++++---
>  tools/perf/util/annotate.h                 |  32 +++++-
>  tools/perf/util/symbol.c                   |   1 +
>  tools/perf/util/symbol_conf.h              |  17 ++-
>  8 files changed, 170 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index a688738809c4..50c6ea680d0d 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -79,6 +79,9 @@ include::itrace.txt[]
>  
>  --stdio:: Use the stdio interface.
>  
> +--no-weights:: Hide weight columns in annotation output. By default, weight columns
> +	are shown when samples contain non-zero weights.
> +
>  --stdio2:: Use the stdio2 interface, non-interactive, uses the TUI formatting.
>  
>  --stdio-color=<mode>::
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 69cb72b2082a..c6c481145e45 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -259,6 +259,7 @@ static int add_sample(struct perf_sample *sample,
>  		return 0;
>  	}
>  
> +
>  	/*
>  	 * XXX filtered samples can still have branch entries pointing into our
>  	 * symbol and are missed.
> @@ -719,6 +720,8 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
>  #endif
>  	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
> +	OPT_BOOLEAN(0, "no-weights", &symbol_conf.hide_weight,
> +		    "Hide weight columns in annotation"),

Can it be just "weights"?  Then we would get --no-weights for free. :)
Of course, the help message needs to say differently.

Thanks,
Namhyung


>  	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
>  	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
>                      "don't load vmlinux even if found"),
