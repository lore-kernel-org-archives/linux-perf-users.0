Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2893F411A
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717893; cv=none; b=itcHtRr5FaxYHHgpuEempCjbLGPaORFJKLF9CnkMzmgQb9doNQ4Q0GVO6jr9w6km8O8f/DSLB9Y/DHggVGvqj1rO6agn6dTgV3SQkcyWCnYjENqHN/BbkE8bckUlDHjNgZsSb1zXoxAvng19XNZ8Yq1y4bNUWLWSM7miOg7/4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717893; c=relaxed/simple;
	bh=r7IxpwU6+D+JS4W+YP9t68imq6yVq6aTQ+WB0oDzMy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CNPHzZTu+Lp8H9PM9pfSFCR16Z45TL1WaFfUWqzXMnzZsgxzPkB7XksXOZ0CZMlNtgC4QpjjL51PuN99aNCj9HxOTRBz29vSfurJOkJO8G5wLGdNEJcEw3lHgg1+iAoWiQ8xHVbNrfvZcPGlTr03OtpYkOKRIDjBYwvbilpSu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSdp1l0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSdp1l0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684A6C19425;
	Thu, 14 May 2026 00:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717892;
	bh=r7IxpwU6+D+JS4W+YP9t68imq6yVq6aTQ+WB0oDzMy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uSdp1l0bMNk8LMgV4GMYFvzbCnkcj9NeEhd4oMEfodyCNfDll6mRjVfAi1bo13QlQ
	 AyhIQAX1wEnH8hS1g1fryGSOZXIKkqHrI2gXVuPKnZnKOPV0T6RSMLYkQ9JNTkR2/H
	 51srjmix4ypCsgnlRNLNwtRVZrZxyUAg6+uervapZo26QTSXnoMoRupkKpx4CblFMQ
	 x5UwpzapJ6mz9gWbG4VZM7gKr7jFXqwPAUWqRwqoJvRHyNQlB/jPu/eW2bQeh3lJmi
	 w2Gu1guR2XtT4xDLDB8Y5ZpqxOJGfzRjDWmQNDybVofNGFXfOMpJ+WJXuX2+tcF3qK
	 /Q8+h791BIBFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/28] perf test: Add truncated perf.data robustness
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-29-acme@kernel.org>
References: <20260510033424.255812-29-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:18:11 +0000
Message-Id: <20260514001812.684A6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete crash signal detection excludes SIGILL and SIGTRAP.
- [Medium] Trap handler for INT and TERM signals fails to exit the script, =
causing false test passes on interruption.
--

commit 4510c7f2cdccee6cf7adf69880ade45a0432607e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add truncated perf.data robustness test

This commit adds a shell test to verify that perf report handles
truncated perf.data files gracefully. It records a workload, truncates
the file at various offsets, and checks the exit code to ensure no
crashes occur.

> diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests=
/shell/data_validation.sh
> new file mode 100755
> index 0000000000000..649f71b6cdb93
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_validation.sh
> @@ -0,0 +1,59 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Test that perf report handles truncated perf.data gracefully
> +# (no crash, no segfault =E2=80=94 clean error exit).
> +#
> +# Exercises the bounds checking and minimum-size validation added
> +# by the perf-data-validation hardening series.
> +
> +err=3D0
> +
> +cleanup() {
> +	rm -f "${perfdata}" "${truncated}"
> +	trap - EXIT TERM INT
> +}
> +trap cleanup EXIT TERM INT

What happens if this script is interrupted by a TERM or INT signal?=20

The cleanup function removes the temporary files and unsets the traps,
but it does not explicitly exit. In bash, if a trap handler does not=20
terminate the script, execution resumes from the instruction immediately
following the interruption.=20

Would the script continue running the truncation loop without the
temporary files, encounter standard file-not-found errors instead of
crashes, and eventually reach the end to exit with err=3D0, falsely
reporting that the test passed?

[ ... ]

> +	# perf report should exit with an error, not crash.
> +	# Suppress stdout/stderr =E2=80=94 we only care about the exit code.
> +	perf report -i "${truncated}" --stdio > /dev/null 2>&1
> +	exit_code=3D$?
> +
> +	# 139 =3D SIGSEGV, 134 =3D SIGABRT, 136 =3D SIGFPE
> +	if [ ${exit_code} -ge 134 ] && [ ${exit_code} -le 159 ]; then

Does this lower bound of 134 accidentally exclude other severe crash signal=
s?

An uncaught signal in bash results in an exit code of 128 + signal_number.
By starting at 134 for SIGABRT, this excludes SIGILL (signal 4, exit code 1=
32)
and SIGTRAP (signal 5, exit code 133).=20

If parsing malformed data causes a jump to a bad pointer resulting in
an illegal instruction, could the script misinterpret the 132 exit code
as a graceful error and falsely pass the test?

> +		echo "FAIL: perf report crashed (signal $((exit_code - 128))) on ${cut=
_at}-byte truncated file"
> +		err=3D1
> +	fi
> +done
> +
> +cleanup
> +exit ${err}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D28
