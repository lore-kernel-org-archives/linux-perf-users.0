Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF315331EC0
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195616; cv=none; b=P9VRAiWiD2kQqZw08JoF07KXNW+tZ9xmKWSlEdT2Doyv0ySDIY/QUcs5y5B+io5OQSsYyAmzaKXJYMpn7+us2wTbGtMJCGL7I7VPYo+TjAAGayXp1i+XhKpbQ5r7g96nHritXL1bgNHOILt3831m+M+rLIBkUWeWs6y+jh66dTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195616; c=relaxed/simple;
	bh=sHAV8ZnWiFMESqm7oQvknMG7F+vzWCrb/sW7O3ZOhZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lvbbru7SQAbDYj4IQnsg76ctXOqxYiXzUZuSdiZ3P4YZVisb/D+5sBQSILcLZchSALP/K5AmVMyXEUVmMSCvFGgY0qHCrN6Av0MCVDHthZELdDd68oELKrcy6HBcP7OIoZO9ZCcQzptykmDKNkH2c16XC+QYoJgJlk3JCumM2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTb0QRO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTb0QRO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712951F00898;
	Thu, 11 Jun 2026 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195614;
	bh=zr9lRNF/pqDGSjXbrG3BNi1+wY6LuCO4o/MFGj3qvp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTb0QRO17nJdTAHwbIgOiW/HuRT+CZMdoIgz9HYmYPWjYgACVDXAePHbydbbtuwc6
	 PqxE44uoVul4RBaS+1YkhBmun+Qk/y4q+RC65OskeQxxdZODC5DWVdhwmPKXMSr65j
	 A5V2SXz6NMMp2KQMKxOAUW3XlVplXbFWVUu1rwYVKVoJP3sVi4gytevH0ml+C9gG+K
	 32CTKXJxTxlcQtEE0zf8Hs1v/YMaH/Uw2O4XeA9ythcyTXZdT3Hb/Aqp3r9oIlEN5W
	 oZUaYm+ML9hWkLW2YtHDATI25Q8UYqrMp5mxt1ujSW73G/7wY8z+GKDjGQ5BOcf8kH
	 4ywJsd+H9MJNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 8/8] perf/x86/intel/uncore: Implement lazy setup for
 MSR/MMIO PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611160033.66760-9-zide.chen@intel.com>
References: <20260611160033.66760-9-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 16:33:34 +0000
Message-Id: <20260611163334.712951F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `pmu->activeboxes` counter can underflow during CPU offline =
if `uncore_box_setup()` fails for an MSR/MMIO PMU lacking an `init_box` cal=
lback.
--

commit be5a594990bc5ad6318159289b770e88f7e8958d
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMUs

This commit delays the registration of MSR and MMIO uncore PMUs until the
first box is successfully initialized, applying the same lazy registration
model used by PCI uncore PMUs. Unregistration is deferred until the last
box exits, while box allocation remains at module init/exit time.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index b9ac2f7d31caa..9f8a80c9dcb66 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1570,8 +1570,13 @@ static void uncore_box_unref(struct intel_uncore_t=
ype **types, int die)
>  		pmu =3D type->pmus;
>  		for (i =3D 0; i < type->num_boxes; i++, pmu++) {
>  			box =3D pmu->boxes[die];
> -			if (box && box->cpu >=3D 0 && atomic_dec_return(&box->refcnt) =3D=3D =
0)
> +			if (box && box->cpu >=3D 0 &&
> +			    atomic_dec_return(&box->refcnt) =3D=3D 0) {
> +				if (uncore_box_active(box) &&
> +				    atomic_dec_return(&pmu->activeboxes) =3D=3D 0)

[Severity: Medium]
Could this atomic decrement cause pmu->activeboxes to underflow during CPU
offline?

If uncore_box_setup() fails during initialization for a PMU that lacks an
init_box callback, the activeboxes counter won't be incremented.

Because uncore_box_active() unconditionally returns true when init_box is
NULL, wouldn't uncore_box_unref() still decrement pmu->activeboxes here and
cause it to become negative?

> +					uncore_pmu_unregister(pmu);
>  				uncore_box_exit(box);
> +			}
>  		}
>  	}
>  }

[ ... ]

> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncor=
e.h
> index 0adb477d97086..c8dfa2d21bfd9 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -568,6 +568,12 @@ static inline u64 uncore_read_counter(struct intel_u=
ncore_box *box,
>  	return box->pmu->type->ops->read_counter(box, event);
>  }
> =20
> +static inline bool uncore_box_active(struct intel_uncore_box *box)
> +{
> +	return (!box->pmu->type->ops->init_box ||
> +		test_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags));
> +}

[Severity: Medium]
Is it safe to unconditionally return true when init_box is NULL?

If uncore_box_setup() fails and marks the PMU as broken, this definition
causes uncore_box_unref() to still consider the box active and perform an
unbalanced decrement on the activeboxes counter.

> +
>  static inline int uncore_box_init(struct intel_uncore_box *box)
>  {
>  	int ret =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611160033.6676=
0-1-zide.chen@intel.com?part=3D8
