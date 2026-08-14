Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D41DFF0
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671494; cv=none; b=frDi4Q9LQio9MGxz9FXPiwFCw8RdOk8h9lk8/JQGujBfEx6UnYOOCQmyijz+sMiXGpvXCJ56hPhlG742LPu4mEZ3QiNxP1TqfHRZH+6YY/E7c2lDP7mJYyTWe5GXo/Yh0BmxgfW+uWV2PXUl7khOZKa/E8XfRmw+gG67nQ5QnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671494; c=relaxed/simple;
	bh=id1UZpTv8DDucUI6Cm3Jez4r7hiy56+95R/48ikkCXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VYWKQn3QFpcNlJ+/wJ/zq9e8v4DhzpT6Nob0J46r6Oi8dabW++zqD0NTqMyBIuBCb15dDOCxilpsgVUqiJioRh1yRkl1J4bQZv2lKvitTiMk6Oy5AZsFTmlggmOl09fNKEYyXEhXcJh5YfoIt7jBLVUxz4Kxubxcm6bXJY/qIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNGiUql+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNGiUql+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AB01F000E9;
	Fri, 14 Aug 2026 01:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671493;
	bh=/p6Qz18pSU5MSAmOcinmRqoEwUIKiH4rZ57p/YpTTZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNGiUql+MU4nlD3etD6vD3q+r3SCVRxDRWeJR5+0YEVdWevKTTfxY8gxA+Ac4rHKG
	 RJjhhtu82iIZI54yJIx2w8GQgWPLDHGs9OJRIlcECTJfAmNqcR/RhoY4COsAT8LDMO
	 Lxol+eb+LZh9XuQTjWCG+8F64io7J00vJtwnwolFNj2dpq27URQOmd/KEeftKK0Ev1
	 1Zps9NLKKZgpIXJEAIxf/sacOYvcVFji58D1aYgK92TnbsJC8XIhRbPdMG3WqLK7ky
	 00iWyV5tLkz/qa8j8PHuWWZnEYCg6HZ5QU9fZogU2YFF0jfujY48nK3kz6JCZR3Ve6
	 B9iilWjK2ZqeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf tools: Add test for weight annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813211109.240689-5-ak@linux.intel.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
 <20260813211109.240689-5-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:38:12 +0000
Message-Id: <20260814013812.B5AB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The pre-condition check for non-zero weights in `perf report` ou=
tput is not restricted to the target symbol `test_loop`, causing flaky test=
 failures instead of graceful skips on CPUs with fast L1 caches.
- [Medium] The `grep -q 'Percent Weight'` command silently aborts the scrip=
t on failure due to `set -e`, suppressing intended diagnostic output.
--

--- Patch [4]: [PATCH v2 4/4] perf tools: Add test for weight annotation ---
commit 4fef6c496fea22a20514f5de2e321ad5a4c0bb3e
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add test for weight annotation

This commit adds a test case to check if the --stdio weight annotation works
correctly in perf tools.

> diff --git a/tools/perf/tests/shell/annotate_weight.sh b/tools/perf/tests=
/shell/annotate_weight.sh
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate_weight.sh

[ ... ]

> +if ! awk '$1 ~ /^[0-9]/ && ($1 + 0) > 0 { found =3D 1 } END { exit !foun=
d }' \
> +	"${report_out}"; then
> +	echo "[SKIP] PEBS weight sampling produced no nonzero weights"
> +	exit 2
> +fi

[Severity: Medium]
Will this global check cause flaky test failures on CPUs with fast L1 cache=
s?

The awk check validates that any symbol produced non-zero weights. Since the
thloop workload spins on a volatile variable, it heavily hits the L1 cache.
On fast CPUs, these L1 hits might not trigger the PEBS mem-loads event,
meaning test_loop might produce zero samples.

However, thread initialization code can still cause cache misses and produce
samples with non-zero weights, which would pass this check. The script then
runs perf annotate for test_loop, finds zero weight, and fails the test
(exit 1) instead of properly skipping it (exit 2).

Should this condition be restricted to the target symbol test_loop before
proceeding to annotate it?

> +
> +perf annotate --stdio -i "${perfdata}" --symbol "${testsym}" \
> +	> "${annotate_out}" 2> "${record_log}"
> +
> +grep -q 'Percent Weight' "${annotate_out}"

[Severity: Medium]
Because set -e is enabled at the top of the script, will this grep command
silently abort the script if the expected header is missing?

If grep returns an exit code of 1 (e.g., if the symbol had no samples or
annotation failed), the script will immediately exit and run the cleanup tr=
ap,
deleting the temporary files.

This bypasses the subsequent awk check which is explicitly designed to outp=
ut
the diagnostic message "Annotation output contained no nonzero weight" and
print the file for debugging.

Could this be handled in a way that preserves the diagnostic output when it
fails?

> +
> +# The second numeric column is the rendered average weight. This asserti=
on
> +# fails on the original regression because calc_percent() left it at zer=
o.
> +if ! awk '$1 ~ /^[0-9]/ && $2 ~ /^[0-9]/ && ($2 + 0) > 0 { found =3D 1 }=
 END { exit !found }' \
> +	"${annotate_out}"; then
> +	echo "Annotation output contained no nonzero weight"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813211109.2406=
89-1-ak@linux.intel.com?part=3D4
