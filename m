Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523B13C918
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780731076; cv=none; b=Me8nbdkK/jTvcp/SlNMwxWsULRNuhKE9x0D31DdB2mhGmg3BGrPZNWVqMD1vSyhmcyVhkhzSoeqKgU1Y2KM6JUzzbS2hSEAUFKZZYMZXTCEE0CJmUPFCW8y6JzKuIG6HvgdcQuV/gAtnnV7p7491/Fomxc4b5ZoroHcbA5HmZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780731076; c=relaxed/simple;
	bh=/UcgQdliCYHo79MfiQOMSL6iRuoBA6FHYsfMWTWVKe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rF4W6DO0vL0zofNzLx3Zco7Y4hGrIjzw+8S2arkIlxdEZsGWrsgqixl5zP3/tIThnSi8X00EdY7Q3F6MMCx2GhbtDMjd/Exgv3VgpqkWKurNW+eOcicbVaQz0mMZpFAbIE5HxHqwK7dpAy9oULdW/Y31BpAURNP2sRy1AwcQWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIb//+3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIb//+3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D581F00893;
	Sat,  6 Jun 2026 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780731075;
	bh=qxeG5BRhluoUIdRE0duPWlBJE5vAayF6UUEpzXRi/AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIb//+3PDW/d7bUai0FrE8xYB1Q5bqgCtiVVYrn+CNIcdzG07fzWelDWLYaFqPzpq
	 rTzV1Y3iQC01UVDP7AKTAQ3nxbFbQW+vVlT5X4rAGOax9rcNrCXQkeRFlL6vNH5U7O
	 wfohd5AZ6NzfOKZLcDMdTO8fQEoUd2jgIJsr2j7ZZxeqMJ5FCFeYqvwqi0TwHt48LE
	 JGypqtFBHKkZ+l/rsqfPpyynTSIxrnnAt9K1gCUAWZCwrRzrRIipPT5Jq+DUdDAqgc
	 Tanw7CmuiZs9JpCP4yxej8zs/g7GJJy268IDEWjbY6OyuSzoc0BhO5ruNtR2nt6mr/
	 fS7wmY5eIByKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 4/5] perf test: Add inject ASLR test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606072125.2786845-5-irogers@google.com>
References: <20260606072125.2786845-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 07:31:14 +0000
Message-Id: <20260606073115.06D581F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing unresolved symbol address filtering in user-space ASLR t=
ests causes spurious test failures.
--

commit 0ac54fddb12723dd235fe2bd67c473f8ec3fe19a
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

Adds a new shell test to verify ASLR injection, covering basic address
remapping, pipe mode, callchains, and kernel address remapping.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 0000000000000..d8ded16ba9052
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh

[ ... ]

> +test_report_aslr() {
> +  echo "Test perf report consistency"

[ ... ]

> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || tr=
ue
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || tr=
ue

[Severity: Medium]
Does this code need to filter out unresolved symbol addresses?

Because --aslr intentionally shifts mappings, unresolved symbols (which perf
report displays as raw hexadecimal addresses) will differ between the two
reports.

Can this cause the diff to fail and the test to flake if perf record catches
samples in the dynamic loader or other unmapped regions?

I noticed test_kernel_report_aslr() avoids this by filtering out hex addres=
ses
with grep -v -E '0x[0-9a-f]{8,}'.

> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || t=
rue

[ ... ]

> +test_pipe_report_aslr() {
> +  echo "Test pipe mode perf report consistency"

[ ... ]

> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || tr=
ue
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || tr=
ue

[Severity: Medium]
Will this comparison also suffer from the same unresolved symbol flakiness
described in test_report_aslr() above?

> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || t=
rue

[ ... ]

> +test_pipe_out_report_aslr() {
> +  echo "Test pipe output mode perf report consistency"

[ ... ]

> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio > "=
${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || tr=
ue
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || tr=
ue

[Severity: Medium]
Could this filter also fail to strip raw hex addresses for unresolved symbo=
ls
and cause similar test flakes?

> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || t=
rue

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606072125.2786=
845-1-irogers@google.com?part=3D4
