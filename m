Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046635838A
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264169; cv=none; b=WH/lL11HUapAMBPch5ccQpnm+0k9w+9uXGOnXp0NzNgUgOCCrR6IGdtFvwTMS+GhFmu1AQUk/kZZE6kng65fqFHEIZ4lmfh8zqzdUOXKPJYVV0bVkr4bQVlLZntFmaEBCsb/XUQv6qSt4dhxhpundy0gWsVlZQJOKP65hMoX1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264169; c=relaxed/simple;
	bh=qgFjQHkLYlNeDtJs91RaSESzhlAUXkInauIlrjbZPAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aLW/3UYenYnlLtKrGEDpteMyymsS3o1JmHaxG5scvd5ViBajLCO/DPg+Avt+m8A+IMAv/SIB26dU6Gtkkjm3CsvrMxbk5xGEwwyrCBTJSGudPcqkQGxJpn1NAHkl/N/IN7J44NHpFF57sUECD6etVDfS7GTA2ES/TuYs4PlAZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0mjo7Yd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0mjo7Yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC431F000E9;
	Wed, 20 May 2026 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779264167;
	bh=3N4vgF6tSDpJg+dZ6UEFL8DdkEC4eWMw1L+im31QOKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0mjo7YdWAUpV2SFhvRyBrOfWjuNJEQykdKyFbxBTK7dnh8khpZJqlq8v9UyWhM6U
	 hiptoh2neXz6r5tYb+mmuIfJPkUuo1drShOJ3MPa/i6GQVWUoDyxOEuRzj2qI/MNZH
	 hrIFkEjPmmhe9TT00VaBQF4+1CoJ5nnHlzbhcf16NHzFXz2nSdCGkCZQAE4rmfCm8B
	 NR0hYFROdLBDgNm8dTN5bg8erpLthKN+9/xWvuJ/bkDQwowJ8oDbewCbQn+ai5+L0j
	 IEaRANrF45ap3+IYbBGTHev55UzqRrp+JfoPaJsdV7n2GuIafd1BeYgODuvqTlP/jP
	 s5F2FoRRywNUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] perf test: Add inject ASLR test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520063050.3917261-4-irogers@google.com>
References: <20260520063050.3917261-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 08:02:46 +0000
Message-Id: <20260520080246.CBC431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The signal handler `trap_cleanup` incorrectly deletes the tempor=
ary directory on interruption under certain conditions, while falsely claim=
ing to preserve it, and prints duplicate messages on SIGINT.
--

commit 7275f0955025f2f2ba770bab4992dc63529b0af5
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

This commit adds a shell script to verify the perf inject --aslr feature.
It covers address remapping, pipe mode, callchain remapping, dropped
samples, and kernel address normalization.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 0000000000000..d921287e849b3
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh
[ ... ]
> +cleanup() {
> +  local exit_code=3D$?
> +  if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
> +    echo "Test failed! Preserving temp directory: ${temp_dir}"
> +    return
> +  fi
> +  # Check if temp_dir is set and looks sane before removing
> +  if [[ "${temp_dir}" =3D~ ^/tmp/perf-test-aslr\. ]]; then
> +    rm -rf "${temp_dir}"
> +  fi
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +
> +trap cleanup EXIT
> +trap trap_cleanup TERM INT

[Severity: Medium]
Will this cause the cleanup routine to run twice when a signal is received?

Since trap_cleanup explicitly calls cleanup and then exits with code 1, won=
't
the exit 1 statement natively trigger the EXIT trap and invoke cleanup a
second time?

If the script receives a targeted signal (like SIGTERM) while the foreground
command successfully completes, the first cleanup execution evaluates the e=
xit
status as successful and irrevocably deletes the temporary directory. The
immediate exit 1 then triggers the second cleanup execution, which evaluates
the failure status and prints the preservation message for a directory that
no longer exists. Under a standard interruption like SIGINT, it prints the
preservation message twice.

Could trap_cleanup simply execute exit 1 and rely entirely on the EXIT trap
to handle unified cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520063050.3917=
261-1-irogers@google.com?part=3D3
