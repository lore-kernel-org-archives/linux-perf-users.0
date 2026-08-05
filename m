Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FB47DD57
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944275; cv=none; b=Slzft3Z/ruylU3/VH0NnJh7a/OUGTNEr81VYuET/J6Lp58E7mzFkt9/ZciBuBhUQX+g3JaUpptlUtDdaUE8ifVpt+XZYDKgdkEKMOz8rAmDUaXGm+Nk/9CTolBiVHXrA2OJuHEbAgsIJqu81r4c6+0J0JBg1nmYJupmEpWxm8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944275; c=relaxed/simple;
	bh=x+44tHeIyXyGn3f68dJqtP8hc8SUWyP2MWU78mZp1YU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tf3PcNaXUpwQOWAwxZTwOWNorp+8s2jGxuBPxF63kJavq0FZFj2rjEmmrwtRoK/50jCApawfoFGV4rwrLcVP9bMAMsj1PA6FFvOk8OXgW2SGQa42te14qLkGygoGnKWxXg9G2MXYbt8MbsP47C3BMuYYX3P9TvUZNcMjNyh/9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp5uIUZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp5uIUZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FFE1F000E9;
	Wed,  5 Aug 2026 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785944270;
	bh=jHJsKxcHP2UDw8nnhtEuSG61AKAplavHuDjFSNXbT9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mp5uIUZtO+thU5Smqsxvl9jChZ77oKCCbhrBVunk3XbBYHXGZ7HDFkKaQ7/cpBfaZ
	 eogcWDghczFTS7AoCrZIKCVLsqSdAZhTxDJugP6j0AeuVP4N1G6FO6WP1bB3Pw2+ee
	 vF/ZaM1/bwcQmft6Yo7+j+enRE0Z4zUqEGATLsZe3TEdGcLW1vIoMH4Xp4tc+vvGv9
	 xJRZvEeRvA8QsN2YBx4C3FRL3G3V2ZbiSAapyGEkusgG+U0EaA2e2UecgyXNSvfciG
	 PTD4XsgUR4oCrKhx7f40aXO+A1WmVWFfBeANotYZpalJwIBMJ9jXRB5ZwdFnZCFR15
	 +xOEHepSXSmsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of
 arm_spe_perf_aux_output_begin()
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:37:50 +0000
Message-Id: <20260805153750.86FFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unhandled Interrupt Storm / Unreachable Code due to uninitialized =
perf_output_handle in discard mode

Pre-existing issues:
- [High] Missing Context Synchronization Event (ISB) after writing to SYS_P=
MBLIMITR_EL1
--

--- Patch [2]: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of arm=
_spe_perf_aux_output_begin() ---
commit 61201ea6d6b4e69de62f9788efe1db4fd64b4fd9
Author: James Clark <james.clark@linaro.org>

perf: arm_spe: Factor HW discard mode out of arm_spe_perf_aux_output_begin()

Discard mode doesn't call perf_aux_output_begin() or emit aux records,
and enabling it never fails. We'll add a second discard mode in the
next commit so it will be cleaner if there is a separate begin function
just for discard mode.

> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
[ ... ]
> @@ -609,18 +614,23 @@ static u64 arm_spe_pmu_next_off(struct perf_output_=
handle *handle)
>  	return limit;
>  }
> =20
> +static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
> +				      struct perf_event *event)
> +{
> +	u64 limit;
> +
> +	limit =3D FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
> +	limit |=3D PMBLIMITR_EL1_E;
> +
> +	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but writing to a control-plane
system register like SYS_PMBLIMITR_EL1 requires an immediate isb() to avoid
leaving the CPU pipeline in an architecturally undefined state.

Looking at the caller in arm_spe_pmu_irq_handler(), the isb() is issued aft=
er
this function returns, which means the CPU executes the function return
instructions before the barrier. In arm_spe_pmu_start(), execution proceeds=
 to
even more instructions before an isb() is eventually issued.

Should the isb() be placed immediately after the write_sysreg_s() directly
inside arm_spe_pmu_begin_discard() to guarantee architectural compliance?

[ ... ]
> @@ -884,7 +900,9 @@ static void arm_spe_pmu_start(struct perf_event *even=
t, int flags)
>  	struct perf_output_handle *handle =3D this_cpu_ptr(spe_pmu->handle);
> =20
>  	hwc->state =3D 0;
> -	if (arm_spe_perf_aux_output_begin(handle, event)) {
> +	if (arm_spe_discard_mode(event)) {
> +		arm_spe_pmu_begin_discard(handle, event);
> +	} else if (arm_spe_perf_aux_output_begin(handle, event)) {
>  		arm_spe_pmu_stop(event, 0);
>  		return;
>  	}

[Severity: High]
Because discard mode explicitly bypasses perf_aux_output_begin() here, the
per-CPU perf_output_handle is never initialized with the ring buffer or eve=
nt.

If the PMU hardware asserts an interrupt during this mode, wouldn't
arm_spe_pmu_irq_handler() see an uninitialized (or previously NULLed) handl=
e?

It looks like early checks in the IRQ handler, such as checking if the event
is present or if perf_get_aux(handle) is valid, would evaluate to true and
return IRQ_NONE immediately without clearing the hardware interrupt syndrom=
e.
Could this lead to an unhandled interrupt storm that locks up the CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-james-spe-=
software-discard-v1-0-0ff0e44c4c92@linaro.org?part=3D2
