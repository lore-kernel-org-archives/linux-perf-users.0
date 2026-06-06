Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780640855
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780759914; cv=none; b=t61K+prcEymdKc+tdNi4ZV+2Pop9dpU0uC0rLQDMYCiuJrBeGOiQPFUKlLH7FYIOLaez8tV1RC1pSn3pbICMw8a9YFKo8E1nlFphh89Iq2g1GpEf5ROGFazzWvP+GN9PDgSnfeEkrhEkLh3l+VHfQhWJumUhNiGPkOhylpYvUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780759914; c=relaxed/simple;
	bh=iAR7MzWYVqsAXUiXYiSKbxLKffKSU/yredlEvtY639c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCUNxbONLCbGZpLspYnUZLotC+a8UHGembtvP94DXvmoTXCD/uYQbvrSkxBmGmksTyKqhBJf7LvJAp97OBwvtPN3vh4/p2QTWUGfIs+M6gBgRc83fWOgPzGvbN92vkEN2KYCdVqr8VvXzAf65T5lXfOmFLVXDD2M97AA+tBiV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYM0uALR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYM0uALR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB5F1F00893;
	Sat,  6 Jun 2026 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780759913;
	bh=0YqkkjgG6ttobYszA55yjyvGj5xErFMB2ipZSI2NP7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RYM0uALRT4E47ysgoKgrcyngKLBYmR1Pv1XgZVnle2RNCB4OWRff+Kp1yd9oUbMqt
	 9jQQWKj32DLOOsx4DXfM2JSbqEkKjcJxmmE6HhAXdP2PWEJHxMA0RuhAnawJ3pAYBf
	 PjUoymyWuefThd7+fJv6MuUaV1MPmI/KlPqLeCNx8afu/pJFfUOBtl32oUGTR37y0S
	 B+KLv/Thn8J4OLNFvmjCz3QdUjBv7cW7JHMYv8JYxAe3tLV/GXKLhZwe4e5ed25kjd
	 hp8E4isfyfEnsZUhnzSfQlZiElMHl5G3F3RSl5x48Q3p5blUcIwLM9vPysZ9QplO+2
	 V1xBg5dKO0MIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606151451.2913860-3-irogers@google.com>
References: <20260606151451.2913860-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:31:52 +0000
Message-Id: <20260606153153.5AB5F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The attribute size check incorrectly uses `event->header.size` ins=
tead of `attr.size`, potentially overwriting the `id` array.
- [Medium] The ASLR tool's isolated `machines` collection lacks a `perf_env=
` pointer, forcing kernel space mapping to silently fall back to the host's=
 compilation architecture bitness.
--

commit 77ff517ae16085496a64df04678110167f79e9c4
Author: Ian Rogers <irogers@google.com>
Subject: perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

This patch introduces the core ASLR remapping tool infrastructure and
implements remapping/tracking for metadata events. It adds an aslr option
for perf inject that remaps all virtual addresses to prevent virtual address
information leakage when sharing perf.data files.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -242,8 +245,43 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
[ ... ]
> +			if (stripped_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT &&
> +			    event->header.size >=3D (offsetof(struct perf_record_header_attr,
> +							    attr.bp_addr) + sizeof(u64))) {
> +				stripped_event->attr.attr.bp_addr =3D 0;
> +			} else if (stripped_event->attr.attr.type >=3D PERF_TYPE_MAX) {
> +				struct perf_pmu *pmu;
> +
> +				pmu =3D perf_pmus__find_by_type(stripped_event->attr.attr.type);
> +				if (pmu && (!strcmp(pmu->name, "kprobe") ||
> +					    !strcmp(pmu->name, "uprobe"))) {
> +					if (event->header.size >=3D
> +					    (offsetof(struct perf_record_header_attr,
> +						      attr.config1) + sizeof(u64)))
> +						stripped_event->attr.attr.config1 =3D 0;
> +					if (event->header.size >=3D
> +					    (offsetof(struct perf_record_header_attr,
> +						      attr.config2) + sizeof(u64)))
> +						stripped_event->attr.attr.config2 =3D 0;
> +				}
> +			}

[Severity: High]
Does this incorrectly check event->header.size instead of the actual
attr.size?

If an older perf.data file is processed with a shorter ABI struct (such as =
the
64-byte PERF_ATTR_SIZE_VER0) and contains appended IDs, this boundary check
would pass because the total event size exceeds the offset.

Could this cause the assignment to config1 or config2 to overwrite the lead=
ing
elements of the appended id[] array with zeroes, permanently corrupting the
event ID stream?

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static void aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *de=
legate)
> +{
> +	delegate_tool__init(&aslr->tool, delegate);
> +	aslr->tool.tool.ordered_events =3D true;
> +
> +	machines__init(&aslr->machines);
[ ... ]
> +static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
[ ... ]
> +	} else {
> +		/* First address of the process, allocate key and first top address. */
> +		struct top_addresses_key *tk;
> +		struct process_top_address *top_val;
> +		struct machine *machine =3D remap_key.machine;
> +		struct perf_env *env =3D machine ? machine->env : NULL;
> +		bool is_64 =3D env ? perf_env__kernel_is_64_bit(env) : (sizeof(void *)=
 =3D=3D 8);

[Severity: Medium]
Because machines__init() creates an isolated collection of machines without
linking its host environment to the primary session's environment, will env
always resolve to NULL here?

If env is NULL, this falls back to the executing host's pointer size
(sizeof(void *) =3D=3D 8) rather than the recorded target architecture.

Will this break cross-platform analysis when analyzing a 32-bit perf.data f=
ile
on a 64-bit host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606151451.2913=
860-1-irogers@google.com?part=3D2
