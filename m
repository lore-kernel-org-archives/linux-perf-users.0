Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CA3B52FA;
	Wed,  1 Jul 2026 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898702; cv=none; b=DtvAvFi8ouPTmggG03sSsIbfOLBlxZ1LR0ppzRoam7vSxThrInP9U6HLDoqN7mxz+ilhtJHbvP0JPnXosO45Zi8KoKVBBMaSiJa+ZG0GeRiTVVVpDmdGLLjOW6YAxKE7Q/to13JbfX79r4l2GmWXnqz6X6RXZOiqDuwORAUQtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898702; c=relaxed/simple;
	bh=xqAkalBFj6P2CfXrC4Djkm278Pl89Ob53W+XVk3g4R8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CniH9BXsdnBNFQenhlyfILPQ0V+PGeGPl2otQq9X8CeF/KJhUZ6sh7PkNjzZSDgWHMAN0kAE5OoK5NEu1NPHMeuxHftg5pYvdB1sL/sdkXhOcvhNgws047ujbm1ij4lDciVXejt/a4lN/GS8TvV+GPRisvVCXX5PQJQwj3XyeBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqeI6r2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqeI6r2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184C31F000E9;
	Wed,  1 Jul 2026 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898701;
	bh=kEMwVhH5ayejfLZVBhJIuE6nzNZKx9bBPXPaWyhB3gU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqeI6r2RXSrNidRRa3GyxBBHtj3blbDo0JZ8csofqd+rnbRzfpbK2i2Kq+2j5CLLj
	 0FyG1iHuuJtruoV9UBX1PAInKEsmyzSDrMBVZZfMdZJ8EOxuhddXAC1fY2BN66MWwu
	 fxcfo5mEAFbSLd382IGioyKPoL+nnjewOHXC2FH5l1U72+G6nORbTVOhSyD96rOVeq
	 yKr+X3Y8OQxh/iKKW/IIRX6e9mSK4807KwX4nN9USKEoBwwFqhkjKy61YY8T4sc2D3
	 e/ymoiZuk/F82rZ0zk2SZE2pd+GHW9hByQA+SzAEb8lkOzBFKKtIsST1AWlxOfE074
	 WLu13SXrxv+Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 21/22] TEST(do-not-upstream): fake qemu-virt PMU
 events for cdeleg counter-mask testing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260701-counter_delegation-v8-21-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-21-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:38:20 +0000
Message-Id: <20260701093821.184C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch injects non-existent fake PMU events for testing direc=
tly into a production driver, polluting the sysfs UAPI and userspace ABI.
--

commit 4ecbb9bba705eb0cbe075ec61ec799a9e140a5fc
Author: Atish Patra <atishp@meta.com>

TEST(do-not-upstream): fake qemu-virt PMU events for cdeleg counter-mask te=
sting

This commit adds fake PMU events to the RISC-V SBI PMU driver to exercise
counter-delegation allocation and counter-mask constraints in QEMU.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -499,6 +505,9 @@ static struct attribute *qemu_virt_event_group[] =3D {
>  	RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
>  	RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
>  	RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
> +	RVPMU_EVENT_ATTR_PTR(fake_any),
> +	RVPMU_EVENT_ATTR_PTR(fake_ctr3),
> +	RVPMU_EVENT_ATTR_PTR(fake_ctr34),

[Severity: Medium]
Even though this patch is explicitly marked as a test that is not meant for
upstream, does unconditionally appending these fake events to
qemu_virt_event_group pollute the sysfs UAPI?

Because they are added directly to the group array, tools interacting with
sysfs will see these non-existent hardware PMU events exposed as part of the
public userspace ABI. Could this logic be exercised using a dedicated test
framework rather than injecting fake test events into a production driver?

>  	NULL,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D21
