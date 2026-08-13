Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887D483BE3
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633314; cv=none; b=aQd4p2wY6lsdU0Om+sWhtplmR5UNqImDgQRjsGeNT1FRqDJTTKrOYb+KCfrKAjoSThieMoMFPGd3qoMr5RUpcsBKX0ThkHElsmbYPS6zD29hVGtBoi+Ip7wRfBdDBdoELz0k17JjUF5thMrNUxEPiQjVv1Ql/lzlbKfUnNxmIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633314; c=relaxed/simple;
	bh=OC9IutyT//BkuJs77h0zfNijPHzUCo052/ql5WQ3jBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2MVUxq9QhhPPI/9axjtjtuVL5tm6JkBU4N8vRNwLw+3QCIWF+TibJ+Svg7eDLM/ClRLfxVOWu2iw6tYsVQeUItSIUVBV3Ibp6liBT719L1pQaDAXjN0J38WewdfYcwxykOyRshtFpOWHDFKuBCb1hJbgxDSCfmhpNqvh10Vh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FS90yvGw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FS90yvGw"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954dff6536so213075e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786633310; x=1787238110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7k8Ok3ovsH8z7i16wZyB/9R4mVj0xRZGgmoWoCE0MIY=;
        b=FS90yvGwGhSZ0H0dri15DlTmoCPdKKldeArg8bkQMVBthG1RVs4P7TuL3iIFYvpzhM
         /uRz1jNWJwgCZrNXcWduXslxklw5rV/BhpVtiGUroTA4NG/b+moXSiNhMZL+IGqMZxYf
         FxB5RC8xJD0PJ06rsWzDMwYEtnNU7NdzpyfPxnQtmWETxirRCVI4+/h1ZNn2e39i/A+x
         6Uf0MnekG15hhqG6VpJR86RL0znqbVn0jKveG0ckL1T8FsdOgL4y6md9mM5GTDqQYojn
         iv2/yUE97pNjORQpck8+b5Pu1UzZTsr63e67zIyfYGaSovlNPH44XwTXzNfjVrw8ibHO
         AzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786633310; x=1787238110;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7k8Ok3ovsH8z7i16wZyB/9R4mVj0xRZGgmoWoCE0MIY=;
        b=IDk5iNPgEOLLzwJb9CV+vFehCr1FxqHq9FkJieImWTC4kv4ZgDZMUc53MP6hP9W9Ak
         06wXMTx8uce1sPLDKtcXxB/azwaXPnDVn3QcU+Ffr1PjyaKWfNVAGJGiArYo+ZpaTP9V
         D/o+bYI6OhLALpTBqSyNi4Sh1TlAovbewZNp69XLCKkIfyN4M2BvfYx6+Jmu6f0hgsAA
         f1RMMlfskRSEOCyBKQ3Bbp+YLiSQL/vkVIOoaM2zroRxh5vzbodzusJbh7p3j3Lg0laR
         I9D/zoPVYIogJyTP+9ET08i5+3sp+tyj3ozODgQSlQ+A6DXAIQTrFMYp8PhSxOUZMQ/O
         462A==
X-Forwarded-Encrypted: i=1; AHgh+Rq/bOt627jVtLGqmiFmVl7zDcbK2R0wLAbsKcUASErD2Nlg1cTmdqqo72sJyWq+COZXd4GFcGH1bCRulRgRlzGt@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZSTKJW0InsyCjunM0wpaY+qGxmSH4SWFOigqt3iN39w3Ra3J
	1UeM/UHBHaiEVs+gK8wxJIj+lcIOGYkVZ05+I+fqjNE0hJkUieYq5GxZ6XV15UeTaOg=
X-Gm-Gg: AR+sD12AuVW6bh+aTBzi14IicBIfslTFk/jM84vb9LxtQKtW+WAp2uyvo/i96ZAXt4Y
	9X4UeFEv6HnmPnBMgIW/tCf4/MHQSlsdfrQPBui9vkz2KKr3pI+pR0urLvG4AXNilLXofJ65NEQ
	hWAPhYVI7rpU4xmJw5k5jbQwSNuUJ4laVLMSWFJL71f3EqBim73lBkcnjpRlc5/KHVc22WPmdKG
	KSSt5rGPMEhMwIwBmJMFaojLWNjNipR2hD9GOizH5E+cmEXdaDhpkfzQIQUIwvEOzySHqoZOXtn
	qxZPWe7pAg4t74CHkep3rEooiOQS/yiI+3KsvJTBIsGQH+ADrPl33GaYPZROOZ+8On01v6dgDe3
	jb1HReVZpFYjH01QvSEPPgpIFl+3z9TDshPwx35QC1zrWNldlsobv1IHcS0vM2+EXti6450qliM
	cbMmrjd2vG0A44i6bFazey9USWDG1hxJuGQ6cos7BNkdfP/dmYrAngpOJ7qRyMWEHxsVikMa4Hw
	AmmfQUeLKp5QFy6L+EgbBJv8aBugKnxzkTEksi8j6K6nFS1hMYCze9tmSBNn9h7
X-Received: by 2002:a05:600c:45d5:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-499821d26demr65530185e9.19.1786633310090;
        Thu, 13 Aug 2026 08:01:50 -0700 (PDT)
