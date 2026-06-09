Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE42ED843
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982709; cv=none; b=FgAzcaW3R6QYvyhY7NfXWxCz19z/hB5bDr7WNpk1oEO0j7B1+XjyGsAjNkJa+MnsHFJhEm1nulc9kEKBbC3IKL+MMmnLLUeLtNGD7Rpp/G20Q+RoKphPwK+6IOD9DETL4Pm2umO0slTEB8HMyTbuyjVkzkPJAwMac0E4dawT63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982709; c=relaxed/simple;
	bh=YavmK0LNVk2mx6hEzTJMIrK7NAmZ9fB6DDaWY/v5rfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVVZP8zYarS3XJ1H1GSTZid/Ydqy1NJE8Oos3cBKFOy9wet0muSRbOXqzdO8xmMTUUhHYfyI7Npx1Y64dmbmHVkOQUOQ4pEpflM5oZg0QUHnDf8P5hVdBfHwzOhYSC48V6+q+5t7fGl8hN8nQpK+XsITbuE5yIWycjnqkS8KkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YozG3puo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YozG3puo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455E11F00893;
	Tue,  9 Jun 2026 05:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780982708;
	bh=N+jtD787DLp2EHJhiKVwCIWO93/1AbuaBbRvyvIbFCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YozG3puopirOukStjqspJaEwONqWHEZEalqUcZDV3HNiLuWNvpQaCIpo8CGdRXY63
	 stZsby0USez+lZ/JQ69saF/7bwbEf1OTBERN//zEQVVPVdfkvSyTL+gOt7gHM1Yt51
	 UuVuQxfw3JsL+PyAA/uvvrWEYeciNLOfKeEyVCIdyZADhYoMYoN3Y1UCFHCIklRIyf
	 JzxJD/sJZQN51NDVGAcXNiY+BvqPbDE+reUEBjzihMezTOEJ2NMk/3Q+6y2QvriKNk
	 /HQ2bBemy9L5iDRdM+qwIUm9WM0iphI14bx+zodxRLrf5fN1qju4mvgMpc7TNqpkWw
	 /5jW84QmFuZBA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 6/9] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609050222.2458129-7-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:25:07 +0000
Message-Id: <20260609052508.455E11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unnecessary error handling logic for memory allocation failure in e=
arly boot (__init) function
--

commit 3dd0c7770a2df131c0ee92d24ad34bc579754b8e
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Validate return value of intel_pmu_init_hybrid()

This commit adds checks for the return value of intel_pmu_init_hybrid()
to prevent accessing the uninitialized x86_pmu.hybrid_pmu[] array on
allocation failure. It also introduces an error path to free the created
task_ctx_cache kmem cache if this failure occurs.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 532a089e16762..57b1a4bd3facf 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -8540,7 +8541,9 @@ __init int intel_pmu_init(void)
>  		 *
>  		 * Initialize the common PerfMon capabilities here.
>  		 */
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret =3D intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;

[ ... ]

> @@ -8886,6 +8901,10 @@ __init int intel_pmu_init(void)
>  	intel_aux_output_init();
> =20
>  	return 0;
> +
> +err:
> +	kmem_cache_destroy(x86_get_pmu(smp_processor_id())->task_ctx_cache);
> +	return ret;
>  }

[Severity: Low]
Is this cleanup logic necessary for an __init function?=20

Memory allocation failures during early boot generally mean the system cann=
ot
boot anyway. Functions executed only at this stage typically do not need to
handle memory allocation failures gracefully, making this kind of error
handling and cleanup logic effectively dead code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609050222.2458=
129-1-dapeng1.mi@linux.intel.com?part=3D6
