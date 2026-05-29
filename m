Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6633B47F0
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043766; cv=none; b=AqwJ12ytnDK+4SNLSC1opsYf7O5BxHNsyNJ7dsVdZuKroaXgxEtE73tJXqg79xD3UqE7jBnCzTCVcLqkFtXW8n8fOfqdDHscFDRG9IHJdxKFD8wXwPP/Uu+CH8nLflJ8FoeelEkInS0hgx2DpYs/FfJLJ/d+IfhLNi5Tl8se9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043766; c=relaxed/simple;
	bh=kfJhQtAX8QVvyVcyegCawM4Lvjz5u8jDKA+ejv1vEUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/5W/SlstJOINzY2FdMUL9P5HXX3JJQ6ke3YkLCWj66ky0/mbOeRFiU+eezp48mjcgoeMtkel0i+yG54UVz9dVmqxC191eo5CP8qqCgWDzout3FXwyeSbTzid5ly1ABjdYxzQVwVxarRwn6or/qIgl8xDkCVdCeI3HqK7DkPL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYWP7oDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYWP7oDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA31F00893;
	Fri, 29 May 2026 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780043764;
	bh=igLCBquf5f9Ps3fauvF8TarRQpQJHcvrSs2fD6kieso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYWP7oDYcbSSQdk5WSnSRBLIXeuc85PurfkTfVLu+uqjL/WipNc0Z/g6RAUhHapby
	 5MPL13AW2D2fZs0WGJ+F3njcFJavgSGMA42uqsWnEL6VkN1t2J8G1a9u9wSRw8KJFp
	 5E8aPX42y9N1n4qsbOPUj762hzsG6AE1GCEXe54z0IXupcFUi3E43wzjiOdf7YANc8
	 HW6xC5aJFxUTg5+9O6Xo22tGJg215FpYLz55JMtj8kNlEOapX2HtV9Sq5fXowaGYNc
	 QzhFiES5GtgTsk5LI7Uip5ehWpUQPnT8q655NKYFTPZfDK9/JPpGs2Nmc+XBbwIZCI
	 gBhPyYByJEAGQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 12/23] perf: Add sampling support for SIMD registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-13-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:36:03 +0000
Message-Id: <20260529083604.21AA31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Missing bounds checking on user-provided SIMD `qwords` fields =
allows an integer overflow of the 16-bit perf event header size, leading to=
 ring buffer corruption and potential NMI lockups.
- [High] SIMD register parameters are evaluated and validated outside of th=
eir respective flag gates, which can falsely reject valid syscalls due to u=
ninitialized memory.
--

commit eeb01562d09b920ab2f41841dd6b7a879ed10465
Author: Kan Liang <kan.liang@linux.intel.com>

perf: Add sampling support for SIMD registers

This commit introduces support for sampling SIMD registers during profiling
by adding new attribute fields to struct perf_event_attr. It adds a new ABI
format to dump the width and values of the requested SIMD registers, using
bitmasks and qword sizes configured by the user.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2ce553db4dcb8..94bb034da9b9d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -8596,6 +8664,33 @@ static __always_inline u64 __cond_set(u64 flags, u=
64 s, u64 d)
>  	return d * !!(flags & s);
>  }
> =20
> +static u64 perf_update_xregs_size(struct perf_event *event, bool intr)
> +{
> +	u16 pred_qwords =3D event->attr.sample_simd_pred_reg_qwords;
> +	u16 vec_qwords =3D event->attr.sample_simd_vec_reg_qwords;
> +	u64 pred_mask;
> +	u64 mask;
> +	int size;
> +
> +	if (intr) {
> +		mask =3D event->attr.sample_simd_vec_reg_intr;
> +		pred_mask =3D event->attr.sample_simd_pred_reg_intr;
> +	} else {
> +		mask =3D event->attr.sample_simd_vec_reg_user;
> +		pred_mask =3D event->attr.sample_simd_pred_reg_user;
> +	}
> +
> +	/* nr_vectors, vector_qwords, nr_pred, pred_qwords */
> +	size =3D sizeof(u64) * 4;
> +	size +=3D (hweight64(mask) * vec_qwords +
> +		 hweight64(pred_mask) * pred_qwords) * sizeof(u64);
> +

[Severity: Critical]
Is there any bounds checking on the user-provided vec_qwords and pred_qwords
fields here?

If userspace provides large values, could the multiplication with the bitma=
sk
weights overflow the 16-bit perf event header size?=20

If the size overflows, would perf_output_begin() allocate a smaller ring bu=
ffer
space than what perf_output_sample_simd_regs() subsequently writes, leading=
 to
an out-of-bounds memory regression in NMI context?

> +	/* Warn if exceeding perf_event_header.size (u16). */
> +	WARN_ON_ONCE(size > U16_MAX);
> +
> +	return size;
> +}

[ ... ]

> @@ -13634,6 +13746,15 @@ static int perf_copy_attr(struct perf_event_attr=
 __user *uattr,
>  		ret =3D perf_reg_validate(attr->sample_regs_user);
>  		if (ret)
>  			return ret;
> +		ret =3D perf_simd_reg_validate(attr->sample_simd_regs_enabled,
> +					     attr->sample_simd_vec_reg_qwords,
> +					     attr->sample_simd_vec_reg_intr,
> +					     attr->sample_simd_vec_reg_user,
> +					     attr->sample_simd_pred_reg_qwords,
> +					     attr->sample_simd_pred_reg_intr,
> +					     attr->sample_simd_pred_reg_user);
> +		if (ret)
> +			return ret;
>  	}

[Severity: High]
When attr->sample_type & PERF_SAMPLE_REGS_USER is true but
PERF_SAMPLE_REGS_INTR is not set, does this validate the _intr fields that
might contain uninitialized garbage from userspace?

Since flag-gated syscall parameters are not required to be zero-filled when
the flag is absent, could evaluating these parameters outside their respect=
ive
flag gates falsely reject valid syscalls due to uninitialized memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D12
