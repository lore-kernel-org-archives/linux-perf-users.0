Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373223EC2EA
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739117; cv=pass; b=FREt/2V4FLZ1MANdNuTt5x9iuP1lGGdKw0VfATmkEuROrlDCv3b6NHj1O77Hpj8i+0TaBYStbji9dv3t3PG4EWtT52HtZ0cV5p4I+7uGlRJJvdaGqRK4VhwAKif6p4ZVckPYhg/1t3m5P3CCAthAAhQAlTuBLf29Cz2lrw9PIG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739117; c=relaxed/simple;
	bh=7RDnzb5y+uAw6wDwgI/WjPnddI4wuh7EhjmnlIgKqqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KZGa/rkP8qBnW5BMY4cc1G+9X2uFNnzONIgAIplmRExx1CXo9ZNmM4EuvR+bV0ZQDIl5jtERsD2K+CruSVd8Bd4VIGjBXUu5swntkrN7sO1mVa8UAzPU+QgzSWp5Al9yevwBqPhDHjsKhq2Ff6Onpsj7WYJCcMwzlHI8nNd25+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvwxtlzi; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvwxtlzi"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c15a5b265so27071cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 09:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784739110; cv=none;
        d=google.com; s=arc-20260327;
        b=Rneic8TuXlYx8t2jNr2XTzala21XAkCjc185Gk7RdaMp7oofvAFtCY9FJSsU80P2+D
         KmtaMQQskIbXAvMPJLCjalKeAidEWOzkk7UP9xx06UimF2QiKPz3BbcECAV38gVd4NV2
         oMqB73X6NqLSQI9B45muLV3CqfrcKSZGKZq+zv6Ph5ZiNvUZJqgfIDX4m0FsTJM+4GeW
         fMaTApwf2yvH3jkCfgt4Tub7BlYtRY06rtp7LrKjrsdN8meCUj6iaDrXLIUDcDzKQGTd
         Jx3K2m0LjdDcn0PglNfYOQlDOSaw2Dvrj12cd33xp7dbd5nD/TkcvDNlsYmnr18geVib
         DRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kgwhed9xFf8c0g92oOq3EOieJTkWbjYPkqVKCwDrqPU=;
        fh=CinQSTkvvxUrUkaNGkfFNqr/h6Whwm7eC0zAZy5yI8s=;
        b=an+Iq5sWxDBckdaQB7FfAGWOvdzbec1sAlAPXsv+FVi3UrzMh34p8zcgN2I5fsREPk
         lO2y7a2mX4bV/Mt9hscoKxIhXgSNlaHHe0X9ct3e8+EsitZnRzCkib1BMAev6otI6Vae
         W4/eQJuDvkWXKSY3S5w+8i8EEz8CoTqujQ3FvfmfZLtRUjFwdo8XZ2BaswcXMUifltwM
         YSflueB5egbMfr5pb0dzdKjGJjono8R5cyXrY2tFCoCvcmSRIU337FT8NeqL5az+3+uI
         qXcXQVS64oedobKrTLFBaSXtqZmds0ARLKnhpRGHan+NvfW/aA97zwY952azQwlYkTaz
         FARA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784739110; x=1785343910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgwhed9xFf8c0g92oOq3EOieJTkWbjYPkqVKCwDrqPU=;
        b=rvwxtlzitwqIFChPgf09L5YVe4smGnEWBU4ItOUFOt8rYrZot0tjqBwDD9647kJFy3
         ENCmY4Zzbh4S3s7MQg0K4VYxt2YHotVyZiQrHJLIyAC62w5WO7Vh2qMGjt4CX5DwLmHJ
         XlzVUwCmOhd+xP3Oq9FlzCW0org0yKRymONpZSFXSdL40VtOll3vjVtkxBtzD8iz/dWI
         VL0Y6B00W0uW789Hh255PPaerVsqVzed5g3q92kkguRm1Hokj5mQhuu+k2+oPt7eXkks
         0NBxOqTFFxljiANZxMDoDIieMalreBjjOIr0mql1IX87ZDPrPwZbX1DFdb6mFPLtIJWq
         wJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739110; x=1785343910;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kgwhed9xFf8c0g92oOq3EOieJTkWbjYPkqVKCwDrqPU=;
        b=cPRMCqgzf7vzqF2ppmiUzyeTR104I049qdxxWlP04XF3/bEgkEj2ou3Z61wuHddy+0
         laMD1N1aIKi8JcL8YPctUw5KDizI+ZiZ5IXlbz6JdfbsAF5pRU0kAV0INo4gK7BF6Uzi
         SLZRUH/PdCURWzR/0eRcXl5JLahctWKbBKIIgfbuQXYDSwGCWTZp2yuXjbBe1aO25XTJ
         5pMqONkj/ppcahpXRjpd+TiHC76MtuChWFc10iUxHe4O9vJBOaT/q9NPU35oZv29ihnj
         gMWRuW9HkY7MterpHnmGJnn+Uhr33KBUUB754e1Md2U0a2XwlngNu96dR07UYmR0+R4h
         LEqg==
