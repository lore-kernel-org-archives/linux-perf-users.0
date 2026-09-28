Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB64EF140
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613484; cv=none; b=Ky5AkG+hFBQoDFeK/PxA6fSEfcP9RqYFe0eQom9CQaEfCnSUUL0ULCribueu+Ksjc23WZvMNoSVEW/xCMqLiGz7y286jeIE4j/HpMb28MoxoaEsiKbScoNIQICVypUcAB40tnr9DYPFRmK1gJiOVN+m73C+SVB7dAk6v6eo0xbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613484; c=relaxed/simple;
	bh=OV4XXMfT52jfoSxCVBKZX20Eb3VzIeN7nA+t1OOEJkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qlvgg8e4E/LkslrXhC0XZ4MsBK86OwNYL1AMfH3/yOvYNhrDUIO0sf5/h2xq5ayuTXleBqpIQAwoR+e4XViTi+4sHJQELd39rT4VhEsSlC/wH7yGLg/JK+2jYQ1h3bxFOf1OSmWd7kOFA/Irv3NCFakettZC7N9RGB7EBO7IBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FARuaQY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FARuaQY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A656F1F000FF;
	Mon, 28 Sep 2026 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613482;
	bh=4IvG0sDgAG0OtxMXQ8uxq+d81vjtg1TA/IaRUXyOipc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FARuaQY2BnWSm/Agv80GL8y0PjXA6vMlf3789iiSrJYy83YPrco0oWd/PcxlAwzgM
	 27bqTE5f3qObTVL0CBkiIpotcTzYCgUMF9g8hZolmBYz3nuLaRBXvOhuFwJinQEBsG
	 waCCQxbg8R++YOQ1fJRO645i7hvBsd7vmvolbSfwSU1S7KtGy2wOuc+l3WpNT2qarC
	 um4icL2wlf2822K4+ws1fbmHz9pnNMtel0Lh/ZWzI8lMW8sKMUxnmMGdpR46tdAK65
	 LTWbb9vo9Ij3qicl4/Qh622elw8uWSfvPvhnT1BrEdSfl++f4fRRMbGJPDbJ0HFs1t
	 PWyrx1mLR3I/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928162250.2413383-2-acme@kernel.org>
References: <20260928162250.2413383-1-acme@kernel.org>
 <20260928162250.2413383-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:38:02 +0000
Message-Id: <20260928163802.A656F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: NULL pointer dereference in perf_config__set_variable()
--

commit 0d5767702c97c90061c56a5a96f7d7f30aec5f53
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf config: Move perf_config__set_variable() to util/config.c
   =20
This commit moves perf_config__set_variable() out of the perf config builtin
to util/config.c so that opt-in features can persist their choices from
outside it. It also introduces mutexes to serialize configuration parsing
and rewriting.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 8fe43b032e9af..43994786eb964 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c

[ ... ]

> +int perf_config__set_variable(const char *var, const char *value)
> +{
> +	char path[PATH_MAX];
> +	char *user_config =3D mkpath(path, sizeof(path), "%s/.perfconfig", gete=
nv("HOME"));
> +	const char *config_filename =3D config_exclusive_filename ?: user_confi=
g;
> +		/*
> +	 * When rewriting the system wide file all entries are marked as coming
> +	 * from it and must be kept, or it would be truncated down to its
> +	 * header.
> +	 */
> +	bool system_config =3D strcmp(config_filename, perf_etc_perfconfig()) =
=3D=3D 0;

[Severity: Medium]
When the system is under memory pressure, strdup() inside system_path() can
fail and return NULL for absolute paths like ETC_PERFCONFIG. In this case,
perf_etc_perfconfig() caches and returns this NULL value.

Since strcmp() is called directly with the return value of
perf_etc_perfconfig() as its second argument in perf_config__set_variable(),
could this unconditionally dereference a NULL pointer and cause a crash
under memory exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928162250.2413=
383-1-acme@kernel.org?part=3D1
