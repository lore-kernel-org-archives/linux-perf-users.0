Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645035BDB8
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141569; cv=none; b=IGyRruiKzeGHyhN8FWv9m4Qhzp3E5x4XAEIk4YOXgZzunqnG69RivnAPCGo3hr3ScUcgH8oWnpW9j4omNZyMGInOGaOmgF9yPQmgAN9LoKiXyu5wa7h03Lgmz0SfZ6XNNMf2ijp3/VHVr2brDLoFheJJSZJGBznpzw5XfJL44c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141569; c=relaxed/simple;
	bh=AEe7tZpsyOd3gAtBuAFuKtYUsvUbw4FAROBDcLqD6yg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xb4uE1eNLLUq37P0ZFvKUDYQ9nVxTfuPW7Dt/ACQ1mCNDEvFjbqtNNtgJn3K7EFvwo5oMmUMFJUOKs0sXUrPW4FcEI90SvCH4aQ3JXnn2wKQiRvt7eK1U30eYyGIiO/SrlfA7GBl60C/BRG8wF07nnZTV+lZHwdRRZMAcRSlxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA/1kLLn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA/1kLLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5A9C2BCB3;
	Sat, 25 Apr 2026 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141569;
	bh=AEe7tZpsyOd3gAtBuAFuKtYUsvUbw4FAROBDcLqD6yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DA/1kLLnYgmgmT0Un+KDWGT1qwziO2Tz/c6nhZP+OS6rnW5Piee74UjWBbXHb/qBD
	 LRwSt2vwDEHZgWi/iGF7/WvIksKcUfugDcsYbuHcX4AAFV4VdNvPWjhFaaNEIkkFiQ
	 +iVASI+OSxKeuC4jpgk4976LKvaQGTJKBgVKe6gIi153yRM99uKXjUt9bI7xvyYIma
	 hvGMWSaZeASZ2bO0YUPM/krP+9uZIN0PQI7zp1nHYgQdM9TWli60u8qJ/pi98GdqIb
	 Zgo42HX0MwhOl6mCbXGzWv60sk8fFWZ8ZzS7k6jgw77RaOua0BsHWVRPM2OS8gdQtn
	 3ydc9ZBKVG3bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 55/59] perf Makefile: Update Python script
 installation path
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-56-irogers@google.com>
References: <20260425174858.3922152-56-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:26:08 +0000
Message-Id: <20260425182609.3A5A9C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Python scripts will silently disappear from the 'perf report' in=
teractive script browser.
- [Medium] The `make_no_scripts` and `make_minimal` test targets in `tools/=
perf/tests/make` are silently broken, neutering build test coverage.
--

commit 097e9f6a5c8c0be76822e797df41c8183e50dce1
Author: Ian Rogers <irogers@google.com>

perf Makefile: Update Python script installation path

This commit replaces the libpython feature test with a python-module feature
test and updates the associated build configuration. It also changes the
installation directory for Python scripts from the legacy scripts/python pa=
th
to a direct python directory under libexec.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
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

Does this regression silently drop Python scripts from the perf report
interactive script browser?=20

Looking at tools/perf/ui/browsers/scripts.c, find_scripts() still hardcodes
its search path to scripts/. Because the scripts are now installed directly
under python/, the readdir loop will fail to discover them.

Additionally, the same browser code contains:

tools/perf/ui/browsers/scripts.c:find_scripts() {
    ...
#ifndef HAVE_LIBPYTHON_SUPPORT
        if (strstr(lang_dirent->d_name, "python"))
                continue;
#endif
    ...
}

Since the libpython feature name was removed and HAVE_LIBPYTHON_SUPPORT
is no longer generated, won't this check always trigger, causing the browser
to unconditionally ignore Python scripts even if the directory search path
were updated?

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
[ ... ]
> @@ -75,8 +75,6 @@ make_jevents_all    :=3D JEVENTS_ARCH=3Dall
>  make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
>  make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
> =20
> -make_no_libpython   :=3D NO_LIBPYTHON=3D1
> -make_no_scripts     :=3D NO_LIBPYTHON=3D1
>  make_no_slang       :=3D NO_SLANG=3D1
>  make_no_gtk2        :=3D NO_GTK2=3D1
>  make_no_ui          :=3D NO_SLANG=3D1 NO_GTK2=3D1
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
> @@ -150,7 +148,6 @@ run +=3D make_jevents_all
>  run +=3D make_no_bpf_skel
>  run +=3D make_gen_vmlinux_h
> =20
> -run +=3D make_no_libpython
>  run +=3D make_no_scripts

Because the definition for make_no_scripts was removed, run +=3D make_no_sc=
ripts
will evaluate to an empty target. Does this regression cause the test
harness to silently run a default build without passing NO_PYTHON_MODULE=3D=
1?

Similarly, should make_minimal have been updated to include NO_PYTHON_MODUL=
E=3D1
instead of just dropping NO_LIBPYTHON=3D1? Without it, the test suite no
longer explicitly verifies that perf builds successfully without Python sup=
port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D55
