Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E69377A8B;
	Fri,  7 Aug 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092042; cv=none; b=HmZAs5KGuOwC1rvXdBNPAuGyDVmkwyZWl4kH84EyCbvbF+aNGB1tuKVUVHr6cawCeDtxOFyh8MXk38g35bGeNe57ANAVKRcBvX7SkEEOOG8dgorHeIEOwPjDQEnPF+RlpbhLO4JF3sSOXrRPhDvAnC1DicHzh3UpP0AOjDdOhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092042; c=relaxed/simple;
	bh=TFWsWmC6S0ELcX/pKjn5KVV0ehnE4DSx2r15Bh1KXGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UfQZ45lxHbl9nhMS7gJFKTjjA2t7Jv25hANNyqm+yMX2okzJx/rsy4Wlyxqcq3CtzA15p+Ya0hprvL6ptGAvpJWqCjg0kQ2ctpHcHB/8Dx8aQ0GkySffIlZcIx3M8N30Cwk6FYOxXLAjQuhLH6xnYH0VMQaUurfOf5T4hjB5ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax5Rv+qR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax5Rv+qR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31611F000E9;
	Fri,  7 Aug 2026 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092040;
	bh=7gjkdY6ykusx8RAwsMX8ncBMDZblhZlor1iCPDT8ans=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ax5Rv+qRCc6w1sDFhZBEc77I0Tfh4AqRvTd6caDl54kxmIO/O3sGhGNIuE70lWI62
	 z/hLb2T99W13BWV4zsyPpVfsq9+xcTwOL07HfjnXWFWA78kjTRFziKnOKV8wH6rVl3
	 e2lODP79QP46Cg3fRTUF5fryVu6fB/S2qCp/eOBvpMUxfheT834SaPryfPVvHswDt9
	 F+doNxAr8eq6tVOdb25Rwcv1N/UlIDWmndbb6TmACjNnKc7FDuhivwyB4sWROXeH+Y
	 jPou6Ra+wE3gQQj+UEaAYaqnnkLt6+8nVw3FdBTHLEswGZFeYEf+cCS0XqiiSfJCnu
	 yjvf+WeNYyyEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/20] RISC-V: perf: Add legacy event encodings via
 sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807-counter_delegation-v9-17-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-17-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:40:38 +0000
Message-Id: <20260807084039.C31611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The macro RVPMU_EVENT_ATTR_RESOLVE performs single-level stringi=
fication, preventing macro expansion of event configuration values.
--

--- Patch [17]: [PATCH v9 17/20] RISC-V: perf: Add legacy event encodings v=
ia sysfs ---
commit b1ff3421691bcc5997cb4d931f9fdffb9eef0d1c
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Add legacy event encodings via sysfs

This commit defines sysfs entries for legacy events to expose event
encoding and counter maps to tools like perf.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index ee0c077859273..5eb49db8bc7c1 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -130,7 +130,20 @@ static struct attribute_group riscv_cdeleg_pmu_forma=
t_group =3D {
>  	.attrs =3D riscv_cdeleg_pmu_formats_attr,
>  };
> =20
> +#define RVPMU_EVENT_ATTR_RESOLVE(m) #m

[Severity: Medium]
Does this single-level stringification handle macro arguments correctly?

If a platform driver defines event mappings and passes standard kernel macr=
os
for the config or mask arguments to RVPMU_EVENT_CMASK_ATTR, this definition
will stringify them verbatim without evaluation.

For example, passing a macro like RISCV_PMU_CYCLE_FIXED_CTR_MASK would emit
the literal string "event=3DRISCV_PMU_CYCLE_FIXED_CTR_MASK" instead of its
numeric value. This breaks the perf tool's ability to parse the event
encoding, rendering the PMU events unusable.

Would it be better to use __stringify() from linux/stringify.h so that both
literal numbers and macros evaluate correctly?

> +#define RVPMU_EVENT_CMASK_ATTR(_name, _var, config, mask) \
> +	PMU_EVENT_ATTR_STRING(_name, rvpmu_event_attr_##_var, \
> +			      "event=3D" RVPMU_EVENT_ATTR_RESOLVE(config) \
> +			      ",counterid_mask=3D" RVPMU_EVENT_ATTR_RESOLVE(mask))
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D17
