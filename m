Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428131;
	b=1/ndrYfmLiqmobKrwjVLxndA1rovGmIhtsqSShWvhi/YwDMy+54I441D+eOs/WZAiXfk
	 KQ6Ny8O4m92USFY3Y6Ga5IpBRiYRJtSvGgS3k867FkUOnsQMuXMJIPSl55DQc0mwrJXIM
	 WRiG3Jw+9ZuCNxt/O5E6A6cV6QEcFf/w/mMCkrUcXKhemtFYDNL7i5rSX6qVXvnu1qfmh
	 96lgH6g+vKP1qL8VMtFfOoMMr1dhcojcO3P8JDNKWgTPQv8J+JfM2U+y0d6qhLRU1BCZB
	 WEUFm266FvgoCWGJdHaKxNGyOAQuTQiQM0CxBTBNbtKDkUjYy7x74ayamIf00AWbcJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428131;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TX6L9YocmHQbzwoZ0cpCn8E7Z+9P0nishB87RAFbS8E=;
	b=nHNENiYp8pqLTa4y8bWlawbLY/Xli1aCGxzamMhTbt9kZqZtnPR9MW8TrbqORx3iykbJ
	 PWP0AUZR8omDaX55hOK58HEKkovzwsJzIuiSdo2FQjYaQ/4LwW3hU8djgVOkA1GvP0BOr
	 mWpIvtWVFMuBqInTjOBI+biCaGspuDey1WA+ur01BTfDgvcxKYonpjbP3qumTDRuKgRT+
	 xm1VjF3HQdcWyVNqEBNVwLggrS3A6mpW6Gs0oJXQNR8y3NInX1agR2vBCnyHIm63jSnpM
	 pu1hMM7PEnglCFi3J28j7tlVDsCgZC407ek0q1jUMkouRUFQ/Ci6GTVGy/vLTbDgu/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDwlMzrg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B5606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDwlMzrg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93141F00A06;
	Wed, 11 Nov 2026 20:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428130;
	bh=TX6L9YocmHQbzwoZ0cpCn8E7Z+9P0nishB87RAFbS8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDwlMzrglrifwBVtZjuFPhE6EG2AY9nj2RjmsBoG920+SSfuFy0E+cjlBSwCdw8yO
	 SrMU7Ig0sL13UcOp6iH8gyfzDB24NdnuwIIrf5hqVW4DV3/vTvjIF30BczumW6zgKs
	 s56UfWPOwZe+RX1+LLLcv7sM04KXPVKuGh0fC4JvbstS32PwcfHuyih66n7se+Sta2
	 0N3MGitxszwcjpFYU1KU7SDcHAR4EF32I1+nCxdnVh57eLCpyTnnf2Kr4mBvRI9qPI
	 f1J+ZfVRWsBPBPAktPoaoerk8W7ruocMEhEohaZdo9iBVyPGIkH3lMe1x+KhVmlo+Q
	 pN6GS3tGeaAhA==
Message-ID: <sashiko-outbox-209625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/20] perf dso: Pass dso_data to close_data_fd()
 and dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-11-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:15:30 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D10

