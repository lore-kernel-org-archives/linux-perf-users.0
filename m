Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588929;
	b=et15qRxHL245wS53oOdBRax3PlxMuIN0i4T6x0/vedpQkIS/dPU/9DoLgASfCBJshjdp
	 Vj0A/gM+fVZ9aFGivL3SPv1+ahVfUc0fw2wKsFC1K2z4eC57qh2KvEGeRzXQHDXE9Kl20
	 DK8NcWMHPb0Pw0qzjuND4g5Hh57YfMV6Ch2pUsaqyYcySl0/8Rv5uyAHeHr2qtLnStdqg
	 qm57AhGqUPzMYt1TqOT+JwfTHrUqE8oT2HGiJWSeEZ89sisAsJ+RxHppolz+8gfp+FjoT
	 Z+L9LGfv3GXtSqCvjpaeJMe1YyFtEJsxLPNQBrczZjjI2FY//QGm1SuBHzmleRl/ohA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PzpFg8TPZUIiTLpkDYemi6iPX3FjcLoo5uw2uJvO7eI=;
	b=RU6JHUyXEdo6o4hv5tNsNmZhm8fn5kcGbKbA2fouO7nKaaEuDKykXzY259LgVCW9aBA0
	 SEv7XlD/WnxQ2KMBSjlckQwwanGfjV1qgAs/wkAFiA+dkvXgmWSZvKlR102hs7TipHMyF
	 dL55o8j53fB4VdTTCn+ssC2PRsFrns2H9oshvHTmarAksyNXHqkVEr4xI7J8ivrnVBT3P
	 JedWUlLqMSBZiSkfZX8sxI5fNF6ld99uzRHglIrteQd9A6JkdzMe8kvda1H5wjPDhE3Hl
	 wj3TJ+M8uLqiztF2whm7CWsRSn1SR9N+Cr66DTOJfiL/TIE4q1R4T0zY80FeC7h039Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9enX4UA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663C606A8A5
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9enX4UA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E2D1F000C7;
	Fri, 13 Nov 2026 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588929;
	bh=PzpFg8TPZUIiTLpkDYemi6iPX3FjcLoo5uw2uJvO7eI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g9enX4UAxnjLp1X5SYAGhsVMxRsRuVjViLlOAEBg9pwYyi3YUT3yaLM5v7YeGfeDx
	 GEoANteesa37AHXSlDmnq0v2I5fayM1/4DLUX3okwBxewrwptzO3rbnENRZf2ZFgx2
	 +tt7EQrAqj0L+8xFvfGHsaNDvHV/kP4DbxiBraeH4n1ODwt9K/2i4Ib8njAqra/1nR
	 5Qfq7hDO7a2Pm8zYrUF7d354ZEMV+/mplX0fujgXOCNdHZJzOgypx9OGO/pEabIW28
	 1KBMC/3RtBmPj0vO/T435dOfmUSAEYcrRjBMHNeqQkSqoDaWTAqKmFv+zivbetsno8
	 5jYojFbBTKLyg==
Message-ID: <sashiko-outbox-213250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/21] perf dso: Pass dso_data to close_data_fd()
 and dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-11-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:55:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D10

