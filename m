Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536070;
	b=bNhNgUNY+EyUvWVITCipCuJ0vsRNLqIf7dfk2GfKMCt0PepjW++6R/eCV8UpUHY/BeV6
	 qcAblQIRn+dQ2XBGIFhnSgXXCoz60xpDB41h2OSWq2hBcfPwejue1feiSc6FhkTBX3wYF
	 L829Zb26NXLlzN6NPzA2fe9bd3hDn41RJvr3q9twN9OYAxmzdTSUK10UCObUBy+BnzVP/
	 Zampbp7j/DtSACET222ympfXYTAFymNSTvYL2x79rxooFNfapSdBp5L8uxmxRgN75cxq0
	 /quvYyKdYPvMBnSsxLVD3AUweqKUnIykxr2Gch7U7CT5tURZ8aK1KKxUh3fJB5DsGeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KOMppN4FNLT/Fo5wD1HuSU3y7idzP8JItU8EvCnTn0o=;
	b=xSpMBxSKQT9gXA0d1wHRr3tgXgTChldrhOwFC6gCsFroD2DsbH1e+o5LmWiy+Y/TQN5m
	 i64S3EvZRO2iWlsum6WCznzP9aSjEUY/t3rKii2QM9TWPMoW4ajZWurQvJsUEKY9Vz1Zr
	 h6i4Kr1QuuNAnGG/GdKwwQ4TS7UCjjyKioPWIVpYVCaP9WwmcuALwns/Uyzn3KOgsIdkI
	 0F9pv+SZBI+YmAYEE+XpyOJOzS6JmaATlZRpzgDGUGRb0333uai9Vnu1n2celnsPaqJxk
	 vCDM+7/iWKP9mrpud/zGOySE/rNGuMgfs+2QMZRS3oNALdV+BshgtaP6jKU+t+7y5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpMygWmg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467E606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpMygWmg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CB51F000C9;
	Tue, 20 Oct 2026 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792536069;
	bh=KOMppN4FNLT/Fo5wD1HuSU3y7idzP8JItU8EvCnTn0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jpMygWmgIIivIvI2aZOUcM6IHQco/D/fiOq9Giwb2rRTvE1Sk671iX1pKco4r6bXg
	 uwXOTL0Bx1gjLAB+JwBZW2FyoLmTZSeIstO05U+bnSoD5f6Gmy30tWakvXMQX5uSxL
	 o3O/+nMwEhOCeX4BMd8vihpg/DrgX6Jh6ahV3tdxxq00DlyAxlHYa2jx3vwRgsC12F
	 Rvfzm+XOKr3zb3jWwPyhJbZ73rjIzLIpFX0K1bXcG7aMnWvF2Uc6ywewUnWmxgvqIo
	 Ll5xa7FtX96fXSuOfbYBSL9PmxbHQGahST94mlLcBHu2KS7NvDedT/nQPaxhPkHNC2
	 B4WIubltPDkZw==
Message-ID: <sashiko-outbox-179569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] perf bpf-filter: Fix bpf_link leak by using
 PERF_EVENT_IOC_SET_BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-3-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:41:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In perf_bpf_filter__prepare(), the unpinned filter path attaches
> skel->progs.perf_sample_filter to each FD(evsel, x, y) using
> bpf_program__attach_perf_event_opts() and ignores the returned
> struct bpf_link *, leaking the allocated struct bpf_link_perf and its
> BPF_PERF_EVENT link fd.
>=20
> Furthermore, bpf_program__attach_perf_event_opts() is designed for
> callers that transfer ownership of the perf_event fd to the returned
> bpf_link: when bpf_link__destroy() is called, bpf_link_perf_detach()
> unconditionally disables and closes perf_link->perf_event_fd. Because
> evsel->core.fd owns FD(evsel, x, y) and closes them in evlist__close(),
> destroying the returned bpf_link would double-close the perf_event file
> descriptors.
>=20
> Fix this by attaching the program directly with
> [ ... ]
>=20
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20261020053226.55936-1-n=
amhyung@kernel.org/
> Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D2

