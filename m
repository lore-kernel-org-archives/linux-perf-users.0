Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591528;
	b=XcazhQQWCCO3CdT5Feq7udC6MSaY1PRdQ7zK7SYqP7R+m2hRPrcL6EqFd0zuF0zPdmO6
	 5TbTVJ7H8okEgG9KJUwpIQdab9qu9Ke0OpRd5GwpmknyYkjncqVo0jZurzQ1APkB76LJk
	 5Qs39CNkTjhZ8sJtEwDwegdi/83Pr91rB6BdVvcD6GmH5UdHCNzNxdxWQUn+R9AQPeFVP
	 NO914IJF7SEAyCMNSkQJD9PRTOIzg4zbOv1FqjmY9RenKUuwzmZzyTCFink+8RLjvdSqN
	 S50SFpFfNxSxxk3CfRCVlgCWiZOK6gnrV+yG1rt20eTh1uCWRa9B4rJPtiQEiAI+j0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qACFaTeuET1wRl7PxIygN+AXMjdQJmaY5Y3HiE3nDQk=;
	b=vwe15Ux2QKZMxiuIofItLoR31hL9foV3KqDGDhPwIh0G1gSkc37Blphhn3nCZjHyzs7z
	 jQ58tx1oERqrWSkbOQTIlLDkZ1pknqdVDukdAfAk1HTMnyF5+4A0xb5g7FG+ez4hWR+R3
	 NpMVwmHmrt2ajsWChcPB3+arPGp/R1YwZKKhIc+pz7w+ex6/NOluyzjMOrqOePz2KDwFk
	 IKuhLM8BWpM0P0z3sa10iTd8cbi02lHpxC+NtF86x8k0wIOveYY/ziGKA0eFbAiybK98b
	 RKJaksrChFelTNOhBFxp8Mok24xjbcgIoQCi6UfIJPjW7lKhB44vesMe+EOX+ZytPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecbE3Zwt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00F606D498
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecbE3Zwt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0171F000C9;
	Fri, 13 Nov 2026 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591528;
	bh=qACFaTeuET1wRl7PxIygN+AXMjdQJmaY5Y3HiE3nDQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ecbE3ZwtRZMDyfvZYmxQz5fT3OVeh01VLJUd7vgJtmv1Fns7/Qvnhe6mDmgTzLMj6
	 Aro4BG23PcDMtY+uHSDDaHJeM1zVxmBKF4gv3d/of2xdAZJmLkXotROo9ZUkdA8PNx
	 MMq26sk0l/1wcI2XlgbTQ57e7CNJ63CLgfYaPIKC25aaAZsLnRDFcb/L4+8Agm20Wm
	 aS6EvVSXJQfk/3I6fj6lI2LfKbYQr6p6r2udPlvhgCTKG+pp9oh9CMDAI9GGE7mg3e
	 kR39IxWZQf76RA31Xl13G/oDH+Lx+y/m2N6RybgEZkdQbRu1xHSZGQP1Zb3IQb6kHt
	 tK6s8k/GkGmoA==
Message-ID: <sashiko-outbox-213337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/23] perf annotate: Move struct annotation to a
 hashmap and remove symbol_conf.priv_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-12-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:38:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf annotate: stale empty_annotation pointer in
  symbol__annotate2()
--

commit ac625a89af0c85006845aa67eead802e5cd52ad9
Author: Ian Rogers <irogers@google.com>

perf annotate: Move struct annotation to a hashmap and remove symbol_conf.p=
riv_size

This commit moves struct annotation instances from negative-offset space
before struct symbol into an on-demand hashmap keyed by the symbol pointer,
and removes symbol_conf.priv_size.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 529d27e2ef636..e907a83e1f27a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
[ ... ]
> @@ -157,9 +162,130 @@ annotated_source__hist_entry(struct annotated_sourc=
e *src, const struct evsel *e
[ ... ]
> +struct annotation *symbol__annotation(struct symbol *sym)
> +{
> +	struct annotation *notes =3D NULL;
> +	long val =3D 0;
> +
> +	if (!sym)
> +		return NULL;
> +
> +	/* Fast path: look up existing annotation under read lock if flagged. */
> +	if (symbol__annotated(sym)) {
> +		down_read(annotations_lock());
> +		if (annotations && hashmap__find(annotations, (long)sym, &val))
> +			notes =3D (struct annotation *)val;
> +		up_read(annotations_lock());
> +		if (notes)
> +			return notes;
> +	}
> +
> +	down_write(annotations_lock());
> +	if (!annotations) {
> +		annotations =3D hashmap__new(sym_ptr_hash, sym_ptr_equal, NULL);
> +		if (IS_ERR(annotations)) {
> +			annotations =3D NULL;
> +			up_write(annotations_lock());
> +			return &empty_annotation;
> +		}
> +	} else if (hashmap__find(annotations, (long)sym, &val)) {
> +		notes =3D (struct annotation *)val;
> +		symbol__set_annotated(sym, true);
> +		up_write(annotations_lock());
> +		return notes;
> +	}
> +
> +	notes =3D zalloc(sizeof(*notes));
> +	if (!notes)
> +		goto err_free_hashmap;
> +
> +	annotation__init(notes);
> +	if (hashmap__add(annotations, (long)sym, notes) < 0) {
> +		annotation__exit(notes);
> +		free(notes);
> +		goto err_free_hashmap;
> +	}
> +	symbol__set_annotated(sym, true);
> +	up_write(annotations_lock());
> +	return notes;
> +
> +err_free_hashmap:
> +	if (hashmap__size(annotations) =3D=3D 0) {
> +		hashmap__free(annotations);
> +		annotations =3D NULL;
> +	}
> +	up_write(annotations_lock());
> +	return &empty_annotation;
> +}

[Severity: Low]
Can returning &empty_annotation without inserting sym into annotations caus=
e a
NULL pointer dereference in symbol__annotate2()?

tools/perf/util/annotate.c:symbol__annotate2() {
	struct symbol *sym =3D ms->sym;
	struct annotation *notes =3D symbol__annotation(sym);
	size_t size =3D symbol__size(sym);
	int err;

	err =3D symbol__annotate(ms, evsel, parch);
	if (err)
		return err;

	symbol__calc_percent(sym, evsel);

	annotation__set_index(notes);

If the first symbol__annotation(sym) call in symbol__annotate2() fails to
allocate and returns &empty_annotation, sym is not added to the hashmap. If
the second symbol__annotation(sym) call inside symbol__annotate() then
succeeds, symbol__annotate() populates the newly allocated annotation and
returns 0, while symbol__annotate2() passes its cached &empty_annotation
pointer (with notes->src =3D=3D NULL) to annotation__set_index(notes).

For the same reason, callers such as perf_top__parse_source() that lock the
sharded mutex for notes =3D symbol__annotation(sym) before calling
symbol__hists(sym, ...) will lock &empty_annotation while symbol__hists()
allocates and mutates a different struct annotation instance unlocked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D11
