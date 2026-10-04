Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF463F6C3E
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135938; cv=none; b=DvSPkNMzyeUfBMquINMLUsxFmRvuXLepX+YvboszXPFdfLzNIwxt5yZ6m5L7lV+NcHWt09lZFcU1d+ZSdtFWhSzDGMg7o/MnJTQc+/qk3QH8K+AKnG4eGXpdcV3Gi59I2KBTIlNPZ1Wrr7QVcvGiNJukG9QQnZL3O5L1gHyJSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135938; c=relaxed/simple;
	bh=jKfWeJIyYLwX5/YEcsW9NyomMf++2w9b2o6VRHVL+C4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Li/vLkIjrqhHPB9h99u5dadBmJgoN750+cGohnXl12mT7WE0iUtVrHokGhvQzSBjQlRzX/7v8FGqbFw5spyPFwAeCTaOi1gseyxhrslq/GJLj0vY7AQFfsuMrPKlmNgFbUqakmsJVjc+0T5RQLmerg8+ct448EcCQNa/IYmZuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfdVzFoL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfdVzFoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E201F000FF;
	Sun,  4 Oct 2026 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135937;
	bh=al0++oTmPAAZYkmFv9SMRE4yzfiS0X8TbidYBkguTdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfdVzFoLiiV7g+M3iHhcxBlO74Eg29+R9uFLcFE5lq3fiFMLpgA9KX7Df+A4PSoKA
	 iMyWh5qblqsuXsxzV3hPCbP0pGO5+6Pmj8SPPYzjREaziZp0Nk2Q4fFxIlwacefBft
	 w8w+CfMChcWo8lFN2j37iEkD/g6/XOmaw6mMB+a4ZnMlyeTy9AWzOmCPV4hdU4H9u7
	 s9lMd7UdYAKhP62YPOonkjCFpGXsEZuO7ik84KhewUlF/nPyLFL+qBs3Kb2hciA69m
	 0Pt4g16XrfO7YCvq/9IZ6QJBUKGK7V82EJpChW176r5MTTpiECLt0SaaaYiTuv4Zl2
	 Llz716dS7atjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] selftests/perf_events: add AUX kernel API selftest
 script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173458.837842-6-kunwu.chan@gmail.com>
References: <20261004173458.837842-1-kunwu.chan@gmail.com>
 <20261004173458.837842-6-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:45:36 +0000
Message-Id: <20261004174536.E8E201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] selftests/perf_events: masked exit code of usermode binary
- [Medium] selftests/perf_events: missed dmesg errors due to ring buffer wr=
ap
- [Medium] selftests/perf_events: compilation failure due to quoted $CC
- [Medium] selftests/perf_events: hardcoded period breaks intel_pt PMU test=
ing
- [Medium] selftests/perf_events: arbitrary fallback to /usr/src/linux brea=
ks installed testing
- [Low] selftests/perf_events: pass() helper discards subsequent string arg=
uments
--

commit ae8124722ffc34fbe1b637d67fb27766b7c48d04
Author: Kunwu Chan <kunwu.chan@gmail.com>

selftests/perf_events: add AUX kernel API selftest script

Add a shell script that runs the perf_aux_kernel KUnit suite through
debugfs, builds and runs the userspace regression program, and
performs static-analysis checks on the source tree.

> diff --git a/tools/testing/selftests/perf_events/aux_kernel.sh b/tools/te=
sting/selftests/perf_events/aux_kernel.sh
> new file mode 100755
> index 0000000000000..2271f105f55b7
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/aux_kernel.sh
> @@ -0,0 +1,631 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

[ ... ]

> +ROOT=3D"$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null || =
true)"
> +if [[ -z "$ROOT" ]]; then
> +	ROOT=3D"/usr/src/linux"
> +fi
> +
> +# Source-level checks need the kernel tree; installed runs have none.
> +SRC_EVENTS=3D"$ROOT/kernel/events"
> +if [[ -f "$SRC_EVENTS/core.c" ]]; then
> +	HAVE_SRC=3D1
> +else
> +	HAVE_SRC=3D0
> +	ROOT=3D""
> +fi

[Severity: Medium]
Does falling back to /usr/src/linux in the main script logic break the
skipping logic for installed selftests?

If the tests are run installed without a kernel tree, git rev-parse fails a=
nd
ROOT becomes /usr/src/linux. If the system has host kernel headers installed
there, HAVE_SRC evaluates to 1.=20

This causes the script to run static analysis against the mismatched host
kernel, resulting in spurious test failures instead of gracefully skipping.

[ ... ]

