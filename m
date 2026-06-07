Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D91F8AC5
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780813109; cv=none; b=n78FOIT1Ar3DE5OFlmBMMPWmbNUhYLALETyPKyiV1X8lHc21utlr0wh3NxtHY07chV2m+PM75mZ2EQ2lsrEkcaFbv2NRJq7yUtoYx6pxJqI3LRQCWQ/yF7T+jUTCV0rfp7qAIs2Q1B1MKZAmWrN6E9hl9kTjP5WbjFs/WqrlzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780813109; c=relaxed/simple;
	bh=wVlGVoydw2yiCnq8LvC+IDeGT7VGNrpEZ5GASuvShzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qv3GYopMRjeAoSB450G6ZViZHumCR64BvPbdqNyu8PF9kLx+NPH78AStd2V/gPewqEX/MWCDidr/wXCoylHUj3vAwUHxrHqCnbxbhxwXILTutG5h+K/uc5DGs/KUE1fp3Mlk8aAEmpMpwS9Y65VuMBwc4eRSXvglTE1xSGGeH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmavk8Ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmavk8Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590F61F00893;
	Sun,  7 Jun 2026 06:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780813107;
	bh=5jlasZzWpS6V0tqxFga8JnluY0DK37sAX03hOqZx/9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jmavk8Zeno5fDIt1kovtddlkJ+tBqoUYR1JNecU89anYA4ygjxiMn6q+eXNTHkAS9
	 z+NX9mrqngVdM18xR8v9rDf6VSxzzSzlX7CQZoE8Ztk7ZW/YwXosbPLbGm6lKFscE9
	 7+YchegzKOFQW/0B86+NlHMRmzJASDwSD0fhqj+ZLo69tZyT1MBx2rAxFAhtOCGBGx
	 yrd6pjp8jCuQGDSXkvZ+EyGhD+h0/6xyBpiEa9OmDPabnCjEbKuRylaXHX1jMcdBL+
	 UeiIvVL+BaurGC/wUZfdsz3Ye4eKnmA3StQV3K0EPNtR5YophhgA7BqBZ198afei59
	 WrIiSxv/icfwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 5/5] perf test: Add inject ASLR test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607060933.3274263-6-irogers@google.com>
References: <20260607060933.3274263-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 06:18:26 +0000
Message-Id: <20260607061827.590F61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The `test_regs_stripping` test contains broken logic that causes=
 it to unconditionally pass, resulting in a false negative.
- [Medium] User space ASLR report tests omit raw hex address filtering, cau=
sing flaky test failures.
- [Medium] The kernel ASLR test is vulnerable to race conditions on high-pe=
rformance systems due to an extremely brief workload, causing flaky test fa=
ilures.
- [Low] Test harness artifacts are overwritten by subsequent tests upon fai=
lure, impeding debugging.
--

commit 130aed1f94b88ff586372e491e562e4121d94067
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

This commit adds a new shell test suite for the perf inject --aslr feature.
It provides coverage for basic user space sample remapping, pipe mode,
callchain remapping, dropped samples leaking physical addresses, and kernel
address remapping tests.

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell=
/inject_aslr.sh
new file mode 100755
index 0000000000000..db54975082599
--- /dev/null
+++ b/tools/perf/tests/shell/inject_aslr.sh

[ ... ]

> +prog=3D"perf test -w noploop"
> +[ "$(uname -m)" =3D "s390x" ] && prog=3D"$prog 3"
> +err=3D0
> +kprog=3D"dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=3D500"

[Severity: Medium]
Will this workload complete too quickly on high-performance systems?

On modern machines, a 500MB transfer might complete in a few milliseconds.
At default sampling frequencies, this extremely short duration could yield
zero kernel samples, causing test_kernel_aslr and test_kernel_report_aslr
to spuriously fail since they assert kernel samples are present.

Is it possible to increase the transfer size or use a different workload
to ensure enough samples are gathered?

[ ... ]

> +test_report_aslr() {
> +  echo "Test perf report consistency"
> +  local data
> +  data=3D$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
> +  local data2
> +  data2=3D$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
> +  local data_clean
> +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +
> +  perf record -e task-clock:u -o "${data}" ${prog}
> +  # Use -b to inject build-ids and force ordered events processing in bo=
th
> +  perf inject -b -i "${data}" -o "${data_clean}"
> +  perf inject -v -b --aslr -i "${data}" -o "${data2}"
> +
> +  local report1=3D"${temp_dir}/report1"
> +  local report2=3D"${temp_dir}/report2"
> +  local report1_clean=3D"${temp_dir}/report1.clean"
> +  local report2_clean=3D"${temp_dir}/report2.clean"
> +  local diff_file=3D"${temp_dir}/diff"

[Severity: Low]
Will these fixed filenames cause debugging issues if multiple tests fail?

Since ${temp_dir} is shared globally across the test script, these paths
evaluate to the same files in test_report_aslr, test_pipe_report_aslr,
and test_pipe_out_report_aslr.

Because the test script accumulates failures with err=3D1 and continues
execution, passing tests will silently overwrite the artifacts of earlier
failing tests.

Should these names include the test function name to preserve artifacts
properly for debugging?

> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || tr=
ue
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || tr=
ue
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || t=
rue

[Severity: Medium]
Does this output comparison need raw hex address filtering to prevent flaky
test failures?

If unresolved symbols are present in user space samples (such as [vdso] or
libc), perf report will output their raw hex addresses. Because the --aslr
injection shifts these addresses, the text output differs, and the diff
will spuriously fail the test.

Other tests like test_kernel_report_aslr use a filter to handle this:
grep -v -E '0x[0-9a-f]{8,}|0000000000000000'

Would it make sense to apply that same filtering here, and similarly
in test_pipe_report_aslr and test_pipe_out_report_aslr?

[ ... ]

> +  local script_dump=3D"${temp_dir}/script_regs_dump"
> +  perf script -D -i "${rdata2}" > "${script_dump}" 2>/dev/null || true
> +  if grep -q "PERF_SAMPLE_REGS_USER" "${script_dump}"; then
> +    echo "User registers stripping test [Failed - register dumps still p=
resent]"
> +    err=3D1
> +  else
> +    echo "User registers stripping test [Success]"
> +  fi
> +}

[Severity: Medium]
Will this grep condition ever evaluate to true?

The test checks for the literal string "PERF_SAMPLE_REGS_USER" in the
perf script -D output. However, the tool formats this flag natively as
"REGS_USER" and prints payloads as "... user regs: mask ...".

Because "PERF_SAMPLE_REGS_USER" is never printed, the grep command will
unconditionally fail. This causes the test to always report success, even
if the --aslr register stripping logic fails.

Could this be updated to match the actual output strings generated by perf?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607060933.3274=
263-1-irogers@google.com?part=3D5
