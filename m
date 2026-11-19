Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115668;
	b=pj1jOyiajJueR+CBRwGMz1ETop9kROT0oHbnOEucxijp6O4rLI0F4CIRq4UTTiJGSRjP
	 PAqKdOq0tbH2cYILHuYenCGGmwfFhGdGNEtsUcf39mxqJ9Q5PZbOy0CVTqdZi6ch8RQhU
	 YNr/UEjjkcUgG6/Pi2g1SOsGh0HAKr/4nOt9gSr/rz5QQX9R0V4vkJ40c19AwrP0InUO7
	 KySKWF/W/q46ePhkFqMci1g0CDihMj92h5xOYsU/asQu7BiFojVgCA0qDBRGyr3X1eHG8
	 bru6FpVwKB4JloGJOcJ6/7HciWyazadlWv+ULBusoI6T9eM+kmT8+K4qvDTJlZTIWng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115668;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rIrRAqUOc/LsyUTThhY85e/YpMqV4NWOSXS1vRNkbfI=;
	b=2S7mronmCZVkizbq5v33V6SG00ZnLe75mJsYmPSGMq+UYTXKxrFq2j3uep8HoBUQDMqX
	 HsynYlwco49XtsEcpjwXx+eJs1Yo/Z2k3pdCScBN6FXrUKvkc+6XzcKWCPg8ltlr7Hm6V
	 w9RRsK6jMBbg7j0mrBFA1k+CAyrBcsQepVThWzSUv/yaAjQKCh8jB7izK5VXGy4wA/xK0
	 DU8NRL509rpKFDhRCJmlzgXZYiVyIKnGkiYNuWu+RibcZLPrmQ73TQOaQMUQywaZ6Be1i
	 irAtpNp0xmDmw6d4BPM/BGttk+G2C35sXa7U0U2QMB4/q/i/r4vmpF4ORCqSjOXUqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmxKnQYj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C922B606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmxKnQYj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB9F1F000C4;
	Thu, 19 Nov 2026 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115668;
	bh=rIrRAqUOc/LsyUTThhY85e/YpMqV4NWOSXS1vRNkbfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FmxKnQYj9d9YdNcMZ8wSR7TRHSB249qedMphF9H9sIPoYP47e1GMdVxVS3EOwmJGR
	 f6rbkLhHP2X0QTkvaSeHe+ngoPOPv+NP/958M/IfD24XGVk/B/EAwKcA8mzJiLhDxY
	 3Kg2s0HvrlhTmZEBRg8FDkUwcdR/RfMgks1j/4cTG+CMo6pf7zwxD9lTpqx5f9AjGi
	 crMOCNetfaFNfwx1enwKWGSkyj5Y4dgyrNXOzfg6vWWsqozGBzM0P2k+F8whGTtQMA
	 xgD6qOi2Y17IV/6TijwNz1EEZbr+FbvJG7H50EHKz+MoQIw2+/uSkcqeE7fmWGQIvO
	 vrxTARRloUOIg==
Message-ID: <sashiko-outbox-223847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 31/33] KVM: arm64: Add vCPU device attr to partition
 the PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-32-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-32-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:14:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add the KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION vCPU device attribute to
> enable a Partitioned PMU on hosts with VHE and PMUv3 support.
>=20
> When partitioning is enabled (KVM_ARCH_FLAG_PARTITION_PMU_ENABLED),
> userspace must configure guest general-purpose counters via
> KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS before KVM_ARM_VCPU_PMU_V3_INIT:
> - Require kvm_arm_pmu_part_hpmn(n) < max_counters so at least one
>   general-purpose counter remains available for host profiling.
> - Allow n =3D=3D 0 (cycle counter only) on hosts without FEAT_HPMN0 when
>   max_counters >=3D 2, reserving physical counter 0 (MDCR_EL2.HPMN =3D 1)
>   and hiding it from the guest via traps.
>=20
> Because PMU attributes are invoked per-vCPU while arm_pmu,
> nr_pmu_counters, and partitioning state are VM-wide, VMMs such as QEMU
> iterate over vCPUs (CPU_FOREACH) and call KVM_ARM_VCPU_PMU_V3_INIT on
> vCPU 0 before configuring vCPU 1..N. Allow SET_PMU, SET_NR_COUNTERS, and
> ENABLE_PARTITION to succeed when a vCPU PMU is already initialized as
> long as the requested value matches the VM's existing configuration, and
> return -EBUSY on conflicting changes.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D31

