Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189200;
	b=MWey0p1+XaZYh/RLIccgtV+PQ5C9M2K86jj2hyfRuZNO+UgiutM3IP7yIUHAtl+9tJ2g
	 WWB2X/aCKC8xwbwE53B+cUuso83EXi035JHV9cKadm60v2dXaTf4SWJZ5g9HRcFWZrlTL
	 fhHQtI18D5waVkEnnqJ2Bx/5yKXU9JEvcWegy+ijZ30RIh1QZU1wLwWQbX/WmIJW1jhoD
	 2YHESdTJWltJh+iaTEorSNaWh2EKt+woRTz7QKk40YwGT3TQAvB1cqasokxt3v+Xfke4J
	 9o4PC94AybC5mpQ8Vj3D1OH7CmHBlg3JxhXyDGsjnO+b9CM5LBQbhKcCHugiBlG7kaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189200;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CQ0g026N9ZPkaY5Axpduk2TzNRPTugPqZkjevKiFSbw=;
	b=Rh9ofgMS+ozLD0k2OB11lZWMlNh3tFCp077o5hMD216VHyJ9ugHHOmKdsXusxqPG6YW5
	 aelPfQISk6adJO9q3bSeEZl4pBdEO/pvwSVk2RZnxOV0ykyL2YH93opgAFIc1TlkU0ZBW
	 sZ0Hae87o8oYz5l83gs5gZWOkoOk3mRdkuTt7zj6d7B2ir9XyjexRcW6aVneTBH+4Fh8u
	 Fcx4/ltHAmRZ9NnLP7OmzY2yl0FXIm1lP0HQSunBZYX5aw9wtFOcQv1fVbtxSBcenBZW0
	 mf3SBR9WN0drJpU42PsEpRqq9F0pPzibs9mgwa36Iscr23VKid6U9/O+EpnuiR/vGxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHShIpBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52734606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHShIpBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862771F000E1;
	Fri, 20 Nov 2026 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189199;
	bh=CQ0g026N9ZPkaY5Axpduk2TzNRPTugPqZkjevKiFSbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DHShIpBDZfW0CS72OqSDWt6sFiDJKWJ0N2JqyVty1Et6fC29E8xxkfsJFlfiy/X5d
	 maAzlYZFXmXbQmZN+m4K1o5TFb41iHiWl5MG5f8NxhwokQEHb+cCBlUcAquxb0dqsg
	 7JB3PI38V5GecNs4JrrxhG9G37uV09iac+y7FZ2Mm1aMTlh1HEc3rnj9bu0zw0aGxV
	 ZIxzRRsaCFxavmiV5oPUumL4a1YX8koqGgI2vBqo3jUQPf8X1Qt68WBEA19QOM56aA
	 c2voCQfYcdI7viVryKFFpI7hjyAqms8Wa9+rCCcgCD3vaYFrRV1wsZIoO1MB7+01ko
	 CnL8ke8Z3TIQg==
Message-ID: <sashiko-outbox-225474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a0472c58f855a9bd358f7faf8e88e44207c90fc4.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
 <a0472c58f855a9bd358f7faf8e88e44207c90fc4.1795182850.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:39:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf: arm_pmu: build failure on 32-bit ARM without
  CONFIG_CPU_CP15
--

commit 35316b1d7277cb0d1201241837c2de25d95ad9c1
Author: Amir Ayupov <aaupov@fb.com>

perf: arm_pmuv3: Add pmuv3_event_implemented()

This commit adds pmuv3_event_implemented() to arch/arm64/include/asm/arm_pm=
uv3.h
to query whether the local CPU's PMU implements a common event via PMCEID0/=
1,
and moves ARMV8_PMUV3_MAX_COMMON_EVENTS and ARMV8_PMUV3_EXT_COMMON_EVENT_BA=
SE
from include/linux/perf/arm_pmu.h to include/linux/perf/arm_pmuv3.h.

> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 02d2c7f45b527..a90867c9774c7 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -10,6 +10,7 @@
> =20
>  #include <linux/interrupt.h>
>  #include <linux/perf_event.h>
> +#include <linux/perf/arm_pmuv3.h>
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>
>  #include <asm/cputype.h>

[Severity: Medium]
Does unconditionally including linux/perf/arm_pmuv3.h here break 32-bit
ARM builds when CONFIG_CPU_CP15 is disabled (for example on
CONFIG_CPU_V7M) and CONFIG_ARM_PMU is enabled?

linux/perf/arm_pmuv3.h includes asm/arm_pmuv3.h, and on 32-bit ARM the
static inline helpers in arch/arm/include/asm/arm_pmuv3.h expand
read_sysreg(), write_sysreg(), __ACCESS_CP15(), and __ACCESS_CP15_64():

arch/arm/include/asm/arm_pmuv3.h:read_pmevcntrn() {
    ...
#define RETURN_READ_PMEVCNTRN(n) \
	return read_sysreg(PMEVCNTR##n)
static inline unsigned long read_pmevcntrn(int n)
{
	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
	return 0;
}
    ...
}

In arch/arm/include/asm/cp15.h and arch/arm/include/asm/vdso/cp15.h,
those macros are defined only under #ifdef CONFIG_CPU_CP15.  Previously
linux/perf/arm_pmuv3.h was only compiled on 32-bit ARM under
CONFIG_ARM_PMUV3 (which depends on CPU_V7 and thus CPU_CP15), whereas
CONFIG_ARM_PMU depends only on ARM || ARM64, so compiling
drivers/perf/arm_pmu.c without CONFIG_CPU_CP15 fails with undeclared
CP15 macros and helpers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795182850.gi=
t.aaupov@fb.com?part=3D5
