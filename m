Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AF3A63EF
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246707; cv=none; b=ZAQnAV4yiaVIQCANHeqbrJdQjv8ka9FuQVTVfFya3ixiLdDuclzO/bqAT3iwg+oMraCmqGqzY71DhAAKUEVj6L6/2l33jrCnFrunYX3FJax9W1M2XlnoCZdhoNKFjO2eF+JZ9D047mYP7IcsVbSrD1VE0pMhUyR54qDjwAodr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246707; c=relaxed/simple;
	bh=qb0g1j32Sff6d6UCy4MZ1jCZA76D6fk385g0wvSLGCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m9zj019QUdlduBI/3hyL8phShlttxX1SrTjMIxwPNsNG1dN6iKzc86KqI0KzZJTwG4XjhHaAkH6riU2SE/o5pJ1pqKHs9N6H/b/gSZm5hPgpDwHRY+V5x0q6xuaCWq7atAbe1wMx30157jiyyRrs5Go/8ypOD4oGTjG7cCvZYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiU16kqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiU16kqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B771F000E9;
	Tue, 23 Jun 2026 20:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782246704;
	bh=Gt0oZZ1y2eL6xxNvTLTHhz6iiKkqaxw5Xi596NUM2B0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XiU16kqDtmkPuSH/LPfMT3R9ZP3OhpJhvVL6pOEddt0UEHPMI7lYpG9Qe5W+Bu/is
	 B8RYRVTFQWJIDeCpmbhHGPiCuwYifQFOTDYj1MDy/CNZs6WHiV3Ohe8J0FsMA0AFUo
	 6GEiDKRFXNf82iifLpB+WpvfJCSvEVPZ+tKhpNzWRcl8i2qxh25c0pLCcL83usoq6B
	 7TtKIxER4X+UlRFTczKituS3wO/3xBBhsb2PhRrUSGwlbt6Gd0u0T3hpuTdhelpAv5
	 rFexkDSeciGBMZU0Gl8m1763BmWmZhvhhuAeL9RqQfIq8YuysDeTA/30D3/GPHRkha
	 w97vNocuK+e7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/8] perf test: Add Arm CoreSight callchain test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-8-1ba770c862ae@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-8-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:31:43 +0000
Message-Id: <20260623203144.06B771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test script relies on non-portable GNU-specific extensions (`gre=
p -Pzq`, `grep -Pzob`, `head -c`), breaking execution on embedded/BusyBox e=
nvironments.
--

commit fd03c33f345e7a9116fc0df15c974d8c6e112e1c
Author: Leo Yan <leo.yan@arm.com>

perf test: Add Arm CoreSight callchain test

This commit adds a CoreSight shell test for synthesized callchains using the
new callchain workload. It traces the workload with cs_etm and verifies that
the instruction samples show the expected callchain push and pop.

> diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/t=
ests/shell/coresight/callchain.sh
> new file mode 100755
> index 0000000000000..e9f907f60e3a4
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/callchain.sh

[ ... ]

> +skip_if_system_is_not_ready()
> +{
> +	[ "$(uname -m)" =3D "aarch64" ] || {
> +		echo "Skip: arm64 only test" >&2
> +		return 2
> +	}
> +
> +	perf list | grep -Pzq 'cs_etm//' || {

[Severity: Medium]
Is this grep command safe for embedded environments like BusyBox?

The -P (PCRE), -z, and -q combinations are GNU-specific extensions.
On minimal environments without PCRE support or full GNU grep, this command
will fail, causing the test to incorrectly skip or error out on ARM targets
that otherwise support the event.

> +		echo "Skip: cs_etm event is not available" >&2
> +		return 2
> +	}
> +
> +	return 0
> +}

[ ... ]

> +find_after_line()
> +{
> +	local regex=3D"$1"
> +	local file=3D"$2"
> +	local start=3D"$3"
> +	local offset
> +	local line
> +
> +	# Search in byte offset
> +	offset=3D$(
> +		tail -n +"$start" "$file" |
> +		grep -Pzob -m1 "$regex" |

[Severity: Medium]
Could this multiline regex search fail on non-GNU grep implementations?

Using -Pzob relies heavily on GNU extensions. BusyBox grep, which is
commonly used on embedded ARM boards, lacks -P, -z, and -b flags.

> +		tr '\0' '\n' |
> +		sed -n 's/^\([0-9][0-9]*\):.*/\1/p;q'
> +	)
> +
> +	if [ -z "$offset" ]; then
> +		echo "Failed to match regex after line $start" >&2
> +		echo "Regex:" >&2
> +		printf '%s\n' "$regex" >&2
> +		echo "Context from line $start:" >&2
> +		sed -n "${start},$((start + 100))p" "$file" >&2
> +		return 1
> +	fi
> +
> +	# Conver from offset to line
> +	line=3D$(
> +		tail -n +"$start" "$file" |
> +		head -c "$offset" |

[Severity: Medium]
Does head -c break POSIX compatibility here?

The -c option is a GNU extension and is not mandated by POSIX. This could
cause the test to fail on minimal filesystems or minimal rootfs setups that
use standard POSIX tools.

> +		wc -l
> +	)
> +
> +	echo "$((start + line))"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v7-0-1ba770c862ae@arm.com?part=3D8
