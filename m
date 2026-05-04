Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E932E141
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931378; cv=none; b=LHrK5CvlECnczu6B30051D/5sO4j1Nyx2SMbg90/RBSeD/He3SJlD34AEqXw+NjJpFfmXNYUj6CPBnn37yP1eBRXVpV1QbQFHlTjS9MP77jeT0O7l24+AEQaWvA0YL4hN7G221apiHr6J5Jahtaj/0TQDk4kgSiNAvR8a3gcf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931378; c=relaxed/simple;
	bh=VBfuVFb2qt9Qps8pmdgQV1OCuKEjAWbdZcGySRLb+8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g1KsUrEdK3plK2Xg2dSXHVOEvdXvqX00p3xFxw1+GxlI1GLpDjZB0w0eUWlHzs9NIPHbcGxnmX8GU2yLuoUbvHL7T/nnIBdd3MfjhB0OJVBXPSpczp5ZKiJalBLd1EioALie0hPkuT3mpdnDg+fKUf0jkFWZjkE69PKmUe1p2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8otVC7r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8otVC7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF1AC2BCB8;
	Mon,  4 May 2026 21:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777931378;
	bh=VBfuVFb2qt9Qps8pmdgQV1OCuKEjAWbdZcGySRLb+8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O8otVC7rDO2fELTYhY/Eq7KJDAq3U5ttJcFuE+x0+6tkk1kYzoCc4rpupM//HpD8V
	 wTZMNDRp7AnqewSGLM2fHkNFvVOY6KYcshTE359jfxM9wgqehESySp6kkPrCP02NnV
	 DPz1PBc4Gl4wwSk/2UfDnFm+/ejtvkgj+PucTnDWwehPbWimySvJg2UpyUgpq4Oxm3
	 Wu09M1NpdyTgsoCOl19kCEXE3ZYeKj4KxRZkmkceaYcNAhnIHgjJ8cRa8tP25pTMDg
	 HooiXhobaBTN0F/UiF4x4LVJlDphAYO2nT589/tpyHmQiCqTeD+mFJF/zXueIK+sRC
	 E8Dur906uCQaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/20] perf: arm_pmuv3: Check cntr_mask before using
 pmccntr
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-6-coltonlewis@google.com>
References: <20260504211813.1804997-6-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 21:49:35 +0000
Message-Id: <20260504214938.3EF1AC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Bypassing the fallback safety check for 64-bit user-access event=
s when pmccntr is partitioned causes counter corruption.
--

commit 1df2bf6962076bf4d1bac00a5756584e40f646ca
Author: Colton Lewis <coltonlewis@google.com>

perf: arm_pmuv3: Check cntr_mask before using pmccntr

This commit adds a check for cntr_mask before using pmccntr to ensure it is
available. This is intended to handle partitioned PMUs where pmccntr might
be used by the guest and absent from the mask.

> Check cntr_mask before using pmccntr to ensure it's available. With a
> partitioned PMU, there may be instances where pmccntr is being used by
> the guest and will ba absent from cntr_mask.

This isn't a bug, but there's a typo (ba) in the commit message.

> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 1cceb1f614515..7ff3139dda893 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -993,6 +993,9 @@ static bool armv8pmu_can_use_pmccntr(struct pmu_hw_ev=
ents *cpuc,
>  	if (evtype !=3D ARMV8_PMUV3_PERFCTR_CPU_CYCLES)
>  		return false;
> =20
> +	if (!test_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask))
> +		return false;
> +

Does moving this check into armv8pmu_can_use_pmccntr() introduce a regressi=
on
that bypasses the 64-bit user-access fallback safety check in
armv8pmu_get_event_idx()?

If pmccntr is reserved for the guest and removed from cntr_mask,
armv8pmu_can_use_pmccntr() will return false. Would this skip the -EAGAIN
safeguard for 64-bit user-access cycle events?

drivers/perf/arm_pmuv3.c:armv8pmu_get_event_idx() {
    ...
	if (armv8pmu_can_use_pmccntr(cpuc, event)) {
		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
			return ARMV8_PMU_CYCLE_IDX;
		else if (armv8pmu_event_is_64bit(event) &&
			   armv8pmu_event_want_user_access(event) &&
			   !armv8pmu_has_long_event(cpu_pmu))
				return -EAGAIN;
	}
    ...
	if (armv8pmu_event_is_chained(event))
		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
	else
		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
}

If armv8pmu_can_use_pmccntr() returns false, the logic will fall through to
armv8pmu_get_single_idx() and allocate a 32-bit general-purpose counter for
the 64-bit user-access event.

Because the event maintains the ARMPMU_EVT_64BIT flag, will
armpmu_event_update() incorrectly calculate deltas using a 64-bit mask? If
the 32-bit hardware counter overflows, could this regression lead to massive
erroneous jumps in the counter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D5