X-Forwarded-Encrypted: i=1; AHgh+RqKtFXItcDc9mXPsv79BV8XXqTTyUWVDkfnAQdft7R9r4DU/kEOouwaESv4O9sPVIiB6Q5KKWOEJCYwe+nRZa+g@vger.kernel.org
X-Gm-Message-State: AOJu0YzREkuqT+UkZBy8u0BPhR32yk+ItxPxHHYii9PKn0u/5xsCFJeJ
	cFYk7eYPMDW8jOR02DJK0ma12aG0yO2d5OCl8LgnU/UcZyHQiBY3vbv+rDNQZjM/CGcFnmk9Or8
	LgiAQlo1sWPmQqBBkBhzrKA15RlmzbLq4L6COLN1G
X-Gm-Gg: AR+sD12Rfdw8Wz3ePyR8PuQYSZNpI5D0fFBnqOcouQ09+285MmiKch/FqIg57FQlgU3
	oYpmyC5MHXWzAgCDHNY0o01QRQNTnwFN1nK+9Nl4V02TFnCqoYputIfXReKAUrcagVvwIXDCvbU
	ptaMDeuPoLR1vQWqGRkB8uadkkPOKXPf4sU/3Y8eekLh2/BX27e2QIfXaADRbSyM8CTqsx5FJ9U
	mabflks8nOm5SHl/CREtnFEJuq/l5b0zreoQ59hZn1Ip/JUd2cHvFMuvomnCZ8T5/VgRy8HIugu
	9M1pOnlRr5sgigD2
X-Received: by 2002:a05:622a:8d10:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-5283a7344acmr1092871cf.4.1784739109454; Wed, 22 Jul 2026
 09:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521175535.1531810-1-irogers@google.com>
