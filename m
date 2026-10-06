Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973893CF20C
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331056; cv=none; b=R/9J3f8DTmFRrXUemrzxQyT4lD2y11JwpXlzveSTSIIv2xXZqv4U7rYzg/DEmcIo1IhcwS+wpoK/S7UAasFTctrQlzqkSK5R6RlDvVddLhmBLsZ9IWaMhPTCZTGclUfpkzAREvaQIjXvFTmhOZc4AuIUvgAs1hJhy01xoq4XVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331056; c=relaxed/simple;
	bh=xMlWH8kBJ/rOVAb5xfwzLQ/UL8r3f3as/yLn3gqLXYQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ur+KDO0KnCHzySwualja8VhDyugU4JfCS1hmJcS7+T0IU8WNLC7i9c5ToEUdli9cNAgLe9FS4giJjJxwTABwkowajpqXVyUfQTFFRz1ogEFetx8JW6gJpGu/dytmCainj7w1YZHzMwazz/iPuMGW0BiVuyLtfyO9ElILBr1gNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIA8kn0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIA8kn0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D36A1F0089B;
	Tue,  6 Oct 2026 23:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791331055;
	bh=X0Tk039E6cyM7MEPtEfINjcgbju3VzHDEcGDwVNldJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIA8kn0KLkKQ+yfQk/1Rbl8mKT1hgdNTBgRVQ1l5SS5Bg0mZkLJKrKje6Exx+HN4U
	 ALZY5Ijf1rME3tkMgsFOUypumH52cKeQkbgHk6kWbtrjfG95S+sCpugtjljdRXvz5S
	 UiuijoJGwj9C0A5TTHGdyqgsh4m8pPVqcgOI5bKZuYZcHE2m5dUKCGYMctzZFxJSwJ
	 N3n0pqqiiNVn99HKGdPhchieI0qbq5YfrAbqYMcEOke1JLqrFo9N4zC8UsiBd5uIMU
	 z04jhvn72Hm8LJnZdsmKLHetHCTLX2z1sSOPxJul4aCZVMGYjIXBDY/r4c3TrTzuXx
	 vIGec1UYb8SWQ==
Message-ID: <sashiko-outbox-162540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] perf symbol: Set dso symtab type for libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-6-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:57:34 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: dso__load() returns 0 on libbfd success causing map__load() =
to discard first sample
- [Low] perf: unintended fallthrough to dso__load_sym clobbers libbfd symta=
b type
--

commit c31089cce4c931915ffad7363dd2a84096e2a4cf
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Set dso symtab type for libbfd

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fc6e4dff282bc..02b096ccbc60a 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1933,6 +1933,7 @@ int dso__load(struct dso *dso, struct map *map)
>  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> =20
>  		if (bfdrc =3D=3D 0) {
> +			dso__set_symtab_type(dso, symtab_type);
>  			ret =3D 0;

[Severity: High]
Does returning 0 here cause map__load() to discard the first sample?

Unlike dso__load_sym(), which returns the number of loaded symbols (> 0),
leaving ret =3D 0 causes dso__load() to return 0. The caller map__load()
strictly checks "if (nr =3D=3D 0)" and treats it as a failure:

tools/perf/util/map.c:map__load() {
    ...
	} else if (nr =3D=3D 0) {
    ...
		return -1;
	}

Because dso__load() correctly calls dso__set_loaded(dso) before returning,
subsequent calls to map__load() hit the early success path and return 0.
As a result, does the very first symbol lookup for a libbfd-loaded map
spuriously fail and cause perf to discard the sample?

>  			break;

[Severity: Low]
Does breaking out of the loop here unintentionally clobber the libbfd symtab
type if syms_ss was already set?

If a prior loop iteration populates syms_ss (e.g., from an ELF file) and a
subsequent iteration successfully loads libbfd symbols (bfdrc =3D=3D 0), the
loop breaks here to return the libbfd symbols.

However, since syms_ss is non-NULL from the prior iteration, the post-loop
cleanup bypass fails:

tools/perf/util/symbol.c:dso__load() {
    ...
	if (!runtime_ss && !syms_ss)
		goto out_free;
    ...
	if (syms_ss)
		ret =3D dso__load_sym(dso, map, syms_ss, runtime_ss, kmod);
    ...
}

Because execution falls through to dso__load_sym(), does it unconditionally
call dso__set_symtab_type(dso, syms_ss->type) and silently overwrite the
newly added symtab_type, mixing the symbols?

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D5
