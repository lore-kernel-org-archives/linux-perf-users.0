Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA23AEF4B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895244; cv=none; b=Cu98bbTMtZcMqYZ1DU8c7OKTLYc4zhQIP6O2dLGy48jb+IOiD5UE4cR69Se8df67TJcRsf3zyPZm7zqO2sdce2aoet011rJVobJQjPxhk39oytogsG7mQKSefNTgJwjjmqfP1TdObOLQAARSnIXvhagJy9MYD9spvewVehz3pKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895244; c=relaxed/simple;
	bh=VMvCuFYuM2RAXh0K++OI9qt7BgLa6PX0gQ58DlDkkj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GzSWXNk2w2COaPjwHXN1d8gnjjJIYd/GLw+m5Si0jQgz/aqvH2re88Ha47ZSIxmw2uUzSEGe60//unR2lc8j0xCDzJt6yFu/m6IHX1O271LLQLJKWn0vc78C6HD5qTv4AiVBkjB7cYKX+mcw2lMWxnG3wLi/jd+zgoMgRS88x9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9QLtX4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9QLtX4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B0EC2BCB8;
	Mon,  4 May 2026 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777895244;
	bh=VMvCuFYuM2RAXh0K++OI9qt7BgLa6PX0gQ58DlDkkj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=m9QLtX4m5ZjkgKFREetn9x5OziypgdORoz9Wmxn9Jea5V7jjUZ0LgnMZzKltBIwfH
	 NpEiGNUlcTi2owVJt++5dCnh3dHjxTzAtKNMwvB4qTKEC24h69gUYs0/QsaGdmhEr4
	 OxjrGczSAJOwJkJAIyJMh4NxEdPKFD5faQIXAREaO9GT926C5rjvISe+EJuRJ+JSfG
	 dIZ1vRNig62qDY/KF9iTmc3UQ8NedzjFU63Or/wf8e75GFbg8oOf8o8qo2i+ijx132
	 KHIPk8xU18rPx0LwSuZMw+zSS7C5J2aG51a0OQ7UTouLfqJYFOBYQd5OIZZ8DDiB9T
	 Do2Mxez/Wlveg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf: arm: pmu: fix reference leak on failed device
 registration
Reply-To: sashiko@lists.linux.dev
To: Vastargazing <vebohr@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <243cb3737b41fae32a09117c17809a210395e69f.1777889235.git.vebohr@gmail.com>
References: <243cb3737b41fae32a09117c17809a210395e69f.1777889235.git.vebohr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 11:47:23 +0000
Message-Id: <20260504114723.D4B0EC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `platform_device_put()` on statically allocated platform d=
evices triggers a kernel WARNING.
--

commit 3c982eab6d069fa3cf3109dda88a31b66ceb0afd
Author: Vastargazing <vebohr@gmail.com>

perf: arm: pmu: fix reference leak on failed device registration

When platform_device_register() fails in arm_acpi_register_pmu_device(),
this commit adds a call to platform_device_put() in the error branch to
prevent a reference leak.

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index e80f76d95e68..c2defbc32ad9 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device =
*pdev, u8 len,
> =20
>  	pdev->resource[0].start =3D irq;
>  	ret =3D platform_device_register(pdev);
> -	if (ret)
> +	if (ret) {
> +		platform_device_put(pdev);

Because the devices passed to this function (spe_dev and trbe_dev) are
statically allocated and do not provide a .dev.release callback, will calli=
ng
platform_device_put() trigger a kernel warning?

When the reference count drops to 0, device_release() is invoked.
Since no release function is defined for these static objects, it triggers
the driver core warning about lacking a release() function, which could pan=
ic
the system if panic_on_warn is configured.

The kernel documentation's advice to use platform_device_put() applies
to dynamically allocated devices, not statically allocated global variables.

>  		acpi_unregister_gsi(gsi);
> +	}
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1777889235.gi=
t.vebohr@gmail.com?part=3D4
