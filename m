Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591187;
	b=RXGzjdW7X/9v4bJD2YYMc262q4upvHaClyOuNwkd+ruhcAjkfilJezGNv0xmkfylPToK
	 FXeFin9oz0I+QCwkiWmBELGEYNS0KviaxnWvei1RZqbRn+ftDmM2gbNNni23FaWcrcpiA
	 pNl/LmNryvvE2GL8MVohartS4FDrAncqghzfnBxT6rXYrL4yxQ5sExkPJh2NoWPSIiYmA
	 Xwylue+G/mdK+wctwSyxU4imajD9NUfHJtvGhRR3pecJrAZEzXNE9j7fJpkqibpixZIDQ
	 vnEiG/g3INZ50VYHJ/ByigiBPiklDGVdGf6RL+MG28+/IjUOx5Hal+xlT+GM8X3Ndqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/pwjE0f+JaH1+E7GjQUfb6eV06oZZzqD22SrURrrU+k=;
	b=ijmizZaFOBdyjoytgrzzG9z02TgTcQZGUyzHp05mpLLmxpcWGeSYo5TT/SLxyrG/1vbg
	 rmBjzzVVVL+5VyA0N0jJNApN25GLKVCEd5YNXHgHx2jylFv0FNasl5UYysBc5gI1v3I1w
	 HgBuVZgnObC6cedwML+VAjaAZC3mB4w33dD6aAFw+yVrQirD4J1YpY6PjJiBWKwPGfZeT
	 2PKRhBQA8au3KcvNxZtTW542cJfLc+I2XqAKNqD6y2hLD9ut6Mp/F6oNHgzx8+aV4m7lc
	 QHldPIUjqYfYQyxpGnLPEo1cVdYKf6JB01QC0Y8BgotJ8cSkIx3s6cslFQpqBm5DBvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBKkmHyp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABE6073FE6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBKkmHyp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6751F000C5;
	Fri, 13 Nov 2026 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591187;
	bh=/pwjE0f+JaH1+E7GjQUfb6eV06oZZzqD22SrURrrU+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBKkmHypOvBjBo0JEktzEIGShEwJJLGYS9YCGFfIir3blxUrDkqj3EMRH1L66loOC
	 rSe248ehxnyBj5W45qDbf6M6Gb5k7gA2a41Tei07q73wyCgZoTttPo4UQf6ITHMDXq
	 DHUDuZjwshwrlMLr5y3w8SnWl8+dzS0oSGw1PsWVIUjH1ENGXR9uJM7cakFGsoX9uY
	 TSmzzJMJ8XH2BlJfGtWXQbRH6DN/yOjfHWdVJ7TxGROodiflD05tcWBNJegK1cT/Ud
	 IcI2zYVndisu8Jgp9nJpVVhEm4zfIo5cDovFMQowO7IbJRsdumA2LzDNtp4JGYBnwN
	 OngU4IgOrm/tg==
Message-ID: <sashiko-outbox-213319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/23] perf map_symbol: Add struct dso_symbol and use
 for parent symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-9-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:33:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A struct symbol's lifetime is owned by the struct dso containing its
> symbol table rather than by an individual struct map. When retaining a
> symbol pointer beyond the scope of a temporary addr_location or map
> reference without holding the map itself, the owning struct dso must be
> refcounted alongside the symbol pointer.
>=20
> Introduce struct dso_symbol pairing a refcounted struct dso * with a
> struct symbol *, along with dso_symbol__copy(), dso_symbol__exit(), and
> dso_symbol__from_al() lifecycle helpers in map_symbol.[ch].
>=20
> Convert parent symbol tracking across callchain resolution,
> hist_entry_iter, and hist_entry from bare struct symbol * pointers to
> struct dso_symbol so that parent symbols pin their owning DSOs until the
> iterator or histogram entry is destroyed. Also drop the unused
> perf_session__resolve_callchain() prototype from session.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D8

