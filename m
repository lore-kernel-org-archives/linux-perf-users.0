Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693929;
	b=2ruMU7J27eBGCe5QeuWORcWCJfNgxLQExv2jwfFiP5oLcTVJ0bEfhte8vdI8sRX25d1H
	 P0iQtrxTuhdQq1ms0VpkfraCSCk1vJyChn+VN4arhK2qnNhuD9pB0WTVfrk3bLzbnVwRg
	 TlLnB6Tkfv1+mViV1XU0elfhErHiXijh/ZHvtg2tqLr8EIqiZzTKpxqbDrrfH/WqCG5qZ
	 /r+WMw2Fjda89075tGu6lw5cpi3TnFLFnCtedDqG8YzfkrAcFofZuQrMKcSx4MPxNLeck
	 mSEWdWxBc4ytmhGPI+jS+UTVP/b0oz0UB5j/74GHzB5sAC92kG03h2uPSWm5UWhycmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iMU331clMs2Ug8a5oYEOf2TSMerhmscopHTRdtAkGYM=;
	b=n6nZ8Ac4+8ZQyXXDjTDItQeU4hXbZHgL2+b4J3bSJ6jZhbU831d/Sto6qbf2v57NoPAn
	 BGhZz9Vvz0V+HuTg7wyDiz7c5Rrv+jDvU+nLVGfzSSEwWDqClbwvvlQBKwxOqrVYU2oDI
	 QX6b1p7riMNeekT3pPG0S1PGy6z644HQptzUH6azZPqJbfYZ5Yymp/YcMAa4zW5L8fvBZ
	 YjufWtzfRZ6T6oACYq8uxF3HWNDZpOoqy6IGM72O3e5wp6zI+Mul554yO36CYAkHu1SX0
	 L9oqV+LWozvnx9qDkp2uXps9bkIhlpEhsxhpD8ZXgp5FXPGML8I5gVcLszFfA4K5Iaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiDZGj61;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7560A2629
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiDZGj61
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497E11F01828;
	Thu, 22 Oct 2026 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693929;
	bh=iMU331clMs2Ug8a5oYEOf2TSMerhmscopHTRdtAkGYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BiDZGj61OjtR8//37kcfjhYXL6jqat12+vzMZ9eBZoBYteHSfFnS96ul6FrLwk967
	 PuzT2WjMW4k7dcqceH+nBQVDMqHMceYMGPs5p1ci9rP9E4PNo5I98BPLF867mNquGW
	 CpLg9yaDvh/hHnUxXXb3bdiFaWOcflVmP6ZOsyxR3IqvtQk5FB8pXC5VY9OWbLJbx+
	 Ua1h+agfQvrpJbTItBpx45mPrtiRTr9540QqIWqKDjdPZIwB1OgslhnBORnVrzL95j
	 T5lDFsMte44nPrzpsFJMtPbaqTQ22Exh3O9RSz8XVROjsVFE4HEVxmiYPPVOgvIiWu
	 n4FU7zPhg/ufw==
Message-ID: <sashiko-outbox-181922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] tools headers: Sync UAPI linux/fs.h with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-8-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:32:08 +0000
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
>   21a62663d473 ("fs: fix typos in comments")
>   338964881982 ("mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/=
linux/fs.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Hemanth Selam <hemanth.selam@gmail.com>
> Cc: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D7

