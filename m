Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF519C553
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094877; cv=none; b=gB0pBuP8xb9biaFV1I3UcFMJfhm3OkR2zsBLBgBtXTC2KFi/uJ6Ch1Q62FY81blaPU5CuFoBO8w/kYqMl+6lX0E9ft0xYPtn6uRQVfST7TcUMRfpUrqn6rSOZ2drdeHlsQNSwIJNcqeQoFmMUY6WX4+1WM1W6dxATZuuWCviQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094877; c=relaxed/simple;
	bh=4GR9xX9sz+kckq+m1PdMhtNddaH5JgX/0bw6l7ZJji4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JS3bpBi4e4K4xBNY6auPVZVqHFp7KoGtk6YFwmTdrUCp77xPA9LIJqzW3GWeDnR744YmrdBnhAKRa6pzeOc0hWcO/1ljTNlLrOK9/KrEj8y0zJmiru4Gb97yPb6XccsclG6s55+Yskhd6LV5VeeSEH/36BA8CGIw8n+CT5wjv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW+NIKQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW+NIKQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF991F000E9;
	Fri,  7 Aug 2026 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094876;
	bh=WBHmglNVo4X1BF/lpWGEcirOEApo2mk0J9d0nx4BMQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SW+NIKQ3o82Y1HIQ7a6KHoS2Kr0KnJkzlmd4GtwVJk/8RlXeSdEotb1leVWHlZap+
	 7tbYA/2TtDkMk7lRepEEb3XDNePbqwpg0C0HmdTgIV2NnLKVagPHFAmfHNHwIZQw+q
	 /9A7uQWL6ub3uDUmcg4DT4lkkojKsVGlBQE+OKVhazvhto5N0tSTsIeff7PaNSAbP/
	 CZAQS89Zzm3R0Bt6HhfWH6bu5dQ8NhygK+DwBOePcrzgRlxtNaBkC6AfL8cNJJglZD
	 6ZCgFlFKO3BvpX1rlHerFEeWZGZdGNgf5pAUhEe+KYTQciHoU+alMbnaotBDZgebKQ
	 k9CKZfTs3t+rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
References: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:27:54 +0000
Message-Id: <20260807092755.CDF991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing initialization of `new_type` and `priv` fields in `perf_cl=
ear_branch_entry_bitfields()` allows cross-sample metadata leakage and KASL=
R bypass.
--

--- Patch [1]: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack =
field ---
commit 9362aa7ec453c50e757449959540fd185a720850
Author: James Clark <james.clark@linaro.org>

perf: arm_pmuv3: Zero initialize hw_id branch stack field

This patch modifies the allocation of the BRBE branch_stack to use kzalloc
instead of kmalloc. This ensures that the hw_id field, and any future field=
s,
are safely zero-initialized upon allocation to comply with documentation.

> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1361,7 +1361,7 @@ static int branch_records_alloc(struct arm_pmu *arm=
pmu)
>  		struct pmu_hw_events *events_cpu;
> =20
>  		events_cpu =3D per_cpu_ptr(armpmu->hw_events, cpu);
> -		events_cpu->branch_stack =3D kmalloc(size, GFP_KERNEL);
> +		events_cpu->branch_stack =3D kzalloc(size, GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but since we are fixing uninitialized branch
stack fields on allocation, does the per-sample reuse of these entries later
leak previous metadata?

The perf_clear_branch_entry_bitfields() helper zeroes most bitfields, but
misses the new_type and priv fields:

include/linux/perf_event.h:perf_clear_branch_entry_bitfields() {
    br->mispred =3D 0;
    br->predicted =3D 0;
    ...
    br->reserved =3D 0;
    // new_type and priv are not cleared
}

In the ARM BRBE driver, the per-CPU branch_stack buffer entries are reused
and cleared using this helper. If a hardware branch record is source-only,
entry->priv is not explicitly set:

drivers/perf/arm_brbe.c:perf_entry_from_brbe_regset() {
    perf_clear_branch_entry_bitfields(entry);
    ...
    if (!brbe_record_is_source_only(brbinf))
        entry->priv =3D brbinf_get_perf_priv(brbinf);
}

If the previous sample in that slot was a user-space branch, entry->priv
retains PERF_BR_PRIV_USER. When filter_branch_privilege() later checks
entry->priv, could this allow kernel source addresses to be exposed to
unprivileged users and bypass KASLR?

>  		if (!events_cpu->branch_stack)
>  			return -ENOMEM;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-james-brbe=
-init-hw-idx-v1-1-009d1843960a@linaro.org?part=3D1
