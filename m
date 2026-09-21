Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524041B808
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951268; cv=none; b=NM97Q2OzEWUOA6Xkx0riLZ73YW4aUBJ2uKgQEgM0Ii9JNsxxSMiRfkv9/ZeMjHFSV14DO88QkTdALPmupCij7H9iZNTbfdMDBQDyCkh6McdcsJcqZT/9bBgy2zgAvEvULocOJlp+h2fl2pX+QOe1KIPtFCTSAXWabYRw1YTgQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951268; c=relaxed/simple;
	bh=pgxNYYmdBzGWJibl614dAuddbSSEH6qA7H5j4ewuivI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EE617VvP/Pr4dFUvPgKaOdWsds4Bu+sVeOB96rsIJlC3qyamFklzSuBMQBl6bi2l1eb/Tk2mrQVwQUWH3i1/okBDalS+xJ555DYQ8Ow0N+VuqmvClU2HmmIMoa1d5LSKq1/HZ8ymJEBhIlIkURzGslCKtA4f+Gd5NdFAenPio08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDQtd6Fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDQtd6Fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D194A1F000FF;
	Mon, 21 Sep 2026 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789951265;
	bh=pgxNYYmdBzGWJibl614dAuddbSSEH6qA7H5j4ewuivI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DDQtd6Fx/rDg2rTKZ5+neivzrzfA1/7oi27nCwwSneXsryBwNtZOpAx5DRIZTv6qh
	 rcvmPIy8D7sxaOZiPS3QUVlleQwV+9QAQS0IGNxsX61cNjsCR+GF8YBTOdTpC1MFQm
	 Ynl6yoeg7jAaQCC3EtebrFetsn+zzBn5KL6M7v8VWjiFZ0OCtZkwDJz/cURoABG+e6
	 NnkeGjqUgdek0UgcQowXqobxRzGxdf2IKbXTtP0YIk3ylXtanEs58/tAttoxcO6104
	 mOUVUNGuWIec6ZgbPKWB+5NwAUCnyOJtmuq20x7pCYo1gRmGdqHcHFnDyeopozooGc
	 GeT88S7UGvrXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: fix user->locked_vm leak on secondary
 mmap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921003306.426050-1-benquike@gmail.com>
References: <20260919221728.3707189-1-benquike@gmail.com>
 <20260921003306.426050-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 00:41:04 +0000
Message-Id: <20260921004104.D194A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()") hoisted
> `user_extra =3D nr_pages` ahead of the existing-buffer checks (`if
> (event->rb)` and `if (rb_has_aux(rb))`), and subsequently
> commit 5d299897f1e3 ("perf: Split out the RB allocation") and
> commit 2aee37682391 ("perf: Split out the AUX buffer allocation")
> carried `long extra =3D 0, user_extra =3D nr_pages` into perf_mmap_rb() a=
nd
> perf_mmap_aux().
>=20
> As a result, when an already-allocated ring buffer (`event->rb`) or AUX
> buffer (`rb_has_aux(rb)`) is mapped again via mmap(), perf_mmap_account()
> is called with `user_extra =3D nr_pages` instead of `0`, charging `nr_pag=
es`
> to `current_user()->locked_vm` on every additional mapping. However,
> perf_mmap_unaccount() and perf_mmap_close() only subtract the ring buffer=
's
> and AUX buffer's pages once when the final `rb->mmap_count` /
> `rb->aux_mmap_count` reference drops to zero. Consequently, every seconda=
ry
> [ ... ]
>=20
> Fixes: 0c8a4e4139ad ("perf/core: Further simplify perf_mmap()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921003306.4260=
50-1-benquike@gmail.com?part=3D1

