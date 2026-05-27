Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B0478E38
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905877; cv=none; b=CSllUNBw6Uv8Eysf4wHyFBhJdmmvu/6aZ57fwoH7PQBX81jAEcyCMJ4rbkHosJrZqFF3lrvcGxYvzs/LqysjHQXU6vnn59HGt1Jdd5WZ+YCClwqg3JlDrNGSkb4W5XPok/+oEPyYsELg+4sy7wCCYJda+zWfCDJMf9cH/NTnU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905877; c=relaxed/simple;
	bh=D2UfcNra0GNucxnHj3eW7+fkp4Q9/+2phAh+6TmbNUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dONVSTDQ6WoUHfg23H4aWwW4EbaDpGVhwZlQxHHxbu+BYIpsodrcyqXKi4Ikj9mnYD5jDeHnh3ZpvC/5sppdLQdDLpsPp/Xl7GA5a/1ZsN6moTto/CKh6HBu1FwigLAftnA9EhH4oYukpRwPwq3QYd3w0OCydw6zM7kyV3/4sNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQkxbmWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQkxbmWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CE01F000E9;
	Wed, 27 May 2026 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905875;
	bh=Z9WqbbyAQt26evl2COb7HpkgCiZs2U9hBDcOwvP6uGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQkxbmWQB7KwxshWUD8Gp7aFW8etk5qzIjax+V6j4ybp2pJuX1An24YHybl5Cc54+
	 6UqwpUMrnpyGCpU57uYzFG5hkf29ubanJxLi+18nZjJbttOfZMh2x4nrUIIDlUKQpy
	 buCVEFWn3ikWqLZN/eDTTSLkRGQI6kJlwnqbeqlHqFMfBhSkCeFzVb1sbPE/WrY5m4
	 snrsDuuftn/KtHvDANnA5smq+B0pzh3We8P5SnR5TWvb7GdyfakIgdeePFKeH6yFLz
	 cpWrbzuufZVuKqngVqDbJGB6cEP6AN0MQt/Hn+Tw2cZNn+1OT9GEkqS0myrWkja/jg
	 YyCbC+DhZ1C4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 4/7] perf/x86/intel/uncore: Defer ADL global PMON
 enable to enable_box()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260527151154.130505-4-zide.chen@intel.com>
References: <20260527151154.130505-4-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 18:17:55 +0000
Message-Id: <20260527181755.B2CE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The global PMON control MSR remains permanently enabled after th=
e first perf event is removed, defeating the patch's intended dynamic power=
-saving goal.
--

commit cfa3cf64f648ad5bd39932da84def0d92dadb8dc
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()

This commit removes adl_uncore_msr_init_box() to stop unconditionally
enabling uncore PMON globally at driver init on Raptor Cove CPUs, which
was increasing power consumption. Instead, it defers programming the
global control register to enable_box() so it is only turned on when a
box is in use.

> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/u=
ncore_snb.c
> index 3dbc6bacbd9de..edddd4f9ab5fc 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
[ ... ]
> @@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
>  	skl_uncore_msr_ops.init_box =3D rkl_uncore_msr_init_box;
>  }
> =20
> -static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
> -{
> -	if (box->pmu->pmu_idx =3D=3D 0)
> -		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> -}
> -
>  static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
>  {
>  	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);

[Severity: Medium]
When the last perf event is removed, will the MSR remain permanently enable=
d?

The perf core framework wraps PMU transactions in perf_pmu_disable() and
perf_pmu_enable(). For example, when removing the last event,
perf_remove_from_context() ends with a call to perf_pmu_enable().

This ultimately invokes uncore_pmu_enable(), which unconditionally calls
the enable_box() callback. Since adl_uncore_msr_enable_box() doesn't
check if there are any active events (like checking box->n_active > 0),
it writes SNB_UNC_GLOBAL_CTL_EN to the MSR.

While this saves power before the first event is created, does it fail to
dynamically power down the hardware after its first use?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527151154.1305=
05-1-zide.chen@intel.com?part=3D4
