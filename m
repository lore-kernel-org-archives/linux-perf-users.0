Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853238838F
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182052; cv=none; b=Qb6ObbS08Z1aA+euKzXte+3I+mr/h1mNHPKspH8uuQ6Kmlr+7aet7tvRWqY0g1O25Ar41hmCR66+aYHQv0hw+ejyCKkbPYN4SnJSQJx8ZzVDUt+++bRj3hah4WF+6jbOJD1iMugqYxIbGji06IL9uEmmNTMGVwKpaGK0gSyCSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182052; c=relaxed/simple;
	bh=HW6FIvW6h7UyawH1kfVIfrbZ4j/CUEXnW14gx7j61FQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ajQTM0iRWPNqbb75u5aeQZkFS0Gm6EkpFYIVAugCI/SWm5StxfFCk0glHSGzuRQ/DoRrFiQq8T2t4p9pab1a4AmXf1f2mccapybjVXnFR0JOUee5YeoWPIeC1503NbFSpdXkHDK3avVIjF5LDYc2ERNvbh5iB1fM3Fh2ipW2RYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKHccqdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKHccqdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB99BC2BCB3;
	Tue, 19 May 2026 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182051;
	bh=HW6FIvW6h7UyawH1kfVIfrbZ4j/CUEXnW14gx7j61FQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dKHccqdSYTpx7ddRyhxSE47jg29aHvfM6AawnYDacnyu84/IeTLOLBQ46fwEOMy9R
	 ckUBJavpnQe+yhYZMDp7o5aReFz6g54hou6054iNedCgvFSf5y0KcIu4k9Jv6M+VPP
	 qqfsNC5qASp+vNJSJr5ge4WbvhYzCDimiVfJlOovAoJmxUHunYR15+qNjCWBVNxQMm
	 taIcFMXFEWXRlHfxcvbWqdxUH2Sc+qztGp9hlbOHxq+jHe1ZeOfa3YHvMIno2svQ8q
	 zUNvKkqYJiIy/tTLBZQpiK3R9o3Qv7/NFU17jHsryVXuezRqwd7NvoO0kEO5T4iAfR
	 zajdfhlqodrLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519080824.3329601-3-irogers@google.com>
References: <20260519080824.3329601-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 09:14:11 +0000
Message-Id: <20260519091411.BB99BC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Modifying `evsel->core.attr.sample_type` upfront corrupts the inpu=
t event parser, causing misaligned reads of raw payload data.
- [High] Ineffective deadlock mitigation due to pre-loading kernel maps int=
o the wrong `machines` struct and premature guest evaluation.
- [High] `aslr_tool__process_ksymbol` truncates ksymbol addresses to the ba=
se address of their containing map.
--

commit 9d45b9cad9df39407d7e9e5d06994ca1d17cd797
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses

This commit introduces an ASLR tool for perf inject that remaps virtual
addresses to prevent leaking address space layouts when sharing perf.data
files. It also attempts to eliminate lazy-loading deadlocks by preloading
kernel and module maps before processing events.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a2493f1097df9..8fe924e730a16 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -2267,6 +2269,56 @@ static int output_fd(struct perf_inject *inject)
[ ... ]
> +/*
> + * Scans and force-loads all registered host and guest machine kernel and
> + * module maps up front before event processing starts.
> + */
> +static int perf_inject__load_kernel_maps(struct perf_inject *inject)
> +{
> +	struct machine *machine;
> +	struct rb_node *nd;
> +	int err =3D 0;
> +
> +	/* Load host kernel maps up front */
> +	if (machine__load_kernel_maps(&inject->session->machines.host) < 0)
> +		err =3D -1;
> +
> +	/* Load all guest machines kernel maps up front */
> +	for (nd =3D rb_first_cached(&inject->session->machines.guests); nd; nd =
=3D rb_next(nd)) {
> +		machine =3D rb_entry(nd, struct machine, rb_node);
> +		if (machine__load_kernel_maps(machine) < 0)
> +			err =3D -1;
> +	}
> +
> +	return err;
> +}

Does this preload the kernel maps into the correct machines collection?

It looks like this loads into inject->session->machines, but the ASLR tool
uses its own isolated aslr->machines collection which starts empty. Because
the preloaded maps are not available to the ASLR tool, will kernel maps sti=
ll
be lazy-loaded dynamically during runtime event processing?

Also, since this is called before perf_session__process_events(), are there
any guest machines discovered from the event stream yet to iterate over?

[ ... ]
> @@ -2689,18 +2758,38 @@ int cmd_inject(int argc, const char **argv)
[ ... ]
> +	if (inject.aslr) {
> +		struct evsel *evsel;
> +
> +		evlist__for_each_entry(inject.session->evlist, evsel) {
> +			evsel->core.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +
> +			if (evsel->core.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
> +				evsel->core.attr.bp_addr =3D 0;
> +		}
> +	}

Does modifying the sample_type upfront cause the input event parser to
misread the physical perf.data file?

The input file was recorded with the original sample_type, so its payloads
still contain the stripped fields. In aslr_tool__process_sample(), when it
checks the masked sample_type:

    sample_type =3D evsel->core.attr.sample_type;
    ...
    if (sample_type & PERF_SAMPLE_REGS_USER) { ... }

Won't it fail to advance the input array index over the register payload,
causing subsequent checks to mistakenly read the leftover register payload
data as stack sizes or lengths?

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..d0b1b33377fd2
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static int aslr_tool__process_ksymbol(const struct perf_tool *tool,
> +				      union perf_event *event,
> +				      struct perf_sample *sample,
> +				      struct machine *machine)
> +{
[ ... ]
> +	/* Remaps the ksymbol.start */
> +	new_event->ksymbol.addr =3D aslr_tool__findnew_mapping(aslr, thread,
> +							     PERF_RECORD_MISC_KERNEL,
> +							     event->ksymbol.addr,
> +							     event->ksymbol.len,
> +							     /*pgoff=3D*/0);
> +
> +	err =3D delegate->ksymbol(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}

Could this truncate ksymbol addresses?

The aslr_tool__findnew_mapping() function appears to return the remapped ba=
se
address of the entire map when an address falls into an existing map, but it
does not seem to add the symbol's internal offset.

Will this cause ksymbols inside an existing kernel map to be clustered at t=
he
exact start address of the mapping in the output trace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519080824.3329=
601-1-irogers@google.com?part=3D2
