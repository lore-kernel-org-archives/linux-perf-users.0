Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F243304C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620093; cv=none; b=bcHUvQit3BF+HYnirNS7jgdmZiAxWZyKdWPRkuaFk2fZ0GCDrJ35ihYKS4JZDLSqLRStaVXQbjBhrQmdq9AjJThqOQt45FaNMcrZWCAMjesrLW9Xy23KuXSNobFMQQY+a5x7YEp68xRy5nmmXWV3jbhmwlxyMcEm0JbGc+1DYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620093; c=relaxed/simple;
	bh=MLr9ZNAQ0mfajQ2aKcgy8GZ6AbyOcE67QDrZrlNaMjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=il9Zv/VBRfDCTq9jHYizg3z8Qavj8rSGmbe/7HpWFaFuQEtf5Wo0zeI7hTBP7plJ1zyZHubzWdx7g/j6hWWVqU/Iht0nwDB5zpdsi2v19MNfub61h3b3Nxb7EnhF0EAJl16qrJxLi+LIkCgeoeXJ+n5ROq/UcBeb5fGRRbQ8D5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2qPfoV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2qPfoV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E151F000E9;
	Tue, 21 Jul 2026 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620090;
	bh=NuDRfocpKjV6xJiUpaXw6Kg+IRQEgXFx8XJtVCR/lFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2qPfoV8lAc5L89QvrvSSpOIRKr/bmi0iPjZ+z2d+83Q1rUVlZ5mpb+v85bJ+ufld
	 NQkddXjcapn6N6Kp+yiwJN8DhM9+47csuPdeQvzOEgW6CnUUiNbHgvPGpz/lV0J3Ab
	 ocINYUNv4R9KYbKSzuJCR7KxEggYHve3zmZf5imxYwI4/Pvzuh4fqmKW0he1bECvpO
	 gWfp241xYMxXctIJt/rG+84ge1Q9/qyQ3jkwNyqO4Qi5PuvDDsCReSP0869LSl2amk
	 /eIam3H1prwBfaQnR6ohpJbndg7fpi3cmuqEIz4JreJA38snQ/d803DcaSTtxX8RhA
	 eDcIuEt58RsBg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v10 10/10] perf tests: Add SIMD registers sampling test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721072707.3787848-11-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:48:09 +0000
Message-Id: <20260721074809.E5E151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test validation logic for SIMD register sampling uses a loos=
e grep pattern that can falsely report success if a sampled symbol contains=
 the register class name.
--

--- Patch [10]: [Patch v10 10/10] perf tests: Add SIMD registers sampling t=
est ---
commit 1c34ec145d62a684219e4898c8fe2a820402bef2
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tests: Add SIMD registers sampling test

Validate that SIMD registers (XMM/YMM/ZMM on x86) can be sampled
correctly with hardware support.

> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 3c17f68ceb929..4a8539a65fa86 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh

[ ... ]

> @@ -252,6 +252,136 @@ test_egpr_register_capture() {

[ ... ]

> +validate_simd_sampling_mode() {
> +  local regs_opt=3D"$1"
> +  local simd_classes=3D"$2"
> +  local script_field=3D"$3"
> +  local simd_class
> +  local sample_output
> +
> +  for simd_class in ${simd_classes}
> +  do
> +    if ! sample_output=3D$(perf record -o - "${regs_opt}=3D${simd_class}=
" \
> +      -e br_inst_retired.near_call -c 1000 --per-thread ${testprog} 2> /=
dev/null \
> +      | perf script -F ip,sym,"${script_field}" -i - 2> /dev/null)
> +    then
> +      echo "SIMD register capture test [Failed record ${regs_opt}=3D${si=
md_class}]"
> +      return 1
> +    fi
> +
> +    if ! has_required_regs "${sample_output}" "${simd_class}"

[Severity: Medium]
Will this search pattern mistakenly match symbol names instead of the actual
register dump?

When perf script outputs symbol names alongside the registers, passing the
raw class name without delimiters to has_required_regs might falsely match
C library routines like __memcmp_sse4_1_xmm or __memcpy_avx_unaligned_erms_=
ymm.

Could this check be made more strict, perhaps by including delimiters to
ensure it only matches the register dump data and not the sampled symbol
names?

> +    then
> +      echo "SIMD register capture test [Failed missing ${simd_class} sam=
pling data]"
> +      return 1
> +    fi
> +  done
> +
> +  return 0
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721072707.3787=
848-1-dapeng1.mi@linux.intel.com?part=3D10
