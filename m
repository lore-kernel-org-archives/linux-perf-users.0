Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E493793BE
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987320; cv=none; b=R9w1EYg57mq/IiWicY19SFUnUUzhIy/cuYyBbCpr4Pinq9+LpiOiZeBnmTVGhUYrlGGiQjwuj5gCmgNvAtM9ddO8SjFOoKB7qZmsY7r3kWZLCdDADjLoMGihJNTQ4+dmx2ptEC+vPfVOg2M9aLMuZ67tBBXj2uf887pnXYXtC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987320; c=relaxed/simple;
	bh=N9tJJKjU3WnO/4sBTiRHqaI12sSYR5TFe35r7t0mwGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eiKaWs9cUfaMVDUojwZXPVvRQCtj0yHbJJ7j6ue/f+Uu/mkUPKJ1DCBOe/jy8CUak3DGAsZMpCnMnNsA2jdkVbkhKN/1JqZGqoCPsZ4WrBuwRPHq5lpK2MyvUrPvGSd/2YO/WtzOv0DJGJEPMcmkaz0YjVn96UNdkOL1pYX4WVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATm7aor5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATm7aor5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B461C1F00893;
	Tue,  9 Jun 2026 06:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780987318;
	bh=HJQQKiQyGCGPwuYUH2n3+G04fE3jPl7kzapu4QS5Rmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ATm7aor5TG/TL1tK29MY6Pfdb6ex7Q/a7wPQQHI+nBdL6/DkCIWLPIPR0kJQlDfhV
	 +kCJpwfE/Q36CQAmrZh1Jn26BRmoTP/s7meZwdpD4d+otf5Lm1Hab0ODbDqtVmk/87
	 XcK60o7UNXTKLx8eScymb4U9FRgWCQ8DmbQne9YkDb1EY3zwNqcvQC6xmEN03DXnXP
	 9n3tmu5/+lt/JZrAR7fxxlcvPdXAc7ms+Iq4dvjzpgcQhoSB6q6BrsIf+IgX8vuXCV
	 6USFIqXOqza/pGfnYWnyp8DSM83Os3ujWwL5Kk0srq2KCDyF+7Qnqj1TT3XB6SNf3G
	 LRuCw9c14eaPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] riscv: stacktrace: introduce stack-bound
 tracking helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Han" <wanghan@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609063002.3943001-5-wanghan@linux.alibaba.com>
References: <20260609063002.3943001-5-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:41:58 +0000
Message-Id: <20260609064158.B461C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new `stackinfo_get_irq()` helper will cause a linker error when=
 wired up if `CONFIG_IRQ_STACKS` is disabled.
--

commit 106252794f147e577df13bf90a54471b531228ae
Author: Wang Han <wanghan@linux.alibaba.com>

riscv: stacktrace: introduce stack-bound tracking helpers

This commit introduces the necessary building blocks for a robust frame-poi=
nter
unwinder on RISC-V. It adds stack boundary tracking and accessors for
different stack types (IRQ, task, overflow) to ensure the unwinder stays
within known, valid bounds.

> diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm=
/stacktrace.h
> index b1495a7e06ce6..bc87c49403798 100644
> --- a/arch/riscv/include/asm/stacktrace.h
> +++ b/arch/riscv/include/asm/stacktrace.h

[ ... ]

> -static inline bool on_thread_stack(void)
> +/*
> + * IRQ stack accessors
> + */
> +static inline struct stack_info stackinfo_get_irq(void)
> +{
> +	unsigned long low =3D (unsigned long)raw_cpu_read(irq_stack_ptr);

[Severity: Low]
Does this cause a linker error when CONFIG_IRQ_STACKS is disabled?

This function unconditionally references irq_stack_ptr, but the definition =
of
irq_stack_ptr in arch/riscv/kernel/irq.c is guarded by CONFIG_IRQ_STACKS.
If CONFIG_IRQ_STACKS is disabled (which is possible if CONFIG_EXPERT=3Dy), =
and=20
the unwinder unconditionally evaluates this accessor to add the IRQ stack t=
o=20
its stack list, will this lead to an "undefined reference to 'irq_stack_ptr=
'"=20
during linking?

> +	unsigned long high =3D low + IRQ_STACK_SIZE;
> +
> +	return (struct stack_info) {
> +		.low =3D low,
> +		.high =3D high,
> +	};
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.194d76e3a15b.=
v3.riscv-livepatch.wanghan@linux.alibaba.com?part=3D5
