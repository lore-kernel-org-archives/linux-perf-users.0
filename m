Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD039281D
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713668; cv=none; b=UlBDPXUhsOGIkRAvY0edPpwmf8dnSll2ksUs6r55Jb3IxkpBX7dCq5rG4N1bVBkyRP254ZXn4BvVepDuv+69mOUVFfGNFCt1qPdl1tqVBDZzI+8snrdHIxiK5LoytJNDzGl0XJ+sP6WfiuHLY2I/oM8jHG1ND7fQTTmbbFqsmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713668; c=relaxed/simple;
	bh=aoVuDinRSGNE842jbkaYH0WJQINSh52Vcl+XuosEBaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KaAZslTdSwKDriDy/4hJgWN6ifmWe+HM7GAeyMx7KX/9fkVEnJFAywPHLvEDVQyMAE4KqInK+lKDzkAMfFOUatnfQpH2vg+O4eePzl8Ctmi3HWtxTzox33SKiSSDmfdo4nMLULoSGdC24KqlI6QOaSY+S3BDGaDvxktWBgTogKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaHrnl2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaHrnl2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913671F000FF;
	Tue, 29 Sep 2026 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790713666;
	bh=wNMbQGfTv2xbpsLXpcOB1CH+zmqU3CnKqO8zEccl45I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MaHrnl2lAVrd9SCdiFX84RRVF/x/M4Zo/jVSuQKh6ShJ0pxQfQpiseIeOTudRVXuL
	 HcQY2JlIKtTO0ccUt6ywp6X1DVf3uaTt97MqS26/SBJOD50T+d68fIG13uLQmHnfAF
	 KKQxj66ny0Qr+ZunGeCKDPZYwPivY15tozMA1DAqEOfdvNVO3kUVENkSuaVztvVKRl
	 fW9eSVgIUF1EoS22z2UBkTdFK6Wm1EJqTVDpvofX02RV/C1CkwjiAAeC00VeS80/eG
	 jBmbZoW1ITX4eOT3IXEYrWKq3UP/b+MXgUnTdtXnskiU34A/BsUECPIElbZ3K5g9Rj
	 nxsjMMKaxJ+gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929201524.2507733-2-acme@kernel.org>
References: <20260929201524.2507733-1-acme@kernel.org>
 <20260929201524.2507733-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 20:27:46 +0000
Message-Id: <20260929202746.913671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: data race in perf_config__set_variable() on static path bu=
ffer
--

commit 6edfbfca7e25b1f211f3d43320a648de89590467
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf config: Move perf_config__set_variable() to util/config.c

This commit moves perf_config__set_variable() out of the perf config builtin
so that opt-in features can persist their choice from outside it. It also
adds mutexes to serialize parsing and rewriting since config file access can
now run on more than one thread.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
[ ... ]
> +int perf_config__set_variable(const char *var, const char *value)
> +{
> +	/*
> +	 * Not on the stack: the parser publishes this buffer as
> +	 * config_file_name, which another thread may still be reading.
> +	 */
> +	static char path[PATH_MAX];
> +	char *user_config =3D mkpath(path, sizeof(path), "%s/.perfconfig", gete=
nv("HOME"));

[Severity: Medium]
Could the use of a static buffer here cause a data race if two threads
concurrently call perf_config__set_variable()?

Since mkpath() uses vsnprintf() to format the file path directly into the
shared static path array concurrently, couldn't this corrupt the resulting
file path and cause perf to read or write its configuration to an invalid
or garbage location?

> +	const char *config_filename =3D config_exclusive_filename ?: user_confi=
g;
> +		/*
> +	 * When rewriting the system wide file all entries are marked as coming
> +	 * from it and must be kept, or it would be truncated down to its
> +	 * header.
> +	 */
> +	bool system_config =3D strcmp(config_filename, perf_etc_perfconfig()) =
=3D=3D 0;
> +	struct perf_config_set *set;
> +	int ret =3D -1;
> +
> +	pthread_mutex_lock(&config_update_mutex);

[Severity: Medium]
The lock intended to serialize the read-modify-write operation is acquired
here, but the static buffer was already mutated in the mkpath() call above.
Does this leave the static path array unprotected against the concurrent
race?

> +	set =3D perf_config_set__new();
> +	if (!set)
> +		goto out_err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929201524.2507=
733-1-acme@kernel.org?part=3D1
