Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C3409285
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619779; cv=none; b=dmg5SmuiOs2godtRdUOrEtCXpFvvR9VwMAVVIHcogqFCS6PW1Jl8uIKgvd/kCnWHxkA/oGVBkcdImGCTBSKnCz/Kj5X90K1cydvFVmUYUhxkN3lV+hYjmSQkj7D5jkrHkWW6k+Z80kSYcaQ74TkSxvAzNQUN8fACE/IL4o8bBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619779; c=relaxed/simple;
	bh=Cauxtpt2NR9jr40KaF6pO+458Ayyzj1VAmqxyZnTdNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WZxtq/BhvyzQz08wUmnnoE/ajwg8emomiFur0TIkm+pEA8C7ejSYy2Z1JHXJ6+Vj6C7BSSY7TnJhTUzGVCGy/C8X3dd7KUXlY+exCN6CL+T6ppGB+eXxRqi7AKde/AFcpwvCqOEX69g98pnoJsO+dexRWFoSvsUF/t/jAA/2ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+CHuJEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+CHuJEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1D21F000E9;
	Tue, 21 Jul 2026 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784619777;
	bh=RqXiuZ0g3crauqo3yNlPy3pJiMx/uudlnqVE7VFanLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I+CHuJELzpZsxgfWwGOAxOyrZRzHS30yIr/+pzuyF9zyBfGyi3Ed7qVBhOLIDNSmx
	 5rBa7aHqg8pdRJqhTwzsirdJ5BLrjRbVBVs/5GAq8r4jJdyrW51b4WXi2pxxRgg3E6
	 mLWKXY0pfUO2+3703RxJUExgjyR4goLKFWakYeF977CFW7K9Xq0J7Op4YsTKHTiWB9
	 NcajYCCSuoYlVeI/pMp0OQKgiAUWf1V/LK2GdDITntnarhZzIiButcwQwXouTKIeIn
	 PM2xf19UrJWZaBxkDx6I5CzcaJCpsWYSv80yQRj8+Jk5IXoNoMjvSXPOE6LcTaGUHM
	 oWX35t7DGYIbg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v10 09/10] perf tests: Add x86 eGPRs/SSP registers
 sampling test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721072707.3787848-10-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:42:56 +0000
Message-Id: <20260721074257.9E1D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added validation function `validate_gp_reg_sampling` e=
xecutes a single-shot pipeline for `perf record`, bypassing the established=
 `perf_record_with_retry` wrapper. This makes the test susceptible to inter=
mittent failures (flakiness) in CI environments and prevents it from utiliz=
ing the fast-path optimization.
--

--- Patch [9]: [Patch v10 09/10] perf tests: Add x86 eGPRs/SSP registers sa=
mpling test ---
commit a4a8e0ee768722ad01317e4cd04c08a71c39eecf
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tests: Add x86 eGPRs/SSP registers sampling test

Validate that eGPRs (extended general purpose registers) and SSP
(shadow stack pointer) registers can be sampled correctly on x86
platforms with hardware support.

> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 625240809fce3..3c17f68ceb929 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh

[ ... ]

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
Will this single-shot pipeline cause intermittent failures in CI environmen=
ts
under heavy load?

Other tests in this file appear to use the perf_record_with_retry wrapper=20
to mitigate flakiness. That wrapper provides a fast-path optimization and
scales up the recording duration if the system load prevents sufficient
hardware events from being generated immediately.

Since validate_gp_reg_sampling() executes perf record directly without a re=
try
loop, could it fail spuriously if the workload doesn't generate enough even=
ts
in the initial window?

> +  then
> +    return 1
> +  fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721072707.3787=
848-1-dapeng1.mi@linux.intel.com?part=3D9
