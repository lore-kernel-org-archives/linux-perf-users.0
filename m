Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E4279DAD
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380814; cv=none; b=Eq4IJD+tpT5uUgjFS4vQ62/ybpeAC2LtJnzbEsdENWsdSuLRWamITA/aibUPmsqKRvJr0n4/10gBBZDrve6SuOcR2w5wL+/QPTPTYd4DH6AiBAlQhup/swm5mfsFwCxAGp4HJ8GXCxDsVusgqIe0mYox5JDk/g7XAxUqtXMhE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380814; c=relaxed/simple;
	bh=MUAljldqPX9jJ3lOFXznFv8Z4VTrYuxsX1HxG/1KlyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ASO3Ge/Ily1qH2i0rMyph7PxRqqXkMOQPDbjL/Rn2thCo97FUNCV4wMMlSE8IBAxWD+gQnJzlYppwlPKTTqlsbPxXC3AiRf8vvnuQJIVUhC56BAiO8zPsZ0y+Y2LIIuK0llFtAxrvyTJVxxNYV4xLZhhgKK3KvolkpTgnFnNGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp66u6/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp66u6/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333121F00A3A;
	Sat, 22 Aug 2026 06:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787380813;
	bh=ACzyUi7wAKxg/BRKMXVSqY3Ll69Xdfadw6I705vhyzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lp66u6/JpFLgYUbsuMRJiWzW4ySrbHw5bFS89ful+eywg7ZryOJfsZ1e7YVscL1kD
	 6hJ5zXKxj8d9tPs3uGBWnU7xMmRQkMRnWFsvYqX3Fu99W6H89ybZ9QorBMrWiYP2HX
	 3MJUutiq/ENVW/tigQvCSu4/399VBlYjTR9Gd1vaOFJCdHG6zEO+lD893oO/VXE/U5
	 rxqsR0o0BTAHVYVJGSnhkx9BR4DmiYPsS/X8M1PW0PwTSIK215hNXSXd0remvx1y5c
	 JHAhc+cmibuGL+bhVocZ97foH/9Tc1caNxbHoFY5Z4MI/VSoLs2GfP0rmoJP3D2Mqr
	 RTfACiX8H91qw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/5] perf/trace-dat: Add trace.dat export
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822062729.882005-2-tshah@linux.ibm.com>
References: <20260822062729.882005-1-tshah@linux.ibm.com>
 <20260822062729.882005-2-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 06:40:12 +0000
Message-Id: <20260822064013.333121F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Large trace events encode their payload length incorrectly, caus=
ing alignment errors and event truncation.
- [Medium] Querying the local host system's `tracefs` for the `trace_clock`=
 during file conversion leaks host environment state into the converted tra=
ce.
--

--- Patch [1]: [RFC PATCH v4 1/5] perf/trace-dat: Add trace.dat export infr=
astructure ---
commit 162f3240dcf1a2672aa00440674197558e8f2cec
Author: Tanushree Shah <tshah@linux.ibm.com>

perf/trace-dat: Add trace.dat export infrastructure

Add new utility files util/trace-dat.c and util/trace-dat.h implementing
the infrastructure for exporting perf.data tracepoints to trace.dat format
compatible with trace-cmd and KernelShark.

> diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
> index 0000000000000..55a7bd982c6f8
> --- /dev/null
> +++ b/tools/perf/util/trace-dat.c
[ ... ]
> +static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long lon=
g *file_offset_out)
> +{
[ ... ]
> +		memcpy(data_rec, &hdr_word, TRACE_DAT_WORD_SIZE);
> +
> +		/* Large events: write actual byte length after header */
> +		if (type_len =3D=3D 0)
> +			memcpy(data_rec + TRACE_DAT_WORD_SIZE, &data_len, TRACE_DAT_WORD_SIZE=
);

[Severity: Medium]
When writing large events (where type_len =3D=3D 0), is `data_len` the corr=
ect
value to write here? Ftrace ring buffer parsers typically expect this field
to contain the size of the payload plus the 4-byte size field itself,
properly padded to 4-byte alignment, rather than just the raw event size.
Could this lead to event truncation or alignment errors when parsing?

[ ... ]
> +int trace_dat__write_options_section1(void)
> +{
[ ... ]
> +	/* TRACECLOCK option */
> +	opt_id =3D TRACE_DAT_OPTION_TRACECLOCK;
> +
> +	path =3D get_tracing_file("trace_clock");
> +	if (path) {
> +		clock_file =3D fopen(path, "r");
> +		put_tracing_file(path);
> +	} else {
> +		clock_file =3D NULL;
> +	}

[Severity: Medium]
Does querying the host system's tracefs mount here break cross-platform
analysis? Since this is an offline conversion of a perf.data file, the host
machine's current trace clock might not match the clock used when the trace
was originally recorded. Should this extract the clock from the perf_env
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822062729.8820=
05-1-tshah@linux.ibm.com?part=3D1
