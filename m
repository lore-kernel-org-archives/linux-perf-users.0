Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA033890E4
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306830; cv=none; b=WVvjnMtyb/+XJAa8hwb6i2y2D2v5kLs+icfUSrWC0bKR5mFPZZwUPLIMd3PIoK0hOlhbIbCmHreH2YVuL6pwauwc4AhxtxExZNbEG5Y4R3hwF6ruDOl+5TCWUv35c6Q0w0KUBxy25WzdWsQpf3I0yR8F/DeEW/sx0EVpFteTbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306830; c=relaxed/simple;
	bh=xNVEzi+UrRRTe8vIrjqOIbbtqJobm9+z5yuTNjMDzho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EMtc8eu71T1sGbHr2Q1SRcY6+Fq30cx8pemi/tSqX6sI0kEESLnIwk/ofYtnEmiFYhPxgLKZVMcDZZzfLDsNxaq3aK6BFHK5otDCtbcTsPWJ8bHwVmyuZ6YCjgqxzNBzvmyI3dPYQTi7VJMHpX2IsjQgVpaPOfwkLYW7/lb6NmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzafw8xB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzafw8xB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6731F000E9;
	Mon,  6 Jul 2026 03:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783306825;
	bh=E5/aXxQQ/0uP/C8aewfSCWH4lyadSm6pwvS/2jRIFNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fzafw8xBPqMl9ugc649rEPX8ixZgxP2OcCu8NjLRFftrtUO0sNud1L47sRNE7cxqq
	 YvDxMBrzNbVqwa27blBwaXx59c8nbqn9dWn5giwGeIB0866b1Dy1tEGpz2BdkIbOhT
	 lseDIQ5dCUWSRTrBMSG74JCYCGhPors/DtKcDkQlhx8EEwWwzYFBGWeEo4uluIiujz
	 hY/1umg6D1T3QFHBPUO0vCrZ8yF+rOTuE5YWqGISHRBRYZc++4wmByifhkYWm/6rR1
	 OGHolJlwitj3zz8uceLywsikmGybBW0Yd7nQFozyvNL0l0/S0OjkXJyGEcnCsQza2W
	 ylIG0ML6Kj/jw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 09/10] perf tests: Add x86 eGPRs/SSP registers
 sampling test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706023444.3067660-10-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:00:24 +0000
Message-Id: <20260706030025.4A6731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The validation function `validate_gp_reg_sampling` executes a si=
ngle hardcoded `perf record` pipeline instead of using the standard `perf_r=
ecord_with_retry` helper, leading to test flakiness and untraceable failure=
s.
--

commit 5bc6b87aa83194eef4aff3394561f1bdb19039e4
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tests: Add x86 eGPRs/SSP registers sampling test

Validate that eGPRs (extended general purpose registers) and SSP
(shadow stack pointer) registers can be sampled correctly on x86
platforms with hardware support.

> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index dd90fef2088b1..48c722e563e27 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh

[ ... ]

> @@ -131,6 +131,131 @@ check_system_wide() {
> +validate_gp_reg_sampling() {
> +  local regs_opt=3D"$1"
> +  local regs_value=3D"$2"
> +  local script_field=3D"$3"
> +  local sample_output
> +  shift 3
> +
> +  if ! sample_output=3D$(perf record -o - "${regs_opt}=3D${regs_value}" \
> +    -e br_inst_retired.near_call -c 1000 --per-thread ${testprog} 2> /de=
v/null \
> +    | perf script -F ip,sym,"${script_field}" -i - 2> /dev/null)

[Severity: Medium]
Could this hardcoded perf record pipeline lead to test flakiness on slower
environments?

By not using the standard perf_record_with_retry helper, a single execution
might fail to generate the 1000 near calls required to trigger a hardware
sample.

Additionally, does suppressing stderr with 2> /dev/null permanently hide
error details from the CI pipelines by bypassing the PERF_RECORD_LOGS
collection mechanism?

> +  then
> +    return 1
> +  fi
> +
> +  if ! has_required_regs "${sample_output}" "$@"
> +  then
> +    return 1
> +  fi
> +
> +  return 0
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706023444.3067=
660-1-dapeng1.mi@linux.intel.com?part=3D9
