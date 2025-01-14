Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1017BB0D;
	Tue, 14 Jan 2025 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736819498; cv=none; b=tNUilDVLOGyEwNNcWpeqpX4ClFet4zeVSnwYU+oydzW+NH4pvNjO/OSuMILa5etpjTskoQYGHe0cwa25EFzQGFD+MulTlt/cvJd5cLT+NghT54w09NX3mubNTyYbJXl8dBbuvu0/qnpOmK1qkqHvyamMNbl/1nMIWW/jJ7P1HkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736819498; c=relaxed/simple;
	bh=iaEfGaw6sVXXOKHqLwqddih7cnhOnqJllh5Iy4wzkp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFmwFlArWLcJj6st6Mquo1vTQH/9wk74QkoGOXiP9avfyiCbIi3aP4PXEmwg4in5Oh+CSFP+QMAdrYNvlxvZ+GPmt7dYGRl91FElB6yU5KduHMKLb4tRY0Z/gsWFqQAUVpIS6HoCLu/vGDDV1SNL4BWLsZ20qaozNOVX/yvhEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCOT4RSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCOT4RSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343E7C4CEE4;
	Tue, 14 Jan 2025 01:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736819497;
	bh=iaEfGaw6sVXXOKHqLwqddih7cnhOnqJllh5Iy4wzkp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCOT4RSgvG4man+zhvZKjcTpcuvhfnaTyB6Ek5D1Vy1wrwL+h4a18XqFswBNkJrXa
	 ncxt5DRLrcGN8BgFhcldD+H2Ycp84iAvD7P6I1NJQy3srorL2pR494BMVzGupgUbPr
	 6GRgkAOxNY91/BnRwaMbkfdhwFcQgCZsrsJveFgf5briN4DWLrGHbdAQDeLMwODwK6
	 IwRR+ZzZBoL1yjKWBjC8CoCR4z/oVewnD1hrIXD6S5ymH0pyhVlcfx9YyhV85DYTKE
	 CAlpNtIAe9ILatXCsDuqFdJkT8IW+gWacJZi8BRdQuENbT2E/kB/ZXdl7pFfDn9gUb
	 6OSaoSM2uaBUg==
Date: Mon, 13 Jan 2025 17:51:35 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
Message-ID: <Z4XDJyvjiie3howF@google.com>
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113134022.2545894-1-dvyukov@google.com>

Hello,

On Mon, Jan 13, 2025 at 02:40:06PM +0100, Dmitry Vyukov wrote:
> There are two notions of time: wall-clock time and CPU time.
> For a single-threaded program, or a program running on a single-core
> machine, these notions are the same. However, for a multi-threaded/
> multi-process program running on a multi-core machine, these notions are
> significantly different. Each second of wall-clock time we have
> number-of-cores seconds of CPU time.
> 
> Currently perf only allows to profile CPU time. Perf (and all other
> existing profilers to the be best of my knowledge) does not allow to
> profile wall-clock time.
> 
> Optimizing CPU overhead is useful to improve 'throughput', while
> optimizing wall-clock overhead is useful to improve 'latency'.
> These profiles are complementary and are not interchangeable.
> Examples of where wall-clock profile is needed:
>  - optimzing build latency
>  - optimizing server request latency
>  - optimizing ML training/inference latency
>  - optimizing running time of any command line program
> 
> CPU profile is useless for these use cases at best (if a user understands
> the difference), or misleading at worst (if a user tries to use a wrong
> profile for a job).
> 
> This patch adds wall-clock and parallelization profiling.
> See the added documentation and flags descriptions for details.
> 
> Brief outline of the implementation:
>  - add context switch collection during record
>  - calculate number of threads running on CPUs (parallelism level)
>    during report
>  - divide each sample weight by the parallelism level
> This effectively models that we were taking 1 sample per unit of
> wall-clock time.

Thanks for working on this, very interesting!

But I guess this implementation depends on cpu-cycles event and single
target process.  Do you think if it'd work for system-wide profiling?
How do you define wall-clock overhead if the event counts something
different (like the number of L3 cache-misses)?

Also I'm not sure about the impact of context switch events which could
generate a lot of records that may end up with losing some of them.  And
in that case the parallelism tracking would break.

> 
> The feature is added on an equal footing with the existing CPU profiling
> rather than a separate mode enabled with special flags. The reasoning is
> that users may not understand the problem and the meaning of numbers they
> are seeing in the first place, so won't even realize that they may need
> to be looking for some different profiling mode. When they are presented
> with 2 sets of different numbers, they should start asking questions.

I understand your point but I think it has some limitation so maybe it's
better to put in a separate mode with special flags.

Thanks,
Namhyung
