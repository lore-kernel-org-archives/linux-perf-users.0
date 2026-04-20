Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AA375AD0;
	Mon, 20 Apr 2026 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690632; cv=none; b=R4mDw6m30aqkQ7H++zPo0i+R8xBw3veEk1R+U+a4x6qbdRA1o+pRVLgzqpJxGNazeki3g5eGhuEuyVZ0pVln3RmWgqHhbY7D1+QH06oTTC4Kdz4S+KpTDoYwXoPVZ8rFBN2f/Gzpst9KwIwmQP497MBGsG+UZy7oGfG4r9x+pVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690632; c=relaxed/simple;
	bh=RFKJ8XgVdNZY9ziaatyj4EMc9th2+ryvIQooMrtXNww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgBXjB1yBCPkXzbwmzHXa753J9Fy9wU/Ok5IMdanOsuZ/o4ICGFsl2EXz5yaO9kRB0QVnOGNcWyP7sVd1wCn/UwygHbfM46WCqY77KOhzdFunOWPdP9uTa4XSJc8U/4lg3GjXHpNQgBMhw+z6eJZRvTsJSPBvl+Ldg6zWml862s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hgDTFYlt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hgDTFYlt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+3lo14J1/NyjIAmHgAiTUITYPL2uWAvAsCttc1UAAp4=; b=hgDTFYltg9WCRYtFOIdcHYbUTb
	p0eKeno69Y4jUP9xqYM/2R0/r9YXVtom3OeDaov72/qJMODZkfGBIL+8Y74zhX5hIOAOcw9yC5IGU
	AjsagYCva87Zzhrkpktun94y315xf/anTI7qR73yqLQA6ep27NcB1U+6gytmEJ7BV4EZHWz7GWrkj
	VTtxuDdNQVaNWnMsjNFhA2tp/gUEIu1FehTu4LycbWkZGwh22cn3fJ5RK9MvzfG0sc7oGJEL17Xzd
	SjCxV/i7j1pg84zHp+Fk/bP8pW3mBQ/xfy9DpOm+zDAbwhxqhbLTPU+ZbGV2tKYwnype5olI+F9cx
	uSYz3eIA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEoOL-00000007zna-2rMr;
	Mon, 20 Apr 2026 13:10:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E090301BDE; Mon, 20 Apr 2026 15:10:20 +0200 (CEST)
Date: Mon, 20 Apr 2026 15:10:20 +0200
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
Message-ID: <20260420131020.GI3102624@noisy.programming.kicks-ass.net>
References: <20260420091634.128787-1-jgross@suse.com>
 <20260420113512.GG3102624@noisy.programming.kicks-ass.net>
 <74aa6707-356f-40d4-8611-5f6d116855ac@suse.com>
 <20260420123352.GH3102624@noisy.programming.kicks-ass.net>
 <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mfmnlIORIkeUiOAD"
Content-Disposition: inline
In-Reply-To: <7078f664-719c-42bc-9eb9-d6bc9ff1f57e@suse.com>


--mfmnlIORIkeUiOAD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 03:01:31PM +0200, J=FCrgen Gro=DF wrote:
> On 20.04.26 14:33, Peter Zijlstra wrote:

> > That is, we have the following instructions: RDMSR, WRMSR, WRMSRNS
> > And we should have the exact same functions:
> >=20
> > 	val =3D rdmsr(msr);
> > 	wrmsr(msr, val);
> > 	wrmsrns(msr, val);
>=20
> People tend to copy similar code, maybe using older kernels as the source.
>=20
> So even if wrmsrns() would be fine (and, resulting from that, better), th=
ey
> will more likely end up using wrmsr() instead.
>=20
> Using new function names implying the exact semantics (serializing vs.
> non-serializing) will make it more likely the correct one is being used.

You cannot fix stupid. If you want friction, the label thing will
ensure 'old' code doesn't compile and will need fixing.

Also, if wrmsrns() really is faster, the performance folks will finger
'incorrect' wrmsr() usage sooner or later.

> > The only interesting question is what to do with the 'safe' aspect. The
> > instruction takes a fault, we do the extable, but rdmsr() above already
> > has a return value, so that can't be used.
> >=20
> > One option is to, like uaccess and the proposed overflow, is to use
> > labels like:
> >=20
> > 	val =3D rdmsr(msr, label);
> >=20
> > And then, even though the wrmsr*() functions have the return available,
> > do we want to be consistent and do:
> >=20
> > 	wrmsr(msr, val, label);
> > 	wrmsrns(msr, val, label);
> >=20
> > rather than be inconsistent and have them have a boolean return for
> > success.
> >=20
> > What am I missing?
>=20
> I like the idea to use a label, but this would result in the need to use
> macros instead of functions. So this is trading one aspect against anothe=
r.
> I'm not sure which is the better one here.
>=20
> An alternative might be to switch rdmsr() to the interface used by rdmsr_=
safe(),
> i.e. let all the accessors return a bool for success/failure and use a po=
inter
> for the MSR value in rdmsr().

Yes, either way around works. Perhaps that is 'better' because mostly we
don't care about the faults since we've checked the 'feature' earlier.

Its just inconvenient to have return in argument crud, but whatever ;-)

--mfmnlIORIkeUiOAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmnmJbsACgkQdkfhpEvA
5LqrfRAAtUP8rVHx50dWDsVTiXDcWxSNtdlVFTwLXSs6fssk3GF8Pkvnful9Rrts
PfWaBEF+4t++knrWfjpYkTtCVGqA62am09PVNkZCurGWR2RSqO9a6HpdIeOHiSw0
+mzmMtRQgjrKnPKP93WL1Fx11M0yiiI0slrAsMjRHdLYmv7K1QbxizaGLOT/AabN
rxmHpAFxhuw+jezG3cQiRdO7dAbcQCaJKbzz5avH32iAQxWAZgfF4U2QJSFdOxZ/
4B0MrhTAnkR1UM8mbDCNNYywvw7OHfPI7SvBhPeeZzPHiJGp8Y1q4JEMvxkMsKeK
29xj0mvSsGBDZt5Q4XnPcpebzqrcSztDnQ+XD2NQ170jX3HxiLqKgYx2BMQ6Fy8I
pnO40s/eovZEWg1BIRyp9xbdwUYCEML6OisNDcbMPYSekpjuicdxB+tNLORn6ttB
IVeiXTKsW4AcnT/55yluE9qBjS6f+AH6arZiGYR2jdlQRgZPyGNSK1MoDNxuLN/E
4Ws9zsVu7CfWJZIXfQ2H1pVbKNRmtI5pWlRSk6ZydQDz1TpybkxQKu/Rp6dTIcL6
4KH93U0fvXyADclbgrlQxlR3OhWmBMA2WdzGYwWoV+MhC8kZomqIM7O/Q/eSrpxE
G14aovU4KMGw7xzLsPH8L3nxJqDk3MhzMz5k2dPNE3fqtO1KgaQ=
=A1vx
-----END PGP SIGNATURE-----

--mfmnlIORIkeUiOAD--
