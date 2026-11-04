Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779188;
	b=tCzncFvnLwiq/RYl2EqcAUd1HjkCHJzgjdviuVq0jydyKP2RCoIIFZosxzKVSZkwjKb7
	 ibRYGlhdf+mqiILcdtL7rrcfXS88iKU771MxVA4hHzH6YCP7HXtRPdQFZtZ//51OJWD75
	 CIrFxjH4cNNbqOn7kHNWp3O6rQkAyYwkWyajnEyZKz9WFKF9dEXCvC6W/xjmXEHI896qB
	 v8KTGomMN+Ht91rsibSDuHTYAz2dfs+XvTAxQC7Q1BjreGgGxrkR92QVPlcsx3uWtsPL0
	 aUaclAirXRZN4m56Qwmx6dna79NL1R2d7SBVpEszSWyeCC5GdnUQiyJq2IJJVH8DF5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779188;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OmTol31Rwh0OaIDaYs1xkFRHA58hhEUUv52bRdbgblo=;
	b=iA2JPWaX3a5kiwu/MAWFAByWYVaCx2WEssH68CZ+WQ99TUs+UcNarffgXk81WIXaCeef
	 gW7F7HctRjlNa19UDmQXbn3WGQUOf9GYQPNeXwewkLTQ9iRVMMzKgqtXkgq6/RTJitgC4
	 deQeXAjMXhMoLE6cSttENhP+M6s1K/5iDmp9MxuUFtIUffV7ohJuFgvWBL9V9EcijldQ5
	 Lb/xNDSnH60qqPjIAk/3iHyP+/Rc7zJ+YbLBXRIMLT5oY/JO6Ji6VYkJWwRV+hwb7UaOB
	 2pUaXMKNMOqkIXCUsIvHBaY8ZXrLWz96iNnQdc6YC9aCdPGIrVx4R8G4tsU+PWztMUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLpw5Mrp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD5606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLpw5Mrp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0DF1F000C1;
	Wed,  4 Nov 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779187;
	bh=OmTol31Rwh0OaIDaYs1xkFRHA58hhEUUv52bRdbgblo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NLpw5MrptMugRuVjD6pN503rmVUukvo7QjhcDWXFAYlA2qSMKpBH7Zp21FsKavF1W
	 PtfENrynMi0sCW4w+FfeWwKWBnB7OIq0+515EmQfL4yMJjuWLQd4KdS2RrrSnanaWJ
	 jCGn6uT0FhLLw8mfGZ4w8YXIinURc+mYLZcQ+9mdlW7x2Gyyi4dcEJw9CPgSSojdMB
	 ZpmtswLaD+iLsOHjvY8aNH1nmHhkRs+IsFskLHStMrvruDxUDjXqqAb7MIjWI5Ncln
	 U+BBGg9jolcKAG8k69N1ABGc5p492XUxCiz5yBFL+dSxKGIqOcylYjNXYZjHus6Dz4
	 lGZcajwzi/Nxg==
Message-ID: <sashiko-outbox-196842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 41/41] perf test: Add perf sysinfo shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-42-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:59:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: sysinfo.sh fails on archs without userspace perf_regs=
 tables
--

commit a34e2e048e81b8c1a56a7440fb4b5a69103fb845
Author: Ian Rogers <irogers@google.com>

perf test: Add perf sysinfo shell test

This commit adds a shell test exercising default perf sysinfo summary
output, --pmus per-PMU output, -j JSON validation, PMU glob filtering,
and -i perf.data inspection.

> diff --git a/tools/perf/tests/shell/sysinfo.sh b/tools/perf/tests/shell/s=
ysinfo.sh
> new file mode 100755
> index 0000000000000..59091b4d750d6
> --- /dev/null
> +++ b/tools/perf/tests/shell/sysinfo.sh
> @@ -0,0 +1,83 @@

[ ... ]

> +test_sysinfo_filter() {
> +  echo "Filtered perf sysinfo output test"
> +  perf sysinfo -o "${sysinfo_output}" software
> +  grep -q "^software (" "${sysinfo_output}"
> +  if grep -q "Modes:.*sampling" "${sysinfo_output}"; then
> +    grep -q "Sample types:.*ip" "${sysinfo_output}"
> +    if grep -q "Sample types:.*regs_user" "${sysinfo_output}"; then
> +      grep -q "User registers:" "${sysinfo_output}"
> +    fi
> +    if grep -q "Sample types:.*regs_intr" "${sysinfo_output}"; then
> +      grep -q "Intr registers:" "${sysinfo_output}"
> +    fi

[Severity: Medium]
Can test_sysinfo_filter() fail under set -e on architectures such as Alpha
and PA-RISC where the kernel enables CONFIG_HAVE_PERF_REGS, but userspace
tools/perf/util/perf_regs.c lacks register mask tables?

During PMU probing in tools/perf/util/pmu.c:probe_sample_types(), the probe
falls back to bit 0 when perf_arch_reg_ip(EM_HOST) returns 0:

	u64 reg_bit =3D BIT_ULL(perf_arch_reg_ip(EM_HOST)) ?: 1ULL;

On Alpha and PA-RISC, kernel perf_reg_validate() accepts bit 0, so
PERF_SAMPLE_REGS_USER and PERF_SAMPLE_REGS_INTR succeed and print_pmu_text()
outputs regs_user and regs_intr in the "Sample types:" line.

However, when tools/perf/util/pmu.c:probe_pmu_regs_one() queries the
register masks:

	u64 gpr_mask =3D intr ? perf_intr_reg_mask(EM_HOST, &dummy_abi) :
			      perf_user_reg_mask(EM_HOST, &dummy_abi);

both perf_intr_reg_mask() and perf_user_reg_mask() in
tools/perf/util/perf_regs.c return 0 for unhandled ELF machines like
EM_ALPHA and EM_PARISC, leaving user_regs_mask and intr_regs_mask as 0.
Then tools/perf/builtin-sysinfo.c:print_probed_regs() returns early without
printing "User registers:" or "Intr registers:":

	if (!mask && !simd_mask && !pred_mask)
		return;

Would this cause the inner grep checks for "User registers:" and
"Intr registers:" in test_sysinfo_filter() to fail and abort the test on
those architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D41
