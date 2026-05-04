Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9D1096F
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870926; cv=none; b=bNC8PyxTB75FM0rEvnUl1XvuqJNgOGyKWzborB9sUlX/RgInkgw5sBo5iCXBUTIvsL5imdfVTOggslFcsV8+CzblLJowbp776fgApyvxoVvTv/VGRQmHU879URtqnmJ6wuECaFgWfLWJo80qDlCWR3uIMftYjWgrwCWNqf/lYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870926; c=relaxed/simple;
	bh=xviJqtB7WZ0W2bRPly2CqNKqc5J3je/FZTZiKMidQgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eNCbSYNo5t7FYcTphx7bGSgZ2k7rEKcKAcFIhLqABbmjNqB7rW3iALiTBbt65gqbNZCZrjwHjhD1A8NuufG4MomyOzQ3HGZfF99e0l425ILH1fforWMhrp61B5e2++RGynfhN39sByD3GUyeatiLgSOfc9qWpGqFhsVULlyT1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8xwWg9s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8xwWg9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58980C2BCB8;
	Mon,  4 May 2026 05:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777870925;
	bh=xviJqtB7WZ0W2bRPly2CqNKqc5J3je/FZTZiKMidQgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=K8xwWg9suglIVVfj6yjMBMuiIMuLF+6yUr1Z0XmRyaFbqskPNTpwQ92rVarwaz6nE
	 1KcgaeMOZXhEvPrrSVuyV2AGqLm00ciRhsaoFzD66P1JAXbIpbVFDCZllP07BeDQuJ
	 SjY5BlIatVJqD5jrWBRzAQKNsMP7DG8PGVm2W0Wgj3FYvBFelGFL5xfuxTjUquhQed
	 NElhwltH03y7uKUE6PAKXfW6STbzSlErxLTtcQnt8ZD3tGfGtQerZgamZp3Q1FMy8z
	 Nz7MpXGLEGAHWujzmk6GJcW7T3L2ni6MDcvvN2a9uRE0fA+zaBatR0nmsU08j2pqzv
	 ytbFDa8VQ3q2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] perf test: Add inject ASLR test
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504035125.1851720-5-irogers@google.com>
References: <20260504035125.1851720-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 05:02:04 +0000
Message-Id: <20260504050205.58980C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The claimed multi-arch address normalization feature is not impl=
emented.
--

commit 7330768f7ec5b4d1676ce71056c223b55aff876e
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

This commit adds a new shell test inject_aslr.sh to verify the perf inject
--aslr feature. It covers various remapping scenarios, pipe modes,
callchains, and report consistency checks.

>     The test suite is hardened with:
>     - Global 'set -o pipefail' pipeline checks to catch failures in perf =
script.
>     - Safe awk processing loop closures that consume whole streams to avo=
id SIGPIPE
>       signal aborts.
>     - False success assertions to verify callchain data isn't dynamically=
 dropped.
>     - Graceful error paths on empty sample records.
>     - Multi-arch support (32-bit and 64-bit address normalizations).

The commit message mentions multi-arch support and 32-bit and 64-bit address
normalizations, but it appears the script only normalizes the DSO names.

[ ... ]

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 000000000000..fa7dd3b4c411
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh

[ ... ]

> +test_kernel_report_aslr() {

[ ... ]

> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
> +
> +  # Normalize kernel DSOs and addresses in clean reports
> +  # This allows kernel modules to be either a module or kernel.kallsyms
> +  local report1_norm=3D"${temp_dir}/report_kernel1.norm"
> +  local report2_norm=3D"${temp_dir}/report_kernel2.norm"
> +
> +  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0)=
; \
> +        print}' "${report1_clean}" > "${report1_norm}"
> +  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0)=
; \
> +        print}' "${report2_clean}" > "${report2_norm}"

Does this awk script normalize memory addresses, or does it only normalize
the DSO names?

The code seems to avoid address-related diff failures by summing the percen=
tage
column later, rather than normalizing the addresses themselves.

Could the commit message and the inline comment be updated to accurately
describe what the script actually normalizes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504035125.1851=
720-1-irogers@google.com?part=3D4
