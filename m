Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C833557F3
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117852; cv=none; b=SBBYpsBAnR5qzELGfnq7LePsiAx+MGv2J8ZMyDQMNWGiMAnOsF4XT53lefTayzpoFHLp1HnlkYFlHMQhh1/cKW/mvqaB0UyXwXWjN9/4gV6cEjnDinoqvcBOWzFMp9d6Za9R+Wd5HZ6xfBvGMb5m6GhRmo5VS4jYGMldqBG0ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117852; c=relaxed/simple;
	bh=XdNDMReQUWwZff6A3EA5HF3sWmrOmYAVvRQY53Vddo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eThHTGZoWLGsu3N8rKAPvDeOa9LvPXZ6/QslAVc5epKtL2Kyj0auRSFG/Zgtm7ZHYV7qaoKq6JlOKA9+BL4duuxq3AGeVhhyInZ2ALacigQ4NtU9SvYjy6/wbx3Ol62Xxf+wDxtWGOXx2DCqSVaNMSQTfOeXYjsRDN+/18WCXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtFp3ZsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtFp3ZsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528FB1F000E9;
	Fri,  7 Aug 2026 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117851;
	bh=tU+g5gnsffG7zFfAprW4hhPRYrFnn3oWRP2ZIpI+nEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EtFp3ZsOtZh/r8Vh9Z6YFA/7dQ5D0OUOsaEw2O5OQK368LoLEV/xdWM1/g887waRw
	 oO1sxfTjUxjoanWWg1+Dw8Hva5RuWjVrbwplmOQCBANZHOayeNJkmJ/PBxCKwcSP8B
	 AZDg1JaSHMN3okt3lRlocNmLrS2/Zn61p6ynYGoNp+Abpo8YmHYJ0TuNTNb4sEsZt7
	 cEVGAcZ6a5TFvK4XEBPYPYjDh0rCf4F6wTW1VnHHf4EIbeWAHZTOVuw6qkLAUZQ0Bw
	 pgqPxsZHJCf9sB/Pe6ZC7zwdjK8Phw0kk2cMEYqODRi3t9HtS91Mx9+zdOSRJVCNEv
	 RvUbnpUBv0Jhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/11] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178611682030.237811.16459191503595231339.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611682030.237811.16459191503595231339.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:50:50 +0000
Message-Id: <20260807155051.528FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arch_modify_local_hw_breakpoint_addr updates the hardware and shad=
ow registers but fails to update the perf_event's canonical software state,=
 leading to silent hardware reverts and incorrect event samples.
--

--- Patch [2]: [PATCH v12 02/11] x86/hw_breakpoints: Add arch_modify_local_=
hw_breakpoint_addr() API ---
commit bbc277e839d1fd31bb4bfa9d695721e5b6899bf6
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
   =20
Wprobe needs to move an active per-CPU watchpoint without releasing and
reserving its hardware slot.
   =20
Add arch_modify_local_hw_breakpoint_addr() to find the installed local
slot and update only its address shadow and hardware debug address
register. Publish the shadow first so hw_breakpoint_restore() observes
the new address if an NMI interrupts the update.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index 9ef24b55737f8..c89f6e71c3a91 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> @@ -128,6 +128,39 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return 0;
>  }
> =20
> +int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
> +					  unsigned long addr)
> +{
> +	struct arch_hw_breakpoint hw;
> +	struct perf_event_attr attr =3D bp->attr;
> +	unsigned int seq;
> +	int i, ret;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	attr.bp_addr =3D addr;
> +	ret =3D hw_breakpoint_arch_parse(bp, &attr, &hw);
> +	if (ret)
> +		return ret;

[Severity: High]
Does this discard the validated software state?

The new address configuration is successfully validated into the local 'hw'
struct, but neither the architecture-specific state (counter_arch_bp(bp))
nor the core attribute (bp->attr.bp_addr) are updated.

If the breakpoint is later re-installed (e.g., during CPU offline/online or
PMU scheduling), arch_install_hw_breakpoint() will read the stale address:

    struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
    ...
    this_cpu_write(cpu_debugreg[i], info->address);
    barrier();
    set_debugreg(info->address, i);

Could this silently revert the hardware register back to the old address?

Also, if a watchpoint fires, perf_bp_event() initializes the sample record
using the unmodified bp->attr.bp_addr. Could this result in reporting
incorrect addresses in the trace output?

> +
> +	for (i =3D 0; i < HBP_NUM; i++) {
> +		if (this_cpu_read(bp_per_reg[i]) =3D=3D bp)
> +			break;
> +	}
> +
> +	if (WARN_ONCE(i =3D=3D HBP_NUM, "Can't find any breakpoint slot"))
> +		return -ENOENT;
> +
> +	do {
> +		seq =3D this_cpu_inc_return(cpu_dr7_seq);
> +		this_cpu_write(cpu_debugreg[i], addr);
> +		barrier();
> +		set_debugreg(addr, i);
> +	} while (seq !=3D this_cpu_read(cpu_dr7_seq));
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178611679753.237811=
.10190793347982785419.stgit@devnote2?part=3D2
