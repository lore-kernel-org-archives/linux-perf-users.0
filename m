Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6123DB96F
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327526; cv=none; b=Ej2wI/gHv7CnqkxQNuxZhEQL1UEOqiA22y/rEbYUQY6RGXaWKIIiyTuvT3qw7uWa82KOMSgS82N/CFXQ0LwJ0IaS6lS64k4FFInl3mIllwgWNNNx+ZsCpd2+rTHCQ7nK3Jj2IluStNHKm+ir3+PF+HcuoTr2uTPFSOeuNL/JOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327526; c=relaxed/simple;
	bh=guvhieK4BrBzqqkCi8XLV/gqqc/oOKsQJJGlp63kahc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Hm49D9LcWe2H3+XsSBCb+b3QmFzDQmTG2DfqtHskHzXp+p/RW0+pd4tXVW2znKODi4Nfz/kQRI10ZxRH1IUpdr0xLGRiNMhpljEiXLpZ3nWRoo8DhBSYHnIwRJEjSfLYNQ/gsWndxl2Re0fPbgQL56MJPQDIIyz9CJlrwnONpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgSkXqvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgSkXqvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555361F0089B;
	Tue,  6 Oct 2026 22:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327526;
	bh=K7EmDM76txV0y1r0YKX3+OWvVqJrz3bOY8L5UB1ObBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgSkXqvdMsK5sLrrU3FHmqQH8IJbhKRocCSvmxXLBsfW8Sz/tPtH+uw2ns70fUcrO
	 F/BAUSll3tlDUoj9EaLxHLBKuKXQ4qCZIGJ2WOS1FGI2UW2kKoYexxbYBQQZvueKuP
	 9ym8Lx+Nbn5ROnA12fDcNEOzdp9i0FXnqnj2PB0A/uRZAMiOFYF0J/4Av7UcDcY7W0
	 cSGGlcMzp8n4P/H2enxx8LC31/Tc65dKuCKMP3gJtsxKvY1D0DxIqPmuRPMFbThuRr
	 RIFEnZcZPlOstBvfBNar16VJBWaDRHmn9y4WTnmAdOGr+QZs0+H2xQFUEX/Cop4vkX
	 bXzw/yEl3hOVA==
Message-ID: <sashiko-outbox-162499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Require kernel access for page-size samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyle Zeng" <kylebot@openai.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006225033.53296-1-kylebot@openai.com>
References: <20261006225033.53296-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 22:58:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PERF_SAMPLE_CODE_PAGE_SIZE and PERF_SAMPLE_DATA_PAGE_SIZE translate a
> sampled virtual address using the current task's page tables, including
> kernel mappings.  exclude_kernel only filters the execution mode of the
> sample; it does not establish that the address being translated belongs
> to userspace.
>=20
> For example, an unprivileged tracer can put a kernel address in a
> tracee's saved IP at a syscall-entry stop.  A following syscall perf
> tracepoint still sees user-mode registers and reports the page size at
> that address.  The distinction between unmapped and mapped addresses
> can disclose the randomized kernel image base even at
> perf_event_paranoid=3D2.
>=20
> Require perf_allow_kernel() for both page-size sample types, as is
> already done for PERF_SAMPLE_PHYS_ADDR.  This applies the existing perf
> and LSM authorization policy before the event is created, independently
> of the source or representation of the sampled address.  Authorized
> page-size sampling and events that do not request these translation
> fields are unchanged.
>=20
> Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
> Fixes: 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SI=
ZE")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006225033.5329=
6-1-kylebot@openai.com?part=3D1

