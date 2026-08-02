Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23233F582
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704912; cv=none; b=Lpg91TSqHGsyYTgLQqn2kFtkhLk4F/s0g0KlvK026zJuxw8f5vlVYCZca+XMT49dwlInE35Y/mwfZ7FhSADD7ifX5SbtLVMnAuRihK0yMZeJitplK+ykoNdH+WYg8OjgW3Zdh8FATM/vAmc4yTRW2TAV7zfHArexHxzmJiK5QM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704912; c=relaxed/simple;
	bh=V5r7QIrQPvds6l+pD3FjfXC43XlRt28TuckiYHbmcJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUbftqFdM0Z62aRm76GDaGqjH7G635E7GHEMeijCnuoEgNo8TPDbhJoJ2R0b4bSs9XgmrEH2c6zz7FtFRR8Dni2HyR/YrHbozTVhq2NHi0JNbNLPbErN4Ah5fWhUyb8SNZKmIQNkudfLmlbWCXuEV3JE6MkINQ7YWFSU9KvLu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCkM/bRo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCkM/bRo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957eefd361so9632035e9.1
        for <linux-perf-users@vger.kernel.org>; Sun, 02 Aug 2026 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785704909; x=1786309709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fFuId5/et30IIYrYQj18+p/LDPIR45GxUSBdCpaynGE=;
        b=jCkM/bRoilSuD9BlBxZyWj1a9HuDTenH6psopcH2fNfI2kL7b/mnB4KXG8R/M0F8Z7
         G+me/lmHhKvEejxPsyZurkED/YOZLMZmajKznAKkbK973pzmAuv9t46Griw4nJ3b+U3n
         Ng/HOI46RCazvsOn3wGWDTyS9H4YVGIJShxpwCAsYtgqZqcAvlBijJxnCkssKHkYnFDe
         oap1CsJk43zmfmyQ0VM+jLyNjKwXl1avsLgLDIqj3iSBDbQrySvXOYFphEqH0eX1WG8W
         bUN2z6vBSAj581mkTKhUIJTZtIuzR5mnKupL/JrdG479jKaA0OzxYu+zySeNE0lOOWap
         77EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785704909; x=1786309709;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fFuId5/et30IIYrYQj18+p/LDPIR45GxUSBdCpaynGE=;
        b=czIxw3fTC0yYALqhDasjXYH4Mmx/8XKq6vpfTnIx/h2Qj8q9ZE4N5qZN8xIZAdwPoR
         x86/ruAXm5z1B1C7aJaWaR/abnITB7vDGxl0pabzhCi9YA7Yr00Wtpw4H89S6sE1j8EA
         Aa6UbcGgIn45nTnrSb9C5nG63fGJA+/aR0eFI8kXY2tt2xZM/BbA5UWS948w6WkzlIMc
         7WTVjF8vURW0hXrBajlux5WHW6LF57RHGt03z2jssP2/t8ssbqgQVlaB32QgxyBnD115
         14sJC7iC6snjaWlUr//MNm/d2IJyGU1cb8ufC0cBXCH+GZAEc9FtCyDw/d8lk9Z+WhzG
         Xbuw==
X-Forwarded-Encrypted: i=1; AHgh+RpDZ4Qhk68U72ZTRU9vGJ4mC7pojS1myFFP4BHraC3kc0BwtW2nTyugUCd2yrEvPGFO8b2nHC/Z45vMJAK+Lgj3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GNqFT3oWXDVa73pQmD3WhA6qjh0145DcNMTdMdY55xYQWLQj
	n9ph8YTRDeP2Y0/oO3R8TqvnLAshxcnC/5j5Puc2ylBvSu3POuFtOwLo
X-Gm-Gg: AR+sD13jvJ3YJrdodJGwivIKDMPClGhpzGsPeWxAUhlgEynxw/38+wfjOp9NKskWXL9
	OuNOULVPx4XSnzbw4d0f11l6AIgPkBFbKgnF3DMubkYdJDsBF2WcABuLjYsUULlj2FMRnb3YnGC
	QQoH6xr/BcQ1UYN8O1Lt6dEfpW0c9LMLefbrD86h4RyQCmE7nYN6X3AKtW3GAFfGzWuJfIgDcra
	ay4OdOm4HYFWlvc5yxbAAxo/6qyY14A8J3bV0rd5ptO9OwEchcADyHw9gMGkrUqjXi8gbANKzvL
	hNWRj91hsU/x5BVQH1nEKz/FvXFfuOBtL4/fnEnBkK/MLvfbjDOuEYF3ai8a4yts7qvEuCLZ0ip
	9T6Fz30p2uwm8iV20Pm07kZichUzd2zIlupSJXoM+jaPVfeugpraOcDTYA/An+vqiFSRaizrsCr
	dphZM+DU+rjcg6sHIw75alljiI6PWpER41VxgH/6pifw5XV2IQpvwOfoqQq5Kx/Qwcu9W7NCnUM
	E2Qsx6lFEVa/NAMWqfbbf1usA==
X-Received: by 2002:a05:600c:840f:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4980c5fa29amr140848065e9.0.1785704908822;
        Sun, 02 Aug 2026 14:08:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808691014sm163988045e9.11.2026.08.02.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:08:28 -0700 (PDT)
Date: Sun, 2 Aug 2026 22:08:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo
 Carvalho de Melo <acme@redhat.com>, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 1/5] perf dso: Guard against errno==0 when
 dso__get_filename() returns NULL
Message-ID: <20260802220827.38ea6e32@pumpkin>
In-Reply-To: <20260802142022.154219-2-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
	<20260802142022.154219-2-acme@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  2 Aug 2026 11:20:18 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> __open_dso() computes fd =3D -errno when dso__get_filename() returns NULL.
> Some failure paths in dso__get_filename() (e.g. binary type mismatch)
> return NULL without making a syscall, leaving errno at 0 from a prior
> successful call.

Except that errno isn't set to zero by successful syscalls.
It is only ever set by ones that fail.
The application may set errno to zero (eg to detect errors from some
library functions).

So paths that don't make syscalls will be returning a 'random' errno.

	David

>  fd =3D -0 =3D 0, which is stdin =E2=80=94 subsequent code treats
> it as a valid file descriptor.
>=20
> Fall back to ENOENT when errno is 0, ensuring fd is always negative on
> failure.
>=20
> Fixes: eba5102d2f0b ("perf tools: Add global list of opened dso objects")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/dso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 2309196d8df3111c..e087a89066bdbc02 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -643,7 +643,7 @@ static int __open_dso(struct dso *dso, struct machine=
 *machine)
>  	if (name)
>  		fd =3D do_open(name);
>  	else
> -		fd =3D -errno;
> +		fd =3D errno ? -errno : -ENOENT;
> =20
>  	if (decomp)
>  		unlink(name);

