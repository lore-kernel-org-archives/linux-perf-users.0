Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817587;
	b=ysGPtFPr9l1Qj3YqQV378IY7IlFVT7qed4BIzgBgwEN8s03bHGZXgULGcbrtsAGqTR9Q
	 r+ZiVJa9GQ34rkrIxWpJLgz6wHRW3ZRRyOgUBTItGHG7OArL16tT9xwAPhHTC2yUitfhm
	 1GMW7oz5C+38vMz/5TtahRMBNYbB+3vDBgawjDb5noSc8+EWjCzZ5R1jXn+mS0kXOtrE7
	 RljfG8u0vBM5zm8+ayC24wlgFUBdAFOUnHFCrjQojeh4MzZ9Fjzu9qH+7MadhX/6jnv3F
	 yPZZe9KzS0HuGn+8/op1ndEmFIgoSYNpB8clZSSSNYPp4s00rjrplEhCJzbMzhgGSIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vsehUs2P1+pXDxx3gq2LzgWUZ10DpAYNe02LkeVlUNg=;
	b=Y8rz/7Ki6P9uUZM7iy+EvSMeIACrIuPAcybe8ndAsvRO50p+nD/0obJmKaRC7McdRyLD
	 dsl1el7dd9yrF1OkwaRbc5mEcGFVBD2urJI1hPagT3w8Z76HOgzfnSibnoRv+yfj5bZQP
	 XCLSOghVjupKzp+pXta6TCYN0C/c7hMjYgnxWE9gCMd76GKKuBDLJOD4/6I3d+RWl30Sa
	 WSkvan/oL5R4H4n9C9/N85CrdkkrCazvWp2LMszzZyikJu19prieFvsQVgS19th+pPpTO
	 4A4KiqKJ+QRg2zoWxTemk3O6I9J+ESFo51FGZwYrEYcnMdoLiNw42v9kSnxDE6OZyFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UN/276QQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2D606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UN/276QQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7611F000C4;
	Mon, 16 Nov 2026 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794817586;
	bh=vsehUs2P1+pXDxx3gq2LzgWUZ10DpAYNe02LkeVlUNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UN/276QQiYWrQM7XoizMVc1sdszUNL5wz+r6wQ5mdCVsv2eDTaG6QkJXcrJGYJT4f
	 B1fkcvlS2nxtHL+4mdNqfkEMo+Lk38wphfP20nNfB+qZBQ+JRc74pCQGx6IwZkSdwO
	 1q9E9jv0xpdvXimXUa1p8dj+HS9BO+fWdxwxBk1aapYUIVPb98czaXXK7edHY4QU5l
	 hYdOZYgBBC0SSY700n7flaja2bxyJrpFuytp9DXeyEeEGq4IEG8cL/6ynGKtTymitg
	 LnKJlDnnoITInxkcez0CdlIF0LXRt8inxjEO70up3tpgoVN6Yw7LesxRUjkjs7X2nG
	 B/IxIt0jbs2+w==
Message-ID: <sashiko-outbox-216527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Reject group leaders detached by CPU hot-unplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Wade" <danjwade95@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116081248.21059-1-danjwade95@gmail.com>
References: <20261116081248.21059-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:26:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] perf/core: KASLR bypass via attr.ksymbol in
  sys_perf_event_open() [1]
--

commit c3cb272ab78e2aa66bba3e8476259e9d9e767fba
Author: Daniel Wade <danjwade95@gmail.com>

perf: Reject group leaders detached by CPU hot-unplug

This commit rejects group leaders that are no longer attached to a context =
in
perf_event_open() so siblings cannot be added to leaders detached by
hot-unplug.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 614f9f0e65005..8c2ae7d082d68 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14288,6 +14288,18 @@ SYSCALL_DEFINE5(perf_event_open,
>  			goto err_locked;
>  		}
> =20
> +		/*
> +		 * Likewise against CPU hot-unplug, which detaches the events
> +		 * of a CPU context and breaks up its groups without putting
> +		 * them in a terminal state. perf_group_detach() does nothing
> +		 * for a leader that is already detached, so a sibling added
> +		 * to one would stay linked to it after the leader is freed.
> +		 */
> +		if (!(group_leader->attach_state & PERF_ATTACH_CONTEXT)) {
> +			err =3D -ENODEV;
> +			goto err_locked;
> +		}

[Severity: Critical]
This problem wasn't introduced by this patch, but shouldn't the
perf_allow_kernel() check earlier in perf_event_open() also cover
attr.ksymbol and attr.bpf_event [1]?

An unprivileged user can open an event with exclude_kernel=3D1 alongside
ksymbol=3D1 or bpf_event=3D1 to bypass perf_allow_kernel():

kernel/events/core.c:SYSCALL_DEFINE5(perf_event_open) {
    ...
	if (!attr.exclude_kernel || attr.text_poke ||
	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
	     !attr.exclude_callchain_kernel)) {
		err =3D perf_allow_kernel();
		if (err)
			return err;
	}
    ...
}

When perf_event_ksymbol() or perf_event_bpf_event() later broadcasts sideba=
nd
records via perf_iterate_sb(), perf_event_ksymbol_match() and
perf_event_bpf_match() only test event->attr.ksymbol and
event->attr.bpf_event without checking exclude_kernel, leaking raw kernel
symbol and trampoline addresses to unprivileged users.

[1] https://sashiko.dev/#/bug/linux-8c1072ab-5584-4983-bcd9-f12f87444ea2

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116081248.2105=
9-1-danjwade95@gmail.com?part=3D1
