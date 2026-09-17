Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42E2C237C;
	Thu, 17 Sep 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687051; cv=none; b=Q5sc21tucgAAnhUAt6XXzR35+eiHLAu6GZRuME0M2uKLvT2PRSYoRqAz+G65U74JkuC0FCp4DmCHvZYmvulbgbnnXmiKLKl7Nhpu69EzibGLfoOdRj67OPPs8cXMWiJn4ehV37IScfmZGwGow67iDwgBAwoGlev3uSQll3JWBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687051; c=relaxed/simple;
	bh=iBFwT8EWh55zDdiWYWL5+m7hDyExYrUJ3RKjlvXihw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fa/BAHJZ4CvXmVY7XJk6cVVZmW6ElmC+X464cffMDP0czWFph1QP+gBZ1keeAdgM5ORuRVQV8IKA/aFRKjzmSp3VHaj+hnpc5Udea+fn/LVI276DbyO8xGz0b1CF3GkTbcsGgYu3eJmmZhJA8Eg7msKjzIYsZ5iHsWRglJSrGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKIxcQzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKIxcQzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913AE1F000FF;
	Thu, 17 Sep 2026 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687044;
	bh=EWGe2xa1RMaDFHh4jelc3Zya04H7dEc05/lAWmAFdTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKIxcQzZv7DVAzX6NJztdGc2e1fNZCtfW5NRXC8m3J7H+gmuNAPymzyZ3je2/4V7z
	 6dII7YYlTcHdnSi7oJCxGv+p8mdpwpYQu585wFJQjIgr/jdaD171T2IVKrfq6ANzdb
	 fcu9CnQVl3t3C45S8vNhHrh0+fwHXJa9P/2Ykn3/7J06H9BoOeeWPy0jjKCVbecBnJ
	 mWDDNbkZXqpJodoBkHGIjZUT9m5yKatoPA9WcfluKPDkvDAKoGXx/IvgiePH6+7er2
	 snqZMlhqOvrXw2Zd4Sqjsr8KVYiWQAxOyC8SrVKyt3N4vPwWD9415zKgUS2vmuK/1a
	 Yr5+IL1mrDzjA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/11] ptwrite uprobes: Add basic memory
 references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917230127.924985-7-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-7-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:17:24 +0000
Message-Id: <20260917231724.913AE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/uprobes: missing disp32 emission for memory args causes invali=
d reads
--

commit a6d11e7a0c907a2ea16451bbea72e2f4d6ed70e8
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add basic memory references

Add support for memory references. Currently this is only
simple cases, no indirect memory references or strings,
that would require saving/restoring registers. Only 8 and 4 byte
memory references are supported.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
[ ... ]
> @@ -1431,24 +1463,62 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprob=
e *auprobe,
[ ... ]
>  	for (i =3D 0; i < desc->nargs; i++) {
> -		if (desc->args[i].src =3D=3D UPROBE_PTW_SRC_REG) {
> +		switch (desc->args[i].src) {
[ ... ]
> +		case UPROBE_PTW_SRC_MEM: {
> +			u8 reg =3D desc->args[i].reg;
> +			bool wide =3D desc->args[i].size =3D=3D 8;
> +			unsigned int arg_len =3D (wide ? 9 : 8) +
> +				((reg & 7) =3D=3D 4) + (!wide && (reg & 8));
> +
> +			PTW_NEED(arg_len);
> +			*p++ =3D 0xf3;
> +			if (wide)
> +				*p++ =3D (reg & 8) ? 0x49 : 0x48; /* REX.W */
> +			else if (reg & 8)
> +				*p++ =3D 0x41; /* REX.B only (32-bit operand) */
> +			*p++ =3D 0x0f;
> +			*p++ =3D 0xae;
> +			*p++ =3D 0xa0 | (reg & 7); /* mod 10, reg /4, rm reg */
> +			if ((reg & 7) =3D=3D 4) /* SIB escape: base rsp/esp/r12 */
> +				*p++ =3D 0x24;
> +			p +=3D 4;

[Severity: High]
Does this code miss copying the displacement value for the memory access?

The stub generator in arch_uprobe_ptwrite_prepare() for memory fetch argume=
nts
(UPROBE_PTW_SRC_MEM) configures the ptwrite instruction to use a 32-bit
displacement (mod=3D10) and advances the instruction pointer p by 4 bytes.
However, it appears to fail to write the requested user displacement
(desc->args[i].val) into those 4 bytes, leaving them as uninitialized zeroe=
s.

Will the generated uprobe stub execute a memory fetch with a displacement of
0 (e.g., reading [reg + 0] instead of [reg + disp32])? This could cause the
traced application to read incorrect memory, which can lead to capturing
garbage data in the trace or crashing the application with an unintended
SIGSEGV.

> +			break;
> +		}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D6
