Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F353D6CC5
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786914292; cv=none; b=V9nfDGaqU4WsZrrateE4AVIj+KRNYn4PzYKJDLfZ86gDH4pTac5UrYxOOsYlvIZ238L+zcWhbCEAMqEqgWRQ5cGHy88RfHrALr6nBRVo34GWi+eJo8ADYbb997IFKeAZPvKzw4UsRbtRd+dB1Z+dsMjFKzcRQzVFeLSZ7LmmUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786914292; c=relaxed/simple;
	bh=tttAY3E3GeRuy/eChkhhbIyJP4jXdybu/OWBIanpSMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bn2SpMpE10FDMVDPfML6EMec9Y5pUw/QXJC2LAxGrwweAvcCueV9t4gOtlX1SuyM6LSmQaGWOuj3I4GSQO/wV6rTvgjZb/XLVfAACt7Zdt8yYAf9rsI5dpGWMqlnXF1Z14tHaXNOtMyxL0YhfD/eXW4/h0oImUeyHGAhB9pAAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euf4+h+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euf4+h+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6E11F000E9;
	Sun, 16 Aug 2026 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786914289;
	bh=aknqlNOW03i4PkLJxbC/Oe5cWdluzeez/a1VV6z5rIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euf4+h+Ia4sB34By0aa1NMtF8jvBM+CBr8jVl+uyfFBtrIxeC/Rdjl7QDYYQm/vBf
	 nRLB8STEFPCqbOXOJcjaBaa4w/NXY0v20CEKgzCnWx721BnKEQE7JZhqJRlPwb49Fa
	 FIwTGK+gSLiRTgkG7+u8bOq9BQunhptVG2DDOB12kuye5U1a6Mh0GYvGZMhOTWBfmv
	 HOlS0ci0KAbRL71FvbpWi1UK/Rb/xUUq7YV1wK+QLLwIueLAXArj+SeMtyywKqNQ4C
	 RsT6lXuWMCBGP0fFsA6vT4VvW65X5ANlxSgKPQgqkrC6qrbJ9kW/IR6im6Dt8xLS8n
	 FMoWoXnQBSGrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 4/4] perf tests: Add shell test for
 kernel symbol beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260816205921.576365-5-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
 <20260816205921.576365-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 21:04:49 +0000
Message-Id: <20260816210449.5F6E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The regular expression used to verify kernel symbol beautificati=
on incorrectly matches raw hexadecimal addresses, causing the test to false=
ly pass even if symbolization fails.
- [Medium] Temporary file created by `mktemp` is leaked on early exits.
- [Low] Unquoted `$0` in `dirname` command substitution can cause the scrip=
t to fail if the execution path contains spaces.
- [Low] Command output is directly interpolated into a `printf` format stri=
ng, which will mangle output containing `%` or `\` characters.
--

--- Patch [4]: [PATCH perf-tools-next v2 4/4] perf tests: Add shell test fo=
r kernel symbol beautifier ---
commit 3b67c2553760890642357a39f8d2c206545b9020
Author: Aaron Tomlin <atomlin@atomlin.com>

perf tests: Add shell test for kernel symbol beautifier

Add a dedicated shell test script, trace_ksym_beautifier.sh, to verify
that 'perf trace' properly symbolises kernel virtual addresses and
function pointers using both the default kallsyms beautifier (SCA_KSYM)
and BTF type routing i.e., --force-btf.

> diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf=
/tests/shell/trace_ksym_beautifier.sh
> new file mode 100755
> index 0000000000000..2916f78503f71
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
> @@ -0,0 +1,52 @@
> +#!/bin/bash
> +# perf trace kernel symbol beautifier tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=3D0
> +OUTPUT=3D$(mktemp /tmp/perf_trace_test.XXXXX)
> +
> +# shellcheck source=3Dlib/probe.sh
> +. "$(dirname $0)"/lib/probe.sh

[Severity: Low]
Does the unquoted $0 in this dirname substitution cause the script to fail =
if
the execution path contains spaces?

> +skip_if_no_perf_trace || exit 2
> +[ "$(id -u)" =3D 0 ] || exit 2

[Severity: Medium]
Since OUTPUT is created via mktemp before these early exit checks, and the
cleanup trap isn't registered until later, do these exits leak the temporary
file in /tmp?

> +
> +cleanup() {
> +  rm -f ${OUTPUT}
> +}
> +
> +trap cleanup EXIT TERM INT HUP
> +
> +test_ksym_kallsyms() {
> +  echo "Testing perf trace kernel symbol beautifier (default kallsyms)"
> +  perf trace -e kmem:kmalloc --max-events=3D1 > ${OUTPUT} 2>&1
> +  if ! grep -q -E "call_site: [a-zA-Z0-9_]+" ${OUTPUT}

[Severity: Medium]
Does this regular expression inadvertently match raw hexadecimal addresses?
Because the character x and hex digits fall within the [a-zA-Z0-9_]+
character class, it appears this could falsely pass if symbolization fails
and perf trace outputs un-symbolized addresses like 0xffffffff12345678.

> +  then
> +    printf "Default kallsyms function symbolization failed, output:\n$(c=
at ${OUTPUT})\n"

[Severity: Low]
Could directly interpolating the command output into the printf format stri=
ng
cause issues? If the output contains % or \ characters, printf might
interpret them as format specifiers or escape sequences.

> +    err=3D1
> +  fi
> +}
> +
> +test_ksym_btf() {
> +  echo "Testing perf trace kernel symbol beautifier (BTF)"
> +  if [ ! -f /sys/kernel/btf/vmlinux ]; then
> +    echo "Skipping BTF test due to missing vmlinux BTF"
> +    return
> +  fi
> +
> +  perf trace -e kmem:kmalloc --force-btf --max-events=3D1 > ${OUTPUT} 2>=
&1
> +  if ! grep -q -E "call_site: [a-zA-Z0-9_]+" ${OUTPUT}

[Severity: Medium]
Similar to the kallsyms test above, does this regex incorrectly match raw h=
ex
addresses when BTF symbolization fails?

> +  then
> +    printf "BTF function symbolization failed, output:\n$(cat ${OUTPUT})=
\n"

[Severity: Low]
As with the previous printf, does embedding the output directly into the
format string risk mangling the output if it contains format specifiers?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816205921.5763=
65-1-atomlin@atomlin.com?part=3D4
