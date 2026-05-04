Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D851F09A8
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870284; cv=none; b=LGlHVx4Lrm9hdj8upow9qNED1x9UjrqoyqlVvs2rEQypljGqqfniVufqu537hebahSYKug+lgquGPqBcWfKvVVkeKv+Z7OF/DfXFCZNkXk4zAxrIarN2U3oh1FNQQlG0tj0v3ZJEFE6uWg5+QIh2erNDX7tEZM07Ah8ZuNrM4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870284; c=relaxed/simple;
	bh=xUNLsqlVh+l7cxxlnfKWTvZKZa6JssFWlSaLBZtkt44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gxKHpYMq7GxOeEdprrNS/VvA7z5K9CpLQA+p/83aiiAL7sYSO6qJIriMe0Ij6grbMll9Op/leAfo8M5L8l6ksyHioN0EQkLklUirMztFUBN8n3ZK3AwtL2ByGslrs4utEt+qIUMue2hYWx6w2n77PMq8uee066bjN+XCd81fuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/3k4Xkt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/3k4Xkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90662C2BCB8;
	Mon,  4 May 2026 04:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777870283;
	bh=xUNLsqlVh+l7cxxlnfKWTvZKZa6JssFWlSaLBZtkt44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=H/3k4XktqRXKsk62NjSGxaoNkDPRK3989PmY4P4r9I13+XKQ56bCcidwnKO8sEHWJ
	 nImEA41uvE6AEHtfKX9KKF0NHy8KM8x02PTY5vMRAO/KhBN1qtTzezzF5ixcTVPu2b
	 P0y0AiqnF9VWpFq4HcPangzePq64b8RL5lj2LICI4l/ZKwGm5vU0p63osldVPCTSLr
	 zucFEvvHVH8i/HGzzjtOtNyjDe8UzHEuNuOoMKlh+tggrcFlHsnhKBWjIK1TIFqwWD
	 DI/t0iyAypzpXbAQgGLleiMMFejAK25Wruirrw2WFP+d3s/BD8uR7911R40mraj6ni
	 WdOSWzmQsIY4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504035125.1851720-4-irogers@google.com>
References: <20260504035125.1851720-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 04:51:22 +0000
Message-Id: <20260504045123.90662C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Breakpoint addresses (bp_addr) are not scrubbed when processing re=
gular perf.data files or synthesizing for a pipe, defeating the ASLR protec=
tion.
- [High] The --aslr option defeats kernel ASLR obfuscation by deterministic=
ally encoding the original kernel start address into the emitted mmap.pgoff=
 field.
- [Medium] The `skipn` function does not handle `EINTR` when reading from a=
 pipe, which can cause spurious tool aborts.
--

commit e61cd92f35f2e374d97add5939b1983c327eae98
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses

This commit adds an --aslr option to perf inject to remap virtual addresses
in perf.data files. This prevents virtual addresses from leaking when
transferring perf data between machines, thus weakening ASLR. Unhandled
events are dropped to conservatively avoid leaking ASLR information.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec4..6e6bf6b67956 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -2763,12 +2777,12 @@ int cmd_inject(int argc, const char **argv)
>  		/*
>  		 * If the input is already a pipe then the features and
>  		 * attributes don't need synthesizing, they will be present in
>  		 * the input.
>  		 */
>  		if (!data.is_pipe) {
>  			ret =3D perf_event__synthesize_for_pipe(&inject.tool,
>  							      inject.session,
>  							      &inject.output,
>  							      perf_event__repipe);

Does this bypass the ASLR tool wrapper for ATTR events and leave breakpoint
addresses unscrubbed?

The aslr_tool__process_attr() function zeros out bp_addr, but this callback
only intercepts ATTR events in the main event stream. If the output is a pi=
pe,
perf_event__synthesize_for_pipe() uses perf_event__repipe directly, bypassi=
ng
the scrubbing and exposing the original bp_addr in the output stream.

When processing regular input files, ATTR configurations are parsed from the
file header and stored in session->evlist. Does perf_session__inject_header=
()
write this un-scrubbed evlist directly into the output file's header, also
leaking the original bp_addr?

[ ... ]
> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 000000000000..32548352e1e5
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static int skipn(int fd, u64 n)
> +{
> +	char buf[4096];
> +	ssize_t ret;
> +
> +	while (n > 0) {
> +		ret =3D read(fd, buf, (n < (u64)sizeof(buf) ? n : (u64)sizeof(buf)));
> +		if (ret <=3D 0)
> +			return ret;
> +		n -=3D ret;
> +	}
> +
> +	return 0;
> +}

Can this cause spurious tool aborts if read() is interrupted by a signal
(like SIGWINCH)?

This function explicitly checks if ret <=3D 0 and returns it without checki=
ng
for EINTR, which allows the error to propagate back to the event processing
loop and prematurely abort the perf inject session.

Should this utilize readn() or preadn() from the perf library which correct=
ly
handle EINTR?

[ ... ]
> +static int aslr_tool__process_mmap(const struct perf_tool *tool,
> +				union perf_event *event,
> +				struct perf_sample *sample,
> +				struct machine *machine)
> +{
[ ... ]
> +	/* Remaps the mmap.start. */
> +	new_event->mmap.start =3D aslr_tool__remap_mapping(aslr, thread, cpumod=
e,
> +							   event->mmap.start,
> +							   event->mmap.len,
> +							   event->mmap.pgoff);
> +	if (aslr->first_kernel_mapping && cpumode =3D=3D PERF_RECORD_MISC_KERNE=
L) {
> +		/*
> +		 * If this is the first kernel image, we need to adjust the pgoff by a
> +		 * similar delta.
> +		 */
> +		new_event->mmap.pgoff =3D event->mmap.pgoff - event->mmap.start +
> +					new_event->mmap.start;

Does this adjustment of pgoff allow recovering the original kernel ASLR bas=
e?

Since event->mmap.pgoff is typically a known public constant for the first
kernel image mapping (e.g., 0 or a fixed ELF offset), and the output trace
exposes both new_event->mmap.start and new_event->mmap.pgoff, could an
attacker trivially reverse the equation:

old_start =3D new_start - new_pgoff + old_pgoff

Does this mathematical leak nullify the ASLR obfuscation intended for the
kernel image?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504035125.1851=
720-1-irogers@google.com?part=3D3
