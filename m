Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A040DFCD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646452; cv=none; b=uyTuDmMuElDtXl6b/4SeQjjlQT+UF33gQ48sui22FGUAA1F78qONlm7RZKXGOfmGw+oQIxYe8MXN7W2eyHwsuEEVFuwZDv0gQ+iHD17ACXT1t5tpZqdGdLsD1OU6dqXz8BWUq9qzR283M4k+nclkeLD1+ox8sZ0FIhj3fqtowsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646452; c=relaxed/simple;
	bh=Epr3leIJSO83h31SzCpyu+CweZgErPysDUYjXV/AzaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cjlGFy3V9QbaT5R6oIEbSU1p39wjVFOeYa+UJBfYOXLiv7P2RlGTkQ23NoF5QXm3Qwdj2qw1QD8MZt4ypGJj2+a3i0SMtS+ezk/+r6FkeiSQSEMX+nKSm4g5DbOO7gEMD3/nkWFb9N9ORFlahLz/ASxDf9MY+GEG+7pUojnlIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8WYeZ6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8WYeZ6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A2C2BCAF;
	Mon, 20 Apr 2026 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646452;
	bh=Epr3leIJSO83h31SzCpyu+CweZgErPysDUYjXV/AzaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=h8WYeZ6U/Hf9bkfgNQo9uT3GSgC9QmPa+ona/L68FWKZnM/hSkdIawdinbwx8N+Cv
	 WuA01SYuIHeqnc5BNzun1bSUO7RAbPTtC/16CvZq40pmlZWRCORu52P1gtnNaemukN
	 aXhgRT5cKsbCi5G6D7qEqJnZtAkje6jaWTE7lXtH7sjnBs/snCK1n2lHcs8o8a0y/1
	 4S7n0jIGaI/dxP1I35ILkwYFBPWEdiFpwSVhq6hO91wjyUKvhN+L2/YnqeMJH+3Ixi
	 8LpNlwosPnXc4t2P84/VFlmaQ9e1lNnAE57CpccnWG+Kf6dwJpfB0pKI7614pibPA7
	 zqHjTX61IUODQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 55/58] perf Makefile: Update Python script
 installation path
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-56-irogers@google.com>
References: <20260419235911.2186050-56-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:54:11 +0000
Message-Id: <20260420005411.EC2A2C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] The `make_no_scripts` test target in `tools/perf/tests/make` is =
broken and fails to test building without the Python module.
- [Medium] Internal script resolution logic in `tools/perf/ui/browsers/scri=
pts.c` was not updated to reflect the new `python` directory path.
- [Medium] The shell tests `script.sh` and `test_arm_coresight_disasm.sh` u=
se hardcoded legacy paths to locate test scripts.
- [Low] Documentation files still explicitly reference the legacy `scripts/=
python` directories.
--

commit 5379ea21d984f43efaab5ea1317e05b8987445a4
Author: Ian Rogers <irogers@google.com>

perf Makefile: Update Python script installation path
   =20
Remove the libpython feature test since it is now a python-module feature
test, and update references accordingly. Remove references to the legacy
scripts/python directory and install scripts directly to the python
directory under libexec.

> Remove references to legacy 'scripts/python' directory and install
> scripts directly to 'python' directory under libexec. This aligns with
> the removal of embedded interpreter and move to standalone
> scripts.

Are there other areas that need to be updated to reflect this new path?

For example, find_scripts() in tools/perf/ui/browsers/scripts.c appears to
still search in "%s/scripts". Will this cause the UI script browser to fail
to locate the new Python scripts?

Similarly, do the shell tests in tools/perf/tests/shell/script.sh and
tools/perf/tests/shell/test_arm_coresight_disasm.sh need to be updated? They
use hardcoded paths like "../../scripts/python/parallel-perf.py" and
"../../scripts/python/arm-cs-trace-disasm.py" which seem like they will now
be skipped incorrectly or fail.

Also, does tools/perf/Documentation/db-export.txt need an update? It still
references legacy paths like tools/perf/scripts/python/export-to-sqlite.py.

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -75,8 +75,6 @@ make_jevents_all    :=3D JEVENTS_ARCH=3Dall
>  make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
>  make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
> =20
> -make_no_libpython   :=3D NO_LIBPYTHON=3D1
> -make_no_scripts     :=3D NO_LIBPYTHON=3D1
>  make_no_slang       :=3D NO_SLANG=3D1

[ ... ]

> @@ -118,7 +116,7 @@ make_install_prefix_slash :=3D install prefix=3D/tmp/=
krava/
>  make_static         :=3D LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PE=
RF_READ_VDSOX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1
> =20
>  # all the NO_* variable combined
> -make_minimal        :=3D NO_LIBPYTHON=3D1 NO_GTK2=3D1
> +make_minimal        :=3D NO_GTK2=3D1

Should NO_PYTHON_MODULE=3D1 be added here to maintain the minimal build test
coverage?

[ ... ]

> @@ -150,7 +148,6 @@ run +=3D make_jevents_all
>  run +=3D make_no_bpf_skel
>  run +=3D make_gen_vmlinux_h
> =20
> -run +=3D make_no_libpython
>  run +=3D make_no_scripts

Since the make_no_scripts assignment was removed above, does leaving it in
the run loop evaluate to an empty string and cause the test harness to run a
default make command without any disabling flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D55
