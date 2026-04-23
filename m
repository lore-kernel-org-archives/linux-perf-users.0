Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFB244687
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918826; cv=none; b=dnzprZtCMm3i0SaRn8TAWhECmZsaZW/WmQD0Bd+oRkoFc3HsTyoPu0gT5ajBItE+PbTK0WaQhv8/1SQA5rMXJ1MbJ6N2VAZcFvRBh2Drh2X3psJ5LYn4ep0Y3mzN475VBe4BzcpixHbQA2lBvrIpjSFA8ZuL3UAYcz2o9immzlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918826; c=relaxed/simple;
	bh=qcnxA3d7vMoOU4ILPi2Gmn7xiweGM+CrVdSFKau72a8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cl8dcN0z4HMSLiadtVynKZ4RYircIFzQBnsW0mnHoSRlj6TJ+5jYFx+vih0WyaW3pKJji6e9lBkE6faOLJQm1vlpd1mmpAXrq8bNyOBguZ8hxQYejdTHB7r+yAianBYZ6+xk+ENALc8rqUYdCjYecf+WGTXIwcrHPbsycZakldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSU/eAYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSU/eAYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FF1C2BCB2;
	Thu, 23 Apr 2026 04:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918825;
	bh=qcnxA3d7vMoOU4ILPi2Gmn7xiweGM+CrVdSFKau72a8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MSU/eAYmrLzqx9nDRCttvyZBLtMrg8HQWM0+J6+ppr/NFl2bhFbEu4ZmlqRn+ANQ7
	 W5DVGuB/JipPyQ5Q1wNXoVv/sUIfWvh6B1si8g58ydygfpQgiarPSwoTvk//ADFEMe
	 HEV9yxHfs5EPCo8UCseu0Cg2sgNM4PQ5dZravQSwJT36j4HjlUdR3+ApJnWIwWhJA9
	 P1frrZp4pdG8/uLfZlhU0F3R7Jd65qumkNqMxltgtUskGXzRCsYAupLM8tftElFB9p
	 j2XP7KSTSCZogEcJkVGYM77aBurW6RRSYpCpDoheE/Mw0nT3pIggIN+C1zLV6L6X0Y
	 6ftagKpgUIYaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 55/58] perf Makefile: Update Python script
 installation path
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-56-irogers@google.com>
References: <20260423035526.1537178-56-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:33:45 +0000
Message-Id: <20260423043345.85FF1C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The TUI script browser fails to locate Python scripts due to hardc=
oded legacy paths.
- [High] Standalone Python scripts are installed with non-executable permis=
sions (`-m 644`), breaking script execution.
- [Medium] Test targets `make_no_scripts` and `make_minimal` no longer disa=
ble Python module support.
--

commit 615391f35d543aa8e125cf128454ccde6c3b24ac
Author: Ian Rogers <irogers@google.com>

perf Makefile: Update Python script installation path
   =20
Remove libpython feature test that is now a python-module feature
test. Update references from libpython to python-module accordingly.

[ ... ]

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2020532bab9cf..e50b1e8cf85df 100644
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

Since the commit message mentions a move to standalone scripts, will
installing these python files with non-executable permissions (-m 644)
prevent them from being run?

If scripts are transitioned to be executed directly via execvp(), it looks
like they will fail with a permission denied error because they lack execute
permissions.

This isn't a bug in the modified file, but does changing the installation
directory to no longer use 'scripts/' break script discovery in the TUI
script browser?

Looking at tools/perf/ui/browsers/scripts.c:find_scripts():

	{
		char scripts_path[PATH_MAX];

		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
		scripts_dir_fd =3D open(scripts_path, O_DIRECTORY);
		pr_err("Failed to open directory '%s'", scripts_path);

Will the interactive TUI script browser fail to locate or execute any
installed python scripts because it still hardcodes the old lookup path?

[ ... ]

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 31b064928cfca..f2c5f1c254a7c 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -75,8 +75,6 @@ make_jevents_all    :=3D JEVENTS_ARCH=3Dall
>  make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
>  make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
> =20
> -make_no_libpython   :=3D NO_LIBPYTHON=3D1
> -make_no_scripts     :=3D NO_LIBPYTHON=3D1
>  make_no_slang       :=3D NO_SLANG=3D1

By removing NO_LIBPYTHON=3D1 from make_no_scripts without replacing it with
the new NO_PYTHON_MODULE=3D1 flag, does this target fail to disable Python
module support?

It seems make_no_scripts now evaluates to an empty configuration rather than
a script-less build test.

[ ... ]

> @@ -118,7 +116,7 @@ make_install_prefix_slash :=3D install prefix=3D/tmp/=
krava/
>  make_static         :=3D LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PE=
RF_READ_VDSOX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1
> =20
>  # all the NO_* variable combined
> -make_minimal        :=3D NO_LIBPYTHON=3D1 NO_GTK2=3D1
> +make_minimal        :=3D NO_GTK2=3D1

Similarly, will make_minimal incorrectly include Python support if the
development headers are present on the host system? Does this invalidate the
minimal build test because it no longer represents a truly minimal
configuration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D55
