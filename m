Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322591E1024
	for <linux-perf-users@vger.kernel.org>; Sat, 23 May 2026 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501086; cv=none; b=PDNdKKuZOwog1KI5OTX+blunk/UoVZfjhn3WIbyQc9dPTQqVvWPwIaNCDubf22odoFsYysCf5WeCQiWaAcuD3q3TeqnH6jKknNCqYKm73JtRX/TdKq+0R1Ys35vj59aO9sGWdDd59qaJm4GoSAbmeHJ79BpXKhUNNMUVgrJAPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501086; c=relaxed/simple;
	bh=uRb+1HsbDYOa9CKKB40nvPJt26Ys/DAwU8Vt+gh9MiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEgvxzebX8JansV/ScIUpyA5Ow3ms2MyeNmegA7NX25j6cgVtq5wMIPi/iZRY83RC6+fmdxJFzDN0YhqFdyFzWQZf1qL8arde/h/hzGjqzdJJhuiXIEgLsvie9ZAShzKHRLi3Y8Ks/lvyAF/KUpE1DHylypO/u6MDyLgxUQ8PEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW2yL9lx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW2yL9lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC1E1F000E9;
	Sat, 23 May 2026 01:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779501084;
	bh=C1jbZkJMkojcPmxVX+KjgXSA1B//KnwUAprhyZAu7UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lW2yL9lx0I9lBESIKBTgalopI8V3CePq4krxhfUx26vrTXeq0urqDWGoyGQsidVIF
	 6kyiZZKMDC2gdAgDo1v4bi7SAsnLktwwBswbPtn4WwBaQZ76uOmlBtRB/3evCI+Lgv
	 X6mbPpwHUt9ihY44ecrgGynNsyWKCh6W96wX7mmU1mar0sDAhS4HNVAgtVl0XRsYL8
	 uIzGcBEXHH3dQnA2sxwNCFV2osVwbf4irMDewY/iR2PQpbrUU36W9OBCJFBAyZgyby
	 uZozJ0rPMPcepPud0wc+sTiNuD0BJPUV4zkloLc92yTAMP8l/M+Gi0605eHUHKPPPV
	 mSii1/ZbvAQZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf/core: out-of-line and export
 perf_allow_cpu/tracepoint()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260523013326.129491-2-jhubbard@nvidia.com>
References: <20260523013326.129491-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 01:51:23 +0000
Message-Id: <20260523015124.6EC1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The variable `v` used to store the event index is inadvertently ov=
erwritten by the return value of `perf_allow_cpu()`.
--

commit 4a1ba4712c8f6d5b5cbf8536fff7c0deb0a5c8b7
Author: John Hubbard <jhubbard@nvidia.com>

perf/core: out-of-line and export perf_allow_cpu/tracepoint()

This commit moves perf_allow_cpu() and perf_allow_tracepoint() out of
the perf_event.h header and into kernel/events/core.c. It exports them=20
with EXPORT_SYMBOL_GPL to allow modular code to access these permissions=20
checks, matching the behavior of perf_allow_kernel(). It also provides=20
stubs for when CONFIG_PERF_EVENTS is disabled.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c5..735e502beb966 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -14691,6 +14691,24 @@ int perf_allow_kernel(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_allow_kernel);
> =20
> +int perf_allow_cpu(void)
> +{
> +	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
> +		return -EACCES;
> +
> +	return security_perf_event_open(PERF_SECURITY_CPU);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the usage
of perf_allow_cpu(), I noticed a pre-existing issue in the p4 PMU code.

Does this overwrite the event index v? Looking at p4_validate_raw_event()
in arch/x86/events/intel/p4.c, v is used to index into p4_event_bind_map,
but it appears to be overwritten by the return value of perf_allow_cpu():

arch/x86/events/intel/p4.c:p4_validate_raw_event() {
    ...
	if (p4_ht_active() && p4_event_bind_map[v].shared) {
		v =3D perf_allow_cpu();
		if (v)
			return v;
	}

	/* ESCR EventMask bits may be invalid */
	emask =3D p4_config_unpack_escr(event->attr.config) & P4_ESCR_EVENTMASK_MA=
SK;
	if (emask & ~p4_event_bind_map[v].escr_emask)
		return -EINVAL;
    ...
}

If perf_allow_cpu() returns 0 for success, does this mean v becomes 0, and
the subsequent check uses p4_event_bind_map[0].escr_emask instead of the
intended event mask?

Could this allow users to bypass proper event mask checks and program inval=
id
hardware ESCR bits?

> +EXPORT_SYMBOL_GPL(perf_allow_cpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523013326.1294=
91-1-jhubbard@nvidia.com?part=3D1
