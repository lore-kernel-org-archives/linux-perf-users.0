Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039710;
	b=d7rrPe2xxHjCzxPLhBlJhuaMGyS5HNCKmJH4/ddIh+mk2kP/a+wTv0G/xBe10YH1VHoa
	 5kLyHcIDLKOemLGrqNIdY76TuYDToEk3po1v9Cq2DHvHKplPC9FTSy2iWxAsWKMyAO8jY
	 OxkgOje+DC9LzObn6CUF7X3eKVe8oX1oglFGy0Exvo9vw6K5wFmFyPFyGCxwFWK0sg9D2
	 WeBuifhae4fwsdU+GDvWDXe/qNQB75ifULhUrOl8GGmuwibNgogYQwWvVlY2/JBdsvaRo
	 7HY+NpPmv75AtFUXl5HJM6JzonZLFf7OcUKfL9caP1g77w6DZIFGWFF2FsjoILfwP4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z98Lqnie3czRelnQyWdP/yNYuDFpo0qfNv3OQT6rLZE=;
	b=0frRiCZ76Q0ii8WCXy2TIQWo4P8r0zbu0ExLCfTlqw4YPI26uOznNKNNO0dDWNqne8MU
	 W4gxsb1YurcWwE1SBNFEY8LyxGfk9fuVr1WezeBIdNqUe8NnpQ6PgpAceI+NiiIkeNWyc
	 tyM47tNPMFpFDMgGCDkxEKX/dPPnUlXmoj9C5akc7tNu4G+ucW2v2d3rObtyJ8ntbAkPl
	 xCJKYjdBV6kdL8VuEQXHpgUDTRZM+un6ptcTqxsrp14MT76lJbpre1ojFSHfX1EogJBKl
	 t6ZwKh+vXU2HHhnQrPf/YxzwE5BswVhWP8108u7Ih8JtLERS2IgGhlDhYUtTezqicSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1sYiPpB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334CD606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1sYiPpB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11201F000C6;
	Wed, 18 Nov 2026 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039709;
	bh=z98Lqnie3czRelnQyWdP/yNYuDFpo0qfNv3OQT6rLZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1sYiPpBdU3niavuJfmjcUN9998yZwqGWsDowz4cdrpZ8oqGSqdNhEkPVxquEg6t3
	 mVRWAO69Nhy4n5vhgV4U3VIaCIkcIYr6KkXX8BfOct702xsK3dYCmjmugtU9HooMHc
	 jxYCI/JepoFGuySYmSmL/VXsmLokTGlkU50yTL1Sw/yckbpGNozghYV4b/tOmnHeRt
	 qsJ/7yUVxLvSktBwcjVLvFfgKDQmqqfZb0YppsOskiqAGVZCrzRRlwIKEfGWmkSIDI
	 IMfUQt1uvT3RqQXo0vv1nhqVl3qqj/3xwtKyG9uUu3MSGeWlqB/B/E18TYXB598lIv
	 Fu8pRk7tgAVoQ==
Message-ID: <sashiko-outbox-222084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/13] perf tests: Exercise DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-5-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:08:29 +0000
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
> clang emits DW_AT_location with DW_OP_addrx for globals in DWARF 5, gcc
> emits DW_OP_addr.  The global_data workload keeps a zero initialized
> struct in .bss: at run time it sits past the file backed mapping, where
> the by-name fallback through the thread maps cannot find it, so only the
> DWARF address lookup resolves it.  The test checks that its three member
> accesses are annotated, so the DW_OP_addrx path is exercised when perf
> is built with clang and DWARF 5 (e.g. coverage.sh --dwarf-version 5),
> and the DW_OP_addr one with gcc.
>=20
> It skips on 32-bit PIE builds, which reach static globals relative to
> the GOT base register, and the resolver does not track that.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D4

