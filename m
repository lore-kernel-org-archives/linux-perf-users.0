Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3846E37C901
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933162; cv=none; b=QxrtPu6/vlOsWsQESEuA4fKwGVb93VQjH+Cc9zmjG7kZObwZt/B+4InS3TByxsLpt3l8FwtndQKd/e484Vl6s8kg2hUKPEirrqsgAaQxBtA0ufDm6iHpQxLIRzhDyNRoMSvCcx/Lyx0LQ0gfwVqRGmB1rjCU/12BQ0O9dn+v3/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933162; c=relaxed/simple;
	bh=ALua+r9N31eGGi6hrCY3zlgQE2oCNfohZGm/EUzt59o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MwsN77IJSIjoD2xVe/2jn579X2CNSwGt2V5XNHn2F4CSJAHn35kc1OcD5LQWAwDZO0oxrMclaX1sS6mRYQ1h6dSmZ33M9XNvryM80W76jmDX4tl1gAXL9i80a9SgmHkawHeTgDurOeKgFjX0NriTca+h8JHY4WyCNrXA9lmi5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5706qzM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5706qzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE9DC2BCB8;
	Mon,  4 May 2026 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777933161;
	bh=ALua+r9N31eGGi6hrCY3zlgQE2oCNfohZGm/EUzt59o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=h5706qzMJRDLQnR5DfiV4CtKfi5pPvASla1Xst9wnmClrr11uNp7fyFCvZj1IOm4g
	 gXW2wkt+w1xWc7KnThb8JGTtsfCxs9f34h+TKGgQBYjUkWfSbAmei90p0jkuGFa4eL
	 jPACdOFKsFjLm0q6WG/yIJFh78AjAkd7wQEq1p94anPPelCx13l6e95ZjLNqtXPCiN
	 FhiAAiGSXtjrIqzdfkVV85rF9QhXuCU+5DN9mN25Y7Un+LO2MUNbRJeB0Uv3X+YjT8
	 IrHwVTYcWPK2E+8hA0SHGgLNiqKXHimj8NAjXiArd42m83BsJqtseDF4gHSgzTHay2
	 CZGPHNbcEDHgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/20] KVM: arm64: selftests: Add test case for
 Partitioned PMU
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-20-coltonlewis@google.com>
References: <20260504211813.1804997-20-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:19:21 +0000
Message-Id: <20260504221921.ABE9DC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION attribute expects an un=
signed int, but a pointer to a 1-byte bool is passed, leading to an out-of-=
bounds stack read and potentially incorrect test execution.
- [Low] The 'pmu_partitioned' field added to 'struct vpmu_vm' is assigned b=
ut never read or utilized.
--

commit f6902795d8749ec81b1bab36231a48757e124a66
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: selftests: Add test case for Partitioned PMU

This commit adds testing for the Partitioned PMU by running all tests for
both Emulated and Partitioned PMU implementations. It modifies the setup
functions to take the implementation type as an argument and configures the
vCPU attribute accordingly.

> diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/to=
ols/testing/selftests/kvm/arm64/vpmu_counter_access.c
> index ae36325c022fb..9702f1d43b832 100644
> --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
[ ... ]
>  struct vpmu_vm {
>  	struct kvm_vm *vm;
>  	struct kvm_vcpu *vcpu;
> +	bool pmu_partitioned;
>  };

This isn't a bug, but is the pmu_partitioned field used anywhere else in
this test? It looks like it is assigned during setup but never read later
in the code.

[ ... ]
> @@ -409,6 +420,13 @@ static void create_vpmu_vm(void *guest_code)
>  		.attr =3D KVM_ARM_VCPU_PMU_V3_IRQ,
>  		.addr =3D (uint64_t)&irq,
>  	};
> +	bool partition =3D (impl =3D=3D PARTITIONED);
> +	struct kvm_device_attr part_attr =3D {
> +		.group =3D KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr =3D KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION,
> +		.addr =3D (uint64_t)&partition
> +	};
> +	int ret;

Does this pass a 1-byte boolean to an attribute that expects a 4-byte
unsigned int?

When the kernel calls get_user() to read the
KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION attribute, could it read 3 bytes of
uninitialized stack data alongside the bool?=20

If the uninitialized stack data contains non-zero bytes, could the kernel
evaluate the 32-bit value as true and erroneously enable PMU partitioning
even when partition is false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D19
