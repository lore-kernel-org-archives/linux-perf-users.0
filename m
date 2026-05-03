Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616240DFB7
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769976; cv=none; b=jLeI3NmK7AJVg76eUOKOCoAkTSUC5C5GJztZAfgCzYjewBb6sxsYWHfPsmdU5ew1rVuLU8YyfeskLw4N2X+hWwy0e2Dq/6yLp8mgvdTjo6t3zt2KLX/fA+gFya39dvN4TkKEl/tQQr44itDM3WqVvSiKfBitxx2WQLphYaEMgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769976; c=relaxed/simple;
	bh=1Yown4RN4aYHPg8RtxiVhRr+HUsRT9SM/+dMmfdmrK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5QKFCVTHaV8D7FbcbWMLVHYQoQWdQ7/eegU1MZnvnArtMcPRiq2RNcBpZT+wiFUzROaNN1Ct0AT6o30AczdfxbbfjkeQap2DL6lQRd8n1+vyyg2MUlFE7yq3EcTtLtGsSu3VskBvXhOaLOqIs/P4k18cOg7+EvCue/0RN6Yd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJdn4Cjv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJdn4Cjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F33C19425;
	Sun,  3 May 2026 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777769975;
	bh=1Yown4RN4aYHPg8RtxiVhRr+HUsRT9SM/+dMmfdmrK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uJdn4CjvoQ4Q4eik5QTRAIzm/6nNWzK3WSaj4uU+AFor1gZzIbW6zDWLGhCeTi2Uu
	 dZOiuZms4PvXHJkMEURjxEleg4vZ7OQjOm7s3u1keTG9+rhRGk7ElcXJZV/w7R4SzZ
	 5OXtQD6iwCrjQmHz9Frqhxvn2fwFuUzKiKsIA+x4LboGKKeQty7jF2RCss5TXL+aSv
	 /mSti6tN9nFAX/fgkaDRxcvD0bg7pEbfiUIIOPj2mOq1mnZ4M+54EzzmD83jOMWTTX
	 zoZoiUhnyz4ReOhcGE9xLCj6uFboY2EgVUgA7X2vO04ImD9qdwpdsD0meTO3Zsep9c
	 shChh3uMdXlZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/18] perf symbol: Add setters for bitfields sharing
 a byte to avoid concurrent update issues
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-18-irogers@google.com>
References: <20260503002248.1040791-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 00:59:34 +0000
Message-Id: <20260503005935.76F33C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Performance regression due to `atomic_load` enforcing strict seq=
uential consistency in frequently called `struct symbol` getters.
--

commit f3d51ff8771487f327675b2cba0003cf43b91f8a
Author: Ian Rogers <irogers@google.com>

perf symbol: Add setters for bitfields sharing a byte to avoid concurrent u=
pdate issues

This commit addresses concurrent update issues by replacing bitfields in
struct symbol with a 16-bit atomic flags variable. It introduces atomic
accessors to read and modify these flags safely.

> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
[ ... ]
> @@ -77,6 +82,43 @@ struct symbol {
>  void symbol__delete(struct symbol *sym);
>  void symbols__delete(struct rb_root_cached *symbols);
> =20
> +static inline u8 symbol__type(const struct symbol *sym)
> +{
> +	return (atomic_load(&sym->flags) & SYMBOL_FLAG_TYPE_MASK) >> SYMBOL_FLA=
G_TYPE_SHIFT;
> +}
> +
> +static inline u8 symbol__binding(const struct symbol *sym)
> +{
> +	return (atomic_load(&sym->flags) & SYMBOL_FLAG_BINDING_MASK) >> SYMBOL_=
FLAG_BINDING_SHIFT;
> +}
[ ... ]
> +static inline bool symbol__inlined(const struct symbol *sym)
> +{
> +	return (atomic_load(&sym->flags) & SYMBOL_FLAG_INLINED) !=3D 0;
> +}

Could the use of atomic_load() here cause a performance regression on
weakly-ordered architectures?

By default, C11 atomic_load() implies memory_order_seq_cst. On architectures
like ARM64 or PowerPC, this generates memory barriers or load-acquire
instructions.

These getters are evaluated millions of times in extremely hot paths, such =
as
the qsort comparison function _sort__sym_cmp() in tools/perf/util/sort.c:

int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
{
        ...
        if (symbol__inlined(sym_l) || symbol__inlined(sym_r)) {
                int ret =3D strcmp(sym_l->name, sym_r->name);
        ...
}

Emitting strict memory ordering instructions inside sorting loops prevents =
CPU
pipeline instruction reordering, which might significantly slow down sample
processing during perf report and perf top.

Since the read operations only require atomicity to prevent tearing, would =
it
be better to use atomic_load_explicit(&sym->flags, memory_order_relaxed)
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D17
