Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7843630A4
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761787; cv=none; b=RFyNOZHofZy7je98vCZoDF3FnS40klsuZjtLGfk5Y+xwc/AQjWQ5kpyRlLH0oupuW2iGjDaFDjCS84dIs9aLGcgMCpcNZQdd0uwW72KyW58CaXOFJ5mIIWoMtD2fHDzHWrrt1C1xAEdUzbC1DRRzpO+nHuFugfZMeGF/FU+FAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761787; c=relaxed/simple;
	bh=HIculyOknzgIuzWbwPxL2249FNwaK7W1Vg+iavgRhFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RaMI2qkUOc7exceWNacBqrf9+JLxgX0KFxOZBm0nSFWPck4cGzN1yKTKIMF6Dsm+cO7uNFYaQj8ATRfrNpYIxUUEeVy41SALw5FRMyQBUP/tyFbl3vqqpIox0fb7XekvfjFT2fgVlNbCrdb7VsvLYle3z0AZtM0qEJdqdifdHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmZEhLiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmZEhLiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F75C2BCB3;
	Thu, 14 May 2026 12:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778761786;
	bh=HIculyOknzgIuzWbwPxL2249FNwaK7W1Vg+iavgRhFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EmZEhLiOT0mjjXpYtpa4rQ0W8JycoUYm9WjDUzXpjSHJQztp16PjSuBx9R13x+bvy
	 aQq/YdxTaMqwqHPC3K0S8fNywHcZKkoA2Y/p7EQ1Yv7YPu1a/GCTq6PXmTsXjv+3bu
	 7LATaTPMRdJDpV15ZMbJI5W5g2Y1sm93k712u1Lx58l+W6/moJ/XF/Y27engqNGPcp
	 h5e36yPJk6EaNCuhSUAGdpLmqVTpVKy5ZnDwbESBA9xoNBTunsR47oXY8ptXx13KeR
	 2IzX59brghR0+rH6GtmrIk6WRPpse3GDQIosAQnvNLg6bDDtzq5QHNblfMDYwtNyvz
	 Up24ewXDEdPEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] init/initramfs_test: wait_for_initramfs() before
 running
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia He" <justin.he@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514050455.2954509-2-justin.he@arm.com>
References: <20260514050455.2954509-2-justin.he@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:29:46 +0000
Message-Id: <20260514122946.C5F75C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch uses the per-test `.init` KUnit callback instead of the s=
uite-level `.suite_init` callback.
--

commit 28e6f37006ed9a359c88f36fcc58752b6f3eb78e
Author: Jia He <justin.he@arm.com>

init/initramfs_test: wait_for_initramfs() before running

The commit introduces a wait_for_initramfs() call to ensure the boot-time
async do_populate_rootfs() is complete before the initramfs kunit tests run.
This prevents a race condition where the boot-time unpacker and the test
unpacker corrupt each other's module-static state.

> diff --git a/init/initramfs_test.c b/init/initramfs_test.c
> index 2ce38d9a8fd0f..eb76f63f302e0 100644
> --- a/init/initramfs_test.c
> +++ b/init/initramfs_test.c

[ ... ]

> @@ -510,8 +512,21 @@ static struct kunit_case __refdata initramfs_test_ca=
ses[] =3D {
>  	{},
>  };
> =20
> -static struct kunit_suite initramfs_test_suite =3D {
> +static int __init initramfs_test_init(struct kunit *test)
> +{
> +	/*
> +	 * unpack_to_rootfs() uses module-static state (victim, byte_count,
> +	 * state, ...). The boot-time async do_populate_rootfs() may still be
> +	 * running, so wait for it to finish before we call unpack_to_rootfs()
> +	 * from the test thread, otherwise the two writers race and crash.
> +	 */
> +	wait_for_initramfs();
> +	return 0;
> +}
> +
> +static struct kunit_suite __refdata initramfs_test_suite =3D {
>  	.name =3D "initramfs",
> +	.init =3D initramfs_test_init,

The commit message notes this is added so the async unpack is quiescent
"before the first case runs". Should this be using .suite_init instead of
.init?

The .init callback is invoked by KUnit before every individual test case,
meaning wait_for_initramfs() will be called once for each of the test cases.

While functionally harmless since subsequent calls return instantly,
.suite_init is designed for one-time suite-level initialization and seems to
better match the intent.

>  	.test_cases =3D initramfs_test_cases,
>  };
>  kunit_test_init_section_suites(&initramfs_test_suite);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514050455.2954=
509-1-justin.he@arm.com?part=3D1
