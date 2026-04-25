Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFC314D26
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158892; cv=none; b=kq27Z0/zEpQSwYePwDH+ji4RcBe1JK/AEpR8IiypvDLeQ/3j9vQFG9EtVc3IRRIK0/Er2zYLVQwnR1bkMU1bgExrGJr5hlMfYgSpb9RKl2qsItFAja8Mts+uYQFE9sKudXzjHBPMzz3NybU1NcE0qE0s1NAPc7PRQL77mxtIn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158892; c=relaxed/simple;
	bh=n44a8ha14sbHmdSZfiYP6ALs+vlLAXCGE9+4y0AnIOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OyMJCkksrFkozYdztDA85pAAlgLHpuoG3P36p7+UqrfXDwFbSdfT+HMo9ffvexvTGvj7plafx+GxOoV/thv6DsTinROFNNBtm4ehyom9Ku5Vo7TmhYp30vJIEMADEhPIz7hMVnfTUQx8gQNJ5IGV4jisqPjH0RpzPls8XKpBynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIHyaN6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIHyaN6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F127C2BCB0;
	Sat, 25 Apr 2026 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158892;
	bh=n44a8ha14sbHmdSZfiYP6ALs+vlLAXCGE9+4y0AnIOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iIHyaN6e+mvFBBaTLK0AM1BbyyfW+bjtICA7Bp48/V1w+W0GWGdQe5T0T4i/YZ1rp
	 JOadCdffJA4TRJNDy88/v14QGvlwRKlgaqF2jU8O6Tgf255WAMVV4ukHVb7+qtArR7
	 tXc5dJaUNVLbkO8OD8ZMh8lKFHwzMtQAAQOiL8SuYWu5mZfV2rlOVMPF5sYzzRtoqV
	 142l/Y58wornX9CaYaAcLBUqM8CdmZeb5YHxh5f5XWOIC179Zg38T+Hcleom8BDwzv
	 zru/qkMjRUggS0TYYOQf2LLYfD4p1Lml2gW8GDwUQz1jevufI8tID7PevpMzp+udCN
	 wY9lutUcUkWXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 52/59] perf test: Migrate Intel PT virtual LBR test
 to use Python API
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-53-irogers@google.com>
References: <20260425224951.174663-53-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:14:51 +0000
Message-Id: <20260425231452.0F127C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The test fails instead of gracefully skipping when perf is compi=
led without Python support.
- [Medium] Hardcoded module path in `perf_brstack_max.py` breaks out-of-tre=
e builds and installed test executions.
--

commit 80b4743807670a643e81f4cb7853f698004da24d
Author: Ian Rogers <irogers@google.com>

perf test: Migrate Intel PT virtual LBR test to use Python API

This commit migrates the Intel PT virtual LBR test from using an inline
ad-hoc python script to a dedicated Python script that utilizes the new
brstack iterator API in the perf Python module.

> diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/=
tests/shell/lib/perf_brstack_max.py
> new file mode 100644
> index 000000000000..bd1cdb463f28
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

Will this hardcoded path cause the test to fail in out-of-tree builds or
installed environments?

In out-of-tree builds (like make O=3D/tmp/build), the compiled perf.so
extension resides in the build directory, not the source tree. Similarly,
when running perf test from an installed location, this relative path
won't point to the correct system installation path.

In both cases, import perf will fail and cause the test to crash.

[ ... ]

> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/s=
hell/test_intel_pt.sh
> index 8ee761f03c38..d711ecdf5be0 100755
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

Can this change cause the test to fail instead of gracefully skipping when
perf is compiled without Python support?

The setup_python.sh script only checks if a Python interpreter exists on
the host, not whether perf was actually compiled with the Python extension.
If perf is compiled with NO_LIBPYTHON=3D1 or without the required headers,
setup_python.sh will still succeed, but perf_brstack_max.py will crash on
import perf with a ModuleNotFoundError.

Since the Python crash output goes to stderr, the test reads an empty
stdout, assigns times_val=3D0, and fails instead of skipping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D52
