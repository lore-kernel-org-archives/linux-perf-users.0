Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E933EAEC
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931053; cv=none; b=ugLd2cK8rp48Zbtaw8yJLwbhIw4gvf90ebgEX2qBku+9izcIYxan27WV6/1OtBubl40VOi4naCdxMOnLuJKKegl+snRxKG0sxnGgvyFO43WhQItRfw5ilmOP4M7crxIFufg7ZYGWWZrl31Az5lOKqmA/ChY9UOUEXRj559spurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931053; c=relaxed/simple;
	bh=ut1r4olpzawjiUkS02eLuqZnpX109voD7h6AlzY9Nb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8+JiHb+hNZK/Z6bjWB3/OyUBtRcgdVK0ZdtV4FOAK8V724ZPgJPcBu+PwdJZWULOZANANt1E4IF10CRctS6jlUN+7XYeFkVgeO90adCtbY5liz4Un+3qSg6waGNxZbe2H12TQ7cfbZdxI5yVA6O4p1reRopKwkYJ2rBLjzir3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2V6WuNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2V6WuNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC81C2BCB8;
	Mon,  4 May 2026 21:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777931052;
	bh=ut1r4olpzawjiUkS02eLuqZnpX109voD7h6AlzY9Nb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d2V6WuNmR1opCcfbyJEEOTG38sXJEht21GPjwt2lDOpJyYRo4ndZ65ETSnvLItPt0
	 AYMyOUEaN8zWt2ZjS3y63TrNTkyFHpOkvBfGPp2LmZBbmJbrppfed2eW2u8mRJekrV
	 Ny3NIKNxH5O1whVCvwDBD7ClA0WPsAEctygv6cevoe5FjO0e0BzWsc9cPrCnh7xPML
	 ZrVo6CCAbEBNJo9SwTAf3uAC/uJ10eO/MOxNleKQpTCefRbAYH5pWsku4sdTWszhhi
	 DMOjCOodUtCiDblOtVJ4sIaW0XWQCvVuVhkPzmM8DfAukKFMIZlsoZCaFfRhxoBF6p
	 jQ2la4j49fLAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/20] KVM: arm64: Reorganize PMU includes
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-3-coltonlewis@google.com>
References: <20260504211813.1804997-3-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 21:44:12 +0000
Message-Id: <20260504214412.BCC81C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] `include/kvm/arm_pmu.h` is no longer self-contained because it reli=
es on `has_vhe()` without including `<asm/virt.h>`.
--

commit 016ed8cf72a663237c0c6836305a2edc3ef74982
Author: Marc Zyngier <maz@kernel.org>

KVM: arm64: Reorganize PMU includes

This commit reorganizes the PMU includes to resolve a circular dependency
between asm/kvm_host.h and asm/arm_pmuv3.h. It removes the inclusion of
kvm_host.h from arm_pmuv3.h and moves the remaining KVM/PMU interfaces into
arm_pmu.h.

[ ... ]

> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 96754b51b4116..e91d15a7a564b 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -9,9 +9,19 @@
> =20
>  #include <linux/perf_event.h>
>  #include <linux/perf/arm_pmuv3.h>
> +#include <linux/perf/arm_pmu.h>
> =20
>  #define KVM_ARMV8_PMU_MAX_COUNTERS	32
> =20
> +#define kvm_pmu_counter_deferred(attr)			\
> +	({						\
> +		!has_vhe() && (attr)->exclude_host;	\
> +	})

This isn't a bug, but by converting kvm_pmu_counter_deferred() from a static
inline function to a macro, do we lose type checking on the attr argument?

Additionally, this macro relies on has_vhe(), but asm/virt.h is not included
in this header. Does this leave the header no longer self-contained, relying
on callers to include asm/virt.h before using this macro?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D2
