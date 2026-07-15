Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537E399D0B
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080834; cv=none; b=W4vcoDUo4MqjbsPEaS55s6uBKbxIRECJU+FkItTzT2Pwt4ABY2+OljHkfCv9DIn6wAFB6O9Ok7oMrvlnAksCr5hj4B82NK1kz2wk93kLri8hyQMUYZBFrv9FJR3ddIhW5S/dAseElk1mYVatK3B1y/tSjxd8nsNbo9Ar0/L13pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080834; c=relaxed/simple;
	bh=8/opBhiWa87p1Lmds8KcDNAcmfdnwgQQPtKFv+zLk48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JB/zshu13RLJlaXYxAZAjnMpxIA0V6yUY2LG5CiiyZxjJ79UpLpJjJ+vvnz7XURbz9bPhRXy/PgfDw//BpislF2uf8HjZjH5KeqjTA/jqyvGlYk5bvIsQhzoYm5FEqGQMTT14GyGQFB80Q8AJiWe879S5WXRXjA/QPUTxu4Vqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7+uPhjc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7+uPhjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001671F000E9;
	Wed, 15 Jul 2026 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080833;
	bh=+7aH3XZDlAMmY2UbtB0lGCJ4QV29HkBc2JVt4Whyzc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d7+uPhjcPRkSm3kJ/FSDLu79KV0Wu2146N/K8XmLFx8sRc/oncSg7GiaO0gthji+R
	 mBYqyPzZld1pN8TZxA30KrnPBk9PNn+9IPcamRM4NayUBZ21dAXosZFvdFf+EMXl9u
	 pYrDfUBCzEvR8Qe1BIEZJZJVRhEqTQEZ8NoZhhtJjsJ7sFZbGsrrJU9Bb6fpZxTq62
	 6p8JUD3a2n3TnLKkvJPkLtRT2ydcZdJJTPVOb289Uq1grK3ubW/HEiMW2Ty3CqBo0i
	 08fSG36CrfZH4vV5y2oxn0EHpAWVP6PqBIkr1LSxoKsJMUQGxbcTJX3wtNYEBYlcit
	 qVBejgIwCapGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] HWBP: Add modify_wide_hw_breakpoint_local()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407993140.95826.16095381350026536181.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407993140.95826.16095381350026536181.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:00:32 +0000
Message-Id: <20260715020033.001671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] State Corruption on Error Path during breakpoint modification
- [High] Hardware Register Corruption (DR7 missing bit clear) on Reinstall
- [Medium] Inconsistent Software State after breakpoint modification
- [Medium] Race Condition with Debug Exception Handlers during in-place mod=
ification
--

--- Patch [8]: [PATCH v7 08/10] HWBP: Add modify_wide_hw_breakpoint_local()=
 API ---
commit e82221932a08cae24063fb7cb3fe49f250391aa5
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

HWBP: Add modify_wide_hw_breakpoint_local() API

This commit adds the modify_wide_hw_breakpoint_local() arch-wide interface
which allows hwbp users to update watch addresses on-line. It reuses the
current hardware breakpoint slot without releasing and reserving it, meaning
type changes are only allowed between compatible types.

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..4337688da3976 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c

[ ... ]

> @@ -888,6 +888,45 @@ void unregister_wide_hw_breakpoint(struct perf_event=
 * __percpu *cpu_events)
>  }
>  EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
> =20
> +/**
> + * modify_wide_hw_breakpoint_local - update breakpoint config for local =
CPU
> + * @bp: the hwbp perf event for this CPU
> + * @attr: the new attribute for @bp
> + *
> + * This does not release and reserve the slot of a HWBP; it just reuses =
the
> + * current slot on local CPU. So the users must update the other CPUs by
> + * themselves.
> + * Also, since this does not release/reserve the slot, this can not chan=
ge the
> + * type to incompatible type of the HWBP.
> + * Return err if attr is invalid or the CPU fails to update debug regist=
er
> + * for new @attr.
> + */
> +#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
> +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> +				    struct perf_event_attr *attr)
> +{
> +	int ret;
> +
> +	if (find_slot_idx(bp->attr.bp_type) !=3D find_slot_idx(attr->bp_type))
> +		return -EINVAL;
> +
> +	ret =3D hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));

[Severity: Medium]
Is it safe to mutate the active hardware state structure in-place while the
hardware breakpoint is still active? If a debug exception (#DB) triggers on
the same CPU during this non-atomic update, could hw_breakpoint_handler()
read a partially updated bp->hw.info and generate flawed samples?

[Severity: High]
Could this corrupt the active state on error paths? By passing the active
hardware configuration pointer via counter_arch_bp(bp) directly, the
architecture parser mutates it in place.

For example, in arch_build_bp_info() on x86, if length or type is updated
but a subsequent alignment check fails, we return an error but leave the
active struct partially modified. When the breakpoint is later uninstalled,
could this use the corrupted length/type to mask out DR7, leaving residual
bits that permanently corrupt the slot?

> +	if (ret)
> +		return ret;
> +
> +	bp->attr.bp_addr =3D attr->bp_addr;

[Severity: Medium]
Does this leave the logical perf_event attributes disconnected from the
hardware configuration? The parser updates the hardware state to reflect the
new type and length, but we only copy attr->bp_addr here. Should this also
update bp->attr.bp_type and bp->attr.bp_len?

> +
> +	return arch_reinstall_hw_breakpoint(bp);

[Severity: High]
Can reinstalling the breakpoint without clearing the old hardware state
corrupt the debug registers? When arch_reinstall_hw_breakpoint() invokes
setup_hwbp() on x86, it ORs the new length and type bits into DR7:

arch/x86/kernel/hw_breakpoint.c:setup_hwbp()
    if (enable)
        dr7 |=3D encode_dr7(slot, info->len, info->type);

Since we did not disable the breakpoint first, won't a bitwise OR of the
old and new encoded values produce an invalid configuration?

Additionally, if the new configuration sets info->mask to 0, setup_hwbp()
skips resetting the hardware mask MSR because it evaluates if (info->mask).
Could this leave the old mask permanently active?

> +}
> +#else

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D8
