Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416781;
	b=RSqhK3P+m3m/n61B/t7VByGvGLs6VeqXsICl7hsVoAlRydKVjcV8v1jJmfjErHxQZ9Bq
	 g8jFb5a7rraynjOVtAZQftHv6w6pJIF5WbnvsJnrG1fy0HLAmVdhoP8ItH4Tc5RScIQPb
	 duqtCOsPI2ckLbSpVc+/dHrdubAvrubossrU0AhbB+Gex/6+t9RhC84ozeRnui2J5OuYp
	 bj933enfp3EjvhvPPzLogIMpxuMgf1noKNcQzDUKUGMLwUq6zMtWigabrdEaZV+AtZk7G
	 EOmPwii7y1guD47p7Q0VI8uEfCCHvLDNMA7cK0dGpaiyFthHO/cYmnBm3k6GaC3N2FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pzYK90STkoSx6CSoB4G+ZFcJ+UveRRF8/cxTRCPg6y8=;
	b=r4MIVNbGjZv5TzZNas/XAbTwiXqN3/1TIaijN+pgHmQe9tDHXDJH94KAYfsxlDUvl3cf
	 2t6D3q9TOaws/6BtCxWoBwJXDUQadFvYHy7O368iGjq3QRat+bOQ9pbQayEyyVz5zDBdf
	 eGXMaW67Mj6oZ2m9B04FDUj4nJ8rqEeUexMr7zLu8gdxeRzXFfqvaalHT1cbokDWltWkZ
	 OY4OxN8EZW99b1M16L8TtvsR20C1XEh6k45ePijYiQorTPr/YkqCNSYzemMkWDhi9S5ym
	 eukvPLiu40wM7aO+CDiqboautMjMb5fJvJ40DvDfYAdw0gEI83/kzhr75YQmG6sjnXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGZ6EHaG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B72606A8AB
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGZ6EHaG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523E31F00A0F;
	Wed, 11 Nov 2026 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416781;
	bh=pzYK90STkoSx6CSoB4G+ZFcJ+UveRRF8/cxTRCPg6y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGZ6EHaGx1DPoysuz2TzIqgjJI6NHs3CzRpYvk7/c2RF82jaO4VofkkiT5Sfpo72c
	 S3hTSl5yH9YN4URBzPkJBCds1MWcmt/gO8l9+5hHhf1VPKBtxUo9g730Oh4Br0KwQB
	 jlRKCj9vjFqebIPWUqbkELSz9vJM9u7ZDVRv766+Zr9NhXh4oozzYJ87y+o3rzY2g9
	 AUZisMeHJD7WurTgDxI6yj+F2neYDN2Jp5JS0dTup0P1tPlqQ1tA/zQxZRhSl0qljZ
	 M/ArPDuTw9kUH6CKeCzyjJUSAJ021vSyCcdvbzh4VWKVEGJL25H7pKeZXoKX5vUVVm
	 YPuDXfdMP9TGQ==
Message-ID: <sashiko-outbox-209373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in
 uncore_event_show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111164926.78234-2-blum@kernel.org>
References: <20261111164926.78234-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:06:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
> is preferred for formatting sysfs output because it provides safer
> bounds checking.
>=20
> Add a terminating newline as suggested by checkpatch.
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111164926.7823=
4-2-blum@kernel.org?part=3D1

