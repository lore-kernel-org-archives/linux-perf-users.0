Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235863;
	b=5PFIdkHmcHAOvX4AC68y8YUc8ZozmeSAvx9kxuMkKSZzrnq44HZ0Y+saIXzLXoZ78WhN
	 e2MLhLu0M6917oSkLY8UayGtWt4k2HjsYcHG1yv9zgoAeCgtGBfPA0pCLIJ/HVhn77Hli
	 lBNskLSVe5aZQpgje4cBYeg8avjpN1LDDLGGtQVpXOpdfDF16ltSXWUwF8f74oys1rjBW
	 w51IBfJguzkxakco/bqpEU4g0dUiP779F4Hsag+2pU/GfxUYdnd2tVStHbPpBQ41MPITQ
	 XVa2z28ynh7NZTktXYwgsuZh3yp2M1J/Fc8s0OvfMyUILG/v6jBxbDq+1q4mxy5sjuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CGtLvQDn/oM0uFkZjbQWv+D7aMDQgAXlsk+0K50bsxc=;
	b=kxK77XLvBIULMzL6vZEYtkcfalu+OiqJk6uahemUKW5MK7zGMmQBY0euDhETU24yajDK
	 w/AWcXBxPVqfvRPDt/lxrYJj3D4eqY6lHXgqXQw2SqX/iEF9USDp21y4XY/t2bqOetOsO
	 XAas2UHMgOpK6Q3kw6jeWrBqv/DAcfY/eLBFHb2wLJ1yks58i3cScuLpyq0cDrPeVkE2c
	 ooXHq3zCLunXPgMkqzlsMdPwJJ7GI3LUIKG+Y2t6FRKe6paoZS8lIunTQemQR8C2ws8uI
	 1XVC56aTFwpf+fK4pdSBPyzPa0kOPXTascLScIVWB945ZhSE4SFBRev6gec261ij2RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0JLEIvk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F803606A323
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0JLEIvk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3241F0089F;
	Mon,  9 Nov 2026 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235863;
	bh=CGtLvQDn/oM0uFkZjbQWv+D7aMDQgAXlsk+0K50bsxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0JLEIvkd1nb86eimkfIAK2aZ8vmZLwkeXjF4bYj9AA/YJUFnBm6wU8qG02dzLppx
	 DwFL8Rd6T27Cwom4eE2VGcbKwgmdowIVEx0DlBZi3qByH2wNPlOXZ9pQ9KSlCkWNQn
	 uDmH+IT4K1P/iCHGV+YYDhyp5o3KrOvsL5WFD/QD5ETdjGv50GPYoAadLo1qp0l+fC
	 O6yyS7pqGVMjQLtdxTljURwHrmTk9CE/MuIZ6HIpmAIc4XNHidIGMKuq1qgKU0TCNZ
	 tajVy8PD30KeODUrHNGpUnvLakEu7IGwzymGuduiqNQAAsYuUynH4zYZdu7SsLaRYl
	 2cPX6GCq8dJlQ==
Message-ID: <sashiko-outbox-205131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf config: Use va_copy() in perf_config_scan_cb() to
 avoid va_list reuse
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyacOhbiBHYXJjw61hIENhc2Fkbw==?= <adriangarciacasado42@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109144210.1626450-1-adriangarciacasado42@gmail.com>
References: <20261109144210.1626450-1-adriangarciacasado42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:51:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] perf config: collect_config() already deduplicates keys for
  perf_config_scan()
- [Low] perf config: missing explicit stdarg.h include in
  tools/perf/util/config.c
--

commit f3806a1321b205e48a7070a279a393d0ecb60054
Author: Adri=C3=A1n Garc=C3=ADa Casado <adriangarciacasado42@gmail.com>

perf config: Use va_copy() in perf_config_scan_cb() to avoid va_list reuse

This commit copies d->args with va_copy() before calling vsscanf() in
perf_config_scan_cb() so that repeated matches on a configuration key do not
reuse a consumed va_list.

> If a configuration key queried via perf_config_scan() appears more than
> once (for example, in both /etc/perfconfig and ~/.perfconfig, or
> duplicated within the same file), perf_config_scan_cb() invokes
> vsscanf(value, d->fmt, d->args) multiple times on the same va_list
> without reinitializing it.

[Severity: Low]
Can perf_config_scan_cb() actually be invoked more than once for the same
configuration key?

perf_config() builds a config_set via collect_config(), which looks up
existing entries with find_section() and find_config_item() and overwrites
item->value in place via set_value() when a duplicate key is parsed.
perf_config_set() then iterates over the deduplicated sections and items, so
perf_config_scan_cb() matches d->name at most once per perf_config_scan()
call.

Also, perf_config_get() already exists in tools/perf/util/config.c to look =
up
the resolved string for a key; calling perf_config_get() from
perf_config_scan() and running vsscanf() once on a non-NULL result would
avoid perf_config_scan_cb() and storing a va_list in struct
perf_config_scan_data altogether.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 287401f159e66..f567cc338ca9d 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -1091,8 +1091,13 @@ static int perf_config_scan_cb(const char *var, co=
nst char *value, void *data)
>  {
>  	struct perf_config_scan_data *d =3D data;
> =20
> -	if (!strcmp(var, d->name))
> -		d->ret =3D vsscanf(value, d->fmt, d->args);
> +	if (!strcmp(var, d->name)) {
> +		va_list args;
> +
> +		va_copy(args, d->args);
> +		d->ret =3D vsscanf(value, d->fmt, args);
> +		va_end(args);
> +	}
> =20
>  	return 0;
>  }

[Severity: Low]
This isn't a bug, but tools/perf/util/config.c uses va_list, va_start(),
va_copy(), and va_end() without explicitly including <stdarg.h> at the top =
of
the file, relying on transitive header inclusion that can break across libc
headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109144210.1626=
450-1-adriangarciacasado42@gmail.com?part=3D1
