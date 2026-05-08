Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C5371893
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275340; cv=none; b=ucl6RR7zepeq/ccagwsujPfLsW5o6RsJrbzoCI8Y/+7ii4XaeG0ACQJ7w76dPi/llC/BRpBuo7zd5VOCdfux9LyMO5qzfntze6jtdlznjfVedXDewI3R/9J6mPHitM4pRqfnxU5T42vd1wRP9glvH1UkKn+ZYTTk7FVVb19nNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275340; c=relaxed/simple;
	bh=QF+e3e2c2G/AI1NBT1J27z2f5zuod94yAWJiZBDxfB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g6AsAyaPti4eQn060pF8gk0KAhXfS8wnq2d554ZnCrXdW1QNuFoS2b8vP5+GNaXoTvNu79VScP9xtYBJ2lW5HNZnnNbj6bdm+e/nPodOIqUHbSeHURroWzeRc0PJhE9MKmZmsSfuAZajJ/G3zof1RaCxckeWPSBjoolujQ7FOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIO3Ak2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIO3Ak2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CD2C2BCB0;
	Fri,  8 May 2026 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275339;
	bh=QF+e3e2c2G/AI1NBT1J27z2f5zuod94yAWJiZBDxfB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iIO3Ak2pQALLhjMMVc9v8Yxvxx8kDltL7p3wszXHaHFTpuscytkxkshHUS+uIisQO
	 D7Sw5y3QU6mI6oB0LoexngWNc3p5e/WMH5+/dsHk4a2QyPJiFlY2aAvqFdUbEGG50M
	 23XliGQZDj8JCYxkmT1uamH1B6FivO9iU9xYIi45efz3E44BGx9NHnfJLcC+w9wiOO
	 sADFiuBTUaXRnLbBi/wvbPXGR4oSvZMIb5XPEV47Yj8ShRQreq2DL1SmvluUv/LTCc
	 gb0Sbm8QoXQIXTi5KFTQEci/WRBy3hTyn8fa7YO7Bk3ykBPQUr3Kf1cA7i0E2166uH
	 uvUNPbX9oNJ/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260508082726.2795191-5-irogers@google.com>
References: <20260508082726.2795191-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:22:19 +0000
Message-Id: <20260508212219.C5CD2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The sample repacking logic silently drops unknown fields without c=
learing their corresponding UAPI presence flags, corrupting downstream pars=
ing.
- [High] Missing PERF_RECORD_MISC_GUEST_KERNEL checks in mapping and remapp=
ing logic break ASLR obfuscation for guest kernel samples.
--

commit e5353f445ca316e60de67b84bb7594a8aa6daa49
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses

This commit introduces a new ASLR obfuscation tool to perf inject that
remaps or drops virtual addresses to prevent ASLR leaks when sharing
perf.data files. It uses a delegate tool architecture to intercept and
sanitize events and samples.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..09b7f2f8fb850
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
> +				    struct thread *aslr_thread,
> +				    u8 cpumode,
> +				    u64 addr)
> +{
[ ... ]
> +	key.machine =3D maps__machine(aslr_thread->maps);
> +	key.dso =3D map__dso(al.map);
> +	key.invariant =3D map__start(al.map) - map__pgoff(al.map);
> +	key.pid =3D effective_cpumode =3D=3D PERF_RECORD_MISC_KERNEL ? kernel_p=
id : aslr_thread->pid_;

Does this also need to check for PERF_RECORD_MISC_GUEST_KERNEL? If a guest
kernel sample interrupts a user process, missing this check might cause
key.pid to be assigned aslr_thread->pid_ instead of kernel_pid (-1). Could
this mismatch prevent hashmap__find() from resolving the mapping?

[ ... ]
> +static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
> +				       struct thread *aslr_thread,
> +				       u8 cpumode, u64 start,
> +				       u64 len, u64 pgoff)
> +{
[ ... ]
> +	/* The key to look up an incoming address to the outgoing value. */
> +	addr_location__init(&al);
> +	remap_key.machine =3D maps__machine(aslr_thread->maps);
> +	remap_key.pid =3D (cpumode =3D=3D PERF_RECORD_MISC_KERNEL) ? kernel_pid=
 : aslr_thread->pid_;

Similarly here, if cpumode is PERF_RECORD_MISC_GUEST_KERNEL, shouldn't
remap_key.pid also be set to kernel_pid?

[ ... ]
> +	/* No mmap, create an entry from the top address. */
> +	if (hashmap__find(&aslr->top_addresses, &top_addr_key, &pmax)) {
[ ... ]
> +	} else {
> +		/* First address of the process, allocate key and first top address. */
> +		struct top_addresses_key *tk;
> +
> +		remap_addr =3D (cpumode =3D=3D PERF_RECORD_MISC_KERNEL) ?
> +			     kernel_space_start : user_space_start;

Would guest kernel maps erroneously be allocated in the user_space_start
range here instead of kernel_space_start due to the missing check for
PERF_RECORD_MISC_GUEST_KERNEL?

[ ... ]
> +static int aslr_tool__process_sample(const struct perf_tool *tool, union=
 perf_event *event,
> +				struct perf_sample *sample,
> +				struct evsel *evsel, struct machine *machine)
> +{
[ ... ]
> +	if (sample_type & PERF_SAMPLE_AUX) {
> +		u64 size;
> +
> +		CHECK_BOUNDS(1, 1);
> +		size =3D out_array[j++] =3D in_array[i++];
> +		if (size > 0) {
> +			size_t u64_words =3D size / 8 + (size % 8 ? 1 : 0);
> +
> +			if (u64_words > max_i - i || u64_words > max_j - j) {
> +				ret =3D -EFAULT;
> +				goto out_put;
> +			}
> +			memcpy(&out_array[j], &in_array[i], size);
> +			if (size % 8) {
> +				size_t pad =3D 8 - (size % 8);
> +
> +				memset(((char *)&out_array[j]) + size, 0, pad);
> +			}
> +			i +=3D u64_words;
> +			j +=3D u64_words;
> +		}
> +		/* TODO: can this be less conservative? */
> +		pr_debug("Dropping aux sample as possible ASLR leak\n");
> +		ret =3D 0;
> +		goto out_put;
> +	}
> +
> +	if (evsel__is_offcpu_event(evsel)) {
> +		/* TODO: can this be less conservative? */
> +		pr_debug("Dropping off-CPU sample as possible ASLR leak\n");
> +		ret =3D 0;
> +		goto out_put;
> +	}
> +
> +	new_event->sample.header.size =3D sizeof(struct perf_event_header) + j =
* sizeof(u64);

If the sample contains unknown UAPI fields (for instance, when processing a
perf.data file generated by a newer kernel), they appear to be silently
dropped from the payload during this repacking loop.

However, since unrecognized bits aren't cleared from evsel->core.attr,
will downstream parsers encounter missing fields while expecting them to
be present? Could this lead to reading misaligned data or triggering
-EFAULT parsing failures when analyzing the resulting trace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508082726.2795=
191-1-irogers@google.com?part=3D4
