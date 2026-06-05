Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9D4071CA
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688296; cv=none; b=g5SQXret+2ReNjTFIF2TgyBOn7zfH2Z35Y1NkAIhLNOZFQfgyosnAvSCb5dM16gkZPX5tZu4Mf2ITxsbKbI8mpzAjDnXmtkAG7mKY2VkqkGwCGh2RJ55geh5T8L/63gP8l5TlfxciEEOAi9p7k8MF76LyMpvnLVHDNWAWmWOf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688296; c=relaxed/simple;
	bh=zfglWWugoUhcIqEQ+QAxI/PSck6O6RztyI4cGCmVcgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y7pfQvQAmH1RV0Jl0/SXESFUApgKb0PqKXPhlzzwm9Net2zq+0juhHG0HBZ3XJJxI9aCjuerZ3hd1ZfD0p5v8eYkgC6sUR+eY1zFK6RMjE0+Rq+/o7x9hspo0c80JsNW0AhLHG4PWhEj/SKkEaXawjaXC/R0AO0syWhhbmYYgEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRq7PjlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRq7PjlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86AC1F00893;
	Fri,  5 Jun 2026 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688295;
	bh=p1T3W4ZiRafxTFGsqgkjJYjQtRCiaUF6u5YM8dF+yPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oRq7PjlZbJm5Narme/tLUhcRhzfWGMj9wyUusy1jt25cJoWVVNr4d5Y7q0e1awISn
	 1RHtHznF8JXJlf0talxq84RdGExPP+WWojJZWivxB//vi/r6fimVBBLfU1ZQ5nb4uY
	 vPTvJAX6gjnuMlLRivFlc7sckkorXxXJw9ZV7ya67ZrKBBRqxr//kB0vBAuHB498Vi
	 vIdEJgfhyOin9Il2xfqe+hrJb67yr+L96K5TBuV9WNcNGhBUk05qNQfHILmjNZoIS5
	 soz09dMLXTSo9YpuOv7+HZgSmC/+FIvXcLrsuoy22WW4OzujOAjdmYa15hueDE7oh4
	 ob3PmlCrzYRwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605192425.2523260-3-irogers@google.com>
References: <20260605192425.2523260-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:38:14 +0000
Message-Id: <20260605193814.B86AC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dereferencing a NULL pointer in the hashmap hash function when bui=
lt with REFCNT_CHECKING.
- [Medium] Hardcoded 64-bit kernel address breaks cross-platform analysis f=
or 32-bit architectures.
--

commit 0eb1d131e7e278ed75ab636cb567e8964c56e531
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

This patch introduces the core ASLR remapping tool infrastructure and
implements remapping/tracking for metadata events.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..ac24fda658a57
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static size_t remap_addresses__hash(long _key, void *ctx __maybe_unused)
> +{
> +	struct remap_addresses_key *key =3D (struct remap_addresses_key *)_key;
> +
> +	return (size_t)key->machine ^ (size_t)RC_CHK_ACCESS(key->dso) ^ key->in=
variant ^ key->pid;

[Severity: High]
Does this code crash when built with REFCNT_CHECKING?

In aslr_tool__findnew_mapping(), if thread__find_map() fails, the fallback
code explicitly sets remap_key.dso to NULL:

	} else {
		remap_key.dso =3D NULL;
		remap_key.invariant =3D start;
	}

When this key is passed to hashmap__find(), the hash function
remap_addresses__hash() uses RC_CHK_ACCESS(key->dso).

When perf is built with REFCNT_CHECKING (e.g., via Address Sanitizer),
RC_CHK_ACCESS(object) expands strictly to object->orig. Since key->dso is
NULL, this expands to NULL->orig, resulting in an unconditional segmentation
fault when processing unmapped or anonymous memory events.

[ ... ]
> +static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
> +				      struct thread *aslr_thread,
> +				      u8 cpumode, u64 start,
> +				      u64 len, u64 pgoff)
> +{
[ ... ]
> +	} else {
> +		/* First address of the process, allocate key and first top address. */
> +		struct top_addresses_key *tk;
> +		struct process_top_address *top_val;
> +
> +		remap_addr =3D (cpumode =3D=3D PERF_RECORD_MISC_KERNEL ||
> +			      cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL) ?
> +			     kernel_space_start : user_space_start;
> +		remap_addr =3D round_up_to_page_size(remap_addr);

[Severity: Medium]
Will this hardcoded 64-bit kernel address break cross-platform analysis for
32-bit architectures?

The code hardcodes kernel_space_start to 0xffff800010000000 and
unconditionally applies it to any mapping with a kernel cpumode.

If perf inject --aslr is run on a perf.data file collected from a 32-bit
machine, this will inject 64-bit virtual addresses into the output stream.

Downstream analysis tools expecting 32-bit address spaces based on the ELF
e_machine type might encounter out-of-bounds addresses and fail.

Should the tool dynamically determine the architecture's address space boun=
ds
via struct perf_env instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605192425.2523=
260-1-irogers@google.com?part=3D2
