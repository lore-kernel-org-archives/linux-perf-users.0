Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946E154425
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703963; cv=none; b=aCeF9i8FvFyOelZiaC8PAQ+gqyC2cE7T03iD8/rff1q8tzRkwBv2oJZmL8GDumd7nl1m4ACYIb10vCVdefAHCWKoTATQyFuHL9eub2ZtZhy2i/9C1vcGSF+AeGwSeN8tQ6iGsr8h+d7Wp5ozxaPSzMCfBeZ3uVsPqnxEn3b7fek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703963; c=relaxed/simple;
	bh=sj8cxff9hswxZzABu6NB4aXciIPa9Xqw7vmgWsSfTKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IIptygsmOg+d1sEed2k8LPcjXAzd3VD/Hsd+K1FpNNCS0lvwDmCuBSwUP0pOLz4B3ziehqA4qiNpVaZVG8GeuosQwU3UiKc1lQuk4YTvbHTaaavQUTEHZeokOYuxyHxp93H80xwYBh76FEv2a6US7tTyZt3Y+uUaxn87pD2llfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/enL0cF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/enL0cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06A01F00A3A;
	Sun,  6 Sep 2026 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788703961;
	bh=sj8cxff9hswxZzABu6NB4aXciIPa9Xqw7vmgWsSfTKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/enL0cF8s0XUjO6KCcD/CyCHMxuWD/ngTKXlCxhy/EAz+yrVKWYcQQd6GEY8iJ8a
	 XgSW4d5AFPI4qB1D3QINhSS6ZWNPz0yK6/b5HjosV//4mOXECqnnhFGcL3jIpI/GD+
	 mbL28+VNaSl6BhpbxcLttudL1/IbJWIx6Utizp44DIooXn/1uvyl4LlNQtmRdlZouw
	 p1SnZ8ij/r8P7rHXjQbnUTmewxKoQ+LVsR85GOz6LimuCPc4SYoDk7xhLRSDGE4n1+
	 9crOxRPWj2C0vZjis6xL0RvBC7d8vXS8UkI9rqc6PdLr71zbpA57uT5SRfbCGKgmYE
	 QweB8jhajuSrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf tools: make the GTK4 report browser actually
 loadable at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v1-2-7564bf8523a9@gmail.com>
References: <20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com>
 <20260906-perf-gtk2-v1-2-7564bf8523a9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 14:12:41 +0000
Message-Id: <20260906141241.C06A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf report --gtk dlopen()s libperf-gtk.so and expects it to resolve
> symbols back against the running perf binary (callchain_param,
> symbol_conf, evsel__name, and friends all live in perf itself, not in
> the plugin). Two things stood in the way of that after the GTK 2 to
> GTK 4 port:
>=20
> perf never passed -rdynamic, so none of its own symbols were in its
> dynamic symbol table for a dlopen()ed plugin to find at all. Add
> -rdynamic to LDFLAGS when GTK4 support is enabled.
>=20
> annotated_source__hist_entry() was a static inline in annotate.h, so
> ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
> hashmap_find(), directly into libperf-gtk.so as an undefined symbol.
> The only hashmap_find perf links against in the common case is
> libbpf's internal one (tools/lib/bpf/hashmap.c), which libbpf
> compiles with -fvisibility=3Dhidden; a hidden symbol can never be
> exported to a dlopen()ed plugin no matter what LDFLAGS perf itself
> gets. Move annotated_source__hist_entry() out of the header and into
> annotate.c, as an ordinary exported function, so the plugin depends
> on it the same way it already depends on evsel__group_desc() and
> friends, instead of reaching for hashmap_find directly.
>=20
> With both fixes, a default 'make GTK4=3D1' build (libbpf statically
> linked, as usual) can dlopen() libperf-gtk.so and open the report
> browser without needing NO_LIBBPF=3D1 or manual LDFLAGS. Verified with
> perf report --gtk against a real perf.data on an actual GTK4 desktop
> session.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v1-0-7564bf8523a9@gmail.com?part=3D2

