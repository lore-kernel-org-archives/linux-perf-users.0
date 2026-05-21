Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB26315D49
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329273; cv=none; b=DY5p1RjzeCqo5E0Dh0b0Js4xvNibi2hi8vTQRwGR2sKdxYO/jP05ixtwahExM4tZswfKKSG2/2E5ErbR5rAa4hzWBJUPZg9rMdmeww8x3nRVzWo35txWLZQt7vQEao0wBarbDc0uGDThS24uWlhMo4uXUAHGtfbV+5hcoUVjvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329273; c=relaxed/simple;
	bh=FTjEFx2du/wywn4GGDIvwhEHVMNx4Vm89tSSKxZ9scI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cq+RVJsZkydCS3htZpdSO9Dc/AGoWAuuoznpUKdcbMlnL4/FLIkRQsMJ5qmqccMTly5MleRz7rs+2lPH/G5wHWj9L5CMSe7kg3t0x+Ywg2sIH8QVSuTV5ZGYhvoq528TUpkPNKwX4wGuXGtDbg7DHbXFSx4jaFSm3IYioe3qZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArjbWlS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArjbWlS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF2C1F000E9;
	Thu, 21 May 2026 02:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329271;
	bh=zucT9l07GF5Yuv7D2F0iSufDDEJRy79pz3CIA5qfsew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ArjbWlS1cjXvZNGpU526oyOE9WCNJENxxiPqSktPVUevPc0tP+3Rao0xbA2HySfPD
	 /TKZZejiUvbPWCj93KYUGADF0gbx25HeYvI5amhFbuKp0RdE6qtQa1Eocjc4MTEncD
	 DYY0iYkWZCVK33asoWuXDddefpU2FabvQ8CKqqp0i1GZFR8LX95a6AEuA9S9NiLaYo
	 vMR1BNipWYzDQYUf2R+3RybZPlLyFLX3wxjQovUVIRn7c7xg0ZtYsAXoIEfmQEsMSN
	 p5kegHKYtgqXnqEA7av5PabLgzUsxlC+LWCjY+n5pQ11qwA4Aqp4+u8Lugr4gMWaRJ
	 HlKfqwHbrHBJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 27/27] perf test: Add truncated perf.data robustness
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-28-acme@kernel.org>
References: <20260521011027.622268-28-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 02:07:50 +0000
Message-Id: <20260521020751.8BF2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test fails to detect OOM (Out Of Memory) kills as failures, =
allowing resource exhaustion bugs to pass the robustness test.
--

commit 3fd512cd1262824e73470f77a4d2f406dcb92047
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add truncated perf.data robustness test

This commit adds a shell test to verify that perf report handles truncated
perf.data files gracefully. It records a simple workload and then runs perf
report on the data truncated at various offsets, checking the exit code
for crashes.

> diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests=
/shell/data_validation.sh
> new file mode 100755
> index 0000000000000..fa7980c4ddd30
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_validation.sh
[ ... ]
> +	# Detect crash signals portably =E2=80=94 signal numbers differ
> +	# across architectures (e.g. SIGBUS is 7 on x86/ARM but
> +	# 10 on MIPS/SPARC).  Use kill -l to map the number to a
> +	# name on the running system.
> +	if [ ${exit_code} -gt 128 ] && [ ${exit_code} -lt 200 ]; then
> +		sig_name=3D$(kill -l $((exit_code - 128)) 2>/dev/null)
> +		case ${sig_name} in
> +		ILL|ABRT|BUS|FPE|SEGV|TRAP|SYS)

[Severity: Medium]
Will this miss Out-Of-Memory (OOM) kills?

If a truncated perf.data file causes perf report to read an abnormally large
size from a partial header and attempt a massive memory allocation, the
kernel's OOM killer may terminate it with SIGKILL (exit code 137).

Because KILL is missing from the case statement, the test will ignore the O=
OM
kill and consider the run a graceful error exit. Should KILL be added to the
list of failing signals to ensure resource exhaustion bugs are caught?

> +			echo "FAIL: perf report crashed (SIG${sig_name}) on ${cut_at}-byte tr=
uncated file"
> +			err=3D1
> +			;;
> +		esac
> +	fi
> +done

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D27
