Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1F35E1C8
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412470; cv=none; b=fm7dGDVLaokVLCwkmwrthP9RG5LnphT4xWUH6CsS6dUwK2EoIa8ay/BOLht3E5VLq0DocITOL26y90DFCOJX1Y77FCkHN2JD0RMoz9yynTA6i4bQ58c92TS/fM9AGJ/BQg3bdzZOZehdFMBFX6Z0AMzxDHrqq5nIK3/fIQuaBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412470; c=relaxed/simple;
	bh=i4hDVFAPULSzcfkdW4IzTdmmRuxS9gXG9AgK6XYKIrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjYv87jSkPpNYcH/HuvJBFWuCIKLp0JrPjhBvsBBJh+qESPqqRR6jkzsbCVHXaWiD8zQaU/Ct79WC+o5Ze1hxQaCw3S2Y/U7Ee3uPbG3XDuiTi6KjBVIY/k6kMMcPuHkRjLzTuO0pgfAomPJhIz/x88WaLoDrFMA2pyXpAKAtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxQ5CAmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxQ5CAmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B151F00893;
	Tue,  2 Jun 2026 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412468;
	bh=NoN3P6IQbeHlHQReg8D73kVILIsUc4EQmpbd9MnymHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxQ5CAmvcSsnsakJpL+PwywcIv88pRExzipoinUnmpzRv8OKdT58JhsyX2d78kmbW
	 dhFrZNSTw92PsXY1vJ6uSExp10fDXUGWPVSVkE3BJGmx1bqRRgTxdSsw9Du3R76y1o
	 pyEpdTJRfIBBQcEnwWQjzPFBWuBhhI8yferQi7VzV2gArI4ADsBm7X+j3nR+TPSevA
	 5wyrqH8d2YEKbUIk6LLK3ddz21jgXjNKHzttPxn0zoSaIGbPNz98Fyj/9NwnHxwGVe
	 0ULVt2tcPlxkVOvamvsM9/8ym4sybt0SPqsnY/zXgCLnZoU6Xsuk6P3W8HmWW86xwC
	 EOzZNwvcWWd+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/18] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-8-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-8-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:01:08 +0000
Message-Id: <20260602150108.91B151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The explicit error handling block for `perf report` is fully unr=
eachable due to `set -e`, making the intended diagnostic failure messages d=
ead code.
--

commit 8eeed98667ec7c0548c0c55cf60670252a0dad1d
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Replace memcpy test with raw dump stress test

This replaces the coresight memcpy test with a raw dump stress test that
verifies the generation of a specific amount of raw output without requiring
a custom binary. It also introduces coverage for exit snapshot mode.

> diff --git a/tools/perf/tests/shell/coresight/raw_dump_stress.sh b/tools/=
perf/tests/shell/coresight/raw_dump_stress.sh
> new file mode 100755
> index 0000000000000..eb5a5e5e1be62
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
> @@ -0,0 +1,54 @@
> +#!/bin/bash -e
> +# Coresight raw dump stress (exclusive)

[ ... ]

> +echo "Dumping raw trace..."
> +perf report --dump-raw-trace -i "$tmpdir/data" 2>/dev/null > "$tmpdir/ra=
wdump"
> +err=3D$?
> +
> +if [ $err -ne 0 ]; then
> +	echo "FAIL: perf report failed with error code $err"
> +	cleanup
> +	exit 1
> +fi

[Severity: Medium]
Will this error handling block ever be reached if perf report fails?

Since the script starts with #!/bin/bash -e, a non-zero exit code from a
standalone command like perf report causes the shell to exit immediately and
trigger the trap_cleanup EXIT trap.

Could this prevent the err=3D$? assignment from occurring, leaving the spec=
ific
diagnostic message unprinted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D8
