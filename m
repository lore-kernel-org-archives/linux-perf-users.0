Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116285;
	b=nlyCOo/1GStvY7ZP2h6CG3DVTq+Wc3MWl205BzOPxQMQy+mpEbjJhwvPlWk9TkE+z5wO
	 iVrEEuGRxdQyWRdpQbsMzMZ6Rd1thoI7HJZFxsKndKX9AtrRu0OmAhjFzEaBXXVT5XQ3E
	 o3KWtZCul6BxPvXqlK2NaYLADkDVbEwdqvcLFpWjO16mx5WN45gAs7gPmMPgACADcUVqm
	 yjDVVTWKMf7ifwo4vsOENG9ESc2gyn3/GU/6a84HRoHNurfw4SS4lct4wjpBDNFxg1S4Z
	 GebG1z94LaKEBs9OGpQiQ+bFnVhKzSAhr8c4j7upZnQWya74YQXaQ4aQpQQm/KIaNIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0JVuic8BFfLi55yC/JUutCRZNVaeU6WTA0+mI4Pw7SY=;
	b=iya4OnkFMpY7tT8Q1Wbpi8TK++uEvZLumCQpWPQcceyO2/nwMFykFkKjEKHDsihe/Zt8
	 GrwS26YM8PZlpQjcLGO9ho0kE9gnkOaTnha7KV+oy6GgZz8ZXTX/xdZDxJtWmKYgY7NYW
	 vKwsDGwg2vlXrzTwObaiMw2ZjeBrwsymCeyyzJLkp93IC359O9vAB7I1R6kYL68IX3bgp
	 WvS34Y+YNfzWg4iDYwLkw4ckfq6bAfJ5T5Dnl68TsiSfbawcluVfgYkUNqT6VxsRmmSQb
	 PnvfvVVZ9iXeV2E9BpjBYwsvf/Qfc5jT+qK3XKT3b2jCnXw8Ko9TtihF8RdJImMCZQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIZQ7xpp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EAA606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIZQ7xpp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CB41F000C4;
	Thu, 19 Nov 2026 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116285;
	bh=0JVuic8BFfLi55yC/JUutCRZNVaeU6WTA0+mI4Pw7SY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIZQ7xpp7JkwVPVo7K7xiqeNyND5I9y8wcgJJ0kZMmuGW3SzwX3LWxcjntsA2UA42
	 /OZOwFDJCuV/DoFZ8HLAt7f7TnazUwABSbJM99wGGZWHiuvZ5ZwVEs07NlncD8btxX
	 GGz/RQq5lFN8WRXNdw1+Zx4sYYqT2iNv1RNPtsYMAHHrelz0yG7BekdXfdNo1wJSum
	 FU85LUORPZavUsOCQUeHSVWoM1Rgs7zfNYxgSjJN9HQZTcCRJ7RiS+1ZX8PQ6UgIkF
	 NzXyoqeaSg5DZR0La4IR6nhbSLskrZrRCZQqLyTK62N+d0nqVmbye4vLGwF9endk2y
	 KWQZmEkRST2Ww==
Message-ID: <sashiko-outbox-223873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 23/33] KVM: arm64: Implement lazy PMU context swaps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-24-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-24-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:24:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Since many guests never use the PMU, avoid reserving hardware counters
> and context swapping PMU registers on every vCPU load and put until the
> guest actively enables counting or overflow interrupts.
>=20
> Track per-vCPU PMU ownership via enum vcpu_pmu_register_access
> (VCPU_PMU_ACCESS_FREE vs. VCPU_PMU_ACCESS_GUEST_OWNED):
> - While FREE, keep MDCR_EL2.HPMN at the full host counter count with TPM
>   and TPMCR set so host perf retains all counters including PMCCNTR_EL0.
>   Trapped reads and non-enabling writes (such as guest boot PMU probes)
>   operate on shadow sys_regs[] without claiming hardware counters.
> - When the guest enables counting or interrupts (setting PMCR_EL0.E,
>   enabling MDCR_EL2.HPME with hypervisor counters, or setting guest bits
>   in PMCNTENSET_EL0 or PMINTENSET_EL1), transition to GUEST_OWNED via
>   kvm_pmu_set_guest_owned(), reserve the guest counter partition, and
>   load guest state into hardware.
>=20
> Add kvm_pmu_reload_part() to service KVM_REQ_RELOAD_PMU for partitioned
> VMs (triggered by MDCR_EL2 or PMUSERENR_EL0 trap changes, vCPU reset,
> and KVM_SET_ONE_REG writes). Unlike the emulated PMU, which only masks
> shadow registers and reprograms perf_events, a partitioned PMU loaded on
> the CPU must flush live hardware registers to sys_regs[], mask
> unimplemented counter bits, recompute FGT, MDCR_EL2, and hardware event
> filters, and reload hardware without dropping its host counter
> reservation. When not yet loaded (such as after vCPU reset or
> KVM_SET_ONE_REG), kvm_pmu_reload_part() transitions to GUEST_OWNED only
> if PMCR_EL0.E or MDCR_EL2.HPME is enabled, avoiding false activation
> from reset_unknown() poison bits in PMCNTENSET_EL0 or PMINTENSET_EL1.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D23

