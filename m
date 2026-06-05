Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445F3644CE
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623535; cv=none; b=AsuPguglVVLdOxmmOMT+Rh9+FXaDlUVZ8ZnmTNXiRhYkcLuV/fdwt0xsfoky6349b6z/ImE5ICThsUKKLPG/asiONtvI8lovtt9ach+OSGOyxHTu3+yfJTluBkCp9dPkDDzeQu2TfwCsctk/gAeacogyUKGG9lMFy0T/dhln3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623535; c=relaxed/simple;
	bh=zyIHpRGz8USjDQlYN2XBZ8ZEE0MnqxT/pArQUO9z4Zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J0kL5tGpHm74tUVo3LE+mVCE2YWgDuvJ0K5wjqpsgomjbN9DsjoEJg/TXIhmuBad9N4fpK9PYY6Xly0C+4EPtRKGFMlLJFHXHEwvIp6a2jRrYKadlckLrnuo+1j1ssl8DVoqLau5A5Phq2Vh1gAPqyrl2q3c4hkmivI+nnd7MUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSpjfynT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSpjfynT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317911F00893;
	Fri,  5 Jun 2026 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623528;
	bh=yNkeD4YctBklX7ewn0slR1wuzSCHTMpcUUW0omVx1PM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSpjfynTS7+pJNfsLQpzFIwdW2/6lPHrP6IA4Cutb5ZKDCrzIvzkkx4ezUoaFHkY1
	 eHmxpTTBN9hOiVFYWEeYiUt4N/gbOn/4+lpQJ4UbTxcxZRjQmoFNAgugvz2SI9xkLU
	 dqUpevwgtIHlsAcNNfRP3LqfXFDv9qBfwzEo/bhb+r0CFijjHw8vYLSu6wqiIYBjE/
	 5+Pf6rWet5DLfoHz8YmbDQ3v6gNo38ax1BJ0vuZGLgZMET23tg2845HTJMIgkecR43
	 N3ej/4cfHmFLXhWWGjfsqZWQv/xqAYic18jJOMGI3o+KlKoE4zBUfazJwut3TUibo5
	 IuIevS/hZQ0fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] perf/core: Fix kernel register info leak via
 hardware skid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605011136.2043393-9-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:38:47 +0000
Message-Id: <20260605013848.317911F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Valid hardware-captured user-space register samples from precise e=
vents (e.g., Intel PEBS) are incorrectly dropped as sensitive kernel data w=
hen the PMU interrupt (PMI) skids into kernel mode.

Pre-existing issues:
- [High] Hardware PMI skid still leaks kernel IPs and callchains to unprivi=
leged users when exclude_kernel=3D1.
--

commit 8a7df272a8b8797c3525f28de5158f11f610df4d
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/core: Fix kernel register info leak via hardware skid
   =20
This patch addresses a security vulnerability where hardware skid can
cause a PMI to trigger in kernel space, leaking kernel register data
to user space via PERF_SAMPLE_REGS_INTR. It fixes this by dropping
sampled register data if the event has exclude_kernel set but the CPU
is in kernel mode.
   =20
Link: https://lore.kernel.org/all/20260529085613.CCAFB1F00893@smtp.kernel.o=
rg/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7935d5663944e..b7326bc3acd00 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7800,10 +7800,21 @@ static void perf_sample_regs_user(struct perf_reg=
s *regs_user,
>  }
> =20
>  static void perf_sample_regs_intr(struct perf_regs *regs_intr,
> -				  struct pt_regs *regs)
> +				  struct pt_regs *regs,
> +				  bool exclude_kernel)
>  {
> -	regs_intr->regs =3D regs;
> -	regs_intr->abi  =3D perf_reg_abi(current);
> +	/*
> +	 * Hardware skid can lead to PMI is delivered after
> +	 * the CPU has already entered kernel mode. In that case,
> +	 * user-space sampling must not expose kernel register state.
> +	 */
> +	if (exclude_kernel && !user_mode(regs)) {

[Severity: High]
Will this incorrectly drop valid hardware-captured user-space register
samples from precise events like Intel PEBS?

For precise events, the PMU driver populates a temporary pt_regs
with exact user-space registers captured by the hardware. Because PEBS
does not capture segment registers, the driver copies them from the
delayed PMI interrupt context:

arch/x86/events/intel/ds.c:setup_pebs_fixed_sample_data() {
    *regs =3D *iregs;
    ...
}

If the PMI skids and is delivered after the CPU enters kernel space,
iregs->cs reflects kernel mode, causing user_mode(regs) to evaluate
to false. This would result in these safe, hardware-captured user
registers being zeroed out here, which seems like it might break
unprivileged precise profiling.

> +		regs_intr->abi =3D PERF_SAMPLE_REGS_ABI_NONE;
> +		regs_intr->regs =3D NULL;
> +	} else {
> +		regs_intr->regs =3D regs;
> +		regs_intr->abi =3D perf_reg_abi(current);
> +	}
>  }

[ ... ]

> @@ -8694,7 +8705,8 @@ void perf_prepare_sample(struct perf_sample_data *d=
ata,
>  		/* regs dump ABI info */
>  		int size =3D sizeof(u64);
> =20
> -		perf_sample_regs_intr(&data->regs_intr, regs);
> +		perf_sample_regs_intr(&data->regs_intr, regs,
> +				      event->attr.exclude_kernel);

[Severity: High]
This is a pre-existing issue, but does the hardware PMI skid still leak
kernel IPs and callchains to unprivileged users when exclude_kernel=3D1?

While this patch correctly zeroes out the register state to prevent
leaking the full CPU register context, it appears the same privilege
boundaries are not applied to PERF_SAMPLE_IP and PERF_SAMPLE_CALLCHAIN.

In perf_prepare_sample(), the kernel IP is unconditionally extracted
from regs if the PMI skid caught the CPU in kernel mode:

kernel/events/core.c:perf_prepare_sample() {
    if (filtered_sample_type & PERF_SAMPLE_IP) {
        data->ip =3D perf_instruction_pointer(event, regs);
        ...
    }
}

Similarly, unprivileged users can set exclude_kernel=3D1 and leave
exclude_callchain_kernel=3D0. On a skid, !user_mode(regs) evaluates to
true, causing perf_callchain() to unwind and expose the kernel stack
trace.

Could this allow a deterministic KASLR bypass, and should it be
addressed alongside the register clearing?

> =20
>  		if (data->regs_intr.regs) {
>  			u64 mask =3D event->attr.sample_regs_intr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605011136.2043=
393-1-dapeng1.mi@linux.intel.com?part=3D8
