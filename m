Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66073407CCA
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727522; cv=none; b=ETXbpk0N/kNcAQ8WzUAW2Jxi5WMFDAGpOaM4K7EU94VZ0jD086eyxGkdpIOc5oBuUHRTxffgguQgmkJqoFL0tzPYxplV+9kF8rUv0uhwFZZNkQf7/GNZTtxYhmgIPg226e49WI1UozXMMX7tZaYTUAWMHWLuddfmRTYjELKbmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727522; c=relaxed/simple;
	bh=dnj3i82Z+ItxqM34yG/PZSnso2cjHZzLdfwwOmGNe2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pCv8Wa6MNncFYuj6MrEbFfLdPD+7ldQAiITKeSE2fBmlc39UCQbtbtu1Wg4+QrgpYTO2siX/c8DSr7guMOAASoatd4dX0Tidor61XvHoB5TNjBK7ODNyujjG5lHkf5flxI2NCUzW/rKeuYkssq6WY0kRrHx3VfYf4p8q7FA66Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Baw9WCd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Baw9WCd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3001F000E9;
	Fri, 10 Jul 2026 23:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783727521;
	bh=yCUnUs6/+4Wq9rPnRSIPw0KJ/4APWF2J87o0gtNwoUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Baw9WCd66EBOtGIAHDFvzPWoSQNa5dgiRdzy8MGcoLSBGn6eHRQyZyTWWYC18+/WL
	 XdBNSfxJOYBRpxXKTIoEgjwgABmH6q284k1g594PjyXGDHpKrLmslrBctHSHQa0eX/
	 JtIx0Ml7mpIS3JnMdsDA91SelJc2JVC2wJJW8Rf27as+Z8oeBw4HPLhd7pfxhuVoRm
	 i4Gt2XlnItqbhs2ahYEKS09BCi6mwLkVXslm70W74OA7/dSZt4r7xcDZL7l09BgURc
	 M9/YL2IaSS9iJLW6gd5eb9wWJEHOYSIL+QxGmMsH6uzgJcghmqcB+6GfTWp6NsKUNB
	 yVGHXZEgd4+7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Update test for --for-each-cgroup
 option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710234143.1934263-4-namhyung@kernel.org>
References: <20260710234143.1934263-1-namhyung@kernel.org>
 <20260710234143.1934263-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 23:52:00 +0000
Message-Id: <20260710235200.CD3001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `check_evlist_expand()` test fails to exercise the bug it in=
tends to verify because it specifies `-e cpu-clock`.
- [Medium] Bash pipeline semantics mask `perf stat` command failures, poten=
tially causing false test passes.
--

--- Patch [4]: [PATCH v2 4/4] perf test: Update test for --for-each-cgroup =
option ---
commit b42b21fdf494fb61acde3f563ac29e9b49df9327
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Update test for --for-each-cgroup option

This commit updates the stat_bpf_counters_cgrp.sh test to simply check the
number of output lines with and without the --for-each-cgroup option.

> diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/per=
f/tests/shell/stat_bpf_counters_cgrp.sh
> index ff2e06c408bc6..17b17b112169c 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
[ ... ]
> @@ -58,9 +58,24 @@ check_system_wide_counted()
>  	fi
>  }
> =20
> +# Missing flags in evlist__clone() resulted in different output.
> +# Just check the number of output lines for simple verification.
> +check_evlist_expand()
> +{
> +	normal_output=3D$(perf stat -a -e cpu-clock -x, true 2>&1 | wc -l)
> +	expand_output=3D$(perf stat -a -e cpu-clock -x, --bpf-counters --for-ea=
ch-cgroup / true 2>&1 | wc -l)

[Severity: Medium]
Will this actually test the bug with evlist__clone() missing flags?

By specifying -e cpu-clock, the loading of default events is disabled,
meaning default_metricgroup and default_show_events are false. This prevents
the duplication bug from occurring during evsel__clone(), rendering the test
ineffective at catching the regression it was meant to verify.

[Severity: Medium]
Also, does using the pipeline | wc -l mask any failures from perf stat?

Without set -o pipefail, the pipeline's exit code will just be the success =
of
wc -l, so if perf stat fails (e.g. from missing permissions or PMU errors),
the script will miss the failure and might falsely report a test pass.

> +	if [ "${normal_output}" !=3D "${expand_output}" ]; then
> +		if [ "${verbose}" =3D "1" ]; then
> +			echo "Normal output has ${normal_output} lines, but it now has ${expa=
nd_output}"
> +		fi
> +		exit 1
> +	fi
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710234143.1934=
263-1-namhyung@kernel.org?part=3D4
