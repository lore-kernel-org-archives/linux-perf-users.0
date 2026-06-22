Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF81DA60D;
	Mon, 22 Jun 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117580; cv=none; b=Yw/ZGfZmCGDLs+nLsd51KEgQbOSba1oY1DutokEwrryNJYOPEck3bidgadX6F045+g+UL/EU5k2WrXhCFKlbxJNupLlRQACJgX2B8x5OArupX+m1DUlDdg58tEkNpN9o6lIEbtxDi9f0U6ha37XRkWuUGFljLW3k034tCBHy+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117580; c=relaxed/simple;
	bh=8KVnwnLIZEOXEt+9WXQZ5xooTYl9LkiX4IFdFYuORoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u/In1bDybhK9jeTVasevjGQiwlEDJlUikJ1OFkWhRVxJ642NAkfpBgCdgKpAgH/F6nkulsaNnvfSnnh65DS/by+hNSfa+yJjTrNhATqAChKvIor2q8AxgYpQEbHaMn6dj6z3C4+GiIOC+LW6sw6tTL+tuDgfP6JyNLvcVKW21V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzdsZcBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzdsZcBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7418B1F000E9;
	Mon, 22 Jun 2026 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782117578;
	bh=R8FJ6OSfMvgdpSiE1mEZObRvH+o1Z0zmiQSNkmZTBmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HzdsZcBgyOlTfQ1xoKGQBHGltU013D4plwPpx3tw1XJaJfH4K/LVjVcMHdTU4TOvY
	 SuTxEJoLw0UbLadPIRn7Socs7O4uWINwgIfNAMSkuCkxqGhw5mUh6KXM5QBANTh7yw
	 MLes18ufW1imU43DZnStf2ZnI+dLBaLYea0UOao6j3ISkYwpeRoELZakO4lfSd/GZb
	 PCwepkBjlabk1BCPK+OFQhquWz6gOylKrcz5udT75av90Es25hHPamyonOlKNJt5Cb
	 q8IwlEsPuijpi+JnnnBljw8Pxn9qbUwHdp/o9kjGec5x5RvNI2hpN3fztZfMaJ0cbl
	 kCt30y4/3jj1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/22] RISC-V: perf: Add Qemu virt machine events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260622-counter_delegation-v7-18-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
 <20260622-counter_delegation-v7-18-0ba2fd34614e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:39:38 +0000
Message-Id: <20260622083938.7418B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using mvendorid=3D0, marchid=3D0, and mimpid=3D0 to uniquely ident=
ify QEMU virt incorrectly hijacks PMU event mappings for all non-commercial=
 RISC-V cores.
--

commit 6c37953807499d33e32d891aa7fbc5980f5e88bb
Author: Atish Patra <atishp@rivosinc.com>
Subject: RISC-V: perf: Add Qemu virt machine events

This commit adds a set of legacy perf events for the Qemu virt machine to=20
the vendor table, allowing users to use them when counter delegation is=20
enabled.

> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/=
asm/vendorid_list.h
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -11,4 +11,8 @@
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
> =20
> +#define QEMU_VIRT_VENDOR_ID		0x000
> +#define QEMU_VIRT_IMPL_ID		0x000
> +#define QEMU_VIRT_ARCH_ID		0x000

[ ... ]

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
>  static struct riscv_vendor_pmu_events pmu_vendor_events_table[] =3D {
> +	RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, QEMU_VI=
RT_IMPL_ID,
> +				qemu_virt_hw_event_map, qemu_virt_cache_event_map,
> +				qemu_virt_event_group)
>  };

[Severity: High]
Will this apply QEMU's limited PMU mappings to all non-commercial
implementations?

The RISC-V privileged specification defines mvendorid=3D0, marchid=3D0, and
mimpid=3D0 as indicating a non-commercial implementation or that the field
is unimplemented. Academic cores and FPGA soft-cores (like BOOM or CVA6)
legitimately return 0 for these IDs.

Registering QEMU's specific legacy PMU event encodings against these generic
0x000 IDs could incorrectly apply them to actual physical hardware that
implements counter delegation. This might force compliant open-source cores
to be restricted to QEMU's limited 5-event map, and write QEMU's raw event
encodings to physical cores' mhpmeventX CSRs, potentially causing silent
measurement corruption or illegal instruction traps.

Would it be safer to identify QEMU virt via device tree machine compat
strings instead, such as checking of_machine_is_compatible("qemu,riscv-virt=
")?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-counter_de=
legation-v7-0-0ba2fd34614e@meta.com?part=3D18
