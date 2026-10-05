Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE384E01E8
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231526; cv=none; b=UFm94u6zza1AMJQxPHif2pvrl/u6ERb5f33EVJYw7cYFQULs70FLbHCH09t5UBS2dIwoHjpf3RGRUV9u6xHyDSmu+ukXQlHFRGgVOywY7kY+SmZCe9UiQTeaEc3O61JvmH38XtAm3nHHIXcgQh48kjLVYxEZqYQ6YZV/cC30FZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231526; c=relaxed/simple;
	bh=/ABlsnlOcLLGIuUBbwGhYcDA0edDcUCQYt+79+Y7Cp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CO4llo6fHg0x9DQJ0TuuKxkBHf4zxb7CDyCNw5hAn0LUw/rvol9L4iSHqKUIyORYPHWuSvI7Kv4iwgJaopvuXpLsKiw6biVoAX/nW5HhYjuLCu+JM7PTxQNJUdlFQ3BbVR/0GeT9PhfDL1xl/zAuR6iFkUJ0N2ZDAzIYeCtkIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+SBQIXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+SBQIXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08DA1F00893;
	Mon,  5 Oct 2026 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231524;
	bh=04kK3yhwtgK5o+9ZhUhAT8DSjjXtFjqXRUGbgeuX/H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+SBQIXXIXzpB+OTw9YtWeYyXUqc7k/uVKd6/jPWfFYPxvS/clFHs942wx+Gd9NJq
	 6zgzOhNjrzhUIgBecfbcPeeQowh7GdXpM5fSTADTh9AGLasiXYn3q0QE4z8Hb5dNd0
	 rPXZm0cYjPsyCgnuV+aZtNQXfDY8phIlj7JRhTdixmBSu6/A9+s7X+YBb8vks/sHJW
	 hcS7e36FaoGxYrN+w4xOWnk8qUU0eTGPT4zgcp25mWBJos4uxd2FBQ2CHKg/Rkc00S
	 nXJpdzDcXls0lnfKH3JRZLUhYlNWt3s5a1h67TjC0fD9lObXB9ry4qz/c3PBTbzxCG
	 6kH8mPitB8LKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf annotate: Resolve C++ virtual function
 calls in x86 insn tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005201010.36493-4-yzhao62@ncsu.edu>
References: <20261005201010.36493-1-yzhao62@ncsu.edu>
 <20261005201010.36493-4-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 20:18:43 +0000
Message-Id: <20261005201843.E08DA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: cross-platform analysis broken by host pointer size in vta=
ble_get_rettype()
--

commit bbc900a432273e7459ac998c5ec0f21d8e575f31
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf annotate: Resolve C++ virtual function calls in x86 insn tracking

This commit resolves C++ virtual function calls in x86 instruction tracking=
 by
identifying the vtable pointer and the slot index from the type of the obje=
ct
pointer using DWARF. This allows perf to track the return type of the funct=
ion
called through the vtable.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> index 1acf31a2c7597..36b51f1bab3d0 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> @@ -216,6 +216,29 @@ static void invalidate_reg_state(struct type_state_r=
eg *reg)
>  	reg->copied_from =3D -1;
>  }
> =20
> +/*
> + * Get the return type of the C++ virtual function at the @offset in the
> + * vtable of @class_die.  Returns false if it's not found or the function
> + * returns void.
> + */
> +static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
> +			       Dwarf_Die *type_die)
> +{
> +	Dwarf_Die func_die;
> +	int index;
> +
> +	if (offset < 0)
> +		return false;
> +
> +	/* TODO: arch-dependent pointer size */
> +	index =3D offset / sizeof(void *);

[Severity: Medium]
Is the target binary's vtable index calculated using the host's pointer size
here?

If a user on a 64-bit host analyzes a perf.data file recorded from a 32-bit
binary, the memory offset will be divided by 8 instead of 4.

This yields the wrong vtable index, which can cause the tool to return the
wrong type or fail to resolve the call.

> +
> +	if (die_find_virtual_func(class_die, index, &func_die) =3D=3D NULL)
> +		return false;
> +
> +	return die_get_real_type(&func_die, type_die) !=3D NULL;
> +}

[ ... ]

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 8a9d3f2eec4dc..e9bf76cc28633 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
[ ... ]
> @@ -715,8 +723,11 @@ void set_stack_state(struct type_state_stack *stack,=
 int offset, u8 kind,
>  			    Dwarf_Die *type_die, int ptr_offset)
>  {
>  	Dwarf_Word size;
> +	bool is_pointer =3D (kind =3D=3D TSR_KIND_POINTER ||
> +			   kind =3D=3D TSR_KIND_VTABLE_PTR ||
> +			   kind =3D=3D TSR_KIND_VFUNC_PTR);
> =20
> -	if (kind =3D=3D TSR_KIND_POINTER) {
> +	if (is_pointer) {
>  		/* TODO: arch-dependent pointer size */
>  		size =3D sizeof(void *);

[Severity: Medium]
Will this assignment use the host's pointer size for tracking the newly
added pointer types (TSR_KIND_VTABLE_PTR and TSR_KIND_VFUNC_PTR) on the sta=
ck?

Similar to the vtable index calculation, using sizeof(void *) can cause a
size mismatch when the target architecture's pointer size differs from the
host architecture.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005201010.3649=
3-1-yzhao62@ncsu.edu?part=3D3
