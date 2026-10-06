Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E04F93A7
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326727; cv=none; b=br8W+JSsmF335i5w9c5Flw6pEO/k9eSxcno2PXsYawXG99yQAStQRl7UV+Wkhukhm2p90SeD/lRoUSOtPlMePPORHR/Qs89yR8kb6JinBJxa/LwS2kfobHlleISIisiL5Q6EuIov2HAlccxt+BijMqNIbn8qK1oQILX09Gsws+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326727; c=relaxed/simple;
	bh=FLfu4obnGJogG1V1fsQIillv+LOxyJTOAaFpTmopE5g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kjNYYAg7HtPQT4lZtDGM7CEz9YpOFljJneWyZj33Jad+gN2Yv8A+C9q8+I7xxgUrJy6xjHmVdbsF5cDA3O/E76bgaQEPUPqhekZPTteUw6euBwoITSsm+6rhQMq+4e0iP3NAz6CkTxZ7NZ+Ec/gBLYwVi1hxdMw/v4jFAmWBvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDx/xLd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDx/xLd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4001F0089E;
	Tue,  6 Oct 2026 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326696;
	bh=HCmZ6dED556Nw6t6NtjW3L1CDRGQwvWE9UpXsZGM38k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDx/xLd+w3IFX0uMhttfj/6h+TiEGkRYbTlehdlrmNCq1dz4EcsU6bzRuB9R7nSlA
	 1S4qV4XEWmuKoG29/KLJjyqvmSmjpiqMEvVWEhnQLbWaDUlsnMnHxTu6LE2J/vSfPi
	 rx9wu5Nt/n1Z/4WIX6KB/GhwECExzg0ivzlvP8Vgvhw04CMgfQ6sE36ph4enIpreJU
	 +cboeqjTI2yrQIXYflrl58J+g/axVSlDEjiblgxT8xGh9V5fwob57banS+lMMlyl0S
	 wPyeIaVWkTTcvwSRiUUtPJbis6jYg1hs63enpho4DGKONfNBsK6GpeZ/8MSSBhOdnx
	 G5Q6hOWFwv5xg==
Message-ID: <sashiko-outbox-162494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/hw_breakpoint: Avoid leaking private x86
 breakpoint ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyle Zeng" <kylebot@openai.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006222519.43193-1-kylebot@openai.com>
References: <20261006222519.43193-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 22:44:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/hw_breakpoint: memcmp validates uninitialized flag-gated fi=
elds
--

commit 0cb8c384abc8b74fee8923d87b586e123993d285
Author: Kyle Zeng <kylebot@openai.com>

perf/hw_breakpoint: Avoid leaking private x86 breakpoint ranges

This commit addresses a security issue where private x86 breakpoint ranges
can be leaked to unprivileged callers by validating immutable attributes
before parsing a modify request. It also checks x86 kernel-breakpoint
access before consulting private blacklists and validates instruction
lengths early.

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..1f0e7f63ba82c 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
[ ... ]
> @@ -765,10 +765,6 @@ modify_user_hw_breakpoint_check(struct perf_event *b=
p, struct perf_event_attr *a
>  	struct arch_hw_breakpoint hw =3D { };
>  	int err;
> =20
> -	err =3D hw_breakpoint_parse(bp, attr, &hw);
> -	if (err)
> -		return err;
> -
>  	if (check) {
>  		struct perf_event_attr old_attr;
> =20
> @@ -778,6 +774,10 @@ modify_user_hw_breakpoint_check(struct perf_event *b=
p, struct perf_event_attr *a
>  			return -EINVAL;

[Severity: Medium]
Does this memcmp() inappropriately enforce equality on uninitialized, unuse=
d,
and flag-gated fields?

Userspace is not required to zero unused fields in the perf_event_attr stru=
ct.
If a user opens a hw_breakpoint event with uninitialized stack garbage in
unused fields (e.g., sample_regs_user, config2), and later calls
PERF_EVENT_IOC_MODIFY_ATTRIBUTES with a new perf_event_attr to modify bp_ad=
dr,
the new struct may contain different stack garbage.

Since perf_copy_attr() copies the struct verbatim from userspace, this
memcmp() fails when comparing the original and new structs due to the
differing uninitialized bytes. This will spuriously reject valid modificati=
on
requests with -EINVAL.

>  	}
> =20
> +	err =3D hw_breakpoint_parse(bp, attr, &hw);
> +	if (err)
> +		return err;
> +
>  	if (bp->attr.bp_type !=3D attr->bp_type) {
>  		err =3D modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
>  		if (err)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006222519.4319=
3-1-kylebot@openai.com?part=3D1
