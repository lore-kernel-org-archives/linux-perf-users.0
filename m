Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9682440A2D
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306655; cv=none; b=A+VuxQ6NyjnBe2ef6pEI98wWyG36lDysagfhK91+dZTJ1U2nQMwjk/tZLh8NCXgMgs3nJ2ovTFfogHzMpK7v1FHQm3XEqaaMFpKPCOYzg+n/s+Ao+G2QmaBkD20QTfQ386ufqAnXx/9+SZrURaa0PP1VzesVb6IFrTsKms0iymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306655; c=relaxed/simple;
	bh=qZGdyp6RQp7Qhduk53OiU0Xl82uMdWfEEFWdYrml0No=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OOOHNxuDI1R9IhMd3fpaf0m2nUiI0LMPFeFPTt0aM2muYbuaXV3wRChTiB6+t314sdnLmKgkSro58dSx2+xyrQX5J5iuAaOiwYYB++tZqcloRDnBwXmlzEthnmm8o73N/ZVhOFyHP8y25+FtgbIY/9MxH8lj+iQ7uvJ42S8rg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzpKzP++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzpKzP++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846BE1F000E9;
	Fri, 21 Aug 2026 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306644;
	bh=xe0wO3IIc6zU9hxbrXNfamfolYqLsk9ibE3WbYRfEiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzpKzP++G7k7lBNtVHasDCm5GkJoqyuHJL+Bla9mjgcGjKtFzsKJ4MnAdzbAyS3OZ
	 xaNe7gyVn9SBS68NhogtFFl1cTTGk50OstyVprVOLBD+ZkSkBplxnwUXeCw5bs5esS
	 k/lG+G2wAvirs5KOCw3y1Cm7Nbpuo5Khokui8CFoa5LPaBnoCdCTSmo18y8mCGwemX
	 0x0bjlbJ4ZEcTnY5lLC7tQSr+24ophtWiMCY4wPnc5eA/7EBB6jwlCJvH4EssdxOMu
	 8yDZ58f1NUNcr6EwpgG8/Wlm0sLHraIySz9IgU6wzKjUgjJ+e7EoLpbotY2HsmkI/Q
	 u83OSZGddB0aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/14] perf test: Add test for per-thread mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-13-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-13-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:04:04 +0000
Message-Id: <20260821100404.846BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test unconditionally hardcodes execution on CPUs 0, 1, and 2=
, which will cause spurious test failures on environments with fewer than 3=
 CPUs, isolated cgroups, or asymmetric architectures lacking CoreSight ETM =
capabilities on those specific cores.
- [Medium] The test hardcodes assertions against a known incorrect perf dec=
oding behavior, which guarantees a test failure when the underlying `perf` =
decode bug is fixed.
--

--- Patch [13]: [PATCH v2 13/14] perf test: Add test for per-thread mode ---
commit 5b1cfaf160332a1a985ebf60b00fdda5fa16efd7
Author: James Clark <james.clark@linaro.org>

perf test: Add test for per-thread mode

This commit introduces a new shell script test to verify that per-thread
mode works correctly when a process migrates across CPUs, and that the
decode happens in the correct order.

> diff --git a/tools/perf/tests/shell/coresight/per-thread.sh b/tools/perf/=
tests/shell/coresight/per-thread.sh
> new file mode 100755
> index 0000000000000..77d1ed3405a9d
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/per-thread.sh
> @@ -0,0 +1,48 @@
[ ... ]
> +echo "Recording..."
> +perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -- \
> +	taskset --cpu-list 0 taskset --cpu-list 1 taskset --cpu-list 2 true > /=
dev/null 2>&1

[Severity: Medium]
Will this unconditionally hardcode execution on CPUs 0, 1, and 2?

Running this on a system with fewer than 3 CPUs (such as typical 2-core CI
environments) might cause the taskset command to fail. Since the script
runs under set -e, could this fail the test spuriously instead of properly
skipping it?

Additionally, on architectures where these specific CPUs exist but lack ETM
capabilities, this could fail to capture trace data.

> +
> +echo "Decoding..."
> +perf script -i "$tmpdir/data" --itrace=3Db -F comm,cpu 2> /dev/null | \
> +	grep -Eo '(taskset|true).*(\[[0-9]+\])' | \
> +	uniq | tail -n 3 > "$tmpdir/script" 2>/dev/null
> +
> +# Check that the decode says it ran on CPU 0, 1, 2, in that order. TODO:=
 The
> +# correct result should be "taskset [0,1,2], true 2" but we don't decode=
 trace
> +# in order of the Perf events yet, so everything is associated with the =
last
> +# exec.
> +cat > "$tmpdir/expected" << EOF
> +true [000]
> +true [001]
> +true [002]
> +EOF

[Severity: Medium]
Does asserting this known broken behavior make the test unnecessarily fragi=
le?

The expected output strictly asserts the current incorrect decoding behavio=
r.
When perf is later fixed to properly associate the events with the earlier
taskset commands, the diff will fail, guaranteeing a test failure.

Since the test's goal is to verify per-thread CPU attribution, would it be
better to assert the CPU sequence rather than the broken comm string?

> +
> +if ! diff -q "$tmpdir/script" "$tmpdir/expected"; then
> +	echo "FAIL: per-thread output doesn't match expected:"
> +	cat "$tmpdir/script"
> +	exit 1
> +fi
> +
> +exit 0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D13
