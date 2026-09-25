Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4A4F30E3
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369667; cv=none; b=Y+sAunQsYQI1OUTALKk05rUU+CDjD7KfrdLmhD9sfoBBzl9nycV5rP/1K98deswdFkIna1QfdAcyfSCX7nFIO7ubp+GQ06gG/40SJlXZ9UVVrPumujJnSem6Vv2WFw17YRBlfEf8gebxWOdYBpvJnPRqCSCCqANm4wNtGI7aaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369667; c=relaxed/simple;
	bh=CUiwE2ZIJGy6OidkpudPd7puey3qdslQ/sOSyoCl0GY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYkMK/ZcvY+bBlFzX0X+xGHBEBjAdUbXtAXP4aVnC3vY/655JS+x3nvTHd7go1svsQI0xPu9kRQ50lypJxQyuVPniwpPaLju6WYlKc4xP6XyXViJgvdak+7IwBgwzboXa8T/Xg7iPYaY83J43rDMQGfFlDGWpr9G3WHvpW6Bmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0CT691i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0CT691i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F711F00893;
	Fri, 25 Sep 2026 20:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369665;
	bh=83whQpPMknJLjzelTig8S3lpBgw4mR+DU0mNOqpvZxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0CT691i1Q0XSN4egglWVHfx5fWbk49yKHTblBv0iE0cQO93R7r2i9nFprp7IsOb0
	 YaMmo/b64fB2hgT8kH8pINOh0prhbrbCHMKcHSqN8lpSnAl4JJFxS4AJbz5GKoJ5/G
	 PeEoDLwFW8NTyMUwGF92re/MBRnBWZr99BbjNsIGqSrwTyTGLsMDzb8y72BveZgpFh
	 VVxXHw4Y6e7PJ7MPUldIz98gYlz2j2p1qS5ixYRqFbM1kFgJU1W9JO73aUQ52WwppH
	 QeYOCoJYsVl+S6UX33HtvW6Q8bp/LczibOqBYVXsJcu9Qrv1YuKrHu/Oz0orx5Plbf
	 g2jIy2vODyj5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf: Fix Python 3.6 build breakage in jevents.py
 and util/setup.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <arbd4TJm4s9MVjN-@x2>
References: <arbd4TJm4s9MVjN-@x2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:54:25 +0000
Message-Id: <20260925205425.84F711F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf's build still accepts Python 3.6: Makefile.config only rejects
> interpreters older than 3.6 and jevents.py keeps its own removesuffix()
> shim for it, but two recently added constructs are evaluated when the
> module or the function is defined and only work on newer interpreters.
>=20
> PEP 585's list[...] became subscriptable in Python 3.9, so the module
> level annotations in jevents.py make Kbuild die at import time:
>=20
>   TypeError: 'type' object is not subscriptable
>   make[3]: *** [pmu-events/Build:176: .../test-empty-pmu-events.c] Error 1
>=20
> as seen on almalinux:8 with its python3.6.8, and the list[str]
> parameters of util/setup.py's functions fail the same way when the
> python binding is built.
>=20
> [ ... ]
> Fixes: cda907c2c3f99 ("perf jevents: Add python type annotations")
> Fixes: 1fa8d81be1eb ("perf python: Clean up and restructure setup.py")
> Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-co=
mputation in jevents.py")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/arbd4TJm4s9MVjN-@x2=
?part=3D1

