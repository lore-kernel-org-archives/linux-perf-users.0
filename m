Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6231282F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918433; cv=none; b=OM26HSwrtexJH5l9cxQ++FwilBgByZQPG2qMcIuCwAc93ShARK7coPoqrQhceSNoizrzm8q7P2yFh/txACZv3H51fBewRbGD+3zWBUdisZc+iEhLGP7Y+UdSrgWneKxsAefuT++ZP5RfXt7/AgeabIRMjbMqywc0+biIXbGRPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918433; c=relaxed/simple;
	bh=qJqz0U65QlrTSKOmM5E5PpP+7fx3+gIS6iyA1qbzcpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mkkwy+5/cLtEB50eO1QLcCMwV5A8NQ48csYFF6DSaQuDmJc9CUycZ+aKhUp3Vou1NS5LWWiYjN7HM3lTNkq7vy3CjxSo+/e9BvnO6CXjaCZy5eICK/MZnMgwK1/nr/lIrsJT8BZUvLfgaFwQJQDFBkb7t+D9k+SPHobW+4adKtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYfsp2Bj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYfsp2Bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26493C2BCB2;
	Thu, 23 Apr 2026 04:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918433;
	bh=qJqz0U65QlrTSKOmM5E5PpP+7fx3+gIS6iyA1qbzcpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DYfsp2Bj6x8R0X7c3I+kR0lO/5ktph+gHe9e4JSqWwqZatLkAaZl3QjMEJCfVOe3+
	 +4Bjqzf1TucLh+PY2JXItBqj3Hq/Pg7tFbpE5x/UB3bPNcIgJpuIiLoSPZSgiPaATm
	 OKGqLvpBE8QJ+7o9RlhHVR3qqXfPrzQYY653Cj4tJiH4N5tFsDfHHEusiawNR9pRzm
	 x2MWDMYYL6T7X1ho1scRyLcR1BWyDx1YHuu3HdRtIbKnCEaWsrogUnpPtk6O3iYfiw
	 OsHoa+6bA64qXsbqfD+GHsiJ+7NX+CHZJKXZm0VP0aXCvPYIQh5MxRVUNEz/sQZdrQ
	 3Q0maK4o/wJjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 52/58] perf test: Migrate Intel PT virtual LBR test
 to use Python API
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-53-irogers@google.com>
References: <20260423035526.1537178-53-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:27:12 +0000
Message-Id: <20260423042713.26493C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The `perf_brstack_max.py` script hardcodes the `perf` python mod=
ule path to the source tree, which breaks out-of-tree tests.
- [Medium] Removing the explicit `perf version` feature check for Python su=
pport combined with ignored script exit codes causes false test failures on=
 systems built without the `perf` Python extension.
--

commit 476471672d05f0679b27caaca9409c70c20a974a
Author: Ian Rogers <irogers@google.com>

perf test: Migrate Intel PT virtual LBR test to use Python API

This commit migrates the Intel PT virtual LBR test to use the newly added
brstack iterator API in the perf Python module, replacing an ad-hoc Python
script that parsed branch stacks.

> diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/=
tests/shell/lib/perf_brstack_max.py
> new file mode 100644
> index 0000000000000..c826e14160d64
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_brstack_max.py
> @@ -0,0 +1,43 @@
[ ... ]
> +import os
> +
> +script_dir =3D os.path.dirname(os.path.abspath(__file__))
> +python_dir =3D os.path.abspath(os.path.join(script_dir, "../../../python=
"))
> +sys.path.insert(0, python_dir)
> +
> +import perf

Does hardcoding the python path to the source tree break out-of-tree builds?

In out-of-tree builds using O=3D..., the compiled perf.so extension is
generated in the build directory, not the source tree. This would cause
the import to fail with a ModuleNotFoundError.

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

Will removing the perf version build-options check for python scripting
cause false test failures on systems built without the perf Python extensio=
n?

The setup_python.sh script only verifies if a Python executable exists on t=
he
host, not if perf was built with Python support.

If the perf Python extension is missing, perf_brstack_max.py will crash with
a ModuleNotFoundError. Because test_virtual_lbr is invoked within an OR-lis=
t,
POSIX shell rules disable set -e, effectively ignoring the script's crash.
The test evaluates the empty output as times_val=3D0 and fails instead of
gracefully skipping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D52
