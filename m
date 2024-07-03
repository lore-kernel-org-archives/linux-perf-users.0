Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E417DA03
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022047; cv=none; b=rghxW8X8nDqYu0T1Z/byrF97YPm5gSAz9LoWipcModgD4ixKRuA23MZn4tpQpWSnr3/vkkudXbPQK7V8DsHBmpew0kl+scoPtLfpPLnHuQWbwVr6FGkXVUz/qZRJKbRMXXqrDkJWmPFEo4OoTpwMZ6xQzcP3rmS0Jz3EptchfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022047; c=relaxed/simple;
	bh=wb28OCOL6XIgWlTK4F54uD0brSLivRMyb33CBcVWIJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEcowQEJIXWaGksa2ksmaVv5Q3uP1yqFTkiWu7LMjNsKxkkJ1jRfy30x1rof01SyUJWihl/rqTSm8Mmzi7D9yTnbEj/IXNPUtUP5YGeuTHLcTX3JBf2uV999GD2Fr4olOWoMFiU9JvHJzuXlThCbk/TYm/YIYG0totH7CxgisvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LGnrEHYN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LGnrEHYN"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so4084475a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2024 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720022043; x=1720626843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgKAueHAmsvhRUNxEOXMX0TgnL4O49SNBsQJkiw1bnE=;
        b=LGnrEHYNcm1XhC9QN3iw6mLY+h0OlcGIRnjpqib/tVJQ+8Xw8zLI8ZnnjimDrGybiH
         TTa/H0gmI6rKdwYHVB1f9iODuE1QOF8+G38Zs2dKb0bevKf6Td4ms6j8KFAAod4/T8+j
         wsFK5lecg32CDt1ujJHaDTHal6kCDq5wCVpc2z6g5M1+fwRpDhsuTerQBz8zydk0Z3Kr
         1GWJ3ldpNQhsqhOwlHBFFzUMXR40e0tIbjnsRitCVbevpvlGRWZk7YR2kriLOv0AjAaY
         h9GXM6VpV1QKBymHlmdycT4EoJw3lhYU6+bcQK9ssL4PJAIjzgQtkmVOk6ZMZ60ePY5x
         c98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720022043; x=1720626843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgKAueHAmsvhRUNxEOXMX0TgnL4O49SNBsQJkiw1bnE=;
        b=oFHRMRWxzCGZDElV0gg3XZwEQLVn20onrcJu3Efwbd8SxFJqtRuszskX2jeoHsLPky
         ki7g+ZxRhfdLJ6XmP0DlqpxwV2MjYrzgJnx0OaAoh0d+wP/XaIDqIwsWLsUhftyalAhi
         h8XGdAtWq1sUjJDHlQZySYs0JNT1O+eQ5/cErc4ciNuxPj4JIHavYzujUVYZtqa0LgAG
         XIvBGMgnYLCoQewpdj3NptUyZjilswl4X21h7CIuyptgPEQepmik6Ykrpk2FEPnvXcwK
         n1k3e7CGjv9YFB1gPZgK5I1L76Zfz9V1YqOPtvHNioZl2s0fJkyg9udUjMmelVrUD2Ag
         qmvw==
X-Forwarded-Encrypted: i=1; AJvYcCVNznVqfztrGkAgT1EejS1IRWAcLsOjyofMrysnAtNY9rvMAoeUYWPKdc8NFnAd+ueIrSi3fklmDdQTQtc15JeJVIn2o2fmsv2tiLrPote59w==
X-Gm-Message-State: AOJu0Yw7Z8MVHHpUjtBAq2TYRI2XgREK1k7mWDNr2GBaBAaTK9YhqD5F
	auCw0F4zADGYFroAew1ZzRi2YIU1g6ykvUgm163Kq/MqQdZkqflL6C1dP5b6Tac=
X-Google-Smtp-Source: AGHT+IGN8vmmwbPhk2yzHSQbyP4/LzBLPhHVaIwbElW2ruwjQ31vIWu8z1bU27K7fNs+RY0pX/NXng==
X-Received: by 2002:a05:6402:2803:b0:57d:10be:6100 with SMTP id 4fb4d7f45d1cf-587a063657fmr8013281a12.29.1720022042560;
        Wed, 03 Jul 2024 08:54:02 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c834e1sm7201287a12.1.2024.07.03.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:54:01 -0700 (PDT)
Date: Wed, 3 Jul 2024 17:54:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Schier <n.schier@avm.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf install: Don't propagate subdir to Documentation
 submake
Message-ID: <psbxdrh74gsqceu5xtgsuhzjxxaf3vspmgr6kjoz6bz2r6kiig@dc2qgrsk6wxv>
References: <20240523-make-tools-perf-install-v1-1-3903499e637f@avm.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhmzlz7q2j5n55zj"
Content-Disposition: inline
In-Reply-To: <20240523-make-tools-perf-install-v1-1-3903499e637f@avm.de>


--lhmzlz7q2j5n55zj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Thu, May 23, 2024 at 10:06:40AM +0200, Nicolas Schier wrote:
> Explicitly reset 'subdir' variable when descending to
> tools/perf/Documentation.  Similar to commit f89fb55714b62 ("perf build:
> Don't propagate subdir to submakes for install_headers", 2023-01-02),
> calling the 'tools/perf_install' target via top-levels Makefile results
> in repeated subdir components when attempting to call the perf
> documentation installation rules:
>=20
>     $ make tools/perf_install NO_LIBTRACEEVENT=3D1 JOBS=3D1
>     [...]
>     /bin/sh: 1: cd: can't cd to /data/linux/kbuild/tools/perf/tools/perf/
>     ../../scripts/Makefile.include:17: *** output directory "/data/linux/=
kbuild/tools/perf/tools/perf/" does not exist.  Stop.
>     make[5]: *** [Makefile.perf:1096: try-install-man] Error 2
>     make[4]: *** [Makefile.perf:264: sub-make] Error 2
>     make[3]: *** [Makefile:113: install] Error 2
>     make[2]: *** [Makefile:131: perf_install] Error 2
>=20
> Resetting 'subdir' fixes the call from top-level Makefile.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Nicolas Schier <n.schier@avm.de>

If it helps:

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Did I already thank you? If not: Thanks a lot!

Best regards
Uwe


--lhmzlz7q2j5n55zj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaFdBYACgkQj4D7WH0S
/k4JnQf8CASfZg0wOKxCWDtiy8OPsDkN1QPEBE0Ely47vXN7v4w6T53/KH5xPGy7
aM7NyblCIrPYoYJ/GmCC4B8mCHJGWcVKF5NkdKYaREY+zvDg8ojQX8FlnRxmOO32
E8NR2Cf4zPL3cOFzsq+TVpVzhc0AR98qaNC6ossmX91iiHkpN4rGlpyzcZva+pJx
ByRWEbnmqQ/6O3uHpmsj07XcS7RrozKicD8nL23qLns/QzqsGu2yrkGsgsN9nxxa
/94qkvideh6ZASV67Zn+DFD5SHdWnjOwTGSY5rJPF7TzZk0EocgeMPFnOszR4WoL
IPPWOUzBQEED9moydr+qOv5jBgXrlw==
=GooX
-----END PGP SIGNATURE-----

--lhmzlz7q2j5n55zj--
