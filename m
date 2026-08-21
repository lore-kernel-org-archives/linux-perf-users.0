Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F436B93E
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346119; cv=none; b=q0bO2e5qpjqu+9Mtf1Qg6ostDtScaWgzAqjRzUWM8U+38EBJshRxh+16/p+f4bqEoOEini6cfnXMt6W7em82PUPtrik8QQHjYQRH6Hb+HPKIZfLrbYzcPuVppEKaAp5p6NTvuvh8DN7Q8TP5pa3g5f7ltzjtvYv2zNlJHCSF2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346119; c=relaxed/simple;
	bh=y+lycF8+fdUijlziBaoeKNc5IgcsjJg7IYdVDyaQo/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SlPMPAc+ZJAZ68yH5bT2BSTerSbXO2Bd167H0VyQipa/M7z9eUGmhGnpl8hE0bu/tdrgicmCgJ8gIZ3sP7RQzjZI/y43EAQOLe+bwhERonTpVCVWKx4IaPkFaJ1dJUir5FhTkD5g/uIi35VNeSUqLJrWBiVAbOyezOFPe2Oip3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzzwju4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzzwju4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243F1F000E9;
	Fri, 21 Aug 2026 21:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787346116;
	bh=yZyDXwmFhXPzwAiZOvXiUC7VOQGYwXEvY+TvLgm04qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xzzwju4BVNHcccbQapm9liSyO5vc6BthM+C0Jnm2cwYM8khEZFux9IZjloQlBCcXU
	 SAzjZ+zjhs+Sps1uM12b8WNZ0opJJbbA2PJRDCtxQl0qis9nroPWWnsrVlLQGsIyjW
	 psY/3cgoAF91K55Yq4NFtD0yt2SchfjMfH+xef+pfxXPx5lEeHtnsId11miG5e9ARW
	 4MYv2qbzMfBbZPqWSa34Fm4nx5iopc/Fb1XGtXQy/YKrMCiesbrPlp9RtRGVNdAHVp
	 yj/L7LQT1hB1pJykDMx9eHBI11CHirKZYQRyqrg4MYeIXgIbh6ZgDmhHsNb/Jik4EN
	 LEkO5K3S+IBbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 4/4] perf tests: Add shell test for
 kernel symbol beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821204930.679027-5-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
 <20260821204930.679027-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:01:55 +0000
Message-Id: <20260821210155.E243F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test script erroneously fails on uniprocessor (UP) kernels d=
ue to a missing SMP-only tracepoint.
- [Medium] The test script can hang the test suite indefinitely on quiescen=
t systems due to unbounded system-wide waits.
--

--- Patch [4]: [PATCH perf-tools-next v4 4/4] perf tests: Add shell test fo=
r kernel symbol beautifier ---
commit c9c4a1b0dcd918dc4702b41032200c74d4363a15
Author: Aaron Tomlin <atomlin@atomlin.com>

perf tests: Add shell test for kernel symbol beautifier

This commit adds a dedicated shell test script to verify that perf trace
properly symbolises kernel virtual addresses and function pointers using
both the default kallsyms beautifier and BTF type routing.

> diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf=
/tests/shell/trace_ksym_beautifier.sh
> new file mode 100755
> index 0000000000000..c030b03e2b662
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
> @@ -0,0 +1,43 @@
[ ... ]
> +test_ksym_kallsyms() {
> +  echo "Testing perf trace kernel symbol beautifier (default kallsyms)"
> +  output=3D"$(perf trace -e kmem:kmalloc --max-events=3D1 2>&1)"

[Severity: Medium]
Could this wait indefinitely on a completely quiescent system?

Because it waits system-wide for the kmem:kmalloc event without a timeout or
a deterministic workload to trigger it, it might stall the test suite if the
event takes too long to fire.

> +  if ! echo "$output" | grep -q -E "call_site: [a-zA-Z_][a-zA-Z0-9_]*" |=
| echo "$output" | grep -q -E "call_site: 0x[0-9a-fA-F]+"
> +  then
> +    printf "Default kallsyms function symbolization failed, output:\n%s\=
n" "$output"
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
> +  output=3D"$(perf trace -e csd:csd_function_entry --force-btf --max-eve=
nts=3D1 2>&1)"

[Severity: Medium]
Will this test fail erroneously on uniprocessor (UP) kernels?

The csd:csd_function_entry tracepoint is defined in kernel/smp.c, which is
only available when CONFIG_SMP is enabled. On a UP kernel, perf trace will
fail with an unknown tracepoint error, which the script would parse as a
symbolization failure.

[Severity: Medium]
Additionally, can this cause an indefinite hang on idle SMP systems?

The csd:csd_function_entry event relies on SMP cross-calls (IPIs). On an id=
le
or isolated test VM, this event might not occur organically for extended
periods, potentially causing perf trace to block forever without a timeout =
or
a triggering workload.

> +  if ! echo "$output" | grep -q -E "func: [a-zA-Z_][a-zA-Z0-9_]*" || ech=
o "$output" | grep -q -E "func: 0x[0-9a-fA-F]+"
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821204930.6790=
27-1-atomlin@atomlin.com?part=3D4
