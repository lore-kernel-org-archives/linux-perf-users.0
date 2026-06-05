Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957732F7EE4
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689869; cv=none; b=tdPqAwwaq6fFzZcjSO6ZxMj+8nJ95uSD88sQ45OK8R8H+AqgP8d3lJ5codhjOodfMms0Le2EDWsoRt3T4Io22izq4mfSfQwdTI4ZjOFX4LxyXkNSlae7JNVmMfK8fIrw2zoTwyDDKxd2zGWLqk7w/0wJjF2l7dft+tLgmiraJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689869; c=relaxed/simple;
	bh=C7zymAD9k6tBNDmzXSGOuLN+v/2Yod000wovUU0Bn7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A+2mReKxvi4xEB5rdb8Dp2m+5ieBLFIJpd/Lmg567S8W1zgyKsdJJr5InyCyx5Q0G9N4CExgnChvW90D7pHM0fE5Xi771ewPG1Xsz5ock37RHMWAnLgxNI/aauvRUdVMuCB2GYQvPZWWKfQ3Gm2sRhRBA1N/06I2j9rjK7jTt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6aFAR+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6aFAR+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015881F00898;
	Fri,  5 Jun 2026 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780689868;
	bh=45i5bM9Y9UdU2RSu98POvQCqtiC6WXTB5kGfqC+I6Rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L6aFAR+w2x2QblIxD6HNStYKXgUO4I5JUMENcoTeeQEjBrAYGJyaASlqz5RJRFkvp
	 RwSB7tp1i+lSRBAeyg/WfDfrcLBYHYroUM0owPBX4WSO2ZEAEb8TJdfpt44ZMnwurv
	 Ria9Lj7CUHfyoIe9YfRk7iUZlYqVpB4WWI9q9u4K64yplD5kBYTTlTa1tQ5kGkeQeT
	 tjYkMHkJuq0vLtTuMMbHvWBFieevzxwz3HD3xI8cAkynKUvrgDmns40r6v33gMVlrE
	 HU9Ll0N3bHj2VOIR0ALupxywhNaFckY9bGUbgbdD+7aKboOuUZoXJoWQpOHvz/p3DD
	 iTOv75vK88ogw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/5] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605194851.2533568-6-irogers@google.com>
References: <20260605194851.2533568-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:04:27 +0000
Message-Id: <20260605200428.015881F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Useless calls to `evsel__reset_sample_bit` due to prior bitwise AND=
, masking a potential desynchronization hazard.
--

commit 407d38620d5d09a61109d6eb3da76fc9aad40847
Author: Ian Rogers <irogers@google.com>

perf aslr: Strip sample registers

Refactor the ASLR tool to strip out only the register dump payload
by masking out the relevant perf_event_attr fields when the delegated
tool is handling the data.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index c62ae5bcc124f..19fca84a7405e 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -1126,11 +1200,69 @@ void aslr_tool__delete(struct perf_tool *tool)
[ ... ]
> +void aslr_tool__strip_evlist(const struct perf_tool *tool __maybe_unused=
, struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		evsel->core.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +		evsel__reset_sample_bit(evsel, REGS_USER);
> +		evsel__reset_sample_bit(evsel, REGS_INTR);

[Severity: Low]
Are these evsel__reset_sample_bit() calls acting as no-ops?

Because sample_type is already bitwise ANDed with ASLR_SUPPORTED_SAMPLE_TYPE
just above, the bits are cleared before the helper functions are called.

This leaves the internal sample_size state temporarily unsynchronized with
the sample_type flags since evsel__reset_sample_bit() will see the bits
are already cleared and return silently without decrementing sample_size.

> +		evsel->core.attr.sample_regs_user =3D 0;
> +		evsel->core.attr.sample_regs_intr =3D 0;
> +
> +		if (evsel->core.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
> +			evsel->core.attr.bp_addr =3D 0;
> +	}
> +}
> +
> +void aslr_tool__restore_evlist(const struct perf_tool *tool, struct evli=
st *evlist)
> +{
> +	const struct delegate_tool *del_tool =3D container_of(tool, const struc=
t delegate_tool, tool);
> +	const struct aslr_tool *aslr =3D container_of(del_tool, const struct as=
lr_tool, tool);
> +	struct evsel *evsel;
> +	struct aslr_evsel_priv *priv;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (hashmap__find(&aslr->evsel_orig_attrs, evsel, &priv)) {
> +			evsel->core.attr.sample_type =3D priv->orig_sample_type;

[Severity: Low]
If sample_size had actually been modified by the reset helpers in
aslr_tool__strip_evlist(), would it remain corrupted here?

Only the sample_type and registers are restored. If evsel__reset_sample_bit=
()
had worked as expected and decremented sample_size, the sample_size would
remain incorrect here when the sample_type flags are put back.

> +			evsel->core.attr.sample_regs_user =3D priv->orig_sample_regs_user;
> +			evsel->core.attr.sample_regs_intr =3D priv->orig_sample_regs_intr;
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605194851.2533=
568-1-irogers@google.com?part=3D5
