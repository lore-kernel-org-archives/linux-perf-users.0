Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664537B00C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932159; cv=none; b=stZVUVO9LcomBtGYZrBxgEdS/LQvXSbUDuYv98F9z4tJa+eAduWQikHh+aI+Vf8nQEL//PehgiHZdcOX4diWNoAGfNNw1ISOQhjqkUjYBS/eJt1OjoJ/bqpB/pje90tQJnfiXIDx5r1zZSRJD3uzpP0+vsMbl6oEF+Dywi7wDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932159; c=relaxed/simple;
	bh=wWNUmf38aIiwbJlAHEBS7fZIJpH+L3wAG+TEIfMLzxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hsd7RF/HjR76py0lURTPGdvCUtAA4ln5KrpbbJS9UtFbyVlMIZ42X50DxFeetFku2GYYtdAiflJXqc7shHx7+pIS/ZFUUZ1Yyz5cRNIQvcIS4ZHhoHV07q1Yizh8uaD3wtaqi1YVIUrZWufY43RV6TSYKcxWQ6b0u5/EO/ecZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sawHcrRs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sawHcrRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79EBC2BCB8;
	Mon,  4 May 2026 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932159;
	bh=wWNUmf38aIiwbJlAHEBS7fZIJpH+L3wAG+TEIfMLzxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sawHcrRshX/jTjCxLsd8tFdJOnBGTgeCeqEjsyqvb9DtJA1QKiU+aoWsmPocKJ01F
	 Adv+F+hvYQMKHWReg6QIsS/Tn5UKTkazGZofzySt6ETpJxIb2XRXgjuEKsl4/pD9Fa
	 SGjwZEpe4/bDNFRHd9xeMCAGKVCQmw53n7QuJiRtoFBNxurKxJUYe02NY2euCmAV16
	 j4y61wdW1XgkXYGLlsdjUESftHW4tJ77ka4BwGEcM8KeJYsgonsRoiFA74+tnCqq7Q
	 vritPp/ywg7aoqM2FDbp4nTUsYIt7QYVLHHZOUARokGeqtbMb+VmlD84PVg8+gAm7F
	 7ZQTYOkiBNvEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/20] KVM: arm64: Reorganize PMU functions
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-4-coltonlewis@google.com>
References: <20260504211813.1804997-4-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:02:38 +0000
Message-Id: <20260504220238.E79EBC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Redundant macro definition of `kvm_arm_pmu_irq_initialized`.
- [Low] Missing `#include <linux/uaccess.h>` in `arch/arm64/kvm/pmu.c`.
--

commit 9aeaae469d996e1d76ed323e65048d5b72469b0b
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Reorganize PMU functions

A lot of functions in pmu-emul.c aren't specific to the emulated PMU
implementation. Move them to the more appropriate pmu.c file where
shared PMU functions should live.

> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index 6b48a3d16d0d5..ee2f0f7e61bcf 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -8,8 +8,22 @@
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/perf/arm_pmuv3.h>
> =20
> +#include <kvm/arm_pmu.h>
> +
> +#include <asm/kvm_emulate.h>

This isn't a bug, but should linux/uaccess.h be explicitly included here?

The refactoring moved functions like kvm_arm_pmu_v3_set_attr() to this file,
which rely on get_user() and copy_from_user().

> +static LIST_HEAD(arm_pmus);
> +static DEFINE_MUTEX(arm_pmus_lock);
>  static DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);
> =20
> +#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >=3D VGIC_=
NR_SGIS)

Is this macro definition redundant?

It appears that kvm_arm_pmu_irq_initialized() is already defined in
include/kvm/arm_pmu.h, and this file includes kvm/arm_pmu.h just above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D3
