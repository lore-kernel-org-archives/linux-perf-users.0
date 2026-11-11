Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428598;
	b=UVBpyoKpwJfbl3Mx5Ker+ca9MQMLhBId9jflHEU4L2I2SsglAr6nAqKnn/LaP+Jc3VI7
	 TvvxdmClvMQB6Z9/9ZG2ruyv5HTKLFQwkhyvYuR2m4ipaE4+B3pOCYy3WKQyla1Z1OBOU
	 vYzKTIQoPUOOAhRU37O26pH8X67+6pTIpGIHsIiuB/TD3aEX8WP7N4QILcNCCkMeG3x4p
	 dsnW2VdL65VLPOlDWj2LYQGcHD7Q0wgvQ7BTNN0kO45XqRYeFOMA73QrXX1tyZ1yVp0dk
	 QYYI/aLdcxh6iQsQbCE5MAmrCaDZkrs5VP/p7UAq6/WfqRvhBGYUKOmo/Lcw4OUZDzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jZOB5KRCXuBXruHFegz0oKOGdQoSIvHfk46qQAE+oxI=;
	b=CCYkqrSCBKfbJojcA6gIJ5CJyPbJHq7jSuF6QQBwsVppcq1zeMIPPWw2uasaKTyEyCsO
	 9r5S4hdUF8eJllUJV0QLqLPC7JXHB/RIiWF/MKfxReZ4qFrE0YM3PmBLR9M4sk4V0LcZw
	 7R/YDWLF8lBOfLWTWu767UStTFeoq9cj10ra+APOEy7dmjcFMR4XiMyx3xSc1FNRxahf9
	 mcaARqnZ6/SBby0AHsvkHRFq5sMxQPkD96a1JIMMg9i1xi2SvsWFVHP7ahxH6ynmnCEwW
	 Q4eHiEx5Vg4dqkO+BD4rm0/jHNaTzpoDx0baXxH/HWkADCMXLhafTi/BDrp6A+dC8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WWBL+2/2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227A606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWBL+2/2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756F41F00A05;
	Wed, 11 Nov 2026 20:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428598;
	bh=jZOB5KRCXuBXruHFegz0oKOGdQoSIvHfk46qQAE+oxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WWBL+2/2HmhT9XMZQ/BsJwHNfVKq51rL0ZdPpMbHRw5I8ZT1KCHnhpM52FcFCEsB9
	 sHObKJLtJthxFOWCJnKXB8xTQy0KVzeLHSo78st+8YArNfIMl34h9hRrf3wFpkV0jT
	 57CYaQcJohQRccm0QpOtHY+tMzMuNxHsZISpeEZwvV9uAwM/r/q68bPikGok3qpB3h
	 hny48EYeXlthSwjvBIcfFitoPsDdpstMjQp1xLMHxgyf6t+xzEqAnKd2gL1wwhE//O
	 CutfcKAV1Vsnhl4Tl68GOnoLhane7IH2dvd/VFNiTqElxwv/Xj92e+kXHLSY+ZvyJv
	 rjk4Jt3LPB9zA==
Message-ID: <sashiko-outbox-209647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 13/20] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-14-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:23:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate
> dso__data_open and fd_limit in util/dso.c with
> __guarded_by(&dso__data_open_lock), and tighten __dsos__findnew_id() and
> __dsos__addnew_id() from shared to exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D13

