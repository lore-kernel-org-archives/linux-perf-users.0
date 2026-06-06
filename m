Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779E1A5B9E
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780731485; cv=none; b=OlmTyaFMZTmOMUCw5ujcG69SUT6gWF+HNW+O42sI47ExvNueWVJpxz4v9OkB+jplx0QXbV53ox1VmMzWlRGl++J0BYlHc1T8DL2h3ssL3Vw6S1wF5mkcS+gpK3eR97k9o2R9CLAFbyVzlPtvitvwTiZqXitVfzfSeGipNO+MX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780731485; c=relaxed/simple;
	bh=eL8jpuXJspB/jugrT9xB//EtbP4rNh+N9vWNeQw4/eY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hqzp4bBcHGDRoq/LCHtXBCOVIPhknUO7J0TBkB1C6xN+Wkj9oLpIJByqcun3vjsANqigCA/OontOIp7ETeYzwXyiCvLeXHc/0V78zKinz5gyWo8Fk4skJwgw+aOlyBPlbN8lH07FqubsM8XjaXmo9z2wbXUVrTxxrV89LVz9YO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVVudRl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVVudRl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA71F00893;
	Sat,  6 Jun 2026 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780731484;
	bh=jKocxp+fThhGlBgxXOF8/XvbXnj1gGXjxY3O25zy8NQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVVudRl8U8GtlxePOExgl8kzg2UW9GlKEC1VP11PJnJj83bqm/ZntdgWo1JRDrUqi
	 STinTyB9R4EcM0mTmbsX1QT4NioeVCjhWaqAA6e6RIW4fGr1j1kT9tSVZvNPH0wyXb
	 fEZ7kNnAn4s8K+acGQPZX7qm/jtjum/aRvInOEfsM08a38lIwV/p0V9aabAtAXNeek
	 dcvQRS2mOjBzaS4jqG8sw2B4wAfgki2TJ7ww4uoe4xWUpTBKC+5ZQik3VjW60Eo95P
	 gONJqPUtDdA5NcId7hftGrVjcu5ybNYQjoSwZK53LZ5NBSQU5KSPZsjk4HiOoNXEin
	 6O55CokU9pWoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 5/5] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606072125.2786845-6-irogers@google.com>
References: <20260606072125.2786845-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 07:38:04 +0000
Message-Id: <20260606073804.69BA71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing out-of-bounds heap write of 8 bytes when zeroing `con=
fig2` in `perf_event__repipe_attr` for small `perf_event_attr` sizes.
- [High] Pre-existing ASLR leak via incomplete attribute stripping in `aslr=
_tool__strip_evlist`.
--

commit 5ac431e4dd0a910e235e94ecc9652b8c0f318e54
Author: Ian Rogers <irogers@google.com>
Subject: perf aslr: Strip sample registers

This commit refactors the ASLR tool to strip out only the register dump=20
payload by masking out the relevant perf_event_attr fields when the delegat=
ed=20
tool is handling the data. It maintains the original perf_event_attr values=
=20
in struct aslr_evsel_priv to keep samples that would otherwise be dropped.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6ac6e6fb3b47e..96b90af8264c6 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -254,6 +254,12 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  				return -ENOMEM;
>  			memcpy(stripped_event, event, event->header.size);
>  			stripped_event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +			if (stripped_event->attr.attr.size >=3D
> +			    (offsetof(struct perf_event_attr, sample_regs_user) + sizeof(u64)=
))
> +				stripped_event->attr.attr.sample_regs_user =3D 0;
> +			if (stripped_event->attr.attr.size >=3D
> +			    (offsetof(struct perf_event_attr, sample_regs_intr) + sizeof(u64)=
))
> +				stripped_event->attr.attr.sample_regs_intr =3D 0;
> =20
>  			if (stripped_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT) {
>  				stripped_event->attr.attr.bp_addr =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to an
out-of-bounds heap write?

In pipe mode, stripped_event is dynamically allocated based on
event->header.size. For older perf formats or dynamically sized events
(like PERF_ATTR_SIZE_VER0 which is 64 bytes), the total event size may be
just 72 bytes.

Immediately following this block, the code does:

    } else if (stripped_event->attr.attr.type >=3D PERF_TYPE_MAX) {
        ...
        if (pmu && (!strcmp(pmu->name, "kprobe") ||
                    !strcmp(pmu->name, "uprobe"))) {
            stripped_event->attr.attr.config1 =3D 0;
            stripped_event->attr.attr.config2 =3D 0;
        }
    }

If the event type matches a kprobe or uprobe PMU, the code zeroes config2
unconditionally. Because config2 starts at offset 64 within the attr
structure (offset 72 in the perf_event), this results in an 8-byte
out-of-bounds write of zeros on the heap. Could a size check be added
similar to the ones just introduced for the sample registers?

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 7bd646a5c2fb1..99a6d73181746 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +void aslr_tool__strip_evlist(const struct perf_tool *tool __maybe_unused=
, struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		evsel->core.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +		evsel->core.attr.sample_regs_user =3D 0;
> +		evsel->core.attr.sample_regs_intr =3D 0;
> +		evsel->sample_size =3D __evsel__sample_size(evsel->core.attr.sample_ty=
pe);
> +		evsel__calc_id_pos(evsel);
> +
> +		if (evsel->core.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
> +			evsel->core.attr.bp_addr =3D 0;

[Severity: High]
This is a pre-existing issue, but does this function miss zeroing config1
and config2 for kprobes and uprobes?

While perf_event__repipe_attr() attempts to handle this for pipe mode to
prevent ASLR leaks, it looks like aslr_tool__strip_evlist(), which is used
for non-pipe mode, entirely omits stripping these attributes.

Could this cause the unstripped config1 and config2 attributes to be
written into the file header, potentially leaking precise probe addresses
and defeating the ASLR mitigation?

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606072125.2786=
845-1-irogers@google.com?part=3D5
