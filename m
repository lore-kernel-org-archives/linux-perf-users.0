Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607311;
	b=3Kvr1lnGRp5aw1TC5KK4MJ5/GhTipm48Qi5+Q7iBx+vPOK0LzeK3K2/GM0z07eFMnVRr
	 IzNtgqJwBUXiYy75qqAeKvZEicjpqZXZVbUe3wihPMJIc4Na+pTs6qZYJxIlByiT6oZUv
	 F+bRu1u3tuBz5YS9eDlndRCjKcZdIh/0jJCBzWaK7bqREEDdiSy2WwXHG2lX7eQeCfhLY
	 YwYvAID8R+7+CUYOKh7OwroxQJntVMqbM7O9JuuQDxU0l3ZhfzrBgUfWNo4MXPMoI/AbJ
	 M7NKrFsuvalEwO9bcrN67+mKvbU7iu+W2dXyd3X/TH/6wRD8CdSb5qsIjT63hCOTYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7cuEz4/em0auvqwvjYF1w9Lz1vMeuR6qOc5nPKFvww8=;
	b=JkGNCl43f5CYqD2yoynSZxSwU7Ppf0SdrYHgs7G5BtmzPAHMjNCet4dPP67z4b3eVSkP
	 +qsw02hrbgC1uHXqeb119Ko6BiPT9vh1D6DaS/+fnbDK6oA+OEFxVOQnFVqUaCUJp4jii
	 LvTt6i4v6dv35iFF3PGqvWNNRu5BRbqDqM4UpnFsRQ9wFd3xeafga/NY6GI/2bC+LqZgm
	 4VzFAlalIbrBOCw0ip4DEH/EGNbuWukgv0cT11mVEGcCITGsjnVrS+yKX9IT7fE4aOMIL
	 BJnlssTj46+yP0NtftbtfJh2WqBAbl+7DGeSPibzdBBrsh+GREoj3oPIxXqkhKTrDZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8+mgAna;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83643606A329
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8+mgAna
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025091F000C4;
	Fri, 13 Nov 2026 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607311;
	bh=7cuEz4/em0auvqwvjYF1w9Lz1vMeuR6qOc5nPKFvww8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8+mgAnauvBx4OvyqTPL99yUdjq5m5qo2iTs3CH0hJJjaQNcDzESfkbq2RAYnMA+I
	 zXe8n6D2N+lfTgPRT9l56HZeuCmRYr0ELS0XEG8yXz6EuSWiQgNX8a/v8wmr+7b1AT
	 1nkf5z15Lj1HYDdvU8Nmtws0J0Y4Sy2Ked4axB4BRldowc9UxhkZiRjD7h8tHsPMRx
	 gg+TksDxKOX7dBTNI/wN0nbkwWH7CVhk5pCWFfnxcBjaL5bjULrUpwkU/HA6PvfNox
	 B3bdlyMmkeDv42L9zTgtAMhwdBWiaHjum6J65uwJIbxRLE09ciWDRgmhylNcAMy46N
	 2LUKSaK91rohA==
Message-ID: <sashiko-outbox-213768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 26/26] perf hashmap: Remove untyped struct hashmap
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-27-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:01:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Now that all hashmap users in tools/perf have been migrated to
> DECLARE_HASHMAP(), remove the legacy untyped struct hashmap wrapper,
> hashmap__new(), __hashmap__new(), __hashmap__free(), the
> untyped-hashmap compatibility branches in hashmap__insert/find/delete,
> and the unused hashmap__for_each_entry* macros from util/hashmap.h, and
> rename struct hashmap_entry to struct __hashmap_entry.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D26

