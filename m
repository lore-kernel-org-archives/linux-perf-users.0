Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783737E308
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786829991; cv=none; b=ONaxjbEE5tcQAkIgMVIu0NHNt2bsaqZNsfnLkBwCkKNjKT2BIZj9pHCbM86vSCB8mWwr8NEDQNX4yYVJVw0X8233bsu0GgBaOf7UySY7n8pWpA98qs4aoRkxdXJMOP6P0SxXjwzLjfcZWfy/XTwfXJxt8IuVbU4VVUv3UQ/Zc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786829991; c=relaxed/simple;
	bh=BBL8EQyJT6vyN7BDVzYQ8qVCWKuSYDBgMshFrvQwg64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZPwYQMG08yjbknFFro4H6X8JFD52DO0eNIajc71/y04n3WjKFAa0N5hb3wyVg6jH5Lc/lVWrAB41O+/BOnGmk33jjtKOC5sOqNx9nPp9EcpOksvkI7gkSC/NAdgUbkrA9eM0Gze4ZwNUME1eb6y4ivQeyxptR0XcWuhd9RF9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=f8QHbjUH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="f8QHbjUH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so17550185e9.0
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786829987; x=1787434787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BBL8EQyJT6vyN7BDVzYQ8qVCWKuSYDBgMshFrvQwg64=;
        b=f8QHbjUHqoDnVMboT1QT6lDYzTmHk383yTaZleYDp9Am5KTSBU0RNVlOzW7MBhp5Pe
         faKY+NJ/bI99Nh4vg3fEGPHRgL0xH8NiY5DR+0uCHX86wP90mfI/l7QDgkKNg2cMLMVp
         bR6WDfRa670Y3O2Fl9I7t8BPpB7rDDC9wxHPtg4caCnP3NsayW7aMWfIB5sZgCW7nUt/
         YKXpfkNPhvLeR9Yqp0ogXiOpAvDHpqjUuVDFBVsZ6dwNJcM/oxTOlssAHHrcCbbAdwFK
         skU8v0rfaKlr5LQwEqKMaYxCiqoxUEpSIxEG56eKJRGkOlW6/YRPs8J9IHq297c6URRk
         9cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786829987; x=1787434787;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BBL8EQyJT6vyN7BDVzYQ8qVCWKuSYDBgMshFrvQwg64=;
        b=SUQJuJlXKFNdGkFkAAxOLTufcsRKrnxpz2ZRvI/giUqTfqzLXiLoPmOxlySlt0X/lZ
         yBamDdhv2S8+zeeVnDTVYmDQKQDFD8yvOKdNkkljJjUrrrrGfJEfcBgVRxewuEEkZ1k/
         y+6BthTcrecj+lWcTu/A3TStCqySRNFUZ8qpp8AGurK7I1k9wCQ/sAMjwM0SqUA9SnIz
         +JVJ7X1sbIoBt9Eiyo4JJ4Foa0NQS8X+GgNQr8j6q3SlugNd9/H/6lGpb70KVV3K4L5n
         YJzrdriGoRaKn1IINPmd+VUCb9habhiCm4PIzvQjTooAEPrKYuJQ034mN6ly5o1aUrUw
         gb7g==
X-Forwarded-Encrypted: i=1; AHgh+Rokw1GooPL/ZFuLQHF6cH/EZpmxT7orqaQ0gNTqrUM41KhWV4KHfvoVQNm6PrpidRE9lZr6ej9yMEdFYy4MhO2U@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNlsuNwywxmrgoc+pfgTfFqFLkQo9CV8siiEkp1VTsaLU9XSB
	C038tb3aoJ67rFXg6uIQL9XUNY+zOUnEkrDQRqiyJReGedgY45Q10Q/J/MAtk9ZvsCM=
