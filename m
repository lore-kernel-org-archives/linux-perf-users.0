Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACE493644
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380724; cv=none; b=EDtPvskjF30oKHbtIn3gDtdNSJIP0A3dgaly4CYgYgr7qORJyhNkzxDVq84FgJSkGzQGGmCSfYFgFpWWGMw2wm+ZRQlN5fQm+iz8aZlFLPE3N4qk3cV3sGrmfHANSmY/IB6iLmTZo65DzCrqM3f0MXD330DcDoPq3ZjSINaTB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380724; c=relaxed/simple;
	bh=BdY1dExn2MH6ztPiP/s3sMRXA/pM2mXBxAXHmYTHCRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dpj1uex4DQ5y9jit6TCgOZC4r6U1ugDNNyDG3KqtX6fJWUvlDlvKueky+mvcOUi0Xgyoyx1uGsGtPP/r0hBmNtqu0rT3ib25JWjrt5333yhKY3RH1CmMNxcqTINngSLbsnCdJdZ9WyDbF7y5BP7si9FFbgA1FHffhD2L23kgXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYvVm1ju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYvVm1ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640C51F000E9;
	Sat, 22 Aug 2026 06:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787380722;
	bh=HLiwGpRG1R0WlXoWFeKhUrjTdKj0n1WsQrkD6pyUAJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYvVm1juGdP80spIVlhvuFn5aIVC/AlMm28oL283CYiVPRaAzIdRTSpmZwO533sx4
	 FzGSu4wd4+C9TFqvzD5zpboCY1+dXX9raV+5JnG4syVyiK7gpc3+n0ep4t9EXhaTrB
	 0xlE8y8XWVS3Pv0+DzPb1kpMmsmU4CYSuXmB5OI4MGiczaO7QrLzMUbqpemcmOrK8t
	 EqI+uvDgbZwQtPx2mGu8kTnkov0L8MRnY84RCyD7kselxsbpFWTOx9z5G+8/Jd35aG
	 /3KfMluGgok/VV52WIpHr/7Qch4D3v32ZpyXPjJLGYuKr/1lt7GFxB/kIrjY7AFx+g
	 ZlDnk6TAGDVUA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/5] perf data-convert: Add perf.data to
 trace.dat conversion backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822062729.882005-4-tshah@linux.ibm.com>
References: <20260822062729.882005-1-tshah@linux.ibm.com>
 <20260822062729.882005-4-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 06:38:42 +0000
Message-Id: <20260822063842.640C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Arbitrary file truncation and TOCTOU vulnerability via symlink in =
the `--force` path.
- [Medium] Directly accessing `perf_env` field without verifying initializa=
tion.
- [Low] Missing feature fallback stub for `trace_convert__perf2dat` in `dat=
a-convert.h`.
- [Low] Lost error code when `fopen()` fails in the `--force` path.
--

--- Patch [3]: [RFC PATCH v4 3/5] perf data-convert: Add perf.data to trace=
.dat conversion backend ---
commit aaf748bbf23e74fad4be33c3834c0413e8def0f8
Author: Tanushree Shah <tshah@linux.ibm.com>

perf data-convert: Add perf.data to trace.dat conversion backend

This commit adds a new conversion backend to perf to translate tracepoint
events from perf.data into trace.dat format. It leverages a new per-CPU
buffering mechanism and implements required callbacks for pipe mode.

> diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-=
convert-trace.c
> new file mode 100644
> index 0000000000000..445479fae8884
> --- /dev/null
> +++ b/tools/perf/util/data-convert-trace.c

[ ... ]

> +	/*
> +	 * In pipe mode, CPU count and page size arrive via feature/tracing_data
> +	 * records before the first sample; initialize buffers lazily on first =
sample.
> +	 */
> +	if (!cpu_buffers_initialized) {
> +		int nr_cpus =3D trace_dat_session->header.env.nr_cpus_online;

[Severity: Medium]
Is it safe to access nr_cpus_online directly here without first verifying t=
he
environment is initialized?

The perf subsystem guidelines suggest that accessing perf_env fields without
first verifying those fields are populated can lead to bugs.=20

[ ... ]

> +	if (!opts->force) {
> +		int fd =3D open(to_trace, O_WRONLY | O_CREAT | O_EXCL, 0644);

[ ... ]

> +	} else {
> +		trace_dat_fp =3D fopen(to_trace, "wb");

[Severity: High]
Could this fopen() in the --force path be susceptible to an arbitrary file
truncation symlink attack?

If an attacker creates a symlink at the destination path, fopen() with "wb"
will follow it and truncate the target file. If the conversion subsequently
fails, the cleanup routine calls unlink(to_trace), which removes the symlink
itself. This leaves the target file truncated while hiding the attacker's
symlink from discovery.

> +		if (!trace_dat_fp) {
> +			pr_err("Failed to open output file: %s\n", to_trace);
> +			return -EINVAL;

[Severity: Low]
Should this return the actual -errno from fopen() instead of a hardcoded
-EINVAL so the exact filesystem error is not lost?

> +		}
> +	}

[ ... ]

> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-conver=
t.h
> index a96240f156712..f041c23252263 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h

[ ... ]

> +#ifdef HAVE_LIBTRACEEVENT
> +int trace_convert__perf2dat(const char *input, const char *to_trace,
> +			   struct perf_data_convert_opts *opts);
> +#endif /* HAVE_LIBTRACEEVENT */

[Severity: Low]
Does this declaration need an #else block with a compatible dummy inline st=
ub?

Without a fallback stub when HAVE_LIBTRACEEVENT is absent, callers might
be forced to clutter their code with preprocessor blocks to prevent build
failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822062729.8820=
05-1-tshah@linux.ibm.com?part=3D3
