Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6EA2CCB9
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334250; cv=none; b=WXdf+x9gpQSE0mABTu16bAz3XYKwQtsS5Duck0T2qsjSU52cvvQMKS4rpS1YyXKx9fv4FGWrOqtRhvC0h+QaDqGVDcLBbSl1RCmjiUxUwYqeyazT3hybCKqr6qLWpvHM3vC6oW9xd6I2ho3a8DIJbwmeGVtvVILFIU9HpJXs+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334250; c=relaxed/simple;
	bh=i6h2KHd3JeP72E0wdMAWV07yv//i6u0EDwH9Ye/dx5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5X+UtH3gOjwI1RzuaaXfTYArSp0im3KGeZE0B3seLsTf7A3c2i7ELOc7iZHr/6Lixpggvutd3VQOE0rViTAdDZEbm+uL7Z09rYhvUsPS/cJIyvYTnx8HEjC6uwN38is8z/PS3WcWM6QT++eK4TQHyexLkg5oSVbab8P1wAeB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwXDEn13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwXDEn13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05411F000E9;
	Thu, 21 May 2026 03:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779334248;
	bh=4vb9bopg9pWRDYgqFNfqDSOPfK6qqgTSKfgpTg63+v0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwXDEn13P3wYmaHrRjzSMUSto1l2y6Um7yzg4joVJwPEC3IVX2+70j7ygY0T8b4qd
	 l25daCcMnMR7j6esPRK8SVL1596bpJMqZmviBJD1aA3y5uOCHD8xfZpcbC84Ld3WYD
	 ZKHy8IWuqkC3/eVQ2EnjblbUApJ9MZLU2n4mLc4NFpO3j9DYv7Xs+9FjU13gjYofQI
	 SctblSCoYKLIMwHA55mRmVSpSyKNYf7lrMbJeiS73M03wQcIceMBqn5yCFUYZh8cER
	 anIc7mRq/8FUFQ9b7qN9BFQ1XXyRavJOUO/sLMPl/PThBx+22PDxvLoghDL56UudoQ
	 ax8T/+qoTEsWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/xe: gate observation streams with
 perf_allow_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521024904.331912-3-jhubbard@nvidia.com>
References: <20260521024904.331912-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 03:30:48 +0000
Message-Id: <20260521033048.C05411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Unconditional call to `perf_allow_cpu()` causes a build failure whe=
n `CONFIG_PERF_EVENTS` is disabled.

Pre-existing issues:
- [High] Reference count leak of `xe_exec_queue` on the error path in `xe_o=
a_stream_open_ioctl()`.
- [High] Memory leak of the `stream->syncs` array when an OA stream is disa=
bled or fails to emit config.
--

commit c928d2e2efb93b79ed4af6b5c4bcf6b62b0a9acb
Author: John Hubbard <jhubbard@nvidia.com>
Subject: drm/xe: gate observation streams with perf_allow_cpu()

This patch introduces xe_observation_paranoid_check() to replace open-coded=
=20
privilege checks in the xe driver. It wraps perf_allow_cpu(), meaning xe=20
observation now respects the system-wide kernel.perf_event_paranoid policy=
=20
and the security_perf_event_open() LSM hook.

> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index 6337e671c97ae..f15847be01bc2 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
[ ... ]
> @@ -2052,10 +2053,12 @@ int xe_oa_stream_open_ioctl(struct drm_device *de=
v, u64 data, struct drm_file *f
>  		privileged_op =3D true;
>  	}
> =20
> -	if (privileged_op && xe_observation_paranoid && !perfmon_capable()) {
> -		drm_dbg(&oa->xe->drm, "Insufficient privileges to open xe OA stream\n"=
);
> -		ret =3D -EACCES;
> -		goto err_exec_q;
> +	if (privileged_op) {
> +		ret =3D xe_observation_paranoid_check();
> +		if (ret) {
> +			drm_dbg(&oa->xe->drm, "Insufficient privileges to open xe OA stream\n=
");
> +			goto err_exec_q;
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, but does this code leak the xe_exec_queue
reference on the error path?

Looking earlier in xe_oa_stream_open_ioctl():

    param.exec_q =3D xe_exec_queue_lookup(xef, param.exec_queue_id);
    if (XE_IOCTL_DBG(oa->xe, !param.exec_q))
        return -ENOENT;

    if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1))
        return -EOPNOTSUPP;

When the execution queue width is greater than 1, it directly returns
-EOPNOTSUPP instead of jumping to the err_exec_q label. This bypasses
xe_exec_queue_put() and leaves the reference incremented, which could allow
a malicious user space program to repeatedly leak execution queue reference=
s.

[Severity: High]
This isn't a bug introduced by this patch, but does the stream opening
process leak the stream->syncs array if the stream is disabled?

When xe_oa_stream_open_ioctl() calls xe_oa_stream_open_ioctl_locked(), the
stream->syncs array is allocated via xe_oa_parse_syncs(). This array is
usually freed inside xe_oa_emit_oa_config() when the stream is enabled.

If a stream is opened with the disabled parameter set to true,
xe_oa_enable_locked() is skipped, and xe_oa_emit_oa_config() is never
called. When the stream is subsequently destroyed upon file release,
xe_oa_stream_destroy() does not appear to free stream->syncs, which might
result in a memory leak.

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_observation.c b/drivers/gpu/drm/xe/xe_=
observation.c
> index e3f9b546207e4..39e05b9131a74 100644
> --- a/drivers/gpu/drm/xe/xe_observation.c
> +++ b/drivers/gpu/drm/xe/xe_observation.c
[ ... ]
> @@ -12,9 +13,28 @@
>  #include "xe_oa.h"
>  #include "xe_observation.h"
> =20
> -u32 xe_observation_paranoid =3D true;
> +static u32 xe_observation_paranoid =3D true;
>  static struct ctl_table_header *sysctl_header;
> =20
> +/**
> + * xe_observation_paranoid_check - Gate access to xe observation streams.
> + *
> + * When the xe-specific observation_paranoid sysctl is enabled (the
> + * default), defer to perf_allow_cpu() so that access is governed by the
> + * same policy as system-wide perf CPU events: kernel.perf_event_paranoid
> + * plus the security_perf_event_open() LSM hook. When the sysctl has been
> + * cleared by a privileged user, observation is open to all callers.
> + *
> + * Return: 0 if access is permitted, a negative errno otherwise.
> + */
> +int xe_observation_paranoid_check(void)
> +{
> +	if (!xe_observation_paranoid)
> +		return 0;
> +
> +	return perf_allow_cpu();
> +}

[Severity: Low]
Will this cause a build failure when CONFIG_PERF_EVENTS is disabled?

The function perf_allow_cpu() is only defined if CONFIG_PERF_EVENTS is
enabled, and there is no fallback stub provided in
include/linux/perf_event.h for the disabled case. Since the DRM_XE
subsystem does not strictly depend on CONFIG_PERF_EVENTS, building the
driver without perf events support might result in an undefined reference
linker error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521024904.3319=
12-1-jhubbard@nvidia.com?part=3D2
