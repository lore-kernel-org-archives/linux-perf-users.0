Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80C37E5F6
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294836; cv=none; b=HEY6fG92Iw7XYMq9Ic7kiaoCJTquIHsOzcnoI3Bg4+Qg8EIMzWthXbKWruTL7RJUD0mMK9RXQFm+fpmw8baDICVSGAQsgn/oJyTW+/l3e3K1pQkL/+5eM+yncxR4u8mF+6Wtwbvs5v+hcf2jpP5THwVDJJivp+CNfE6kPFDqKlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294836; c=relaxed/simple;
	bh=HPy9mYWEEzlgVhzftYeAKzpxyh4qr4J7k3f/BCkOFzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TDLaJKNTJYdviRTMZiDihPhw8xHPav9/WeeDEY9aCufmwaCP8RO82RHNqxYlvOz0FHcGMr/DyFXBFmmPOoO91N7zuSndPn8mB49lfiUZwNJLO9dsbjA0LWCTNLHj7AbFUFXVQ4DSaHt3Vmuo+3uwN8EB89L6wuDhHOvvM1+Xan4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4x44PKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4x44PKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2897C1F000E9;
	Fri, 17 Jul 2026 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294835;
	bh=CGYp+tHhJ9PZDxLiO/rFBrrcQzYmCsxlkpL7RTkAKZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P4x44PKBDM0qYQVFjeVnIJXY7FC0DA/DiNdX8QPDpkH55nAMla976AgYakhl8EHBL
	 jV8ss9hfrNjGEe3IDjb37yUOtXTj1tIued6yBcLKphNSG9HnuzJ/D45ZbL6J/05jdT
	 7vTEynOO6xIiaEHIQQBGxNR3DurywJkce/0leq2guvfbBGPkqrvLYbU8vffVERWbns
	 eFjockZTLwMCYrUYmYcckBN0yFhanmju3f/HfxcOUuciUqxh/N081zNQI2x2MEfqoq
	 XsQPdiUMafqFN/BJDADPgsl6bl7DAV18jo1MvS0BURynGda8GPf8R6mVjoDJHqHlqg
	 ulbX+3piTz0gw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/13] mm/kwatch: add debugfs control plane
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130637.1903667-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130637.1903667-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:27:14 +0000
Message-Id: <20260717132715.2897C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Use-After-Free in kwatch context pool due to delayed kretprobe=
 exit handlers
--

--- Patch [11]: [RFC PATCH v2 11/13] mm/kwatch: add debugfs control plane -=
--
commit 7abbeb0e0111172be94e0f025440e5d06358c7a1
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add debugfs control plane
   =20
Wire the pieces together behind a single debugfs file.
Add the Kconfig entry and hook mm/kwatch into the mm build.

> diff --git a/mm/kwatch/core.c b/mm/kwatch/core.c
> new file mode 100644
> index 0000000000000..d8526d5aae5cd
> --- /dev/null
> +++ b/mm/kwatch/core.c
[ ... ]
> @@ -0,0 +1,324 @@
> +static void kwatch_stop_watching(void)
> +{
> +	watching_active =3D false;
> +
> +	kwatch_anchor_stop();
> +	/* after kthread_stop: the dead thread cannot re-mark expiry */
> +	kwatch_anchor_clear_expired();
> +
> +	kwatch_probe_stop();
> +	synchronize_rcu();
> +	kwatch_tsk_ctx_release_wps();
> +	/*
> +	 * Waits for disarm IPIs and unregisters breakpoints: no #DB can
> +	 * reach the ctx pool once this returns.
> +	 */
> +	kwatch_hwbp_free();
> +	kwatch_tsk_ctx_free();

[Severity: Critical]
Is it possible for a sleeping task to access the context pool after it gets
freed here?

If a task enters a watched function that can sleep, it triggers the kretpro=
be
entry handler and goes to sleep. When the user stops watching, this code
unregisters the probe and calls synchronize_rcu(). Since the sleeping task =
is
not in an RCU read-side critical section, synchronize_rcu() can return with=
out
waiting for the task to wake up.

The kwatch_ctx_pool is then freed. When the sleeping task eventually wakes =
up
and returns from the watched function, its kretprobe exit trampoline execut=
es
kwatch_lifecycle_exit(). That exit handler calls kwatch_tsk_ctx_get(), which
dereferences the freed pool, resulting in a use-after-free regression.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D11
