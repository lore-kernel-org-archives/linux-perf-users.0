Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057D3FE679
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294435; cv=none; b=QqG3dqAldhfGR5VPokc2JhUDtd5eeRxUKI/pLpJvwC/2L/IC5Y30SHntgOGrP0Z/zA8HMyGNNd4KBIaEpXAyYbIMYhgfYiEx7eAtdIqMBx5gg/0blaaG40HzEBjH1ZO95rSTRmZ9s0PnR5b0FZlrrRGtIQtVJci1a6BTEH6IGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294435; c=relaxed/simple;
	bh=MWNYmxxq/LoC0f+H1+cYUU8uUU/Dx/s3NWMC2TY+L6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jd9MxXpw7U3K7k73S7T1/SA/0S0sZIH9JyOOVHzLE4JdsF3ySUgcv2CGmFXJxH1MKrPgsD28MNAFfWIemY7AURulBYuo5k/HKeWLuslVCe8mhvlS+FZua0MCLQnHNTQJiU/f5Tfn8fRTuG3IxazH26XbD98vOBVS1RYdxdCzaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNW2RnO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNW2RnO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68001F00A3A;
	Fri, 17 Jul 2026 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294433;
	bh=VH8iTcZ5zL+fwgSuY01aguORGKko0AgkG2IN1Gj+Zgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RNW2RnO3v44U+FY7aFbOIRaUnbZKZBkVuTuHr9aINKCJpHznE1+ThFQ6ROhXbOAHc
	 FwbeD+RYNJ+SDTNdIqAQc4umBkcICfgY6BhdDhaVQbgTEPO3e+6/lnyol6+agCePN6
	 lZYOZgtjxvi1SukiX5u0bpd+KmVu4zGYy1hzCXmdC2L6j4C4rM/nKg8/U1nuMTZnrJ
	 /5mVXs+T/NrsgYHIXcDhsrJhpnAvO68cnPVTiVsE1wc0OiL34uYGWZ7sqOjg7R0VvH
	 ecRuc0Cdgp+2zRSDrvHHeHkpy9QbwSdbW6sjmPLrD3mRYCbuebNdNAVDastPdk+HbH
	 6ALSv/EmSsAIA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/13] mm/kwatch: add anchor thread for global
 watchpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130609.1903443-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130609.1903443-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:20:33 +0000
Message-Id: <20260717132033.A68001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] `kwatch_anchor_start()` overwrites `kwatch_anchor_tsk` without c=
hecking if a thread is already running, permanently leaking the previous ke=
rnel thread.
- [Low] Undefined reference to `kwatch_auto_stop` causing a linker error.
--

--- Patch [10]: [RFC PATCH v2 10/13] mm/kwatch: add anchor thread for globa=
l watchpoints ---
commit a3eb869f890aaa4760c373cf20d5f98126ae7d23
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add anchor thread for global watchpoints

This patch adds a kernel thread that sleeps for a configured duration to
bound the watch window for global variables. When the duration expires,
the thread schedules a work item to tear down the session.

> diff --git a/mm/kwatch/anchor.c b/mm/kwatch/anchor.c
> new file mode 100644
> index 0000000000000..e87eb5e813ff2
> --- /dev/null
> +++ b/mm/kwatch/anchor.c
[ ... ]
> +static void kwatch_auto_stop_handler(struct work_struct *work)
> +{
> +	kwatch_auto_stop();
> +}

[Severity: Low]
Does this cause a linker error? kwatch_auto_stop() is called here, but it
appears to be undefined in the tree, which would result in a build failure
when CONFIG_KWATCH=3Dy is enabled.

[ ... ]
> +int kwatch_anchor_start(u16 duration)
> +{
> +	kwatch_anchor_tsk =3D kthread_run(kwatch_anchor_thread_fn,
> +					(void *)(unsigned long)duration,
> +					"kwatch_anchor");
> +	if (IS_ERR(kwatch_anchor_tsk)) {

[Severity: Medium]
What happens if this function is called while an anchor thread is already
running? The global kwatch_anchor_tsk pointer is unconditionally overwritten
here without verifying if a previous thread is active or stopping it.=20

Since the leaked thread loops waiting for kthread_should_stop() on a lost
task pointer, could this permanently leak the previous thread's task_struct
and stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D10
