Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C8548573
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113735; cv=none; b=LvoCY8CFf7LEF3vMgM95zS05fCGEUBxHLZWaWXEXZj0EVxak3zfBXR/rR7HB2QM5PAhvoqQqveg9nWOLU4y6TpUwE28VLZh8pKV8gZkuDjsLGY3AkdLjlw2Bndc5m2B9CYx+elARaH5+D8P6hRhDVC+ibCxQ/1ytgrV1Kmj56s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113735; c=relaxed/simple;
	bh=K2q/IiVeToklBnO8gewJGyEpByPIx8NJWeRyRhudUns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXClmpWF9iY0yhou/YjdGC0VMIqnhh1+Zjbgk6nzLKspA48HdvjvhrxcNaZiGxSECugb+hlPVwWG/jkP5fRfAIcT7SQZ0duS+Q89VZzMw1hbmvlHsWEer7z56kIogUMg0IhXEl4GtZZ5xAccXfLJ+uMnpbWNpVfHf91N6NEil5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=L9hylgpP; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="L9hylgpP"
Message-ID: <66a27d3ccb61f716b158582b0c59beca2a4546ea.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790113725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2q/IiVeToklBnO8gewJGyEpByPIx8NJWeRyRhudUns=;
	b=L9hylgpPqHSCFvgqmKGozQpYM3wBwvrXXOZskZhjkOu5bKq5LrHfRHWezNjTNXk+T7q1VH
	FQwFy4l0N9YJQ1Xli5TJ70pOiu1fZRuuXL3MVsGsBhGd7iqGOXjn8LnqVaq6knl1s6ue5i
	EO2Uu6LnW80zmOY5tWMZidHygoZHgUQ=
Subject: Re: [RFC PATCH v2 2/3] sparc64: Support PERF_SAMPLE_REGS_USER and
 PERF_SAMPLE_STACK_USER
From: Stian Halseth <stian@itx.no>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Date: Tue, 22 Sep 2026 23:48:45 +0200
In-Reply-To: <60dfd32837f9d1752fb96a35d8ce1d08c89e5d5d.camel@itx.no>
References: <20260922201507.1719668-1-stian@itx.no>
	 <20260922201507.1719668-3-stian@itx.no>
	 <20260922203330.F2EEF1F000FF@smtp.kernel.org>
	 <60dfd32837f9d1752fb96a35d8ce1d08c89e5d5d.camel@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-1IGfxrB9S1M0tN8YfY7N"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-1IGfxrB9S1M0tN8YfY7N
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, correcting a typo in my previous reply.

On Tue, 2026-09-22 at 23:42 +0200, Stian Halseth wrote:
> > [Severity: Medium]
> > For PERF_REG_SPARC_O6 (%sp), returning the raw register means the
> > stack
> > pointer remains biased by 2047 bytes on SPARC64.
> >=20
> > While the commit message notes this biased address is expected by
> > consumers, when perf_output_sample_ustack() attempts to copy the
> > stack, it
> > will start 2047 bytes below the actual mapped stack frame.
> >=20
> > Could this high probability (~25% for 8KB pages) of starting in an
> > unmapped
> > page cause __copy_from_user_inatomic() to immediately fault and
> > abort
> > the
> > copy? Would this result in a 0-byte dynamic stack dump even for
> > perfectly
> > valid stack frames, breaking userspace DWARF unwinding and
> > profiling
> > tools?
>=20
> I was thinking about setting up some real world tests to see if this
> is
> valid/producable, but I think I will instead go back on my first
> statement in v1, and start the dump at the stack's actual address:
> %o0
> + 2047 for a 64-bit stack.=A0
Typo: %o0 + 2047 should be %o6 + 2047

Getting late, good night ;-)
>=20
> Unless I'm missing something, that should clear this concern.
>=20
> Then the tools and elfutils patches take their dump base from there.
> There aren't really any other consumers anyway, so changing this now,
> rather than later, is probably a good idea.
>=20
> I will wait for some more feedback, and starting preparing a v3
> tomorrow.
>=20

--=20
Best regards
Stian Halseth

--=-1IGfxrB9S1M0tN8YfY7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarL3vQAKCRDoeAEuJe36
VjWHAP9KYb5fVFovIEpUddZZgoyoWxwJOfw79OZkjU9gneaRWgD/YwvlEkQZBjnL
mDI74J5Y0k9R4eqKHhrADn851qUq9gM=
=GHv8
-----END PGP SIGNATURE-----

--=-1IGfxrB9S1M0tN8YfY7N--
