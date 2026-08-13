Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF294314B5
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604354; cv=none; b=t8w7kpqMdT8fYC8H0wxL02k8N3cpC3S2VPl+FojtMXX5Xqq5IXxkPi1pWGoAQbWQtFzWGuq0IKSEc6+J4uQsnTo+5qwjtogcikgJG10KMcx1iIefOp5VTeKRO17kWlPqXQoD/OeTC9oyK04BMRQtEFqUuzZc5MDJjdXpsXsnxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604354; c=relaxed/simple;
	bh=3BNLjiFIOG2P1Jvd86TR0xlX9AA+JzbF7W9zKST6qIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbA0fgUbbbYyO500Z2C2c9CkAXmqPF2SDzAZX1boKxe28QrtGXwhBBIMy3MniE85BWTv82v1HUMIbINst6k34pNbVokHV2EaeN5hDhjP8pFgsEUZuo2OQlVAqX0dnu/xprJkELsDr9IVjLR1ss+3oX60Wmd0vU2fbV9ZxnYsODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PcGcUwor; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PcGcUwor"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso16103445e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786604349; x=1787209149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BNLjiFIOG2P1Jvd86TR0xlX9AA+JzbF7W9zKST6qIE=;
        b=PcGcUworu+Iw6DQ0J0OWAzYgdvc8/9jRtaPJrSA2Umh+Wfc15xlaHo5q20vNQBKl+v
         FdHHRqW4gPvzqtfwYoXvdrk7iDd/WIEPJmHIh9xT5ZVbnX5BJRDcARDzvkzElQwC+hH7
         kOECdMO1QuBbv+0j8MoWkaV8TApLUzw4doozLTVrgiLfAjaFLCv0b55P96sAj9Pj7NFX
         pBgJg/ZjyeH7b5P34Sw/CLmT3LT0mNYq6aBFVGxAptyyKnUp70FCOI37avntZKY+sDMU
         K1WTp2sYYH4oEssNi/pE6ffMYeOQbvtXOPWZEW7yOUvuIYUyrbNcyKBYCkUEjRnGgenx
         oRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786604349; x=1787209149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BNLjiFIOG2P1Jvd86TR0xlX9AA+JzbF7W9zKST6qIE=;
        b=fSEViAK/muBhGmqFe18JS9kfSWT4zx/issfnZus8b4aJVBSHfHUlV8pMc38IauglVY
         7vVuMxcR3q6va3ZeiUKfrzUJmAXyit+RisrFFhO2kOBmy0cy2V/sX5hvUrEkG9ALZv6T
         EuLAIVZHMHIuHE5FgL8MwhiEnvgV0g6fZPIB4saQtcIet02YKxF2KiKjQ5lKAvamb0au
         DHSRoXvHv8AI5KZc5osyIc806UlYqR7jyIyox42VNYvwW5B109kssK90PiOmMUWGreYo
         a6Treb74PnUIp6RwXemgt8wQXnWoDH/stwaFQnyPu1ZYIeUxN9mJWRNEosiKynV3wZdV
         BC/g==
X-Forwarded-Encrypted: i=1; AHgh+RrxJAJ2Z0bCBgRrpcJPhdQR1htDVvIaI733ZB41But+i3bf7Aj7oi4AdLuhuFUj4JNSxv0L0/7AyquY82Y3u3VT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53KtN6vzZTbIxcUl3fOJ31SLhmcdS/AwTP1J9DqWclj9BCic3
	swIdK7+uzzNNh0m0ql99BnbJR+4nNYslim8RoGHAoC6zwgk/guXzoWedJPTDZD8gnV0=
