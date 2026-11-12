Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487197;
	b=EAp2nKqd3qFl/rvJpWR52csq6LglAWdGapgrbXwJr/hb0r3MTqgGot5LR6vNNIKBe9hv
	 i02Nq8D/vUq/LpzkLTvrgdt7oX5wuLa+h19RXDrExmZI+JBb3jux3BVQ5/xvYrqFJhVQ8
	 v7vFmm/dh3wjARumNpoMwCL4Kl+ZN9w/g9AEgrfajLPnsqvBCdbBRKUxzmNEzM9vdypAz
	 icPKcH3FlhNsvR3KkgXmojHWkcHtNCi442yJNVZBREirF9Zqj0V31uVY0WsXdqDODR8ap
	 Kta/8zwh2t0/4NcaGBmD7fnEt+7gHHA5S1XOCzbtTJFI5l8WbeXKidkHWFBauXEke2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DV+LKS48YmEZSroiXZsTTTYLS3+NDQcdvpq4ImXfbSA=;
	b=0aLTaPGiyrkpR7b7xASYTp5OZlRsgZlbRkzqTpf4crWT8s1FdVKORMWJ5V3cpw6fJicm
	 qRnEbZBT7KC45l/jvJaZzUsudO+/wri3Dh0pq2AIHA7YN1tieRN6CP64p/xkASR7u/vYS
	 6OmT+9hNNAjOnQ/3wXJbrSo7oFrGjEbbZw9n8iy8zR1rm4BN8/wCQPbCVnPh2OgXy+dPn
	 y8utRA9+AOCXK9b+3eQpt94s8MhAm8gesBC4ubN84EHup9Cb6XO6O0Sz6s3J8oUlTceUW
	 fCxKgPl0wn01BjRdxPKGyiEF6CbSRlP3ggIb8xWSwUUlrPeox2f/jHs1tR/lbTXwGHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3uSGKIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F06606A331;
	Thu, 12 Nov 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3uSGKIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C438F1F00A05;
	Thu, 12 Nov 2026 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794487197;
	bh=DV+LKS48YmEZSroiXZsTTTYLS3+NDQcdvpq4ImXfbSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3uSGKIc2ZnJXqjiw9aR+lB0kx+D7mXHS02uAwD/zZCiEZOR4AqVWguhdeNKMd7cm
	 wo9UjEES+eOOdrIw/foxVN+3hWMohyfW2/o0Sb0eKfONd4Abg8bvhBNLKEiRM9avVW
	 jd4yK1XEDHQ8wOA1gWQOhv7wLWD9Tqms0dmI/nNL/hykgEth56KVtsZnLsiDzAL/qI
	 ipe88DbmWDM8I171ReNNLHBetk6K/4U5djSX2ApvD0rEwKJaQCFss5eWGIEO4Z8pMe
	 yhaZkhkXMZB0PEFX6oWo9+Vu4heSqALVtZ01fhVgL747zYJODGf912egqXyFVjiBdA
	 lRSZKjiPjuQwg==
Message-ID: <sashiko-outbox-211101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] MIPS: CM: Make cm_core_lock raw spinlocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112-i6500-cm3-pmu-v2-1-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-1-cd2569571819@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 12:39:56 +0000
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
- [High] mips: cm: invalid wait context in mips_cpc_lock_other() under
  cm_core_lock
--

commit 4e39a6ca6a7f0be5ae6999f6aa8d3e3e05b7551d
Author: Paul Burton <paulburton@kernel.org>

MIPS: CM: Make cm_core_lock raw spinlocks

This commit converts the per-CPU cm_core_lock from spinlock_t to
raw_spinlock_t so that preemption remains disabled while accessing the
core-other CM register block on PREEMPT_RT kernels.

> diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
> index 7c9c5dc38823f..3bfe85e86a9a5 100644
> --- a/arch/mips/kernel/mips-cm.c
> +++ b/arch/mips/kernel/mips-cm.c

[ ... ]

> @@ -359,8 +359,8 @@ void mips_cm_lock_other(unsigned int cluster, unsigne=
d int core,
>  		 * race with us.
>  		 */
>  		curr_core =3D cpu_core(&current_cpu_data);
> -		spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
> -				  per_cpu(cm_core_lock_flags, curr_core));
> +		raw_spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
> +				      per_cpu(cm_core_lock_flags, curr_core));
> =20
>  		val =3D FIELD_PREP(CM_GCR_Cx_OTHER_CORENUM, core);
>  	}

[Severity: High]
Does converting cm_core_lock to raw_spinlock_t without also converting
cpc_core_lock cause an invalid wait context in mips_cpc_lock_other() on
systems with CM < 3?

mips_cpc_lock_other() is always called inside a mips_cm_lock_other() /
mips_cm_unlock_other() section (for example in boot_core() and
mips_smp_send_ipi_mask()).  On CM < 3 systems, mips_cpc_lock_other()
acquires cpc_core_lock, which is still a spinlock_t:

arch/mips/kernel/mips-cpc.c:mips_cpc_lock_other() {
	if (mips_cm_revision() >=3D CM_REV_CM3)
		/* Systems with CM >=3D 3 lock the CPC via mips_cm_lock_other */
		return;

	preempt_disable();
	curr_core =3D cpu_core(&current_cpu_data);
	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
			  per_cpu(cpc_core_lock_flags, curr_core));
    ...
}

Taking spinlock_t cpc_core_lock while holding raw_spinlock_t cm_core_lock
triggers a lockdep invalid wait context warning and sleeps in atomic
context on PREEMPT_RT kernels.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-i6500-cm3-=
pmu-v2-0-cd2569571819@mobileye.com?part=3D1
