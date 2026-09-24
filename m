Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA64AD4CF
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269843; cv=none; b=QB5swPttKtmMkkKJEUvBEY0Boayfh7JPsUNiO+wuJARe5iEamL1mcB0puhNVpmgHfdGabAxp20CrJ2+xk03ssphuvm4UkYP+RcUxNTqud577AKGAhz2ukwovNddG3naazNMLwn/jzCyv152kumb5zaSgGj/rhSvdPEt9b157cNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269843; c=relaxed/simple;
	bh=JV32EJjuLe7PDqGwcI8gWVnRXi5g9ETY5kOFiOLHHsc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uNKXWMPmoPpFErO6Mz0WhoEAnNwYSlCt2ssZ/w7lgBBEabp2JbGjGI036MEIdB2ZTnego5hwWgAJes90Ui6cpLLMKgUTxFQXBSl1OPmzVT6MJ6tMOhCE++3Y+V7ptZVPYvZ3z48bSAavyJfybT6XwtahjErFfhRwQbCLDoem2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbwZaL+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbwZaL+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A741F00898;
	Thu, 24 Sep 2026 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269841;
	bh=sGyFJevvvvb7CIyZvB4w1SwyZTpF1igzUoTsJfx2bj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbwZaL+MP8eMm5A4tMU+AIGuA2hP+evYLMINRJIKHTxdGhlNA4dkrsRUc76yZx6i0
	 GZ4LX9UxTb4lhePi9zcz+/y52lLheqT0tZyRUvq2TP4D3bXAvtggdMqDJnUaaeESiF
	 Si9PbO4yBQqzSMCuUBH39gunVzYK6RNbQ/OG46RX30fQiEUhBvoJ/qC/cSch6jYZVi
	 VWy/lpv89cz17dc7nYKTotf1NJVHUSWD+KQWIR6uQCLecbIyLjsCuG+g/L2inyLEAp
	 +JLT4ZIE5tyXnFpji6AP6D1UgNQtbxvTTdQvnQaTQ5GFU5hTB8bz8Db8Lbf7aVZOnO
	 1RV4faLjidRbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/26] perf vendor events intel: Update
 sapphirerapids events from 1.39 to 1.40
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-20-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:10:41 +0000
Message-Id: <20260924171041.61A741F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/2ba60f607169b97dcfa0d28f7e3a613=
28627cf0c
>=20
> Fix umask encodings when there is a UMaskExt.
>=20
> Fixes: 54f5de6f2998 ("perf vendor events intel: Update sapphirerapids to =
v1.12")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D19