X-Gm-Gg: AR+sD138GFjW5A++y+dG/OWyLsStrzxZqTKLK0oc0CwGZKvsQJ9e61lnUKbEZqJeCyq
	cupaMTI7K6FPKX8ND6zwrhwQveHFxpdoB9wBDicmKGQ0OqVz7tucpRh17KkCcKCRIv/37ZhTany
	x8XXzPp9uU2bIB5QSuE4Ke9d40nJWO52036fnl9rwB2NTLE84xtBHVLDvvN1t4NahAjZpLHgQJ2
	jSvIkxjY9CNYkoG7ve4XrT+PLKXnov+D95m5edykot5t2du/ZfHhe1d+YBLI0Jh40Qxnyo4/L5u
	IhTcl7eFh+Wya8T3FAL9UIi5mxE6LbsIGau6yF86GGgAaaXOZfhNpq0f+LyMtSs36YImDFoyKXQ
	aY2Tfr2vzegBh1LlyqS7FsWOpYQlSir/KK/iO///32THjOFGdTF04TnHx/GPWKciSpQnXDGFjaI
	rk6JW2ImLUjK08PHdC/QK2vnqLvYQp71DoIpWoPHBC/Sf6Q0v0VFMOOgUNpd7UKT9/Tg==
X-Received: by 2002:a05:600c:4f12:b0:499:491e:4b0d with SMTP id 5b1f17b1804b1-499879c627bmr236930545e9.19.1786829986865;
        Sat, 15 Aug 2026 14:39:46 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4999130d9a4sm111435945e9.15.2026.08.15.14.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 14:39:44 -0700 (PDT)
Date: Sat, 15 Aug 2026 23:39:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v13 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
Message-ID: <aoDZrWaC20bfc2jX@monoceros>
References: <20260815082048.4043217-1-irogers@google.com>
 <20260815172712.50119-1-irogers@google.com>
 <20260815172712.50119-2-irogers@google.com>
 <20260815173050.041A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="drgmyt6hkmp5k23g"
Content-Disposition: inline
In-Reply-To: <20260815173050.041A61F000E9@smtp.kernel.org>


--drgmyt6hkmp5k23g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi AXI
 PMU definition
MIME-Version: 1.0

On Sat, Aug 15, 2026 at 05:30:49PM +0000, sashiko-bot@kernel.org wrote:
> > Add Device Tree bindings for the Broadcom AXI PMU hardware blocks prese=
nt
> > in the Raspberry Pi SoC line (BCM2835, BCM2711, BCM2712).
> >=20
> > Depending on the SoC and security configuration, these PMUs support eit=
her
> > direct MMIO access or routing via the Raspberry Pi firmware Mailbox IPC.
> > The bindings support defining 1 or 2 backing MMIO regions natively map
> > the system and VPU control surfaces.
> >=20
> > Assisted-by: Antigravity:gemini-3.6-flash
> > Signed-off-by: Ian Rogers <irogers@google.com>
>=20
> Sashiko has reviewed this patch and found no issues. It looks great!

While Sashiko doesn't find issues any more, checkpatch still does. It
(rightfully!) criticizes usage of LINUX_VERSION_CODE which is unsuitable
for mainline inclusion.

Florian already pointed that out in reply to v10 or v11 (these two
versions were not marked with a vX and I don't feel like doing the
detective work to find that out. Usually you can see that using the Date
they were sent, but they were sent on the same day and both in reply to
v9 (which was also sent the same day =F0=9F=99=84)). Sad Ian knew better and
continued using LINUX_VERSION_CODE. :-(

Best regards
Uwe

--drgmyt6hkmp5k23g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqA3JwACgkQj4D7WH0S
/k7vGAgAh9OCi5rmtHL/MLTSp+jox4z83Dr/Oz5u4Sf4Fu/1aEN07NgJdZFpZd7d
mkVkEbHsHb6kdOzrr+VOHA1kkc6Eiz9VuXkFuC/qgFW9OHPp/hmYcTtOXSF1jGEN
zApJE8qSeau6iuGcC18uHn8ygprg1asloNf9+prmTe1iS/M9di+oDRSq8M5mk5Mp
r60LrdKZim+gtGnlzN/2s9FlgJEZwdxtI5MCjWOfZFgjTi9vjEFbvGY0idXLrEO8
aMSmWdgk+nrS0u3GiXsXiVJo+/cAn+ZcEfkfxUFMaKtnkQhccktg+7AYDGGUpFv6
w9pOo+QPuGcbpuXYV+1KOU9NzkuBDQ==
=Xlbr
-----END PGP SIGNATURE-----

--drgmyt6hkmp5k23g--
