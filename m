Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC7245019
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990633; cv=none; b=gfCqDOI1Utrk5FNZAS5WxCxwBqO0PETJnByff/Sp8ehuwH+s8Jh3SQCFzje79czHx9jD11LLHnv2bA8R/C89Mx1RNLWK4DSEmRwkEcFhnAnqxYFAvT8dZsz2EGKpChHSiuvezP3+7ULTMH/qyWMqZ8VKNLP1Uraws2GgVfeBOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990633; c=relaxed/simple;
	bh=ynCE+4PmCoa5m7Wv4AEpvCHYQjiZlnJnDcYMRfa0ZG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uFFk46nPOJHTDxSiO9vPe5nJUufZDJpseCobcxImlTmU1QaVX7oDhlXLT0wRX9U5NChlt+44ZlPlu1pTmU1qCp1CmClL3WxJyhIK6Zx7i94DDaXBN6z8GAf2C3MhgaxpBIbsoPvTlQ72dL8SNOwONnyoev9Klq6u613zesGb9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCPliskN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCPliskN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709741F000E9;
	Tue, 14 Jul 2026 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783990631;
	bh=jr3YBLrlyDZWiRGH2BtylokWCKVa7gVPz5Z70Af+n5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCPliskNuIZA8FSnGj+X9IExN/gDVrVVKwxsDIva7aAqfASNZ56qiLF24qScRpxtx
	 gTQqsKD5fRdgGNw5DerD2WTZAXrEjnE5N2X/ew0zvhE36O5h/6sOjb7ndqVq7K2uUu
	 Ihv6iRXegQVfFPEw2YlPV/LOM6+Zrz48jrKvERjXM3fo3m5DuAmwhIWhpqjc/n0MJX
	 k5EK8t5pA8sc/GJ8RKGUrqxxNSMyqZDJ6+mKjYXIsZw9sqZYMDMBKT6QsQGRjwm2kX
	 V2wil0bRxBKT0YmAHRtS+urxDOmH+wdyWdQI7SMz3vwEvCykB2/olzi1pHZpINz0hj
	 ouIhz1faaa5wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714004359.179451-7-thomas.falcon@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:57:11 +0000
Message-Id: <20260714005711.709741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The perf c2c tool structure omits the `.feature` callback, break=
ing `perf_env` initialization in pipe mode.
- [Low] Implicit reliance on POSIX libc headers violates musl build compati=
bility rules (missing `<stdio.h>`).
--

--- Patch [6]: [PATCH v2 6/6] perf c2c: print memory region data with stdio=
 output ---
commit 210b29f2c6ae9c7cc910fd9994d1e0b92078eec2
Author: Thomas Falcon <thomas.falcon@intel.com>

    perf c2c: print memory region data with stdio output
   =20
    Print memory range data in perf-c2c subcommand. Only available in stdio
    mode currently. If memory ranges are not supported or present, print
    nothing.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index cba2e9f21ae7c..68348a93bd331 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2634,6 +2634,34 @@ static void print_c2c_info(FILE *out, struct perf_=
session *session)
>  	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
>  }
> =20
> +
> +static void print_memory_ranges_info(FILE *out, struct perf_session *ses=
sion)
> +{

[Severity: Low]
Does this code rely on implicit header inclusion?

The new print_memory_ranges_info() function uses FILE and fprintf, but the
patch doesn't explicitly include <stdio.h>. Can this cause the code to fail=
 to
compile under musl libc due to missing declarations?

> +	struct perf_env *env =3D perf_session__env(session);
> +	int nr_ranges =3D 0;
> +
> +	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
> +		return;
> +	nr_ranges =3D env->nr_memory_ranges;
> +	if (nr_ranges =3D=3D 0) {
> +		pr_debug("No memory ranges found, skipping\n");
> +		return;
> +	}
> +
> +	fprintf(out, "\n");
> +	fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
> +	fprintf(out, "                  Memory Ranges                  \n");
> +	fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
> +
> +	for (int i =3D 0; i < nr_ranges; i++) {
> +		struct memory_range *r =3D &env->memory_ranges[i];
> +
> +		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, l=
ocal region id %u, remote region id %u\n",
> +			i, r->base, r->base + r->length - 1, r->node,
> +			r->local_region_id, r->remote_region_id);
> +	}
> +}

[Severity: Medium]
Will this silently fail to display memory ranges when perf is run in pipe
mode?

The tool initializes its callbacks in perf_c2c__report() like this:

	perf_tool__init(&c2c.tool, /*ordered_events=3D*/true);
	c2c.tool.sample		=3D process_sample_event;
	c2c.tool.mmap		=3D perf_event__process_mmap;

Because the .feature callback is missing here, feature events are dropped in
pipe mode, so perf_env is not populated with memory ranges. Although the
callback omission was pre-existing, doesn't it actively break the
functionality introduced in this patch?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714004359.1794=
51-1-thomas.falcon@intel.com?part=3D6
