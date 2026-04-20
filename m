Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9D1C5D7D;
	Mon, 20 Apr 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688447; cv=none; b=UTWhnixjzIbhFLcY2icpcbgKsBABm2g0oNkEj3EiyytN0i4SSInXCf6AHIT4LW52BiF71T/jpGHKBnnZozPqMuYW15pzMpyvD9F9nW7ndd2PkbKWJyMihXA3AcwGf5vPQcdxpQd4hLq7fMIfVQuH/jOzx/99UkeClcsG78uVgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688447; c=relaxed/simple;
	bh=8DVNTdqtymxD+D6VomkDQpMXINeeL78z3PdZiAQgVeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0jSDaqZlIC7eL3aatIkGHXH3E2Fubx4l8eLjV1jmYDvTBGboPEulX6/3Z+6KQr1Bl4upiyz+SmnI8pNs/GnvQk0v56De6Zpioq690GfEKBeeHNANYQaRlNwiQrsPRcnB9kcbqrIAH05WOvSEknQwcyKy9C9CKKjRgBVKbR7fDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ENOysmJK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ENOysmJK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ru+w/oxZxTd7mJgX/R7M8U9xpsJRQsuaGfnFo/fCVFI=; b=ENOysmJKu5w9jFkEIg9WaAce4C
	Yj+tzNn6nVX+Dw+TjnW1nmWnQz1XSKFYAKAKhTokCUg5c73ycSJeRhQRIPPsZmNSf40VW9/dy9z0l
	0naLSjmWkpDEQM1jX2Qe8sUFrUKYjeH9nDL1+Aj4+0DFm96JSmqo3NzApMoSR20e0aJtIXhk9xJsZ
	MPy6dPZrQ7o1gBH1XxEj5DnWFu+qfDlEXszugL8OdqTWz3IP09+xbZSAT9Pv7TV9etisQahkh2bQZ
	evx3IfuLYxG7wpRkXV1QS093SDE5JoCNrYkRwqj2sPibueMVRmka675+NxmUBC7Der2BKXt35Jwit
	IFfkYnkQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnp3-00000007v7m-2ARA;
	Mon, 20 Apr 2026 12:33:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 373883021A4; Mon, 20 Apr 2026 14:33:52 +0200 (CEST)
Date: Mon, 20 Apr 2026 14:33:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
Message-ID: <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7+yjHOX3pOmOVtM"
Content-Disposition: inline
In-Reply-To: <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>


--f7+yjHOX3pOmOVtM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 01:49:02PM +0200, J=FCrgen Gro=DF wrote:
> On 20.04.26 13:35, Peter Zijlstra wrote:
> > On Mon, Apr 20, 2026 at 11:16:28AM +0200, Juergen Gross wrote:
> >=20
> > > - Use functions instead of macros for accessing MSRs, which will drop
> > >    modifying variables passed as a parameter.
> > >=20
> > > - Eliminate multiple accessors doing exactly the same thing (e.g.
> > >    rdmsrl() and rdmsrq()).
> >=20
> > So far so sane.
> >=20
> > > - Instead of having function names based on the underlying instruction
> > >    mnemonics, have functions of a common name space (msr_*()).
> >=20
> > Not sure on this one. The whole msr_{read,write}_{safe,noser}() thing is
> > a royal pain. Also 'noser' reads to me as the noun that goes with 'to
> > nose' [he that noses (around), like baker: he that bakes].
>=20
> Naming is hard. :-)
>=20
> What about s/ser/sync/ then?
>=20
> > I would much rather we just stick to the mnemonics here. All of this
> > really is about wrapping single instructions, no need to make it an
> > unreadable mess.
>=20
> I'm pretty sure most of the wrmsr*() use cases could switch to the non
> serializing variants. The problem not making the serializing aspect visib=
le
> in the function name will probably result in most new instances still usi=
ng
> the serializing variant instead of the probably possible non serializing =
one.
>=20
> Many of those use cases will even suffer more, as they won't use the
> immediate form of WRMSRNS then, which would waste the additional benefits=
 of
> that instruction.

I'm confused, if we have a wrmsrns() function, that could see if the msr
argument was a constant and use the immediate form, no?

That is, we have the following instructions: RDMSR, WRMSR, WRMSRNS
And we should have the exact same functions:

	val =3D rdmsr(msr);
	wrmsr(msr, val);
	wrmsrns(msr, val);

The only interesting question is what to do with the 'safe' aspect. The
instruction takes a fault, we do the extable, but rdmsr() above already
has a return value, so that can't be used.

One option is to, like uaccess and the proposed overflow, is to use
labels like:

	val =3D rdmsr(msr, label);

And then, even though the wrmsr*() functions have the return available,
do we want to be consistent and do:

	wrmsr(msr, val, label);
	wrmsrns(msr, val, label);

rather than be inconsistent and have them have a boolean return for
success.

What am I missing?

--f7+yjHOX3pOmOVtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmnmHR0ACgkQdkfhpEvA
5Lrx/RAAmQHG3r/BKE7IXGwEwRO+Ue3IdkpYg1QALizJTSBunX4cxL2HgUDfb2GG
YkY/f9QYZ3PdIKTRsx6b8UpUqx5kzYolD1YlkU7mCBJopQGW1XmquBj0j+vVjDo8
h7gMNWYRblf5pM4Pv1M816OJatl5TscFnITfbvSjvxVcJezPASlQHTbRb2m+KVRX
Q/XqVhoT6wCilPpnei4rXRtPowTCQ2KzW6x+nhJeDonbUdPAFC5w2gWXrTlQK34B
YMnrEkj/B7qkcplkpniBIMcWLR3ZO6eQhpsvgD/Bfs4PPIxf9Nt4bZZ0rdYz3cSW
6CzqLFYSY0aCFfMIDR6FbHt0B3rxBklqEKFApshSQ1/wdAwSWcf6IPr6c6VMpyw6
4pFDsBRs7uPZKPYFo2fHVC+HlYSY3F+1mpV/2roIyvzla5q/EULMbu04nDbRxuYr
AV6Qxj4HiqBe5cVkqLDU8dOl4eokpllCLqIXpymHeEhhR31tOSAorlkTUHjW0vLy
VrP6uDOpQzLg8sp4gKDQNaaSaxRT9bP3puBA6VAlK0deyU4L89967aO8W1Oo0/0Z
gDUxuTv47e3QucdAg0ckm3meShY6Gf6ROCnxewdlBRYRzXcjcmqKwA4m+MbEYapL
+Wui6A4XMK7dGRWsFCeE9XYal8yRRa54+RPj4hqtlJduZUZxiGc=
=t9s5
-----END PGP SIGNATURE-----

--f7+yjHOX3pOmOVtM--
