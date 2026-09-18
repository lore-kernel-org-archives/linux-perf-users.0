Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78E4FC343
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743115; cv=none; b=N7K/Eb0/4Uo4o6TDLED8CYyKFJCaf0m782ge8gpV5Q8aW3LnOOsHfyEs6Ou+dUtKL/ZcLYA65YprWD1uKmbhPUBEMcABy6qvFCGyqXhED+piUsOCMauwBLe5veo64k/oBwRMIC02BFHrjS5iwgVyI6S/3PmKifRqlNrwXIlvwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743115; c=relaxed/simple;
	bh=xsdl9Q0VHiCVZ2VNzjwpxWC5gf46Qitq129g0Lv7BE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m6iCKsboM+I2R+Ol9BZEvvDZ+NAJPOIdKoej8YYn+LlgaHfELiLsE2TQKC5VJNDiio7dpsO1XD/giWpFVY+YC7h8OIDsdGAG8UWQLyUzMWKpOZRngoWHgAtiqbbfT+Bdr0ErY/zjejltT/kZM5R7QXNIf11rboo95Qx/Dc4J1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFjsiLoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFjsiLoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7351F000FF;
	Fri, 18 Sep 2026 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743102;
	bh=xsdl9Q0VHiCVZ2VNzjwpxWC5gf46Qitq129g0Lv7BE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFjsiLoagnacfRBz1OB45baKZUBpGPsPgQAaiNW8wm12Qa62LTvKHOPq6ttZ0AEUK
	 lBvxlcl5ZO0j/HY5G0Q0NWd9Xzewlw/maEfCpSizVOxR4vLqiONg5ovgHjSXwVIWWa
	 e1aWC12JDP3A/cAeVhJqXzIxMgDCkR1el/toRNNHXYfMtsOSKsg8vkdgENp11Yfind
	 6vnKIhhp/QJ+lcVxEWTFYgQIgo8sfRYdnkeixmact865RBNTiU7krm0BK05Oy+nqD+
	 lkABtEBtQ8jwLQ+RPO6YvPosonmevy9xtyGt5qpU9X7aw6tnXEtgz3sn7H32KzjG9B
	 frS0S0UHYRkJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/16] perf test trace_btf_general: Drop
 --max-events=1 and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-15-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:51:41 +0000
Message-Id: <20260918145141.ED7351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_btf_general.sh used `--max-events=3D1` with `perf trace` on
> commands such as `mv`, `echo`, and `sleep`. When background activity
> occurs or tests run in parallel, `perf trace` can capture an event
> from an unrelated process and exit prematurely before recording the
> target command's syscalls.
>=20
> Drop `--max-events=3D1` and let tracing run until the command completes,
> checking for the expected output with grep (matching trace_btf_enum.sh).
> Remove the (exclusive) tag so the test runs in parallel.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D14

