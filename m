Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787315;
	b=AwhZqtxktU3X70Yh3MwoFYlDHgJ1vYLOJ3c1cyQGVA1erR3/aJrhHTv+xDhWbxqtDaW0
	 0FDHvSZjvcxmdc9DWAgEuXuNbc1guzgqPwxWO7u3cIzOTzZ3+/a5PKsLrRXvmN3tn4vYT
	 kcvtn4v9C1osj+MNFmPEDHgjZpvUPx+fWXXAPf3M41Kpe83PZIlw1QGxV65LaiXU03XIq
	 ddqGgDWvjad39+0GBIs64gjgp+jQ/6fIHwIYCYL/v8iyB1nlHMhpSYP2Cr2F1jn4WC9d1
	 kjww5SwnWrc3zFLVPo/mccm5aLJEQMeIHDIU60Ql3H3h0zTFIe1DFIhNcCS1rerZobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787315;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c1L1VJCy/RWTEIaTvzcaAbEu5pynkfVzcsaToI9pjLk=;
	b=fMktWd/4KrhTZcwo5GiKntV3sO0Mb0muTy8thT+rvEA3630DyHoWiHclHdhUyvdvB8HQ
	 UgBMXo2c+oCTq/lJCPvpZJ9Hdark6j+sCMC4pNSpwkV2G2GeFnXjWUTPU3NUlOOjMUm7q
	 ifYsRkAol4tsHZz3jTniptn4x88ZlGZvj2/uG7+XR1ZQOpVdYXLQ+K8n0Iu0AnH6ZJtBW
	 U6mTT8XZ+7MpvVdLVnQ4Mpr6nPh6TbDu3MANsddm9gIJaZCZGv7IcJNOcieJc6PsqniaI
	 Kcp1LOy9/LBctzSpUMqP7UrMGVx8r8RMT3F/riXUaW6XUA7KVGPK0Gf4phDihaiILeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ8phmTt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8F606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ8phmTt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10F51F000C1;
	Wed,  4 Nov 2026 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793787315;
	bh=c1L1VJCy/RWTEIaTvzcaAbEu5pynkfVzcsaToI9pjLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJ8phmTtRJUOmj/Bjr5Ev/aw0dVtgzN2oCfO68D4kXgQxHeMOif/WhF8Y4EIgjeJm
	 K42M/6NV/S3HQv0/JBzd8dcik3MUcgEEuMr0A3PEv7YlQav6AyYQ329Zbp+6YEpQPH
	 oMBco17V79u+hyV23FixwEjuoLbtknxNLyDOECBUqNFyvpcOxhrNff0Z9KMvQNQMka
	 Rz6q6hcz4SstvtYTIOifuALmTWcOUaxuV3XDh/pbCQVzTxe2jGwoGgS33bu7Rqy5kK
	 Q94BtSoy8xsdj6yXRDQ/fXpSKFcp6ZG/WJuefmZ2aAFHjFI5s81VUgDxUR+P8ZS8WR
	 WVtdTAq2WPSuw==
Message-ID: <sashiko-outbox-197071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf: do not call zfree() on uninitialized pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104100802.539266-1-jirislaby@kernel.org>
References: <20261104100802.539266-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:15:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In add_drm_pmu(), the check for type > PERF_PMU_TYPE_DRM_END happens
> before "drm" is allocated by zalloc(). The error path nevertheless
> called zfree(&drm), i.e. free() on an uninitialized pointer, which
> can crash. Remove this bogus zfree() -- nothing has been allocated
> yet at this point, so there is nothing to free.
>=20
> Fixes this compiler warning:
> In function =E2=80=98__zfree=E2=80=99,
>     inlined from =E2=80=98add_drm_pmu=E2=80=99 at util/drm_pmu.c:110:3,
>     inlined from =E2=80=98read_drm_pmus_cb=E2=80=99 at util/drm_pmu.c:174=
:10:
> ../lib/zalloc.c:13:9: warning: =E2=80=98drm=E2=80=99 may be used uninitia=
lized [-Wmaybe-uninitialized]
>    13 |         free(*ptr);
>       |         ^
>=20
> Assisted-by: LLM
> Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM inf=
ormation")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104100802.5392=
66-1-jirislaby@kernel.org?part=3D1

