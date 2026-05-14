Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431193F413A
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776243; cv=none; b=AFARTt8wDyke+g8HFiZ/Jn/6aTvnDaTluVAT20+jD9lKpoY8Ch2Bvfc+B3/kWULCLHnOdz6eyM2DDWEKnoSWAopctvEm+/iNgn8IkelvZAjsRdjLDeyyp9akzsFEXFj5vS8mAh4rpDUpu5bGzXkuVJVmkne0OQwWEZT9YlKaGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776243; c=relaxed/simple;
	bh=k4Ppw6krhjJ81WQnwk9yNjViWGGbGMFOnXYbI4Z4Fs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjqPAkCqD/WEGe6nib/zla1U8QXiEKZ1TRrKeVcqbZqy0BsvQG5zR3KgUSFesYtS8/9bH09DvsUk6C7UXJybv3mL1S04DLWPQQRWMLsenGKmc/YKGcfPUsFQp8fR2U2mYcYRlAq2EL1OfAJjU9f9vMCnhwgXYt5EAG2Khf5eu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh3M1vYr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh3M1vYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A2EC2BCB3;
	Thu, 14 May 2026 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776242;
	bh=k4Ppw6krhjJ81WQnwk9yNjViWGGbGMFOnXYbI4Z4Fs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Xh3M1vYrjhQiosfa4/DGkgIVioUM+AlEHeTcdjC1IKuCAVTlY7nh+lHrcFglDXApw
	 UexV0jPRNF9FHlv+mVJTvXCP0hrPsu+vch2Ju51ES/hHAp0QnqqB25CPjiUcklqJ7N
	 RkNtF26WZYhzek4k92li90hlNYqiJYqnnCGjjBlMXjnECMugZruSq7w5F+XQkeFckY
	 zucs8eZTAvVp18AGvspoejO6E9xTEh5dA5pV81G5KRp4D7aByGKV/fVOdFxAGn76rf
	 EN0D3uxjo7rhXkopuQwJJ/R98pfoZ3DM0xReAspRH26EjI+44JCOfjwdIHWugT6T50
	 UWyQ31OEM3jFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] kunit: platform: catch duplicate (name, id) in
 kunit_platform_device_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia He" <justin.he@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514050455.2954509-5-justin.he@arm.com>
References: <20260514050455.2954509-5-justin.he@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 16:30:42 +0000
Message-Id: <20260514163042.D4A2EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Asymmetric error handling in `kunit_platform_device_add()` creates=
 a double-free or memory leak trap for unmanaged devices.
- [Medium] The duplicate device check falsely rejects explicit device IDs t=
hat happen to match the internal ID of an auto-allocated device.
--

commit eaa71e70d7a40c957322770b8d98b24b4def8073
Author: Jia He <justin.he@arm.com>
kunit: platform: catch duplicate (name, id) in kunit_platform_device_add()

This commit adds an early check in kunit_platform_device_add() to detect
duplicate platform devices before they trigger a sysfs warning stack trace.
It walks the platform bus to find matching names and IDs and returns
-EEXIST if a collision is found.

> diff --git a/lib/kunit/platform.c b/lib/kunit/platform.c
> index 0b518de26065d..515f7c859014a 100644
> --- a/lib/kunit/platform.c
> +++ b/lib/kunit/platform.c

[ ... ]

> @@ -80,6 +81,20 @@ kunit_platform_device_alloc_match(struct kunit *test,
> =20
>  KUNIT_DEFINE_ACTION_WRAPPER(platform_device_unregister_wrapper,
>  			    platform_device_unregister, struct platform_device *);
> +
> +struct kunit_pdev_dup_match {
> +	const char *name;
> +	int id;
> +};
> +
> +static int kunit_pdev_dup_match_fn(struct device *dev, void *data)
> +{
> +	struct kunit_pdev_dup_match *m =3D data;
> +	struct platform_device *p =3D to_platform_device(dev);
> +
> +	return p->id =3D=3D m->id && p->name && !strcmp(p->name, m->name);
> +}
> +

Could this match function falsely reject explicit device IDs that happen to
match the internal ID of an auto-allocated device?

When platform_device_add() registers a device with PLATFORM_DEVID_AUTO, it
allocates an ID and sets pdev->id_auto to true, appending an ".auto" suffix
to its sysfs name.

If a KUnit test registers an explicit device that happens to share a name
and ID with an existing auto-allocated device, this match function will flag
a collision and return -EEXIST, even though their sysfs names are distinct
and platform_device_add() would have succeeded.

>  /**
>   * kunit_platform_device_add() - Register a KUnit test managed platform =
device
>   * @test: test context
> @@ -95,6 +110,22 @@ int kunit_platform_device_add(struct kunit *test, str=
uct platform_device *pdev)
>  	struct kunit_resource *res;
>  	int ret;
> =20
> +	/*
> +	 * Detect duplicate (name, id) registrations early, before
> +	 * platform_device_add() reaches sysfs_create_dir_ns() and
> +	 * unconditionally dumps a stack trace via sysfs_warn_dup(). This keeps
> +	 * tests that intentionally exercise the duplicate-add failure path
> +	 * (e.g. kunit_platform_device_add_twice_fails_test) quiet without
> +	 * losing the negative return value they assert on.
> +	 */
> +	if (pdev->name && pdev->id !=3D PLATFORM_DEVID_AUTO) {
> +		struct kunit_pdev_dup_match m =3D { pdev->name, pdev->id };
> +
> +		if (bus_for_each_dev(&platform_bus_type, NULL, &m,
> +				     kunit_pdev_dup_match_fn))
> +			return -EEXIST;
> +	}
> +

Does this new error path create an ambiguous state for unmanaged devices on
failure?

If kunit_platform_device_add() is called with an unmanaged device and
succeeds here, but later fails during kunit_add_action_or_reset(), the
action wrapper is automatically executed to unregister and free the device.

However, if it fails early in this new duplicate check, the device is not
freed. The caller has no way to distinguish which step failed, meaning
unconditionally calling platform_device_put() on error causes a double-free
if it failed later, while not calling it leaks the platform device if it
failed early.

>  	ret =3D platform_device_add(pdev);
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514050455.2954=
509-1-justin.he@arm.com?part=3D4
