Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC843546F6
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186174; cv=none; b=Ji5vKQamUgjWpY7nEEmybP0Niqg6DLf1XF/Sy29Tvcl8WQFsMlN07mAdQmpDVRTC/xSa6yiVg4t1SpGpZSSKotglPSKe2dxTrefYp4Y7OG6HHOc6T6BhtZml3kV/7XHTTDHokBqCUWZYDDLPAwMpqJPma5BzlmyYodhfbgOt28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186174; c=relaxed/simple;
	bh=8e+fhZlQi7kThVNUeTip9zdOxpak/iAsAS8iI7oRv9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MVDJ2fd4IjN5iMxvWuzrApiZBSxEMSmXxEWVkOT4N1ohG2fOXmikJUDRCfFiU3tl7lAuuTfH6tq2ddtFwY+pUijVMFa2hh4XHIal90Xsm1+ZfRUtv/z/mno20Ihvvf5hcSIYXD7C2Nwe4SdzEEncI9UjTY2Wb0q+p76iIO65Tb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUPBqz1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUPBqz1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C6C1F000E9;
	Thu, 16 Jul 2026 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186170;
	bh=1qwkMPYKvofBVbxkI3P7D3d86efYjztl+xnQENB49o8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kUPBqz1Xa8P+fdFoNb8+y82eU6RSbL6VN1SSUAzO21f6BR/Bq0kX15GURdUqWaQXE
	 DmzfagZoSNp2kAiJTn/R/SqKWCfhcNlTeL/yac0wOFYp3D7A3SkOJy5x93PZG4ywAT
	 n+o2dfl7CBuWb4PmTNTR0DgEX9QXFjVf1xhXfBMnSHHVydu6QfT1ZEAy1k4puaF9fn
	 hlXbmCYJ8VRLbzQimAlJbQQ4AaP81uA34MtoeDsKuwMXopXi7lnIHq5Bc2dV2WEwwU
	 8gdmNDKOOG/ZJ5a1sYWahGx7akY8Alc9waSzp2ZDand+7hwsTlg9bAwQXCa3ohFaS/
	 skak3KR+cCN0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/14] perf stat: Extend PMU metrics value linter to
 validate --new outputs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716070303.507066-15-irogers@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:16:10 +0000
Message-Id: <20260716071610.73C6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script intentionally bypasses temporary directory clean=
up on failure to aid debugging, but points the user to an empty directory b=
ecause it fails to pass the `-debug` flag to the Python validator.
--

--- Patch [14]: [PATCH v4 14/14] perf stat: Extend PMU metrics value linter=
 to validate --new outputs ---
commit aa043483360a1985a27fcbbfa6c36e6a6c2a5d00
Author: Ian Rogers <irogers@google.com>
perf stat: Extend PMU metrics value linter to validate --new outputs

This patch updates the stat_metrics_values.sh script to run the metrics
value validation linter twice: once for the legacy path, and once under
the --new print flag. It also adds early exits on validation failures
so developers can inspect the output directory.

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
Will this leave the user with an empty directory to inspect?

The script intentionally exits early on failure to bypass the temporary
directory cleanup, directing the user to check "$tmpdir/legacy".

However, looking at Validator.create_report() in perf_metric_validation.py,
the Python script only generates output files if the debug flag is provided:

tools/perf/tests/shell/lib/perf_metric_validation.py:Validator.create_repor=
t() {
    ...
    if self.debug:
        allres =3D [{"Workload": self.workloads[i], ... }]
        self.json_dump(allres, self.datafname)
    ...
}

Since -debug is not passed to the Python script in this patch, won't this
result in an empty directory being leaked in /tmp while leaving the
developer with no output data to inspect?

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
This appears to have the same issue as above. The script directs the user t=
o=20
inspect "$tmpdir/new", but without passing -debug to the pythonvalidator, w=
on't
this directory also be empty?

>  	fi
>  done
> +rm -rf "$tmpdir"
>  exit $ret

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716070303.5070=
66-1-irogers@google.com?part=3D14
