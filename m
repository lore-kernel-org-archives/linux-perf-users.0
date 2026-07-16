Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC083093DB
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177363; cv=none; b=u5hivZgF2FD8j/5eoEUM2p0ngm12xnnfIG1TS4fG4+7K+I8ifwKCsIKwFombmzZjbvutY+uZiSv1sn0tr72vGLwcgcrdThMkxLIQvj7OQ297+Kfe33I6aruc1fYqxK7CYTukdOvnYQx1LVp2YXdnKOkA0INlEmeUb/KJAhbQfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177363; c=relaxed/simple;
	bh=qiqzmuaIR8FKDVx+z8ed59ea4DtRfKNcPI0RamKDNrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzkAXhScG5wFf3C6IQAQo4RAFp7HHR7ILW5glG8AwdYjr5mQuAel4AC4Y1WnPkJThHywRMvlQ55xOseyU8FX/yjF74plTTNYmiDpGCBKbmNgLrLT6RkgwJZZMUec6uZIVtsTgb9n6OmB/KUe1Z4cPMMTseMYdgWSDjQ7lV3xXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+cLb26e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+cLb26e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6521F000E9;
	Thu, 16 Jul 2026 04:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784177361;
	bh=TQyjhkJMevx67hVpjNQVMGHrtktbmjZXwMyoPijPqzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+cLb26eK+rCeppOAvrtylNP4A0jimTdMXHlTFnlnYzIE2sr6O1U7yt9GUQZH5V7G
	 8ExlCq2k2H0KAky3lDB0bRruug0TWE/hS79j/lw1b0qWt+8aCQKpXOBihKWr5E4rwi
	 TzN7i7zfBRVXqMzQJJLdcJJY5wGZG3hzSR8EY+enhb4KZROyo5mtbGEzunGj4BdBIi
	 ra8fWeFSmR3L4W2HK72hFs61gvvgdpzD6Ea1jExhqstQ5LWPiPEn5eJHGlMS7GjomI
	 4TtCEBLRaXAIP7eJVJYwZdaW/klWDaoqkSa8FeRK98gS9eETvb+zhmurf3+JraL5vg
	 a9Pid/XMgHzaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/14] perf stat: Extend PMU metrics value linter to
 validate --new outputs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-15-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:49:21 +0000
Message-Id: <20260716044921.9C6521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script directs users to an empty debug directory and le=
aks temporary files on failure.
--

--- Patch [14]: [PATCH v3 14/14] perf stat: Extend PMU metrics value linter=
 to validate --new outputs ---
commit 04fc0ceb56132c274f7a0d6caa07c7fa1e8373fa
Author: Ian Rogers <irogers@google.com>

perf stat: Extend PMU metrics value linter to validate --new outputs

This commit updates the stat_metrics_values.sh test to run the python metri=
cs
value validation linter twice. It tests both the legacy path and the new API
path using the -new argument to mathematically guarantee valid metric
calculations.

> diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/t=
ests/shell/stat_metrics_values.sh
> index 30566f0b54279..9823b09589574 100755
> --- a/tools/perf/tests/shell/stat_metrics_values.sh
> +++ b/tools/perf/tests/shell/stat_metrics_values.sh
[ ... ]
> @@ -19,13 +19,29 @@ echo "Output will be stored in: $tmpdir"
>  for cputype in /sys/bus/event_source/devices/cpu_*; do
>  	cputype=3D$(basename "$cputype")
>  	echo "Testing metrics for: $cputype"
> -	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${wor=
kload}" \
> +	mkdir -p "$tmpdir/legacy"
> +	$PYTHON $pythonvalidator -rule $rulefile -output_dir "$tmpdir/legacy" -=
wl "${workload}" \
>  		-cputype "${cputype}"
>  	ret=3D$?
> -	rm -rf $tmpdir
>  	if [ $ret -ne 0 ]; then
> -		echo "Metric validation return with errors. Please check metrics repor=
ted with errors."
> +		echo "Metric validation return with errors. " \
> +			"Please check metrics reported with errors in: " \
> +			"$tmpdir/legacy"
> +		exit $ret

[Severity: Medium]
Does this error path leak the temporary directory?

Since the cleanup is now at the end of the script instead of inside the loo=
p,
calling exit here will bypass the removal and leave the temporary directory
behind.

Additionally, will this output directory actually contain any error reports?

The error message directs users to check the legacy directory for details, =
but
because the python validator is run without the -debug flag, it appears this
directory will remain completely empty upon failure.

> +	fi
> +
> +	echo "Testing metrics for: $cputype (New API)"
> +	mkdir -p "$tmpdir/new"
> +	$PYTHON $pythonvalidator -rule $rulefile -output_dir "$tmpdir/new" -wl =
"${workload}" \
> +		-cputype "${cputype}" -new
> +	ret=3D$?
> +	if [ $ret -ne 0 ]; then
> +		echo "Metric validation return with errors (New API). " \
> +			"Please check metrics reported with errors in: " \
> +			"$tmpdir/new"
> +		exit $ret

[Severity: Medium]
Similarly, does this exit path also bypass the temporary directory cleanup
at the bottom of the script?

Also like the legacy path above, without passing the -debug flag to the pyt=
hon
validator, it looks like this directory will also be empty when a user atte=
mpts
to inspect it for errors.

>  	fi
>  done
> +rm -rf "$tmpdir"
>  exit $ret

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D14