X-Gm-Gg: AR+sD13E3M5p21uTKRPIPrAWwWLItdtXtY/teE7H32v25kKRLTCStiZaMBap0N+26cf
	+WizuS9y+wSm63BWnrNAoNeASC6WUnyuOkFhucFUxut2r+J0t5toX1WRW1/PV6Wb+MS8V6zU74j
	6y9lW3Q86tjXgUQPVBQzcYBxoKLdWzrOfUJIS4PdNQXdyvCsb1C9rnM6iTVk9RHZQ52SuCKK2oZ
	amdc0z6p2PVIhX0rpBCliO2oVkMdp4PBzhYxURbUJa5G3i3ASZKUxa9NsN6GGkGBZG42Xzugjr3
	IkDAGm2U3pyR6AO25B0Z2pNeRKaonoISJP/Z/t1DlATy1cH3iVv4r+RbIpv0HkUGHnYOOgasH+D
	VLAJRYAOz9kV4m4GAytuNFX4shrlSoOtrfe8pQD0kiAu3sCpnRM+6u9QOP8w1OC9XbqXkSYZi7Y
	43MpKpTqe5OdII/y63se1LOd1QcqNO0Zp0rsJIo0w0V7VXQ1vvT5Yni70QUk92eN3G1w==
X-Received: by 2002:a05:600c:1d1e:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-499821d295amr35363365e9.13.1786604349134;
        Wed, 12 Aug 2026 23:59:09 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49982165351sm33566005e9.10.2026.08.12.23.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:59:08 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:59:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
Message-ID: <an1qE5g9GW7OJceP@monoceros>
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck>
 <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>
 <anyd_NS4D8KRIuEW@monoceros>
 <CAP-5=fUrvxsJ09BtPy-3beSoypBG6LaNjX1iL4aKMMEC8LaH2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gi6uudmibuugdytf"
Content-Disposition: inline
In-Reply-To: <CAP-5=fUrvxsJ09BtPy-3beSoypBG6LaNjX1iL4aKMMEC8LaH2Q@mail.gmail.com>


--gi6uudmibuugdytf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
MIME-Version: 1.0

Hello Ian,

On Wed, Aug 12, 2026 at 02:37:32PM -0700, Ian Rogers wrote:
> On Wed, Aug 12, 2026 at 9:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Wed, Aug 12, 2026 at 06:38:24AM -0700, Ian Rogers wrote:
> > > The changes are sent in reply to each other because the entire series
> > > is visible in one mailbox (b4 mbox), which I find easier to work with
> > > and provides me better context. Others use semcode to do something
> > > similar, but I've not explored that.
> >
> > The usual recommendation is to start a new thread for a new revision.
> > Depending on the mail reader (configuration) new mails to an old thread
> > might or might not appear at the end of people's mailbox where new mail
> > usually lands and so might be missed.
>=20
> Yep, I agree. People who configure their email client so that a thread
> doesn't move to the top of their inbox upon receiving a reply are
> prone to missing subsequent replies in that thread. I suggest that
> people in that position change their email configuration, or use
> lore.kernel.org, which doesn't suffer from this bad configuration, for
> example:
> https://lore.kernel.org/linux-perf-users/20260811083828.2057695-1-irogers=
@google.com/

And I suggest that patch submitters read and honor the hints they get
=66rom relevant members of the community, to make their submissions easy
to work with and less annoying. And no, the solution is not that others
adapt to you.

Thanks
Uwe

--gi6uudmibuugdytf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp9azgACgkQj4D7WH0S
/k74TAgAgl/E9K/Ppx9iCIHf2mu930Fj3swFvVkP3RocXwmv1+UvBqbTGgDLHzuw
r27kX7YVEUQkqPIiVONTD3EQD0JYi4I/oQZpWVFdDPq/RGXQXFlbLlbmOJyQbe6a
APmnD6QGm+CyEXc+YBLPBJD5n51Z40sh5zUq/jVyDGIgRSwNHl6L2zeK/FF89nuW
sWoSvNY9kb8APqjca6cuoZ3l4pKgSoKEP1eLKJvfctTa64JJQ8iv+NQnDtsDAwtf
8h6sI7+Yg34qr0ZalF8MQHDYNHPlusp81tqrFswP89QVVZ1eF0cgJ8M8KQlDx2zo
8WgbGX7VozEa5He73YAL0SiAX0AjvA==
=vp29
-----END PGP SIGNATURE-----

--gi6uudmibuugdytf--
