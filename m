Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE23612F1
	for <linux-perf-users@vger.kernel.org>; Sat, 23 May 2026 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502825; cv=none; b=PETeyybXpNtOcV5+ESnyN3RriOnrrwXjtgqMFamafAU/ST90ipA9vMPPyWM3RL3QmDXsVC6nv1+x52FDtAG98mD3J6rZyiQGyaPAJNXWv4SoBlmLGBSrGaaoFUe23Y3Jn6S3UKg5Bt516+zpWo65Vz/CNGC7Ccr10cXH9wcr80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502825; c=relaxed/simple;
	bh=fbgIiFpM46sJDuMbkCjb07TKNrNTVUN1BZt/Ro2CLP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ifr+3F8IR/krfDZIfbF+7kKrt2LG/xv0wnABvuF/sQ2gW0CQ+77bDd68jf2O2J7nLPR+SogEXtgyVd9X1rGWSiCjcwfnYEbaEQeVTIO9pMby6HTRsjuX/VtChtPxZGT9xMhuggYxVfzni/p2tRj2Ld1yAp3g1nLklcj3qU0H4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyTyvPNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyTyvPNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E766E1F00A3A;
	Sat, 23 May 2026 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502823;
	bh=5aITw/IdWXS97jD7Stj3bA2g0kSs0UuhZEhPnJm+7Ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QyTyvPNmaRkD7gHoVbhVYHyZwxx7XbRVxqiguuT+LcmIiZt2uVNh5x0oxmhU03RGW
	 KDyzkz7Nikk2J9qgm9D1fMINRizAwRH36zjoNcd1/DH21Tyw6d5PXh9UlsB8FF2b12
	 YBsarz41x8DO5spcL1fGmf/zsLayUHQNA8SQkL49mZBP7mVh7dEDIEwVbrZnDX4YVP
	 YF+mtV6JRXUzNJzgs/a00GEcxE7Gvs7HxYcAYPwCzXdm4OrYC6Vi5lglVWLB9wIb7g
	 vfriO7W+h8zQRrDpsWTbCXrfNgcUShlcfYg883IOyXpjj/8p+HezwS5I5nn05gb5NH
	 asiFD6Q8ItELw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/xe: gate observation streams with
 perf_allow_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260523013326.129491-3-jhubbard@nvidia.com>
References: <20260523013326.129491-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 02:20:22 +0000
Message-Id: <20260523022022.E766E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Reference leak of `xe_exec_queue` when the execution queue width i=
s unsupported.
- [High] Failure in `idr_alloc()` leads to a leaked sysfs group and a subse=
quent Use-After-Free of `oa_config`.
- [High] Exposing file descriptor to user space before acquiring device ref=
erence leads to potential Use-After-Free.
--

commit 8e3552a6815565ba8e84e67fba6937312f269a6f
Author: John Hubbard <jhubbard@nvidia.com>
Subject: drm/xe: gate observation streams with perf_allow_cpu()

This commit introduces xe_observation_paranoid_check() to wrap
perf_allow_cpu() and converts the open-coded sites in xe_oa.c and
xe_eu_stall.c. It ensures xe observation consults kernel.perf_event_paranoid
and the LSM perf hook on every open.

> diff --git a/drivers/gpu/drm/xe/xe_eu_stall.c b/drivers/gpu/drm/xe/xe_eu_=
stall.c
> index c34408cfd292c..a1fd7dace0a61 100644
> --- a/drivers/gpu/drm/xe/xe_eu_stall.c
> +++ b/drivers/gpu/drm/xe/xe_eu_stall.c
[ ... ]
> @@ -963,9 +963,10 @@ int xe_eu_stall_stream_open(struct drm_device *dev, =
u64 data, struct drm_file *f
>  		return -ENODEV;
>  	}
> =20
> -	if (xe_observation_paranoid && !perfmon_capable()) {
> +	ret =3D xe_observation_paranoid_check();
> +	if (ret) {
>  		drm_dbg(&xe->drm,  "Insufficient privileges for EU stall monitoring\n"=
);
> -		return -EACCES;
> +		return ret;
>  	}
> =20
>  	/* Initialize and set default values */

[Severity: High]
This is a pre-existing issue, but is there a potential use-after-free
if anon_inode_getfd() is called before drm_dev_get() in the locked stream
open functions (like xe_eu_stall_stream_open_locked)?

If anon_inode_getfd() exposes the file descriptor to user space, it becomes
immediately visible. If a concurrent thread calls close() on the new fd
before drm_dev_get() increments the device refcount, the release handler
will drop a device reference prematurely.

Could this potentially free the DRM device while the original thread resumes
and calls drm_dev_get()?

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
> =20
>  	if (!param.exec_q && !param.sample) {

[Severity: High]
This is a pre-existing issue, but does this function leak the xe_exec_queue
reference?

Earlier in the function, if param.exec_q->width > 1, it directly returns
-EOPNOTSUPP:

if (param.exec_queue_id > 0) {
    ...
    param.exec_q =3D xe_exec_queue_lookup(xef, param.exec_queue_id);
    ...
    if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1))
        return -EOPNOTSUPP;
}

This bypasses the err_exec_q label which is responsible for calling
xe_exec_queue_put(param.exec_q).

Since this happens before the privilege check, could an unprivileged user
repeatedly trigger this to exhaust kernel memory?

[ ... ]
> @@ -2334,9 +2337,10 @@ int xe_oa_add_config_ioctl(struct drm_device *dev,=
 u64 data, struct drm_file *fi
>  		return -ENODEV;
>  	}
> =20
> -	if (xe_observation_paranoid && !perfmon_capable()) {
> +	err =3D xe_observation_paranoid_check();
> +	if (err) {
>  		drm_dbg(&oa->xe->drm, "Insufficient privileges to add xe OA config\n");
> -		return -EACCES;
> +		return err;
>  	}
> =20
>  	err =3D copy_from_user(&param, u64_to_user_ptr(data), sizeof(param));

[Severity: High]
This is a pre-existing issue, but does a failure in idr_alloc() lead to a
leaked sysfs group and a use-after-free?

Later in this function, create_dynamic_oa_sysfs_entry() creates a sysfs
group linked to oa_config. If the subsequent idr_alloc() fails:

    err =3D create_dynamic_oa_sysfs_entry(oa, oa_config);
    ...
    oa_config->id =3D idr_alloc(&oa->metrics_idr, oa_config, 1, 0, GFP_KERN=
EL);
    if (oa_config->id < 0) {
        ...
        err =3D oa_config->id;
        goto sysfs_err;
    }

The code jumps to sysfs_err and frees oa_config via xe_oa_config_put(),
but it does not call sysfs_remove_group().

Can user space read the remaining sysfs files to trigger show_dynamic_id(),
dereferencing the freed oa_config?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523013326.1294=
91-1-jhubbard@nvidia.com?part=3D2
