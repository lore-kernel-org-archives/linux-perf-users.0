Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6A3148C5;
	Thu, 18 Jun 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803920; cv=none; b=XlOefnVTWF02X5Tuo60BhUybEthnPAykL0+pfXw0GSB79vUBPaH8P6m9fMeLLOPVm/gUufm5jVfjH/KM5xkqTqYn+Bp69tG22ApIz7bp05c9LCb3vr9p8Cnyaop+h5dhY5P/dVn8e7C68q6rzn4RbviAT0FzzRWZBI46fifqnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803920; c=relaxed/simple;
	bh=GlqgOGc7SYHZ6eVs45T0Nt1v1hPKpgy7Y/Y1CR8Z3WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqq5ZwXs58oBM8PwWBQsFtdPSth0LPosPkKEuflafM1q4RHBjfkcMzUC0Np5yV3x7A+oUpPWW3F+31nHJQvReR26FOZV2tK1HZbXsNJxpFDNtOgDXbB1zNUb/St/pfuH08IzG1bjf0ev8tqc54AFnW3GVQ6rm3std1ypaHrGLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS0g5QIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS0g5QIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B731B1F000E9;
	Thu, 18 Jun 2026 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781803919;
	bh=6jlvzYclGM3ScNb711jXCJ9OfUmO+NjoQBt7ybJiCnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QS0g5QIYIrLsZO0ra7WCuETFQshbRlqEuqM7G7RpwTbgXQe6X9P6OdSzZCPASMVjq
	 fTQM2/ap32aUDwn54pNvLF+lRy3Q6tZ4d2E1O5TzFwObLB5iT7DzZVfQzg8ZNtBAH4
	 U0xX8w3HJiKcaYblPrJ0p8CwrgqK6aRvafo7t/n+YV/XguXU5WLtp/g4LkJXn+C7It
	 q0L8YcjqlxrbbStqdqv1HaG/wELNgBCobjKmVjOS8Czd8nb8aefGBB3BmNKZETwnZX
	 HlWiIOj7L2KMz/17sF+lVi+iyWJw87F1XDk3f72x1CgRiCgvVY+TzeMIFEOmVE0Bpd
	 DmKWo4w8fCemA==
Date: Thu, 18 Jun 2026 14:31:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES v2 0/7] Initial support for some Rust tags + way to ask
 for CU merging at load time
Message-ID: <ajQrjKyBjjR1vxp6@x1>
References: <20260618151606.82747-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618151606.82747-1-acme@kernel.org>

On Thu, Jun 18, 2026 at 12:15:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
>         Here is a series with some initial support for some Rust DWARF
> tags and a way to ask for CUs to be merged just like we do for LTO to
> cope with inter CU tag references.

Sorry Namhyung, used the wrong send mail script :-\ This one should have
been sent to the pahole mailing list, doing that now.

- Arnaldo
 
>         This makes one of the regression tests to pass again as perf now
> has some rust source files and thus Rust CUs in a perf binary built with
> DWARF, which is used to test pahole's pretty printing features, where it
> uses the DWARF in a perf binary to decode perf.data records.
> 
> 	Now this is implemented as --features=force_cu_merging,
> following a suggestion from Alan, so that we can ask for this, that
> albeit not optimal is a way to handle Rust and other cases that may need
> this CU merging approach while we don't have something that works in
> parallel as without this option.
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (7):
>   dwarf_loader: Initial support for DW_TAG_variant_part
>   dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag
>     references
>   dwarf_loader: Initial support for DW_TAG_subprogram in
>     DW_TAG_enumeration
>   encoders: Fix diagnostic messages for unexpected tags in enumerations
>   dwarves_fprintf: Accumulate function__fprintf return value in
>     enumeration printing
>   dwarves: Use tag__delete for enumeration children
>   btf_encoder: Remove unused variables
> 
>  btf_encoder.c               | 17 ++++++----
>  ctf_encoder.c               | 16 ++++++---
>  dwarf_loader.c              | 67 +++++++++++++++++++++++++++++++------
>  dwarves.c                   | 35 +++++++++++++++----
>  dwarves.h                   | 19 ++++++++++-
>  dwarves_emit.c              | 10 +++---
>  dwarves_fprintf.c           | 44 +++++++++++++++++-------
>  man-pages/pahole.1          | 17 ++++++++--
>  pahole.c                    | 20 ++++++++---
>  tests/prettify_perf.data.sh |  4 +--
>  10 files changed, 195 insertions(+), 54 deletions(-)
> 
> -- 
> 2.54.0
