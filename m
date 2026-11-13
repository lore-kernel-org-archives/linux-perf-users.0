Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614063;
	b=IKEPQ7M7RocaZ9jwTThC36PhTXcY/8wsncPak53sCiLOtfR+9qM0OQoxTxbreeSThfNA
	 DcG9EAf4r4OQynNlsmcJQ7Pw+lrOrwbxlvkDm5AwPM9IhAqe6/rpFoWi3EozkSqJpxaog
	 5V4XVS8BihKDrubBl/zlAI3nOyv/VJzuSzgf+VeLbmSAeMSt1C/O8LkiCW1b2KyN4RGrT
	 wUqUqr+O9lhUs2PzycoPpH4DuxXtwf6fYmmdhIZRzKuwvRkdwV+/93kuIb9rb12aocHhI
	 XYyI6RnYRmycIsq6N4G8UerD34/kNSHlOiS5xJ9GtbAZrg5YdhbyMaU5c5xP1TQRWFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=87ckCAg4rRthjAFIqoXOp3s6sIoao/QzN9ch9Ws2jc0=;
	b=H+0yXhVvoyvY6g2BKd6E6U7UY0rzS1WG5xtwm0/beySLYhxSDZ60126jaj3uScv/tg47
	 UTyASZH+OgYYrrMTsFHEt6Xxdfxn6yrWyNQZpC+Hs1hDOSHVRIQeGMQ8EzyiNIKThiR10
	 S/fVvMrLqeTk92Rb/FF2mmqS+XWoPgJjyuh3CBfEzGhF0hxORhC+BaQnEsmZ5vgccVB9l
	 W+bdsa0DOShCYjS+Yj6o/XXKw1ddwX6vPPo0MTLbAhYeQrDcAZYciLlmsCeCHd9SCPxu/
	 9o+0MXRdmKiooUpE9lieECYjlgFi+/nx6Oxpn0VItQjZ17S1J1aPNBH+aSKFVvxfIHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxxfcHHl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E1606A887
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxxfcHHl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF10B1F000C4;
	Fri, 13 Nov 2026 23:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794614063;
	bh=87ckCAg4rRthjAFIqoXOp3s6sIoao/QzN9ch9Ws2jc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NxxfcHHlpmQB6yTu55lmTzJ7sMGB9Y4Jx5KwZMmcQAZQ1UAvEgzlIj9CveMaKUs6E
	 8d0H36ZO0NbmL01OKiS5hi2KA/JPfNzjDsBlO/8eEaLN3XwIjcPodicmWc8oxzwMYq
	 WUvp4U7RA5kO0XIUy5/mrIiTojAcD66drty6kLbmuevIf0MNbBROKK8iO0vhDRMxGL
	 IZ6+nmXhcZT5CizUa/lsLZgWafKFMzJS8ZvhKFmb0MqyOLPnWKpS3zEl40CeRc8Zvo
	 9//oWmS3+nbj/Bs2GN0u9+Q/Dcm8tdCyir5rFGFYxa0we0Nr0jFwKaKQwIPL3a01+8
	 2MUdgW4lBaG9g==
Message-ID: <sashiko-outbox-213885@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] MIPS: perf: Add SB1 and SB1A performance counter
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261113233358.538698-4-f.fainelli@gmail.com>
References: <20261113233358.538698-1-f.fainelli@gmail.com>
 <20261113233358.538698-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:54:22 +0000
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
- [Low] MIPS: perf: preemptible smp_processor_id() call in is_sb1_pmu()
--

commit f968ced28e6948da3887ac13c02f7c72caf1a26e
Author: Florian Fainelli <f.fainelli@gmail.com>

MIPS: perf: Add SB1 and SB1A performance counter support

This commit adds performance counter support for SB1 and SB1A CPUs to the
MIPS PMU driver, along with documentation and CPU hotplug state handling.

> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf=
_event_mipsxx.c
> index 196a070349b09..7a212d4757a0a 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
[ ... ]
> @@ -93,6 +102,12 @@ struct mips_pmu {
>  static int counter_bits;
>  static struct mips_pmu mipspmu;
> =20
> +static bool is_sb1_pmu(void)
> +{
> +	return current_cpu_type() =3D=3D CPU_SB1 ||
> +	       current_cpu_type() =3D=3D CPU_SB1A;
> +}

[Severity: Low]
Should is_sb1_pmu() use boot_cpu_type() (like get_loongson3_pmu_type() in
this file) instead of current_cpu_type()?

current_cpu_type() reads current_cpu_data.cputype, which expands to
cpu_data[smp_processor_id()].cputype.  Because is_sb1_pmu() is called from
preemptible process context in paths such as mipspmu_event_init(), opening
or closing a perf event from a task that is not pinned to a single CPU
triggers a debug_smp_processor_id() warning when CONFIG_DEBUG_PREEMPT is
enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113233358.5386=
98-1-f.fainelli@gmail.com?part=3D3
