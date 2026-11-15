Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703140;
	b=3sOiMgeFt7mm1JZmG8ZcAj0c2xoCCuMz2gB3hVn3d8/t2Gn+8bWYnXjv/7ioyy0I/+5T
	 tSrZwqrqZtqOnZAROJK5A6qhsPJNyGo+8jnuzVlhiPVqYdvobTmSFBPAKpQXQ0O2Q0Nl/
	 Ox6K/QXi/Fddps2xZz1XRIcMjcAib8D+W3eAu450JABTkpYmoke1xcfCg9asNg3eesgiE
	 gAkowFNifK8WoR+8DHPn+oXKd/tNzE5hfmBtdiQs4he+LpRmaH7OhpBSRiDbLAn+QOvpu
	 pV4NExPbzCG1VnSvwXPBHTZZ8Yy/kpXRSv+JSIxcCKYe0swjm0QQJFfnlbPxuiN0fWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703140;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eBmyEKM0Wrx3sxrlLws63NDpS25wuDbCDTl2Lm4kK0M=;
	b=Eo6FMdM1fF5aFfOPkls4Hq1KgXi2kBmZYonjzeGLaHH9GhYn468/bnSHor0DgTr/3BPz
	 j9GHoblkN59zUAzYhbRXAng4u6qdmX12WDsBOh39fQRzcMe7OsVgo1qBz+M/zRX377+zo
	 /q1VDpuQXruUzBkVxCukpTCbXbVNue57xOkBWzhlUErSOV56w/Osnd44O+xvdkIzG8lpV
	 XPgt0yhk/fZApKKXclKmwUxLidjFRN778RmQEtFbKbPlDSdg24mOKCyc1B7zMdnf6yKV2
	 zDkol2VsR7g1AMcOOlPKN7gCcCFq2d3VpatL1yWjPe7HX2LFECPSpsRXeDEMDP5Yg3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fn+NhhDE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E2606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fn+NhhDE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4744C1F000C4;
	Sun, 15 Nov 2026 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703140;
	bh=eBmyEKM0Wrx3sxrlLws63NDpS25wuDbCDTl2Lm4kK0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fn+NhhDEgYvNbVq3b/Ldyl0xlUWQ6+a4nznxSkrIlyn9VpbEQjDzE/wkoFFgG4/E/
	 Qub31VikDNhlm1EqxjDmlUTila91jnReiCYMcyy8sTFtmISq35UkCp37vo9DiAq/DK
	 9yG9AVRCnumIdU9YwoOu6Sqn2Kgumt1xqRIFNl1UMmoiDSkohHMg2uu1rlLbMMlB7P
	 wnF906kt2oGyHP6eGMrNnJuGFGdSPoxyUotz8QXfKjivH2C1oPslerzChbf32N3LHh
	 KwAkfJARZtLEUOoWRpKpsvSYSmY3FzlDWTr26MGkeVBNgmvXXJzyyueHnNSSdrZmcb
	 v5+Y5rXZl4xxw==
Message-ID: <sashiko-outbox-215154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf tools: Stop using the deprecated argparse.FileType
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115003507.1872482-1-lalitmaganti@gmail.com>
References: <20261115003507.1872482-1-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:38:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Python 3.14 deprecates argparse.FileType, and pylint 4 warns about each
> use of it. The perf build runs pylint and treats its warnings as errors,
> so the default build fails:
>=20
>   pmu-events/jevents.py:1494:26: W4904: Using deprecated class FileType o=
f module argparse (deprecated-class)
>   pmu-events/jevents.py:1496:33: W4904: Using deprecated class FileType o=
f module argparse (deprecated-class)
>   tests/shell/lib/perf_json_output_lint.py:23:31: W4904: Using deprecated=
 class FileType of module argparse (deprecated-class)
>=20
> Take plain file names and open the files after parsing, as the
> deprecation warning suggests. The output of jevents.py is unchanged.
>=20
> Fixes: 5fe83fb352c8 ("perf build: Make pylint build test opt-out (NO_PYLI=
NT=3D1)")
> Link: https://lore.kernel.org/linux-perf-users/20261018070110.927636-1-la=
litmaganti@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115003507.1872=
482-1-lalitmaganti@gmail.com?part=3D1

