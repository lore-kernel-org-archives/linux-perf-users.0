Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0F38947F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825684; cv=none; b=eF5gHbek47iWi8qicWXEB1aGkcFRMWQF+/TD6ClMKeyZUwVWVqubHoKtvIIddUgqCJR3Lde1pyeUdtdCXCK4yPhJqO2Nm8dE5+RKfUO5n5CrRk0TMYEu5uAArFWvDVMX4XpGjvYirrmABKgwdilh8VTg71a4fqntAy0dpypqaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825684; c=relaxed/simple;
	bh=LQgDYOunwmvvj8pZvw+5nVLXLE6L2R1ySXKdfCPXbZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xp5GDfHXzTb+YUsTyPGe0OMoqvQmV+gDq4ePL7KwWl3KVpqdyFdf8n5lATv5p6RPezfaO+2AdjbLHLdy5IpteRJX4ANEzaO5RiYpj6MRXcbiyvnEE+eLvPO1D4VDkgAeIt9WF97ne+zK6Ou+Zeq7/VQTotcA/o+TxpvwEWWyCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsYMYguD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsYMYguD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F9C1F00A3E;
	Thu, 23 Jul 2026 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825682;
	bh=6LNKsjNwGtChYe5FbiIfbbMi65Z2Z1jjWUVeoHulfEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsYMYguDX94CD7uzkRA+bAhSbOLdvKMoWucKZCtNoGGqpuvIuqw3XhmmYuExy46XA
	 8jWza1iUNegte3BxqoRLawk/hAhEZqHV+y0DUmdkTzQ+OG93rGehmOn5NaLOE0X9Pz
	 XuCH5ZDmVGi9tmYkeJRlSIwHKGYcKbLLp5yK/DiU0iAu65fQFHW0eanpmYKvtHeVzQ
	 vJVCqpig0ykKO2O9IRrYDtfN+eMM4CUpJhw9gdOFkSWdkQrlnBsOc07ggZ4p427h3N
	 M+bA0FDKOH29a1Z43/eW1qLo8LUlyph9swK4InoxKHWTh5XxwS8i5uVgUr9KwH0vV+
	 yRjM4znhegafA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf python: Clean up and restructure setup.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723164421.1232688-1-irogers@google.com>
References: <amGnWXQgP9Hu5xUT@google.com>
 <20260723164421.1232688-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 16:54:41 +0000
Message-Id: <20260723165441.E3F9C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Unresolved reference to `src_perf` in `InstallLib.run()` will raise=
 a `NameError` during the installation phase.
- [Low] Naive splitting of compiler flags (`CFLAGS` and `OPT`) using `.spli=
t()` breaks quoted arguments and redundantly duplicates user flags.
--

--- Patch [1]: [PATCH v2] perf python: Clean up and restructure setup.py ---
commit 48e3810550a434c966bd3941fa49269f6b80e25e
Author: Ian Rogers <irogers@google.com>

perf python: Clean up and restructure setup.py

This commit cleans up and restructures the python setup script to resolve
pylint warnings and improve code quality. It moves global logic into a
main() function and extracts compiler flag filtering into a helper.

> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index cb14554454a21..1385f07424b7c 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
[ ... ]
> +def filter_clang_options(cc: str, cc_args: list[str], src_feature_tests:=
 str) -> None:
> +    """Filter out unsupported clang options from sysconfig CFLAGS and OP=
T.
> +
> +    Args:
> +        cc: The compiler executable.
> +        cc_args: Compiler arguments from CC environment variable.
> +        src_feature_tests: Path to the feature tests directory.
> +    """
> +    config_vars =3D sysconfig.get_config_vars()
>      for var in ('CFLAGS', 'OPT'):
> -        vars[var] =3D sub("-specs=3D[^ ]+", "", vars[var])
> +        if var not in config_vars:
> +            continue
> +
> +        # Split into individual flags to avoid regex boundary issues
> +        flags =3D config_vars[var].split()

[Severity: Low]
Does using a simple string split here break quoted compiler flags?

If the system Python configuration provides CFLAGS or OPT with quoted
arguments (e.g., -D"MACRO=3D'some string'"), it appears this will destructi=
vely
split them on spaces into invalid fragments.

Should this use a quote-aware parser like shlex.split() instead?

[ ... ]
> +class InstallLib(_install_lib):
> +    """Custom install_lib command to set output directory."""
> =20
> -class install_lib(_install_lib):
> -    def finalize_options(self):
> +    def __init__(self, *args, **kwargs):
> +        self.build_dir =3D None
> +        super().__init__(*args, **kwargs)
> +
> +    def finalize_options(self) -> None:
>          _install_lib.finalize_options(self)
> -        self.build_dir =3D build_lib
> +        build_lib =3D os.getenv('PYTHON_EXTBUILD_LIB')
> +        if build_lib:
> +            self.build_dir =3D build_lib
> =20
>      def run(self):
>          _install_lib.run(self)
>          shutil.copy2(f'{src_perf}/python/perf.pyi', self.install_dir)

[Severity: Low]
Will this raise a NameError exception during installation?

The src_perf variable was refactored out of the module scope and moved into
the main() local scope, making it undefined here in InstallLib.run().

[ ... ]
> +def main() -> None:
[ ... ]
> +    if cc_is_clang:
> +        filter_clang_options(cc, cc_args, src_feature_tests)
> +
> +    cflags =3D os.getenv('CFLAGS', '').split()

[Severity: Low]
Similarly to the sysconfig variables, does this naive split break quoted
arguments in the CFLAGS environment variable?

Also, since setuptools inherently parses and applies CFLAGS from the
environment during extension compilation, will manually appending this to
extra_compile_args duplicate the user flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723164421.1232=
688-1-irogers@google.com?part=3D1
