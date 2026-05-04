Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13722306B3B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777930893; cv=none; b=VGhhqVSU9UeRpfYYBkoic6G5rDAcFB9V7vhHiOiy8SoNWGUBAUe+oZcVqLGsXtomVXBQG7rLwJ0zWRwr3MQc+DHIMgOBdSo91OHhvjWXLYcOaeZXSku7hfzm62JkkBhEn7FPtxT0X/vNIQUq31ahNr0E/zWZFhz0lcJZjryzJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777930893; c=relaxed/simple;
	bh=nXI+4ROeLwRNy1IfV00Odm7gQ4iZzMnl6DzTpZVWkwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UNmMRy8pv7ZzdceA4JrAN5gCH9J9lkfN4k6vtctm6laW/G8OyTxmSNqVjWvX/DJdu39ctbqcIS7wut4kvP0obeaX/l6N5WUkW3rXMMpJ/gr0GNubJcqmJt+FdBqHNekGqOmxKnXhfyuQ7mvBsZQ9+QFjPvleVNYITJbcr+GWszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN7tgHQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN7tgHQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E5FC2BCB8;
	Mon,  4 May 2026 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777930892;
	bh=nXI+4ROeLwRNy1IfV00Odm7gQ4iZzMnl6DzTpZVWkwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cN7tgHQHNB/a5qsXenksf/xjoxxlkyJk5mowCTyarMc7bFeRrzHDw01voWF1SASnq
	 nKdGXbLcst/CLaEMgf4gnNot0ckXtP5e9BLS3xLyzGXDAXFsdC1+U9BxDS4L754duO
	 MxqI+fyFTPv9GHllK+AydRxHxbV9XB39X5CigTRx/8AJNbtVdRD3hf71PTlHaQy+/l
	 A6mw/vLCBcNzYxMupHNlKzfI7FqdQdO9BCQWgkog8B6GL+f5mW1JIwL4DVQH1vi+Ei
	 MD2yYU5ujxiusN8TMJKyiPYMEGScixncMYqf89E/dGvYnR3YXY8Yse68bHZz6r+lBK
	 hSd5fy4smZWzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/20] perf: arm_pmuv3: Generalize counter bitmasks
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-5-coltonlewis@google.com>
References: <20260504211813.1804997-5-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 21:41:31 +0000
Message-Id: <20260504214132.88E5FC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing synchronization for the tools mirrored header `tools/includ=
e/perf/arm_pmuv3.h`.
--

commit 11c1a089e4abf2f887089a60dd977c70575ab494
Author: Colton Lewis <coltonlewis@google.com>

perf: arm_pmuv3: Generalize counter bitmasks

This commit renames the OVSR bitmasks to be more general since they apply
to enable and interrupt registers as well as overflow registers.

> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv=
3.h
> index d698efba28a27..fd2a34b4a64d1 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -224,14 +224,14 @@
>  				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
> =20
>  /*
> - * PMOVSR: counters overflow flag status reg
> + * Counter bitmask layouts for overflow, enable, and interrupts
>   */
> -#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
> -#define ARMV8_PMU_OVSR_C		BIT(31)
> -#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
> -/* Mask for writable bits is both P and C fields */
> -#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C |=
 \
> -					ARMV8_PMU_OVSR_F)
> +#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
> +#define ARMV8_PMU_CNT_MASK_C		BIT(31)
> +#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
> +#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
> +					 ARMV8_PMU_CNT_MASK_C | \
> +					 ARMV8_PMU_CNT_MASK_F)

This isn't a bug, but should tools/include/perf/arm_pmuv3.h also be updated
to reflect these macro renames?

The kernel maintains a mirrored copy of this header which is used by KVM
selftests (tools/testing/selftests/kvm/arm64/vpmu_counter_access.c). Keeping
the tools header synchronized helps avoid future build confusion for test
developers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D4
