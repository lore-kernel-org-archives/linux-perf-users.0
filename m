Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FF391E4C
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159343; cv=none; b=UluQRMGkJnZWezUQo4/6bNHJbVU8fZKTJyaZoR2D7aoKPZ+6TXSevgegbTT12eWIewpdCQ8LezXdKaIXDo3OGOODP+W2UZsECA7V+qjBOAeOQ2IYzfLMjs04nqdA+Vgj/MtTX08687Bsx3bfU4L52TIRJ5X2eLgQu9PuI/xKSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159343; c=relaxed/simple;
	bh=u8jeEy1OaJpEyvygTBJhy+p8fPDaFQ5c6JVnMagm2F8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qM5Tnr0Bg5xBqh9fpti8PEc76cY4Q/nxJhPdEPnIsqqUAztiEJIBybD+gI1P+47qPatByprVVFlL7+stbxZEJjn3yD4cSnVAPzyY7Sw4Qp3Nqm6O+MLrBtW4O92HHq92zXTw5ulBOQTcGphMt08eq+XVQr/gFaA6j9f7VJ4Z6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhMSWZ+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhMSWZ+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06135C2BCB0;
	Sat, 25 Apr 2026 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159343;
	bh=u8jeEy1OaJpEyvygTBJhy+p8fPDaFQ5c6JVnMagm2F8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PhMSWZ+n6d14zjEBb2PoqD6r+OlqBBtgkC8f0IY5BaIWJ/k5PEzUNuNgvqOffigh4
	 a0L9e20pP1WjtyNdwJo4+JDxvBLToiI0mScp1KZh7JQGwLKVQOEA3xQvsZRA6c/tsH
	 BZkDZQ3CAvYc89ZuoFLONMgup6K3w/BzKouaaBrODKHVXm8QRI74IOvS30ltA8Tx4Q
	 Ls4zgRchcYl0coi2bpwJhoIzUcFtlu2jmlf56lxAOirW8WlNl5BPI2k1HWt4G94uLJ
	 r9LFM1PKq79OsyZmnvb+x+uxId/MquE7oK0yGHwj9QyZJ0gicnn39q3+IJgljk0A2v
	 3rSMVNcYSjQUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 55/59] perf Makefile: Update Python script
 installation path
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-56-irogers@google.com>
References: <20260425224951.174663-56-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:22:22 +0000
Message-Id: <20260425232223.06135C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The patch changes the installation directory for Python scripts bu=
t fails to update the C code that resolves them, causing `perf script -l` t=
o unconditionally abort and breaking script resolution.
- [Medium] The patch breaks the `make_no_scripts` and `make_minimal` test t=
argets, resulting in a silent loss of test coverage for the Python opt-out =
build configuration.
--

commit 7e77c00b937b8bb6b2b6ff7f1c92cb9981141b94
Author: Ian Rogers <irogers@google.com>

perf Makefile: Update Python script installation path

This patch updates the feature test from libpython to python-module, adjusts
the corresponding variables in the build system, and changes the installati=
on
directory for Python scripts from scripts/python to python under the perf
libexec directory.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2020532bab9c..e50b1e8cf85d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
[ ... ]
> @@ -1099,10 +1097,10 @@ endif
>  	$(call QUIET_INSTALL, perf-iostat) \
>  		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ=
)'
> =20
> -ifndef NO_LIBPYTHON
> +ifndef NO_PYTHON_MODULE
>  	$(call QUIET_INSTALL, python-scripts) \
> -		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/pyth=
on'; \
> -		$(INSTALL) python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/=
scripts/python'
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python'; \
> +		$(INSTALL) python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/=
python'
>  endif

Does changing the installation directory to python without also updating
tools/perf/builtin-script.c cause a temporary regression in this commit?

The list_available_scripts() function in tools/perf/builtin-script.c
still calls opendir() on the legacy scripts directory and explicitly calls
exit(-1) if it does not exist, which causes perf script -l to abort.

Similarly, find_script() still searches the nonexistent scripts directory,
preventing execution of the Python scripts.

I noticed this is fixed later in the series in commit
28566cda6894feea81082103f438305b884d5d12 ("perf script: Refactor to support
standalone scripts and remove legacy features").

Should each commit build and function independently without introducing
temporary regressions?

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 31b064928cfc..f2c5f1c254a7 100644
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
>  make_minimal        +=3D NO_LIBBPF=3D1

Should NO_PYTHON_MODULE=3D1 be added to make_minimal to replace NO_LIBPYTHO=
N=3D1?

Without it, this drops the intended minimal build coverage for Python-disab=
led
configurations.

[ ... ]
> @@ -150,7 +148,6 @@ run +=3D make_jevents_all
>  run +=3D make_no_bpf_skel
>  run +=3D make_gen_vmlinux_h
> =20
> -run +=3D make_no_libpython
>  run +=3D make_no_scripts
>  run +=3D make_no_slang
>  run +=3D make_no_gtk2

Does leaving run +=3D make_no_scripts here without an underlying assignment
cause the test framework to silently evaluate the variable to an empty stri=
ng?

This appears to cause the test target to run a standard default make build
instead of verifying that perf builds successfully when Python module suppo=
rt
is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D55
