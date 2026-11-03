Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672829;
	b=uxu/bln7CVmxQ3U15d0d0QZDLYgNKZTqyb1BxJtzIjAVhnqYJbh4/7UYsDEDIM3xHWns
	 NjyhBONUIzFTRvoK5fGfmWDlNiQkems0R4XaidGH1SA/iyHarUCjJp8AeLzF7DBgpgb+0
	 umpLXMgpZqI8rc2Faj9qLbKmmGLgUB7ygMql6gHG2x9XgEY+fZY6Q66tRZmwI/HJHxK2z
	 JjocM+TvnLCLgltxWO8nMuGXQ4GwSf4eJxaY+LDrb/rs9zOFgLtXIbVYyetgJSoarG2x2
	 L/kbpcc2ySfpw/R5kT2msu99la/92FUGH68aglaA0/TL321myCzFnDlj2rH9/tTR+qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gamsnOws/hbtp44dfQH7scc87M0M1VobIbKlZZrgYjU=;
	b=2By0mQBe9lzpGxZ9Unx2mCs8pP96pLJd1a8eUZaTHVEMPGJESP7SWFuWtxLTEAqATqQl
	 SPjgWaWf1pE2N0NXI1v3nkyewfo9MGpTHYGo44scSR42H/xt+9SJf5NhpZGXqINLyOIJE
	 IMsLpQcGZl1f6AwV56b70yjnp4Pg0RtmlvplUqDNTiY56kbYmNvrTRh6lVDTE9GEO7p/D
	 DOlfsATQ858qPEB0anvJIwy5Kai75m+bSXtpN3u0dbKgkw9m6HR6dYlLhHO8rRzf4jB2o
	 gYV13sxzTcLboH/NomjrVK7ZmXK3KJf3jmbQvDSkiTCkN534GQE+Tk/OA+ovrfLceBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsncoCc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E9606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsncoCc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E471F00919;
	Tue,  3 Nov 2026 02:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672829;
	bh=gamsnOws/hbtp44dfQH7scc87M0M1VobIbKlZZrgYjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VsncoCc30m7v+uncmgs8A59zsGxQLimTc+T/MWIQcj1lyogBUY5cuP/GCYZkSLyz6
	 zMry/SOB8snxEC3jILU+66mleha6Sft5ZKlMWVVlcfubxxfc3ThAUAV1w0cpKroiuU
	 3+qJERCEn+4aNEJ/EuFn/g+Nq46m9zBy5pz3ikKeyWkEtOk/TfpqIqwTF4DpYQ2DDs
	 rvzHH1DLDjT6VK77QYefDorWfFWMhXA/VNPZjwVwdOieRFk0PvTnIkyjUCedQsnTPS
	 AmqfOGANEWO/9hGW6IczYA95PWoXE9z5r8eXHv8nTqrQF8MZwn3mtiMN2beNq9HghD
	 9lSF1OCpemtxQ==
Message-ID: <sashiko-outbox-194460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf python: Add alpha-profileme.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-perf-alpha-profileme-v3-2-4bf6e1dda733@gmail.com>
References: <20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com>
 <20261102-perf-alpha-profileme-v3-2-4bf6e1dda733@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:27:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf report shows where Alpha ProfileMe samples land but cannot
> aggregate the raw status attached to them.
>=20
> Add a standalone script, using the perf Python module, that summarizes
> it by symbol or, with --pc, by instruction, in the style of DCPI: the
> fraction of samples killed on a wrong path, not retired, mispredicted,
> taken or stalled, the mean PCTR1 window count, and trap counts by type.
> Mispredict and trap types are only counted when I_STAT[TRP] is set,
> since they are stale otherwise. Redirect traps are counted by their
> PALcode entry offset in PMPC.
>=20
> Raw data is only read from cpu PMU events, as a tracepoint's payload can
> pass for ProfileMe status. Rows are kept apart by PCTR_CTL[SL1], as a
> mean over two things PCTR1 can count means nothing.
>=20
> On an EV7, sampling a loop whose branch tests random data reports that
> branch mispredicted in 21% of its samples, and 0% with sorted data.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-perf-alpha=
-profileme-v3-0-4bf6e1dda733@gmail.com?part=3D2

