Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC461303C8A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639303; cv=none; b=NxkoCC3cbZN+361QEZWFw+q4fFvn5Xh+maCzFlnfzLgpTVPJF+0C/m7eALeM4kWEFpT93dV31mTNYMZzW7VcNNNwvURcAxx+PqCrNuc4NDHElTQjk9SvlkkV3NvcqWWvbeW7QI9OCU5X/qBI/xc2GYVMk58XHrVXn587UxNbsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639303; c=relaxed/simple;
	bh=dnPZlcRJOBz5xsoV5cdpPMGsngAN77C5WkYDf0kK/C4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pEyAlqythqKSRsvSxIEj427GUGo5EKA0GwXCbFR7TmpBU6j/aKEf+9CmddQVAbeMxL1ukgVtrPYfxNe72v//nckMaYOp2cAhLKAlOGoNEsxeXhAXd4HZbYGusaDPC5HuSBTajunRjCZ9gVDBIs/IJXHTMBvj+MBbuuiSrK3/P7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQTD8s49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQTD8s49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D5B1F000E9;
	Tue, 16 Jun 2026 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639302;
	bh=FJcmmWFzYuS0wMv0l6v+dhpGdz/CEiWcpPwPHZ31UL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lQTD8s49ZVCueFEOMZwyG5xW2YGJmNC3rJ96WhfBwb8SzGtvFbvosjB8X9fPLFSqy
	 Z26Fo7ZqOgcsrkz95AUwAnkaQ3Z1TtKbhu8wwDQD4oavg8MNOaVo57Z5SovtuNQewk
	 G1rtgboW+KyWI1kNTmGn8LjTU7AUi/2sklnqVwHD3VTHq/kZQJ5OxrDGi5sHW7a9F+
	 /RQHoG+DGzukoAMdLcv/x+Ht1actRyzFo53aYPlbMKd70zANruh7/gb3/8Vhnlk1Xd
	 VWcZPtF0qwjT4Hy+Q/VmFxPscxw6ajnQzSFtCvyU4VTHkJOi6ZeMwXfRWBghzYhd/n
	 o8hSEAUUpBRIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf cs-etm: Validate num_cpu before metadata
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616193033.10035-4-acme@kernel.org>
References: <20260616193033.10035-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:48:21 +0000
Message-Id: <20260616194822.22D5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insufficient bounds checking during per-CPU metadata parsing allow=
s out-of-bounds reads and potential info leaks.
--

commit 473102d55bf7bd2e3011265b42ca3a3d07213392
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Validate num_cpu before metadata allocation

cs_etm__process_auxtrace_info_full() reads num_cpu from untrusted
perf.data and uses it to allocate the metadata pointer array. On 32-bit,
this can overflow the multiplication and cause a zero-sized allocation.
This patch computes priv_size early and uses it to bound num_cpu to prevent
out-of-bounds writes.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0927b0b9c06b1..d121c8f22028d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3431,6 +3431,18 @@ int cs_etm__process_auxtrace_info_full(union perf_=
event *event,
>  	/* First the global part */
>  	ptr =3D (u64 *) auxtrace_info->priv;
>  	num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> +
> +	/*
> +	 * Bound num_cpu by the event size: the global header consumes
> +	 * CS_ETM_HEADER_SIZE bytes, and each CPU needs at least one u64
> +	 * metadata entry after that.
> +	 */
> +	priv_size =3D total_size - event_header_size - INFO_HEADER_SIZE -
> +		    CS_ETM_HEADER_SIZE;
> +	if (num_cpu <=3D 0 || priv_size <=3D 0 ||
> +	    num_cpu > priv_size / (int)sizeof(u64))
> +		return -EINVAL;
> +
>  	metadata =3D zalloc(sizeof(*metadata) * num_cpu);
>  	if (!metadata)
>  		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does the per-CPU metadata
parsing loop still allow out-of-bounds reads when processing crafted
perf.data files?

While this patch bounds num_cpu, the subsequent parsing loop repeatedly
calls cs_etm__create_meta_blk(). This function advances the parse index
based on an untrusted length read directly from the payload:

tools/perf/util/cs-etm.c:cs_etm__create_meta_blk() {
    ...
    } else {
        /* read version 1 info block - input and output nr_params may diffe=
r */
        /* version 1 has 3 common params */
        nr_cmn_params =3D 3;
        nr_in_params =3D buff_in[i + CS_ETM_NR_TRC_PARAMS];
    ...
    /* adjust in offset by number of in params used */
    i +=3D nr_in_params + nr_cmn_params;
    *buff_in_offset =3D i;
    return metadata;
}

The updated index is then used in the next loop iteration without being
checked against the bounded priv_size:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
    for (int j =3D 0; j < num_cpu; j++) {
        if (ptr[i] =3D=3D __perf_cs_etmv3_magic) {
            metadata[j] =3D cs_etm__create_meta_blk(ptr, &i, ...);
        } else if (ptr[i] =3D=3D __perf_cs_etmv4_magic) {
            ...
        } else {
            ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". =
...\n",
                      ptr[i]);
            err =3D -EINVAL;
            goto err_free_metadata;
        }
    ...
}

Could an excessively large or negative value for nr_in_params cause arbitra=
ry
forward or backward out-of-bounds reads when evaluating ptr[i]?

If the out-of-bounds memory does not match a recognized magic number,
ui__error() prints the memory directly to stderr, which could potentially
leak heap memory or trigger a segmentation fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616193033.1003=
5-1-acme@kernel.org?part=3D3