Received: from localhost (p200300f65f017104a224b5246b1e216d.dip0.t-ipconnect.de. [2003:f6:5f01:7104:a224:b524:6b1e:216d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49981b03cd0sm75972075e9.1.2026.08.13.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:01:49 -0700 (PDT)
Date: Thu, 13 Aug 2026 17:01:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
Message-ID: <an3YAEn7Q0GwiaUG@monoceros>
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck>
 <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>
 <an2DHgfQsQ6TOF44@willie-the-truck>
 <CAP-5=fVOzmzxO2X4+r9goRxtwtWqdR15kPBP9ApSjuP2u6p7Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bhv5kdfh36fwppu4"
Content-Disposition: inline
In-Reply-To: <CAP-5=fVOzmzxO2X4+r9goRxtwtWqdR15kPBP9ApSjuP2u6p7Cw@mail.gmail.com>


--bhv5kdfh36fwppu4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
MIME-Version: 1.0

On Thu, Aug 13, 2026 at 06:44:48AM -0700, Ian Rogers wrote:
> On Thu, Aug 13, 2026 at 1:41=E2=80=AFAM Will Deacon <will@kernel.org> wro=
te:
> >
> > On Wed, Aug 12, 2026 at 06:38:24AM -0700, Ian Rogers wrote:
> > > On Wed, Aug 12, 2026 at 1:27=E2=80=AFAM Will Deacon <will@kernel.org>=
 wrote:
> > > >
> > > > On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> > > > > This patch series adds an uncore Performance Monitoring Unit (PMU=
) driver
> > > > > for Broadcom AXI system and VideoCore VPU performance monitors fo=
und on
> > > > > Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 throu=
gh 5).
> > > >
> > > > Why are you sending four versions of this patch series, at -rc7, ea=
ch in
> > > > reply to the previous one? Nobody is going to review that.
> > >
> > > See the cover letter for changes. They address the sashiko reviews,
> > > you may not see these reviews as they are only sent to me and
> > > linux-perf-users, which is somewhat customary in the sashiko setup.
> >
> > Have you considered running Sashiko locally given that you work at Goog=
le?
>=20
> Yes I do. If you look at the changes you will notice that more issues
> are being resolved per version than the issues raised by Sashiko.
> Unfortunately, factors like the model, context window and just the
> inherent non-determinism of AI mean that AI reviews generate a
> firehose of suggestions that you can't reproduce either remotely or
> locally.
>=20
> > > I don't see any relevance in rc7, I'm just mailing out a new driver
> > > now that I have the opportunity to look at it. Whether and when it
> > > gets pulled upstream is up to a maintainer.
> >
> > Right, as the maintainer for drivers/perf/ and I'm just asking you to
> > slow down a bit. I don't need 10 versions of a patch series in two days
> > when I'm focussed almost entirely on the upcoming merge window, which
> > this is too late for. You should read
> > Documentation/process/submitting-patches.rst which states:
> >
> >   | Wait for a minimum of one week before resubmitting
>=20
> That's not what it says:
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> """
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a few weeks (typically 2-3); if that does not
> happen, make sure that you have sent your patches to the right place.
> Wait for a minimum of one week before resubmitting or pinging reviewers
> - possibly longer during busy times like merge windows.
> """

I didn't care enough to check if respining a series more than once a
week is explicitly mentioned, but let me interpret the paragraph for
you:

Maintainers are busy people. Patch submitters who increase their inbox
size considerably without adding much value easily annoy them (and I can
read Will's annoyance between his lines). A maintainer being annoyed by
you isn't a good situation to get your patches merged, so better
consider to follow their advice. Once you made it to a procmail rule
that routes all your mail to /dev/null, it's hard to recover.

Are you aware that it's Will who judges your perf patches in the end and
picks them up for mainline inclusion (or doesn't)?

So yes, the documentation about sending patch revisions might be
incomplete, but if you're asked to slow down, practise some patience and
do slow down.

Also if Sashiko still finds relevant issues after 9 iterations, it might
be better to seek internal human(!) feedback by experienced people in
your company first. I recommend you to reach out to them, before they
reach out to you about annoying upstream folks and thus damaging your
reputation and Google's with it.

Best regards
Uwe

--bhv5kdfh36fwppu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp93FgACgkQj4D7WH0S
/k5Kpgf5ATTmyu6kJCS0955udpxpXmTJ7JxCYhgN+G1BAAu7jp/u/KY2XWN8bQQS
uEQVZjMCMedQIoONcztXt+cY0IkAASER0CWkgLVDt+QnRjEyZg2QSHg+tkJNJAm2
tTVNZkrOCZsFU4+MIyBhPcySLotLA9mJsCguyI3XL+EKmoYbvQUYi7SKEooq4g34
nYmbCPL311rCBRe88Eb/oBMexpUQdCwzIf33DfApU2ASTxYBtxYJOic77El4uzjK
za8AV7iEavsb6xJFvzam6s9pSenpQCQg3w6J9VJJxtlTRybRytrKHjd8f5D5rJg7
53BVklIR3Y+A+Zz6cPPuo1Yevq7StA==
=tysB
-----END PGP SIGNATURE-----

--bhv5kdfh36fwppu4--
