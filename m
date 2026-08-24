Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EA34A773
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553602; cv=none; b=pCUu6Z4EjC6jT3hqhN9BLC03+QmbDoyVdeOk50qYXqUtG5hdkbvrr1FFufM/J/Y3yiK11W/wpgUvO2PgHijUg+VPuVdjFWvma7cdSBeWDxAX7iyPPa88Ab6bSzUcqcQaFjHEwgP1HXImkLANhXNa0uxcdPHGNwLlLZA9EN9saKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553602; c=relaxed/simple;
	bh=HVAf2XINkpQMUKvyqTbfoq8pAxtbeLheH6PUo4xeJrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RoSMl9lqxnNUHxSLyFeSeUMY58ft0XrPD7EmP0Qak3A8K2qSFcbyOAJVzw/n1PKi/K7drGiWaT5TKJcdV+bmwRTWVTBGOrFggcJBhwHgfAT7/WAHKGYBfJucED451mIv72J+HQ3W/1lVFxxUuXoVmvC0t4+xBfGbGWZD9r9mHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9AvPmE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9AvPmE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038AF1F000E9;
	Mon, 24 Aug 2026 06:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787553601;
	bh=4QOJ/g5p5jl87CS+IRlfm6/A1oLPP3B0X55FbZWE9AQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f9AvPmE4BkvrtGIazqNv+xAEtXws11OX9re3CZgoHJrKaToaIEKA7e85tw9FuTxeu
	 4FKdgp4dEiSrcCC+6m3LIQQxD5AmZCH1wlxSV3GSYUS+7El9Fl7QQKVXBhxWlfdoHo
	 MzU2UYU1W7D4aSbeq1xYyEeQ7hl5znaA3y4Lxv5v2MZGrDIZm3dOyi/s6de+wVkAwx
	 cBaRmO0/RFolltmDkNySw9bcTKaDkHmMQ5a4MZRU5wXPX43KyvwgKnQDya3E1XGnlg
	 YPIhfxBWNDa+uezBW92oM950slpnQMJGliOHvKDY0WEe5kaL54/WrXZAnJdskbgtPM
	 Y+2/6/t4EmASQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf libdw: Optimize fallback logic for missing
 DWARF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824062841.1529489-3-irogers@google.com>
References: <20260824062841.1529489-1-irogers@google.com>
 <20260824062841.1529489-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:40:00 +0000
Message-Id: <20260824064001.038AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The modified return logic for `-EINVAL` fatally aborts all unwinde=
r fallbacks on initialization errors and truncates partial callchains.
- [High] Unsupported fallback styles incorrectly abort the entire address r=
esolution loop.
- [Medium] The patch modifies error handling for `dwfl_module_getdwarf()` i=
nstead of `dwfl_module_getsrc()`, failing to bypass the fallback loop as in=
tended.

Pre-existing issues:
- [High] Passing potentially `NULL` pointer to `%s` format specifier causes=
 a segmentation fault under musl libc.
--

--- Patch [2]: [PATCH v1 2/2] perf libdw: Optimize fallback logic for missi=
ng DWARF ---
commit 5f18acea82554e76916d774c6228aad56add9f6a
Author: Ian Rogers <irogers@google.com>

perf libdw: Optimize fallback logic for missing DWARF

This commit attempts to optimize fallback logic for missing DWARF informati=
on
in perf. It modifies libdw__addr2line() to return -1 on "no DWARF" error to
bypass the subprocess fallback in addr2line(). It also updates
libdw__get_entries() to return -EINVAL if unwinding fails due to missing DW=
ARF
information.

> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index f53caee980b0b..7c681b03c6543 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c
> @@ -186,8 +186,15 @@ int libdw__addr2line(const char *dso_name, u64 addr,=
 char **file, unsigned int *
>  	 * between the regular ELF addr2line addresses and those to use with
>  	 * libdw.
>  	 */
> -	if (!dwfl_module_getdwarf(mod, &bias))
> -		return 0;
> +	if (!dwfl_module_getdwarf(mod, &bias)) {
> +		const char *err =3D dwfl_errmsg(-1);
> +
> +		/*
> +		 * Abort fallbacks specifically when DWARF is completely missing,
> +		 * but allow alternative backends to try if parsing failed.
> +		 */
> +		return (err && strstr(err, "no DWARF")) ? -1 : 0;
> +	}

[Severity: Medium]
The commit message mentions that when dwfl_module_getsrc() encounters an is=
sue,
it returns 0 and causes redundant addr2line forks. However, this patch appl=
ies
the new error checking and -1 return to dwfl_module_getdwarf() instead of
dwfl_module_getsrc() on line 196:

	dwline =3D dwfl_module_getsrc(mod, addr + bias);
	if (!dwline)
		return 0;

Because the unmodified check for dwfl_module_getsrc() still returns 0, does=
 this
miss the intended optimization described in the commit message and continue=
 to
trigger subprocess fallbacks when line maps are missing?

[ ... ]

> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 8e954f0c860a0..8283a741c0186 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -176,6 +176,8 @@ static int addr2line(const char *dso_name, u64 addr, =
char **file, unsigned int *
>  		}
>  		if (ret > 0)
>  			return ret;
> +		if (ret < 0)
> +			return 0;
>  	}
> =20
>  	return 0;

[Severity: High]
Unsupported fallback styles, like llvm__addr2line() or libbfd__addr2line() =
when
not compiled in, return -1 as stubs.

If a user has an uncompiled backend configured early in their
symbol_conf.addr2line_style list, won't this new (ret < 0) condition
incorrectly match the -1 from the stub and abort the entire resolution loop,
bypassing any subsequent valid fallbacks like A2L_STYLE_CMD?

[ ... ]

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 63a5c2253174f..69d4585c870c8 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -441,8 +441,17 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>  	}
> =20
>   out:
> -	if (err)
> -		pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
> +	if (err) {
> +		const char *msg =3D dwfl_errmsg(-1);
> +
> +		pr_debug("unwind: failed with '%s'\n", msg);

[Severity: High]
This is a pre-existing issue, but if perf_reg_value() fails earlier in this
function, err is set to -EINVAL and it jumps to out.=20

Since no libdw function failed, dwfl_errmsg(-1) can return NULL. The msg po=
inter
is then immediately passed to pr_debug with a '%s' format specifier before =
the
subsequent msg NULL check. Under musl libc, won't passing a NULL pointer to=
 %s
cause a segmentation fault?

> +		/*
> +		 * Abort fallbacks specifically when unwinding information is complete=
ly
> +		 * missing, but allow fallback unwinders to try if parsing simply fail=
ed.
> +		 */
> +		if (msg && strstr(msg, "no DWARF"))
> +			err =3D -EINVAL;
> +	}
> =20
>  	for (i =3D 0; i < ui->idx; i++)
>  		map_symbol__exit(&ui->entries[i].ms);
> @@ -460,6 +469,6 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *ar=
g,
>  	 *  < 0 : fatal error (e.g. -ENOMEM). Aborts unwinding entirely.
>  	 */
>  	if (err)
> -		return (err =3D=3D -ENOMEM) ? -ENOMEM : (entries > 0 ? 1 : 0);
> +		return (err =3D=3D -ENOMEM || err =3D=3D -EINVAL) ? err : (entries > 0=
 ? 1 : 0);
>  	return entries;
>  }

[Severity: High]
If perf_reg_value() or dwfl_begin() fail earlier during initialization, err=
 is
set to -EINVAL.

With this new return logic, returning -EINVAL (< 0) signals a fatal error t=
o the
unwinder caller. Does this completely abort unwinding fallbacks and truncate
partial callchains instead of allowing subsequent fallbacks (like kernel
callchains) to proceed, which returning 0 would previously allow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824062841.1529=
489-1-irogers@google.com?part=3D2
