Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622331;
	b=tSqvVJI2wbspwni2MNp4dkZHYxMDzNV0IzB71h2jR6ksRZb6JYXnmz/xssIE4CK9W4Bd
	 LyrIiB4wcQ8KzeJG4efZWgriWTazQsR7dPqbr84cRnotpB7/OBApbcQvjv4MN9lhTLuYc
	 dzhxauuQq9HpQVPQnselfBvhgIa7FYnCehyX8K31+GvH4t4RQj9UifRwYjVjWW4Y48ckL
	 824PMcDvg/Gh7c5JalfdhroxjGdkSVCON3v9b7gkDy+XKBAAzfeGfW8EdOx1ff4rdIcUN
	 kCA9uwBjQYIB9fyATH9WIS8rhmRDtFF0up/se76n1fkfaio248eZyoojWuRNdT7zTBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3b09B9xId2cwc5YMZcaeZcxG7Pil1k25lX9rlEppdIw=;
	b=5K7uLcGGkDqQQOUp9E3zK7hBz126FUt6fEHnaHAxboeyaioNkSlcIJ4NxYMg3civL7z0
	 VbuQO0k0B+q7ZYukx50FH195jw3wHo857v+ZaD7sAtdfB7eLjADaBfmBFlFwUhhjbgh39
	 eiS7dtw7kiyW6ZFLgVAqfE/izgtWbF+PMjhVfYCJt2yeO9Tmfgl6e9xozHKjIIxyGSSb+
	 wWe50pizn/zwHuH8pXtgt1rNT8V0YQ9rVjV5z/HMtarG0Wwa+EhLuJNXeVhQ+fIcN0Mej
	 FrE0ssXQgZhVjnvKcLIq4lxE60RldXMRSPg7tqjhr1xwnRh27y8ARWB/4pcRKwQcrDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCfj1yec;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF00606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCfj1yec
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8981F000C1;
	Wed, 21 Oct 2026 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622331;
	bh=3b09B9xId2cwc5YMZcaeZcxG7Pil1k25lX9rlEppdIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCfj1yecQl9J8rXmsckWBbP1S+C3YoGUHFnlY0csob3Xhi6lqTvR1SAfxlOVYOGbh
	 rPfIcZ+CVPfBtZxZROwWakMbVDgunDce3aHE2sP9slAJm2QslCf9acmHx9P+KLRquP
	 JnjMS+NPxOOx3fED+A3HOAgfVrb+qugKFcoTKdEeYCLcTSLiQY/QXy6ZncaJGQluYE
	 vjwRe9xuAEuljjOoMmCEAwUvs14uVhZQIhIUZ7zcp+0hdy07NdIEZ/XpfOVonuj6Gz
	 djsgZiPYcM/+R7eR7rzr4gGerI+3fY0jaIQi29lvMSujqP6It0+d7OI1OQOkzeJIAv
	 5jY7BTMZto5Hw==
Message-ID: <sashiko-outbox-180723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] tools headers: Sync linux/gfp_types.h with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-5-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:38:50 +0000
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
>   f6c786a95e95 ("mm: gfp_types: fix __GFP_ACCOUNT, GFP_KERNEL_ACCOUNT doc=
umentation")
>=20
> That just rebuilds perf, silencing this build warning.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/linux/gfp_types.h include/linux/gfp_types.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D4

