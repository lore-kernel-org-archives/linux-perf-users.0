Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FA33C5;
	Mon, 12 Aug 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469448; cv=none; b=ZMOhXegiMPNX67pEHCbkOB+XtmtFOfkQ7ysUidGaVELqbODIOHaa1yb/7LS2CH/8+whgICuEKUk51Rc4sFkMOA2rD+avy8GFm6dHzLt65qWrdUtJSVeYdArCRJFM2Vruv6elnP7m6ceWYKBg9dHoR3grSYYMHeBEVVRVj0P8gS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469448; c=relaxed/simple;
	bh=OJQQgwlsPZ6iolgnL+6Oe7gq/bg2vyI9hu1xOqlu6q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/FRubDWs81KgoDh+PHbcszcYjytZgJLr8VkGroEvGrQfeNEeZCL09bsVIx/9Q0IppvsrWTVpeTN2KnlchoNJ4W0GRqmPTI58KE7BM4vMsEXIHzD+s65g9NOYWIWaeMoFqURLgol6fYcmgfvge4Srm1ckcfH6qCVhrCXI9fdhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIMHr34K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIMHr34K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578A6C32782;
	Mon, 12 Aug 2024 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723469447;
	bh=OJQQgwlsPZ6iolgnL+6Oe7gq/bg2vyI9hu1xOqlu6q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIMHr34K8u3yVIWPa7Yi4docrq4wmJoJaqNrU9JDRj/f+54SxZsj1qFZYPcPICG9r
	 3UDpj51+XvAfnRAkjt4TY59OolZ0SApTYw/IQgYL8XMEo+6TlLs+yOK/OaD7SAU9+U
	 ejooodO/Uxf5qfcO0wXf4SkVlu+ifIel1/p1DjMhzvgyRGOT+J0mcijXyQOoM3QobL
	 AeRRABLb9ueLcCewz1wIM8qPVQqcCrGfG+c1CCRgroT9aNNR2qGfRDrRA/7984irsn
	 UOgH6NqSp2bD/BupGiqlmkVQW6+sK8G9hmHN0cQ/gn++4HATyQn77cyHxxDPOllw1l
	 kNUH+6+nRlxaA==
Date: Mon, 12 Aug 2024 10:30:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf docs: Refine the description for the buffer size
Message-ID: <ZroOhMIKF0OkmoaY@x1>
References: <20240812093459.2575278-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812093459.2575278-1-leo.yan@arm.com>

On Mon, Aug 12, 2024 at 10:34:59AM +0100, Leo Yan wrote:
> Current description for the AUX trace buffer size is misleading. When a
> user specifies the option '-m,512M', it represents a size value in bytes
> (512MiB) but not 512M pages (512M x 4KiB regard to a page of 4KiB).
> 
> Make the document clear that the normal buffer and the AUX tracing
> buffer share the same semantics. Syncs the documents for consistent
> text.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> ---
> 
> Changes from v1:
>  Synced for all documents for consistent description (James)

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
 
>  tools/perf/Documentation/perf-kvm.txt    | 6 +++---
>  tools/perf/Documentation/perf-record.txt | 9 +++++----
>  tools/perf/Documentation/perf-top.txt    | 4 ++--
>  tools/perf/Documentation/perf-trace.txt  | 4 ++--
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
> index b66be66fe836..c26524d38f47 100644
> --- a/tools/perf/Documentation/perf-kvm.txt
> +++ b/tools/perf/Documentation/perf-kvm.txt
> @@ -115,9 +115,9 @@ STAT LIVE OPTIONS
>  
>  -m::
>  --mmap-pages=::
> -    Number of mmap data pages (must be a power of two) or size
> -    specification with appended unit character - B/K/M/G. The
> -    size is rounded up to have nearest pages power of two value.
> +        Number of mmap data pages (must be a power of two) or size
> +        specification in bytes with appended unit character - B/K/M/G.
> +        The size is rounded up to the nearest power-of-two page value.
>  
>  -a::
>  --all-cpus::
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 41e36b4dc765..242223240a08 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -273,10 +273,11 @@ OPTIONS
>  -m::
>  --mmap-pages=::
>  	Number of mmap data pages (must be a power of two) or size
> -	specification with appended unit character - B/K/M/G. The
> -	size is rounded up to have nearest pages power of two value.
> -	Also, by adding a comma, the number of mmap pages for AUX
> -	area tracing can be specified.
> +	specification in bytes with appended unit character - B/K/M/G.
> +	The size is rounded up to the nearest power-of-two page value.
> +	By adding a comma, an additional parameter with the same
> +	semantics used for the normal mmap areas can be specified for
> +	AUX tracing area.
>  
>  -g::
>  	Enables call-graph (stack chain/backtrace) recording for both
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 667e5102075e..af3e4230c72f 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -83,8 +83,8 @@ Default is to monitor all CPUS.
>  -m <pages>::
>  --mmap-pages=<pages>::
>  	Number of mmap data pages (must be a power of two) or size
> -	specification with appended unit character - B/K/M/G. The
> -	size is rounded up to have nearest pages power of two value.
> +	specification in bytes with appended unit character - B/K/M/G.
> +	The size is rounded up to the nearest power-of-two page value.
>  
>  -p <pid>::
>  --pid=<pid>::
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index f0da8cf63e9a..6e0cc50bbc13 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -106,8 +106,8 @@ filter out the startup phase of the program, which is often very different.
>  -m::
>  --mmap-pages=::
>  	Number of mmap data pages (must be a power of two) or size
> -	specification with appended unit character - B/K/M/G. The
> -	size is rounded up to have nearest pages power of two value.
> +	specification in bytes with appended unit character - B/K/M/G.
> +	The size is rounded up to the nearest power-of-two page value.
>  
>  -C::
>  --cpu::
> -- 
> 2.34.1
