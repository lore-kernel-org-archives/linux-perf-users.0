Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF999388868
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094494; cv=none; b=M3gTB3tlSD48WrSyHcDa9zbGAfF6jCVcQj8QphyvcOqXnOicGhvRHn+5hUMCRQ/COAKvb43JS3+lgNE0vJ2AwMd+HXfF3wG7bNYwA9i6lTptAaFCiJ/XedEs3fr0EU+Kk4QEnZCP84FPe5zsmQgDjhprAZz3KrgNoviG7IufhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094494; c=relaxed/simple;
	bh=S2R5i9BfcZSgMdd0hw3v0rl2jvzpfAzQYckq9jGXwjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eV8ymClp5GGNyAQE0XUIq88IP0ULp23EVc8nJRaO+vsHVI/CLQTOkvRIZ22qDco0vV/n0EgNvBnIAaB+O8ZXiywFsx2egS1D4yj2hxnwMP2ZvM8F/T8pOfwc1jsS491DR2jATfsBVnY88eNc79P5l/xqoGzjZ/DgWMgtj0jeNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqzlLtdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqzlLtdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6865B1F000FF;
	Sun,  4 Oct 2026 06:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094492;
	bh=bTvB9shqldXu6Jc3uJBRziwKW3ce4fe+unmTcpyt4mE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iqzlLtdgVRliVsOEe8kD2fnqxUQ7GlrYYFyS4rW35+ufn79bRxF1LA1rpuDZXA6P6
	 GgMkxrh2qTFx76qMDsM8shDjKUHPYG2MeZEF9ss3EawSLw9JTBdX1p3Z09TCODBVfO
	 9GjrObi6LJ6PNmhuHLcdjmg67a5iP1xym4WKiMbrzgFrSSM9coI2LSBWyJ5AwJEPMH
	 /gXCo5LhQ+u7obj/MPAN/otQuDe88rkl8HSn2J16LFp2NLZM9x3KCukcnZul0mLgcG
	 t3KzOcoygBty52MIrSIl6qxplBaNBLV5XV/w7nxoPiN53sYQL30dgA+S5rwgjwRjZr
	 uy/TplkPDS3XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/9] perf config: Serialize config file access with a
 mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-6-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:14:51 +0000
Message-Id: <20261004061452.6865B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Config file access shares the static parser state and, since
> perf_config__set_variable() became an entry point for background
> features, can run on more than one thread: a feature writing the
> config while perf top's display thread reads it.  Serialize parsing
> and rewriting with config_mutex and the whole read-modify-write of
> perf_config__set_variable() with config_update_mutex; config_set_mutex
> comes before it, as building the set parses the config files.
>=20
> perf has its own mutex type, util/mutex.h; the file scope mutexes
> here use the DEFINE_MUTEX() static initializer added in the previous
> patch.  The two lazy inits that system_path() and home_perfconfig()
> do would leak all but one of the strings racing on two threads, so
> they move to DO_ONCE(), added in the previous patch as well.
> bad_config() runs on the dispatching thread, outside config_mutex, so
> it stops reading config_file_name, which the parsing thread owns.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D5

