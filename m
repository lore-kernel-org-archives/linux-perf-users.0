Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7753D667D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051687; cv=none; b=VY4dT87t0KyE/1k5a/snjxSVO5RUkOlCRkVoSVyBSRtPSG4VltY9rO/Xv4TBiV9CV4L+ubzfWA1yhPLwSk0c5BI5Ap1JUYCQn8G86YftmjLJUKKfOW9kxwcXgjj385VA/UYfCHpKq3/bpJU9PyfkihSLlwi5bKaAA0psxYqsR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051687; c=relaxed/simple;
	bh=kfrQgpZEnqrtPX0UTTy1I1uGvWSyvEc7PPVMsQiKhlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKx3P+1v1TDk9PUyqbEUJVKKvgonMdS6UTeIrCpRFbj7yam3I9YV7jGxp7nBewSuPq9zqdIVXOfWKN32Rt81SZ8iA7QkfuQEIcE2upkDzW0depguDcNJ6qXWx9FSLAeeGdU0jN0k1/SFHpl0k5RXLSbzerIOXwNl1QrJkZw8la0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDuDXMZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDuDXMZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7059AC2BCB2;
	Fri, 24 Apr 2026 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051686;
	bh=kfrQgpZEnqrtPX0UTTy1I1uGvWSyvEc7PPVMsQiKhlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LDuDXMZuAjW4fZG64wraMhZPv8+LKlmHHOCevEPiLCbjc0uE4ST8SEOk+G9a3cjRh
	 hpsRt9RCFkbF99u4MVOnE4RsYevXSwt39zvl7jicYjZx3fWi1dhv7qxGXzDxaq8F9V
	 haXykkZG4QVKGvJ4mxrsCATVJgxVRSv2myu10855iKdpMDMA2fdSYGdYh0hD2byiT4
	 C8OM/HBWvtN26mqsHe9+9TDYURLI+54EiTJoYdQ2wOHs+qWXtcSTzU/vJ9iX9s32IA
	 NWebEKcVbM35UWEJQlNqh5JfCDfoBIvL1EEVy8qpIdm3e8cimkDfv47uZQuWzPryEt
	 2bKDSKcZD7OJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 52/58] perf test: Migrate Intel PT virtual LBR test
 to use Python API
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-53-irogers@google.com>
References: <20260424164721.2229025-53-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:28:05 +0000
Message-Id: <20260424172806.7059AC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The virtual LBR test incorrectly fails instead of skipping when =
perf is compiled without Python scripting support.
- [Medium] The Python script `perf_brstack_max.py` hardcodes the module imp=
ort path to the source tree, breaking out-of-tree builds.
- [Medium] The target workload being traced in the virtual LBR test was alt=
ered without documentation.
--

commit cbbef273b0244c6297a2400b5289beae1b58936c
Author: Ian Rogers <irogers@google.com>

perf test: Migrate Intel PT virtual LBR test to use Python API

The Intel PT virtual LBR test used an ad-hoc Python script written on
the fly to parse branch stacks. This change migrates it to use the
newly added brstack iterator API in the perf Python module.

> The Intel PT virtual LBR test used an ad-hoc Python script written on
> the fly to parse branch stacks. This change migrates it to use the
> newly added brstack iterator API in the perf Python module.

Is it intentional that the workload was changed from uname to perf test -w
brstack, and a new perf inject step was added?

The commit message only mentions migrating the python script to the new API,
but does not document the changes to the test payload and processing
pipeline.

> diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/=
tests/shell/lib/perf_brstack_max.py
> new file mode 100644
> index 00000000000000..c826e14160d640
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_brstack_max.py
[ ... ]
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

Does this hardcoded relative path break out-of-tree builds like
make O=3D/path/to/build?=20

The compiled perf.so module would be generated in the build directory
rather than the source directory, which might cause import perf to fail
with a ModuleNotFoundError.

[ ... ]
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/s=
hell/test_intel_pt.sh
> index 8ee761f03c38b5..d711ecdf5be020 100755
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

Will this cause the test to fail instead of skipping if perf was built
without Python support?

The setup_python.sh script only checks if the python executable is available
on the host system. If Python is installed but the perf python extension
was not compiled, the script's import perf statement will fail. This will
result in an empty stdout, evaluating to times_val=3D0 and causing a hard t=
est
failure rather than a graceful skip.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D52
