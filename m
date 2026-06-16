Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEC1A6803
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573972; cv=none; b=M7722leLUuj+ijfkZywTssTj03oxgjhC39ESFor6SXS5VOYPYTek2VOrPYDBTknxCRqssR9YiRqOCajTuLyP8A/NSsnCNGSYoWJcz76000kPbah7NESLViHU4t5TozUh8pd5XNJ9iAOryiXG8f/FPbCy7y7EMPizxn/sCas4jxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573972; c=relaxed/simple;
	bh=L0mbZimxcQKLNsqhyJ9CBiX8NZHHt9jqr1q0w9AUXak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5qWOZNIWT2PQBbS7pHmLH3nGZHu/lNSkFI/sU0+qaghGrBSb2/6qsNrrkfIAJzgGhi6e0OFBo0CQkdX8wSQxZYJsRBtNsfd79P9uLp4s171KQ1fDKfEE/H6vqJXFPrZe5MHcMM9+AVozolQua9P2JniVQplhcHKMaVyjMYpp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0pAZ/3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0pAZ/3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606271F000E9;
	Tue, 16 Jun 2026 01:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573971;
	bh=8a3ozerKyD9JULh65ifFIdHzObrUz+XxGes7lZr7phs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G0pAZ/3Y4fva/rxqlMsYm/0v0Wn94F5+q+c2NeVh98wSQIUz4w4RI+ZrKpv4ufaJu
	 q8diR5caYEop9bnTwAibjI9z8FLdQCv0pVsBDlVaFT9Z7hShMD+eG1ItNNzKwg3n5i
	 j3RAMbBymYqVuyrIMsI7T0kwgorlDxUSzFl+L0i7up/lnf/bydkGqrO0HdXLMp8zuF
	 c9enp4jAywhzkt9wxu8GTpqYTbDBLJ73jImBV7o4rZ9kfWw3WLwwiX0QFKDkC1yLlE
	 TbPmOr2GJEt+hB96dek4AxVLGE1F6X1AgvO28JqclC6ViPqe8J6j1Iq7pJ934/DNSC
	 HFCGjUGsWOQtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/12] perf tests: Fix Python JIT dump profiling test
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-7-irogers@google.com>
References: <20260616012744.4049193-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:39:31 +0000
Message-Id: <20260616013931.606271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Temporary file leak of Python JIT dumps when PID extraction fail=
s in the retry loop.
--

commit 95eef2f7b52233762f091ea2346305a0f24a12f4
Author: Ian Rogers <irogers@google.com>

perf tests: Fix Python JIT dump profiling test failure

This commit addresses the python profiling with jitdump test failure by fix=
ing
the PID parsing logic and implementing a robust retry loop for workloads wi=
th
insufficient runtime.

> diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/=
shell/jitdump-python.sh
> index ae86203b14a22..6f3d1edd6f04f 100755
> --- a/tools/perf/tests/shell/jitdump-python.sh
> +++ b/tools/perf/tests/shell/jitdump-python.sh
[ ... ]
> @@ -33,9 +36,11 @@ trap_cleanup() {
> =20
>  trap trap_cleanup EXIT TERM INT
> =20
> -echo "Run python with -Xperf_jit"
> -cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" \
> -		 -- ${PYTHON} -Xperf_jit
> +ALL_PIDS=3D""
> +NUM=3D0
> +for iterations in 1000000 10000000 50000000 100000000; do
> +    echo "Running with $iterations iterations..."
> +    cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}"=
 -- ${PYTHON} -Xperf_jit
>  def foo(n):
>      result =3D 0
>      for _ in range(n):
[ ... ]
> @@ -49,29 +54,40 @@ def baz(n):
>      bar(n)
> =20
>  if __name__ =3D=3D "__main__":
> -    baz(1000000)
> +    baz($iterations)
>  EOF
> =20
> -# extract PID of the target process from the data
> -_PID=3D$(perf report -i "${PERF_DATA}" -F pid -q -g none | cut -d: -f1 -=
s)
> -PID=3D$(echo -n $_PID)  # remove newlines
> -
> -echo "Generate JIT-ed DSOs using perf inject"
> -DEBUGINFOD_URLS=3D'' perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.j=
it"
> -
> -echo "Add JIT-ed DSOs to the build-ID cache"
> -for F in /tmp/jitted-${PID}-*.so; do
> -  perf buildid-cache -a "${F}"
> -done
> -
> -echo "Check the symbol containing the function/module name"
> -NUM=3D$(perf report -i "${PERF_DATA}.jit" -s sym | grep -cE 'py::(foo|ba=
r|baz):<stdin>')
> -
> -echo "Found ${NUM} matching lines"
> -
> -echo "Remove JIT-ed DSOs from the build-ID cache"
> -for F in /tmp/jitted-${PID}-*.so; do
> -  perf buildid-cache -r "${F}"
> +    # extract PID of the target process from the data
> +    PID=3D$(perf report -i "${PERF_DATA}" --stdio -F pid -q -g none | \
> +          cut -d: -f1 -s | sort -u | head -n 1 | tr -d ' ')
> +    if [ -z "${PID}" ]; then

[Severity: Medium]
When the loop skips because PID is empty, does this leak the temporary
/tmp/jit-<PID>.dump file generated by the python -Xperf_jit execution?

Python's -Xperf_jit option eagerly creates a /tmp/jit-<PID>.dump file upon
initialization. If a workload iteration executes too quickly and perf record
captures zero samples, perf report cannot extract the PID, resulting in an
empty PID variable.

Because the unknown PID is not appended to ALL_PIDS and the loop skips the
cleanup block, the file might permanently remain in /tmp. While the failure
to clean up an unknown PID existed previously on the error path, this retry
loop intentionally executes short workloads expected to fail, which might
turn this into a systematic leak on the test's normal success path.

> +        echo "Failed to get PID, retrying..."
> +        continue
> +    fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D6
