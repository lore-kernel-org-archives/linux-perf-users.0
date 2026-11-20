Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197672;
	b=WeAWTGlqaeVO62//VhLJXJdrayT/+66G6S9oP/t3V3hZbWJjkIrX4tSBWnWeEI85NpLu
	 Z5uFSUMBdq4Qfi2+oGQ1HQWDXuqQVA2ydxF4Uw8Eh4x9Tj12x7ZoPVDRoFw/oVQjk8Agd
	 7vDDleJh/h+04nYfQ0kpV212e10jG11petsbDNg4fDi3i6bC0dvh7DDxsSBVcI2g0AyZD
	 y+Q6Pvl7nL/Yz/HoXEmJMWctOTVLh+8JBEw3tshTF8GfNWOd8ocE3zMOgpUG5x09Whzu1
	 0oygKAeMoO7gXlCEXijwLxzXJuXhcbPiEHg/g3TNJ0BIwPFXHv0ZiVmsVlCvmxZ75Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197672;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8k/seoYkbDkZyB6ZpvsoQ3zobdGpks0aF1xm5aQy82c=;
	b=Tk5p2cPH3o2D0paJwY6VUzKawgoa4IvxGTtv/iI91U5hjB7SoJ3nWFDK/fOVZ8Y0kQMr
	 hpBFUFVbC00c1xz6HXnEPIEfK3tY1PCcsWnCaOhlMhyGkEfmD0QMa3NMzJ8EwfjvfTi3w
	 o17gW+El18dGdHp/6IEo52ZMu8iDL/Qif9ljrzeiaPcVccB3TVdEhTFsCXGXR9dJgb5QB
	 mVC5yQTCaCbTWcByXCGzdVKDBce7GTGT+qBB6hE+mJQuKt9mZNOXZXdim71roAl/WjYKO
	 qdRRvlRjiPdG7z89Wdgf9vQIDbq+mHzoTEUoEhYUCsMzrilCZhSmPWUDEoB1I1PdUDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/Cm1h84";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7260A2603
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/Cm1h84
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D0F1F000C6;
	Fri, 20 Nov 2026 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197672;
	bh=8k/seoYkbDkZyB6ZpvsoQ3zobdGpks0aF1xm5aQy82c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=b/Cm1h84w7xAriBrWZv24syxrXBWxw7G3zalEomnMeOTuGx7WqkW9GzLfuheu13MQ
	 wMwpmxQqhmaMU1e7ApJgyT4XUCGm77SHct+dxzZDfe796VGXA4dmYcswAQZvt1JTbh
	 T9itELnHxNw8bCBN3acMZOkk6oeIehvjeOOJGGLi5Cab/rgV6gVKhG+jK7jORznrhy
	 BPE5c8GQZcIfBRJ6oDz661PpTwGyPzKP2zdjC/tllpxLfq/URUxjX8X++F9DUpfAWS
	 NitQo0xjtY8x5rDtd1c95W4nzgu7SM7WkQhch7c1iQpUkjZVmUsVz5uJDQMznBbGEH
	 TKx/qRhjopaCA==
Message-ID: <sashiko-outbox-225778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf vendor events powerpc: Fix misspellings in the
 power tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261120175840.1274637-2-takano32@gmail.com>
References: <20261120175840.1274637-1-takano32@gmail.com>
 <20261120175840.1274637-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:01:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Thirty-two different words are wrong, 69 times in all, in 54 descriptions
> of the power8, power9 and power10 tables.  Fifteen of them appear more
> than once: "than than" and "thee" eight times each, "exceed" five times,
> "cyles", "finshed" and "cant" four times each, "software.Fuzzy" three
> times, and "coverted", "repoted", "Fetchs", "whtver", "Micrpartition",
> "dmand", "invalidat" and "tread" twice each; the other seventeen appear
> once.
>=20
> 62 of the 69 are in BriefDescription fields and seven in PublicDescription
> fields, so `perf list` prints those 62 and `perf list -v` prints those
> seven.  Eleven of the 62 are metric descriptions, printed by `perf list
> metric`.
>=20
> Sixteen of the 69 are not misspellings: eight are a doubled "than", four
> are missing spaces ("touchto" in "touch to L3", and "software.Fuzzy" in
> [ ... ]
> gone from the generated out-str.c, which shrinks by 393 bytes as some
> corrected descriptions become identical to ones already stored for other
> models.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120175840.1274=
637-1-takano32@gmail.com?part=3D1

