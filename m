Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303033F9A0C
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867981; cv=none; b=cCBRG8vcfbPgvW25rq+4OOyyiVH8pNRlFxQKf2bW8w1LnfwnuSdDndhO+G8v9J2gsqSyXPHop9dot608HeR9bAIY5rfeM6SM4DCFUwSGB+5TbyeimcJyLGJ6IKW8BeeQXABQjCnLiEF2TVrH2YZovona39navwabK2biuNyhpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867981; c=relaxed/simple;
	bh=gKxLGFk2B80ZgcHW/yIln4wSle3DWg0NG7DmIaYEoMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W4J9E747xPi9DrA5kHVjny9ITyv+VU8njRlZICciycbaKx9RLMc0H5MchfSKlJHdChLvMOVsEEoNS8RE/Gdk86cAbRg6poeNukRr3kqamQkGRv+j9KxMYaIwcLbvB/urKFnOWkfUEFBWf2TX6F6JRIOFQpDWZeyqNzDb9p7FMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMeO4NAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMeO4NAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB06C2BCC7;
	Fri, 15 May 2026 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778867980;
	bh=gKxLGFk2B80ZgcHW/yIln4wSle3DWg0NG7DmIaYEoMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mMeO4NAaTzst9Rda3SH3CImxPsLeOkSXnhZildyoI/XCFmA6ivsLra2LbHZpInWFO
	 0+/OmoinUnWhlUPAZgnKRIl5h8W7mIo3RDy914syEvUmoy9pnK0EvBPtrm9tKrV9zf
	 2vyLsT22O49J7hxvKkb5kNMLzSanoH/ZAoAX+OMOKTz//3BvMuhOnHc/H8V7VFP6bC
	 CzLXRSDVlOt+U/K1THxdD000wlDlxBcQUy/rK8/kCDPsruHrOAVvF9qB4AcYcC1RJP
	 ZLJDJHTQu7xvTV5rZVRvgLsWWVQfmlQ2KugibfE4WZtbBxDuvJYFHaZt/NqfXWofB6
	 JMq9dTgTW+EVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260515172710.428474-1-ctshao@google.com>
References: <20260515172710.428474-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 17:59:40 +0000
Message-Id: <20260515175940.CBB06C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The bounds check for `imc_num` incorrectly limits the maximum IMC =
number based on the number of active sockets, causing valid IMC PMUs to be =
rejected and leaving their cpumasks unadjusted on single-socket systems.
- [High] A divide-by-zero crash can occur when computing `cha_snc` due to a=
n unhandled edge case where the number of discovered CHA PMUs is less than =
the calculated `snc_nodes`.
--

commit c91c5bd96c1936822e95d0f574b8f633d5afb4c1
Author: Chun-Tse Shao <ctshao@google.com>

perf pmu intel: Generalize SNC cpumask adjustment for multiple platforms

Prepare for supporting more Intel platforms with sub-NUMA clustering by
generalizing the GNR specific logic.

> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 7c9d238922a6c..b8fab260c4238 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c

[ ... ]

> @@ -156,11 +166,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->nam=
e);
>  		return 0;
>  	}
> -	if (imc_num >=3D snc_map_len) {
> +	if (imc_num >=3D snc_map_len * perf_cpu_map__nr(pmu->cpus)) {

Will this condition incorrectly limit the maximum IMC number based on the
number of active sockets?

The expression perf_cpu_map__nr(pmu->cpus) represents the number of active
sockets, meaning it will evaluate to 1 on a single-socket system. In an
SNC3 configuration where snc_map_len is 6, this would limit imc_num to
less than 6.

Could this cause single-socket systems to wrongly reject imc_num >=3D 6,
given that the hardware might still expose 12 IMC blocks on that socket?
If so, processing uncore_imc_6 through uncore_imc_11 would trigger the
"Unexpected IMC" warning and skip the necessary cpumask adjustments.

(Note that subsequent patches in the series, such as "perf pmu intel:
Adjust cpumasks for sub-NUMA clusters on Sapphire Rapids and Emerald
Rapids", do not appear to resolve this bounds check).

>  		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes=
);
>  		return 0;
>  	}

[ ... ]

> @@ -300,11 +311,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  				pmu->mem_events =3D perf_mem_events_intel_aux;
>  			else
>  				pmu->mem_events =3D perf_mem_events_intel;
> -		} else if (x86__is_intel_graniterapids()) {
> +		} else if (x86__is_snc_supported()) {
>  			if (strstarts(pmu->name, "uncore_cha_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=3D*/true);
> -			else if (strstarts(pmu->name, "uncore_imc_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=3D*/false);
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=3D*/true);

Is it possible for a divide-by-zero to occur when this generalized
adjustment logic invokes uncore_cha_snc()?

If a system or container restricts access to sysfs and exposes fewer CHA
devices, or if testing under a fake PMU environment, the dynamically
determined num_cha could be less than the calculated snc_nodes.

In uncore_cha_snc(), the code performs:

chas_per_node =3D num_cha / snc_nodes;

And later evaluates:

cha_snc =3D cha_num / chas_per_node;

Could the initial integer division result in chas_per_node =3D 0, causing
an unhandled crash when evaluating cha_snc?

> +			else if (strstarts(pmu->name, "uncore_imc_") &&
> +				 !strstarts(pmu->name, "uncore_imc_free_running"))
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=3D*/false);
>  		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515172710.4284=
74-1-ctshao@google.com?part=3D1
