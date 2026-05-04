Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2E345740
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884503; cv=none; b=dC9TkVaCW94kArBH/hn+FNnRKUNT6VqbpEdrBIDlOjRc5IeWM15bJzgv9Be1CnubdK59KfxN3vkf9ZdVxRys1nSKzWtklu4ClOXOMmkD+bTvPH1sBSiK7f+SThxi3kdBQwViarF/uykKWtZltJVOeDI2losqt0WtcqeqsyBtK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884503; c=relaxed/simple;
	bh=DM0V5u+E1HBoYfn3CKXVMp8SZu16Ldthkg97IFT+UJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X30uWVPlTCm6M3rcClHZkQogiw88cgf2VkryoBJfpvbHKdcON5MfiTE/TCNGQp4k84XkVt+UkJBvbR7OikAh0TOyJFGvmFfc9SwhLNZht/Pa1F7nZYG4TVxBDdq65SLWULmGB/oi+Nno3Hwv0kdg2//sBpWaQgsZSPwHlztzaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXm4ulud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXm4ulud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3F5C2BCB9;
	Mon,  4 May 2026 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777884503;
	bh=DM0V5u+E1HBoYfn3CKXVMp8SZu16Ldthkg97IFT+UJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lXm4uludNdVr2Y25FoFU3FVMZowA1GBkwP0UpqOYu2KkRAisRMSjPUsf4AHpquv35
	 x3AGI0wg+AUuo6evlQN6QSCRyPGD+cjPAgJF8bPJpLa9j4KMvi5KliN+9sp1x1kn9x
	 LZQODX6Ihg/L6VRRIVFBWYEMGIIGNKV96wOqwRG2tySj6Bcrfja73OsokdH8mOiPXv
	 nitntTj5MJgejKD1d1uLSJmxtqKRdp9x4doZfJ9McX7AhP6LiNNv3dudazZgiFeykB
	 p+zFkP0n348qDi/iGecdhC3UkbI7CMMGEU9fAeCeFz3BdqRGPJKearGO273+m8O/u3
	 JL8fU+xr/8ysQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] perf test: Add inject ASLR test
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504072937.2103453-5-irogers@google.com>
References: <20260504072937.2103453-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 08:48:22 +0000
Message-Id: <20260504084822.EA3F5C2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script claims to perform address normalization for kern=
el reports but fails to implement it in the awk substitution.
--

commit 35a72f67733a9ae0ed75cf3ba7c2a7ec0e4419cd
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

This commit adds a new shell test, inject_aslr.sh, to verify the perf inject
--aslr feature. It covers various scenarios including basic address remappi=
ng,
pipe modes, callchains, and kernel address remapping consistency.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 000000000000..80ec9bf3daf8
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh

[ ... ]

> +test_kernel_report_aslr() {

[ ... ]

> +  # Normalize kernel DSOs and addresses in clean reports
> +  # This allows kernel modules to be either a module or kernel.kallsyms
> +  local report1_norm=3D"${temp_dir}/report_kernel1.norm"
> +  local report2_norm=3D"${temp_dir}/report_kernel2.norm"
> +  local diff_file=3D"${temp_dir}/diff_kernel"
> +
> +  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0)=
; \
> +        print}' "${report1_clean}" | sort > "${report1_norm}"
> +  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0)=
; \
> +        print}' "${report2_clean}" | sort > "${report2_norm}"

The commit message mentions "32-bit and 64-bit address normalizations", and
the inline comment here specifically states it will normalize addresses.

However, the awk substitution appears to only match and replace the DSO
module names.

If unresolved kernel symbols are present in the trace, perf report will
output their absolute hexadecimal addresses. Since --aslr shifts these
addresses, wouldn't the unnormalized hex strings differ between the
original and injected reports?

Could this cause the diff check to fail on environments lacking full kernel
symbol resolution, leading to flaky test failures?

> +
> +  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" || true

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504072937.2103=
453-1-irogers@google.com?part=3D4
