Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253B3C4149
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647696; cv=none; b=LumRRVVaMrrWZZvPhsZ9E8rJp0rHf8HnUxaTjbqXD8WDRrHIGqqLC81XvpI7AzE4q9O3kZD8vMsXnE1Fi3+3fKvRvxsd2XfGWb7lpTDfQphvqN9BtiW85+AHhomkEzIdh8YSXYpnEpHaTTGE75UD/R0qLcS62jX81OIO6QtjF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647696; c=relaxed/simple;
	bh=8XCyb4B5KOCbjJGo682S8EV5JyuU24ngI3ks4YA9TP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QxIrHelRD6pkgEsvT1DoQJxzHrJLhn2PEqPryjHoJVV99ZYzv98l0OSWroiHnpCF1LKD8zHW9+T8RuCaVbu2XpVZwW39ok68MjNip3r8ERR7k9OkVvpFoDfOrarvYuvlbsV9yWIkJJXSRpnEROPVPBhVYlasCBkb+HT9GRtLxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJte/S41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJte/S41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF01F00893;
	Fri,  5 Jun 2026 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780647695;
	bh=Lm45cYj/eSgTnL6HyaZl5sn3U/hAKW21GfGoXsGD2Xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJte/S41Da1Lf+iM25VzXrXqr5bgt2DZ1hLyZw8yJ4Qmzyjk+G/9S6VJ2/1WHMxWn
	 uh4uJpC670Whjx2xWAoF89b/4L915svgSd0iSKhpHmMifutMQp6qscz9iJPcpqx1LF
	 HodNxoc8GPwWAHfURxTC4OO5m+KBFTEMEJplPXiyxlusZGvg0rbEGNb2egjUY6TnT0
	 YjB869Br7LQapO/hfAC+dgw9QXgjSgQyoIroo0O8+UQeaX7usHNuPu4BlfsGK9trMK
	 mlu6t5WoogpfLIVyAReF21UaNxNI7j5u8s/CEQatvgHKVxDLKhWAGVBb7OkkIdjHX5
	 tQvLFSFJq5+jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/19] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-19-irogers@google.com>
References: <20260605074003.1730715-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:21:34 +0000
Message-Id: <20260605082135.39BF01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `setup.py` configuration incorrectly installs `perf.pyi` dir=
ectly to the system's root installation prefix rather than the `site-packag=
es` directory alongside the extension module.
- [Low] In-tree builds fail unconditionally due to a self-copy error when `=
$(OUTPUT)` is empty.
--

commit c97699f4738dbd39b930541637409562855b081b
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

Add Python type stubs for the perf module to improve IDE support and
static analysis. Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index ab661a1d271c7..c5e01daf3bd1c 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -527,7 +527,8 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/=
python.c util/setup.py $(PE
>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  --quiet build_ext; \
> -	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> +	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
> +	cp python/perf.pyi $(OUTPUT)python/

[Severity: Low]
Does this rule cause in-tree builds to fail?

During an in-tree build of perf, the $(OUTPUT) variable is empty. This
evaluates the command to cp python/perf.pyi python/.

This causes GNU cp to exit with an error indicating the source and
destination are the same file, which aborts the build process.

[ ... ]

> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index b65b1792ca056..8d8d1a7f4433c 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -105,4 +105,5 @@ setup(name=3D'perf',
>        license=3D'GPLv2',
>        url=3D'http://perf.wiki.kernel.org',
>        ext_modules=3D[perf],
> +      data_files=3D[('', [f'{src_perf}/python/perf.pyi'])],
>        cmdclass=3D{'build_ext': build_ext, 'install_lib': install_lib})

[Severity: Medium]
Will this configuration install the stub file into the system root rather
than the site-packages directory?

By specifying an empty string as the target directory in the data_files
list, setuptools places the perf.pyi file directly into the root
installation prefix, such as /usr/perf.pyi.

This avoids installing the file alongside the extension module in the
Python site-packages directory. Consequently, type checkers and IDEs
will fail to discover the stub.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D18