> +if [[ -x "$UMODE_BIN" && ( ! -f "$UMODE_SRC" || ! "$UMODE_SRC" -nt "$UMO=
DE_BIN" ) ]]; then
> +	:
> +elif [[ -f "$UMODE_SRC" ]]; then
> +	echo "  Building aux_kernel_usermode with ${CC}..."
> +	if "$CC" -o "$UMODE_BIN" "$UMODE_SRC" -Wall -Wextra -O2; then

[Severity: Medium]
Will this compile command in the main script logic fail if the CC environme=
nt
variable contains spaces?

By double-quoting "$CC", bash is prevented from performing word splitting.=
=20

If CC contains flags or prefixes like "ccache gcc" or "clang --target=3D...=
",
bash attempts to execute a binary literally named with spaces and will fail
with a command not found error.

> +		:
> +	else
> +		echo "  $CC build failed"
> +		UMODE_BIN=3D""
> +	fi
> +else
> +	UMODE_BIN=3D""
> +fi
> +
> +if [[ -n "$UMODE_BIN" && -x "$UMODE_BIN" ]]; then
> +	if "$UMODE_BIN" "$PMU_NAME" 2>&1 | tee "$RESULTS_DIR/usermode.log" | \
> +		grep -c '\[PASS\]' > /dev/null; then

[Severity: Medium]
Does this pipeline evaluate only the exit status of grep, swallowing the te=
st
binary's exit status?

Since the pipeline is evaluated without pipefail in the main script logic,
if the test program emits at least one [PASS] before crashing, grep -c
returns 0 and the if condition is satisfied.=20

Because UMODE_FAIL only counts explicit [FAIL] strings, crashes without
explicit failure logs bypass the error checks.

> +		# Count pass/fail from the output
> +		UMODE_PASS=3D$(grep -c '\[PASS\]' "$RESULTS_DIR/usermode.log" || true)
> +		UMODE_FAIL=3D$(grep -c '\[FAIL\]' "$RESULTS_DIR/usermode.log" || true)
> +		UMODE_SKIP=3D$(grep -c '\[SKIP\]' "$RESULTS_DIR/usermode.log" || true)
> +		pass "Userspace API regression: $UMODE_PASS passed," \
> +			" $UMODE_FAIL failed, $UMODE_SKIP skipped"

[Severity: Low]
Because the pass() helper function only consumes $1, are the second and thi=
rd
string arguments dropped?

When invoked here with a multi-argument string, the pass() helper drops all
arguments after the first. This truncates the test log output, losing the
counts of failed and skipped tests.

[ ... ]

> +		if [[ -n "$PERF_BIN" ]]; then
> +			DMESG_BEFORE=3D$(dmesg 2>/dev/null | wc -l)
> +			if "$PERF_BIN" record -e "$PMU_NAME/period=3D100000/" \
> +				-o "$RESULTS_DIR/perf_hw.data" -- sleep 0.5 2>/dev/null; then

[Severity: Medium]
Could this hardcoded config term break compatibility with instruction traci=
ng
PMUs like intel_pt?

The script's usage advertises support for intel_pt. However, it hardcodes
the /period=3D100000/ config term in the perf record command here in the ma=
in
script logic.=20

Instruction tracing PMUs like Intel PT do not support sampling periods,
causing the perf_event_open syscall to reject the configuration.

> +				pass "Hardware AUX: perf record with $PMU_NAME succeeded"
> +			else
> +				fail "Hardware AUX: perf record with $PMU_NAME failed"
> +			fi
> +
> +			DMESG_AFTER=3D"$RESULTS_DIR/dmesg-hardware.log"
> +			dmesg 2>/dev/null > "$DMESG_AFTER" || true
> +			DMESG_LINES_AFTER=3D$(wc -l < "$DMESG_AFTER")
> +			if [[ "$DMESG_LINES_AFTER" -ge "$DMESG_BEFORE" ]]; then
> +				NEW_DMESG=3D$(tail -n "+$((DMESG_BEFORE + 1))" "$DMESG_AFTER")

[Severity: Medium]
Does this logic fail when the kernel log buffer wraps around and maintains a
constant maximum line count?

dmesg outputs the contents of a circular buffer. If the buffer is full,
DMESG_LINES_AFTER will equal DMESG_BEFORE (or be very close).=20

When DMESG_LINES_AFTER >=3D DMESG_BEFORE, the script uses=20
tail -n "+$((DMESG_BEFORE + 1))". If the line count hasn't increased because
the buffer reached max capacity and wrapped, this command attempts to read =
past
the end of the buffer, yielding zero lines and missing all new kernel messa=
ges.

> +			else
> +				NEW_DMESG=3D$(cat "$DMESG_AFTER")
> +			fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173458.8378=
42-1-kunwu.chan@gmail.com?part=3D5
