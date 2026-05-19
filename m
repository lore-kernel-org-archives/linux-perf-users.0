Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6C20C461
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184512; cv=none; b=WVsxMV7Q0QZr+M0vkpOBO0Nbl3gtZ6HMXw18jj6UrwXJBEBgFId/cX5pM9x9V+M3ufhjQAxmAttLJD5TJfkp8cG4vYEKr5JHMyer/OrfCmE093cd9dE8A+1GMDyobfgi7Q0q+GKR5Z5wtXeBMH7KkA6zDpmhiMcOYMw+jTU3QxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184512; c=relaxed/simple;
	bh=5x07tln9uIx7dBtfEU6NU0hJP8t4j7diicOfhh+L/fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRwHeKgP3lOGDd7BAhR+ySRnMhUbXzFj3bmB/yV/45CX5hHM4pUfU1LarVSwODmT8WG1OAtqyBYSr73fMcCDZ9n1DSFGqfvVXg1LH9/SjdD20VKsr3ZVU1y5vUXH5XIxGf/lnXC6cO/p8Ekyx+n/7HrD5Cc044k0AJWeApKpZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEkT8u03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEkT8u03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09691C2BCB3;
	Tue, 19 May 2026 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779184512;
	bh=5x07tln9uIx7dBtfEU6NU0hJP8t4j7diicOfhh+L/fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eEkT8u03aiZnbgzLsod+3/BgYUinLQbGmP4x3/jo2A9HVgrnzCGIsx3k5xJzhq+wR
	 yAFM3lNiwSdaxSoovmG/8hDOSBsdqhmowPzEn2dPRRwHcWaOq33TETYqNehZQPgEqS
	 Yng+wsMEHzxK0vAG7KBP+iwQ/ajBhN8muwxuKQhXp33yP3AaWtGOLActNyr+NK/h8+
	 BWPlXjVObmvlefZGYCJFEZRSPVVKSpu0mPZqOpYR4SMG6lIVRGXEcY7nqDJVs4FrGg
	 lzUCLYua4Y7yNq6brx8/5Niwb7JO+5NzkLImzDA+B6J01m5Fl3mG5zpuWJdQPbhec+
	 EHDeZe/RywHpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519080824.3329601-5-irogers@google.com>
References: <20260519080824.3329601-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 09:55:11 +0000
Message-Id: <20260519095512.09691C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Modifying `evsel->core.attr.sample_type` before input event proces=
sing corrupts the raw event stream parser.
- [Low] Build failure due to undeclared `ASLR_SUPPORTED_SAMPLE_TYPE` identi=
fier.
- [Low] Commit message discrepancy regarding the handling of ABI words.
- [Low] Error masking in `aslr_tool__cache_orig_attrs` hides out-of-memory =
errors.
--

commit 828b37c8e32f7fe3bd6173589afcab0ed6408c51
Author: Ian Rogers <irogers@google.com>

perf aslr: Strip sample registers

This commit refactors the ASLR tool to strip register dumps from sample
events rather than dropping the entire sample. It scrubs incoming attribute
events and attempts to keep downstream parsers synchronized.

> and output sample ABI words are safely overwritten to
> PERF_SAMPLE_REGS_ABI_NONE.

This isn't a bug, but the commit message states that the ABI words are
overwritten to PERF_SAMPLE_REGS_ABI_NONE. However, the code in
aslr_tool__process_sample() skips writing to the output array entirely,
stripping the ABI words and register payloads rather than overwriting them.

Is this description accurate?

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 8fe924e730a16..4bafccf7dae40 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -2783,7 +2794,18 @@ int cmd_inject(int argc, const char **argv)
>  		struct evsel *evsel;
> =20
>  		evlist__for_each_entry(inject.session->evlist, evsel) {
> +			ret =3D aslr_tool__cache_orig_attrs(tool, evsel);
> +			if (ret) {
> +				pr_err("Failed to cache original attributes: %d\n", ret);
> +				goto out_delete;
> +			}
> +
> +			/* Strip the registers and unknown flags natively inside memory! */
>  			evsel->core.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;

This macro is removed from tools/perf/util/aslr.c in this patch and doesn't
appear to be relocated to a shared header. Will this cause a build failure
due to an undeclared identifier?

> +			evsel__reset_sample_bit(evsel, REGS_USER);
> +			evsel__reset_sample_bit(evsel, REGS_INTR);
> +			evsel->core.attr.sample_regs_user =3D 0;
> +			evsel->core.attr.sample_regs_intr =3D 0;

During trace ingestion, the core parser relies on evsel->core.attr.sample_t=
ype
to deserialize raw binary samples linearly.=20

If the register bits are cleared prematurely from the in-memory evsel here =
in
cmd_inject() (before __cmd_inject() executes perf_session__process_events()=
),
the parser will expect no register data and skip extracting those fields.

If the raw sample contains subsequent trailing fields like
PERF_SAMPLE_STACK_USER, will the unskipped raw register bytes physically
present in the stream be misinterpreted as those trailing fields?

Could this result in out-of-bounds memory reads and -EFAULT errors,
effectively aborting trace processing for files recorded with registers?

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index d0b1b33377fd2..ef6ba6fa5ff45 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -1097,10 +1122,34 @@ void aslr_tool__delete(struct perf_tool *tool)
[ ... ]
> +int aslr_tool__cache_orig_attrs(struct perf_tool *tool, struct evsel *ev=
sel)
> +{
> +	struct delegate_tool *del_tool =3D container_of(tool, struct delegate_t=
ool, tool);
> +	struct aslr_tool *aslr =3D container_of(del_tool, struct aslr_tool, too=
l);
> +	struct aslr_evsel_priv *priv =3D zalloc(sizeof(*priv));
> +
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->orig_sample_type =3D evsel->core.attr.sample_type;
> +	priv->orig_sample_regs_user =3D evsel->core.attr.sample_regs_user;
> +	priv->orig_sample_regs_intr =3D evsel->core.attr.sample_regs_intr;
> +
> +	if (hashmap__add(&aslr->evsel_orig_attrs, evsel, priv) !=3D 0) {
> +		free(priv);
> +		return -EEXIST;
> +	}
> +	return 0;
> +}

If memory allocation fails for the new bucket or entry inside hashmap__add(=
),
it will return -ENOMEM.

Since the code assumes any non-zero return indicates the entry already exis=
ts
and unconditionally returns -EEXIST, does this unintentionally mask legitim=
ate
memory exhaustion errors during tool initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519080824.3329=
601-1-irogers@google.com?part=3D4
