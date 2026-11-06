Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941275;
	b=MvhgdIICbxC+jRGM7eUWzy/0mxlGp9W25P9u2//STYQr3UPWlkayZMUkqXRb4fJhE5fF
	 FqcFPu/Re3K8A6xhEujBrUcVM+ymIFX/bs46XzE4alAwu/H3Wi1QDioJxbF6VbDv4muTW
	 Rz/LjvwGj/sBszBDUUjGGnsy3PlZZKfIeM0MpHx0xdpEqcGDAIj9BK+9qRChWpmQXwl32
	 GcwwkJMdoiFHkHqI84sDQ5VnhGJtdWtOwrY4fBKyTeorPHoO4NUQaxqoSdVQq/9M3YcFH
	 tRkhBYPQAoYgfyDQLNXvWq3eDc0VCAfVHT8SsllHdtkZEea5jvNCU8uyvl8Dufoic7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j5hTxVha0pIyp65aKu9OxONr/TdNJ0NLjPZrkXTpUuA=;
	b=mLbirxYZYLRFwQpx3NLkoeWu2cWl3W/Lme5vwpU1t7IvxwV/B3ocsvkjANWlrpQi44kF
	 HBQJLuCc9L8iB7C73uUgruqXRPrcQuzBYzJtjPa2NmioNRrE8JKx3R9lE45M33JYFlVC+
	 SOjY5YeJh6VjL+Cj8ytmu1zbH5ADt9hZpmYLZj91lBveqADfwfR6K8nEPXrTZHEI6FmGr
	 DqASMidcwS0t9haTwP+JQkB3FXn+jK4vpslWtn3PMnR1i6vuHy95WiGLiTwvePSAcK2ih
	 TUc4I5aYBv0hjlqZIVKaNQg/JpcljQ9VnojmihZajN1VkitjEyuvxYuHpMbh8lM2t0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kTu7/0po";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDA606A31B;
	Fri,  6 Nov 2026 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTu7/0po
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0B31F0089F;
	Fri,  6 Nov 2026 05:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941274;
	bh=j5hTxVha0pIyp65aKu9OxONr/TdNJ0NLjPZrkXTpUuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTu7/0poZr8UFYtIoG3pCArqMJb093/bctyTDbSURWASLPbT5FuajZ9qKWrDWQ+3e
	 YLrpGVVGoQAVswpAMks3BQ85VND2PY7uTFGLPxn32uSLEgeFbEaIUpBtci5eYAFgtD
	 RCkbJBWHVxbm3XdaGqY3IweWWqLfq/wMV1sE+z45JJZ/G+JUgUU/+8mil90TMsdAhi
	 tJVWZ2QC6qdXVcfhUxmIzxI6gw0ydGIYvFiarndkdJFSLuUNQ/bJ9l5Hfr16PpYncI
	 Da+YkbYyLigv5zrsXQJDhP118eZcnti7C6rQohQBPRghGVHuxkegxshyRrSZytXd8P
	 WV7mnoO9TqGdg==
Message-ID: <sashiko-outbox-200787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 06/20] perf/x86/amd: Avoid re-enabling PMU and LBR
 for BPF when disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261106043257.842864-7-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:01:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/x86/amd: amd_pmu_v2_snapshot_branch_stack() leaves cpuc->en=
abled set
--

commit dbf85e8b6a5abeff651d80166ad0c339896c5b42
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled

This commit updates amd_pmu_v2_snapshot_branch_stack() to save cpuc->enabled
and cpuc->lbr_enabled before disabling the PMU and LBR, and only re-enable
them if they were previously enabled.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index bf631f60757cc..851d8a938f522 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -932,22 +932,28 @@ static int amd_pmu_v2_snapshot_branch_stack(struct =
perf_branch_entry *entries, u
>  {
>  	struct cpu_hw_events *cpuc;
>  	unsigned long flags;
> +	int pmu_enabled;
> +	int lbr_enabled;
> =20
>  	/*
>  	 * The sequence of steps to freeze LBR should be completely inlined
>  	 * and contain no branches to minimize contamination of LBR snapshot
>  	 */
>  	local_irq_save(flags);
> +	cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +	pmu_enabled =3D cpuc->enabled;
> +	lbr_enabled =3D cpuc->lbr_enabled;
>  	amd_pmu_core_disable_all();
>  	__amd_pmu_lbr_disable();
> =20
> -	cpuc =3D this_cpu_ptr(&cpu_hw_events);
> -
>  	amd_pmu_lbr_read();
>  	cnt =3D min(cnt, cpuc->lbr_stack.nr);
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);
> =20
> -	amd_pmu_v2_enable_all(0);
> +	if (lbr_enabled)
> +		amd_pmu_lbr_enable_all();
> +	if (pmu_enabled)
> +		amd_pmu_core_enable_all();

[Severity: Medium]
As reported by Sashiko on v5 [1], while __amd_pmu_lbr_disable() clears
cpuc->lbr_enabled =3D 0, amd_pmu_core_disable_all() only clears the hardware
global control MSR and leaves cpuc->enabled set to 1.

If a BPF program in non-NMI context calls bpf_get_branch_snapshot() ->
amd_pmu_v2_snapshot_branch_stack() while cpuc->enabled is 1, local_irq_save=
()
does not mask NMIs. If an NMI arrives while amd_pmu_v2_snapshot_branch_stac=
k()
is reading LBR MSRs or copying entries, perf_event_nmi_handler() ->
amd_pmu_v2_handle_irq() will see cpuc->enabled =3D=3D 1 and re-enable the c=
ore PMU
counters on exit:

arch/x86/events/amd/core.c:amd_pmu_v2_handle_irq() {
	pmu_enabled =3D cpuc->enabled;
	cpuc->enabled =3D 0;

	/* Stop counting but do not disable LBR */
	amd_pmu_core_disable_all();
	...
done:
	cpuc->enabled =3D pmu_enabled;

	/* Resume counting only if PMU is active */
	if (pmu_enabled)
		amd_pmu_core_enable_all();
}

Similarly, if an NMI triggers a nested BPF call to
amd_pmu_v2_snapshot_branch_stack(), the nested call will also observe
cpuc->enabled =3D=3D 1 and call amd_pmu_core_enable_all() before returning =
to the
outer snapshot.

Should amd_pmu_v2_snapshot_branch_stack() clear cpuc->enabled =3D 0 after s=
aving
pmu_enabled and restore cpuc->enabled =3D pmu_enabled before re-enabling the
core PMU, matching amd_pmu_v2_handle_irq()?

[1] https://lore.kernel.org/r/20261029043914.1395147-7-dapeng1.mi@linux.int=
el.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D6
