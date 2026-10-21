Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622466;
	b=jnHKIoV4QerKoQz++2tkVmC8ZPvcmcTM8uYqs28ptRPJ7TT5bTc8GY7tPBHaZevLQL66
	 PGh+5X5W1KxggmTKPmBYqYsJQmmYD3/NK8GHLIWTat24RH/N/cl7NL2smtx5x2jK8qtpx
	 4v/7S0Ob2SKZSRcIha6bxwzYcK22OOS1amOe5OHfCzDNEhcHuRaAtd8UigM8/Fgk2Nu8Y
	 VOMhzYi/ypt1blckiXMIIQv0CjDz6CYkZ4Lfj0YbktQoS5TOXA1bOwh+zD4NiYQIrgcK+
	 gw+Psfu7wPpKRWZmJm6PpNWFgfIuPfjrnWQlFcdoZTEDsJQlSds/5d/u8Ov3Pjr9jQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622466;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o6aZf7NAWruUCgl8BLSrLWLwO2Swk7xHjhrmjS/jhTw=;
	b=GXYD9HSSLlvRiR9OhJqo7expho7cC/GId4od0LSZNknnaOk13QBDjLF3RBayO3lD3rhu
	 XTQffrRBqnbsb095i5RcgfW8HlU4IPaTs7/Ti3bveFgd290dbj2BXGtFhoB5yqENnE3eH
	 otmyF9YVGc9cTaFiDT/LBdxzOIsQGDagnfXziKzPCINyu2BziiDEbajp6OFkDmkhfTx4q
	 nAMKWu5XC6G/IaOF3Swr8IDAr/QkW8zZzAinVrgec4V3ynFH4m8imCwb5YQUztFcs50o1
	 Kd8yL4YooFqr0zK8lEH/6ER5ENK+rh6H5fPz+vEb4QbQMDTneYfLiJMRKCvDyDUIwvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtwP9zby;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DA606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtwP9zby
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028501F000C1;
	Wed, 21 Oct 2026 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622466;
	bh=o6aZf7NAWruUCgl8BLSrLWLwO2Swk7xHjhrmjS/jhTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtwP9zbyOhUjN6+KWqtGdzG/oeOfI2HS+2pDSR8+e5qwRdf9NnyfFkmfPpb3K4Tul
	 jIyORUDa8pEZ2EoSETc2w2DU27kjYgGjLseSXoWSAEzdT0vbt4gjYtK/U3qH/MtIkw
	 uABYrs2qpKHxRhVnXKMUjonbIEg4loyZEoXDRE14V4CblaLitcSWgEcghhX16eDa3/
	 x88oLUAqNtRyQr1yXLgHPBFoANYgGudtpK54sCDDD7P7gqMmgxVJBotVsP59I1Xt+t
	 rTwV5qge0yCzucHd+pGxA3V8bwvXkUy5eVJ9S1Jsvs9Q0GQEoUDu9mpDnK3hoPVPnT
	 XyRP72oRhtY1A==
Message-ID: <sashiko-outbox-180729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] perf beauty: Update copy of linux/socket.h
 with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-8-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:41:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> To pick up the changes in:
>=20
>   be3a5e06b962 ("net: add SO_PASSPIDFD_THREAD to get a thread-specific SC=
M_PIDFD")
>   5bd369c05576 ("net: Add connect_socket() helper")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/=
socket.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Acked-by: Mahe Tardy <mahe.tardy@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D7

