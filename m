Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827424;
	b=Ko2Iq6J3B6DNUP3bh7kERqZTh/2cVl/0Ia5Ju6SZuqTrRj3tJCUP8KzhEOBklNsn2OUB
	 SZa5LMkhQsmdOmzJ+gTfXwqio6jji1J1NXV0WVkj5GAJyD4bvincwSZXezk6cpMBAVjhw
	 eRTHH6dgxyrw4Iy5lMSdAqkq/nXVRskekEHo1RF8HJr9yzjj9TbY17MXzPYEzxMlplzka
	 1w/LS8GrWniz98qbDkN1JSZZfSktPW3dLRpypQMN0IIlttDJ53AV77F7P/MXHNp3BZsVc
	 IYGpDTzz0MBTKRiZZ1S35ACZB9cYudnLnQNSoI/4ZdZ1ms3m3tF011vK+YGH5u7c6xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VR/y+tChzUOGuOFK3gicLwVnkU6vDAUnuwTR6Qha+Tk=;
	b=IB7d/5zvRks/+O6brfShGxqR2hdyPfcnD2EWUQqLR88RA/hpqRG7j2QmKTsmQp7zyb89
	 EjXVNUZmNavjhwruoNdB3cJhu9tGjK27QOs/PHldu4+3UmwMmfDSKOsaqcBfyIAKvYm5X
	 m5P157xhT1Lw8v13dRwuOBvf+SvAYQzpPkEA8fkoUKFl/+MTGbO5icACcIiJp4zBKXCmG
	 68IQUaG27Fn5FbXqoeRf9cvlLojjmhMuY6kuCLTRDgrxdtXkpkwfvlKqfToPj95Gitrgh
	 I7VNsKq9CSG2uQAZmg43u4raUU0TIwLGOa/fONZxDPCjIGSvcfPNpYZMWtESH/vzXlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuyapGO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE66606B2F1
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuyapGO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8871F000C1;
	Wed,  4 Nov 2026 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827423;
	bh=VR/y+tChzUOGuOFK3gicLwVnkU6vDAUnuwTR6Qha+Tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuyapGO0XGAwXQK04jkhRPBo/uyyV33jHls809BteC3iIVoRsO0q1T0Dp1/jPhOjq
	 bZazbZAMCMrdEBKozmLfHURJvKaZ94tKG8eJ1WdwBWEMki2Op0eXPp3YqGV5Fgd5wW
	 ZogKmprmkLJExvhkZbSUntqFaBALXR162G7iZ9HT/LqvXEw3a22VrNYAWY1l/FqZuf
	 ripyuwhthQtCAwYskCixwMCJ313QaVWkOrxUb50JNitXlDih51nX1Fr/EpLpFh53pY
	 xWncM/qt1ZeawftzCXvLyiNnmVQTO9GFiytIOlp1WgSvFJeEguTFQKISp8PIgbdgJe
	 P8CzFKHXoFt6Q==
Message-ID: <sashiko-outbox-198109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/19] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-13-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:23:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D12

