Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5F3B47E5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386567; cv=none; b=p6uDD6mdh3nNlcYpn/eEW5uhLidCKW6VkoF6CvcPhr/oevsZivCzMCQGGXAtzjQUVue6Kz4z4pwnERoH7aW6tHmDSUZ81aU1of25fzDN4aPSfWBXYU0O5o7BUc40OGqF9Kz9wqVCBVlJNgVG6RZznK2k9RKGNiBUrv6telvmbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386567; c=relaxed/simple;
	bh=tdtB6rnAa3ADbXfz4EDSW5r214kguoX83Ex31kdAAVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sO4Jn2ll6ofvNz5CyCEUm5OLvmc5vqFfsW5Yd5X8YkcLgJjVuSWyGYWQ64PI1HVDFVSHA0IjaFLTf3v8l0AK+bNPpvk7Je7RaaLdj8rXLsJqeJdU+G9DArTLBtaOG4BcFhQV1eU4A5qo+zHv39xSMm4Y2QdRpPe9iAq339tbluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb7VJ07r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb7VJ07r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E4A1F00898;
	Tue,  2 Jun 2026 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386566;
	bh=SHtblatxy20KJFP6Y1B/kxh7y/bV2sjWF6ZnGzBLBxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nb7VJ07ryNH9MwDP/esp4elBenRIddmiFbYI7mON1dMrfiqKY7TcTSg32jy6T3CQ4
	 2KxNl2rQpNoOZLcx4L8CqRkZnpF/vXCpwTa/TYkP/4FPHpdW0fn4cyg2KgWZkh2uRY
	 JE9NWeijhvOTCMpKSLa250tsuufCMqR2ZDBT9Mt2Jb5Xj91aYldDUvaIUTEvnI/H/u
	 D6Kcua/YnPkVMrNRqPzmCJ8HgxyrZktyQruq93tRbm7z99CDacmKTuRczSe9ieDM9i
	 lYkZaOS392vvm4quVg41cROt8Bx4pt0Jw0BeZ8sVMZVNlDF/UOy0Ir4KpFl/bpxNDx
	 0+POb/36P9QBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf jevents.py: Make generated C code more kernel
 style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-3-irogers@google.com>
References: <20260602073132.2653307-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:49:25 +0000
Message-Id: <20260602074926.21E4A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unmatched `/* clang-format on */` directive and failure to bypass c=
lang-format for generated tables.
--

commit 0066c92b375735ccaca89b6a548251dee83b70d0
Author: Ian Rogers <irogers@google.com>

perf jevents.py: Make generated C code more kernel style

This commit updates jevents.py to generate C code that complies with
kernel formatting tools. It adds /* clang-format off/on */ directives around
large generated tables to bypass them while checking functions and early
structs. It also fixes comments and indentation in initializers.

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -1466,6 +1463,7 @@ struct pmu_table_entry {
> =20
>    _bcs.compute()
>    if not _args.output_string_file:
> +    _args.output_file.write('/* clang-format off */\n')
>      _args.output_file.write('static const char *const big_c_string =3D\n=
')
>      for s in _bcs.big_string:
>        _args.output_file.write(s)
[ ... ]
> @@ -1487,6 +1485,7 @@ struct pmu_table_entry {
> =20
>    print_mapping_table(archs)
>    print_system_mapping_table()
> +  _args.output_file.write('/* clang-format on */\n')

[Severity: Low]
Is it possible to end up with an unmatched /* clang-format on */ directive?

If the script is executed with output_string_file specified, the
/* clang-format off */ directive won't be written, but the on directive is
unconditionally written here. This could also fail the commit's goal of
bypassing clang-format for the generated tables.

>    print_metricgroups()
>    _args.output_file.close()
>    if _args.output_string_file:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-3-irogers@google.com?part=3D1
