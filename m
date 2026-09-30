Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084251C060
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804927; cv=none; b=Q5whKtgTjW0bae0C3+Izq2glI+iOGmaEzNuj3stUFqWJOlxyk1jcXsxoofzLE9Jx3fdnAKkmtNy1rD6DRw3cgYWZiqpc0HuvnlOHAWuk9OWar15KPMWm6AE6MVHEAbkYKsVpAv+nUvUJIAQe/9EQwjouTQm4kmnKvAL89onnB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804927; c=relaxed/simple;
	bh=dx0bYT5w9aQ4KxNiOrzE2VRov8akNPy85SWpWueLtwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P8S3/oVJgCqoNjCz+bi8h7A0Rvo9bz0wmUWE17+Sc56xLHFGDBmdGT3x8Q+3OBJFf/yd2EaatGNsZKH/Gzf669njCGvmgSq+Iqq0TEklmT81XgitEx3oX56BTi+wqrjEbJ6wDaXD5cPsGp/9Kc3UFCQiu0BWChcKU+UYatWP5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgcjyEuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgcjyEuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F2F1F000FF;
	Wed, 30 Sep 2026 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804924;
	bh=dkgLeW2lusxuqS7tvaSQo4foBMjdKkPnToMbNMAVZ7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hgcjyEucvYPmUBRQVg4uV/tg4b2s0vyM2D0zytl9hC2xVTs29oN3L23u1pXT3eOQh
	 EM1xNTDy7LBXrZmHKOWTzhUkiHKGK3/NzGL4ETjGe+PO1Q6ZpKO4zMMDaGsgkYI4C5
	 ri1MvQQGYtz2rn8Q7xykX6HudkfeU3KhR4ncUJWzZuCouPMM9Ye+1U10dYQutk3kTZ
	 agXzDempncrWTc4nh7i+7uhEXrbmrnnnV5vjIQJvAGFTr5FlCHBONTBoqnexkSm/YJ
	 49Ug8VfhSC4xN0aHWZV6EkxI52D8ler+Vwr061x7yDiyxKaMRIcFn+Woy0AOhI5Pb2
	 I8JP7f6/Ug5mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930213716.2633750-2-acme@kernel.org>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:48:44 +0000
Message-Id: <20260930214844.C2F2F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Move perf_config__set_variable() out of the 'perf config' builtin so
> that opt-in features can persist their choice from outside it, e.g.
> util/debuginfo.c writing core.debuginfod=3Dfalse when the user disables
> debuginfod for the rest of the session.  The
> set_config() body becomes perf_config_set__write(), with the
> system_config choice as an argument, as the builtin's
> use_system_config/use_user_config statics are not available outside it.
>=20
> All config file access shares the static parser state and can now run
> on more than one thread, with a feature writing the config while perf
> top's display thread reads it, so serialize parsing and
> rewriting with a mutex, and the whole read-modify-write of
> perf_config__set_variable() against itself.
> [ ... ]
> accessor anyway, so make it total: the unresolved path is the same
> string for the usual absolute ETC_PERFCONFIG.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213716.2633=
750-1-acme@kernel.org?part=3D1

