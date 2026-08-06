Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03C439F90
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011849; cv=none; b=Xihq8U8oomr+SmtI/uJEBjoDY9eGqzILW+gVEjM+yRkFpYTZta3qwIOYXSfg8nIF4UjXN07rIdUFyfRhkeNeOdnwu+Zdoe5sB45zJ53fvI200eo/mkSVNhSU7/EyKsJtN6sFERH6vk/x1Gojcb02YireoaY0wdtihiJP6o/kgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011849; c=relaxed/simple;
	bh=qSd5e3kTcMlUbwxI3GdmixpyQLWJud3HRZ1mJSATfdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nNawqGNUl3nYI1UbxmGQI9xP4LCgtQPXSYftG2jO6YKiD8aZxAj9PGfXH6UtV2sKKwtPmDkuu5xUyq0UajNMXADb1ELjkCw9H//ZXbVHtX+iYhB7tOh6Vi1+MhiCp1S/eCPYINzDA2lTQszlEBAMxkKXOQVQBTmHLssX1qgVNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F56InozU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F56InozU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8941F000E9;
	Thu,  6 Aug 2026 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786011848;
	bh=6S4AxnYjBw7hbWGEoLMswPzqLGsbgIum9lMw5Q3x98E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F56InozUdDLWsrkJImjCpddH9n85+Tp6fyvkvUZB9Rf2lrtksup9DHse0YfT355rM
	 8fxIKE716JKO+eHuO6AXXscatPyM/dTIAiTOKYt2Hn4spMdi+LE6CY2G1CHz884JMe
	 rjNfiphjX8tkL5ivp2xrmzlJz1ytKNfjhuEN9KtoI+8oQnQSjTjOzuj06A8mG3ilRm
	 5eSaX5EIUP6ILa9fDwVAHQjOEkfsOcHjlA0VLJ2u+vKrCbG0hpU0S/iRwUIIKg0LFa
	 De3l/xmWPNT/hpME2m0kkzK/+VkNVMsmAb63+mxYLExwh2HBpEVOv1EBK9vhdJVkOb
	 iLgUjF0SqdWRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf/x86: Add x86_pmu::print_debug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <fc6ff612d26c2f5b0f015d9fac309cc58e913c1f.1786010408.git.sandipan.das@amd.com>
References: <cover.1786010408.git.sandipan.das@amd.com>
 <fc6ff612d26c2f5b0f015d9fac309cc58e913c1f.1786010408.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 10:24:07 +0000
Message-Id: <20260806102408.4A8941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `x86_pmu_print_debug` takes `cpu` as a parameter but a=
lso declares it as a local variable. This results in a compilation error du=
e to the redefinition of the identifier in the same scope.
--

--- Patch [1]: [PATCH 1/3] perf/x86: Add x86_pmu::print_debug ---
commit 020114d6f9bb4628136240e2b9270b949589ab7b
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86: Add x86_pmu::print_debug

This commit splits out the register dumping portion of
perf_event_print_debug() into a new x86_pmu_print_debug() helper. It
adds an optional print_debug method to x86_pmu to allow vendor-specific
PMUs to dump their global state.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index d1af33d96d0a3..901a294d6e6cf 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1557,7 +1557,7 @@ static void x86_pmu_start(struct perf_event *event,=
 int flags)
>  	perf_event_update_userpage(event);
>  }
> =20
> -void perf_event_print_debug(void)
> +void x86_pmu_print_debug(int cpu)
>  {
>  	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>  	unsigned long *cntr_mask, *fixed_cntr_mask;
> @@ -1566,17 +1566,11 @@ void perf_event_print_debug(void)
>  	u64 pebs, debugctl;
>  	int cpu, idx;

[Severity: Low]
Will this cause a compilation error? The x86_pmu_print_debug() function
now takes 'cpu' as a parameter, but the local variable declaration 'int cpu'
was left in place, which redefines the identifier in the same scope.

> =20
> -	guard(irqsave)();
> -
> -	cpu =3D smp_processor_id();
>  	cpuc =3D &per_cpu(cpu_hw_events, cpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786010408.gi=
t.sandipan.das@amd.com?part=3D1
