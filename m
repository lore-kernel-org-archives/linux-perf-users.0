Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD336682A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140847; cv=none; b=FE7UPIos0oOitP9uS0mrQ4XMFxb1aAvvpiAC/T/b+79gahLEKWfmCCPhOy7yXVMH/8uc44ZoARi/NpyMZV7Ugp1nMD4ZnB68HUTI2BMWbqKhu3csVAzZ/sYOvF8nAB+WZGoxG9fqTvZo+0Omq/URUvcO8R4Iu8ZU7ZXAzCkMcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140847; c=relaxed/simple;
	bh=tXTYmKyEpUuGgNVJbXvy83+ZiOi0zeSseoUNGLsmrNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FayJ4fLlWa2BcUUadWvaOLEfZIUKKNm1akzeeNsE9WcI+gvNR+XasCyAOC50xk4cXOspXWyDpyc3o1KRuvdwbnL6k9vsgsiFxRyefC2bL21UdCQmswZqXSVPV6VkibjIh/5QCKWnEkEFhFFj3WTctm9kxjkr8jHLHxH6BbiawjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWihdYWw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWihdYWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F2C2BCB0;
	Sat, 25 Apr 2026 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140846;
	bh=tXTYmKyEpUuGgNVJbXvy83+ZiOi0zeSseoUNGLsmrNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YWihdYWwWDDeKfTBHVUWeZSV8T8rGQtoGZfGKzFaI/ovDLXQcHg+HFwU60c5W3tVR
	 PkzFrE5EqICl/iF37YLEmDSC71ktot0UIR+XvpFxu/6GcHzJRvq6ECp5CGTb7TvvPG
	 C9qjTxIGE1JQvwO0cb0X/W4+F8sWnzTZ09iMJzc8Jk5YpKi80QQwxAmUVTi6w9fYaN
	 SYT8l4GJP0QYN0qpYw6uARX3tSZoDQ+4Sxd2i4rjYCUdKNZLHHjAEpcR/5/IwmoVzA
	 QWNx20KdOgtQL6lqvQjsvYaOeHRI8tifVnWHpzPWHohG6t3v49C0cgqYBGaY+5s7KN
	 HTHwzEBdSylOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 52/59] perf test: Migrate Intel PT virtual LBR test
 to use Python API
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-53-irogers@google.com>
References: <20260425174858.3922152-53-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:14:06 +0000
Message-Id: <20260425181406.B03F2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The test incorrectly fails instead of skipping when `perf` is co=
mpiled without Python scripting support.
- [Medium] Hardcoded relative path in the Python script breaks out-of-tree =
builds (O=3D...).
--

commit 0468e87feb947646888210ed3df346abde440b42
Author: Ian Rogers <irogers@google.com>

perf test: Migrate Intel PT virtual LBR test to use Python API

This commit migrates the Intel PT virtual LBR test to use the newly
added brstack iterator API in the perf Python module instead of generating
an ad-hoc Python script.

> diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/=
tests/shell/lib/perf_brstack_max.py
> new file mode 100644
> index 000000000000..c826e14160d6
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_brstack_max.py
> @@ -0,0 +1,43 @@
> +#!/usr/bin/python
> +# SPDX-License-Identifier: GPL-2.0
> +# Determine the maximum size of branch stacks in a perf.data file.
> +
> +import argparse
> +import sys
> +
> +import os
> +
> +script_dir =3D os.path.dirname(os.path.abspath(__file__))
> +python_dir =3D os.path.abspath(os.path.join(script_dir, "../../../python=
"))
> +sys.path.insert(0, python_dir)

Does this hardcoded relative path cause regressions for out-of-tree builds?

If built with make O=3D/tmp/build, the compiled perf C extension is placed =
in
the build output directory rather than the source tree. It looks like runni=
ng
this script in such an environment will fail to find the module and crash
with a ModuleNotFoundError.

[ ... ]

> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/s=
hell/test_intel_pt.sh
> index 8ee761f03c38..d711ecdf5be0 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -539,34 +538,20 @@ test_kernel_trace()
>  test_virtual_lbr()
>  {
>  	echo "--- Test virtual LBR ---"
> -	# Check if python script is supported
> -	libpython=3D$(perf version --build-options | grep python | grep -cv OFF)
> -	if [ "${libpython}" !=3D "1" ] ; then
> -		echo "SKIP: python scripting is not supported"
> +	# shellcheck source=3Dlib/setup_python.sh
> +	. "$(dirname "$0")"/lib/setup_python.sh
> +
> +	if [ -z "$PYTHON" ] ; then
> +		echo "SKIP: Python not found"
>  		return 2
>  	fi

Could removing the explicit feature check cause false test failures when pe=
rf
is built without Python support?

The original code checked perf version --build-options to ensure perf itself
had Python scripting support. The new setup_python.sh only verifies the
presence of a Python interpreter on the host system.

If a user tests a build lacking Python support, setup_python.sh passes, but
the subsequent execution of perf_brstack_max.py crashes when attempting to
import perf. This leaves stdout empty, making times_val evaluate to 0 and
failing the test instead of appropriately skipping it.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D52
