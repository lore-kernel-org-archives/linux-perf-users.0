Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A923E324
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102040; cv=none; b=u+YG7eMqGc/8HcZzhofZEALrYypAO2dv16+lhSzguifqycWl/lrI01PWgGD0twAnr4siiIuwapE7jLx8aLTHROZGJMTWpSmr5B3z7QbEfDfdxqAdnsf4ZHV/AohaXcVFfje3Fi7E22qnNzzrKzHUKUrwDgk1gzUxWpg1bNCAhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102040; c=relaxed/simple;
	bh=WXinyAYgBtEF56wvhTiC0kNkVojeywX+Sn2wkg0kVi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LuCTB/lNXRn4W9M/W1iTwD144qBqGD/NGw3N1X/rW/+exdvj9nBVbqvx0duxMwsrTDg+iyfiXhCNFcS0AHNjWA+5MfuuBwX0qFh7hqxWgkyenMtJnvgQzr0e49mRwSQE2yN9CoUtC+o60EaXOlNtfa/fEbWET4//sHK8783ETpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVNKyL7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVNKyL7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB621F00893;
	Sat, 30 May 2026 00:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102039;
	bh=xNkzvba71iHnNA0avgETV8rrbUeUSdb3vbgsdSh34To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oVNKyL7NncktFc7m/woMpi6EftTAJ9+biJ2OqsU9X0BWS7vkHMQaj3So9lNHwH5iP
	 y86Fap85lcT+BJBO58Lx1jo0FXT+kWfZaWcQSuOZ6CcNnIxO9H5q5saKPBlVIqSN8B
	 zOtt6Xx76nJqtKuy0SzmQFLMuc+S4cg24kuxng/F/vYJ+CZB32JW2sElXAGK7gzjuH
	 pAo7e0k7odUv4KLGA6J1AViYBUmTNoHiKUMo6GumOHPgazBEt+D+fLVRknhYN/0Dlv
	 uJyW03xHoToeKHzRQdO5AlN0XwM1srJbloJGRlRJkcH28zMSb9adrmpN535PJzIF98
	 vy2Bp8Ts1z++g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] net: Remove support for AIO on sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Demi Marie Obenour via B4 Relay" <devnull+demiobenour.gmail.com@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260523-af-alg-harden-v1-1-c76755c3a5c5@gmail.com>
References: <20260523-af-alg-harden-v1-1-c76755c3a5c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:47:18 +0000
Message-Id: <20260530004719.0DB621F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `outlen` field in `struct af_alg_async_req` is unused.
- [Low] Obsolete error handling and comments for `-EIOCBQUEUED` in `algif_a=
ead.c` and `algif_skcipher.c`.
--

commit 64f74b492ae582ab9df137534f38a66893730e73
Author: Demi Marie Obenour <demiobenour@gmail.com>

net: Remove support for AIO on sockets

This commit removes support for asynchronous I/O on sockets, as the only
user (AF_ALG) is deprecated. This reduces the size of struct msghdr by
removing msg_iocb and makes operations strictly synchronous.

> diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
> index c6c2ce21895dd..60f06597cb0b1 100644
> --- a/crypto/algif_aead.c
> +++ b/crypto/algif_aead.c
[ ... ]
> @@ -197,37 +197,14 @@ static int _aead_recvmsg(struct socket *sock, struc=
t msghdr *msg,
>  	aead_request_set_ad(&areq->cra_u.aead_req, ctx->aead_assoclen);
>  	aead_request_set_tfm(&areq->cra_u.aead_req, tfm);
> =20
> -	if (msg->msg_iocb && !is_sync_kiocb(msg->msg_iocb)) {
[ ... ]
> -		err =3D ctx->enc ? crypto_aead_encrypt(&areq->cra_u.aead_req) :
> -				 crypto_aead_decrypt(&areq->cra_u.aead_req);
> -
> -		/* AIO operation in progress */
> -		if (err =3D=3D -EINPROGRESS)
> -			return -EIOCBQUEUED;

[Severity: Low]
Since operations are now strictly synchronous and no longer return
-EIOCBQUEUED here, do the callers like aead_recvmsg() and skcipher_recvmsg()
still need to check for -EIOCBQUEUED? It seems the error handling and
comments explaining AIO request limits in the outer loops might now be
leftover dead code.

> -
> -		sock_put(sk);
> -	} else {
> -		/* Synchronous operation */
[ ... ]
> diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
> index 0cc8fa749f68d..62867daca47d7 100644
> --- a/include/crypto/if_alg.h
> +++ b/include/crypto/if_alg.h
> @@ -80,7 +80,6 @@ struct af_alg_rsgl {
> =20
>  /**
>   * struct af_alg_async_req - definition of crypto request
> - * @iocb:		IOCB for AIO operations
>   * @sk:			Socket the request is associated with
>   * @first_rsgl:		First RX SG
>   * @last_rsgl:		Pointer to last RX SG
> @@ -92,7 +91,6 @@ struct af_alg_rsgl {
>   * @cra_u:		Cipher request
>   */
>  struct af_alg_async_req {
> -	struct kiocb *iocb;
>  	struct sock *sk;

[Severity: Low]
Does this struct still need the outlen field?

The patch removes the af_alg_async_cb callback and the areq->outlen
assignments that were used during AIO operations, so it looks like outlen
is now completely unused and could be removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523-af-alg-har=
den-v1-0-c76755c3a5c5@gmail.com?part=3D1
