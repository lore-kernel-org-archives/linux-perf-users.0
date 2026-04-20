Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62713A3ED
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645968; cv=none; b=gSA3hkMPy9E/Wp0hCBrk76+wgXJkLwVWImV0mU/kv805+w2hVyjVCD/8t2Gj4TZOIbGiHwKbIedzBdAAAVXV+NC6pu4WP85lvzR3R/k9ECFb3Lur4T/q7zgKemsBNYyM86dPkVtAc3ZZ/zo+Soi20yiMTHz4QgvggkUqg4n++Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645968; c=relaxed/simple;
	bh=50WUH94KI5ZlGnA5FkuTRCTKG9f3iPg5HoHQr6aL8xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fhc7DVIpTYxZtG9e7IssDFXKp0b1ISJZlmkXqK4JeFdGo87SrLdJd3C/VHpN2SchUmaXOv0DwgSZ6/Jikj0ktxyT9fvyMiur5dWK4fYu5thBiy+FFAThA0QgBwoocITJciQb2lO3Byp7LhvhbSFcHIo6tW3P6cII7kcjTWEqe0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOeZMHRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOeZMHRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18437C2BCAF;
	Mon, 20 Apr 2026 00:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645968;
	bh=50WUH94KI5ZlGnA5FkuTRCTKG9f3iPg5HoHQr6aL8xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QOeZMHRCJbKloWgc+JOnF8n2wSh88C9b1nDP5wlDIvNAz4x4f6cfIsLj3Z3jg1lHO
	 ASbH2eNIzddnjMp4YOD3/8beyhLNBd6gN89FTfrXSdBDd2AqFHpqg8MVKZsCMo4eb0
	 fIsXuIKGkLmbzWDdZ+FaaxQsikORPrlMMlc2ovpuNsbPyeVL/5G+L0kS6/vc/v8AiM
	 Z5/YqmvNfOuXl+mo2PSASO3RZL44xi2BtG6qOSr8pva2SoiZHXqIw3HVWmc6GXfOF9
	 1VAI3BxbC3eUN/Cs7yNDzMxGSN23EmfDexRkicve5mhP5EJau6L6nG111zJuf74DR+
	 dsXAfkjxlsnyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 52/58] perf test: Migrate Intel PT virtual LBR test
 to use Python API
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-53-irogers@google.com>
References: <20260419235911.2186050-53-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:46:07 +0000
Message-Id: <20260420004608.18437C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Hardcoded Python module search path breaks out-of-tree builds.
- [Medium] Removal of libpython support check turns test skips into false f=
ailures when perf is built without the Python extension.
--

commit ae322c0b2a25025bdfd1c2b9252929eca12fcd88
Author: Ian Rogers <irogers@google.com>

perf test: Migrate Intel PT virtual LBR test to use Python API

This commit migrates the Intel PT virtual LBR test to use the newly added
brstack iterator API in the perf Python module, replacing the ad-hoc Python
script that was previously written on the fly.

> diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/=
tests/shell/lib/perf_brstack_max.py
> new file mode 100644
> index 0000000000000..c826e14160d64
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
> +
> +import perf

Will this hardcoded path cause issues for out-of-tree builds?

If perf is built using an output directory, the perf.so Python extension wi=
ll
be placed in the build directory rather than the source tree.=20

It looks like the import perf module resolution might fail with a
ModuleNotFoundError during out-of-tree test execution, causing the shell
script to see an invalid output and explicitly fail the virtual LBR test.

[ ... ]

> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/s=
hell/test_intel_pt.sh
> index 8ee761f03c38b..d711ecdf5be02 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh

[ ... ]

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

Could this change cause the test to falsely fail instead of skipping when p=
erf
is built without Python support?

The previous code checked perf version --build-options to verify that
libpython was actually compiled into the tool. Relying only on setup_python=
.sh
checks if the python executable exists on the host system.

If perf is compiled without python-dev headers, the interpreter will still
try to run the script and crash during import perf. The shell script captur=
es
the empty output, falls back to a 0 value, and registers a test failure
instead of a skip.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D52
