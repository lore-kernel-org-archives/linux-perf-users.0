Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8B46B5
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102040; cv=none; b=V+5nEIK5vVWEIc4wPbJwb7k98etHFUi0Sks03EivMvzL/qGItQw0yzNOw2mfUe1c1nY1jsiRx3Y5LS8rksZo883y7le0rs2yQdqpPxvttVdeyEMOSiSpFixQjote4+BixLLcStN3nrYvtccxJG3cApYSCUmMxMQkrCIIWhz8Gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102040; c=relaxed/simple;
	bh=2WgarYpNKmqxtFC+YhtprbavfjaugktNqjB/oW25SaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZlDZVtVh3dUWP2gnnULgzCA4iwi92Sb7Q70WmlEd3sMZ4q0MJjbsopxwmj7ragd5RB4q7biMa5iBbTalULIB/2m9vx8O7lKiD3dCuMgiMhJ4t2eRZgiPl7JQT17Onfwug9meK2jJdXw5qByqc39rzbyjn1T4ZXJlk52YvLuuPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnDXRmJ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnDXRmJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFB61F00898;
	Sat, 30 May 2026 00:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102039;
	bh=GOILGeHFLsWbJKHvC/xLM6Eb3w9wsqrMQ4L4mnlw2aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KnDXRmJ+opCc2fSO+Z/Pg6gQft/Cz06sxirJB9j8SsASGx+eIOzfHRoAgOCIHnibW
	 mZ4TKy0K7bzw8a76wFC3U+yDv1z8gj9X4beZT+fRYxMlBl5R4Zq3wbkGuMUM1If7FC
	 /270OqL5tA4kXCo04R1rPEKZslmwg9NzscUXXa9n5otoO/EqI8g+rh9h5JW6Zq890S
	 ZLE7qz4DlX9xfWcxJF/NmILfWfm/qp3aF3QN4IHmx9o9Ao+Nk2VeErP8iOGofbrYme
	 GMuvSgW0r6S88wIf3WFaKzSI/ibGh0V/7eWqkFFGBm/6Fr2/7QNX7YiD6wUZhDIVu0
	 Jg7VmwTFTh0WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
Reply-To: sashiko-reviews@lists.linux.dev
To: "Demi Marie Obenour via B4 Relay" <devnull+demiobenour.gmail.com@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:47:19 +0000
Message-Id: <20260530004719.8EFB61F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch breaks userspace compatibility by forcefully disabli=
ng hardware accelerators, asynchronous algorithms, and memory-allocating al=
gorithms, and silently ignores user-provided configuration flags.
--

commit ac5d5083a6e0ac13c785899123f47cf8eacc20ee
Author: Demi Marie Obenour <demiobenour@gmail.com>

AF_ALG: Drop support for off-CPU cryptography

This commit removes support for hardware accelerators in the AF_ALG
subsystem. It forces all userspace crypto API consumers to use purely
software-based synchronous implementations by dropping features and
flags in the bind callbacks. The goal stated is to reduce overhead
and attack surface.

> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index 8ccf7a737cd6c..cce000e8590e4 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
[ ... ]
> @@ -181,7 +181,7 @@ static int alg_bind(struct socket *sock, struct socka=
ddr_unsized *uaddr, int add
>  	if (IS_ERR(type))
>  		return PTR_ERR(type);
> =20
> -	private =3D type->bind(sa->salg_name, sa->salg_feat, sa->salg_mask);
> +	private =3D type->bind(sa->salg_name);

[Severity: Critical]
Does this silently ignore user-provided configuration flags?

Looking earlier in alg_bind(), the user-supplied salg_feat and salg_mask are
still validated, which explicitly allows the hardware driver flag:

    const u32 allowed =3D CRYPTO_ALG_KERN_DRIVER_ONLY;
    ...
    if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
        return -EINVAL;

If userspace explicitly requests a hardware driver, it looks like the kernel
will now silently ignore the flag and provide a software fallback instead of
returning an error.

[ ... ]
> diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
> index 62867daca47d7..7643ba954125a 100644
> --- a/include/crypto/if_alg.h
> +++ b/include/crypto/if_alg.h
[ ... ]
> @@ -243,4 +243,16 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *=
msg, int flags,
>  		    struct af_alg_async_req *areq, size_t maxsize,
>  		    size_t *outlen);
> =20
> +/*
> + * Mask used to disable unsupported algorithm implementations.
> + *
> + * This is the same as FSCRYPT_CRYPTOAPI_MASK in fs/crypto/fscrypt_priva=
te.h.
> + * In additions to the motivations there, this API is exposed to userspa=
ce
> + * that might not be fully trusted.
> + */
> +#define AF_ALG_CRYPTOAPI_MASK                             \
> +	(CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY | \
> +	 CRYPTO_ALG_KERN_DRIVER_ONLY)

[Severity: Critical]
Does this unnecessarily break pure software algorithms that legitimately
allocate memory?

While fscrypt restricts memory allocation to prevent filesystem deadlocks,
AF_ALG is a socket API that does not have these same constraints. By
copying the fscrypt mask, this might inadvertently prevent the use of valid
software-only algorithms.

Furthermore, does forcefully removing asynchronous algorithm and hardware
accelerator support break userspace ABI? The kernel generally maintains a
strict no-regression policy for userspace compatibility.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-af-alg-har=
den-v1-0-c76755c3a5c5@gmail.com?part=3D2