In-Reply-To: <20260521175535.1531810-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Jul 2026 09:51:34 -0700
X-Gm-Features: AUfX_mw9jp4CCjBkyffpVLOZzu2-dM-58CjX-Tmz9BaSpsYLmhL2t_V2BhLbJCM
Message-ID: <CAP-5=fWD+zy8NKWyUieF-Kk4q5yEjr+qYVbU-vhT85McLeaxUg@mail.gmail.com>
Subject: Re: [PATCH v1] perf python: Clean up and restructure setup.py
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:55=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Clean up and restructure the python setup script to resolve pylint
> warnings, improve code quality, and increase robustness and
> readability, targeting Python 3.9+ (the Linux kernel build minimum
> Python version).
>
> Changes:
> - Restructure the script to use a `main()` function as the entry point,
>   leaving only imports, classes, and pure functions at module level.
> - Eliminate all global/module-level variables, making them local to
>   `main()` or the respective classes/functions.
> - Make `clang_has_option` a pure function by passing all necessary
>   parameters explicitly.
> - Extract clang compiler flag filtering into a new
>   `filter_clang_options` helper function. This function uses a loop
>   over a tuple of options, replacing ~30 lines of repetitive blocks
>   and reducing branch/statement complexity in the main flow.
> - Cleanly define attributes in `__init__` for `BuildExt` and `InstallLib`
>   and read environment variables dynamically within the methods, removing
>   their dependency on global variables.
> - Replace legacy Popen with subprocess.run for safer process handling.
> - Use list-based flag filtering (split, filter, re-join) instead of regex
>   `re.sub` substitutions on space-separated compiler flag strings. This
>   avoids boundary bugs and safely handles flags with arguments (e.g.
>   `-fcf-protection=3Dfull`).
> - Safely parse `CC` env var using `shlex.split` to handle quotes and pass
>   compiler arguments as `list[str]` lists to helper functions, avoiding
>   redundant string formatting and parsing.
> - Remove unused `import re`.
> - Rename setuptools command subclasses to PascalCase (BuildExt, InstallLi=
b).
> - Add type annotations to functions and methods.
> - Add missing docstrings for module, functions, and classes.
> - Split long lines to adhere to standard limits.
>
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/util/setup.py | 253 +++++++++++++++++++++++++--------------
>  1 file changed, 166 insertions(+), 87 deletions(-)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index b65b1792ca05..55ff7d8cba7e 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -1,108 +1,187 @@
> -from os import getenv, path
> -from subprocess import Popen, PIPE
> -from re import sub
> +"""Setup script for perf python extension.
> +
> +This script is used to build and install the perf python binding.
> +It handles compiler-specific flags, especially for clang, and configures
> +the setuptools Extension.
> +"""
> +
> +import os
>  import shlex
> +import subprocess
> +import sysconfig
>
> -cc =3D getenv("CC")
> -assert cc, "Environment variable CC not set"
> +from setuptools import setup, Extension
> +from setuptools.command.build_ext import build_ext as _build_ext
> +from setuptools.command.install_lib import install_lib as _install_lib
>
> -# Check if CC has options, as is the case in yocto, where it uses CC=3D"=
cc --sysroot..."
> -cc_tokens =3D cc.split()
> -if len(cc_tokens) > 1:
> -    cc =3D cc_tokens[0]
> -    cc_options =3D " ".join([str(e) for e in cc_tokens[1:]]) + " "
> -else:
> -    cc_options =3D ""
>
> -# ignore optional stderr could be None as it is set to PIPE to avoid tha=
t.
> -# mypy: disable-error-code=3D"union-attr"
> -cc_is_clang =3D b"clang version" in Popen([cc, "-v"], stderr=3DPIPE).std=
err.readline()
> +def clang_has_option(cc: str, cc_args: list[str], src_feature_tests: str=
, option: str) -> bool:
> +    """Check if clang supports a specific option.
>
> -srctree =3D getenv('srctree')
> -assert srctree, "Environment variable srctree, for the Linux sources, no=
t set"
> -src_feature_tests  =3D f'{srctree}/tools/build/feature'
> +    Args:
> +        cc: The compiler executable.
> +        cc_args: Compiler arguments from CC environment variable.
> +        src_feature_tests: Path to the feature tests directory.
> +        option: The compiler option to check (e.g., "-mcet").
>
> -def clang_has_option(option):
> +    Returns:
> +        True if the option is supported, False otherwise.
> +    """
>      error_substrings =3D (
>          b"unknown argument",
>          b"is not supported",
>          b"unknown warning option"
>      )
> -    cmd =3D shlex.split(f"{cc} {cc_options} {option}") + [
> +    cmd =3D [cc] + cc_args + [
> +        option,
>          "-o", "/dev/null",
> -        path.join(src_feature_tests, "test-hello.c")
> +        os.path.join(src_feature_tests, "test-hello.c")
>      ]
> -    cc_output =3D Popen(cmd, stderr=3DPIPE).stderr.readlines()
> +    try:
> +        res =3D subprocess.run(cmd, stderr=3Dsubprocess.PIPE, stdout=3Ds=
ubprocess.DEVNULL, check=3DFalse)
> +        cc_output =3D res.stderr.splitlines()
> +    except OSError:
> +        return False
>      return not any(any(error in line for error in error_substrings) for =
line in cc_output)
>
> -if cc_is_clang:
> -    from sysconfig import get_config_vars
> -    vars =3D get_config_vars()
> +
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
> -        if not clang_has_option("-mcet"):
> -            vars[var] =3D sub("-mcet", "", vars[var])
> -        if not clang_has_option("-fcf-protection"):
> -            vars[var] =3D sub("-fcf-protection", "", vars[var])
> -        if not clang_has_option("-fstack-clash-protection"):
> -            vars[var] =3D sub("-fstack-clash-protection", "", vars[var])
> -        if not clang_has_option("-fstack-protector-strong"):
> -            vars[var] =3D sub("-fstack-protector-strong", "", vars[var])
> -        if not clang_has_option("-fno-semantic-interposition"):
> -            vars[var] =3D sub("-fno-semantic-interposition", "", vars[va=
r])
> -        if not clang_has_option("-ffat-lto-objects"):
> -            vars[var] =3D sub("-ffat-lto-objects", "", vars[var])
> -        if not clang_has_option("-ftree-loop-distribute-patterns"):
> -            vars[var] =3D sub("-ftree-loop-distribute-patterns", "", var=
s[var])
> -        if not clang_has_option("-gno-variable-location-views"):
> -            vars[var] =3D sub("-gno-variable-location-views", "", vars[v=
ar])
> +        if var not in config_vars:
> +            continue
> +
> +        # Split into individual flags to avoid regex boundary issues
> +        flags =3D config_vars[var].split()
> +
> +        # Remove -specs=3D...
> +        flags =3D [f for f in flags if not f.startswith("-specs=3D")]
> +
> +        options =3D (
> +            "-mcet",
> +            "-fcf-protection",
> +            "-fstack-clash-protection",
> +            "-fstack-protector-strong",
> +            "-fno-semantic-interposition",
> +            "-ffat-lto-objects",
> +            "-ftree-loop-distribute-patterns",
> +            "-gno-variable-location-views"
> +        )
> +        for option in options:
> +            if not clang_has_option(cc, cc_args, src_feature_tests, opti=
on):
> +                # Remove the option and any variant (e.g. -option=3D...)
> +                flags =3D [f for f in flags if not f.startswith(option)]
> +
> +        # Re-join flags
> +        config_vars[var] =3D " ".join(flags)
> +
> +
> +class BuildExt(_build_ext):
> +    """Custom build_ext command to set output directories."""
> +
> +    def __init__(self, *args, **kwargs):
> +        self.build_lib =3D None
> +        self.build_temp =3D None
> +        super().__init__(*args, **kwargs)
> +
> +    def finalize_options(self) -> None:
> +        _build_ext.finalize_options(self)
> +        build_lib =3D os.getenv('PYTHON_EXTBUILD_LIB')
> +        build_tmp =3D os.getenv('PYTHON_EXTBUILD_TMP')
> +        if build_lib:
> +            self.build_lib =3D build_lib
> +        if build_tmp:
> +            self.build_temp =3D build_tmp
>
> -from setuptools import setup, Extension
>
> -from setuptools.command.build_ext   import build_ext   as _build_ext
> -from setuptools.command.install_lib import install_lib as _install_lib
> +class InstallLib(_install_lib):
> +    """Custom install_lib command to set output directory."""
>
> -class build_ext(_build_ext):
> -    def finalize_options(self):
> -        _build_ext.finalize_options(self)
> -        self.build_lib  =3D build_lib
> -        self.build_temp =3D build_tmp
> +    def __init__(self, *args, **kwargs):
> +        self.build_dir =3D None
> +        super().__init__(*args, **kwargs)
>
> -class install_lib(_install_lib):
> -    def finalize_options(self):
> +    def finalize_options(self) -> None:
>          _install_lib.finalize_options(self)
> -        self.build_dir =3D build_lib
> -
> -
> -cflags =3D getenv('CFLAGS', '').split()
> -# switch off several checks (need to be at the end of cflags list)
> -cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-=
parameter', '-Wno-redundant-decls' ]
> -if cc_is_clang:
> -    cflags +=3D ["-Wno-unused-command-line-argument" ]
> -    if clang_has_option("-Wno-cast-function-type-mismatch"):
> -        cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> -else:
> -    cflags +=3D ['-Wno-cast-function-type' ]
> -
> -# The python headers have mixed code with declarations (decls after asse=
rts, for instance)
> -cflags +=3D [ "-Wno-declaration-after-statement" ]
> -
> -src_perf  =3D f'{srctree}/tools/perf'
> -build_lib =3D getenv('PYTHON_EXTBUILD_LIB')
> -build_tmp =3D getenv('PYTHON_EXTBUILD_TMP')
> -
> -perf =3D Extension('perf',
> -                 sources =3D [ src_perf + '/util/python.c' ],
> -                        include_dirs =3D ['util/include'],
> -                        extra_compile_args =3D cflags,
> -                 )
> -
> -setup(name=3D'perf',
> -      version=3D'0.1',
> -      description=3D'Interface with the Linux profiling infrastructure',
> -      author=3D'Arnaldo Carvalho de Melo',
> -      author_email=3D'acme@redhat.com',
> -      license=3D'GPLv2',
> -      url=3D'http://perf.wiki.kernel.org',
> -      ext_modules=3D[perf],
> -      cmdclass=3D{'build_ext': build_ext, 'install_lib': install_lib})
> +        build_lib =3D os.getenv('PYTHON_EXTBUILD_LIB')
> +        if build_lib:
> +            self.build_dir =3D build_lib
> +
> +
> +def main() -> None:
> +    """Main entry point for the setup script."""
> +    cc_env =3D os.getenv("CC")
> +    assert cc_env, "Environment variable CC not set"
> +
> +    # Safe parsing of CC environment variable which might contain option=
s/quotes
> +    cc_tokens =3D shlex.split(cc_env)
> +    cc =3D cc_tokens[0]
> +    cc_args =3D cc_tokens[1:]
> +
> +    # Run CC -v to check if it is clang.
> +    try:
> +        cc_info =3D subprocess.run(
> +            [cc, "-v"], stderr=3Dsubprocess.PIPE, stdout=3Dsubprocess.DE=
VNULL, check=3DFalse
> +        )
> +        cc_is_clang =3D b"clang version" in cc_info.stderr
> +    except OSError as e:
> +        raise RuntimeError(f"Failed to execute compiler '{cc}': {e}") fr=
om e
> +
> +    srctree =3D os.getenv('srctree')
> +    assert srctree, "Environment variable srctree, for the Linux sources=
, not set"
> +    src_feature_tests =3D f'{srctree}/tools/build/feature'
> +
> +    if cc_is_clang:
> +        filter_clang_options(cc, cc_args, src_feature_tests)
> +
> +    cflags =3D os.getenv('CFLAGS', '').split()
> +    # switch off several checks (need to be at the end of cflags list)
> +    cflags +=3D [
> +        '-fno-strict-aliasing',
> +        '-Wno-write-strings',
> +        '-Wno-unused-parameter',
> +        '-Wno-redundant-decls'
> +    ]
> +    if cc_is_clang:
> +        cflags +=3D ["-Wno-unused-command-line-argument"]
> +        if clang_has_option(
> +            cc, cc_args, src_feature_tests, "-Wno-cast-function-type-mis=
match"
> +        ):
> +            cflags +=3D ["-Wno-cast-function-type-mismatch"]
> +    else:
> +        cflags +=3D ['-Wno-cast-function-type']
> +
> +    # The python headers have mixed code with declarations (decls after =
asserts, for instance)
> +    cflags +=3D ["-Wno-declaration-after-statement"]
> +
> +    src_perf =3D f'{srctree}/tools/perf'
> +
> +    perf =3D Extension(
> +        'perf',
> +        sources=3D[os.path.join(src_perf, 'util/python.c')],
> +        include_dirs=3D['util/include'],
> +        extra_compile_args=3Dcflags,
> +    )
> +
> +    setup(
> +        name=3D'perf',
> +        version=3D'0.1',
> +        description=3D'Interface with the Linux profiling infrastructure=
',
> +        author=3D'Arnaldo Carvalho de Melo',
> +        author_email=3D'acme@redhat.com',
> +        license=3D'GPLv2',
> +        url=3D'http://perf.wiki.kernel.org',
> +        ext_modules=3D[perf],
> +        cmdclass=3D{'build_ext': BuildExt, 'install_lib': InstallLib},
> +    )
> +
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> --
> 2.54.0.794.g4f17f83d09-goog
>
