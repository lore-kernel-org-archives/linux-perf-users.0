Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA572BD11
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788119795; cv=none; b=DwJKlG6yJJYqLzizDPS7feo+7OEp22wd9QuPfeKysGkMMcacnmhDfVPDjbYRsgMzKiLdsE3VWot9CsNG9VkGNQStDlVFScETF9z/xaODDme+Tf9F+mtizApUfRrNKaUqkssMjkx/Xv5ECQzc5EiYH6+W6a1ROjUYKDy6FCEsg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788119795; c=relaxed/simple;
	bh=luQadXR4zMk61bW5ovV6KOPlEC4+YfyF5Yn7YwvuMmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HbnJmeuSKKJHMrzH8qvJCs615iEL0DOcZztyyCRrUWlCofLHMVF8fu2AokhesojBMvfcQyPLyY5oo5Y33GZAkjEXM+C4BDub+BnYJf5JgM/diP6jd09nUi6QmdtNFb24szC8LxHuJ6NTk5wl9GCnLY1u9Tn4ewHZe5pL+vuvJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEP1miXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEP1miXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAC31F000E9;
	Sun, 30 Aug 2026 19:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788119793;
	bh=YNa5n23GsHHKPnpfq1PVnNN2OSntX74+e39rKOkNcos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cEP1miXYDXaMbkEnRcYLPmgYi6J655rUSl7PwgtEHes+SHU8/+dfgCa6DtmA5HaQI
	 SSd87uTRBb6utRwkpTlCQtHWUe6O9lmuM93X2qY2sJlrdwtSUPthti55KXPyern3wC
	 duJyxEeKjklvVGVLB/Rg4hGEhIZ06fgH4yVD2cQSmDiC1Cfan+cBJNxhyewEWo+1Ug
	 uswLmup5EeYWXy3skVQflMjeYe3rwJo2EccJlmNYhKR1IwyYh+TgeSJrzRW7yFSSzD
	 2AhZV9XqmqptnT8ePstI4k9ZazKKTzVdyNxBNBXcBzyYGgaVTcsjw9vkjhCIH1y7y+
	 gFWJJV9oOSO1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] perf tools: Add test for weight annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260830193459.2840519-5-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
 <20260830193459.2840519-5-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 19:56:33 +0000
Message-Id: <20260830195633.BAAC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The script conflates PEBS support checking with workload executi=
on, masking workload failures as skipped tests.
- [Medium] Silent test failure due to unhandled `grep -q` execution under `=
set -e`.
--

commit 8db1611c3b92cee56576e6157914227faf90fc5a
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add test for weight annotation

This commit adds a shell script test case to check if the --stdio weight
annotation functions correctly in perf annotate.

> diff --git a/tools/perf/tests/shell/annotate_weight.sh b/tools/perf/tests=
/shell/annotate_weight.sh
> new file mode 100755
> index 0000000000000..6b8c105c048b5
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate_weight.sh
[ ... ]
> +trap 'cleanup; exit 1' TERM INT
> +trap cleanup EXIT
> +
> +# mem-loads:pu requests a precise user PEBS event whose sample weight sh=
ould
> +# be populated by -W. Unsupported PEBS/weight PMUs are skipped below.
> +if ! perf record -W -e mem-loads:pu -o "${perfdata}" -- perf test -w thl=
oop \
> +	> /dev/null 2> "${record_log}"; then
> +	echo "[SKIP] precise PEBS weight sampling is unavailable"
> +	exit 2
> +fi

[Severity: Medium]
If the inner workload (perf test -w thloop) crashes or otherwise fails to
execute, does this conditional block improperly catch the failure and repor=
t=20
it as an unsupported hardware feature?=20

It looks like any non-zero exit status from the child process will result=20
in a skipped test, which might mask underlying environment or test suite bu=
gs.

[ ... ]
> +	echo "[SKIP] PEBS weight sampling produced no nonzero weights"
> +	exit 2
> +fi
> +
> +perf annotate --stdio -i "${perfdata}" --symbol "${testsym}" \
> +	> "${annotate_out}" 2> "${record_log}"
> +
> +grep -q 'Percent Weight' "${annotate_out}"

[Severity: Medium]
Since set -e is enabled at the top of the script, will this isolated grep=20
command cause an abrupt and silent exit if the 'Percent Weight' header is=20
missing from the annotation output?=20

If the string is missing, grep will exit with code 1, which might instantly=
=20
abort the script without printing diagnostic output, making regressions har=
der=20
to debug.

> +
> +# The second numeric column is the rendered average weight. This asserti=
on
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830193459.2840=
519-1-ak@linux.intel.com?part=3D4
