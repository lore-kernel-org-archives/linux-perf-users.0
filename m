Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF514AD0D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054918; cv=none; b=OIewkAyJxCIt7ZSw+iFmF4h47qPZsTU5HN8X6e4mI92Ove2Q0eIIwT1M7NzliA+HGC+b8J+pJulgY0W9x2xogJbn2+u6AFhFfFPJS1/PHZsU7dVtqmqBsjcgFlCQyMTRFjDx3r7trVhg8/Qa5JkK75Z5A9z/HsK1nPBj60S93Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054918; c=relaxed/simple;
	bh=wX4aTN7WAsgcpRXqtRecZq/rwi+PuIklmuoPVUYrw7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WD+FMu9mFvVaA+D25mnXb+OovjIg75Xeftk7J6XNgnFfLMQrJUKWw7P2f4wtp1ZOC53gXKmTw2Z972osVE76rNxqi7y68rL8PMOcqPZIdjUFzwPVVXi/E75GUnjGKf+LfKu+Mkcb/RoKh1VNEc92tLQDaoBPOZpTd4wYDs+EsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YemJi7iu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YemJi7iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0155C2BCB4;
	Fri, 24 Apr 2026 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777054917;
	bh=wX4aTN7WAsgcpRXqtRecZq/rwi+PuIklmuoPVUYrw7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YemJi7iuMphU1IC651uIo18R5weHYHRfVBGefd0a4c/f7aqBecXzqVKLwHsOLM4s0
	 sejsVtkLRpjWUzpo3byTT52mxNFhDtccb0qjJ+C6p4k1OHX4w0WE/S3ZgZkM9YA5M3
	 dOaC1Y/gu13zB6SdyMHRhO6Zd7/70iEPY+Sg16siOnEMhzOzY2/2bavT0VigS6MCe4
	 BZT58zF9lfV0/qBozpooU1lZyMUVTWfpS901nRcIH0GLSmScLzvxj5VkOIIS3bGeyK
	 XIwh3WIFPZjYq16RoXNyWwrtJLVzXceqEpnmv4T8Jlnes1GBV1Upm9GivZFq1lvKAx
	 ZSlfC9SYR3FRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 55/58] perf Makefile: Update Python script
 installation path
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-56-irogers@google.com>
References: <20260424164721.2229025-56-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 18:21:57 +0000
Message-Id: <20260424182157.D0155C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The interactive UI script browser is completely broken for Python =
scripts due to obsolete macros and paths.
- [Medium] Test suite silently loses coverage for the 'disable python modul=
e' configuration.
- [Medium] The `python-module` feature test incorrectly requires the Python=
 embedding library, unnecessarily failing on some systems.
--

commit 00f5f415c2dee014c40385386d7e52b97edea230
Author: Ian Rogers <irogers@google.com>

perf Makefile: Update Python script installation path

Remove libpython feature test that is now a python-module feature test.
Update references from libpython to python-module accordingly.
Remove references to legacy 'scripts/python' directory and install
scripts directly to 'python' directory under libexec.

> Remove references to legacy 'scripts/python' directory and install
> scripts directly to 'python' directory under libexec. This aligns with
> the removal of embedded interpreter and move to standalone
> scripts.

Was tools/perf/ui/browsers/scripts.c missed in this update? The
find_scripts() function still has an #ifndef HAVE_LIBPYTHON_SUPPORT check
that unconditionally skips the Python directory because
HAVE_LIBPYTHON_SUPPORT was removed.

It also still searches the legacy scripts/python path instead of the new
python/ directory:

tools/perf/ui/browsers/scripts.c:find_scripts() {
    ...
		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, "..=
"))
			continue;

#ifndef HAVE_LIBPYTHON_SUPPORT
		if (strstr(lang_dirent->d_name, "python"))
			continue;
#endif
    ...
			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
				exec_path,
				lang_dirent->d_name,
				script_dirent->d_name);
    ...
}

Will this cause the UI script browser to completely break for Python script=
s?

> diff --git a/tools/build/feature/test-python-module.c b/tools/build/featu=
re/test-python-module.c
> new file mode 100644
> index 00000000000000..d670dba014b001
> --- /dev/null
> +++ b/tools/build/feature/test-python-module.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <Python.h>
> +
> +int main(void)
> +{
> +	static struct PyModuleDef moduledef =3D {
> +		PyModuleDef_HEAD_INIT,
> +	};
> +	PyObject *module =3D PyModule_Create(&moduledef);
> +
> +	return module ? 0 : -1;
> +}

Because this test is compiled as a standalone executable, it forces the bui=
ld
system to link against libpython.

Since the embedded interpreter was removed and perf now only builds a Python
extension module, does this incorrectly require the Python embedding librar=
y?

Systems that have the Python headers but lack the static/dynamic embedding
library will fail this feature test, incorrectly disabling Python support
across the build.

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 31b064928cfca0..f2c5f1c254a7cc 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -75,8 +75,6 @@ make_jevents_all    :=3D JEVENTS_ARCH=3Dall
>  make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
>  make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
> =20
> -make_no_libpython   :=3D NO_LIBPYTHON=3D1
> -make_no_scripts     :=3D NO_LIBPYTHON=3D1
>  make_no_slang       :=3D NO_SLANG=3D1
>  make_no_gtk2        :=3D NO_GTK2=3D1
>  make_no_ui          :=3D NO_SLANG=3D1 NO_GTK2=3D1

[ ... ]

> @@ -118,7 +116,7 @@ make_install_prefix_slash :=3D install prefix=3D/tmp/=
krava/
>  make_static         :=3D LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PE=
RF_READ_VDSOX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1
> =20
>  # all the NO_* variable combined
> -make_minimal        :=3D NO_LIBPYTHON=3D1 NO_GTK2=3D1
> +make_minimal        :=3D NO_GTK2=3D1
>  make_minimal        +=3D NO_DEMANGLE=3D1 NO_LIBELF=3D1 NO_BACKTRACE=3D1
>  make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBBIONIC=3D1 NO_LIBDW=3D1

Should NO_PYTHON_MODULE=3D1 be added to make_minimal here since
NO_LIBPYTHON=3D1 was removed?

[ ... ]

> @@ -150,7 +148,6 @@ run +=3D make_jevents_all
>  run +=3D make_no_bpf_skel
>  run +=3D make_gen_vmlinux_h
> =20
> -run +=3D make_no_libpython
>  run +=3D make_no_scripts
>  run +=3D make_no_slang
>  run +=3D make_no_gtk2

Is it expected that make_no_scripts is still in the run list even though
its definition was removed?=20

Because the variable is now undefined, it evaluates to an empty string. This
causes the test suite to execute a redundant default build instead of
verifying the NO_PYTHON_MODULE=3D1 opt-out path, leading to a silent drop
in CI test coverage.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D55
