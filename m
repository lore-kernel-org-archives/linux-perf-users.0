Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F617AE11
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023953; cv=none; b=FCS/WFjMzn1FYTGou/yJ2kWO5X28yc61GJZE5MkxzWXjL1mqyo0ybeDgz5mQvbsQplrf2O+7ISbdxs3E8vz6DN4F2uORJPlH53xYdWHWv9G0l2CWQnHa9JvB+5CDJJiWulLRhRuKzHNdIkQhlGlZa8HormESWSpRjwRgl9svBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023953; c=relaxed/simple;
	bh=TUqTDWIgIW5jwdAtXVOxPBnxEZmDG5Tb3tlC3gkiaaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCZ1/j5ucmg5H6/f7/Iy3GQLgBOoM2f2Ww41bwsHnrW3sAuFc6u0PioCDjq7m7O44eboeYBbATUjQiiKqNis0hRhuIKNUYxYFQ8EDdIpo8pteSgA8XFTKekEmYpT7vMeaPUM8zb8Atay/yIL4Y3XQY2d8fraBPID7/QoJQrpe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz9gfY6p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz9gfY6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76673C2BCB4;
	Tue,  5 May 2026 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778023952;
	bh=TUqTDWIgIW5jwdAtXVOxPBnxEZmDG5Tb3tlC3gkiaaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uz9gfY6pH5qcMwYYwBeRIr+eT9jwCKFnMUh+HeClCNpRfWCdiCHLi4JlNeAM3o9oH
	 o9A7Ewz1DNL9dqOzfDb0fvS2FYcJvfldCWICVHc25jBD+hSe6Dz3eXT18hIkO3ecmQ
	 YIsHF0ArtzQ2EvhBsV0+sGTcUw/6t9J0iftB59vk9HQeHxCrlKMVUbME5iUA5pM1MK
	 GaLZutJqHVr0PxmBKKJgh/J0+jex1aGItXXqT9MwxazrYZlO95i1rhUJbIIJjFf5RB
	 gEMdTnJ3b2sXw79IQatj94SJaNh0C0t1RAYT6JopLsKrmq1fCCLuvOhnxd9tqSK+ai
	 IZkuLREcKVY5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf lock contention: Allow 'mmap_lock' in
 -L/--lock-filter
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260505231136.691907-1-namhyung@kernel.org>
References: <20260505231136.691907-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 23:32:31 +0000
Message-Id: <20260505233232.76673C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Combining a slab cache filter with the 'mmap_lock' filter silent=
ly drops all valid slab lock events.
--

commit b47198e2987a248476bc916b47bb7722966773ea
Author: Namhyung Kim <namhyung@kernel.org>

perf lock contention: Allow 'mmap_lock' in -L/--lock-filter

This commit allows filtering for the per-process mmap_lock using the
-L/--lock-filter option in perf lock contention by adding a special case
to check the lock type via BPF.

> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 96e7d853b9edf..8b1aa64deb6e4 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
[ ... ]
> @@ -291,7 +302,15 @@ static inline int can_record(u64 *ctx)
> =20
>  		kmem_cache_addr =3D (long)bpf_get_kmem_cache(addr);
>  		ok =3D bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr);
> -		if (!ok)
> +		if (!ok && !has_mmap_lock)
> +			return 0;
> +	}
> +
> +	if (has_mmap_lock) {
> +		__u64 lock =3D ctx[0];
> +		__u32 flag =3D ctx[1];
> +
> +		if (check_lock_type(lock, flag) !=3D LCD_F_MMAP_LOCK)
>  			return 0;
>  	}

If a user specifies both a slab cache filter and the mmap_lock filter,
will valid slab lock events be silently dropped here?

When a lock event successfully matches the slab_filter, ok is non-null.
However, there is no early return like there is for is_addr_ok above.

Execution falls through to the has_mmap_lock block. Since a slab lock
is not an mmap_lock, check_lock_type() will not equal LCD_F_MMAP_LOCK,
and the function returns 0, filtering out the valid slab event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505231136.6919=
07-1-namhyung@kernel.org?part=3D1
