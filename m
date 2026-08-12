Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98A38F64E
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551973; cv=none; b=vEj/cln37gIjy5M/vY1p82YXeJEclWbNzB4TZAjkiMzS5TVG0JMkcl47mQKFKW+FxjY+F1qLaqveE+5prA+bOsMIf96Oc49aCmH4dyRrz3BM1MuPr+CrK7C/b0pLx+a909bDcz+5RVrziwfEOQ3pWoDz5jPWB0G8ibEWa6/rZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551973; c=relaxed/simple;
	bh=yfDriKHlKJPwI0qKyg0STbkkscByIZsyJZCbFgT+ZwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8vvFG46YpacSFcrtvFsSOxdggfvYXTgAGyCYXePtRWKIjHC+l7iVeYzCcpc3gPdTaIpKRGJ6bAI9Nw9+JOY6IH8Gl2suyRLAj3FmmxFs300FdoLZ4l9IPePYKB/BLRHJ8mnVUs1BA0jbe0CekBEK1vqk3Hj2s947N+wicatS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Iq1TytTS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Iq1TytTS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so11493075e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786551970; x=1787156770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yfDriKHlKJPwI0qKyg0STbkkscByIZsyJZCbFgT+ZwI=;
        b=Iq1TytTSvMTk2H3Zj+BXfrBmaM8mvQjv2DUoq7TqoBunbUp2BWWUcoWjGLqvcS0cK+
         ZeHKbiZeQ+t6SRSJlnssfXoYU6Y6QQyItiqb/wyRMwfhbWuEd0QDeb93aDgHWFihOClE
         TvrFUICy/v3Cq9aJZr9/qhwEdWTrZRZygJxr5E6apKlVLeVhYK6uNdlQqfMRrmbt8xcN
         aETx6VquMSXfBR5d98qurKxJ2D3oo6k3ezUIe6vDsZjuVZEOqugnbjqQKV9rcpjQb75p
         RHWUZV9pH/leLQzohKhakXi5Or74gZEQVSsgmxd4/rh6bwzbicrPlNm7HaTTyWj1mEYn
         26kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551970; x=1787156770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfDriKHlKJPwI0qKyg0STbkkscByIZsyJZCbFgT+ZwI=;
        b=n8sg2+YYxL7UyAywFRh6POAicurJYvxymxM7hTcRJRnlNrscE7vBkaD9m0Evbzpp6/
         MoeUVKDQNGRL7sLS+UkQU/W0a6zqAkGxDBpSI51Q7HNjtu7jQAVtOm+0s+TEgcSN9jQm
         SZC/XYngNUnCTDJUfzdg3Sc/rAUeRh+mZkkJX6q7+an4c4suDWMKtxpkGp3d/RKQbZu4
         6Mj8r5r8rvgsL2/W6GySscdP4lm+w5iqBhrCiqAyjlAk1B9vTo3T8oNBt2aTQoTmdInR
         Ma0W5Grh/iyP6vJYN3B+EFE8CVRUgyRNIRZETD+Gy1CH2InT3gF11baa53vyjOF+TcX5
         yhmA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5mgqiPgiFeIOgyZJxUfw5jIpgVj08biBPOLrgi7AqBTg0PH3y62XC0XIdntYAcSEBKOdumLQ+1tOnP30UBo+D@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DQ2iJc2LzZuvHvm1b/SPYg2WiHsCA0Hm0UP9OMezcL3J6i+4
	KNXQZvlERycQ+2M3BLbi/5UKqZF1BQGhPhDnenEBaNRDKhC7yBbor+CNuNIghOXErQFGwTS7qcs
	Ei+RKtPM=
X-Gm-Gg: AR+sD11S1XUnpFYueL0arZJUsPOm7//TbLT6zJrKGFhZRWVfxWOHp+Lt5PZ1oYt5Wt2
	JB52wNGCOV/n5itAyjH8JTvOknxZ1d9F3OFIKmmDcVbU4n9WPqbyQUq6i1wfR2VWEuVl1kcGQB/
	mVYDK+syZlvfRjgGIACzcwJ1CDnzriQBqEdN/0C8bE/WX2ELvRrjMHMYQibDbuf1VfoqQ0LaBLv
	V0wMuyWhx0DgNbEQ1JVxwJaciWlN3pspwJyJXpVG80T9ZuEuZ+PiyYEK/Bm5DP27qKGd9e0r/4/
	GzCgzsy63QfNXDxvKu48ie2YKyzeYuR8Xw+9nVqfVEbu4dV6uhqO32DMS31j8CM5MWno/m6ssvQ
	2aWtn3pB5y02VaCnJuKnPSBrCCb7F3wYwRzx/Lyw8NqMxtxR8QKTZX4+KkHzaPh/mGSdO9vyXEt
	aCyIN466u9FL529CUnIJDwMJ06le3l0gN4IKU2q2THdn+omgzWhQe+IFAsvQ4DeV2uXFA58eV7n
	yPHwdTzfy4KRugn5THcwPsMUQYncBJa0U0iIumWludjkdqn9kE=
X-Received: by 2002:a05:600c:6012:b0:499:81ae:1020 with SMTP id 5b1f17b1804b1-49981ae1070mr1584685e9.11.1786551969802;
        Wed, 12 Aug 2026 09:26:09 -0700 (PDT)
Received: from localhost (p200300f65f017104d14d09407ec2ee4e.dip0.t-ipconnect.de. [2003:f6:5f01:7104:d14d:940:7ec2:ee4e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49981abd6desm1552825e9.0.2026.08.12.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:26:08 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:26:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
Message-ID: <anyd_NS4D8KRIuEW@monoceros>
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck>
 <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7sx3vsomhyj6zol"
Content-Disposition: inline
In-Reply-To: <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>


--f7sx3vsomhyj6zol
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
MIME-Version: 1.0

Hello Ian,

On Wed, Aug 12, 2026 at 06:38:24AM -0700, Ian Rogers wrote:
> The changes are sent in reply to each other because the entire series
> is visible in one mailbox (b4 mbox), which I find easier to work with
> and provides me better context. Others use semcode to do something
> similar, but I've not explored that.

The usual recommendation is to start a new thread for a new revision.
Depending on the mail reader (configuration) new mails to an old thread
might or might not appear at the end of people's mailbox where new mail
usually lands and so might be missed.

Best regards
Uwe

--f7sx3vsomhyj6zol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp8np0ACgkQj4D7WH0S
/k4VQwf/YxOBBigksYFgF22jLmKVsFAaZptWFZ4gVjHqa7XnIkPvK/AFnjSipLEF
fUoUkd3vnJurJVn+Z9Agg7O66DLQ5ittOVmYJj4Abq1mwqYGycZd60kfc/2ULOZD
WRvK1oD/9wV3CFcmfHpmEdTB6lKOx+Cjlw7zXewYZ2lej0pp2BPl4pFB5N/c+ZxH
vXvYZujyIxk0W3PK08UukO2BqpSgVZx7Rz9STDRHPvypvUTcusMRl9dtWGepmmyu
AYWdYKpQtSjZeaXWgYXVqksQkIfP03QirRaq9ZntHeQvSZ8ogNiKUjBbG1wC1zhp
BZf+rGVBObnlJFRc0ldLhPETdUBHag==
=S6yj
-----END PGP SIGNATURE-----

--f7sx3vsomhyj6zol--
